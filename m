Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA53D2117
	for <lists+linux-api@lfdr.de>; Thu, 22 Jul 2021 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhGVJB5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jul 2021 05:01:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42076 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhGVJB4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Jul 2021 05:01:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B9E471FEFF;
        Thu, 22 Jul 2021 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626946950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXJx37mOrxn26UUK1CevyaXcxyE38W8O3S0O2+ZWYbc=;
        b=lcUvBFndRTN58rETlosOwvD9Ti+VY+zvj4HaOxoZpYnQRMSYHyrVhTo7Mui97tnAcze9cF
        viVU2eRTN73ft6HP8r+uBom4ah8uBocQmkeF5apfbx3c7nR5NPftiu7LzwJAAbP/6NQqAV
        sDe+hpVRhefdau7xt2aeDEBGALeTzFw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 276F1A3B88;
        Thu, 22 Jul 2021 09:42:30 +0000 (UTC)
Date:   Thu, 22 Jul 2021 11:42:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v6 4/6] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
Message-ID: <YPk9hTQ5KQCv7KFw@dhcp22.suse.cz>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-5-git-send-email-feng.tang@intel.com>
 <7cdf88d8-9eea-5547-ee77-7d46829bf2dd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cdf88d8-9eea-5547-ee77-7d46829bf2dd@oracle.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 21-07-21 13:49:15, Mike Kravetz wrote:
> On 7/12/21 1:09 AM, Feng Tang wrote:
[...]
> > +#ifdef CONFIG_NUMA
> > +	if (mpol->mode == MPOL_PREFERRED_MANY) {
> > +		gfp_t gfp = (gfp_mask | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM;
> 
> I believe __GFP_NOWARN will be added later in alloc_buddy_huge_page, so
> no need to add here?

The mask is manipulated here anyway and the __GFP_NOWARN is really
telling that there is no need to report the failure for _this_
allocation request. alloc_surplus_huge_page might alter that in whatever
way in the future. So I would keep NOWARN here for the code clarity
rather than rely on some implicit assumption down the path.
-- 
Michal Hocko
SUSE Labs
