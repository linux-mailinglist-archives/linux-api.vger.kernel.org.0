Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5983DA8DC
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhG2QVa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 12:21:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38052 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhG2QV0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Jul 2021 12:21:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A78D020061;
        Thu, 29 Jul 2021 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627575680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t012uWsF/p/ncJgBtbiwHbjc70VAkY0WVH/DmM2Q0+s=;
        b=kqtPRwrkKn2TTZ3ZTf9Pj9xxtWP3TKJ9spCqGVbMHulRak1717Abfu7cV58JE4mZ9xZSsO
        Swz+AwGVgaYNUFMdaeqL83bUGo9baxa9nm+o/8IrkEn7SJraDNs8N8Y+2j1el+tyB4CeTw
        wQGsH/UH9ORO6TSGkO+kUECLPZnWf/A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5368DA3B85;
        Thu, 29 Jul 2021 16:21:15 +0000 (UTC)
Date:   Thu, 29 Jul 2021 18:21:19 +0200
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
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <YQLVf3pkQTHLemAZ@dhcp22.suse.cz>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-2-git-send-email-feng.tang@intel.com>
 <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
 <20210728141156.GC43486@shbuild999.sh.intel.com>
 <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
 <20210729070918.GA96680@shbuild999.sh.intel.com>
 <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
 <20210729151242.GA42865@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729151242.GA42865@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 29-07-21 23:12:42, Feng Tang wrote:
> On Thu, Jul 29, 2021 at 03:38:44PM +0200, Michal Hocko wrote:
[...]
> > Also the
> > semantic to give nodes some ordering based on their numbers sounds
> > rather weird to me.
> 
> I agree, and as I admitted in the first reply, this need to be fixed.

OK. I was not really clear that we are on the same page here.

> > The semantic I am proposing is to allocate from prefered nodes in
> > distance order starting from the local node.
> 
> So the plan is:
> * if the local node is set in 'prefer-many's nodemask, then chose
> * otherwise chose the node with the shortest distance to local node
> ?

Yes and what I am trying to say is that you will achieve that simply by
doing the following in policy_node:
	if (policy->mode == MPOL_PREFERRED_MANY)
		return nd;
-- 
Michal Hocko
SUSE Labs
