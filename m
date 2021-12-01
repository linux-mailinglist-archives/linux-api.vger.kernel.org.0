Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF30464714
	for <lists+linux-api@lfdr.de>; Wed,  1 Dec 2021 07:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbhLAGUL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Dec 2021 01:20:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1346866AbhLAGUK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Dec 2021 01:20:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B14plF5009384;
        Wed, 1 Dec 2021 06:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=45sl5+gG9/zE9FU7uGSF93cJvmgBFbhYUclGGRzq5uU=;
 b=p98H3p5BhdktOfY0a0rYNT//TvDrEh2xbtf3x4mlYiHQGRDgR/FAmQmoWR9PP/qxFPDR
 VnOL+pND1VmAy0GCuXY6ET5YZeIq0QA5KMKlskSPtiktLdQ1B/lJ616n+Vd1Eu/w3tfZ
 7HDjGimp5I7niTOAtZ+706y0gaOwBGFVdQiaWd3C5RT/vR1qX6Mbyq6MWEMNdzTXjCcy
 uk0CLPpsNiPpWClF2QGt5/785xffFB+bhmow0RmavUIfRT/rcXxE6vx8WmmFQsxS1f/M
 rRAN5LIOQgQKsNfjtyIAf1HlQ5N63TNEhPdu3e+cAd5oQB6ve2tsjBLDz2JUEq3Tjc2S DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cp2d81aqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 06:15:33 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B152afs011795;
        Wed, 1 Dec 2021 06:15:30 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cp2d81aqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 06:15:30 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B168eLF022334;
        Wed, 1 Dec 2021 06:15:29 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 3ckcac8y82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 06:15:29 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B16FRa915204784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 06:15:27 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A96DE124053;
        Wed,  1 Dec 2021 06:15:27 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A11B12405C;
        Wed,  1 Dec 2021 06:15:21 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.38.73])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 06:15:21 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
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
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
In-Reply-To: <20211201004758.boix3k76bjtz2p4u@oracle.com>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <20211201004758.boix3k76bjtz2p4u@oracle.com>
Date:   Wed, 01 Dec 2021 11:45:14 +0530
Message-ID: <87tufsc0lp.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fsXirh7_1ayG8a7rEcy0Lt_3KYEOPOmf
X-Proofpoint-ORIG-GUID: Dw2KghJQ5rfuFiF8bEhWvAcKhMUX3Zd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010034
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Tue, Nov 16, 2021 at 12:12:37PM +0530, Aneesh Kumar K.V wrote:
>> sys_set_mempolicy_home_node((unsigned long)p, nr_pages * page_size,
>> 				  home_node, 0);
>
> What about sys_mbind_home_node so the name is better aligned with mbind,
> since both operate on vma policy?  The syscall might or might not be
> extended to task memory policy, but vma policy is what we're using this
> for today.

I used the name set_mempolicy_home_node, because we are setting the home
for a memory policy. I find the term mbind confusing. 

>
>
>> +SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
>> +		unsigned long, home_node, unsigned long, flags)
>
> mbind does untagged_addr(addr), why doesn't this need to do the same?
> Seems like tagged addresses could be passed here too.
>

updated
modified   mm/mempolicy.c
@@ -1489,6 +1489,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 	unsigned long end;
 	int err = -ENOENT;
 
+	start = untagged_addr(start);
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
 	/*



>
>> +		/*
>> +		 * Only update home node if there is an existing vma policy
>> +		 */
>> +		if (!new)
>> +			continue;
>> +		new->home_node = home_node;
>> +		err = mbind_range(mm, vmstart, vmend, new);
>
> I think you need an mpol_put(new) here since @new is dup'ed again during
> mbind_range > vma_replace_policy.

updated
@@ -1536,6 +1540,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 
 		new->home_node = home_node;
 		err = mbind_range(mm, vmstart, vmend, new);
+		mpol_put(new);
 		if (err)
 			break;
 	}


Thanks for your review
-aneesh
