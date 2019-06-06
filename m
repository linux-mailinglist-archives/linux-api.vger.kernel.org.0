Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3536922
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 03:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFFBXC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 21:23:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:54654 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfFFBXA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 5 Jun 2019 21:23:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:23:01 -0700
X-ExtLoop1: 1
Received: from aubrey-skl.sh.intel.com ([10.239.53.6])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2019 18:22:58 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v19 2/3] x86,/proc/pid/arch_status: Add AVX-512 usage elapsed time
Date:   Thu,  6 Jun 2019 09:22:35 +0800
Message-Id: <20190606012236.9391-2-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606012236.9391-1-aubrey.li@linux.intel.com>
References: <20190606012236.9391-1-aubrey.li@linux.intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

AVX-512 components use could cause core turbo frequency drop. So
it's useful to expose AVX-512 usage elapsed time as a heuristic hint
for the user space job scheduler to cluster the AVX-512 using tasks
together.

Tensorflow example:
$ while [ 1 ]; do cat /proc/tid/arch_status | grep AVX512; sleep 1; done
AVX512_elapsed_ms:      4
AVX512_elapsed_ms:      8
AVX512_elapsed_ms:      4

This means that 4 milliseconds have elapsed since the AVX512 usage
of tensorflow task was detected when the task was scheduled out.

Or:
$ cat /proc/tid/arch_status | grep AVX512
AVX512_elapsed_ms:      -1

The number '-1' indicates that no AVX512 usage recorded before
thus the task unlikely has frequency drop issue.

User space tools may want to further check by:

$ perf stat --pid <pid> -e core_power.lvl2_turbo_license -- sleep 1

 Performance counter stats for process id '3558':

     3,251,565,961      core_power.lvl2_turbo_license

       1.004031387 seconds time elapsed

Non-zero counter value confirms that the task causes frequency drop.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linux API <linux-api@vger.kernel.org>
---
 arch/x86/Kconfig             |  1 +
 arch/x86/kernel/fpu/xstate.c | 47 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fda1a05..5003c6f3a4d5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -208,6 +208,7 @@ config X86
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
+	select PROC_PID_ARCH_STATUS		if PROC_FS
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d7432c2b1051..fcaaf21aa015 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,8 @@
 #include <linux/cpu.h>
 #include <linux/mman.h>
 #include <linux/pkeys.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -1243,3 +1245,48 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 
 	return 0;
 }
+
+#ifdef CONFIG_PROC_PID_ARCH_STATUS
+/*
+ * Report the amount of time elapsed in millisecond since last AVX512
+ * use in the task.
+ */
+static void avx512_status(struct seq_file *m, struct task_struct *task)
+{
+	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
+	long delta;
+
+	if (!timestamp) {
+		/*
+		 * Report -1 if no AVX512 usage
+		 */
+		delta = -1;
+	} else {
+		delta = (long)(jiffies - timestamp);
+		/*
+		 * Cap to LONG_MAX if time difference > LONG_MAX
+		 */
+		if (delta < 0)
+			delta = LONG_MAX;
+		delta = jiffies_to_msecs(delta);
+	}
+
+	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
+	seq_putc(m, '\n');
+}
+
+/*
+ * Report architecture specific information
+ */
+int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
+			struct pid *pid, struct task_struct *task)
+{
+	/*
+	 * Report AVX512 state if the processor and build option supported.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
+		avx512_status(m, task);
+
+	return 0;
+}
+#endif /* CONFIG_PROC_PID_ARCH_STATUS */
-- 
2.17.1

