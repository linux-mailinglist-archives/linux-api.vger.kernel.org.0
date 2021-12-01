Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C999464720
	for <lists+linux-api@lfdr.de>; Wed,  1 Dec 2021 07:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhLAGZw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Dec 2021 01:25:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231871AbhLAGZv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Dec 2021 01:25:51 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B15cIAX002218;
        Wed, 1 Dec 2021 06:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=60VzF9r60QMTqaKczXpfroOZx9CoVrufBeApKEeEhdE=;
 b=CL4fIp146CgvqdH99mh25BGxxFOSfJ3fIF1XHFSgOqv1lCoPSjYzJ+/pR0ueh017vi4a
 hbzfuxpkxjmQK+uEa6Rb40XK+ebbivqHAOuWsJXgXGaNvVnA1/ET67pEu6IyKr5YCXP/
 NFVjfyttjd92Vkks8ZihLNhvXQJDi6fURSoWB+HD3vcfv/x0yUWygwtziZQmUN+beNh7
 y4sFW41qaTHl8iOrDhgYo7rFvnKnOMjIPFGUNCXjzFQwICqiUFoGHsIyiyluELVhTi88
 IzxtFK3doxDsdCeUrxRzMD6szdfcydlzqf6q7O3W8eDUTfuzroM9npqgkfJehK1kkDoD gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cp2sprwv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 06:22:18 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B16IRMv007562;
        Wed, 1 Dec 2021 06:22:17 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cp2sprwuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 06:22:17 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B16Ld2T003867;
        Wed, 1 Dec 2021 06:22:16 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcabdegp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 06:22:16 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B16MFG553936436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 06:22:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A7DB6E054;
        Wed,  1 Dec 2021 06:22:15 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C9A16E052;
        Wed,  1 Dec 2021 06:22:10 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.38.73])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 06:22:09 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Ben Widawsky <ben.widawsky@intel.com>,
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
In-Reply-To: <20211130190028.6644054bc7142af36ef5c648@linux-foundation.org>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <20211129140215.11b7cf9f1034a7fe7017768c@linux-foundation.org>
 <87wnkqaujt.fsf@linux.ibm.com>
 <20211130190028.6644054bc7142af36ef5c648@linux-foundation.org>
Date:   Wed, 01 Dec 2021 11:52:08 +0530
Message-ID: <87r1awc0a7.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UcOHq32OOeGqmNWdexe8uvVDdw-l_AHv
X-Proofpoint-GUID: BHEz3vFUC4OE8XTXBNGuBLyD2SuxBoIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010034
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 30 Nov 2021 14:29:02 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>
>> > What's the thinking here?  The node can later be offlined and the
>> > kernel takes no action to reset home nodes, so why not permit setting a
>> > presently-offline node as the home node?  Checking here seems rather
>> > arbitrary?
>> 
>> The node online check was needed to avoid accessing 
>> uninitialised pgdat structure. Such an access can result in
>> below crash
>
> Oh.  This is unobvious from reading the code.  Which calls for a
> comment, no?

updated

@@ -1497,6 +1498,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 	if (flags != 0)
 		return -EINVAL;
 
+	/*
+	 * Check home_node is online to avoid accessing uninitialized
+	 * NODE_DATA.
+	 */
 	if (home_node >= MAX_NUMNODES || !node_online(home_node))
 		return -EINVAL;
