Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68859203EC5
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 20:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgFVSIM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 14:08:12 -0400
Received: from mail.efficios.com ([167.114.26.124]:35224 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgFVSIL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 14:08:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3D7922B6F2D;
        Mon, 22 Jun 2020 14:08:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZXtbc0lA3bhQ; Mon, 22 Jun 2020 14:08:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EC6AF2B6ED8;
        Mon, 22 Jun 2020 14:08:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EC6AF2B6ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1592849289;
        bh=yRiGtquXYPCKnEyIARANnhxrsJ53NZMKmbMlMj8D3uI=;
        h=From:To:Date:Message-Id;
        b=N3ALkBp9RQZIFWtwiMynZtPjd5HMR4YvsfQd5dMx7+3BByTANsJvoOnfcy4t4k6mn
         4FX2u5Jb+xUmHHKn+SLffg+HzkmktZbIvbJWTy70pTjKnu8qPc/R8IBG8zkDYAYAaa
         FiRvuXeP7ZtXLHJQXUcwNLbkzfOqZkFyxlo17UCFIWOhjXhRLjvHxNXB7W5XljCk9+
         ny0jcbAXT8ft0Yf/5ijh5ajg2l7wybGLFtVTIVifBw48K87tXc72DjrYRkWbaT/ZWm
         6snoEqzILBd9C8gcQhwiSAT60Q0V/YyJLaFWU9dtOO+W9S7Ae6F+0+CkbdEt+MQ1zg
         Kn6NjoxJWL3yQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7WF-2it4VbFd; Mon, 22 Jun 2020 14:08:09 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 9B8562B6F27;
        Mon, 22 Jun 2020 14:08:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
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
Subject: [PATCH 2/3] Linux: Use rseq in sched_getcpu if available (v9)
Date:   Mon, 22 Jun 2020 14:08:02 -0400
Message-Id: <20200622180803.1449-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622180803.1449-1-mathieu.desnoyers@efficios.com>
References: <20200622180803.1449-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When available, use the cpu_id field from __rseq_abi on Linux to
implement sched_getcpu().  Fall-back on the vgetcpu vDSO if unavailable.

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

Changes since v7:
- Fix incorrect merge with commit d0def09ff6 ("linux: Fix vDSO macros
  build with time64 interfaces")

Changes since v8:
- Update patch title.
- Add /* RSEQ_SIG */ for #else and #endif.
---
 sysdeps/unix/sysv/linux/sched_getcpu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/linux/sched_getcpu.c
index c019cfb3cf..c0f992e056 100644
--- a/sysdeps/unix/sysv/linux/sched_getcpu.c
+++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
@@ -18,10 +18,12 @@
 #include <errno.h>
 #include <sched.h>
 #include <sysdep.h>
+#include <atomic.h>
 #include <sysdep-vdso.h>
+#include <sys/rseq.h>
 
-int
-sched_getcpu (void)
+static int
+vsyscall_sched_getcpu (void)
 {
   unsigned int cpu;
   int r = -1;
@@ -32,3 +34,19 @@ sched_getcpu (void)
 #endif
   return r == -1 ? r : cpu;
 }
+
+#ifdef RSEQ_SIG
+int
+sched_getcpu (void)
+{
+  int cpu_id = atomic_load_relaxed (&__rseq_abi.cpu_id);
+
+  return cpu_id >= 0 ? cpu_id : vsyscall_sched_getcpu ();
+}
+#else /* RSEQ_SIG */
+int
+sched_getcpu (void)
+{
+  return vsyscall_sched_getcpu ();
+}
+#endif /* RSEQ_SIG */
-- 
2.17.1

