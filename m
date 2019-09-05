Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63514A97B9
	for <lists+linux-api@lfdr.de>; Thu,  5 Sep 2019 02:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfIEAxX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Sep 2019 20:53:23 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41194 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfIEAxX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Sep 2019 20:53:23 -0400
Received: by mail-qt1-f202.google.com with SMTP id n59so674700qtd.8
        for <linux-api@vger.kernel.org>; Wed, 04 Sep 2019 17:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=IvnDskQJANuLQ1Pn7l1TmXAAMajXPjDT8vWcyh/XpmU=;
        b=gO/FwIoDdL9taG9VUeNXZQNCiJk0A/0oE9ucXBj7+Xx9splScPhCR2nWU47O6fXBx6
         C582CQtLKNx7/QnibdqXHNUq+BPpBYj+kMNkM9hCWE/sifAGYQWwwIrbl9B1O5kPARX7
         Sk4hrqBRBNpFc/8eVaoaA6S+6GlbrF2jju0VJIEFnkoaqkZ14HUTE16i1g/8La34blCa
         IispT1OWkLNGFO6BPlxSHoYEyubgQpgLwXCQHVVRyOawRWNAFt1M5zVim5CbTtmwNXX7
         1nb+q+6Wam20ESgKQsDee+IilAawZft+oZApLZcpSy8fKCBxrNB/ubshRRDlxLzMKGmO
         FD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=IvnDskQJANuLQ1Pn7l1TmXAAMajXPjDT8vWcyh/XpmU=;
        b=oo1TO8guaPTAW+TpFUVcNhq3r6u3S2N1mXF+1gVX5sVyN3gFvK78PvoH8R8Hxz28Z1
         h4kyAu3ZCDN9eN+Z9jmWXJwG5UYMp5Key/kFzoDXOHh/p9XyeMdz0aExJhtmyU1feiR3
         u5T0rw/WBGPyMJhNkBQoqR4OtW2eIvqf66nNMDxyX2W6rmkktdV+bnnhPAcb1C0sfYvN
         11yGlmeRUYNgQooCG9HXvyE8zr23OM8A0UrtjAgG9PF0sgS2vazI3GP0qa6Em7Z07zKK
         CdRgvl4RTLeR8w2hMH9Vwh9RA0pXExXGqubQdVnWQfEef2AR2HyKqksU3buhW3Js4OSt
         P85w==
X-Gm-Message-State: APjAAAVaN+Xbk2Vw7mS32ic7T2dgV+ApJTTabGqdV9oHNi3dPwgGdaJS
        Xq5SWiMftVTTzLOZNd+3zEphbmtlx3w=
X-Google-Smtp-Source: APXvYqzu1B6DaFQ6YtDFilNWzwU62bbldfumKwkDWypKJe0Vvy6rAikoX2mOx7QuRd6Xew1uSVd9kV0JRLw=
X-Received: by 2002:a0c:9289:: with SMTP id b9mr155958qvb.211.1567644802199;
 Wed, 04 Sep 2019 17:53:22 -0700 (PDT)
Date:   Wed,  4 Sep 2019 17:53:13 -0700
Message-Id: <20190905005313.126823-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [RFC] Add critical process prctl
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A task with CAP_SYS_ADMIN can mark itself PR_SET_TASK_CRITICAL,
meaning that if the task ever exits, the kernel panics. This facility
is intended for use by low-level core system processes that cannot
gracefully restart without a reboot. This prctl allows these processes
to ensure that the system restarts when they die regardless of whether
the rest of userspace is operational.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 include/linux/sched.h      |  5 +++++
 include/uapi/linux/prctl.h |  5 +++++
 kernel/exit.c              |  2 ++
 kernel/sys.c               | 19 +++++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..29420b9ebb63 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1526,6 +1526,7 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
 #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
+#define PFA_CRITICAL                    8       /* Panic system if process exits */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1568,6 +1569,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
 TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 
+TASK_PFA_TEST(CRITICAL, critical)
+TASK_PFA_SET(CRITICAL, critical)
+TASK_PFA_CLEAR(CRITICAL, critical)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 094bb03b9cc2..4964723bbd47 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -229,4 +229,9 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+/* Per-task criticality control */
+#define PR_SET_TASK_CRITICAL 55
+#define PR_CRITICAL_NOT_CRITICAL 0
+#define PR_CRITICAL_CRITICAL 1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..9b3d3411d935 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -788,6 +788,8 @@ void __noreturn do_exit(long code)
 		panic("Aiee, killing interrupt handler!");
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
+	if (unlikely(task_critical(tsk)))
+		panic("Critical task died!");
 
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304c29fe..097e05ebaf94 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2269,6 +2269,20 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 	return -EINVAL;
 }
 
+int task_do_set_critical(struct task_struct *t, unsigned long opt)
+{
+	if (opt != PR_CRITICAL_NOT_CRITICAL &&
+	    opt != PR_CRITICAL_CRITICAL)
+		return -EINVAL;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (opt == PR_CRITICAL_NOT_CRITICAL)
+		task_clear_critical(t);
+	else
+		task_set_critical(t);
+	return 0;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2492,6 +2506,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
+	case PR_SET_TASK_CRITICAL:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = task_do_set_critical(me, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.23.0.187.g17f5b7556c-goog

