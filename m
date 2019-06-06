Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3825836920
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 03:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFFBW7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 21:22:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:54654 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfFFBW7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 5 Jun 2019 21:22:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:22:58 -0700
X-ExtLoop1: 1
Received: from aubrey-skl.sh.intel.com ([10.239.53.6])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2019 18:22:55 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v19 1/3] proc: add /proc/<pid>/arch_status
Date:   Thu,  6 Jun 2019 09:22:34 +0800
Message-Id: <20190606012236.9391-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The architecture specific information of the running processes
could be useful to the userland. Add /proc/<pid>/arch_status
interface support to examine process architecture specific
information externally.

v3:
  Add a /proc/<pid>/arch_state interface to expose per-task
  cpu specific state values.
v5:
  Change the interface to /proc/pid/status since no other
  architectures need a separated CPU specific interface.
v18:
  Change the interface to /proc/pid/arch_status. The interface
  /proc/<pid>/status should not be different on different
  architectures. It would be better to separate the arch staff
  into its own file /proc/<pid>/arch_status and make sure that
  everything in it is namespaced.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
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
 fs/proc/Kconfig         | 4 ++++
 fs/proc/base.c          | 6 ++++++
 include/linux/proc_fs.h | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 817c02b13b1d..d80ebf19d5f1 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -97,3 +97,7 @@ config PROC_CHILDREN
 
 	  Say Y if you are running any user-space software which takes benefit from
 	  this interface. For example, rkt is such a piece of software.
+
+config PROC_PID_ARCH_STATUS
+	def_bool n
+	depends on PROC_FS
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0c9bef89ac43..39ce939d8964 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3066,6 +3066,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_STACKLEAK_METRICS
 	ONE("stack_depth", S_IRUGO, proc_stack_depth),
 #endif
+#ifdef CONFIG_PROC_PID_ARCH_STATUS
+	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3454,6 +3457,9 @@ static const struct pid_entry tid_base_stuff[] = {
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
-- 
2.17.1

