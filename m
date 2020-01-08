Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E713457E
	for <lists+linux-api@lfdr.de>; Wed,  8 Jan 2020 15:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAHO71 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jan 2020 09:59:27 -0500
Received: from mail.efficios.com ([167.114.142.138]:58158 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgAHO71 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jan 2020 09:59:27 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A12006959E6;
        Wed,  8 Jan 2020 09:59:25 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id uGb2HplhVTXv; Wed,  8 Jan 2020 09:59:25 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C00A76959CD;
        Wed,  8 Jan 2020 09:59:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C00A76959CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1578495562;
        bh=csmXiMR894cheYBJKST2fVas13SXJ+OppF5lHATVWIs=;
        h=From:To:Date:Message-Id;
        b=kF/rFIjYU6pzhYQQoiLv1a+lDJ6XnzLG4nfCeapqzamCqpKamE9E1saWOkr8+ZRxU
         sIPdkjoVurzsbTmhArqg857rMRGLSUuo4hb6UAJLKqgJY/lHV37DKSxmDxZWeU+z+i
         lkTYGYmM8U9d3RtKbWnjokQ5ciDVv1l+P3xGKxuSoAekD8OC6POlVji7FWUaATH2xh
         34YSL/FM4bvOXFXbl/KzP4vptXcLYW4UMfl23YK0Y6ZsxdJvzxI8XX3XTRBUq44IN5
         JTBCnLyWAeYGFvDAOrOCoPSGV9I1mcZ/V9dbsXyYgp000jPpFnagA/aCmEKuoaZfgr
         tqKQzFhQiG9Eg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Js-LS6a-xGbz; Wed,  8 Jan 2020 09:59:22 -0500 (EST)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 508216959BF;
        Wed,  8 Jan 2020 09:59:20 -0500 (EST)
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
Subject: [RFC PATCH glibc 5/8] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v5)
Date:   Wed,  8 Jan 2020 09:58:48 -0500
Message-Id: <20200108145851.13594-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108145851.13594-1-mathieu.desnoyers@efficios.com>
References: <20200108145851.13594-1-mathieu.desnoyers@efficios.com>
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

	* sysdeps/unix/sysv/linux/sched_getcpu.c: use rseq cpu_id TLS on
	Linux.

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
 sysdeps/unix/sysv/linux/sched_getcpu.c | 29 ++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/linux/sched_getcpu.c
index c019cfb3cf..6d3541333d 100644
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
@@ -32,3 +37,23 @@ sched_getcpu (void)
 #endif
   return r == -1 ? r : cpu;
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

