Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A4B1BC643
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgD1RPW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 13:15:22 -0400
Received: from mail.efficios.com ([167.114.26.124]:44046 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgD1RPW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Apr 2020 13:15:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C162D27E927;
        Tue, 28 Apr 2020 13:15:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m-OwioVHNQqU; Tue, 28 Apr 2020 13:15:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5589727E926;
        Tue, 28 Apr 2020 13:15:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5589727E926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588094120;
        bh=0smAkb6cp0p+RuLi71ihxVXx+NcGlOLwapAddILSwQ4=;
        h=From:To:Date:Message-Id;
        b=WAqEKu+24lm5qRCV5yJwWPHQBgxEAVPrcXpp6/JrG3g48Ec1+62dxKKZDrgtUgYcj
         cZt1gE2U4N8yxxXhf3F3THD5zpt9di0r6dO0tjr0yS4FAZYKdLd53fnG8bODQLsHlZ
         SX7X8gsljHNzbQYHzWa9rBecfO36sQvLg4P6QcuKNdnN7saR9UOlp2DZSTwGsnVdk+
         1htKwyUTZLPz1lzrlu+MmGnuxPH828bdWs7i3Hhc3e4CSSwB71vKlK2aPiLgoS+zPv
         SxsIMcV1WdMOnH+1ZpXI66I84qDiZGjj8XtgRY5MCsbUHxO5BLvuJygiA3L8TIyli7
         7LctWSuVrJhkg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NdISAkAmPADx; Tue, 28 Apr 2020 13:15:20 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 128FC27E91B;
        Tue, 28 Apr 2020 13:15:20 -0400 (EDT)
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
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC PATCH glibc 2/3] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v7)
Date:   Tue, 28 Apr 2020 13:15:12 -0400
Message-Id: <20200428171513.22926-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428171513.22926-1-mathieu.desnoyers@efficios.com>
References: <20200428171513.22926-1-mathieu.desnoyers@efficios.com>
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

Changes since v5:
- Use __ASSUME_RSEQ to detect rseq availability.

Changes since v6:
- Remove use of __ASSUME_RSEQ.
---
 sysdeps/unix/sysv/linux/sched_getcpu.c | 27 ++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/linux/sched_getcpu.c
index c019cfb3cf..2269c4f2bd 100644
--- a/sysdeps/unix/sysv/linux/sched_getcpu.c
+++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
@@ -18,10 +18,15 @@
 #include <errno.h>
 #include <sched.h>
 #include <sysdep.h>
+#include <atomic.h>
 #include <sysdep-vdso.h>
 
-int
-sched_getcpu (void)
+#ifdef HAVE_GETCPU_VSYSCALL
+# define HAVE_VSYSCALL
+#endif
+
+static int
+vsyscall_sched_getcpu (void)
 {
   unsigned int cpu;
   int r = -1;
@@ -32,3 +37,21 @@ sched_getcpu (void)
 #endif
   return r == -1 ? r : cpu;
 }
+
+#include <sys/rseq.h>
+
+#ifdef RSEQ_SIG
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

