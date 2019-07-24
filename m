Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5B07321A
	for <lists+linux-api@lfdr.de>; Wed, 24 Jul 2019 16:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfGXOsA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 10:48:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36518 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfGXOsA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 10:48:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so21351919pgm.3
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBTl4EOXHZ71oG8dRPzQKN+4olExLO4T099FLNi+kAE=;
        b=VxeftMgEfyaGpnYIggVLKpk5Jy6dCbINbsRb875Jknt+NYx4nXnox39mXMwRz1hznx
         aNgyalVejrzh0SdQwZA1ehK5f2Ti/vwx2y+45Sgo3/vS7u1KaR57h8ilowcTEITJ7KK7
         hhCCj3PRwvABi9Qn1vzWZD7noBehNAzjRoahnT2/EsgoTN/oG+BrAB5NOyT/Do/Ll2u6
         cX6MyqUdnHW20LKy2/gwC3uBZN8mxe8/vw2p75JxjAuF0DUFbkrWCrGYmrbgPqJdY1Uq
         iHkQNa+Z8mL11k24eKBmiLVmiZUmjCMDEV3Vma7fDNU/Kp6pk5PnFKGnOdWpVSlzfOqb
         nhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBTl4EOXHZ71oG8dRPzQKN+4olExLO4T099FLNi+kAE=;
        b=hywlgPLscBaxjkNOdypU6X43OvHAqLBw8sB+Odk7/dNuqg5HYCrlLSJNhtYpHsSVsd
         sjw2abE1azoeVermYJh6d8gIsJ6BteamA7wJl1RASqSHyaxrdLIdcnrhF/qcR9cg6Q99
         pnv0FPSrnCqFCPiQpu6l/WZ3tYlGBxF7n1n96FaOl8Rq9N2YI5JJL0iyCj9lNFLu13zd
         tBnI0fQU/gOGbvOB2+luE1WaP0D1H8pw2UtsoS85t2i2oSZiGP6ECHP216xkQvk6804t
         srKp05v6AHSFVVkrvosB4nI+oQ3xg+YF1fUiUR038zhnSv1cYrSIH2O/mEs57vAZztJs
         lkIw==
X-Gm-Message-State: APjAAAWVxg3BsUatDWwSFFXjkq6QIToMB37G1i33WYbhDBF86ZLoyqOR
        Bldn3cfE4H8CECfI519Fq5o=
X-Google-Smtp-Source: APXvYqz+Enq2/NcPy88WMMAnNrBgBpGN4SxupV5kpEOM4+HykjBi7Trcfsyp6kBKb/Ez904IoMQBXQ==
X-Received: by 2002:a63:2004:: with SMTP id g4mr78265918pgg.97.1563979679360;
        Wed, 24 Jul 2019 07:47:59 -0700 (PDT)
Received: from localhost.localdomain ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id g6sm41125644pgh.64.2019.07.24.07.47.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:47:58 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Date:   Wed, 24 Jul 2019 16:46:50 +0200
Message-Id: <20190724144651.28272-5-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724144651.28272-1-christian@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

If CLONE_WAIT_PID is set the newly created process will not be
considered by process wait requests that wait generically on children
such as:

	syscall(__NR_wait4, -1, wstatus, options, rusage)
	syscall(__NR_waitpid, -1, wstatus, options)
	syscall(__NR_waitid, P_ALL, -1, siginfo, options, rusage)
	syscall(__NR_waitid, P_PGID, -1, siginfo, options, rusage)
	syscall(__NR_waitpid, -pid, wstatus, options)
	syscall(__NR_wait4, -pid, wstatus, options, rusage)

A process created with CLONE_WAIT_PID can only be waited upon with a
focussed wait call. This ensures that processes can be reaped even if
all file descriptors referring to it are closed.

