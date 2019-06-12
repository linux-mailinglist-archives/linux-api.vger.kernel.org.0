Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3562425F3
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 14:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407680AbfFLMfF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 08:35:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407663AbfFLMfF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 08:35:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCYqu2686296
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:34:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCYqu2686296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342894;
        bh=kmYcR1CQENnXNtOk1UteNJlqYAEgacAVyIILLRAIoKY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=c0TDAO2Y46sLf/igF1PIfYSvYsONjQNMFVGwkZ7r2oL5J3E8m3LMJDm1Y/qr9ohr7
         qLbbVg3PY6F0VyZGpFubMX4upt6B6F/4bc7AClkoxFjWxKA6lbNEFDBC8YGVnNGuFz
         z2J21tenfKB31rswCrm8MmqPm3PcEBqrvBsvXZQDA442GFclo2jmzRN3lNP4gjK5ik
         ePcrsk5IEI1vgkoYXIDheEdkA16mlkhKDxKPL6x2+ipDRKWfVkonIkbo3c1HoJLI2n
         TD5Z2EpyyHtYU3OIKWp65S5CLpddNFqTxwgASBBy8OYRHQXio5gO7jeGKdocVRaEmF
         s6Qj6mSWDFJag==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCYpWa686293;
        Wed, 12 Jun 2019 05:34:51 -0700
Date:   Wed, 12 Jun 2019 05:34:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Aubrey Li <tipbot@zytor.com>
Message-ID: <tip-68bc30bb9f33fc8d11e3d110d29e06490896a999@git.kernel.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, mingo@kernel.org,
        dave.hansen@intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, ak@linux.intel.com, peterz@infradead.org,
        linux-api@vger.kernel.org, luto@kernel.org,
        aubrey.li@linux.intel.com, hpa@zytor.com
Reply-To: ak@linux.intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, arjan@linux.intel.com,
          hpa@zytor.com, aubrey.li@linux.intel.com, luto@kernel.org,
          linux-api@vger.kernel.org, peterz@infradead.org,
          akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
          mingo@kernel.org, dave.hansen@intel.com, adobriyan@gmail.com
In-Reply-To: <20190606012236.9391-1-aubrey.li@linux.intel.com>
References: <20190606012236.9391-1-aubrey.li@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] proc: Add /proc/<pid>/arch_status
Git-Commit-ID: 68bc30bb9f33fc8d11e3d110d29e06490896a999
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

Commit-ID:  68bc30bb9f33fc8d11e3d110d29e06490896a999
Gitweb:     https://git.kernel.org/tip/68bc30bb9f33fc8d11e3d110d29e06490896a999
Author:     Aubrey Li <aubrey.li@linux.intel.com>
AuthorDate: Thu, 6 Jun 2019 09:22:34 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 11:42:13 +0200

proc: Add /proc/<pid>/arch_status

Exposing architecture specific per process information is useful for
various reasons. An example is the AVX512 usage on x86 which is important
for task placement for power/performance optimizations.

Adding this information to the existing /prcc/pid/status file would be the
obvious choise, but it has been agreed on that a explicit arch_status file
is better in separating the generic and architecture specific information.

[ tglx: Massage changelog ]

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
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
Cc: Linux API <linux-api@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190606012236.9391-1-aubrey.li@linux.intel.com

---
 fs/proc/Kconfig         | 4 ++++
 fs/proc/base.c          | 6 ++++++
 include/linux/proc_fs.h | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 62ee41b4bbd0..4c3dcb718961 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -98,3 +98,7 @@ config PROC_CHILDREN
 
 	  Say Y if you are running any user-space software which takes benefit from
 	  this interface. For example, rkt is such a piece of software.
+
+config PROC_PID_ARCH_STATUS
+	def_bool n
+	depends on PROC_FS
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9c8ca6cd3ce4..ec436c61eece 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3061,6 +3061,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_STACKLEAK_METRICS
 	ONE("stack_depth", S_IRUGO, proc_stack_depth),
 #endif
+#ifdef CONFIG_PROC_PID_ARCH_STATUS
+	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3449,6 +3452,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
+#ifdef CONFIG_PROC_PID_ARCH_STATUS
+	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 52a283ba0465..a705aa2d03f9 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -75,6 +75,15 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 						    void *data);
 extern struct pid *tgid_pidfd_to_pid(const struct file *file);
 
+#ifdef CONFIG_PROC_PID_ARCH_STATUS
+/*
+ * The architecture which selects CONFIG_PROC_PID_ARCH_STATUS must
+ * provide proc_pid_arch_status() definition.
+ */
+int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
+			struct pid *pid, struct task_struct *task);
+#endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
 #else /* CONFIG_PROC_FS */
 
 static inline void proc_root_init(void)
