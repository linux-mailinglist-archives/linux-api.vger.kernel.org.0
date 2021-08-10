Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278753E55E8
	for <lists+linux-api@lfdr.de>; Tue, 10 Aug 2021 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhHJIvP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Aug 2021 04:51:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:16147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234054AbhHJIvP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 10 Aug 2021 04:51:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="195129928"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="195129928"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 01:50:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="445053532"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Aug 2021 01:50:48 -0700
Date:   Tue, 10 Aug 2021 16:50:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v7 3/5] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
Message-ID: <20210810085048.GA67328@shbuild999.sh.intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-4-git-send-email-feng.tang@intel.com>
 <YQ06tNiDEsvl8004@dhcp22.suse.cz>
 <20210809024430.GA46432@shbuild999.sh.intel.com>
 <YRDqRMTXVZO9EkoC@dhcp22.suse.cz>
 <20210809123747.GB46432@shbuild999.sh.intel.com>
 <YRErZFQGZx4aPYuU@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRErZFQGZx4aPYuU@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 09, 2021 at 03:19:32PM +0200, Michal Hocko wrote:
[snip]
> > > Do you think you can provide same helpers for other policies as well?
> > > Maybe we can get rid of some other ifdefery as well.
> > 
> > Sure. I can make separate patch(es) for that.
> > 
> > And you mean helper like mpol_is_bind/default/local/preferred? 
> > 
> > I just run 'git-grep MPOL', and for places using "mode == MPOL_XXX",
> > mostly they are in mempolicy.[ch], the only another place is in
> > shmem.c, do we need to create all the helpers for it and the
> > potential future users? 
> 
> I would just go with those instances which need to ifdef for NUMA.
> Thanks!

Yes, following is a patch to remove one CONFIG_NUMA check, though
an bolder idea to extend the patch by removing the CONFIG_TMPFS
check in the same line.

Thanks,
Feng

---------8<---------------------------------

From 1a5858721ac8ce99c27c13d310bba2983dc73d97 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Tue, 10 Aug 2021 17:00:59 +0800
Subject: [PATCH] mm: shmem: avoid open coded check for mempolicy's mode

Add a mempolicy helper to do the check, which can also remove
a CONFIG_NUMA option check.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/mempolicy.h | 14 ++++++++++++++
 mm/shmem.c                |  8 ++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 60d5e6c3340c..8fc518ad4f3c 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -192,6 +192,10 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 	return  (pol->mode == MPOL_PREFERRED_MANY);
 }
 
+static inline bool mpol_is_default(struct mempolicy *pol)
+{
+	return  (pol->mode == MPOL_DEFAULT);
+}
 
 #else
 
@@ -287,6 +291,10 @@ static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
 }
 #endif
 
+static inline void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
+{
+}
+
 static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
 				 unsigned long address)
 {
@@ -309,5 +317,11 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 	return  false;
 }
 
+static inline bool mpol_is_default(struct mempolicy *pol)
+{
+	return  false;
+}
+
+
 #endif /* CONFIG_NUMA */
 #endif
diff --git a/mm/shmem.c b/mm/shmem.c
index 96f05f6af8bb..26b195209ef7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1437,12 +1437,12 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
-#if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)
+#ifdef CONFIG_TMPFS
 static void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
 {
 	char buffer[64];
 
-	if (!mpol || mpol->mode == MPOL_DEFAULT)
+	if (!mpol || mpol_is_default(mpol))
 		return;		/* show nothing */
 
 	mpol_to_str(buffer, sizeof(buffer), mpol);
@@ -1461,7 +1461,7 @@ static struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 	}
 	return mpol;
 }
-#else /* !CONFIG_NUMA || !CONFIG_TMPFS */
+#else /* !CONFIG_TMPFS */
 static inline void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
 {
 }
@@ -1469,7 +1469,7 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 {
 	return NULL;
 }
-#endif /* CONFIG_NUMA && CONFIG_TMPFS */
+#endif /* CONFIG_TMPFS */
 #ifndef CONFIG_NUMA
 #define vm_policy vm_private_data
 #endif
-- 
2.14.1