/* Usecases */
This feature has been requested in discussions when I presented this
work multiple times. Here are concrete use cases people have:
1. Process managers that would like to use pidfd for all process
   watching needs require this feature.
   A process manager (e.g. PID 1) that needs to reap all children
   assigned to it needs to invoke some form of waitall request as
   outlined above.  This has to be done since the process manager might
   not know about processes that got re-parented to it. Without
   CLONE_WAIT_PID the process manager will end up reaping processes it
   uses pidfds to watch for since they are crucial internal processes.
2. Various libraries want to be able to fork off helper processes
   internally that do not otherwise affect the program they are used in.
   This is currently not possible.
   However, if a process invokes a waitall request the internal
   helper process of the library might get reaped, confusing the library
   which expected it to reap it itself.
   Careful programs will thus generally avoid waitall requests which is
   inefficient.
3. A general class of programs are ones that use event loops (e.g. GLib,
   systemd, and LXC etc.). Such event loops currently call focused wait
   requests iteratively on all processes they are configured to watch to
   avoid waitall request pitfalls.
   This is ugly and inefficient since it cannot be used to watch large
   numbers of file descriptors without paying the O(n) cost on each
   event loop iteration.

/* Prior art */
FreeBSD has a similar concept (cf. [1], [2]). They are currently doing
it the other way around, i.e. by default all procdescs are not visible
in waitall requests. Howver, originally, they allowed procdescs to
appear in waitall and changed it later (cf. [1]).

Currently, CLONE_WAIT_PID can only be used in conjunction with
CLONE_PIDFD since the usecases above only make sense when used in
combination with both.

/* References */
[1]: https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=201054
[2]: https://svnweb.freebsd.org/base/head/sys/kern/kern_exit.c

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-api@vger.kernel.org
---
 include/linux/sched.h      |  1 +
 include/uapi/linux/sched.h |  1 +
 kernel/exit.c              |  3 +++
 kernel/fork.c              | 11 ++++++++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8dc1811487f5..f0166f630a1a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1468,6 +1468,7 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
+#define PF_WAIT_PID		0x20000000	/* This task will not appear in generic wait requests */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index b3105ac1381a..ffb1cac18e4e 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -32,6 +32,7 @@
 #define CLONE_NEWPID		0x20000000	/* New pid namespace */
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
+#define CLONE_WAIT_PID		0x200000000ULL  /* set if process should not appear in generic wait requests */
 
 /*
  * Arguments for the clone3 syscall
diff --git a/kernel/exit.c b/kernel/exit.c
index 8086c76e1959..aa15de1108b2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1019,6 +1019,9 @@ eligible_child(struct wait_opts *wo, bool ptrace, struct task_struct *p)
 	if (!eligible_pid(wo, p))
 		return 0;
 
+	if ((p->flags & PF_WAIT_PID) && (wo->wo_type != PIDTYPE_PID))
+		return 0;
+
 	/*
 	 * Wait for all children (clone and not) if __WALL is set or
 	 * if it is traced by us.
diff --git a/kernel/fork.c b/kernel/fork.c
index baaff6570517..a067f3876e2e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1910,6 +1910,8 @@ static __latent_entropy struct task_struct *copy_process(
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
 	p->flags |= PF_FORKNOEXEC;
+	if (clone_flags & CLONE_WAIT_PID)
+		p->flags |= PF_WAIT_PID;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
@@ -2590,7 +2592,7 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
 	 * All lower bits of the flag word are taken.
 	 * Verify that no other unknown flags are passed along.
 	 */
-	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
+	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_WAIT_PID))
 		return false;
 
 	/*
@@ -2600,6 +2602,13 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
 	if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
 		return false;
 
+	/*
+	 * Currently only allow CLONE_WAIT_PID for processes created as
+	 * pidfds until someone needs this feature for regular pids too.
+	 */
+	if ((kargs->flags & CLONE_WAIT_PID) && !(kargs->flags & CLONE_PIDFD))
+		return false;
+
 	if ((kargs->flags & (CLONE_THREAD | CLONE_PARENT)) &&
 	    kargs->exit_signal)
 		return false;
-- 
2.22.0

