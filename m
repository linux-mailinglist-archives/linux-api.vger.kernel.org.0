Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B600D4B94
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 02:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJLA7d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 20:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJLA7X (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 20:59:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99556206CD;
        Sat, 12 Oct 2019 00:59:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iJ5ke-0004DT-Nz; Fri, 11 Oct 2019 20:59:20 -0400
Message-Id: <20191012005920.630331484@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 11 Oct 2019 20:57:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/7 v2] tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict tracefs when the
 kernel is locked down")
References: <20191012005747.210722465@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Running the latest kernel through my "make instances" stress tests, I
triggered the following bug (with KASAN and kmemleak enabled):

mkdir invoked oom-killer:
gfp_mask=0x40cd0(GFP_KERNEL|__GFP_COMP|__GFP_RECLAIMABLE), order=0,
oom_score_adj=0
CPU: 1 PID: 2229 Comm: mkdir Not tainted 5.4.0-rc2-test #325
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
Call Trace:
 dump_stack+0x64/0x8c
 dump_header+0x43/0x3b7
 ? trace_hardirqs_on+0x48/0x4a
 oom_kill_process+0x68/0x2d5
 out_of_memory+0x2aa/0x2d0
 __alloc_pages_nodemask+0x96d/0xb67
 __alloc_pages_node+0x19/0x1e
 alloc_slab_page+0x17/0x45
 new_slab+0xd0/0x234
 ___slab_alloc.constprop.86+0x18f/0x336
 ? alloc_inode+0x2c/0x74
 ? irq_trace+0x12/0x1e
 ? tracer_hardirqs_off+0x1d/0xd7
 ? __slab_alloc.constprop.85+0x21/0x53
 __slab_alloc.constprop.85+0x31/0x53
 ? __slab_alloc.constprop.85+0x31/0x53
 ? alloc_inode+0x2c/0x74
 kmem_cache_alloc+0x50/0x179
 ? alloc_inode+0x2c/0x74
 alloc_inode+0x2c/0x74
 new_inode_pseudo+0xf/0x48
 new_inode+0x15/0x25
 tracefs_get_inode+0x23/0x7c
 ? lookup_one_len+0x54/0x6c
 tracefs_create_file+0x53/0x11d
 trace_create_file+0x15/0x33
 event_create_dir+0x2a3/0x34b
 __trace_add_new_event+0x1c/0x26
 event_trace_add_tracer+0x56/0x86
 trace_array_create+0x13e/0x1e1
 instance_mkdir+0x8/0x17
 tracefs_syscall_mkdir+0x39/0x50
 ? get_dname+0x31/0x31
 vfs_mkdir+0x78/0xa3
 do_mkdirat+0x71/0xb0
 sys_mkdir+0x19/0x1b
 do_fast_syscall_32+0xb0/0xed

I bisected this down to the addition of the proxy_ops into tracefs for
lockdown. It appears that the allocation of the proxy_ops and then freeing
it in the destroy_inode callback, is causing havoc with the memory system.
Reading the documentation about destroy_inode and talking with Linus about
this, this is buggy and wrong.

Instead of allocating the proxy_ops (and then having to free it) the checks
should be done by the open functions themselves, and not hack into the
tracefs directory. First revert the tracefs updates for locked_down and then
later we can add the locked_down checks in the kernel/trace files.

Link: http://lkml.kernel.org/r/20191011135458.7399da44@gandalf.local.home

Fixes: ccbd54ff54e8 ("tracefs: Restrict tracefs when the kernel is locked down")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 9fc14e38927f..eeeae0475da9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -20,7 +20,6 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
-#include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -28,25 +27,6 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
-static int default_open_file(struct inode *inode, struct file *filp)
-{
-	struct dentry *dentry = filp->f_path.dentry;
-	struct file_operations *real_fops;
-	int ret;
-
-	if (!dentry)
-		return -EINVAL;
-
-	ret = security_locked_down(LOCKDOWN_TRACEFS);
-	if (ret)
-		return ret;
-
-	real_fops = dentry->d_fsdata;
-	if (!real_fops->open)
-		return 0;
-	return real_fops->open(inode, filp);
-}
-
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -241,12 +221,6 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
-static void tracefs_destroy_inode(struct inode *inode)
-{
-	if (S_ISREG(inode->i_mode))
-		kfree(inode->i_fop);
-}
-
 static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 {
 	int err;
@@ -283,7 +257,6 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
 	.remount_fs	= tracefs_remount,
-	.destroy_inode  = tracefs_destroy_inode,
 	.show_options	= tracefs_show_options,
 };
 
@@ -414,7 +387,6 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
 {
-	struct file_operations *proxy_fops;
 	struct dentry *dentry;
 	struct inode *inode;
 
@@ -430,20 +402,8 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
-	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
-	if (unlikely(!proxy_fops)) {
-		iput(inode);
-		return failed_creating(dentry);
-	}
-
-	if (!fops)
-		fops = &tracefs_file_operations;
-
-	dentry->d_fsdata = (void *)fops;
-	memcpy(proxy_fops, fops, sizeof(*proxy_fops));
-	proxy_fops->open = default_open_file;
 	inode->i_mode = mode;
-	inode->i_fop = proxy_fops;
+	inode->i_fop = fops ? fops : &tracefs_file_operations;
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
-- 
2.23.0


