Return-Path: <linux-api+bounces-796-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048CB8470E6
	for <lists+linux-api@lfdr.de>; Fri,  2 Feb 2024 14:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67A328E13E
	for <lists+linux-api@lfdr.de>; Fri,  2 Feb 2024 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B945BFC;
	Fri,  2 Feb 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUMHxEwf"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E471755A
	for <linux-api@vger.kernel.org>; Fri,  2 Feb 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879651; cv=none; b=b7z8xvXx+XxLK36gOUp1PXSn6/o6leSbaTgkV4zCt8zUFCUMary4qDfL/HPjOhTUiz2+YLIivss1iXN8Ot9nSGrlgcXTKN80Mt53B/KPfCY4gmyyAsZ9kv7y9XEWYQDb91N+LCmvWuJYw9q9gMBRDGzdwMDMfpVck1/5JQ3qppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879651; c=relaxed/simple;
	bh=Ll/s1Mpq1wn0WVe7lBWJ6vbuD1ND6xPjIS/Y+odacrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tu0P1zIRAGSom/BfyHvd8EDL5Yq2rCjKgZObM9wHp7kjfOy8uku56IicmguYm1ZbL0CBQ0f215RxS+nqo0v0Fe1XLCowZOkTGKDVHKgtN46MdPucn85k8zCT4WnjwJuUv67Q1XDTwwcnJvi+jWQ7+5ie2/o4nDP06UD29Vb+NDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUMHxEwf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706879649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=hcrUB/TxGDQzkVWVzEEPdidIHt7V/i+DGLB/TQZqAG4=;
	b=jUMHxEwfoEOTG5De+T0VSoOjLZxNH99L5s0nLi/Nbyi72p9d86BcCSGHomBC8zcuAIox5X
	mAo11O8jP9pORaTdsrfqaOBtHpMTngAPJxpuE3oR3Y6UxqpxSVYQ2c7PFA9ioQVnafU8pe
	KYwHZH9Q4CQwuvg/elE5oVrqeVyHRe4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-UFkX2USqOH-HlUQt27oB7w-1; Fri,
 02 Feb 2024 08:14:03 -0500
X-MC-Unique: UFkX2USqOH-HlUQt27oB7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 614F529AC00E;
	Fri,  2 Feb 2024 13:14:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0F4B4400D783;
	Fri,  2 Feb 2024 13:14:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Feb 2024 14:12:48 +0100 (CET)
Date: Fri, 2 Feb 2024 14:12:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202131226.GA26018@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202131147.GA25988@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add another wake_up_all(wait_pidfd) into __change_pid() and change
pidfd_poll() to include EPOLLHUP if task == NULL.

This allows to wait until the target process/thread is reaped.

TODO: change do_notify_pidfd() to use the keyed wakeups.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 22 +++++++---------------
 kernel/pid.c  |  5 +++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index b8c6ec9a08dd..8d08a2d1b095 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2071,20 +2071,6 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
-static bool pidfd_task_exited(struct pid *pid, bool thread)
-{
-	struct task_struct *task;
-	bool exited;
-
-	rcu_read_lock();
-	task = pid_task(pid, PIDTYPE_PID);
-	exited = !task ||
-		(READ_ONCE(task->exit_state) && (thread || thread_group_empty(task)));
-	rcu_read_unlock();
-
-	return exited;
-}
-
 /*
  * Poll support for process exit notification.
  */
@@ -2092,6 +2078,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 {
 	struct pid *pid = file->private_data;
 	bool thread = file->f_flags & PIDFD_THREAD;
+	struct task_struct *task;
 	__poll_t poll_flags = 0;
 
 	poll_wait(file, &pid->wait_pidfd, pts);
@@ -2099,8 +2086,13 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	 * Depending on PIDFD_THREAD, inform pollers when the thread
 	 * or the whole thread-group exits.
 	 */
-	if (pidfd_task_exited(pid, thread))
+	rcu_read_lock();
+	task = pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
+	else if (task->exit_state && (thread || thread_group_empty(task)))
 		poll_flags = EPOLLIN | EPOLLRDNORM;
+	rcu_read_unlock();
 
 	return poll_flags;
 }
diff --git a/kernel/pid.c b/kernel/pid.c
index e11144466828..62461c7c82b8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -349,6 +349,11 @@ static void __change_pid(struct task_struct *task, enum pid_type type,
 	hlist_del_rcu(&task->pid_links[type]);
 	*pid_ptr = new;
 
+	if (type == PIDTYPE_PID) {
+		WARN_ON_ONCE(pid_has_task(pid, PIDTYPE_PID));
+		wake_up_all(&pid->wait_pidfd);
+	}
+
 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
 		if (pid_has_task(pid, tmp))
 			return;
-- 
2.25.1.362.g51ebf55


