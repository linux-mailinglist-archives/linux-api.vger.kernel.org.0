Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D181943A9
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 16:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCZP5H (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 11:57:07 -0400
Received: from mail.efficios.com ([167.114.26.124]:47408 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgCZP5G (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 11:57:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4C00D277EB7;
        Thu, 26 Mar 2020 11:57:05 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ii5h1qGZ6RL3; Thu, 26 Mar 2020 11:57:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7FD412772CF;
        Thu, 26 Mar 2020 11:57:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7FD412772CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1585238220;
        bh=MPN/nh2eqVGSbCWW3l0JbpXjFSWm7qUcdtF1gO28mMI=;
        h=From:To:Date:Message-Id;
        b=PjdXKZGAoCtHn7Ent2hrASug0GK23cqHmwHKVjpmNtbMqPebA3qJj0ta5FGJDWJsP
         sjXX1IcZ16FIDnV8l9FPYiT/ny/d6mwYD8TQoGNb4l4Ug2/TEH01lb/nJ2Ag+cWjd9
         jn/3AWuW/Lv3ojvI0LbQaPx3HC1iQ+a0rG1jeD30YHXKay7IQG9h9xbUq7qKJIDhRf
         MUuU7IA5lny9x4J8QqShNm8h0GgYYYH8Hmy96VRLjXNge0/OonVK4FP3KfpNtY3HG8
         5AuM7MIGrVGpwXGpCIRPCT1IYh6rqkAIBydRLGEJUpY027ZMYg8+2iAHHzPTHuktCQ
         WMw7ZBJ7gOZvA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P1cMScfDNFqm; Thu, 26 Mar 2020 11:57:00 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 06F282777E1;
        Thu, 26 Mar 2020 11:56:58 -0400 (EDT)
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
Subject: [PATCH glibc 6/9] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v7)
Date:   Thu, 26 Mar 2020 11:56:30 -0400
Message-Id: <20200326155633.18236-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
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

