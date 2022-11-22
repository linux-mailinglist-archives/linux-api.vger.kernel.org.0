Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E3634875
	for <lists+linux-api@lfdr.de>; Tue, 22 Nov 2022 21:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiKVUkC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Nov 2022 15:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiKVUjz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Nov 2022 15:39:55 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B06B3A2;
        Tue, 22 Nov 2022 12:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149589;
        bh=s5FLkqjgOOf6yIWKRu/RCMYBBwBDTEIxmomNOmbCqBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0mZ9JNbRYiR7EA39L3eWVsPxblXGTrTw8EVvjXZXsTTFUW5kgW0yO3vlrkaAHnTc
         4c4xu3WMtwGkqIitB38fzQ83T6q10pVL88G+y+HorPXs0xjkB3j/pjUyaPpNaWxbDm
         V+l7BGoqO5FhnFlhpFQ5TuBTW8GLESMLX/CRaCWMI0H/aj372uXZ3TFyKd1Z8lmMw9
         8FiK25g9UsqoBpgZ98GH09wyanyb2nG83YNFPtk5822pYGdeiXseru7XCMvOC1MwFP
         xcVRsPrKoltCQcHbscOcH5DonXxugmPWx/3JkHlEXCMTr7xY6F/SJXwohDiMs+9nLp
         N04JPBqhIp6+A==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2Y4H7DzX52;
        Tue, 22 Nov 2022 15:39:49 -0500 (EST)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 13/30] selftests/rseq: arm64: Template memory ordering and percpu access mode
Date:   Tue, 22 Nov 2022 15:39:15 -0500
Message-Id: <20221122203932.231377-14-mathieu.desnoyers@efficios.com>
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

Introduce a rseq-arm64-bits.h template header which is internally
included to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-mm-cid per-cpu data access.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
Changes since v4:
- Use RSEQ_TEMPLATE_CPU_ID_FIELD.
---
 .../testing/selftests/rseq/rseq-arm64-bits.h  | 392 +++++++++++++
 tools/testing/selftests/rseq/rseq-arm64.h     | 516 +-----------------
 2 files changed, 422 insertions(+), 486 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-arm64-bits.h

diff --git a/tools/testing/selftests/rseq/rseq-arm64-bits.h b/tools/testing/selftests/rseq/rseq-arm64-bits.h
new file mode 100644
index 000000000000..cc7226b1efe1
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-arm64-bits.h
@@ -0,0 +1,392 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-arm64-bits.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2018 - Will Deacon <will.deacon@arm.com>
+ */
+
+#include "rseq-bits-template.h"
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_LOAD(v)
+		RSEQ_ASM_OP_R_STORE(load)
+		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [load]		"Qo" (*load),
+		  [voffp]		"r" (voffp)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_addv)(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		RSEQ_ASM_OP_R_LOAD(v)
+		RSEQ_ASM_OP_R_ADD(count)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
+#endif
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expect]		"r" (expect),
+		  [v2]			"Qo" (*v2),
+		  [expect2]		"r" (expect2),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+#endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+#else
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+#endif
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [expect]		"r" (expect),
+		  [v]			"Qo" (*v),
+		  [newv]		"r" (newv),
+		  [v2]			"Qo" (*v2),
+		  [newv2]		"r" (newv2)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+#else
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+#endif
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [expect]		"r" (expect),
+		  [v]			"Qo" (*v),
+		  [newv]		"r" (newv),
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG, RSEQ_ASM_TMP_REG_2
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 49c387fcd868..85b90977e7e6 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -2,7 +2,7 @@
 /*
  * rseq-arm64.h
  *
- * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  * (C) Copyright 2018 - Will Deacon <will.deacon@arm.com>
  */
 
@@ -200,490 +200,34 @@ do {										\
 	"	cbnz	" RSEQ_ASM_TMP_REG_2 ", 222b\n"				\
 	"333:\n"
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"Qo" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       long voffp, intptr_t *load, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
-#endif
-		RSEQ_ASM_OP_R_LOAD(v)
-		RSEQ_ASM_OP_R_STORE(load)
-		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"Qo" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [load]		"Qo" (*load),
-		  [voffp]		"r" (voffp)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
+/* Per-cpu-id indexing. */
 
-static inline __attribute__((always_inline))
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-#endif
-		RSEQ_ASM_OP_R_LOAD(v)
-		RSEQ_ASM_OP_R_ADD(count)
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"Qo" (*v),
-		  [count]		"r" (count)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
-				 intptr_t *v2, intptr_t newv2,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_STORE(newv2, v2)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [expect]		"r" (expect),
-		  [v]			"Qo" (*v),
-		  [newv]		"r" (newv),
-		  [v2]			"Qo" (*v2),
-		  [newv2]		"r" (newv2)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_STORE(newv2, v2)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [expect]		"r" (expect),
-		  [v]			"Qo" (*v),
-		  [newv]		"r" (newv),
-		  [v2]			"Qo" (*v2),
-		  [newv2]		"r" (newv2)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
-#endif
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"Qo" (*v),
-		  [expect]		"r" (expect),
-		  [v2]			"Qo" (*v2),
-		  [expect2]		"r" (expect2),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2, error3
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-error3:
-	rseq_after_asm_goto();
-	rseq_bug("2nd expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [expect]		"r" (expect),
-		  [v]			"Qo" (*v),
-		  [newv]		"r" (newv),
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG, RSEQ_ASM_TMP_REG_2
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [expect]		"r" (expect),
-		  [v]			"Qo" (*v),
-		  [newv]		"r" (newv),
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG, RSEQ_ASM_TMP_REG_2
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
+
+/* Per-mm-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_CID
+
+/* APIs which are not based on cpu ids. */
+
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
-- 
2.25.1

