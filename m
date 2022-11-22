Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB74634877
	for <lists+linux-api@lfdr.de>; Tue, 22 Nov 2022 21:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiKVUkB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Nov 2022 15:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiKVUjw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Nov 2022 15:39:52 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A815E697D0;
        Tue, 22 Nov 2022 12:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149588;
        bh=BGYkK/0Xg+VdEtmPnWZve4U8TBZgFuP3LSZBFJwxWyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptafjNlds1C4fwjC7eM2ZmFjeX6CEGe0rEUvJk25KltJoTxcLbPrnKC/8ngtC3X35
         XAnS3DMpst9cKDn+Mz9gznOahEjp9bJ4JY5aHkG5G6Y1ZfV7QtxbqLuSkGraxAiPpj
         Vp7FlI4gaM4DMAq+44WeQDX1ToDGqQCuGMEm7WxvWRmIm0EROvIzos3xDr1McPSf18
         eFpMhbdUbVFHsQAga1RErr3ToVt3gKEGNSR4SK0YSACqdvrvGOLQc7GzFLIwv1SZUP
         3zcEJ2R8fA1I42EgbBcU9hKPMGwh3GVAooF/5LVC11QEyhW03JLZfZR4ttOBOU2J3o
         Oeepxi6CYzzzA==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2W60ZVzXLQ;
        Tue, 22 Nov 2022 15:39:47 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 09/30] selftests/rseq: Remove RSEQ_SKIP_FASTPATH code
Date:   Tue, 22 Nov 2022 15:39:11 -0500
Message-Id: <20221122203932.231377-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This code is not currently build by the test Makefile, adds complexity,
and is not overall useful considering that the abort handling loops to
retry the fast-path.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/param_test.c |  4 --
 tools/testing/selftests/rseq/rseq-arm.h   |  6 ---
 tools/testing/selftests/rseq/rseq-arm64.h |  6 ---
 tools/testing/selftests/rseq/rseq-mips.h  |  6 ---
 tools/testing/selftests/rseq/rseq-ppc.h   |  6 ---
 tools/testing/selftests/rseq/rseq-riscv.h |  6 ---
 tools/testing/selftests/rseq/rseq-s390.h  |  5 --
 tools/testing/selftests/rseq/rseq-skip.h  | 65 -----------------------
 tools/testing/selftests/rseq/rseq-x86.h   | 12 -----
 9 files changed, 116 deletions(-)
 delete mode 100644 tools/testing/selftests/rseq/rseq-skip.h

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index ef29bc16f358..9869369a8607 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -38,11 +38,7 @@ static int opt_yield, opt_signal, opt_sleep,
 		opt_disable_rseq, opt_threads = 200,
 		opt_disable_mod = 0, opt_test = 's', opt_mb = 0;
 
-#ifndef RSEQ_SKIP_FASTPATH
 static long long opt_reps = 5000;
-#else
-static long long opt_reps = 100;
-#endif
 
 static __thread __attribute__((tls_model("initial-exec")))
 unsigned int signals_delivered;
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 893a11eca9d5..7445107f842b 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -79,10 +79,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
 				post_commit_offset, abort_ip)		\
 		".pushsection __rseq_cs, \"aw\"\n\t"			\
@@ -823,5 +819,3 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	rseq_bug("expected value comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index cbe190a4d005..49c387fcd868 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -85,10 +85,6 @@ do {										\
 	}									\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #define RSEQ_ASM_TMP_REG32	"w15"
 #define RSEQ_ASM_TMP_REG	"x15"
 #define RSEQ_ASM_TMP_REG_2	"x14"
@@ -691,5 +687,3 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	rseq_bug("expected value comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 878739fae2fd..dd199952d649 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -60,10 +60,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #if _MIPS_SZLONG == 64
 # define LONG			".dword"
 # define LONG_LA		"dla"
@@ -773,5 +769,3 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	rseq_bug("expected value comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index bab8e0b9fb11..f82d95c1bb3f 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -36,10 +36,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 /*
  * The __rseq_cs_ptr_array and __rseq_cs sections can be used by debuggers to
  * better handle single-stepping through the restartable critical sections.
@@ -787,5 +783,3 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	rseq_bug("expected value comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 3a391c9bf468..b16d943a63e1 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -49,10 +49,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*(p), v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
 				post_commit_offset, abort_ip)		\
 	".pushsection	__rseq_cs, \"aw\"\n"				\
@@ -673,5 +669,3 @@ int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 4e6dc5f0cb42..4d3286453bbf 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -28,10 +28,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #ifdef __s390x__
 
 #define LONG_L			"lg"
@@ -607,4 +603,3 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	return rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
 					    newv, cpu);
 }
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-skip.h b/tools/testing/selftests/rseq/rseq-skip.h
deleted file mode 100644
index 7b53dac1fcdd..000000000000
--- a/tools/testing/selftests/rseq/rseq-skip.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
-/*
- * rseq-skip.h
- *
- * (C) Copyright 2017-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- */
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       long voffp, intptr_t *load, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
-				 intptr_t *v2, intptr_t newv2,
-				 intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	return -1;
-}
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index bd01dc41ca13..e148dfb2f68a 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -50,10 +50,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
 				start_ip, post_commit_offset, abort_ip)	\
 		".pushsection __rseq_cs, \"aw\"\n\t"			\
@@ -629,8 +625,6 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 					    newv, cpu);
 }
 
-#endif /* !RSEQ_SKIP_FASTPATH */
-
 #elif defined(__i386__)
 
 #define RSEQ_ASM_TP_SEGMENT	%%gs
@@ -657,10 +651,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 /*
  * Use eax as scratch register and take memory operands as input to
  * lessen register pressure. Especially needed when compiling in O0.
@@ -1360,6 +1350,4 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 #endif
 }
 
-#endif /* !RSEQ_SKIP_FASTPATH */
-
 #endif
-- 
2.25.1

