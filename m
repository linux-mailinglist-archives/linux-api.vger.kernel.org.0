Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1CD4B91
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 02:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfJLA70 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 20:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbfJLA7Y (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 20:59:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 576B221D7D;
        Sat, 12 Oct 2019 00:59:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iJ5kf-0004Fu-H6; Fri, 11 Oct 2019 20:59:21 -0400
Message-Id: <20191012005921.411873502@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 11 Oct 2019 20:57:53 -0400
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
Subject: [PATCH 6/7 v2] tracing: Add some more locked_down checks
References: <20191012005747.210722465@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Added various checks on open tracefs calls to see if tracefs is in lockdown
mode, and if so, to return -EPERM.

Note, the event format files (which are basically standard on all machines)
as well as the enabled_functions file (which shows what is currently being
traced) are not lockde down. Perhaps they should be, but it seems counter
intuitive to lockdown information to help you know if the system has been
modified.

Link: http://lkml.kernel.org/r/CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c               | 23 ++++++++++++++++++++++-
 kernel/trace/trace.c                |  8 ++++++++
 kernel/trace/trace_events.c         |  8 ++++++++
 kernel/trace/trace_events_hist.c    | 11 +++++++++++
 kernel/trace/trace_events_trigger.c |  8 +++++++-
 kernel/trace/trace_kprobe.c         | 12 +++++++++++-
 kernel/trace/trace_printk.c         |  7 +++++++
 kernel/trace/trace_stack.c          |  8 ++++++++
 kernel/trace/trace_stat.c           |  6 +++++-
 kernel/trace/trace_uprobe.c         | 11 +++++++++++
 10 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8b765a55e01c..f296d89be757 100644
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
@@ -3505,6 +3511,15 @@ ftrace_enabled_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_iterator *iter;
 
+	/*
+	 * This shows us what functions are currently being
+	 * traced and by what. Not sure if we want lockdown
+	 * to hide such critical information for an admin.
+	 * Although, perhaps it can show information we don't
+	 * want people to see, but if something is tracing
+	 * something, we probably want to know about it.
+	 */
+
 	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
@@ -3625,6 +3640,7 @@ ftrace_filter_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_ops *ops = inode->i_private;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_regex_open(ops,
 			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
 			inode, file);
@@ -3635,6 +3651,7 @@ ftrace_notrace_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_ops *ops = inode->i_private;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
 				 inode, file);
 }
@@ -5203,9 +5220,13 @@ static int
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
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 26ee280f852b..2b4eff383505 100644
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
@@ -306,6 +307,12 @@ void trace_array_put(struct trace_array *this_tr)
 
 int tracing_check_open_get_tr(struct trace_array *tr)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (tracing_disabled)
 		return -ENODEV;
 
@@ -6813,6 +6820,7 @@ static int snapshot_raw_open(struct inode *inode, struct file *filp)
 	struct ftrace_buffer_info *info;
 	int ret;
 
+	/* The following checks for tracefs lockdown */
 	ret = tracing_buffers_open(inode, filp);
 	if (ret < 0)
 		return ret;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ae35d6cb802a..994b7a408c5f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/workqueue.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
 #include <linux/tracefs.h>
@@ -1294,6 +1295,8 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret;
 
+	/* Do we want to hide event format files on tracefs lockdown? */
+
 	ret = seq_open(file, &trace_format_seq_ops);
 	if (ret < 0)
 		return ret;
@@ -1750,6 +1753,10 @@ ftrace_event_open(struct inode *inode, struct file *file,
 	struct seq_file *m;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = seq_open(file, seq_ops);
 	if (ret < 0)
 		return ret;
@@ -1774,6 +1781,7 @@ ftrace_event_avail_open(struct inode *inode, struct file *file)
 {
 	const struct seq_operations *seq_ops = &show_event_seq_ops;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_event_open(inode, file, seq_ops);
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index dd18d76bf1bd..57648c5aa679 100644
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
index 324ffbea3556..1552a95c743b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -7,11 +7,11 @@
  */
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
+#include <linux/security.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
-#include <linux/security.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 
@@ -936,6 +936,10 @@ static int probes_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(&trace_kprobe_ops);
 		if (ret < 0)
@@ -988,6 +992,12 @@ static const struct seq_operations profile_seq_op = {
 
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
 
-- 
2.23.0


