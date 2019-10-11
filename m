Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651C1D46FC
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 19:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfJKRzC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 13:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbfJKRzC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 13:55:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F2ED206A1;
        Fri, 11 Oct 2019 17:55:00 +0000 (UTC)
Date:   Fri, 11 Oct 2019 13:54:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
Message-ID: <20191011135458.7399da44@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/S_xZo.4ffMMJN//_08r1b1i"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--MP_/S_xZo.4ffMMJN//_08r1b1i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


[ Attached the reproducers to this email ]

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
Reading the documentation about destroy_inode, I'm not sure that this is the
proper way to handle allocating and then freeing the fops of the inode.

Instead of allocating the proxy_ops (and then having to free it), I created
a static proxy_ops. As tracefs only uses a subset of all the file_operations
methods, that subset can be defined in the static proxy_ops, and then the
passed in fops during the creation of the inode is saved in the dentry, and
that is use to call the real functions by the proxy_ops.

Fixes: ccbd54ff54e8 ("tracefs: Restrict tracefs when the kernel is locked down")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 153 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 135 insertions(+), 18 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 9fc14e38927f..d0e8e4a16812 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/poll.h>
 #include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
@@ -28,7 +29,7 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
-static int default_open_file(struct inode *inode, struct file *filp)
+static int proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = filp->f_path.dentry;
 	struct file_operations *real_fops;
@@ -47,6 +48,138 @@ static int default_open_file(struct inode *inode, struct file *filp)
 	return real_fops->open(inode, filp);
 }
 
+static ssize_t proxy_read(struct file *file, char __user *buf,
+			  size_t count, loff_t *pos)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct file_operations *real_fops;
+
+	if (!dentry)
+		return -EINVAL;
+
+	real_fops = dentry->d_fsdata;
+
+	if (real_fops->read)
+		return real_fops->read(file, buf, count, pos);
+	else
+		return -EINVAL;
+}
+
+static ssize_t proxy_write(struct file *file, const char __user *p,
+			   size_t count, loff_t *pos)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct file_operations *real_fops;
+
+	if (!dentry)
+		return -EINVAL;
+
+	real_fops = dentry->d_fsdata;
+
+	if (real_fops->write)
+		return real_fops->write(file, p, count, pos);
+	else
+		return -EINVAL;
+}
+
+static loff_t proxy_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct file_operations *real_fops;
+	loff_t (*fn)(struct file *, loff_t, int);
+
+	if (!dentry)
+		return -EINVAL;
+
+	real_fops = dentry->d_fsdata;
+
+	fn = no_llseek;
+	if (file->f_mode & FMODE_LSEEK) {
+		if (real_fops->llseek)
+			fn = real_fops->llseek;
+	}
+	return fn(file, offset, whence);
+}
+
+static int proxy_release(struct inode *inode, struct file *filp)
+{
+	struct dentry *dentry = filp->f_path.dentry;
+	struct file_operations *real_fops;
+
+	if (!dentry)
+		return 0;
+
+	real_fops = dentry->d_fsdata;
+
+	if (real_fops->release)
+		return real_fops->release(inode, filp);
+	return 0;
+}
+
+static __poll_t proxy_poll(struct file *file, struct poll_table_struct *pt)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct file_operations *real_fops;
+
+	if (!dentry)
+		return 0;
+
+	real_fops = dentry->d_fsdata;
+
+	if (unlikely(!real_fops->poll))
+		return DEFAULT_POLLMASK;
+	return real_fops->poll(file, pt);
+}
+
+static ssize_t proxy_splice_read(struct file *in, loff_t *ppos,
+				 struct pipe_inode_info *pipe, size_t len,
+				 unsigned int flags)
+{
+	struct dentry *dentry = in->f_path.dentry;
+	struct file_operations *real_fops;
+	ssize_t (*splice_read)(struct file *, loff_t *,
+			       struct pipe_inode_info *, size_t, unsigned int);
+
+	if (!dentry)
+		return 0;
+
+	real_fops = dentry->d_fsdata;
+
+	if (real_fops->splice_read)
+		splice_read = real_fops->splice_read;
+	else
+		splice_read = generic_file_splice_read;
+
+	return splice_read(in, ppos, pipe, len, flags);
+}
+
+static int proxy_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct file_operations *real_fops;
+
+	if (!dentry)
+		return 0;
+
+	real_fops = dentry->d_fsdata;
+
+	if (!real_fops->mmap)
+		return -ENODEV;
+
+	return real_fops->mmap(file, vma);
+}
+
+static const struct file_operations proxy_fops = {
+	.open		= proxy_open,
+	.read		= proxy_read,
+	.write		= proxy_write,
+	.llseek		= proxy_llseek,
+	.release	= proxy_release,
+	.poll		= proxy_poll,
+	.splice_read	= proxy_splice_read,
+	.mmap		= proxy_mmap,
+};
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -241,12 +374,6 @@ static int tracefs_apply_options(struct super_block *sb)
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
@@ -283,7 +410,6 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
 	.remount_fs	= tracefs_remount,
