Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1913BAF3A9
	for <lists+linux-api@lfdr.de>; Wed, 11 Sep 2019 02:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfIKA1z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Sep 2019 20:27:55 -0400
Received: from mail.efficios.com ([167.114.142.138]:59988 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfIKA1z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Sep 2019 20:27:55 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7F2ECBD667;
        Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Jlve_KhKvART; Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 18080BD650;
        Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 18080BD650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568161673;
        bh=W4jMXPsnJkokBAz0RvMF3m+o1BZRSxX2/fcbTb/hjTY=;
        h=From:To:Date:Message-Id;
        b=EdAea2NHM8iG4NEj2pD5HgRVH9sHCV8p3r9eu2XzQuVL9dFxTWk6q4U1T/uDP+E+S
         9Ikb1IpDSH6CtyNS90cGcu9I7QYGwHCy2/S+Yd9DWT3MG5U58MHsE2gs/tgLd2C6b0
         Hio1BL7JIz3snZezuvHLZTNDqdnYaSBX/ODfBzv4fRhsjApUfWvvvd3tTYHkD3ukYk
         NTqaU3rCm7QXDHqxOQJkoz0YPaakbQavY//bZbqpsJpd33T9mUsU1t4Tg3t1ECxIdW
         8/3JYXm/HKxuP0facH/GSgsacFP6bsP0UMzTgK/XiRmtJd0qoknaEnImMpdHXZ6lpa
         rSzQ63byoMZnQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Bd4J1vp88lc5; Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 28F47BD63E;
        Tue, 10 Sep 2019 20:27:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-api@vger.kernel.org
Subject: [RFC PATCH 3/4] rseq: Introduce unreg_clone_flags
Date:   Tue, 10 Sep 2019 20:27:43 -0400
Message-Id: <20190911002744.8690-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911002744.8690-1-mathieu.desnoyers@efficios.com>
References: <20190911002744.8690-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Considering that some custom libc could possibly choose not to use
CLONE_SETTLS, we should allow the libc to override the choice of clone
flags meant to unregister rseq. This is a policy decision which should
not be made by the kernel.

Therefore, introduce a new RSEQ_FLAG_UNREG_CLONE_FLAGS, which makes the
rseq system call expect an additional 5th argument: a mask of all the
clone flags which may each ensure rseq is unregistered upon clone.

So even if CLONE_SETTLS is eventually replaced by some other flag in the
future, the libc will be able to adapt and pass this new flag upon rseq
registration as well.

The default when RSEQ_FLAG_UNREG_CLONE_FLAGS is unset is to unregister
rseq on clone with CLONE_SETTLS.

Suggested-by: "H . Peter Anvin" <hpa@zytor.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Paul Turner <pjt@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-api@vger.kernel.org
---
 include/linux/sched.h     |  9 +++++++--
 include/linux/syscalls.h  |  2 +-
 include/uapi/linux/rseq.h |  1 +
 kernel/rseq.c             | 14 +++++++++++---
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index deb4154dbf11..c8faa6f8493d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1138,6 +1138,7 @@ struct task_struct {
 	 * with respect to preemption.
 	 */
 	unsigned long rseq_event_mask;
+	int rseq_unreg_clone_flags;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
@@ -1919,18 +1920,21 @@ static inline void rseq_migrate(struct task_struct *t)
 
 /*
  * If parent process has a registered restartable sequences area, the
- * child inherits. Unregister rseq for a clone with CLONE_TLS set.
+ * child inherits, except if it has been required to be explicitly
+ * unregistered when any of the rseq_unreg_clone_flags are passed to clone.
  */
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
-	if (clone_flags & CLONE_TLS) {
+	if (clone_flags & t->rseq_unreg_clone_flags) {
 		t->rseq = NULL;
 		t->rseq_sig = 0;
 		t->rseq_event_mask = 0;
+		t->rseq_unreg_clone_flags = 0;
 	} else {
 		t->rseq = current->rseq;
 		t->rseq_sig = current->rseq_sig;
 		t->rseq_event_mask = current->rseq_event_mask;
+		t->rseq_unreg_clone_flags = current->rseq_unreg_clone_flags;
 	}
 }
 
@@ -1939,6 +1943,7 @@ static inline void rseq_execve(struct task_struct *t)
 	t->rseq = NULL;
 	t->rseq_sig = 0;
 	t->rseq_event_mask = 0;
+	t->rseq_unreg_clone_flags = 0;
 }
 
 #else
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 88145da7d140..6a242cfcc360 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -987,7 +987,7 @@ asmlinkage long sys_pkey_free(int pkey);
 asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
-			 int flags, uint32_t sig);
+			 int flags, uint32_t sig, int unreg_clone_flags);
 asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
 asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
 			       int to_dfd, const char __user *to_path,
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 9a402fdb60e9..d71e3c6b7fdb 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -20,6 +20,7 @@ enum rseq_cpu_id_state {
 
 enum rseq_flags {
 	RSEQ_FLAG_UNREGISTER = (1 << 0),
+	RSEQ_FLAG_UNREG_CLONE_FLAGS = (1 << 1),
 };
 
 enum rseq_cs_flags_bit {
diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937..c59b8d3dc275 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -304,8 +304,8 @@ void rseq_syscall(struct pt_regs *regs)
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
-SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
-		int, flags, u32, sig)
+SYSCALL_DEFINE5(rseq, struct rseq __user *, rseq, u32, rseq_len,
+		int, flags, u32, sig, int, unreg_clone_flags)
 {
 	int ret;
 
@@ -324,12 +324,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return ret;
 		current->rseq = NULL;
 		current->rseq_sig = 0;
+		current->rseq_unreg_clone_flags = 0;
 		return 0;
 	}
 
-	if (unlikely(flags))
+	if (unlikely(flags & ~RSEQ_FLAG_UNREG_CLONE_FLAGS))
 		return -EINVAL;
 
+	if (!(flags & RSEQ_FLAG_UNREG_CLONE_FLAGS))
+		unreg_clone_flags = CLONE_SETTLS;
+
 	if (current->rseq) {
 		/*
 		 * If rseq is already registered, check whether
@@ -338,6 +342,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 */
 		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
 			return -EINVAL;
+		if ((flags & RSEQ_FLAG_UNREG_CLONE_FLAGS) &&
+		    current->rseq_unreg_clone_flags != unreg_clone_flags)
+			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
 		/* Already registered. */
@@ -355,6 +362,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EFAULT;
 	current->rseq = rseq;
 	current->rseq_sig = sig;
+	current->rseq_unreg_clone_flags = unreg_clone_flags;
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
-- 
2.17.1

