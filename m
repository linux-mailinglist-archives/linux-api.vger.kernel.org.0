Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB34D176121
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 18:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCBRfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 2 Mar 2020 12:35:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42437 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgCBRfX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 12:35:23 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j8oyK-00069s-IK; Mon, 02 Mar 2020 18:35:16 +0100
Date:   Mon, 2 Mar 2020 18:35:16 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH v2] mm/compaction: Disable compact_unevictable_allowed on RT
Message-ID: <20200302173516.iysuejilava37psk@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Since commit
    5bbe3547aa3ba ("mm: allow compaction of unevictable pages")

it is allowed to examine mlocked pages and compact them by default.
On -RT even minor pagefaults are problematic because it may take a few
100us to resolve them and until then the task is blocked.

Make compact_unevictable_allowed = 0 default and RO on RT.

Link: https://lore.kernel.org/linux-mm/20190710144138.qyn4tuttdq6h7kqx@linutronix.de/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: - Make the proc file RO instead removing it.
       - Mention this change in Documentation/…/vm.rst.

 Documentation/admin-guide/sysctl/vm.rst | 1 +
 kernel/sysctl.c                         | 4 ++++
 mm/compaction.c                         | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 64aeee1009cab..bbfa59d25eec3 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -128,6 +128,7 @@ allowed to examine the unevictable lru (mlocked pages) for pages to compact.
 This should be used on systems where stalls for minor page faults are an
 acceptable trade for large contiguous free memory.  Set to 0 to prevent
 compaction from moving pages that are unevictable.  Default value is 1.
+On CONFIG_PREEMPT_RT the default value is 0.
 
 
 dirty_background_bytes
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a8..f113e31d0b0b6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1483,7 +1483,11 @@ static struct ctl_table vm_table[] = {
 		.procname	= "compact_unevictable_allowed",
 		.data		= &sysctl_compact_unevictable_allowed,
 		.maxlen		= sizeof(int),
+#ifdef CONFIG_PREEMPT_RT
+		.mode		= 0444,
+#else
 		.mode		= 0644,
+#endif
 		.proc_handler	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
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
2.25.1