-	.destroy_inode  = tracefs_destroy_inode,
 	.show_options	= tracefs_show_options,
 };
 
@@ -414,7 +540,6 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
 {
-	struct file_operations *proxy_fops;
 	struct dentry *dentry;
 	struct inode *inode;
 
@@ -430,20 +555,12 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
-	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
-	if (unlikely(!proxy_fops)) {
-		iput(inode);
-		return failed_creating(dentry);
-	}
-
 	if (!fops)
 		fops = &tracefs_file_operations;
 
 	dentry->d_fsdata = (void *)fops;
-	memcpy(proxy_fops, fops, sizeof(*proxy_fops));
-	proxy_fops->open = default_open_file;
 	inode->i_mode = mode;
-	inode->i_fop = proxy_fops;
+	inode->i_fop = &proxy_fops;
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
-- 
2.20.1


--MP_/S_xZo.4ffMMJN//_08r1b1i
Content-Type: application/octet-stream; name=ftrace-test-mkinstances
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=ftrace-test-mkinstances

IyEvYmluL2Jhc2gKCnRyYWNlZnM9YGNhdCAvcHJvYy9tb3VudHMgIHxncmVwIHRyYWNlZnN8IGhl
YWQgLTEgfCBjdXQgLWQnICcgLWYyYAoKaWYgWyAteiAiJHRyYWNlZnMiIF07IHRoZW4KCWVjaG8g
InRyYWNlZnMgbm90IG1vdW50ZWQiCglleGl0IDAKZmkKCmlmIFsgISAtZCAkdHJhY2Vmcy9pbnN0
YW5jZXMgXTsgdGhlbgoJZWNobyAiTm8gaW5zdGFuY2VzIGRpcmVjdG9yeSIKCWV4aXQgMApmaQoK
Y2QgJHRyYWNlZnMvaW5zdGFuY2VzCgpta2RpciB4CnJtZGlyIHgKcmVzdWx0PSQ/CgppZiBbICRy
ZXN1bHQgLW5lIDAgXTsgdGhlbgoJZWNobyAiaW5zdGFuY2Ugcm1kaXIgbm90IHN1cHBvcnRlZCwg
c2tpcHBpbmcgdGhpcyB0ZXN0IgoJZXhpdCAwCmZpCgppbnN0YW5jZV9zbGFtKCkgewoJd2hpbGUg
OjsgZG8KCQlta2RpciB4CgkJbWtkaXIgeQoJCW1rZGlyIHoKCQlybWRpciB4CgkJcm1kaXIgeQoJ
CXJtZGlyIHoKCWRvbmUgMj4vZGV2L251bGwKfQoKaW5zdGFuY2Vfc2xhbSAmCnAxPSQhCmVjaG8g
JHAxCgppbnN0YW5jZV9zbGFtICYKcDI9JCEKZWNobyAkcDIKCmluc3RhbmNlX3NsYW0gJgpwMz0k
IQplY2hvICRwMwoKaW5zdGFuY2Vfc2xhbSAmCnA0PSQhCmVjaG8gJHA0CgppbnN0YW5jZV9zbGFt
ICYKcDU9JCEKZWNobyAkcDUKCmZvciBpIGluIGBzZXEgMTBgOyBkbwoJbHMKCXNsZWVwIDEKZG9u
ZQpraWxsIC0xICRwMSAKa2lsbCAtMSAkcDIKa2lsbCAtMSAkcDMKa2lsbCAtMSAkcDQKa2lsbCAt
MSAkcDUKCmVjaG8gIldhaXQgZm9yIHByb2Nlc3NlcyB0byBmaW5pc2giCndhaXQgJHAxICRwMiAk
cDMgJHA0ICRwNQplY2hvICJhbGwgcHJvY2Vzc2VzIGZpbmlzaGVkLCB3YWl0IGZvciBjbGVhbnVw
IgpzbGVlcCAyCgpta2RpciB4IHkgegpscyB4IHkgegpybWRpciB4IHkgegpmb3IgZCBpbiB4IHkg
ejsgZG8KCWlmIFsgLWQgJGQgXTsgdGhlbgoJCWVjaG8gJGQgc3RpbGwgZXhpc3RzCgkJZXhpdCAt
MQoJZmkKZG9uZQplY2hvIFNVQ0NFU1MKZXhpdCAwCg==

--MP_/S_xZo.4ffMMJN//_08r1b1i
Content-Type: application/octet-stream; name=ftrace-test-mkinstances-2
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=ftrace-test-mkinstances-2

IyEvYmluL2Jhc2gKCnRyYWNlZnM9YGNhdCAvcHJvYy9tb3VudHMgIHxncmVwIHRyYWNlZnN8IGhl
YWQgLTEgfCBjdXQgLWQnICcgLWYyYAoKaWYgWyAteiAiJHRyYWNlZnMiIF07IHRoZW4KCWVjaG8g
InRyYWNlZnMgbm90IG1vdW50ZWQiCglleGl0IDAKZmkKCmlmIFsgISAtZCAkdHJhY2Vmcy9pbnN0
YW5jZXMgXTsgdGhlbgoJZWNobyAiTm8gaW5zdGFuY2VzIGRpcmVjdG9yeSIKCWV4aXQgMApmaQoK
Y2QgJHRyYWNlZnMvaW5zdGFuY2VzCgppbnN0YW5jZV9zbGFtKCkgewoJd2hpbGUgOjsgZG8KCQlt
a2RpciBmb28gJj4gL2Rldi9udWxsCgkJcm1kaXIgZm9vICY+IC9kZXYvbnVsbAoJZG9uZQp9Cgpp
bnN0YW5jZV9yZWFkKCkgewoJd2hpbGUgOjsgZG8KCQljYXQgZm9vL3RyYWNlICY+IC9kZXYvbnVs
bAoJZG9uZQp9CgppbnN0YW5jZV9zZXQoKSB7Cgl3aGlsZSA6OyBkbwoJCWVjaG8gMSA+IGZvby9l
dmVudHMvc2NoZWQvc2NoZWRfc3dpdGNoCglkb25lIDI+IC9kZXYvbnVsbAp9CgppbnN0YW5jZV9z
bGFtICYKeD1gam9icyAtbGAKcDE9YGVjaG8gJHggfCBjdXQgLWQnICcgLWYyYAplY2hvICRwMQoK
aW5zdGFuY2Vfc2V0ICYKeD1gam9icyAtbCB8IHRhaWwgLTFgCnAyPWBlY2hvICR4IHwgY3V0IC1k
JyAnIC1mMmAKZWNobyAkcDIKCnNsZWVwIDEwCgpraWxsIC0xICRwMSAKa2lsbCAtMSAkcDIKCmVj
aG8gIldhaXQgZm9yIHByb2Nlc3NlcyB0byBmaW5pc2giCndhaXQgJHAxICRwMgplY2hvICJhbGwg
cHJvY2Vzc2VzIGZpbmlzaGVkLCB3YWl0IGZvciBjbGVhbnVwIgpzbGVlcCAyCgpta2RpciBmb28K
bHMgZm9vCnJtZGlyIGZvbwppZiBbIC1kIGZvbyBdOyB0aGVuCgllY2hvIGZvbyBzdGlsbCBleGlz
dHMKCWV4aXQgLTEKZmkKZWNobyBTVUNDRVNTCmV4aXQgMAo=

--MP_/S_xZo.4ffMMJN//_08r1b1i--
