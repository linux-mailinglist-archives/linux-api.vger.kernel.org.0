Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D658E2F7A7
	for <lists+linux-api@lfdr.de>; Thu, 30 May 2019 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfE3G57 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 May 2019 02:57:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfE3G57 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 May 2019 02:57:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B51BAF48;
        Thu, 30 May 2019 06:57:57 +0000 (UTC)
Date:   Thu, 30 May 2019 08:57:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190530065755.GD6703@dhcp22.suse.cz>
References: <20190520035254.57579-7-minchan@kernel.org>
 <20190520092258.GZ6836@dhcp22.suse.cz>
 <20190521024820.GG10039@google.com>
 <20190521062421.GD32329@dhcp22.suse.cz>
 <20190521102613.GC219653@google.com>
 <20190521103726.GM32329@dhcp22.suse.cz>
 <20190527074940.GB6879@google.com>
 <CAKOZuesK-8zrm1zua4dzqh4TEMivsZKiccySMvfBjOyDkg-MEw@mail.gmail.com>
 <20190529103352.GD18589@dhcp22.suse.cz>
 <20190530021748.GE229459@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530021748.GE229459@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 30-05-19 11:17:48, Minchan Kim wrote:
> On Wed, May 29, 2019 at 12:33:52PM +0200, Michal Hocko wrote:
> > On Wed 29-05-19 03:08:32, Daniel Colascione wrote:
> > > On Mon, May 27, 2019 at 12:49 AM Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > On Tue, May 21, 2019 at 12:37:26PM +0200, Michal Hocko wrote:
> > > > > On Tue 21-05-19 19:26:13, Minchan Kim wrote:
> > > > > > On Tue, May 21, 2019 at 08:24:21AM +0200, Michal Hocko wrote:
> > > > > > > On Tue 21-05-19 11:48:20, Minchan Kim wrote:
> > > > > > > > On Mon, May 20, 2019 at 11:22:58AM +0200, Michal Hocko wrote:
> > > > > > > > > [Cc linux-api]
> > > > > > > > >
> > > > > > > > > On Mon 20-05-19 12:52:53, Minchan Kim wrote:
> > > > > > > > > > Currently, process_madvise syscall works for only one address range
> > > > > > > > > > so user should call the syscall several times to give hints to
> > > > > > > > > > multiple address range.
> > > > > > > > >
> > > > > > > > > Is that a problem? How big of a problem? Any numbers?
> > > > > > > >
> > > > > > > > We easily have 2000+ vma so it's not trivial overhead. I will come up
> > > > > > > > with number in the description at respin.
> > > > > > >
> > > > > > > Does this really have to be a fast operation? I would expect the monitor
> > > > > > > is by no means a fast path. The system call overhead is not what it used
> > > > > > > to be, sigh, but still for something that is not a hot path it should be
> > > > > > > tolerable, especially when the whole operation is quite expensive on its
> > > > > > > own (wrt. the syscall entry/exit).
> > > > > >
> > > > > > What's different with process_vm_[readv|writev] and vmsplice?
> > > > > > If the range needed to be covered is a lot, vector operation makes senese
> > > > > > to me.
> > > > >
> > > > > I am not saying that the vector API is wrong. All I am trying to say is
> > > > > that the benefit is not really clear so far. If you want to push it
> > > > > through then you should better get some supporting data.
> > > >
> > > > I measured 1000 madvise syscall vs. a vector range syscall with 1000
> > > > ranges on ARM64 mordern device. Even though I saw 15% improvement but
> > > > absoluate gain is just 1ms so I don't think it's worth to support.
> > > > I will drop vector support at next revision.
> > > 
> > > Please do keep the vector support. Absolute timing is misleading,
> > > since in a tight loop, you're not going to contend on mmap_sem. We've
> > > seen tons of improvements in things like camera start come from
> > > coalescing mprotect calls, with the gains coming from taking and
> > > releasing various locks a lot less often and bouncing around less on
> > > the contended lock paths. Raw throughput doesn't tell the whole story,
> > > especially on mobile.
> > 
> > This will always be a double edge sword. Taking a lock for longer can
> > improve a throughput of a single call but it would make a latency for
> > anybody contending on the lock much worse.
> > 
> > Besides that, please do not overcomplicate the thing from the early
> > beginning please. Let's start with a simple and well defined remote
> > madvise alternative first and build a vector API on top with some
> > numbers based on _real_ workloads.
> 
> First time, I didn't think about atomicity about address range race
> because MADV_COLD/PAGEOUT is not critical for the race.
> However you raised the atomicity issue because people would extend
> hints to destructive ones easily. I agree with that and that's why
> we discussed how to guarantee the race and Daniel comes up with good idea.

Just for the clarification, I didn't really mean atomicity but rather a
_consistency_ (essentially time to check to time to use consistency).
 
>   - vma configuration seq number via process_getinfo(2).
> 
> We discussed the race issue without _read_ workloads/requests because
> it's common sense that people might extend the syscall later.
> 
> Here is same. For current workload, we don't need to support vector
> for perfomance point of view based on my experiment. However, it's
> rather limited experiment. Some configuration might have 10000+ vmas
> or really slow CPU. 
> 
> Furthermore, I want to have vector support due to atomicity issue
> if it's really the one we should consider.
> With vector support of the API and vma configuration sequence number
> from Daniel, we could support address ranges operations's atomicity.

I am not sure what do you mean here. Perform all ranges atomicaly wrt.
other address space modifications? If yes I am not sure we want that
semantic because it can cause really long stalls for other operations
but that is a discussion on its own and I would rather focus on a simple
interface first.

> However, since we don't introduce vector at this moment, we need to
> introduce *another syscall* later to be able to handle multile ranges
> all at once atomically if it's okay.

Agreed.

> Other thought:
> Maybe we could extend address range batch syscall covers other MM
> syscall like mmap/munmap/madvise/mprotect and so on because there
> are multiple users that would benefit from this general batching
> mechanism.

Again a discussion on its own ;)

-- 
Michal Hocko
SUSE Labs
