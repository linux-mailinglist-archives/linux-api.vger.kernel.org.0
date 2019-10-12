Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E52ED4B8E
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 02:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJLA7X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 20:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfJLA7X (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 20:59:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348CD21D71;
        Sat, 12 Oct 2019 00:59:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iJ5kf-0004FQ-Bt; Fri, 11 Oct 2019 20:59:21 -0400
Message-Id: <20191012005921.255635646@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 11 Oct 2019 20:57:52 -0400
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
Subject: [PATCH 5/7 v2] tracing: Add tracing_check_open_get_tr()
References: <20191012005747.210722465@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently, most files in the tracefs directory that gets opened needs to
test if tracing_disabled is set. If so, it should return -ENODEV. The
tracing_disabled is called when tracing is found to be broken. Originally it
was done in case the ring buffer was found to be corrupted, and we wanted to
prevent reading it from crashing the kernel. But it's also called if a
tracing selftest fails on boot. It's a one way switch. That is, once it is
triggered, tracing is disabled until reboot.

As most tracefs files can also be used by instances in the tracefs
directory, they need to be carefully done. Each instance has a trace_array
associated to it, and when the instance is removed, the trace_array is
freed. But if an instance is opened with a reference to the trace_array, the
getting the trace_array has to be done by a lookup (as there could be a race
with it being deleted and the open itself), and then once it is found, a
reference is added to prevent the instance from being removed (and the
trace_array associated with it freed).

Combine the two checks (tracing_disabled and trace_array_get()) into a
single helper function. This will also make it easier to add lockdown to
tracefs later.

Link: http://lkml.kernel.org/r/20191011135458.7399da44@gandalf.local.home

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c            |   7 +-
 kernel/trace/trace.c             | 117 +++++++++++++++++--------------
 kernel/trace/trace.h             |   1 +
 kernel/trace/trace_dynevent.c    |   4 ++
 kernel/trace/trace_events.c      |  10 +--
 kernel/trace/trace_events_hist.c |   2 +-
 6 files changed, 81 insertions(+), 60 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 32c2eb167de0..8b765a55e01c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3547,7 +3547,7 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
-	if (tr && trace_array_get(tr) < 0)
+	if (tracing_check_open_get_tr(tr))
 		return -ENODEV;
 
 	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
@@ -6546,8 +6546,9 @@ ftrace_pid_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret = 0;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC))
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 94f1b9124939..26ee280f852b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -304,6 +304,17 @@ void trace_array_put(struct trace_array *this_tr)
 	mutex_unlock(&trace_types_lock);
 }
 
+int tracing_check_open_get_tr(struct trace_array *tr)
+{
+	if (tracing_disabled)
+		return -ENODEV;
+
+	if (tr && trace_array_get(tr) < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
 int call_filter_check_discard(struct trace_event_call *call, void *rec,
 			      struct ring_buffer *buffer,
 			      struct ring_buffer_event *event)
@@ -4140,8 +4151,11 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
 int tracing_open_generic(struct inode *inode, struct file *filp)
 {
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
 
 	filp->private_data = inode->i_private;
 	return 0;
@@ -4159,12 +4173,11 @@ bool tracing_is_disabled(void)
 int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
+	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	filp->private_data = inode->i_private;
 
@@ -4233,10 +4246,11 @@ static int tracing_open(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
-	int ret = 0;
+	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	/* If this file was open for write, then erase contents */
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
@@ -4352,11 +4366,9 @@ static int show_traces_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	ret = seq_open(file, &show_traces_seq_ops);
 	if (ret) {
@@ -4710,11 +4722,9 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	ret = single_open(file, tracing_trace_options_show, inode->i_private);
 	if (ret < 0)
@@ -5051,8 +5061,11 @@ static const struct seq_operations tracing_saved_tgids_seq_ops = {
 
 static int tracing_saved_tgids_open(struct inode *inode, struct file *filp)
 {
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
 
 	return seq_open(filp, &tracing_saved_tgids_seq_ops);
 }
@@ -5128,8 +5141,11 @@ static const struct seq_operations tracing_saved_cmdlines_seq_ops = {
 
 static int tracing_saved_cmdlines_open(struct inode *inode, struct file *filp)
 {
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
 
 	return seq_open(filp, &tracing_saved_cmdlines_seq_ops);
 }
@@ -5293,8 +5309,11 @@ static const struct seq_operations tracing_eval_map_seq_ops = {
 
 static int tracing_eval_map_open(struct inode *inode, struct file *filp)
 {
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
 
 	return seq_open(filp, &tracing_eval_map_seq_ops);
 }
@@ -5817,13 +5836,11 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
-	int ret = 0;
-
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	mutex_lock(&trace_types_lock);
 
@@ -6560,11 +6577,9 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr))
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	ret = single_open(file, tracing_clock_show, inode->i_private);
 	if (ret < 0)
@@ -6594,11 +6609,9 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr))
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	ret = single_open(file, tracing_time_stamp_mode_show, inode->i_private);
 	if (ret < 0)
@@ -6651,10 +6664,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
 	struct seq_file *m;
-	int ret = 0;
+	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	if (file->f_mode & FMODE_READ) {
 		iter = __tracing_open(inode, file, true);
@@ -7118,8 +7132,9 @@ static int tracing_err_log_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret = 0;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	/* If this file was opened for write, then erase contents */
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
@@ -7170,11 +7185,9 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
 	struct ftrace_buffer_info *info;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 854dbf4050f8..d685c61085c0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -338,6 +338,7 @@ extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
+extern int tracing_check_open_get_tr(struct trace_array *tr);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index a41fed46c285..89779eb84a07 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -174,6 +174,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(NULL);
 		if (ret < 0)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0d29f2f13477..ae35d6cb802a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1784,8 +1784,9 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC))
@@ -1804,8 +1805,9 @@ ftrace_event_set_pid_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC))
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9468bd8d44a2..dd18d76bf1bd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1680,7 +1680,7 @@ static int save_hist_vars(struct hist_trigger_data *hist_data)
 	if (var_data)
 		return 0;
 
-	if (trace_array_get(tr) < 0)
+	if (tracing_check_open_get_tr(tr))
 		return -ENODEV;
 
 	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
-- 
2.23.0


