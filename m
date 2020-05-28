Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB97D1E5C67
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2020 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgE1Juo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 May 2020 05:50:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387493AbgE1Juo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 28 May 2020 05:50:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6AB2AD3A;
        Thu, 28 May 2020 09:50:41 +0000 (UTC)
Subject: Re: [PATCH v5] mm: Proactive compaction
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <ngupta@nitingupta.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20200518181446.25759-1-nigupta@nvidia.com>
 <27b39956-2a21-8eef-8ebb-cb3a93a41a36@applied-asynchrony.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ab3e4c38-a7f9-01fc-f25f-f13f8e30985f@suse.cz>
Date:   Thu, 28 May 2020 11:50:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <27b39956-2a21-8eef-8ebb-cb3a93a41a36@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/28/20 11:15 AM, Holger Hoffstätte wrote:
> 
> On 5/18/20 8:14 PM, Nitin Gupta wrote:
> [patch v5 :)]
> 
> I've been successfully using this in my tree and it works great, but a friend
> who also uses my tree just found a bug (actually an improvement ;) due to the
> change from HUGETLB_PAGE_ORDER to HPAGE_PMD_ORDER in v5.
> 
> When building with CONFIG_TRANSPARENT_HUGEPAGE=n (for some reason it was off)
> HPAGE_PMD_SHIFT expands to BUILD_BUG() and compilation fails like this:

Oops, I forgot about this. Still I believe HPAGE_PMD_ORDER is the best choice as
long as THP's are enabled. I guess fallback to HUGETLB_PAGE_ORDER would be
possible if THPS are not enabled, but AFAICS some architectures don't define
that. Such architectures perhaps won't benefit from proactive compaction anyway?

> ...
> ./include/linux/huge_mm.h:284:28: note: in expansion of macro ‘BUILD_BUG’
>    284 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>        |                            ^~~~~~~~~
> ./include/linux/huge_mm.h:78:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>     78 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>        |                          ^~~~~~~~~~~~~~~
> mm/compaction.c:1874:28: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>   1874 |    extfrag_for_order(zone, HPAGE_PMD_ORDER);
>        |                            ^~~~~~~~~~~~~~~
> ...
> 
> It would be great if the whole thing would compile without THP; the only
> occurrence is in fragmentation_score_zone(). Unfortunately I'm not familiar
> enough with how to properly check for THP and properly calculate whatever
> you're doing there, otherwise I would ifdef this away myself. ;)
> 
> Thanks for an otherwise great patch!
> 
> cheers,
> Holger
> 

