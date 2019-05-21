Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DA247EA
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfEUGRr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 02:17:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:52082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbfEUGRr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 21 May 2019 02:17:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B91BCAD47;
        Tue, 21 May 2019 06:17:44 +0000 (UTC)
Date:   Tue, 21 May 2019 08:17:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 5/7] mm: introduce external memory hinting API
Message-ID: <20190521061743.GC32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-6-minchan@kernel.org>
 <20190520091829.GY6836@dhcp22.suse.cz>
 <20190521024107.GF10039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521024107.GF10039@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 21-05-19 11:41:07, Minchan Kim wrote:
> On Mon, May 20, 2019 at 11:18:29AM +0200, Michal Hocko wrote:
> > [Cc linux-api]
> > 
> > On Mon 20-05-19 12:52:52, Minchan Kim wrote:
> > > There is some usecase that centralized userspace daemon want to give
> > > a memory hint like MADV_[COOL|COLD] to other process. Android's
> > > ActivityManagerService is one of them.
> > > 
> > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > required to make the reclaim decision is not known to the app. Instead,
> > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > and that daemon must be able to initiate reclaim on its own without
> > > any app involvement.
> > 
> > Could you expand some more about how this all works? How does the
> > centralized daemon track respective ranges? How does it synchronize
> > against parallel modification of the address space etc.
> 
> Currently, we don't track each address ranges because we have two
> policies at this moment:
> 
> 	deactive file pages and reclaim anonymous pages of the app.
> 
> Since the daemon has a ability to let background apps resume(IOW, process
> will be run by the daemon) and both hints are non-disruptive stabilty point
> of view, we are okay for the race.

Fair enough but the API should consider future usecases where this might
be a problem. So we should really think about those potential scenarios
now. If we are ok with that, fine, but then we should be explicit and
document it that way. Essentially say that any sort of synchronization
is supposed to be done by monitor. This will make the API less usable
but maybe that is enough.
 
> > > To solve the issue, this patch introduces new syscall process_madvise(2)
> > > which works based on pidfd so it could give a hint to the exeternal
> > > process.
> > > 
> > > int process_madvise(int pidfd, void *addr, size_t length, int advise);
> > 
> > OK, this makes some sense from the API point of view. When we have
> > discussed that at LSFMM I was contemplating about something like that
> > except the fd would be a VMA fd rather than the process. We could extend
> > and reuse /proc/<pid>/map_files interface which doesn't support the
> > anonymous memory right now. 
> > 
> > I am not saying this would be a better interface but I wanted to mention
> > it here for a further discussion. One slight advantage would be that
> > you know the exact object that you are operating on because you have a
> > fd for the VMA and we would have a more straightforward way to reject
> > operation if the underlying object has changed (e.g. unmapped and reused
> > for a different mapping).
> 
> I agree your point. If I didn't miss something, such kinds of vma level
> modify notification doesn't work even file mapped vma at this moment.
> For anonymous vma, I think we could use userfaultfd, pontentially.
> It would be great if someone want to do with disruptive hints like
> MADV_DONTNEED.
> 
> I'd like to see it further enhancement after landing address range based
> operation via limiting hints process_madvise supports to non-disruptive
> only(e.g., MADV_[COOL|COLD]) so that we could catch up the usercase/workload
> when someone want to extend the API.

So do you think we want both interfaces (process_madvise and madvisefd)?
-- 
Michal Hocko
SUSE Labs
