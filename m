Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C827903C
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 20:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgIYSZI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 14:25:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:44834 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIYSZI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 14:25:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0FD8F2D0B50;
        Fri, 25 Sep 2020 14:15:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IEbueKNW6RUW; Fri, 25 Sep 2020 14:15:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A28722D0DA9;
        Fri, 25 Sep 2020 14:15:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A28722D0DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601057729;
        bh=0x2DyR7P5kIFKDZl1Me0aWp215/aUuzCV5thSrCYrY4=;
        h=From:To:Date:Message-Id;
        b=YS6m59Y1vjr4kWoyrTIBMj7r4LcCQydtOBFwQ/iaokf18W1/hFwdXCFi302IJKZ+a
         rD2VhVcIl1oE0GheBqjQVSSQSC2vJyucT6YS4RVG4NjIaR2HOh8m6WNLEZKLvPgSBY
         PXSzZqTVSVm6uijtwiLCzJ7guFVIcQECWblXxXiBXPkNsIBE4UsX3Tw1Kds+OR1IkX
         EpM+TxaaLBZyp+MPrDTA8cVDzsOXQzU8K4bn5bql2vIWJABKgm0DgqcRMdPMhoXGhy
         i1z46CaeeSiUYDjErc4yjWDmT+Yg943KhzGrswCXYdDA+xH1GULUaPl0g+YLKRw0Rf
         b9pMy8bpGJheQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8JxkvBFC_Goy; Fri, 25 Sep 2020 14:15:29 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 344132D0EB2;
        Fri, 25 Sep 2020 14:15:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 2/2] selftests/rseq: Adapt x86-64 rseq selftest to rseq KTLS prototype
Date:   Fri, 25 Sep 2020 14:15:18 -0400
Message-Id: <20200925181518.4141-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925181518.4141-1-mathieu.desnoyers@efficios.com>
References: <20200925181518.4141-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The rseq KTLS ABI only requires a single SET_KTLS_OFFSET system call at
library init for the entire thread group. There is no more need for
per-thread registration.

The only architecture-specific part of this patch is
rseq_get_thread_pointer, which is only implemented for x86-64
so far. Other architectures can rely on __builtin_thread_pointer(), but
it is unfortunately unimplemented by gcc for at least x86-32 and x86-64
at the moment.

This is a minimal change to the rseq selftests which keeps using a
fixed-size __rseq_abi TLS inital-exec variable in user-space, but
use the rseq KTLS ABI for registration to the kernel.

In order to facilitate prototyping without requiring an updated glibc,
there is one per-thread operation which is still performed right after
thread creation: RSEQ_FLAG_SET_KTLS_THREAD. It sets the rseq_ktls flag
to true in the current task struct. This is meant to be performed by
glibc through use of clone3 CLONE_RSEQ_KTLS.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: "Florian Weimer <fweimer@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rseq/rseq-x86.h |   8 ++
 tools/testing/selftests/rseq/rseq.c     | 101 ++++++++----------------
 tools/testing/selftests/rseq/rseq.h     |   2 +-
 3 files changed, 44 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index b2da6004fe30..e959d3fb1dea 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -28,6 +28,14 @@
 
 #ifdef __x86_64__
 
