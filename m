Return-Path: <linux-api+bounces-3865-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BC8ACB4C9
	for <lists+linux-api@lfdr.de>; Mon,  2 Jun 2025 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEB8188DFF3
	for <lists+linux-api@lfdr.de>; Mon,  2 Jun 2025 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943E22539E;
	Mon,  2 Jun 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TC9mz+6z"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6272C3247;
	Mon,  2 Jun 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874975; cv=none; b=S4pg7ElgqQ1kqoj9E9Ehk0/uE9HNw8Gl0FTf1HFUM7F1cED0cBSlO+RpcNAYwUYeGZgdKucyfmI8IG8hhGao+qbGuxzGwgVtpjSXeVcVvIW7U/vMckndcKdX3xSjJ9FWphOPrK3IqXnbxGSeIJGdA3sxYcy9TkNIB7nFWkebhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874975; c=relaxed/simple;
	bh=kp+WSZdOuINjaGj5c3s6dJyNaLtwpBOqrWOUGFgFgAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqvHtzYWimVzI8lfDw0go3PbXguNRRDmxPUg3MVDsyiGYpAw+eebbn2aOsf7o1MvhRbTq3r3vZLPJVOPYFrBl/UjBhsR9YaaIIEWb3f0bKyw33+vDtpj0Q6xiJh18zX7eMxZVi1UE40KJkZPwMZQ//JKVy5pdh5m3EdjUg8xy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TC9mz+6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8867EC4CEEB;
	Mon,  2 Jun 2025 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874975;
	bh=kp+WSZdOuINjaGj5c3s6dJyNaLtwpBOqrWOUGFgFgAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TC9mz+6zEOi2v7bgxNYjdBzA9XcYUzcl5PW8LGaeo0jG1U4NKfnNsvJt6mi0KT2P4
	 NLZeRQ5paeo7A1GWUElOtMSiWjWN5XljQiQ1K4w4wQ4jDwv4sVnoapYEOsMu3o5XHz
	 FIk41RFOaH5vYMTY8P+mNZyN3hTbCyvWZTZ6ovUo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Christian Kellner <christian@kellner.me>,
	linux-api@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 193/204] pidfd: check pid has attached task in fdinfo
Date: Mon,  2 Jun 2025 15:48:46 +0200
Message-ID: <20250602134303.260720932@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <christian.brauner@ubuntu.com>

commit 3d6d8da48d0b214d65ea0227d47228abc75d7c88 upstream.

Currently, when a task is dead we still print the pid it used to use in
the fdinfo files of its pidfds. This doesn't make much sense since the
pid may have already been reused. So verify that the task is still alive
by introducing the pid_has_task() helper which will be used by other
callers in follow-up patches.
If the task is not alive anymore, we will print -1. This allows us to
differentiate between a task not being present in a given pid namespace
- in which case we already print 0 - and a task having been reaped.

Note that this uses PIDTYPE_PID for the check. Technically, we could've
checked PIDTYPE_TGID since pidfds currently only refer to thread-group
leaders but if they won't anymore in the future then this check becomes
problematic without it being immediately obvious to non-experts imho. If
a thread is created via clone(CLONE_THREAD) than struct pid has a single
non-empty list pid->tasks[PIDTYPE_PID] and this pid can't be used as a
PIDTYPE_TGID meaning pid->tasks[PIDTYPE_TGID] will return NULL even
though the thread-group leader might still be very much alive. So
checking PIDTYPE_PID is fine and is easier to maintain should we ever
allow pidfds to refer to threads.

Cc: Jann Horn <jannh@google.com>
Cc: Christian Kellner <christian@kellner.me>
Cc: linux-api@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20191017101832.5985-1-christian.brauner@ubuntu.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/pid.h |    4 ++++
 kernel/fork.c       |   10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -85,6 +85,10 @@ static inline struct pid *get_pid(struct
 
 extern void put_pid(struct pid *pid);
 extern struct task_struct *pid_task(struct pid *pid, enum pid_type);
+static inline bool pid_has_task(struct pid *pid, enum pid_type type)
+{
+	return !hlist_empty(&pid->tasks[type]);
+}
 extern struct task_struct *get_pid_task(struct pid *pid, enum pid_type);
 
 extern struct pid *get_task_pid(struct task_struct *task, enum pid_type type);
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1703,10 +1703,16 @@ static int pidfd_release(struct inode *i
 #ifdef CONFIG_PROC_FS
 static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
-	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
 	struct pid *pid = f->private_data;
+	struct pid_namespace *ns;
+	pid_t nr = -1;
 
-	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
+	if (likely(pid_has_task(pid, PIDTYPE_PID))) {
+		ns = proc_pid_ns(file_inode(m->file));
+		nr = pid_nr_ns(pid, ns);
+	}
+
+	seq_put_decimal_ll(m, "Pid:\t", nr);
 	seq_putc(m, '\n');
 }
 #endif



