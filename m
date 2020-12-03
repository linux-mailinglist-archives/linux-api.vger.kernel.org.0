Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF302CD367
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 11:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgLCK06 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 05:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgLCK06 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 05:26:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BCCC061A4D;
        Thu,  3 Dec 2020 02:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XCWg7Tb5mZvG/2h9CQXFxMTAJ32rXCudkFDrtro7Gcc=; b=X4Zcth9JiusNnNnWu7clwftyDq
        K8OL3GQ2KYXRgp+9HQySN/sgRAPUMbF0WtNs/OOtYPr9Qty0LJ2jg5YVe4MkzOQECLOilt529ucBq
        yEX1qDpFCsYEAbsGf6LnwTPTAK1B1jxTvvpZjxjEyh+V0isms7IbTIpycgadu4TGpssSLt8UeLXQh
        AQEsJGDUy/Y4qM64Z+fVepduWehHYj6pGfPVDnwh4DmIVDfiGgRx8zjiaGNoIkMoz+fb+/hr+4X1T
        uAPx4fchwaaWS/WiU4zCCcs7EYFI+g3658KtLnOuKBL82Pw8yvEHn6/Gk373iNYiJQelAdEjj7cuy
        T+Zd7McA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kklo8-0007qk-6I; Thu, 03 Dec 2020 10:25:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1B67302753;
        Thu,  3 Dec 2020 11:25:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9308A201BAA75; Thu,  3 Dec 2020 11:25:50 +0100 (CET)
Date:   Thu, 3 Dec 2020 11:25:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH -V6 RESEND 1/3] numa balancing: Migrate on fault among
 multiple bound nodes
Message-ID: <20201203102550.GK2414@hirez.programming.kicks-ass.net>
References: <20201202084234.15797-1-ying.huang@intel.com>
 <20201202084234.15797-2-ying.huang@intel.com>
 <20201202114054.GV3306@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202114054.GV3306@suse.de>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 02, 2020 at 11:40:54AM +0000, Mel Gorman wrote:
> On Wed, Dec 02, 2020 at 04:42:32PM +0800, Huang Ying wrote:
> > Now, NUMA balancing can only optimize the page placement among the
> > NUMA nodes if the default memory policy is used.  Because the memory
> > policy specified explicitly should take precedence.  But this seems
> > too strict in some situations.  For example, on a system with 4 NUMA
> > nodes, if the memory of an application is bound to the node 0 and 1,
> > NUMA balancing can potentially migrate the pages between the node 0
> > and 1 to reduce cross-node accessing without breaking the explicit
> > memory binding policy.
> > 
> 
> Ok, I think this part is ok and while the test case is somewhat
> superficial, it at least demonstrated that the NUMA balancing overhead
> did not offset any potential benefit
> 
> Acked-by: Mel Gorman <mgorman@suse.de>

Who do we expect to merge this, me through tip/sched/core or akpm ?