+static inline void *rseq_get_thread_pointer(void)
+{
+	void *p;
+
+	asm ("mov %%fs:0, %0" : "=r" (p));
+	return p;
+}
+
 #define rseq_smp_mb()	\
 	__asm__ __volatile__ ("lock; addl $0,-128(%%rsp)" ::: "memory", "cc")
 #define rseq_smp_rmb()	rseq_barrier()
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 7159eb777fd3..9bc5c195a79a 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -31,7 +31,7 @@
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
-__thread volatile struct rseq __rseq_abi = {
+__thread struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
 
@@ -47,83 +47,26 @@ static int rseq_ownership;
 
 static __thread volatile uint32_t __rseq_refcount;
 
-static void signal_off_save(sigset_t *oldset)
-{
-	sigset_t set;
-	int ret;
-
-	sigfillset(&set);
-	ret = pthread_sigmask(SIG_BLOCK, &set, oldset);
-	if (ret)
-		abort();
-}
-
-static void signal_restore(sigset_t oldset)
-{
-	int ret;
-
-	ret = pthread_sigmask(SIG_SETMASK, &oldset, NULL);
-	if (ret)
-		abort();
-}
-
-static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
+static int sys_rseq(void *ptr, uint32_t rseq_len,
 		    int flags, uint32_t sig)
 {
-	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
+	return syscall(__NR_rseq, ptr, rseq_len, flags, sig);
 }
 
 int rseq_register_current_thread(void)
 {
-	int rc, ret = 0;
-	sigset_t oldset;
+	int rc;
 
-	if (!rseq_ownership)
-		return 0;
-	signal_off_save(&oldset);
-	if (__rseq_refcount == UINT_MAX) {
-		ret = -1;
-		goto end;
-	}
-	if (__rseq_refcount++)
-		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
-	if (!rc) {
-		assert(rseq_current_cpu_raw() >= 0);
-		goto end;
+	rc = sys_rseq(NULL, 0, RSEQ_FLAG_SET_KTLS_THREAD, 0);
+	if (rc) {
+		abort();
 	}
-	if (errno != EBUSY)
-		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
-	ret = -1;
-	__rseq_refcount--;
-end:
-	signal_restore(oldset);
-	return ret;
+	return 0;
 }
 
 int rseq_unregister_current_thread(void)
 {
-	int rc, ret = 0;
-	sigset_t oldset;
-
-	if (!rseq_ownership)
-		return 0;
-	signal_off_save(&oldset);
-	if (!__rseq_refcount) {
-		ret = -1;
-		goto end;
-	}
-	if (--__rseq_refcount)
-		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
-		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
-	if (!rc)
-		goto end;
-	__rseq_refcount = 1;
-	ret = -1;
-end:
-	signal_restore(oldset);
-	return ret;
+	return 0;
 }
 
 int32_t rseq_fallback_current_cpu(void)
@@ -140,11 +83,37 @@ int32_t rseq_fallback_current_cpu(void)
 
 void __attribute__((constructor)) rseq_init(void)
 {
+	int rc;
+	long rseq_abi_offset;
+	struct rseq_ktls_layout layout;
+	struct rseq_ktls_offset offset;
+
 	/* Check whether rseq is handled by another library. */
 	if (__rseq_handled)
 		return;
 	__rseq_handled = 1;
 	rseq_ownership = 1;
+
+	rseq_abi_offset = (long) &__rseq_abi - (long) rseq_get_thread_pointer();
+
+	rc = sys_rseq(&layout, 0, RSEQ_FLAG_GET_KTLS_LAYOUT, 0);
+	if (rc) {
+		abort();
+	}
+	if (layout.size > sizeof(struct rseq) || layout.alignment > __alignof__(struct rseq)) {
+		abort();
+	}
+	offset.offset = rseq_abi_offset;
+	rc = sys_rseq(&offset, 0, RSEQ_FLAG_SET_KTLS_OFFSET, 0);
+	if (rc) {
+		abort();
+	}
+	rc = sys_rseq(NULL, 0, RSEQ_FLAG_SET_SIG, RSEQ_SIG);
+	if (rc) {
+		abort();
+	}
+
+	assert(rseq_current_cpu_raw() >= 0);
 }
 
 void __attribute__((destructor)) rseq_fini(void)
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 3f63eb362b92..3c4fad7be4f7 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -43,7 +43,7 @@
 #define RSEQ_INJECT_FAILED
 #endif
 
-extern __thread volatile struct rseq __rseq_abi;
+extern __thread __attribute__((tls_model("initial-exec"))) struct rseq __rseq_abi;
 extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
-- 
2.17.1

