Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13C32C18B
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 10:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfE1Imq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 04:42:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfE1Imp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 May 2019 04:42:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83E45ADD4;
        Tue, 28 May 2019 08:42:44 +0000 (UTC)
Date:   Tue, 28 May 2019 10:42:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: implement MADV_STOCKPILE (kswapd from
 user space)
Message-ID: <20190528084243.GT1658@dhcp22.suse.cz>
References: <155895155861.2824.318013775811596173.stgit@buzz>
 <20190527141223.GD1658@dhcp22.suse.cz>
 <20190527142156.GE1658@dhcp22.suse.cz>
 <20190527143926.GF1658@dhcp22.suse.cz>
 <9c55a343-2a91-46c6-166d-41b94bf5e9c8@yandex-team.ru>
 <20190528065153.GB1803@dhcp22.suse.cz>
 <a4e5eeb8-3560-d4b4-08a0-8a22c677c0f7@yandex-team.ru>
 <20190528073835.GP1658@dhcp22.suse.cz>
 <5af1ba69-61d1-1472-4aa3-20beb4ae44ae@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af1ba69-61d1-1472-4aa3-20beb4ae44ae@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 28-05-19 11:04:46, Konstantin Khlebnikov wrote:
> On 28.05.2019 10:38, Michal Hocko wrote:
[...]
> > Could you define the exact semantic? Ideally something for the manual
> > page please?
> > 
> 
> Like kswapd which works with thresholds of free memory this one reclaims
> until 'free' (i.e. memory which could be allocated without invoking
> direct recliam of any kind) is lower than passed 'size' argument.

s@lower@higher@ I guess

> Thus right after madvise(NULL, size, MADV_STOCKPILE) 'size' bytes
> could be allocated in this memory cgroup without extra latency from
> reclaimer if there is no other memory consumers.
> 
> Reclaimed memory is simply put into free lists in common buddy allocator,
> there is no reserves for particular task or cgroup.
> 
> If overall memory allocation rate is smooth without rough spikes then
> calling MADV_STOCKPILE in loop periodically provides enough room for
> allocations and eliminates direct reclaim from all other tasks.
> As a result this eliminates unpredictable delays caused by
> direct reclaim in random places.

OK, this makes it more clear to me. Thanks for the clarification!
I have clearly misunderstood and misinterpreted target as the reclaim
target rather than free memory target.  Sorry about the confusion.
I sill think that this looks like an abuse of the madvise but if there
is a wider consensus this is acceptable I will not stand in the way.

-- 
Michal Hocko
SUSE Labs
