Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC9E66E
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfD2P3e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 11:29:34 -0400
Received: from mail.efficios.com ([167.114.142.138]:57176 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfD2P3d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 11:29:33 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D4FB11C1D72;
        Mon, 29 Apr 2019 11:29:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Cc5FUPImg6Ue; Mon, 29 Apr 2019 11:29:32 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A7D411C1D44;
        Mon, 29 Apr 2019 11:29:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A7D411C1D44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551769;
        bh=3OJVvuE91UydmNNlW0wPtWvnsQUMUL+fIt4xHI3hrjs=;
        h=From:To:Date:Message-Id;
        b=st1gJWzchsZUV401Ru3hpBA6BgoKDDlhoio3glMB5OS0BxbE7aibNvd4I8/X04VNJ
         /QuHUylKMkRX6q53b/fDI8H3GFUxh2rp7cB3AqAYDicNKqEBRi/+a41F6C5M0wIcDK
         upYfouBA+mwPkX8smn+gYNi5CjFqeRBLlFoYzlwUAzitidAqFGVgP5C0NFz4B1IozQ
         6NmrMD+9ufYx1d2TIDmP7C/0a9Mrxt1cPpEtc1h8NyGSx3QMwnOFcw9YNY/5ujkprc
         OGkOqcS3Q3/bLyrXd+QY19UjwfVlioMEEJs8bkm1MO2u1kJXnKkAtbCJZz8CEQ6h0B
         DghiIDcglSeiQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id cTFCtR1OaPtT; Mon, 29 Apr 2019 11:29:29 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id DE3B91C1D09;
        Mon, 29 Apr 2019 11:29:27 -0400 (EDT)
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
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH for 5.2 11/12] rseq/selftests: mips: use break instruction for RSEQ_SIG
Date:   Mon, 29 Apr 2019 11:28:02 -0400
Message-Id: <20190429152803.7719-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Use break as guard instruction for the restartable sequence abort
handler.

Previously, the chosen signature was simply data, based on the
assumption that it could always sit in a literal pool. However,
some compilation environments favor disabling literal pool. Therefore,
ensure the signature is a valid uncommon trap instruction.

Suggested-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul Burton <paul.burton@mips.com>
CC: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq-mips.h | 34 +++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index fe3eabcdcbe5..e989e7c14b09 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -7,7 +7,39 @@
  * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the break instruction. The instruction pattern is:
+ *
+ * On MIPS:
+ *	0350000d        break     0x350
+ *
+ * On nanoMIPS:
+ *      00100350        break     0x350
+ *
+ * On microMIPS:
+ *      0000d407        break     0x350
+ *
+ * For nanoMIPS32 and microMIPS, the instruction stream is encoded as 16-bit
+ * halfwords, so the signature halfwords need to be swapped accordingly for
+ * little-endian.
+ */
+#if defined(__nanomips__)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG	0x03500010
+# else
+#  define RSEQ_SIG	0x00100350
+# endif
+#elif defined(__mips_micromips)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG	0xd4070000
+# else
+#  define RSEQ_SIG	0x0000d407
+# endif
+#elif defined(__mips__)
+# define RSEQ_SIG	0x0350000d
+#else
+/* Unknown MIPS architecture. */
+#endif
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("sync" ::: "memory")
 #define rseq_smp_rmb()	rseq_smp_mb()
-- 
2.11.0

