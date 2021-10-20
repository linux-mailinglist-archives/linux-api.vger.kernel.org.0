Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8617D4347DD
	for <lists+linux-api@lfdr.de>; Wed, 20 Oct 2021 11:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTJ1v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Oct 2021 05:27:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229503AbhJTJ1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Oct 2021 05:27:50 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K8hbZH008319;
        Wed, 20 Oct 2021 05:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HOGHmzqpzsOdwB/Bqi0kaipplO7h8QHSumoPfiY7EJk=;
 b=OK6x77bm+O1bh/7uqLnPLU18WMdI9bGw8u03eKTNKZuM6Ws7yTb5sFT8wQysWmTWjQuv
 F8hNW2K10gimEuLR33PkX50jj+ITvpt7D9jlFp8ivw+LgF04x1gWTZRKMTnUxOgQJjnd
 MlP5GEN1WrQwWFeRSyQdSTSv9MACoReAKCj+yMhn8p6De4vt4uyhlgd0U2PewwUMkeKO
 8NZRNO16bGaJ2OUCghWxG04Mjms2GNdbt+kCqUtaw3R0hNCwEoFd4bG6RdyM7XbCTzq1
 uob8UsvOb/oUi1+uBKDYf09mXqiMtmWYWcII+rf0eJaal2GOPUWD+31Og8d8MefhXNP4 Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3btekqjcm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 05:25:16 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19K9PGEb002559;
        Wed, 20 Oct 2021 05:25:16 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3btekqjcku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 05:25:16 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19K9HWbC013123;
        Wed, 20 Oct 2021 09:25:15 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3bqpccjv93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 09:25:15 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19K9PE0A28377516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 09:25:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F7BEBE058;
        Wed, 20 Oct 2021 09:25:14 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34A26BE05A;
        Wed, 20 Oct 2021 09:25:08 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.103.88])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 09:25:07 +0000 (GMT)
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
Subject: [RFC PATCH v2 1/3] mm/mempolicy: use policy_node helper with MPOL_PREFERRED_MANY
Date:   Wed, 20 Oct 2021 14:54:51 +0530
Message-Id: <20211020092453.179929-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iG9v2vf4byP1moR6l-mGvYafZBMPnrQV
X-Proofpoint-GUID: uG0JLlILDPohXSpqiyOOCRNh3y9blkcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200051
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
index 1592b081c58e..6f0f607cd070 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2067,7 +2067,7 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 	page = __alloc_pages(preferred_gfp, order, nid, &pol->nodes);
 	if (!page)
-		page = __alloc_pages(gfp, order, numa_node_id(), NULL);
+		page = __alloc_pages(gfp, order, nid, NULL);
 
 	return page;
 }
@@ -2108,6 +2108,7 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	}
 
 	if (pol->mode == MPOL_PREFERRED_MANY) {
+		node = policy_node(gfp, pol, node);
 		page = alloc_pages_preferred_many(gfp, order, node, pol);
 		mpol_cond_put(pol);
 		goto out;
@@ -2192,7 +2193,7 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
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

