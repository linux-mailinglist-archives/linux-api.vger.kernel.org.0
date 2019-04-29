Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD3E66D
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfD2P3b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 11:29:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:56952 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfD2P31 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 11:29:27 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D89A31C1CEA;
        Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Dih3OQRmIuKp; Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 159A21C1CCD;
        Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 159A21C1CCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551765;
        bh=7bREYjl8Np1pAd/Fde//VKkoNKJfwTpSdwiHFLstO2Y=;
        h=From:To:Date:Message-Id;
        b=qdsdefdtcms3xo87H8y+IjvGDUQjo00yZbwHg2fFWlmSiOpPiYd7Yr+Fbw671on4T
         YIF7yjLKHsj8Oj2FQG1xQ9E0mw5S7mw0KjVzgOcRQWyVwrau+KOVERiaRz3dFDtK3e
         LeGmu9rldeFUl7zSmAQjy1MjlSezw2pK7qQdYeYT+W7znWKBUNYVAamU9ekt8BlO1P
         9bv9v4Sq/Dhe2x8Vkk6NK3vsZX+19xwF79l728i4Ak4wEhVVKeoYVOucrJioaf4Zv6
         ek3yglNSjYNoKMDeuOhOPBSJonAdf9al4rB9u1Mw4RTP3YTcHeFJaTgvYW/rK2tyqA
         XYsJr9ypbkHUg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id A3PNBTsTlWyu; Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id C10091C1C9E;
        Mon, 29 Apr 2019 11:29:23 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [PATCH for 5.2 04/12] rseq/selftests: Use __rseq_handled symbol to coexist with glibc
Date:   Mon, 29 Apr 2019 11:27:55 -0400
Message-Id: <20190429152803.7719-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to integrate rseq into user-space applications, expose a
__rseq_handled symbol so many rseq users can be linked into the same
application (e.g. librseq and glibc).

The __rseq_refcount TLS variable is static to the librseq library. It
ensures that rseq syscall registration/unregistration happens only for
the most early/late caller to rseq_{,un}register_current_thread for each
thread, thus ensuring that rseq is registered across the lifetime of all
rseq users for a given thread.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
CC: Joseph Myers <joseph@codesourcery.com>
CC: Szabolcs Nagy <szabolcs.nagy@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ben Maurer <bmaurer@fb.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Dave Watson <davejwatson@fb.com>
CC: Paul Turner <pjt@google.com>
CC: linux-api@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq.c | 55 +++++++++++++++++++++++++++++++------
 tools/testing/selftests/rseq/rseq.h |  1 +
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4847e97ed049..7159eb777fd3 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -25,18 +25,27 @@
 #include <syscall.h>
 #include <assert.h>
 #include <signal.h>
+#include <limits.h>
 
 #include "rseq.h"
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
-__attribute__((tls_model("initial-exec"))) __thread
-volatile struct rseq __rseq_abi = {
+__thread volatile struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
 
-static __attribute__((tls_model("initial-exec"))) __thread
-volatile int refcount;
+/*
+ * Shared with other libraries. This library may take rseq ownership if it is
+ * still 0 when executing the library constructor. Set to 1 by library
+ * constructor when handling rseq. Set to 0 in destructor if handling rseq.
+ */
+int __rseq_handled;
+
+/* Whether this library have ownership of rseq registration. */
+static int rseq_ownership;
+
+static __thread volatile uint32_t __rseq_refcount;
 
 static void signal_off_save(sigset_t *oldset)
 {
@@ -69,8 +78,14 @@ int rseq_register_current_thread(void)
 	int rc, ret = 0;
 	sigset_t oldset;
 
+	if (!rseq_ownership)
+		return 0;
 	signal_off_save(&oldset);
-	if (refcount++)
+	if (__rseq_refcount == UINT_MAX) {
+		ret = -1;
+		goto end;
+	}
+	if (__rseq_refcount++)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
 	if (!rc) {
@@ -78,9 +93,9 @@ int rseq_register_current_thread(void)
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = -2;
+		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
 	ret = -1;
-	refcount--;
+	__rseq_refcount--;
 end:
 	signal_restore(oldset);
 	return ret;
@@ -91,13 +106,20 @@ int rseq_unregister_current_thread(void)
 	int rc, ret = 0;
 	sigset_t oldset;
 
+	if (!rseq_ownership)
+		return 0;
 	signal_off_save(&oldset);
-	if (--refcount)
+	if (!__rseq_refcount) {
+		ret = -1;
+		goto end;
+	}
+	if (--__rseq_refcount)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
 		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
 	if (!rc)
 		goto end;
+	__rseq_refcount = 1;
 	ret = -1;
 end:
 	signal_restore(oldset);
@@ -115,3 +137,20 @@ int32_t rseq_fallback_current_cpu(void)
 	}
 	return cpu;
 }
+
+void __attribute__((constructor)) rseq_init(void)
+{
+	/* Check whether rseq is handled by another library. */
+	if (__rseq_handled)
+		return;
+	__rseq_handled = 1;
+	rseq_ownership = 1;
+}
+
+void __attribute__((destructor)) rseq_fini(void)
+{
+	if (!rseq_ownership)
+		return;
+	__rseq_handled = 0;
+	rseq_ownership = 0;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index c72eb70f9b52..26348e2c44f3 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -45,6 +45,7 @@
 #endif
 
 extern __thread volatile struct rseq __rseq_abi;
+extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
 #define rseq_unlikely(x)	__builtin_expect(!!(x), 0)
-- 
2.11.0

