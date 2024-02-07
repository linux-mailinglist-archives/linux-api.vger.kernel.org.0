Return-Path: <linux-api+bounces-871-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480C84C9E4
	for <lists+linux-api@lfdr.de>; Wed,  7 Feb 2024 12:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F086AB21123
	for <lists+linux-api@lfdr.de>; Wed,  7 Feb 2024 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB651BDE2;
	Wed,  7 Feb 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5KTzD4J"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8DA1B811
	for <linux-api@vger.kernel.org>; Wed,  7 Feb 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306436; cv=none; b=WlCIai7WuubCrZCbduVmw5vZJ47l49laejeuHFUSFngLb/xxYai5N53E+kOj+y5ujsm8dT3RsKat1ZuyVtqQvY7VFyL7Bp/8FX0Ttn8tt0Uk5Bs8RrGJ4Eifm7pnmjIOrqvz8nUuDXJRfaRj59YYi7UNkzyUvjhcuyh7hgy5NI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306436; c=relaxed/simple;
	bh=tjrQh1y4H5W6sx6xqeHy4JzMSxFgjnezbUH6ZJHM5NI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M29MirGlrxqHrR37Tk1HJt8DbGOl2c3DX8I20ouFqdAJz3cI8sOk7V3uv++76GKjPmxcsy1pxQMFOFDCutKT1Vx5bS4+8d96SmZhESKdMGHszAYcnN3IitnrAJ4JEygAoXFhF9i8lIMwGFWecVI3OWZJEDElXO71tUd8HbHVkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5KTzD4J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707306432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nvbuj/0u9tEQEJhqguXdXu/oFCwcAEaMYAW5rW/LIQU=;
	b=M5KTzD4JFpB81mk40dcqReb27FgwviDw9j6/pLjAwl03Mpcj/9cd94TvbDbpzcBuQ08E1X
	hlUSNTiUsqP7Y3uEcBx2gC3NVk+EQsMQVE1OYbCLQNwNAMKmmQkLBWZA2vqk0Lm6fOK0df
	BC85Xu8Tpu/v+ZuozQz8q99sjZoVR7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-aNrfZZEpPIqEjvdaQ2srow-1; Wed, 07 Feb 2024 06:47:08 -0500
X-MC-Unique: aNrfZZEpPIqEjvdaQ2srow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F195185A588;
	Wed,  7 Feb 2024 11:47:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.212])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5171F1C02EB3;
	Wed,  7 Feb 2024 11:47:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Feb 2024 12:45:51 +0100 (CET)
Date: Wed, 7 Feb 2024 12:45:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240207114549.GA12697@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
pid_type to group_send_sig_info(), despite its name it should work fine
even if type = PIDTYPE_PID.

Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
on PIDFD_THREAD.

While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c   |  2 --
 kernel/signal.c | 18 ++++++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cd61ca87d0e6..47b565598063 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2051,8 +2051,6 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 
 	seq_put_decimal_ll(m, "Pid:\t", nr);
 
-	/* TODO: report PIDFD_THREAD */
-
 #ifdef CONFIG_PID_NS
 	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
 	if (nr > 0) {
diff --git a/kernel/signal.c b/kernel/signal.c
index c3fac06937e2..e3edcd784e45 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -47,6 +47,7 @@
 #include <linux/cgroup.h>
 #include <linux/audit.h>
 #include <linux/sysctl.h>
+#include <uapi/linux/pidfd.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -1478,7 +1479,8 @@ int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
 	return ret;
 }
 
-int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
+static int kill_pid_info_type(int sig, struct kernel_siginfo *info,
+				struct pid *pid, enum pid_type type)
 {
 	int error = -ESRCH;
 	struct task_struct *p;
@@ -1487,11 +1489,10 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
 		if (p)
-			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
+			error = group_send_sig_info(sig, info, p, type);
 		rcu_read_unlock();
 		if (likely(!p || error != -ESRCH))
 			return error;
-
 		/*
 		 * The task was unhashed in between, try again.  If it
 		 * is dead, pid_task() will return NULL, if we race with
@@ -1500,6 +1501,11 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
 	}
 }
 
+int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
+{
+	return kill_pid_info_type(sig, info, pid, PIDTYPE_TGID);
+}
+
 static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
 {
 	int error;
@@ -3890,6 +3896,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
+	enum pid_type type;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags)
@@ -3928,9 +3935,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		prepare_kill_siginfo(sig, &kinfo);
 	}
 
-	/* TODO: respect PIDFD_THREAD */
-	ret = kill_pid_info(sig, &kinfo, pid);
-
+	type = (f.file->f_flags & PIDFD_THREAD) ? PIDTYPE_PID : PIDTYPE_TGID;
+	ret = kill_pid_info_type(sig, &kinfo, pid, type);
 err:
 	fdput(f);
 	return ret;
-- 
2.25.1.362.g51ebf55



