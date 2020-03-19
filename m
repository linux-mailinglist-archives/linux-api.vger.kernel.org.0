Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFEF18BCC1
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 17:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCSQji convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 19 Mar 2020 12:39:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33599 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgCSQjh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 12:39:37 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jEyCh-0005Us-9l; Thu, 19 Mar 2020 17:39:31 +0100
Date:   Thu, 19 Mar 2020 17:39:31 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH 2/2 v4] mm/compaction: Disable compact_unevictable_allowed on
 RT
Message-ID: <20200319163931.ioaslbduokhtprfw@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
 <20200302173516.iysuejilava37psk@linutronix.de>
 <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
 <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
 <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
 <20200303202225.nhqc3v5gwlb7x6et@linutronix.de>
 <20200303155635.1955cb90451abd3ef8bfba63@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200303155635.1955cb90451abd3ef8bfba63@linux-foundation.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Since commit
    5bbe3547aa3ba ("mm: allow compaction of unevictable pages")

it is allowed to examine mlocked pages and compact them by default.
On -RT even minor pagefaults are problematic because it may take a few
100us to resolve them and until then the task is blocked.

Make compact_unevictable_allowed = 0 default and issue a warning on RT
if it is changed.

Link: https://lore.kernel.org/linux-mm/20190710144138.qyn4tuttdq6h7kqx@linutronix.de/
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v3…v4: - Replace WARN_ONCE() with pr_warn_once() and extend the message
         by name of the task and its pid.
       - Use proc_dointvec_minmax() in the !RT case.
       - Added Mel's Ack as per
	 20200304091159.GN3818@techsingularity.net.

v2…v3: - Allow to modify the value but issue a warning if it is changed.

v1…v2: - Make the proc file RO instead removing it.
       - Mention this change in Documentation/…/vm.rst.

 Documentation/admin-guide/sysctl/vm.rst |  3 +++
 kernel/sysctl.c                         | 29 ++++++++++++++++++++++++-
 mm/compaction.c                         |  4 ++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 64aeee1009cab..0329a4d3fa9ec 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -128,6 +128,9 @@ allowed to examine the unevictable lru (mlocked pages) for pages to compact.
 This should be used on systems where stalls for minor page faults are an
 acceptable trade for large contiguous free memory.  Set to 0 to prevent
 compaction from moving pages that are unevictable.  Default value is 1.
+On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fault, due
+to compaction, which would block the task from becomming active until the fault
+is resolved.
 
 
 dirty_background_bytes
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 982203101f961..43eb9da0ea86c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -212,6 +212,11 @@ static int proc_do_cad_pid(struct ctl_table *table, int write,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
 static int proc_taint(struct ctl_table *table, int write,
 			       void __user *buffer, size_t *lenp, loff_t *ppos);
+#ifdef CONFIG_COMPACTION
+static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
+					       int write, void __user *buffer,
+					       size_t *lenp, loff_t *ppos);
+#endif
 #endif
 
 #ifdef CONFIG_PRINTK
@@ -1484,7 +1489,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &sysctl_compact_unevictable_allowed,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax_warn_RT_change,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
@@ -2572,6 +2577,28 @@ int proc_dointvec(struct ctl_table *table, int write,
 	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
 }
 
+#ifdef CONFIG_COMPACTION
+static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
+					       int write, void __user *buffer,
+					       size_t *lenp, loff_t *ppos)
+{
+	int ret, old;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
+		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	old = *(int *)table->data;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+	if (old != *(int *)table->data)
+		pr_warn_once("sysctl attribute %s changed changed by %s[%d]\n",
+			     table->procname, current->comm,
+			     task_pid_nr(current));
+	return ret;
+}
+#endif
+
 /**
  * proc_douintvec - read a vector of unsigned integers
  * @table: the sysctl table
diff --git a/mm/compaction.c b/mm/compaction.c
index 672d3c78c6abf..ba77809a1666e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1590,7 +1590,11 @@ typedef enum {
  * Allow userspace to control policy on scanning the unevictable LRU for
  * compactable pages.
  */
+#ifdef CONFIG_PREEMPT_RT
+int sysctl_compact_unevictable_allowed __read_mostly = 0;
+#else
 int sysctl_compact_unevictable_allowed __read_mostly = 1;
+#endif
 
 static inline void
 update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
-- 
2.26.0.rc2

