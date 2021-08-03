Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505983DE677
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 07:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhHCF7m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 01:59:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:34927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233927AbhHCF7m (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Aug 2021 01:59:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235529234"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="235529234"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 22:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="479233322"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2021 22:59:27 -0700
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
Subject: [PATCH v7 1/5] mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
Date:   Tue,  3 Aug 2021 13:59:18 +0800
Message-Id: <1627970362-61305-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
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

[Michal Hocko: suggest to refine policy_node/policy_nodemask handling]
Link: https://lore.kernel.org/r/20200630212517.308045-4-ben.widawsky@intel.com
Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/uapi/linux/mempolicy.h |  1 +
 mm/mempolicy.c                 | 73 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 14 deletions(-)

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
index e675bfb856da..72f7ff760989 100644
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
@@ -1875,16 +1897,27 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
  */
 nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
+	int mode = policy->mode;
+
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
-	if (unlikely(policy->mode == MPOL_BIND) &&
-			apply_policy_zone(policy, gfp_zone(gfp)) &&
-			cpuset_nodemask_valid_mems_allowed(&policy->nodes))
+	if (unlikely(mode == MPOL_BIND) &&
+		apply_policy_zone(policy, gfp_zone(gfp)) &&
+		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
+		return &policy->nodes;
+
+	if (mode == MPOL_PREFERRED_MANY)
 		return &policy->nodes;
 
 	return NULL;
 }
 
-/* Return the node id preferred by the given mempolicy, or the given id */
+/*
+ * Return the  preferred node id for 'prefer' mempolicy, and return
+ * the given id for all other policies.
+ *
+ * policy_node() is always coupled with policy_nodemask(), which
+ * secures the nodemask limit for 'bind' and 'prefer-many' policy.
+ */
 static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 {
 	if (policy->mode == MPOL_PREFERRED) {
@@ -1936,7 +1969,9 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
-	case MPOL_BIND: {
+	case MPOL_BIND:
+	case MPOL_PREFERRED_MANY:
+	{
 		struct zoneref *z;
 
 		/*
@@ -2008,12 +2043,12 @@ static inline unsigned interleave_nid(struct mempolicy *pol,
  * @addr: address in @vma for shared policy lookup and interleave policy
  * @gfp_flags: for requested zone
  * @mpol: pointer to mempolicy pointer for reference counted mempolicy
- * @nodemask: pointer to nodemask pointer for MPOL_BIND nodemask
+ * @nodemask: pointer to nodemask pointer for 'bind' and 'prefer-many' policy
  *
  * Returns a nid suitable for a huge page allocation and a pointer
  * to the struct mempolicy for conditional unref after allocation.
- * If the effective policy is 'BIND, returns a pointer to the mempolicy's
- * @nodemask for filtering the zonelist.
+ * If the effective policy is 'bind' or 'prefer-many', returns a pointer
+ * to the mempolicy's @nodemask for filtering the zonelist.
  *
  * Must be protected by read_mems_allowed_begin()
  */
@@ -2021,16 +2056,18 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 				struct mempolicy **mpol, nodemask_t **nodemask)
 {
 	int nid;
+	int mode;
 
 	*mpol = get_vma_policy(vma, addr);
-	*nodemask = NULL;	/* assume !MPOL_BIND */
+	*nodemask = NULL;
+	mode = (*mpol)->mode;
 
-	if (unlikely((*mpol)->mode == MPOL_INTERLEAVE)) {
+	if (unlikely(mode == MPOL_INTERLEAVE)) {
 		nid = interleave_nid(*mpol, vma, addr,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
 		nid = policy_node(gfp_flags, *mpol, numa_node_id());
-		if ((*mpol)->mode == MPOL_BIND)
+		if (mode == MPOL_BIND || mode == MPOL_PREFERRED_MANY)
 			*nodemask = &(*mpol)->nodes;
 	}
 	return nid;
@@ -2063,6 +2100,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		*mask = mempolicy->nodes;
@@ -2173,7 +2211,7 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * node and don't fall back to other nodes, as the cost of
 		 * remote accesses would likely offset THP benefits.
 		 *
-		 * If the policy is interleave, or does not allow the current
+		 * If the policy is interleave or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
 		if (pol->mode == MPOL_PREFERRED)
@@ -2311,6 +2349,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_LOCAL:
 		return true;
@@ -2451,6 +2490,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_PREFERRED:
+		if (node_isset(curnid, pol->nodes))
+			goto out;
 		polnid = first_node(pol->nodes);
 		break;
 
@@ -2465,9 +2506,10 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 				break;
 			goto out;
 		}
+		fallthrough;
 
+	case MPOL_PREFERRED_MANY:
 		/*
-		 * allows binding to multiple nodes.
 		 * use current page if in policy nodemask,
 		 * else select nearest allowed node, if any.
 		 * If no allowed nodes, use current [!misplaced].
@@ -2829,6 +2871,7 @@ static const char * const policy_modes[] =
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
 	[MPOL_LOCAL]      = "local",
+	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
 
@@ -2907,6 +2950,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		if (!nodelist)
 			err = 0;
 		goto out;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 		/*
 		 * Insist on a nodelist
@@ -2993,6 +3037,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_LOCAL:
 		break;
 	case MPOL_PREFERRED:
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		nodes = pol->nodes;
-- 
2.14.1

