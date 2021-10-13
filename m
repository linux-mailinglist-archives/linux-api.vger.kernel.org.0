Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0542C30E
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 16:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhJMO1J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 10:27:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41844 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbhJMOYn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 10:24:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E1B802020F;
        Wed, 13 Oct 2021 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634134960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgW6zz17iHLG0f48fp6yDV9PEDwsZc2MTenVsfHVmx8=;
        b=rL+KEX2qRPBz9nWbfX0e79uywLYwPklIN2VDwVn+M0wLflhDxCa7I0iWXzT6Bfesc0ugXx
        Fw/tI/TdTsCAmp8pck92EmifhepBl+djBs+7+5lrqL+CYkTjl3veAILIqrFBWoCKqwxrqv
        BBblBuc/1hxw514DP91kWV85hKqS4ag=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12F01A3B8C;
        Wed, 13 Oct 2021 14:22:35 +0000 (UTC)
Date:   Wed, 13 Oct 2021 16:22:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Subject: Re: [RFC PATCH] mm/mempolicy: add MPOL_PREFERRED_STRICT memory policy
Message-ID: <YWbrr2vgLb32JZQ3@dhcp22.suse.cz>
References: <20211013094539.962357-1-aneesh.kumar@linux.ibm.com>
 <YWa4FoicH0VztGTl@dhcp22.suse.cz>
 <YWa5geHLIPe2aUxB@dhcp22.suse.cz>
 <4399a215-296f-e880-c5f4-8065ab13d210@linux.ibm.com>
 <YWbWDlpQzQ9GC+B6@dhcp22.suse.cz>
 <9a0baa59-f316-103f-3030-990cd91d1813@linux.ibm.com>
 <YWbaAv/RGt+SCnql@dhcp22.suse.cz>
 <adc63bf3-b8b6-c705-805d-a84633a7f728@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc63bf3-b8b6-c705-805d-a84633a7f728@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 13-10-21 18:40:26, Aneesh Kumar K.V wrote:
> On 10/13/21 18:37, Michal Hocko wrote:
> > On Wed 13-10-21 18:28:40, Aneesh Kumar K.V wrote:
> > > On 10/13/21 18:20, Michal Hocko wrote:
> > [...]
> > > > I am still not sure the semantic makes sense though. Why should
> > > > the lowest node in the nodemask have any special meaning? What if it is
> > > > a node with a higher number that somebody preferes to start with?
> > > > 
> > > 
> > > That is true. I haven't been able to find an easy way to specify the
> > > preferred node other than expressing it as first node in the node mask. Yes,
> > > it limits the usage of the policy. Any alternate suggestion?
> > 
> > set_mempolicy is indeed not very suitable for something you are looking
> > for. Could you be more specific why the initial node is so important?
> > Is this because you want to allocate from a cpu less node first before
> > falling back to others?
> > 
> 
> One of the reason is that the thread that is faulting in pages first is not
> the one that is going to operate on this page long term. Application wants
> to hint the allocation node for the same reason they use MPOL_PREFERRED now.

Why cannot you move the faulting thread to a numa node of the preference
during the faulting and them move it out if that is really necessary?
-- 
Michal Hocko
SUSE Labs
