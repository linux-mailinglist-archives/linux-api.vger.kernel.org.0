Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB60425FC
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407804AbfFLMft (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 08:35:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56157 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407663AbfFLMfs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 08:35:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCZZK9686452
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:35:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCZZK9686452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342936;
        bh=h3in5hBREftm3C57eF1wFkPde9gIToHd7JgiCVF5P9M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FreZ+Ydxy/Khf4anThvGthBBEmuVdCezI6VqQQ4j+mhBLU66eE5luEvgjbSB9CTVX
         T3Rfyur5hLwcQSW0njN05QOT8Dbm3FYxjG9iJwx2P88zhzC9QOmyBJu6RfoxPFbTVw
         WBwveRa1ECBDL1Kd98rPlY8rvCCMoiXdPmvjMl2yHNbGG5v3NeMUYEnsqabEOl8SMN
         zdfy2gzS6oHfdCWhswi9qYehgRV1U+sVL05m55Ezxoy/2XeU/i6bQD6m11bJ1z/sfB
         YWygKTNcmaFTCOrUa4r2ZbE5aazJDtIWBuayktmOmPWFctFKubHuFecGuRRJ4xchGj
         6Og/J3ZVHYZoQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCZYDI686448;
        Wed, 12 Jun 2019 05:35:34 -0700
Date:   Wed, 12 Jun 2019 05:35:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Aubrey Li <tipbot@zytor.com>
Message-ID: <tip-0c608dad2a771c0a11b6d12148d1a8b975e015d4@git.kernel.org>
Cc:     adobriyan@gmail.com, mingo@kernel.org, luto@kernel.org,
        tim.c.chen@linux.intel.com, hpa@zytor.com, ak@linux.intel.com,
        peterz@infradead.org, dave.hansen@intel.com, tglx@linutronix.de,
        aubrey.li@linux.intel.com, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com, akpm@linux-foundation.org,
        linux-api@vger.kernel.org
Reply-To: ak@linux.intel.com, dave.hansen@intel.com, peterz@infradead.org,
          aubrey.li@linux.intel.com, arjan@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          linux-api@vger.kernel.org, akpm@linux-foundation.org,
          luto@kernel.org, mingo@kernel.org, adobriyan@gmail.com,
          hpa@zytor.com, tim.c.chen@linux.intel.com
In-Reply-To: <20190606012236.9391-2-aubrey.li@linux.intel.com>
References: <20190606012236.9391-2-aubrey.li@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] x86/process: Add AVX-512 usage elapsed time to
 /proc/pid/arch_status
Git-Commit-ID: 0c608dad2a771c0a11b6d12148d1a8b975e015d4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Commit-ID:  0c608dad2a771c0a11b6d12148d1a8b975e015d4
Gitweb:     https://git.kernel.org/tip/0c608dad2a771c0a11b6d12148d1a8b975e015d4
Author:     Aubrey Li <aubrey.li@linux.intel.com>
AuthorDate: Thu, 6 Jun 2019 09:22:35 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 11:42:13 +0200

x86/process: Add AVX-512 usage elapsed time to /proc/pid/arch_status

AVX-512 components usage can result in turbo frequency drop. So it's useful
to expose AVX-512 usage elapsed time as a heuristic hint for user space job
schedulers to cluster the AVX-512 using tasks together.

Examples:
$ while [ 1 ]; do cat /proc/tid/arch_status | grep AVX512; sleep 1; done
AVX512_elapsed_ms:      4
AVX512_elapsed_ms:      8
AVX512_elapsed_ms:      4

This means that 4 milliseconds have elapsed since the tsks AVX512 usage was
detected when the task was scheduled out.

$ cat /proc/tid/arch_status | grep AVX512
AVX512_elapsed_ms:      -1

'-1' indicates that no AVX512 usage was recorded for this task.

The time exposed is not necessarily accurate when the arch_status file is
read as the AVX512 usage is only evaluated when a task is scheduled
out. Accurate usage information can be obtained with performance counters.

[ tglx: Massaged changelog ]

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Cc: peterz@infradead.org
Cc: hpa@zytor.com
Cc: ak@linux.intel.com
Cc: tim.c.chen@linux.intel.com
Cc: dave.hansen@intel.com
Cc: arjan@linux.intel.com
Cc: adobriyan@gmail.com
Cc: aubrey.li@intel.com
Cc: linux-api@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux API <linux-api@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190606012236.9391-2-aubrey.li@linux.intel.com

---
 arch/x86/Kconfig             |  1 +
 arch/x86/kernel/fpu/xstate.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..8a49b4b03f6b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -217,6 +217,7 @@ config X86
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
+	select PROC_PID_ARCH_STATUS		if PROC_FS
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3c36dd1784db..591ddde3b3e8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -8,6 +8,8 @@
 #include <linux/cpu.h>
 #include <linux/mman.h>
 #include <linux/pkeys.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -1240,3 +1242,48 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 
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
