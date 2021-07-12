Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A616E3C566F
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbhGLISW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 04:18:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:12162 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354224AbhGLIPR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Jul 2021 04:15:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="190322287"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="190322287"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 01:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="459109422"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Jul 2021 01:10:01 -0700
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
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v6 6/6] mm/mempolicy: unify the create() func for bind/interleave/prefer-many policies
Date:   Mon, 12 Jul 2021 16:09:34 +0800
Message-Id: <1626077374-81682-7-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As they all do the same thing: sanity check and save nodemask info, create
one mpol_new_nodemask() to reduce redundancy.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d90247d6a71b..e5ce5a7e8d92 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -192,7 +192,7 @@ static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
 	nodes_onto(*ret, tmp, *rel);
 }
 
-static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
+static int mpol_new_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	if (nodes_empty(*nodes))
 		return -EINVAL;
@@ -210,22 +210,6 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
 	return 0;
 }
 
-static int mpol_new_preferred_many(struct mempolicy *pol, const nodemask_t *nodes)
-{
-	if (nodes_empty(*nodes))
-		return -EINVAL;
-	pol->nodes = *nodes;
-	return 0;
-}
-
-static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
-{
-	if (nodes_empty(*nodes))
-		return -EINVAL;
-	pol->nodes = *nodes;
-	return 0;
-}
-
 /*
  * mpol_set_nodemask is called after mpol_new() to set up the nodemask, if
  * any, for the new policy.  mpol_new() has already validated the nodes
@@ -405,7 +389,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.rebind = mpol_rebind_default,
 	},
 	[MPOL_INTERLEAVE] = {
-		.create = mpol_new_interleave,
+		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_nodemask,
 	},
 	[MPOL_PREFERRED] = {
@@ -413,14 +397,14 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.rebind = mpol_rebind_preferred,
 	},
 	[MPOL_BIND] = {
-		.create = mpol_new_bind,
+		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_nodemask,
 	},
 	[MPOL_LOCAL] = {
 		.rebind = mpol_rebind_default,
 	},
 	[MPOL_PREFERRED_MANY] = {
-		.create = mpol_new_preferred_many,
+		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_preferred,
 	},
 };
-- 
2.7.4

