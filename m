Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4527013BC72
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2020 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgAOJbQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jan 2020 04:31:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:46313 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbgAOJbQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Jan 2020 04:31:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 01:31:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="397826039"
Received: from unknown (HELO chenyu-office.sh.intel.com) ([10.239.158.173])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2020 01:31:11 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     x86@kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][v7] x86/resctrl: Add task resctrl information display
Date:   Wed, 15 Jan 2020 17:28:51 +0800
Message-Id: <20200115092851.14761-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Monitoring tools that want to find out which resctrl control and monitor
groups a task belongs to must currently read the "tasks" file in every
group until they locate the process ID.

Add an additional file /proc/{pid}/cpu_resctrl_groups to provide this
information:

1)   res:
     mon:

resctrl is not available.

2)   res:/
     mon:

Task is part of the root resctrl control group, and it is not associated
to any monitor group.

3)  res:/
    mon:mon0

Task is part of the root resctrl control group and monitor group mon0.

4)  res:group0
    mon:

Task is part of resctrl control group group0, and it is not associated
to any monitor group.

5) res:group0
   mon:mon1

Task is part of resctrl control group group0 and monitor group mon1.

Tested-by: Jinshi Chen <jinshi.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v1: Initial version reviewed by Reinette Chatre,
    Fenghua Yu and Tony Luck.

v2: According to Boris's suggestion,
    reduce indentation level in proc_resctrl_show().
    Create the include/linux/resctrl.h header and
    declare proc_resctrl_show() in this file, so
    that other architectures would probably use it
    in the future. Different architectures should
    implement architectural specific proc_resctrl_show()
    accordingly.

v3: According to Boris's suggestion,
    Return empty string if the resctrl filesystem has
    not been mounted.
    Rename the config from CPU_RESCTRL to PROC_CPU_RESCTRL
    to better represent its usage. Move PROC_CPU_RESCTRL
    from arch/Kconfig to fs/proc/Kconfig.
    And let PROC_CPU_RESCTRL to be depended on PROC_FS.

v4: According to Thomas's suggestion, changed the output
    from multiple lines to one single line.

v5: According to Alexey's feedback, removed the header file
    proc_fs.h in resctrl.h, and changed seq_puts() to
    seq_putc() for simplicity.

v6: According to Chris Down's suggestion,
    1. rename:
    /proc/{pid}/resctrl to /proc/{pid}/cpu_resctrl
    to better reflect its meaning.
    2. change the description in comments:
    "control group" to "resctrl control group"
    as the former is confusing for cgroup users.

v7: According to Boris's suggestion,
    split the output into two lines, to display the
    resctrl control group and monitor group respctively
    to be more human/tool-readable. Renamed the file to
    cpu_resctrl_groups.
---
 arch/x86/Kconfig                       |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 86 ++++++++++++++++++++++++++
 fs/proc/Kconfig                        |  4 ++
 fs/proc/base.c                         |  7 +++
 include/linux/resctrl.h                | 14 +++++
 5 files changed, 112 insertions(+)
 create mode 100644 include/linux/resctrl.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e8949953660..6e17a68c7d77 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -456,6 +456,7 @@ config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
+	select PROC_CPU_RESCTRL		if PROC_FS
 	help
 	  Enable x86 CPU resource control support.
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d6bbc6..4b185740d29d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -725,6 +725,92 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+#ifdef CONFIG_PROC_CPU_RESCTRL
+
+/*
+ * A task can only be part of one resctrl control group and of one monitor
+ * group which is associated to that control group.
+ *
+ * 1)   res:
+ *      mon:
+ *
+ *    resctrl is not available.
+ *
+ * 2)   res:/
+ *      mon:
+ *
+ *    Task is part of the root resctrl control group, and it is not associated
+ *    to any monitor group.
+ *
+ * 3)  res:/
+ *     mon:mon0
+ *
+ *    Task is part of the root resctrl control group and monitor group mon0.
+ *
+ * 4)  res:group0
+ *     mon:
+ *
+ *    Task is part of resctrl control group group0, and it is not associated
+ *    to any monitor group.
+ *
+ * 5) res:group0
+ *    mon:mon1
+ *
+ *    Task is part of resctrl control group group0 and monitor group mon1.
+ */
+int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
+		      struct pid *pid, struct task_struct *tsk)
+{
+	struct rdtgroup *rdtg;
+	int ret = 0;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	/* Return empty if resctrl has not been mounted. */
+	if (!static_branch_unlikely(&rdt_enable_key)) {
+		seq_puts(s, "res:\nmon:\n");
+		goto unlock;
+	}
+
+	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+		struct rdtgroup *crg;
+
+		/*
+		 * Task information is only relevant for shareable
+		 * and exclusive groups.
+		 */
+		if (rdtg->mode != RDT_MODE_SHAREABLE &&
+		    rdtg->mode != RDT_MODE_EXCLUSIVE)
+			continue;
+
+		if (rdtg->closid != tsk->closid)
+			continue;
+
+		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
+			   rdtg->kn->name);
+		seq_puts(s, "mon:");
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			if (tsk->rmid != crg->mon.rmid)
+				continue;
+			seq_printf(s, "%s", crg->kn->name);
+			break;
+		}
+		seq_putc(s, '\n');
+		goto unlock;
+	}
+	/*
+	 * The above search should succeed. Otherwise return
+	 * with an error.
+	 */
+	ret = -ENOENT;
+unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+#endif
+
 static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 				    struct seq_file *seq, void *v)
 {
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 733881a6387b..27ef84d99f59 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -103,3 +103,7 @@ config PROC_CHILDREN
 config PROC_PID_ARCH_STATUS
 	def_bool n
 	depends on PROC_FS
+
+config PROC_CPU_RESCTRL
+	def_bool n
+	depends on PROC_FS
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..bbffd654bb0e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/resctrl.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -3060,6 +3061,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
+#endif
+#ifdef CONFIG_PROC_CPU_RESCTRL
+	ONE("cpu_resctrl_groups", S_IRUGO, proc_resctrl_show),
 #endif
 	ONE("oom_score",  S_IRUGO, proc_oom_score),
 	REG("oom_adj",    S_IRUGO|S_IWUSR, proc_oom_adj_operations),
@@ -3460,6 +3464,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
+#endif
+#ifdef CONFIG_PROC_CPU_RESCTRL
+	ONE("cpu_resctrl_groups", S_IRUGO, proc_resctrl_show),
 #endif
 	ONE("oom_score", S_IRUGO, proc_oom_score),
 	REG("oom_adj",   S_IRUGO|S_IWUSR, proc_oom_adj_operations),
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
new file mode 100644
index 000000000000..daf5cf64c6a6
--- /dev/null
+++ b/include/linux/resctrl.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RESCTRL_H
+#define _RESCTRL_H
+
+#ifdef CONFIG_PROC_CPU_RESCTRL
+
+int proc_resctrl_show(struct seq_file *m,
+		      struct pid_namespace *ns,
+		      struct pid *pid,
+		      struct task_struct *tsk);
+
+#endif
+
+#endif /* _RESCTRL_H */
-- 
2.17.1

