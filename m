Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B749D4949
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfJKUZW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 16:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbfJKUZW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 16:25:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C4C2084C;
        Fri, 11 Oct 2019 20:25:19 +0000 (UTC)
Date:   Fri, 11 Oct 2019 16:25:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for
 lockdown
Message-ID: <20191011162518.2f8c99ca@gandalf.local.home>
In-Reply-To: <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
References: <20191011135458.7399da44@gandalf.local.home>
        <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 11 Oct 2019 11:20:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So from a quick glance, just making tracing_open_generic() do the
> lockdown testing will take care of most cases.  Add a few other cases
> to fill up the whole set, and your'e done.
> 
> Willing to do that instead?

OK, so I tried this approach, and there's a bit more than just a "few"
extra cases that use tracing_open_generic(). Below is the full patch.

Here's the diffstat:

 fs/tracefs/inode.c                  |   42 --------------------
 kernel/trace/ftrace.c               |   29 +++++++++++++-
 kernel/trace/trace.c                |   73 ++++++++++++++++++++++++++++++++++--
 kernel/trace/trace_dynevent.c       |    5 ++
 kernel/trace/trace_events.c         |   10 ++++
 kernel/trace/trace_events_hist.c    |   11 +++++
 kernel/trace/trace_events_trigger.c |    8 +++
 kernel/trace/trace_kprobe.c         |   11 +++++
 kernel/trace/trace_printk.c         |    7 +++
 kernel/trace/trace_stack.c          |    8 +++
 kernel/trace/trace_stat.c           |    6 ++
 kernel/trace/trace_uprobe.c         |   11 +++++
 12 files changed, 173 insertions(+), 48 deletions(-)

Compared to the patch with the full wrapper:

 fs/tracefs/inode.c | 153 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 135 insertions(+), 18 deletions(-)

I'm thinking that the full wrapper may not be as bad. But then again, I
could probably clean up some of this code and have a single check for
both the lockdown and the "tracing_disabled" check.

-- Steve

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
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 62a50bf399d6..326253b4de93 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -18,6 +18,7 @@
 #include <linux/clocksource.h>
 #include <linux/sched/task.h>
 #include <linux/kallsyms.h>
+#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/tracefs.h>
 #include <linux/hardirq.h>
@@ -3486,6 +3487,11 @@ static int
 ftrace_avail_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_iterator *iter;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
@@ -3504,6 +3510,11 @@ static int
 ftrace_enabled_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_iterator *iter;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
 	if (!iter)
@@ -3540,7 +3551,11 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	struct ftrace_hash *hash;
 	struct list_head *mod_head;
 	struct trace_array *tr = ops->private;
-	int ret = 0;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	ftrace_ops_init(ops);
 
@@ -3618,6 +3633,7 @@ ftrace_filter_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_ops *ops = inode->i_private;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_regex_open(ops,
 			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
 			inode, file);
@@ -3628,6 +3644,7 @@ ftrace_notrace_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_ops *ops = inode->i_private;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
 				 inode, file);
 }
