Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01810452B2A
	for <lists+linux-api@lfdr.de>; Tue, 16 Nov 2021 07:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhKPGrX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Nov 2021 01:47:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231688AbhKPGrR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Nov 2021 01:47:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AG3fZMr016433;
        Tue, 16 Nov 2021 06:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yBNLPV/a5jm78iEqB6kKPYDe73JPMYXDkH/CeGggn2A=;
 b=KzkRg/HFnWequTtBAt5Z8gDdLU6O4T60Di2508qFDCL6GqhXA03Xz7ofQ4bWhMibB4kX
 5KhGl8A7x+jXrlcM0Bz9Rw2fYt+EBbUv9TEWxwWBG6DgZjy6Pg4kgGCDEqc+gjwIWk0E
 NNE5kPLMLDjcExHxaA4b28wxXPYyZYpX6eBRJJObGOoETpQaRxqHlRmPaLUJ4TnGrjDD
 WhhBm0pyIoWY4K0DAthUeQQYsgzvkkUjUq6zzsYX+eDeI8tv9QkyQ/QXu36DdTup50rH
 xsEmMYIGcZhFOzEYRugOVvX/SLDVmJ+hwf3J6We1+7oIM1OpFEN6rtwNL6UgEPIK1nCQ Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cc4y62kqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 06:42:51 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AG6URbt018187;
        Tue, 16 Nov 2021 06:42:51 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cc4y62kqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 06:42:51 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AG6ghun023022;
        Tue, 16 Nov 2021 06:42:50 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 3ca50anuyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 06:42:50 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AG6gnBr13959900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 06:42:49 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75C226E05D;
        Tue, 16 Nov 2021 06:42:49 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C5906E056;
        Tue, 16 Nov 2021 06:42:44 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.124.74])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Nov 2021 06:42:43 +0000 (GMT)
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
Subject: [PATCH v5 1/3] mm/mempolicy: use policy_node helper with MPOL_PREFERRED_MANY
Date:   Tue, 16 Nov 2021 12:12:36 +0530
Message-Id: <20211116064238.727454-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M1xaKSCaJe2oDzGGg_8AN0j9r8CSAraF
X-Proofpoint-ORIG-GUID: ITmh0cb0AYBhWfFwnRG3V7ELK-W_N6BO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_16,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160034
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
index 10e9c87260ed..673b5fb13346 100644
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

