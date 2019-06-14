Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6C4629C
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFNPXM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 11:23:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:49952 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNPXM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 11:23:12 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EEC6825174D;
        Fri, 14 Jun 2019 11:23:10 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id dHBNh9EPKqVL; Fri, 14 Jun 2019 11:23:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AA480251731;
        Fri, 14 Jun 2019 11:23:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AA480251731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560525788;
        bh=OBox3OMxjxvC7PvoLYGWSN3dsx6DMeQHxfzI7UPjj1Y=;
        h=From:To:Date:Message-Id;
        b=ZxhHLReM1LIW1i4jvG82L8qd3m5LTPJDyXwDqty0mpFQ+PLM8Cp+W8h7rbu734ot7
         1Qg6PIsk3Q7eYwHmQEuH3mqUrMoYcqExVUsVlkB3ehCCcSSj7BDPSoHhGE61e2qXk3
         1YWyu18xdbqY6QiRcvEfvoUpuZdvaZbNux0oI2PFtFfshhaSZpXcDfNkqsBbeK04Cq
         zFNu2khFa6v4rXfjX3jNPBAsvjO1NCOPjV8OeL6X7WoPzKrpW4fPeJoYBiCx1OS0uq
         L6HiXqZWIgOHjhdQXVDEhVs55OyLIH9rME6OctJDlrefUJQcZnehuOQ6ABHcrRk6fa
         g3yhiwSdJrUyg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Uimi5a9qPjeK; Fri, 14 Jun 2019 11:23:08 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 655E725171F;
        Fri, 14 Jun 2019 11:23:08 -0400 (EDT)
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
Subject: [PATCH glibc 2/5] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v5)
Date:   Fri, 14 Jun 2019 11:23:01 -0400
Message-Id: <20190614152304.12321-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614152304.12321-1-mathieu.desnoyers@efficios.com>
References: <20190614152304.12321-1-mathieu.desnoyers@efficios.com>
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
 ChangeLog                              |  5 +++++
 sysdeps/unix/sysv/linux/sched_getcpu.c | 25 +++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 01a411acbf..58830cafc2 100644
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
index fb0d317f83..01a818f5b0 100644
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

