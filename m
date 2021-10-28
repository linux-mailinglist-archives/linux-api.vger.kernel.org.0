Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5749E43DD3A
	for <lists+linux-api@lfdr.de>; Thu, 28 Oct 2021 10:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1JAS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Oct 2021 05:00:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhJ1JAP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Oct 2021 05:00:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S7HTtJ003539;
        Thu, 28 Oct 2021 08:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yzP1sRl2XHUwlMcaDx2oXZtZvjVgXg6KwtPNJGUlscM=;
 b=r69kGEntBFE8z3CP3eLGHF7t9aBTJ1UTq0pDJLuphprq+TLWZ3jx3CpS6hhAP2N0EIvb
 yJCFkZackAfFWybbBAiPbBRZNZEmsis/v8xTx6vKgIdcKOHY191GyhQf2JGfjjPP4YIu
 D2Rp6I+Q7Ps909bu3ik0BDGjtG5TLmifepya/CbmUEAzuE+UdmErqa0OtdrY/CfXTFBr
 DuUhML9fVPXzuADiQmcTHl8BU4yFE7zj9KH3/HYTX360Y1eq+bITg1XAi2zZU48WIgcd
 2b28oCqs69VaPLRorI6NONqvm1diZEOe2v6J9UjWqVI06IpS90qKcXJxYpsk8/2kaIm5 Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byqbghws9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 08:57:34 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19S8SDfu028746;
        Thu, 28 Oct 2021 08:57:34 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byqbghwrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 08:57:34 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19S8q5tq014964;
        Thu, 28 Oct 2021 08:57:32 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3bx4emc0b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 08:57:32 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19S8vVkS14156238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 08:57:31 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 030E66E095;
        Thu, 28 Oct 2021 08:57:31 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F29C96E05F;
        Thu, 28 Oct 2021 08:57:23 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.43.151])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Oct 2021 08:57:23 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: [PATCH v3 1/3] mm/mempolicy: use policy_node helper with MPOL_PREFERRED_MANY
Date:   Thu, 28 Oct 2021 14:26:59 +0530
Message-Id: <20211028085701.505593-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211028085701.505593-1-aneesh.kumar@linux.ibm.com>
References: <20211028085701.505593-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qpdWuye1itNTjaILPrsQx8s0BTJJn8a4
X-Proofpoint-ORIG-GUID: 58pEz6F-kQNUvmYjv_HG2cTL7fW52GRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280044
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A followup patch will enable setting a home node with MPOL_PREFERRED_MANY
memory policy. To facilitate that switch to using policy_node helper.
There is no functional change in this patch.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: linux-api@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/mempolicy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d12e0608fced..35a0e72c74a3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2061,7 +2061,7 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 	page = __alloc_pages(preferred_gfp, order, nid, &pol->nodes);
 	if (!page)
-		page = __alloc_pages(gfp, order, numa_node_id(), NULL);
+		page = __alloc_pages(gfp, order, nid, NULL);
 
 	return page;
 }
@@ -2102,6 +2102,7 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	}
 
 	if (pol->mode == MPOL_PREFERRED_MANY) {
+		node = policy_node(gfp, pol, node);
 		page = alloc_pages_preferred_many(gfp, order, node, pol);
 		mpol_cond_put(pol);
 		goto out;
@@ -2186,7 +2187,7 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	else if (pol->mode == MPOL_PREFERRED_MANY)
 		page = alloc_pages_preferred_many(gfp, order,
-				numa_node_id(), pol);
+				  policy_node(gfp, pol, numa_node_id()), pol);
 	else
 		page = __alloc_pages(gfp, order,
 				policy_node(gfp, pol, numa_node_id()),
-- 
2.31.1

