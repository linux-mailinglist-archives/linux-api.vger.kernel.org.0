Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EBC3E41BA
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhHIImC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 04:42:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36788 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhHIImB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Aug 2021 04:42:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B3C351FDA8;
        Mon,  9 Aug 2021 08:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628498500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K6FleGU+Vjel8oStWbGJNmI2TOAKUwObhLh2qqJEUkQ=;
        b=PcJDwHo0UzeYJns4EM1QpLxbC4zsRy7ZWZMAgi3m5nhbj+qP7O9UAg1JjMI07rmR3kKccw
        QMWd37DUAY1ytkpwlPaSkPQvGx5xOBluGRkwCSwb2ISuaIV9aESW/9ONExVsO/zmOlNMlp
        ZVCCj4CO5DbdKFEn2A2bhon1jr2uVdU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D41BA3B8C;
        Mon,  9 Aug 2021 08:41:40 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:41:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v7 3/5] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
Message-ID: <YRDqRMTXVZO9EkoC@dhcp22.suse.cz>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-4-git-send-email-feng.tang@intel.com>
 <YQ06tNiDEsvl8004@dhcp22.suse.cz>
 <20210809024430.GA46432@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809024430.GA46432@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 09-08-21 10:44:30, Feng Tang wrote:
> Hi Michal,
> 
> Thanks for the review and ACKs to 1/5 and 2/5 patches.
> 
> On Fri, Aug 06, 2021 at 03:35:48PM +0200, Michal Hocko wrote:
> > On Tue 03-08-21 13:59:20, Feng Tang wrote:
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > 
> > > Implement the missing huge page allocation functionality while obeying
> > > the preferred node semantics. This is similar to the implementation
> > > for general page allocation, as it uses a fallback mechanism to try
> > > multiple preferred nodes first, and then all other nodes.
> > > 
> > > [akpm: fix compling issue when merging with other hugetlb patch]
> > > [Thanks to 0day bot for catching the missing #ifdef CONFIG_NUMA issue]
> > > Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Co-developed-by: Feng Tang <feng.tang@intel.com>
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > 
> > ifdefery is just ugly as hell. One way to get rid of that would be to
> > provide a mpol_is_preferred_many() wrapper and hide the CONFIG_NUMA in
> > mempolicy.h. I haven't checked but this might help to remove some other
> > ifdefery as well.
> > 
> > I especially dislike the label hidden in the ifdef. You can get rid of
> > that by checking the page for NULL.
> 
> Yes, the 'ifdef's were annoying to me too, and thanks for the suggestions.
> Following is the revised patch upon the suggestion.
> 
> Thanks,
> Feng
> 
> -------8<---------------------
> 
> >From fc30718c40f02ba5ea73456af49173e66b5032c1 Mon Sep 17 00:00:00 2001
> From: Ben Widawsky <ben.widawsky@intel.com>
> Date: Thu, 5 Aug 2021 23:01:11 -0400
> Subject: [PATCH] mm/hugetlb: add support for mempolicy MPOL_PREFERRED_MANY
> 
> Implement the missing huge page allocation functionality while obeying the
> preferred node semantics.  This is similar to the implementation for
> general page allocation, as it uses a fallback mechanism to try multiple
> preferred nodes first, and then all other nodes. 
> 
> To avoid adding too many "#ifdef CONFIG_NUMA" check, add a helper function
> in mempolicy.h to check whether a mempolicy is MPOL_PREFERRED_MANY.
> 
> [akpm: fix compling issue when merging with other hugetlb patch]
> [Thanks to 0day bot for catching the !CONFIG_NUMA compiling issue]
> [Michal Hocko: suggest to remove the #ifdef CONFIG_NUMA check]
> Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> Link: https://lkml.kernel.org/r/1627970362-61305-4-git-send-email-feng.tang@intel.com
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Co-developed-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Yeah. This looks much better. Thanks!
Acked-by: Michal Hocko <mhocko@suse.com>
Do you think you can provide same helpers for other policies as well?
Maybe we can get rid of some other ifdefery as well.

Thanks!
-- 
Michal Hocko
SUSE Labs
