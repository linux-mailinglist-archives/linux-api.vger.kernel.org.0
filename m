Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35C03DD1B3
	for <lists+linux-api@lfdr.de>; Mon,  2 Aug 2021 10:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhHBILq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Aug 2021 04:11:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:8886 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232632AbhHBILq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 2 Aug 2021 04:11:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="277179494"
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="277179494"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 01:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="520389366"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2021 01:11:31 -0700
Date:   Mon, 2 Aug 2021 16:11:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <20210802081130.GA42490@shbuild999.sh.intel.com>
References: <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
 <20210728141156.GC43486@shbuild999.sh.intel.com>
 <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
 <20210729070918.GA96680@shbuild999.sh.intel.com>
 <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
 <20210729151242.GA42865@shbuild999.sh.intel.com>
 <YQLVf3pkQTHLemAZ@dhcp22.suse.cz>
 <20210730030502.GA87066@shbuild999.sh.intel.com>
 <YQOeAgPS9+FUseIx@dhcp22.suse.cz>
 <20210730071840.GA87305@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730071840.GA87305@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:40PM +0800, Tang, Feng wrote:
[snip]
> > > One thing is, it's possible that 'nd' is not set in the preferred
> > > nodemask. 
> > 
> > Yes, and there shouldn't be any problem with that.  The given node is
> > only used to get the respective zonelist (order distance ordered list of
> > zones to try). get_page_from_freelist will then use the preferred node
> > mask to filter this zone list. Is that more clear now?
> 
> Yes, from the code, the policy_node() is always coupled with
> policy_nodemask(), which secures the 'nodemask' limit. Thanks for
> the clarification!

Hi Michal,

To ensure the nodemask limit, the policy_nodemask() also needs some
change to return the nodemask for 'prefer-many' policy, so here is a
updated 1/6 patch, which mainly changes the node/nodemask selection
for 'prefer-many' policy, could you review it? thanks!

- Feng

------8<-------------------------------------------------------
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
index e675bfb856da..ea97530f86db 100644
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
@@ -1875,8 +1897,13 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
  */
 nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
-	/* Lower zones don't get a nodemask applied for MPOL_BIND */
-	if (unlikely(policy->mode == MPOL_BIND) &&
+	int mode = policy->mode;
+
+	/*
+	 * Lower zones don't get a nodemask applied for 'bind' and
+	 * 'prefer-many' policies
+	 */
+	if (unlikely(mode == MPOL_BIND || mode == MPOL_PREFERRED_MANY) &&
 			apply_policy_zone(policy, gfp_zone(gfp)) &&
 			cpuset_nodemask_valid_mems_allowed(&policy->nodes))
 		return &policy->nodes;
@@ -1884,7 +1911,13 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 	return NULL;
 }
 
-/* Return the node id preferred by the given mempolicy, or the given id */
+/*
+ * Return the  preferred node id for 'prefer' mempolicy, and return
+ * the given id for all other policies.
+ *
+ * policy_node() is always coupbled with policy_nodemask(), which
+ * secures the the nodemask limit for 'bind' and 'prefer-many' policy.
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
@@ -2008,7 +2043,7 @@ static inline unsigned interleave_nid(struct mempolicy *pol,
  * @addr: address in @vma for shared policy lookup and interleave policy
  * @gfp_flags: for requested zone
  * @mpol: pointer to mempolicy pointer for reference counted mempolicy
- * @nodemask: pointer to nodemask pointer for MPOL_BIND nodemask
+ * @nodemask: pointer to nodemask pointer for 'bind' and 'prefer-many' policy
  *
  * Returns a nid suitable for a huge page allocation and a pointer
  * to the struct mempolicy for conditional unref after allocation.
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
