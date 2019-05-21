Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD224819
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 08:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfEUGc0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 02:32:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfEUGcY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 21 May 2019 02:32:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57D8FAE1D;
        Tue, 21 May 2019 06:32:22 +0000 (UTC)
Date:   Tue, 21 May 2019 08:32:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190521063221.GF32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520164605.GA11665@cmpxchg.org>
 <20190521043950.GJ10039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521043950.GJ10039@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Cc linux-api]

On Tue 21-05-19 13:39:50, Minchan Kim wrote:
> On Mon, May 20, 2019 at 12:46:05PM -0400, Johannes Weiner wrote:
> > On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > > - Approach
> > > 
> > > The approach we chose was to use a new interface to allow userspace to
> > > proactively reclaim entire processes by leveraging platform information.
> > > This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
> > > that are known to be cold from userspace and to avoid races with lmkd
> > > by reclaiming apps as soon as they entered the cached state. Additionally,
> > > it could provide many chances for platform to use much information to
> > > optimize memory efficiency.
> > > 
> > > IMHO we should spell it out that this patchset complements MADV_WONTNEED
> > > and MADV_FREE by adding non-destructive ways to gain some free memory
> > > space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> > > kernel that memory region is not currently needed and should be reclaimed
> > > immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> > > kernel that memory region is not currently needed and should be reclaimed
> > > when memory pressure rises.
> > 
> > I agree with this approach and the semantics. But these names are very
> > vague and extremely easy to confuse since they're so similar.
> > 
> > MADV_COLD could be a good name, but for deactivating pages, not
> > reclaiming them - marking memory "cold" on the LRU for later reclaim.
> > 
> > For the immediate reclaim one, I think there is a better option too:
> > In virtual memory speak, putting a page into secondary storage (or
> > ensuring it's already there), and then freeing its in-memory copy, is
> > called "paging out". And that's what this flag is supposed to do. So
> > how about MADV_PAGEOUT?
> > 
> > With that, we'd have:
> > 
> > MADV_FREE: Mark data invalid, free memory when needed
> > MADV_DONTNEED: Mark data invalid, free memory immediately
> > 
> > MADV_COLD: Data is not used for a while, free memory when needed
> > MADV_PAGEOUT: Data is not used for a while, free memory immediately
> > 
> > What do you think?
> 
> There are several suggestions until now. Thanks, Folks!
> 
> For deactivating:
> 
> - MADV_COOL
> - MADV_RECLAIM_LAZY
> - MADV_DEACTIVATE
> - MADV_COLD
> - MADV_FREE_PRESERVE
> 
> 
> For reclaiming:
> 
> - MADV_COLD
> - MADV_RECLAIM_NOW
> - MADV_RECLAIMING
> - MADV_PAGEOUT
> - MADV_DONTNEED_PRESERVE
> 
> It seems everybody doesn't like MADV_COLD so want to go with other.
> For consisteny of view with other existing hints of madvise, -preserve
> postfix suits well. However, originally, I don't like the naming FREE
> vs DONTNEED from the beginning. They were easily confused.
> I prefer PAGEOUT to RECLAIM since it's more likely to be nuance to
> represent reclaim with memory pressure and is supposed to paged-in
> if someone need it later. So, it imply PRESERVE.
> If there is not strong against it, I want to go with MADV_COLD and
> MADV_PAGEOUT.
> 
> Other opinion?

I do not really care strongly. I am pretty sure we will have a lot of
suggestions because people tend to be good at arguing about that...
Anyway, unlike DONTNEED/FREE we do not have any other OS to implement
these features, right? So we shouldn't be tight to existing names.
On the other hand I kinda like the reference to the existing names but
DEACTIVATE/PAGEOUT seem a good fit to me as well. Unless there is way
much better name suggested I would go with one of those. Up to you.
-- 
Michal Hocko
SUSE Labs
