Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3198221608B
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGFUto (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 16:49:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:56996 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGFUto (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 16:49:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 296022DCDAB;
        Mon,  6 Jul 2020 16:49:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LAB-r-SSw6q0; Mon,  6 Jul 2020 16:49:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AFAEB2DCC52;
        Mon,  6 Jul 2020 16:49:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AFAEB2DCC52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594068582;
        bh=CJAD5RnNyYUd/l27WZZ2oB80+Gg+2mREgkdjG0cNpBs=;
        h=From:To:Date:Message-Id;
        b=rnnFS127qZ28sQaXb/1/SvbfzBXq5w5JFNxdAwM6zryF0sB20cyIbefZqCZ85Vahj
         W2sgETdv/GPMnCm/q5RWI5ofKHkyth2JAG8ZBAeROr3Ta0tekIg3CHPpFz330Q44tn
         J98z4QD5RhKGxkY77D58HMgHdRyWkIUqP3y4iireYQJjSlRNil1zu8aH5ETpcYVv1N
         UXiMGbBsATnWq4z6vgpmJ20bXF5YYFNKZrajjnGg0MukLn1SZ5TBFi3XA2fr7/siGB
         YBb+Jb8VVEeAEzR3hLwtQE9VZT16KvBnDZ7UaPZ0VJ6ez5Otg+uwVAVyT7kisg9MXS
         NDg0cl75enizQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2d6TKKdaLeys; Mon,  6 Jul 2020 16:49:42 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id B7D712DCE20;
        Mon,  6 Jul 2020 16:49:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Subject: [RFC PATCH for 5.8 2/4] rseq: Introduce RSEQ_FLAG_REGISTER
Date:   Mon,  6 Jul 2020 16:49:11 -0400
Message-Id: <20200706204913.20347-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Introduce RSEQ_FLAG_REGISTER with the same behavior as the flag value
"0". The main advantage of introducing this flag as a non-zero (1 << 1)
value is that it can be combined with other flags to register and check
for features with a single system call. Considering that this system
call needs to be performed for each new thread in glibc, minimize the
amount of overhead required.

This is needed for introducing a new RSEQ_FLAG_RELIABLE_CPU_ID flag in a
later change.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Paul Turner <pjt@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Neel Natu <neelnatu@google.com>
Cc: linux-api@vger.kernel.org
---
 include/uapi/linux/rseq.h | 10 ++++-
 kernel/rseq.c             | 77 +++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 9a402fdb60e9..3b5fba25461a 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -18,8 +18,16 @@ enum rseq_cpu_id_state {
 	RSEQ_CPU_ID_REGISTRATION_FAILED		= -2,
 };
 
+/*
+ * RSEQ_FLAG_UNREGISTER:       Unregister rseq ABI for caller thread.
+ * RSEQ_FLAG_REGISTER:         Register rseq ABI for caller thread.
+ *
+ * Flag value 0 has the same behavior as RSEQ_FLAG_REGISTER, but cannot be
+ * combined with other flags. This behavior is kept for backward compatibility.
+ */
 enum rseq_flags {
-	RSEQ_FLAG_UNREGISTER = (1 << 0),
+	RSEQ_FLAG_UNREGISTER			= (1 << 0),
+	RSEQ_FLAG_REGISTER			= (1 << 1),
 };
 
 enum rseq_cs_flags_bit {
diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937..47ce221cd6f9 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -309,9 +309,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 {
 	int ret;
 
-	if (flags & RSEQ_FLAG_UNREGISTER) {
-		if (flags & ~RSEQ_FLAG_UNREGISTER)
-			return -EINVAL;
+	/*
+	 * Flag value 0 has the same behavior as RSEQ_FLAG_REGISTER, but cannot
+	 * be combined with other flags. This behavior is kept for backward
+	 * compatibility.
+	 */
+	if (!flags)
+		flags = RSEQ_FLAG_REGISTER;
+
+	switch (flags) {
+	case RSEQ_FLAG_UNREGISTER:
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
@@ -324,43 +331,43 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return ret;
 		current->rseq = NULL;
 		current->rseq_sig = 0;
-		return 0;
-	}
-
-	if (unlikely(flags))
-		return -EINVAL;
+		break;
+	case RSEQ_FLAG_REGISTER:
+		if (current->rseq) {
+			/*
+			 * If rseq is already registered, check whether
+			 * the provided address differs from the prior
+			 * one.
+			 */
+			if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+				return -EINVAL;
+			if (current->rseq_sig != sig)
+				return -EPERM;
+			/* Already registered. */
+			return -EBUSY;
+		}
 
-	if (current->rseq) {
 		/*
-		 * If rseq is already registered, check whether
-		 * the provided address differs from the prior
-		 * one.
+		 * If there was no rseq previously registered,
+		 * ensure the provided rseq is properly aligned and valid.
 		 */
-		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+		if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
+		    rseq_len != sizeof(*rseq))
 			return -EINVAL;
-		if (current->rseq_sig != sig)
-			return -EPERM;
-		/* Already registered. */
-		return -EBUSY;
-	}
-
-	/*
-	 * If there was no rseq previously registered,
-	 * ensure the provided rseq is properly aligned and valid.
-	 */
-	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
-	    rseq_len != sizeof(*rseq))
+		if (!access_ok(rseq, rseq_len))
+			return -EFAULT;
+		current->rseq = rseq;
+		current->rseq_sig = sig;
+		/*
+		 * If rseq was previously inactive, and has just been
+		 * registered, ensure the cpu_id_start and cpu_id fields
+		 * are updated before returning to user-space.
+		 */
+		rseq_set_notify_resume(current);
+		break;
+	default:
 		return -EINVAL;
-	if (!access_ok(rseq, rseq_len))
-		return -EFAULT;
-	current->rseq = rseq;
-	current->rseq_sig = sig;
-	/*
-	 * If rseq was previously inactive, and has just been
-	 * registered, ensure the cpu_id_start and cpu_id fields
-	 * are updated before returning to user-space.
-	 */
-	rseq_set_notify_resume(current);
+	}
 
 	return 0;
 }
-- 
2.17.1

