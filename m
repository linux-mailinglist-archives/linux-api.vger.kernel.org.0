Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF52D5543
	for <lists+linux-api@lfdr.de>; Thu, 10 Dec 2020 09:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbgLJIWa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Dec 2020 03:22:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:14941 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730907AbgLJIWY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 Dec 2020 03:22:24 -0500
IronPort-SDR: JeOT8PPNqpHaHrRWhDKtscXriLud/+FPhXfo4udLor52ppxnh1y+Po8mf6XcDDfIORd8rGdTYq
 GuVj+3i110Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="161267805"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="161267805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 00:21:29 -0800
IronPort-SDR: 1R5N6Yw/ROt9D4NEyhUAZTnLuF6700tb8Fo61weRzdRGNyQh0RkUg4k/6/nWQtoSiqJMT+SHJZ
 husbGZWbep/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="438251654"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by fmsmga001.fm.intel.com with ESMTP; 10 Dec 2020 00:21:26 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH -V6 RESEND 1/3] numa balancing: Migrate on fault among multiple bound nodes
References: <20201202084234.15797-1-ying.huang@intel.com>
        <20201202084234.15797-2-ying.huang@intel.com>
        <20201202114054.GV3306@suse.de>
        <20201203102550.GK2414@hirez.programming.kicks-ass.net>
        <87zh2ulyhc.fsf@yhuang-dev.intel.com>
Date:   Thu, 10 Dec 2020 16:21:25 +0800
In-Reply-To: <87zh2ulyhc.fsf@yhuang-dev.intel.com> (Ying Huang's message of
        "Fri, 04 Dec 2020 17:19:43 +0800")
Message-ID: <87a6umjcl6.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Peter Zijlstra <peterz@infradead.org> writes:
>
>> On Wed, Dec 02, 2020 at 11:40:54AM +0000, Mel Gorman wrote:
>>> On Wed, Dec 02, 2020 at 04:42:32PM +0800, Huang Ying wrote:
>>> > Now, NUMA balancing can only optimize the page placement among the
>>> > NUMA nodes if the default memory policy is used.  Because the memory
>>> > policy specified explicitly should take precedence.  But this seems
>>> > too strict in some situations.  For example, on a system with 4 NUMA
>>> > nodes, if the memory of an application is bound to the node 0 and 1,
>>> > NUMA balancing can potentially migrate the pages between the node 0
>>> > and 1 to reduce cross-node accessing without breaking the explicit
>>> > memory binding policy.
>>> > 
>>> 
>>> Ok, I think this part is ok and while the test case is somewhat
>>> superficial, it at least demonstrated that the NUMA balancing overhead
>>> did not offset any potential benefit
>>> 
>>> Acked-by: Mel Gorman <mgorman@suse.de>
>>
>> Who do we expect to merge this, me through tip/sched/core or akpm ?
>
> Hi, Peter,
>
> Per my understanding, this is NUMA balancing related, so could go
> through your tree.
>
> BTW: I have just sent -V7 with some small changes per Mel's latest
> comments.
>
> Hi, Andrew,
>
> Do you agree?

So, what's the conclusion here?  Both path works for me.  I will update
2/3 per Alejandro Colomar's comments.  But that's for man-pages only,
not for kernel.  So, we can merge this one into kernel if you think it's
appropriate.

Best Regards,
Huang, Ying
