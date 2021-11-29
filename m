Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C574D461A8F
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 16:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhK2PEw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 10:04:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234653AbhK2PCw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 10:02:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATEmKbn006810;
        Mon, 29 Nov 2021 14:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=kV66JP31X0cgtw64a0HT5jYYLBjQhNxz3SxOikZpkc0=;
 b=DfMmfPK7Pp7hXn1WL5+PPmAoLd0P7x7eCOIg5+P32bcLC6smzNW20E2Oqb9/sUJ5MSQo
 N05p2YoXSeF9E7QbxSC1/BiAWjIP0rIrfGUL1qXqKDFxiX0ZijAHg9ylHT6Z7Mqr0Kq5
 ldQDgpA6Te5isl+fItDlFdp8E+8qALUUyV/khy5e7w9M1HgBtO1ObflJsQKVZqKrC1VK
 Pg38JRb3Wm+SOY1eJUe6fGOkWtd/oC8XmGuI3TmFPP8Ce/Xsm2RNdoCHLIy5422iUw8U
 68UheqwUYvvmTOE77zKOXWu5x6D5tY4of6NLfsqkT/GIPdD/YrUh3a2i8kOhAxvKwSbO kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn0xur714-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:59:17 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATExG9r017346;
        Mon, 29 Nov 2021 14:59:16 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn0xur70p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:59:16 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATEhGT4029750;
        Mon, 29 Nov 2021 14:59:15 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3ckcaamgwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:59:15 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATExEBF58261824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 14:59:14 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7854FAE076;
        Mon, 29 Nov 2021 14:59:14 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C40EAE06A;
        Mon, 29 Nov 2021 14:59:08 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.15.168])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 14:59:07 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
In-Reply-To: <YaTpNJep2OXBkRLe@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <YaSsR0z6GN07qyH7@dhcp22.suse.cz> <87fsrf1bpu.fsf@linux.ibm.com>
 <YaTLVCKl9t5RCfQR@dhcp22.suse.cz> <8735nfcbvp.fsf@linux.ibm.com>
 <YaTpNJep2OXBkRLe@dhcp22.suse.cz>
Date:   Mon, 29 Nov 2021 20:29:05 +0530
Message-ID: <87zgpnatza.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fuDVD3EYwghDoLVtz6nPZ3n99lccpSBC
X-Proofpoint-ORIG-GUID: t6AYO2LT6Hxrov9J6htpugsjdc_4OziP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=973 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290073
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Mon 29-11-21 19:17:06, Aneesh Kumar K.V wrote:
>> Michal Hocko <mhocko@suse.com> writes:
> [...]
>> > But you do allow to set the home node also for other policies and that
>> > means that a default MPOL_INTERLEAVE would be different from the one
>> > with home_node set up even though they behave exactly the same.
>> 
>> I agree that there is no error returned if we try to set the home_node
>> for other memory policies. But there should not be any behaviour
>> differences. We ignore home_node for policies other than BIND and
>> PREFERRED_MANY.
>> 
>> The reason I avoided erroring out for other policies was to simplify the
>> error handling.
>
> But this leads to a future extensions problems. How do you tell whether
> a specific policy has a support for home node?
>
>> For example, for a range of addr with a mix of memory
>> policy MPOLD_BIND and MPOL_INTERLEAVE what should be the state after the
>> above system call?
>
> Do we even allow to combinate different memory policies?
>
>> We could say, we ignore setting home_node for vma
>> with policy MPOL_INTERLEAVE and leave the home node set for vma with
>> policy MPOL_BIND. Or should we make the system call return error also
>> undoing the changes done for vmas for which we have set the home_node?
>
> The error behavior is really nasty with the existing behavior. The
> caller has no way to tell which vmas have been updated. The only way is
> to query the state. So if we return an error because of an incompatible
> mempolicy in place we are not much worse than now. If the "error" is
> silent then we establish a dependency on the specific implementation.

How about
	for (; vma && vma->vm_start < end;  vma = vma->vm_next) {

		vmstart = max(start, vma->vm_start);
		vmend   = min(end, vma->vm_end);
		new = mpol_dup(vma_policy(vma));
		if (IS_ERR(new)) {
			err = PTR_ERR(new);
			break;
		}
		/*
		 * Only update home node if there is an existing vma policy
		 */
		if (!new)
			continue;

		/*
		 * If any vma in the range got policy other than MPOL_BIND
		 * or MPOL_PREFERRED_MANY we return error. We don't reset
		 * the home node for vmas we already updated before.
		 */
		if (new->mode != MPOL_BIND && new->mode != MPOL_PREFERRED_MANY) {
			err = -EINVAL;
			break;
		}


....

