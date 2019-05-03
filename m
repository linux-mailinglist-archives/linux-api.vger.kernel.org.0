Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6B133AD
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2019 20:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfECSm1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 May 2019 14:42:27 -0400
Received: from mail.efficios.com ([167.114.142.138]:47788 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECSm1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 May 2019 14:42:27 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D9FB91DD9D0;
        Fri,  3 May 2019 14:42:25 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id NuLlI6YvXPtK; Fri,  3 May 2019 14:42:25 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7DCDC1DD9C8;
        Fri,  3 May 2019 14:42:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7DCDC1DD9C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556908945;
        bh=8IWdbQsdeFFX/LTHcnOdmakbfhLqku06FAcvzm3c+/g=;
        h=From:To:Date:Message-Id;
        b=jBGUXCdzaOlh55LoRWCf1nvd74iZTCfXIqyCRLatV6CiIYO2bd5WETT0jh0JbNDpV
         FGU/lWvAClugrSmAmIn1ubOSeGow3nQcRzXAxZzI+5lkg6u+TPNQVU9wmPMn4ydXEu
         9xHy3SxjOhF4OXeex817PKFJSrR24/X9EqrSOx08nZ/640VGMfmg3e4uuXLslNFAVu
         9q3lgY1WXCyFD99L6wh9aOF3mOZhCz/CLW+Rnoi50A0wySzvrLFqa0b6Wm4sEwt2ot
         IQLnxCHadMNaLgWEYKvpT+ZKXNWAnN8wjpk3gJyLaMamDX5t98XMcYhj35bNc2jfy2
         eVWWhcNtfCamw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id U5ljua075RoI; Fri,  3 May 2019 14:42:25 -0400 (EDT)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 2703D1DD9B5;
        Fri,  3 May 2019 14:42:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 2/5] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v4)
Date:   Fri,  3 May 2019 14:42:16 -0400
Message-Id: <20190503184219.19266-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When available, use the cpu_id field from __rseq_abi on Linux to
implement sched_getcpu(). Fall-back on the vgetcpu vDSO if unavailable.

Benchmarks:

x86-64: Intel E5-2630 v3@2.40GHz, 16-core, hyperthreading

glibc sched_getcpu():                     13.7 ns (baseline)
glibc sched_getcpu() using rseq:           2.5 ns (speedup:  5.5x)
inline load cpuid from __rseq_abi TLS:     0.8 ns (speedup: 17.1x)

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
CC: libc-alpha@sourceware.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
---
Changes since v1:
- rseq is only used if both __NR_rseq and RSEQ_SIG are defined.

Changes since v2:
- remove duplicated __rseq_abi extern declaration.

Changes since v3:
- update ChangeLog.
---
 ChangeLog                              |  5 +++++
 sysdeps/unix/sysv/linux/sched_getcpu.c | 24 ++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 459af8f1a5..3e8ec0de1c 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,8 @@
+2019-04-23  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+
+	* sysdeps/unix/sysv/linux/sched_getcpu.c: use rseq cpu_id TLS on
+	Linux.
+
 2019-04-23  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 
 	* NEWS: Add Restartable Sequences feature description.
diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/linux/sched_getcpu.c
index fb0d317f83..167976fab7 100644
--- a/sysdeps/unix/sysv/linux/sched_getcpu.c
+++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
@@ -24,8 +24,8 @@
 #endif
 #include <sysdep-vdso.h>
 
-int
-sched_getcpu (void)
+static int
+vsyscall_sched_getcpu (void)
 {
 #ifdef __NR_getcpu
   unsigned int cpu;
@@ -37,3 +37,23 @@ sched_getcpu (void)
   return -1;
 #endif
 }
+
+#ifdef __NR_rseq
+#include <sys/rseq.h>
+#endif
+
+#if defined __NR_rseq && defined RSEQ_SIG
+int
+sched_getcpu (void)
+{
+  int cpu_id = __rseq_abi.cpu_id;
+
+  return cpu_id >= 0 ? cpu_id : vsyscall_sched_getcpu ();
+}
+#else
+int
+sched_getcpu (void)
+{
+  return vsyscall_sched_getcpu ();
+}
+#endif
-- 
2.17.1

