Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DBA3AC186
	for <lists+linux-api@lfdr.de>; Fri, 18 Jun 2021 05:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFRDrD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Jun 2021 23:47:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:1056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhFRDrC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 Jun 2021 23:47:02 -0400
IronPort-SDR: tuq2Pumb05j/+3YODF05itI4re49WH4ORnxWZyyY6U5Tvtksj45ZOI665MlGUXKktg3XSUTJay
 zNe7MboHjrQg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267636018"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267636018"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 20:44:54 -0700
IronPort-SDR: 3X+2VbFbAS+0IkEG7fHkgEDvKlDnS8zbVFRJ//Ga7dCbDyNqU5o2NmREOl9ua7ON7Gv5+WEKpm
 dWO7fTluQoCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="485539814"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2021 20:44:49 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v5 -mm 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
Date:   Fri, 18 Jun 2021 11:44:39 +0800
Message-Id: <1623987884-43576-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
References: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

The NUMA APIs currently allow passing in a "preferred node" as a
single bit set in a nodemask.  If more than one bit it set, bits
after the first are ignored.

This single node is generally OK for location-based NUMA where
memory being allocated will eventually be operated on by a single
CPU.  However, in systems with multiple memory types, folks want
to target a *type* of memory instead of a location.  For instance,
someone might want some high-bandwidth memory but do not care about
the CPU next to which it is allocated.  Or, they want a cheap,
high capacity allocation and want to target all NUMA nodes which
have persistent memory in volatile mode.  In both of these cases,
the application wants to target a *set* of nodes, but does not
want strict MPOL_BIND behavior as that could lead to OOM killer or
SIGSEGV.

So add MPOL_PREFERRED_MANY policy to support the multiple preferred
nodes requirement. This is not a pie-in-the-sky dream for an API.
This was a response to a specific ask of more than one group at Intel.
Specifically:

1. There are existing libraries that target memory types such as
   https://github.com/memkind/memkind.  These are known to suffer
   from SIGSEGV's when memory is low on targeted memory "kinds" that
   span more than one node.  The MCDRAM on a Xeon Phi in "Cluster on
   Die" mode is an example of this.
2. Volatile-use persistent memory users want to have a memory policy
   which is targeted at either "cheap and slow" (PMEM) or "expensive and
   fast" (DRAM).  However, they do not want to experience allocation
   failures when the targeted type is unavailable.
3. Allocate-then-run.  Generally, we let the process scheduler decide
   on which physical CPU to run a task.  That location provides a
   default allocation policy, and memory availability is not generally
   considered when placing tasks.  For situations where memory is
   valuable and constrained, some users want to allocate memory first,
   *then* allocate close compute resources to the allocation.  This is
   the reverse of the normal (CPU) model.  Accelerators such as GPUs
   that operate on core-mm-managed memory are interested in this model.

A check is added in sanitize_mpol_flags() to not permit 'prefer_many'
policy to be used for now, and will be removed in later patch after all
implementations for 'prefer_many' are ready, as suggested by Michal Hocko.

Link: https://lore.kernel.org/r/20200630212517.308045-4-ben.widawsky@intel.com
Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/uapi/linux/mempolicy.h |  1 +
 mm/mempolicy.c                 | 44 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 19a00bc7fe86..046d0ccba4cd 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -22,6 +22,7 @@ enum {
 	MPOL_BIND,
 	MPOL_INTERLEAVE,
 	MPOL_LOCAL,
+	MPOL_PREFERRED_MANY,
 	MPOL_MAX,	/* always last member of enum */
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e90274..17b5800b7dcc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -31,6 +31,9 @@
  *                but useful to set in a VMA when you have a non default
  *                process policy.
  *
+ * preferred many Try a set of nodes first before normal fallback. This is
+ *                similar to preferred without the special case.
+ *
  * default        Allocate on the local node first, or when on a VMA
  *                use the process policy. This is what Linux always did
  *		  in a NUMA aware kernel and still does by, ahem, default.
@@ -207,6 +210,14 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
 	return 0;
 }
 
+static int mpol_new_preferred_many(struct mempolicy *pol, const nodemask_t *nodes)
+{
+	if (nodes_empty(*nodes))
+		return -EINVAL;
+	pol->nodes = *nodes;
+	return 0;
+}
+
 static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	if (nodes_empty(*nodes))
@@ -408,6 +419,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 	[MPOL_LOCAL] = {
 		.rebind = mpol_rebind_default,
 	},
+	[MPOL_PREFERRED_MANY] = {
+		.create = mpol_new_preferred_many,
+		.rebind = mpol_rebind_preferred,
+	},
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
@@ -900,6 +915,7 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
 		*nodes = p->nodes;
 		break;
 	case MPOL_LOCAL:
@@ -1446,7 +1462,13 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 {
 	*flags = *mode & MPOL_MODE_FLAGS;
 	*mode &= ~MPOL_MODE_FLAGS;
-	if ((unsigned int)(*mode) >= MPOL_MAX)
+
+	/*
+	 * The check should be 'mode >= MPOL_MAX', but as 'prefer_many'
+	 * is not fully implemented, don't permit it to be used for now,
+	 * and the logic will be restored in following patch
+	 */
+	if ((unsigned int)(*mode) >=  MPOL_PREFERRED_MANY)
 		return -EINVAL;
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
@@ -1887,7 +1909,8 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 /* Return the node id preferred by the given mempolicy, or the given id */
 static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 {
-	if (policy->mode == MPOL_PREFERRED) {
+	if (policy->mode == MPOL_PREFERRED ||
+	    policy->mode == MPOL_PREFERRED_MANY) {
 		nd = first_node(policy->nodes);
 	} else {
 		/*
@@ -1931,6 +1954,7 @@ unsigned int mempolicy_slab_node(void)
 
 	switch (policy->mode) {
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
 		return first_node(policy->nodes);
 
 	case MPOL_INTERLEAVE:
@@ -2063,6 +2087,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		*mask = mempolicy->nodes;
@@ -2173,10 +2198,12 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * node and don't fall back to other nodes, as the cost of
 		 * remote accesses would likely offset THP benefits.
 		 *
-		 * If the policy is interleave, or does not allow the current
-		 * node in its nodemask, we allocate the standard way.
+		 * If the policy is interleave or multiple preferred nodes, or
+		 * does not allow the current node in its nodemask, we allocate
+		 * the standard way.
 		 */
-		if (pol->mode == MPOL_PREFERRED)
+		if ((pol->mode == MPOL_PREFERRED ||
+		     pol->mode == MPOL_PREFERRED_MANY))
 			hpage_node = first_node(pol->nodes);
 
 		nmask = policy_nodemask(gfp, pol);
@@ -2311,6 +2338,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_LOCAL:
 		return true;
@@ -2451,6 +2479,9 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
+		if (node_isset(curnid, pol->nodes))
+			goto out;
 		polnid = first_node(pol->nodes);
 		break;
 
@@ -2829,6 +2860,7 @@ static const char * const policy_modes[] =
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
 	[MPOL_LOCAL]      = "local",
+	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
 
@@ -2907,6 +2939,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		if (!nodelist)
 			err = 0;
 		goto out;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 		/*
 		 * Insist on a nodelist
@@ -2993,6 +3026,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_LOCAL:
 		break;
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		nodes = pol->nodes;
-- 
2.7.4

