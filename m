Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467C3E67E
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfD2PaM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 11:30:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:56952 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfD2P3a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 11:29:30 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 292111C1D35;
        Mon, 29 Apr 2019 11:29:29 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 8AVwtYizlX-S; Mon, 29 Apr 2019 11:29:28 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 689991C1D01;
        Mon, 29 Apr 2019 11:29:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 689991C1D01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551767;
        bh=WV0aLN7pvahQr5sToC9GKACvUzvM6D05m4T4cPR6y/0=;
        h=From:To:Date:Message-Id;
        b=gY7mBdv9f6s9a/ZyoMWVDFgWTDXXpMiFCKiVYEr8gmVxq0tmgojgxoWL67IGs7Zy+
         4oLIR3pHi8fbyLBcz0op+m6na4uM15pdLr6GW1WD7nVcg8PfC8Qg6mhqUex4JaJCqH
         RgAsbvPUuNKefhnJ50MZ+9K31XE9qtA7LC2wjWRTxvkvbNknsbt3CgGkcO3S4DcJEO
         xMHaLGJ/7fWx2tqh8BkkfkAkPo0HwcuTvarup2pUQkRIO2TkxL0qNcpOjoRMt2VZ5O
         hipJOecYHnjskj7ON5/5eZ572TyX5t9lU7lMkIamG0B3iOiygUuAc0s/FIaEcSyv/r
         nigW6X6NdsjuQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 3PxAdUG1kt-c; Mon, 29 Apr 2019 11:29:27 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id ADAD01C1CE5;
        Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
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
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH for 5.2 07/12] rseq/selftests: s390: use trap4 for RSEQ_SIG
Date:   Mon, 29 Apr 2019 11:27:58 -0400
Message-Id: <20190429152803.7719-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Use trap4 as the guard instruction for the restartable sequence abort
handler.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-s390.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 7c4f3a70b6c7..1d05c5187ae6 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
+ * access-register mode nor the linkage stack this instruction will always
+ * cause a special-operation exception (the trap-enabled bit in the DUCT
+ * is and will stay 0). The instruction pattern is
+ *	b2 ff 0f ff	trap4   4095(%r0)
+ */
+#define RSEQ_SIG	0xB2FF0FFF
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("bcr 15,0" ::: "memory")
 #define rseq_smp_rmb()	rseq_smp_mb()
-- 
2.11.0

