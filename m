Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3339A2C561
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfE1L2n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 07:28:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfE1L2n (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 May 2019 07:28:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C877AF1C;
        Tue, 28 May 2019 11:28:41 +0000 (UTC)
Date:   Tue, 28 May 2019 13:28:40 +0200
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
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190528112840.GY1658@dhcp22.suse.cz>
References: <20190527124411.GC1658@dhcp22.suse.cz>
 <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz>
 <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com>
 <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com>
 <20190528104117.GW1658@dhcp22.suse.cz>
 <20190528111208.GA30365@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528111208.GA30365@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 28-05-19 20:12:08, Minchan Kim wrote:
> On Tue, May 28, 2019 at 12:41:17PM +0200, Michal Hocko wrote:
> > On Tue 28-05-19 19:32:56, Minchan Kim wrote:
> > > On Tue, May 28, 2019 at 11:08:21AM +0200, Michal Hocko wrote:
> > > > On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > > > > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > > > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > > > if we went with the per vma fd approach then you would get this
> > > > > > > > feature automatically because map_files would refer to file backed
> > > > > > > > mappings while map_anon could refer only to anonymous mappings.
> > > > > > >
> > > > > > > The reason to add such filter option is to avoid the parsing overhead
> > > > > > > so map_anon wouldn't be helpful.
> > > > > > 
> > > > > > Without chiming on whether the filter option is a good idea, I'd like
> > > > > > to suggest that providing an efficient binary interfaces for pulling
> > > > > > memory map information out of processes.  Some single-system-call
> > > > > > method for retrieving a binary snapshot of a process's address space
> > > > > > complete with attributes (selectable, like statx?) for each VMA would
> > > > > > reduce complexity and increase performance in a variety of areas,
> > > > > > e.g., Android memory map debugging commands.
> > > > > 
> > > > > I agree it's the best we can get *generally*.
> > > > > Michal, any opinion?
> > > > 
> > > > I am not really sure this is directly related. I think the primary
> > > > question that we have to sort out first is whether we want to have
> > > > the remote madvise call process or vma fd based. This is an important
> > > > distinction wrt. usability. I have only seen pid vs. pidfd discussions
> > > > so far unfortunately.
> > > 
> > > With current usecase, it's per-process API with distinguishable anon/file
> > > but thought it could be easily extended later for each address range
> > > operation as userspace getting smarter with more information.
> > 
> > Never design user API based on a single usecase, please. The "easily
> > extended" part is by far not clear to me TBH. As I've already mentioned
> > several times, the synchronization model has to be thought through
> > carefuly before a remote process address range operation can be
> > implemented.
> 
> I agree with you that we shouldn't design API on single usecase but what
> you are concerning is actually not our usecase because we are resilient
> with the race since MADV_COLD|PAGEOUT is not destruptive.
> Actually, many hints are already racy in that the upcoming pattern would
> be different with the behavior you thought at the moment.

How come they are racy wrt address ranges? You would have to be in
multithreaded environment and then the onus of synchronization is on
threads. That model is quite clear. But we are talking about separate
processes and some of them might be even not aware of an external entity
tweaking their address space.

> If you are still concerning of address range synchronization, how about
> moving such hints to per-process level like prctl?
> Does it make sense to you?

No it doesn't. How is prctl any relevant to any address range
operations.

-- 
Michal Hocko
SUSE Labs
