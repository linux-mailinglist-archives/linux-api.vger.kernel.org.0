Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32089461700
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 14:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhK2Nwv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 08:52:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241424AbhK2Nuv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 08:50:51 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDkWYE016303;
        Mon, 29 Nov 2021 13:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=Ahzwc80kop1+lL4IXn616uFAorDZ5jdxqXCW6i2Hs1s=;
 b=NOlw6u3CxFaxSTDQ71ehsdBFGYUR/OiHHWloETBrE6fVk/k8qdVIRi85KlvRpNOrgUPX
 Zd4L/QYmSOZSJrIauoUhxcQGXSCwTGNkxaE1qu26d9omf/XxHLP3gVHU5ogFyA4ES5Ho
 /3raKY/RbhYoS2jwdvIY69MN320uQ4CkScbQK5YA/pNSNrkifMljPGE+K6BbfiGJWEb2
 YLlSEY3+IZBRT9um5QEWcYkNJgf05V55Fvu3dTcfLQ9silC1c36CIzs4mgqJz3dqRNq7
 m/s9IOeCqtFoHCTJqfSvWsLXOlnoD35nu/mhOyMq6F2ho9soH9ZZM9PbSykMinRVWJ2Q BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn01w80df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:47:18 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATDkk02019696;
        Mon, 29 Nov 2021 13:47:18 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn01w80d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:47:17 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDg55m031793;
        Mon, 29 Nov 2021 13:47:16 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcaa23u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:47:16 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATDlFG763177168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 13:47:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7357212405E;
        Mon, 29 Nov 2021 13:47:15 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DE66124058;
        Mon, 29 Nov 2021 13:47:09 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.15.168])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 13:47:08 +0000 (GMT)
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
In-Reply-To: <YaTLVCKl9t5RCfQR@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <YaSsR0z6GN07qyH7@dhcp22.suse.cz> <87fsrf1bpu.fsf@linux.ibm.com>
 <YaTLVCKl9t5RCfQR@dhcp22.suse.cz>
Date:   Mon, 29 Nov 2021 19:17:06 +0530
Message-ID: <8735nfcbvp.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q_vXlqoE_1qF_fJ3eqIiq6Tq9VRQHn1Q
X-Proofpoint-GUID: 0uqYTpn9--5nb4xZNrIInWlZZvlRqwCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290068
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Mon 29-11-21 16:16:05, Aneesh Kumar K.V wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Tue 16-11-21 12:12:37, Aneesh Kumar K.V wrote:
> [...]
>> >> +SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
>> >> +		unsigned long, home_node, unsigned long, flags)
>> >> +{
>> >> +	struct mm_struct *mm = current->mm;
>> >> +	struct vm_area_struct *vma;
>> >> +	struct mempolicy *new;
>> >> +	unsigned long vmstart;
>> >> +	unsigned long vmend;
>> >> +	unsigned long end;
>> >> +	int err = -ENOENT;
>> >> +
>> >> +	if (start & ~PAGE_MASK)
>> >> +		return -EINVAL;
>> >> +	/*
>> >> +	 * flags is used for future extension if any.
>> >> +	 */
>> >> +	if (flags != 0)
>> >> +		return -EINVAL;
>> >> +
>> >> +	if (!node_online(home_node))
>> >> +		return -EINVAL;
>> >
>> > You really want to check the home_node before dereferencing the mask.
>> >
>> 
>> Any reason why we want to check for home node first?
>
> Because the given node is an index to node_states[N_ONLINE] bitmap. I do
> not think we do range checking there.

Will add this

	if (home_node >= MAX_NUMNODES || !node_online(home_node))
		return -EINVAL;



>
>> >> +	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
>> >> +	end = start + len;
>> >> +
>> >> +	if (end < start)
>> >> +		return -EINVAL;
>> >> +	if (end == start)
>> >> +		return 0;
>> >> +	mmap_write_lock(mm);
>> >> +	vma = find_vma(mm, start);
>> >> +	for (; vma && vma->vm_start < end;  vma = vma->vm_next) {
>> >> +
>> >> +		vmstart = max(start, vma->vm_start);
>> >> +		vmend   = min(end, vma->vm_end);
>> >> +		new = mpol_dup(vma_policy(vma));
>> >> +		if (IS_ERR(new)) {
>> >> +			err = PTR_ERR(new);
>> >> +			break;
>> >> +		}
>> >> +		/*
>> >> +		 * Only update home node if there is an existing vma policy
>> >> +		 */
>> >> +		if (!new)
>> >> +			continue;
>> >
>> > Your changelog only mentions MPOL_BIND and MPOL_PREFERRED_MANY as
>> > supported but you seem to be applying the home node to all existing
>> > policieso
>> 
>> 
>> The restriction is done in policy_node. 
>> 
>> @@ -1801,6 +1856,11 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
>> 		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
>> 	}
>> 
>> +	if ((policy->mode == MPOL_BIND ||
>> +	     policy->mode == MPOL_PREFERRED_MANY) &&
>> +	    policy->home_node != NUMA_NO_NODE)
>> +		return policy->home_node;
>> +
>> 	return nd;
>>  }
>
> But you do allow to set the home node also for other policies and that
> means that a default MPOL_INTERLEAVE would be different from the one
> with home_node set up even though they behave exactly the same.

I agree that there is no error returned if we try to set the home_node
for other memory policies. But there should not be any behaviour
differences. We ignore home_node for policies other than BIND and
PREFERRED_MANY.

The reason I avoided erroring out for other policies was to simplify the
error handling. For example, for a range of addr with a mix of memory
policy MPOLD_BIND and MPOL_INTERLEAVE what should be the state after the
above system call? We could say, we ignore setting home_node for vma
with policy MPOL_INTERLEAVE and leave the home node set for vma with
policy MPOL_BIND. Or should we make the system call return error also
undoing the changes done for vmas for which we have set the home_node?

-aneesh
