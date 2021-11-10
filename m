Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60A544C430
	for <lists+linux-api@lfdr.de>; Wed, 10 Nov 2021 16:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhKJPVE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Nov 2021 10:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhKJPVD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Nov 2021 10:21:03 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B45C061764
        for <linux-api@vger.kernel.org>; Wed, 10 Nov 2021 07:18:16 -0800 (PST)
Received: from localhost (unknown [151.44.43.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B40D666A2;
        Wed, 10 Nov 2021 15:18:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B40D666A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1636557495; bh=ZlvIct1YlHVmHRl5C1iZW3/1TCXS7uMjVjy8csW6Kdg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YW5NfrauweDi3VsUawuIev5ulzoXJPs/JATQl48sP70iEuY9K90fAqu7EEevIVa2A
         oRPU/IfqFqQdCdH1XR5t4ERVVpKugbhULWHuBhp/nxMxKiFxU7U9NSgQsMSwxlogBH
         wWIhjIitiXJCR78XKYNekTzMur9DRd8Tmt63lK1f+mGBXHDH5b3RSPlEIWg3qcl6Vz
         WasBXbuxcr7sYaTufV4SoDIOvoAYU8iiIvtuPCTAfrUSUftk8jaT3T63px5P/LAf+B
         JP/ckijNze+weU5PrQersVnsUXAA88Lnu0MwiSsYhOvdTC7Zdi31bEGt/tUH4OGFgz
         u+h3ec7e2XsBw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org
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
Subject: Re: [PATCH v4 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
In-Reply-To: <20211101050206.549050-3-aneesh.kumar@linux.ibm.com>
References: <20211101050206.549050-1-aneesh.kumar@linux.ibm.com>
 <20211101050206.549050-3-aneesh.kumar@linux.ibm.com>
Date:   Wed, 10 Nov 2021 08:18:10 -0700
Message-ID: <871r3okpjh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This syscall can be used to set a home node for the MPOL_BIND
> and MPOL_PREFERRED_MANY memory policy. Users should use this
> syscall after setting up a memory policy for the specified range
> as shown below.

So I noticed one little thing as I was looking at this...

[...]

> +SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
> +		unsigned long, home_node, unsigned long, flags)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	struct mempolicy *new;
> +	unsigned long vmstart;
> +	unsigned long vmend;
> +	unsigned long end;
> +	int err = -ENOENT;
> +
> +	if (start & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
> +	end = start + len;
> +
> +	if (end < start)
> +		return -EINVAL;
> +	if (end == start)
> +		return 0;
> +	mmap_write_lock(mm);
> +	vma = find_vma(mm, start);
> +	for (; vma && vma->vm_start < end;  vma = vma->vm_next) {
> +
> +		vmstart = max(start, vma->vm_start);
> +		vmend   = min(end, vma->vm_end);
> +		new = mpol_dup(vma_policy(vma));
> +		if (IS_ERR(new)) {
> +			err = PTR_ERR(new);
> +			break;
> +		}
> +		/*
> +		 * Only update home node if there is an existing vma policy
> +		 */
> +		if (!new)
> +			continue;
> +		new->home_node = home_node;
> +		err = mbind_range(mm, vmstart, vmend, new);
> +		if (err)
> +			break;
> +	}
> +	mmap_write_unlock(mm);
> +	return err;
> +}

You never do anything with flags; I believe you want to check and ensure
that it's zero if there are no defined flags at this point?

Thanks,

jon
