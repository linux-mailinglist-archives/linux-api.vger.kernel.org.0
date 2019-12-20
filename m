Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40701283F0
	for <lists+linux-api@lfdr.de>; Fri, 20 Dec 2019 22:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfLTVi2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Dec 2019 16:38:28 -0500
Received: from mail.efficios.com ([167.114.142.138]:57496 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfLTVi1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Dec 2019 16:38:27 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7C0A7690A58;
        Fri, 20 Dec 2019 16:38:26 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 7k6W8dVGt-Pc; Fri, 20 Dec 2019 16:38:26 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 908CA690A46;
        Fri, 20 Dec 2019 16:38:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 908CA690A46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1576877904;
        bh=/bVnUsGf5G1T0yIcu2lL51PVFsvSJZzRb6jBDRmIQF8=;
        h=From:To:Date:Message-Id;
        b=tKN3zjtNK1XqrbY4/FojAITR0EWU4qZjdiRZWxEeTNYk5QGbh/8GQRAMbe3r1Gcvi
         UmeP6qXi3W6uULCLruh82LnSDQZJt1hvEGB0wri0gI8YfECc+9RiqTUMW4PNa1RO2g
         b8TaT6cG7SL1u0DBpNMAjslpfwq449b9H3jSTAcPxz0XP81LqPiGJnSBdShzpnJmxG
         jVHnDP+v2qqn8A1mGpmocA9vBVGa+wdezHhHphEn9OgUce7+utLEGjWtm3xHHn0tEe
         DF1xjwHIq5OH1X0mAFFtBrvtK5INDIy2Cn6Lha++wWLQZGbKoMO/21M0BNPCPZ2RRX
         Db/7fvpRCpLnw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 1IjHwgEbjLNe; Fri, 20 Dec 2019 16:38:24 -0500 (EST)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 45D13690A36;
        Fri, 20 Dec 2019 16:38:24 -0500 (EST)
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
Subject: [RFC PATCH glibc 10/13] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v5)
Date:   Fri, 20 Dec 2019 16:36:47 -0500
Message-Id: <20191220213650.11281-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220213650.11281-1-mathieu.desnoyers@efficios.com>
References: <20191220213650.11281-1-mathieu.desnoyers@efficios.com>
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

Changes since v4:
- Use atomic_load_relaxed to load the __rseq_abi.cpu_id field, a
  consequence of the fact that __rseq_abi is not volatile anymore.
- Include atomic.h which provides atomic_load_relaxed.
---
 ChangeLog.old/ChangeLog.19             |  5 +++++
 sysdeps/unix/sysv/linux/sched_getcpu.c | 25 +++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/ChangeLog.old/ChangeLog.19 b/ChangeLog.old/ChangeLog.19
index 9d6496c747..07c6aff585 100644
--- a/ChangeLog.old/ChangeLog.19
+++ b/ChangeLog.old/ChangeLog.19
@@ -1,3 +1,8 @@
+2019-12-17  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+
+	* sysdeps/unix/sysv/linux/sched_getcpu.c: use rseq cpu_id TLS on
+	Linux.
+
 2019-12-17  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 
 	* NEWS: Add Restartable Sequences feature description.
diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/linux/sched_getcpu.c
index 65dd9fdda7..6f24c1db99 100644
--- a/sysdeps/unix/sysv/linux/sched_getcpu.c
+++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
@@ -18,14 +18,15 @@
 #include <errno.h>
 #include <sched.h>
 #include <sysdep.h>
+#include <atomic.h>
 
 #ifdef HAVE_GETCPU_VSYSCALL
 # define HAVE_VSYSCALL
 #endif
 #include <sysdep-vdso.h>
 
-int
-sched_getcpu (void)
+static int
+vsyscall_sched_getcpu (void)
 {
 #ifdef __NR_getcpu
   unsigned int cpu;
@@ -37,3 +38,23 @@ sched_getcpu (void)
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
+  int cpu_id = atomic_load_relaxed (&__rseq_abi.cpu_id);
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

