Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54A2B2ACC
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 03:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKNCQe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 21:16:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKNCQe (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Nov 2020 21:16:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEBE20A8B;
        Sat, 14 Nov 2020 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605320193;
        bh=f53VHtpTrGtgDaUId+eGdbfbwV1CzrlZJlAgcdrN4Jc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VxAVz1yMuuB8W7A8AtC9Zqncm3wiP/le2O9NBW8GNkFAmWqXK9EZy4v6BkAu2XxXS
         ryd/KliwGNUs0cNYHemGDXCgZECcMjXzRnG3/gHKnDgoMbt+c4a9uP9XvSBVFukn02
         I5wo9rKB38e0w3LMD3Fk4oyc9SFgwINpiwh2KGc0=
Date:   Fri, 13 Nov 2020 18:16:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
Message-Id: <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
In-Reply-To: <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
References: <20201113173448.1863419-1-surenb@google.com>
        <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
        <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
        <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
        <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
        <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
        <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 13 Nov 2020 17:57:02 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Fri, Nov 13, 2020 at 5:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 13 Nov 2020 17:09:37 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > > > > Seems to me that the ability to reap another process's memory is a
> > > > > > generally useful one, and that it should not be tied to delivering a
> > > > > > signal in this fashion.
> > > > > >
> > > > > > And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
> > > > > > few changes and tweaks, but can't that be used to solve this problem?
> > > > >
> > > > > Thank you for the feedback, Andrew. process_madvise(MADV_DONTNEED) was
> > > > > one of the options recently discussed in
> > > > > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > > > > . The thread describes some of the issues with that approach but if we
> > > > > limit it to processes with pending SIGKILL only then I think that
> > > > > would be doable.
> > > >
> > > > Why would it be necessary to read /proc/pid/maps?  I'd have thought
> > > > that a starting effort would be
> > > >
> > > >         madvise((void *)0, (void *)-1, MADV_PAGEOUT)
> > > >
> > > > (after translation into process_madvise() speak).  Which is equivalent
> > > > to the proposed process_madvise(MADV_DONTNEED_MM)?
> > >
> > > Yep, this is very similar to option #3 in
> > > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > > and I actually have a tested prototype for that.
> >
> > Why is the `vector=NULL' needed?  Can't `vector' point at a single iovec
> > which spans the whole address range?
> 
> That would be the option #4 from the same discussion and the issues
> noted there are "process_madvise return value can't handle such a
> large number of bytes and there is MAX_RW_COUNT limit on max number of
> bytes one process_madvise call can handle". In my prototype I have a
> special handling for such "bulk operation" to work around the
> MAX_RW_COUNT limitation.

Ah, OK, return value.  Maybe process_madvise() shouldn't have done that
and should have simply returned 0 on success, like madvise().

I guess a special "nuke whole address space" command is OK.  But, again
in the search for generality, the ability to nuke very large amounts of
address space (but not the entire address space) would be better. 

The process_madvise() return value issue could be addressed by adding a
process_madvise() mode which return 0 on success.

And I guess the MAX_RW_COUNT issue is solvable by adding an
import_iovec() arg to say "don't check that".  Along those lines.

It's all sounding a bit painful (but not *too* painful).  But to
reiterate, I do think that adding the ability for a process to shoot
down a large amount of another process's memory is a lot more generally
useful than tying it to SIGKILL, agree?

> >
> > > If that's the
> > > preferred method then I can post it quite quickly.
> >
> > I assume you've tested that prototype.  How did its usefulness compare
> > with this SIGKILL-based approach?
> 
> Just to make sure I understand correctly your question, you are asking
> about performance comparison of:
> 
> // approach in this RFC
> pidfd_send_signal(SIGKILL, SYNC_REAP_MM)
> 
> vs
> 
> // option #4 in the previous RFC
> kill(SIGKILL); process_madvise(vector=NULL, MADV_DONTNEED);
> 
> If so, I have results for the current RFC approach but the previous
> approach was testing on an older device, so don't have
> apples-to-apples comparison results at the moment. I can collect the
> data for fair comparison if desired, however I don't expect a
> noticeable performance difference since they both do pretty much the
> same thing (even on different devices my results are quite close). I
> think it's more a question of which API would be more appropriate.

OK.  I wouldn't expect performance to be very different (and things can
be sped up if so), but the API usefulness might be an issue.  Using
process_madvise() (or similar) makes it a two-step operation, whereas
tying it to SIGKILL&&TASK_UNINTERRUPTIBLE provides a more precise tool.
Any thoughts on this?