@@ -5194,9 +5211,13 @@ static int
 __ftrace_graph_open(struct inode *inode, struct file *file,
 		    struct ftrace_graph_data *fgd)
 {
-	int ret = 0;
+	int ret;
 	struct ftrace_hash *new_hash = NULL;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (file->f_mode & FMODE_WRITE) {
 		const int size_bits = FTRACE_HASH_DEFAULT_BITS;
 
@@ -6537,6 +6558,10 @@ ftrace_pid_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret = 0;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (trace_array_get(tr) < 0)
 		return -ENODEV;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 252f79c435f8..4be1be27d064 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -17,6 +17,7 @@
 #include <linux/stacktrace.h>
 #include <linux/writeback.h>
 #include <linux/kallsyms.h>
+#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/notifier.h>
 #include <linux/irqflags.h>
@@ -4140,6 +4141,12 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
 int tracing_open_generic(struct inode *inode, struct file *filp)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -4159,6 +4166,11 @@ bool tracing_is_disabled(void)
 static int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	if (tracing_disabled)
 		return -ENODEV;
@@ -4233,7 +4245,11 @@ static int tracing_open(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
-	int ret = 0;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	if (trace_array_get(tr) < 0)
 		return -ENODEV;
@@ -4352,6 +4368,10 @@ static int show_traces_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -4697,6 +4717,10 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -5038,6 +5062,12 @@ static const struct seq_operations tracing_saved_tgids_seq_ops = {
 
 static int tracing_saved_tgids_open(struct inode *inode, struct file *filp)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -5115,6 +5145,12 @@ static const struct seq_operations tracing_saved_cmdlines_seq_ops = {
 
 static int tracing_saved_cmdlines_open(struct inode *inode, struct file *filp)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -5280,6 +5316,12 @@ static const struct seq_operations tracing_eval_map_seq_ops = {
 
 static int tracing_eval_map_open(struct inode *inode, struct file *filp)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -5804,7 +5846,11 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
-	int ret = 0;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	if (tracing_disabled)
 		return -ENODEV;
@@ -6547,6 +6593,10 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -6581,6 +6631,10 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -6638,7 +6692,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
 	struct seq_file *m;
-	int ret = 0;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	if (trace_array_get(tr) < 0)
 		return -ENODEV;
@@ -6786,6 +6844,7 @@ static int snapshot_raw_open(struct inode *inode, struct file *filp)
 	struct ftrace_buffer_info *info;
 	int ret;
 
+	/* The following checks for tracefs lockdown */
 	ret = tracing_buffers_open(inode, filp);
 	if (ret < 0)
 		return ret;
@@ -7105,6 +7164,10 @@ static int tracing_err_log_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret = 0;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (trace_array_get(tr) < 0)
 		return -ENODEV;
 
@@ -7157,6 +7220,10 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
 	struct ftrace_buffer_info *info;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index a41fed46c285..7a731416bbdd 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 Masami Hiramatsu <mhiramat@kernel.org>
  */
 
+#include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -174,6 +175,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(NULL);
 		if (ret < 0)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b89cdfe20bc1..cc02257fd6df 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/workqueue.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
 #include <linux/tracefs.h>
@@ -1294,6 +1295,10 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = seq_open(file, &trace_format_seq_ops);
 	if (ret < 0)
 		return ret;
@@ -1771,6 +1776,10 @@ ftrace_event_open(struct inode *inode, struct file *file,
 	struct seq_file *m;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = seq_open(file, seq_ops);
 	if (ret < 0)
 		return ret;
@@ -1795,6 +1804,7 @@ ftrace_event_avail_open(struct inode *inode, struct file *file)
 {
 	const struct seq_operations *seq_ops = &show_event_seq_ops;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_event_open(inode, file, seq_ops);
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9468bd8d44a2..71dfe6889d62 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/security.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
@@ -1448,6 +1449,10 @@ static int synth_events_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(&synth_event_ops);
 		if (ret < 0)
@@ -5515,6 +5520,12 @@ static int hist_show(struct seq_file *m, void *v)
 
 static int event_hist_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return single_open(file, hist_show, file);
 }
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2a2912cb4533..2cd53ca21b51 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 Tom Zanussi <tom.zanussi@linux.intel.com>
  */
 
+#include <linux/security.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/mutex.h>
@@ -173,7 +174,11 @@ static const struct seq_operations event_triggers_seq_ops = {
 
 static int event_trigger_regex_open(struct inode *inode, struct file *file)
 {
-	int ret = 0;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	mutex_lock(&event_mutex);
 
@@ -292,6 +297,7 @@ event_trigger_write(struct file *filp, const char __user *ubuf,
 static int
 event_trigger_open(struct inode *inode, struct file *filp)
 {
+	/* Checks for tracefs lockdown */
 	return event_trigger_regex_open(inode, filp);
 }
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 324ffbea3556..e4422746cb4c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
+#include <linux/security.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
@@ -936,6 +937,10 @@ static int probes_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(&trace_kprobe_ops);
 		if (ret < 0)
@@ -988,6 +993,12 @@ static const struct seq_operations profile_seq_op = {
 
 static int profile_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return seq_open(file, &profile_seq_op);
 }
 
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index c3fd849d4a8f..d4e31e969206 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -6,6 +6,7 @@
  *
  */
 #include <linux/seq_file.h>
+#include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/ftrace.h>
@@ -348,6 +349,12 @@ static const struct seq_operations show_format_seq_ops = {
 static int
 ftrace_formats_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return seq_open(file, &show_format_seq_ops);
 }
 
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index ec9a34a97129..4df9a209f7ca 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -5,6 +5,7 @@
  */
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
+#include <linux/security.h>
 #include <linux/kallsyms.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
@@ -470,6 +471,12 @@ static const struct seq_operations stack_trace_seq_ops = {
 
 static int stack_trace_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return seq_open(file, &stack_trace_seq_ops);
 }
 
@@ -487,6 +494,7 @@ stack_trace_filter_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_ops *ops = inode->i_private;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_regex_open(ops, FTRACE_ITER_FILTER,
 				 inode, file);
 }
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index 75bf1bcb4a8a..9ab0a1a7ad5e 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -9,7 +9,7 @@
  *
  */
 
-
+#include <linux/security.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/rbtree.h>
@@ -238,6 +238,10 @@ static int tracing_stat_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	struct stat_session *session = inode->i_private;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = stat_seq_init(session);
 	if (ret)
 		return ret;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index dd884341f5c5..352073d36585 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt)	"trace_uprobe: " fmt
 
+#include <linux/security.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
@@ -769,6 +770,10 @@ static int probes_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(&trace_uprobe_ops);
 		if (ret)
@@ -818,6 +823,12 @@ static const struct seq_operations profile_seq_op = {
 
 static int profile_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return seq_open(file, &profile_seq_op);
 }
 
