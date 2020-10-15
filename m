Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1097F28EF4E
	for <lists+linux-api@lfdr.de>; Thu, 15 Oct 2020 11:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgJOJUe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Oct 2020 05:20:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:38228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgJOJUd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 15 Oct 2020 05:20:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602753631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dJHIbZ9xDbDoZCoYvRLfsd+h+MR29PHhVlxFEd7ZxQ=;
        b=fHB7wxZ9rz6ZKMeSC1rrJZbwi1DedgVxNhXmpcvpDQj5EM0yZShkXfxsN0fvqe1JYzrvuj
        5cG+muWpAY9sR2uMM3fFhVNJ4LkBaNEIRbtPQzfxdZ/1mvoXOujYabx4NUPA8pwJj1RIIq
        yogQuWdzfLQxpaSBIERxFriPqWj5qJU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DC1CAF4D;
        Thu, 15 Oct 2020 09:20:31 +0000 (UTC)
Date:   Thu, 15 Oct 2020 11:20:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-api@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201015092030.GB22589@dhcp22.suse.cz>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz>
 <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 14-10-20 09:57:20, Suren Baghdasaryan wrote:
> On Wed, Oct 14, 2020 at 5:09 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > > The need is similar to why oom-reaper was introduced - when a process
> > > > is being killed to free memory we want to make sure memory is freed
> > > > even if the victim is in uninterruptible sleep or is busy and reaction
> > > > to SIGKILL is delayed by an unpredictable amount of time. I
> > > > experimented with enabling process_madvise(MADV_DONTNEED) operation
> > > > and using it to force memory reclaim of the target process after
> > > > sending SIGKILL. Unfortunately this approach requires the caller to
> > > > read proc/pid/maps to extract the list of VMAs to pass as an input to
> > > > process_madvise().
> >
> > Well I would argue that this is not really necessary. You can simply
> > call process_madvise with the full address range and let the kernel
> > operated only on ranges which are safe to tear down asynchronously.
> > Sure that would require some changes to the existing code to not fail
> > on those ranges if they contain incompatible vmas but that should be
> > possible. If we are worried about backward compatibility then a
> > dedicated flag could override.
> >
> 
> IIUC this is very similar to the last option I proposed. I think this
> is doable if we treat it as a special case. process_madvise() return
> value not being able to handle a large range would still be a problem.
> Maybe we can return MAX_INT in those cases?

madvise is documented to return 
       On success, madvise() returns zero.  On error, it returns -1 and
       errno is set appropriately.
[...]
NOTES
   Linux notes
       The Linux implementation requires that the address addr be
       page-aligned, and allows length to be zero.  If there are some
       parts of the specified address range that are not mapped, the
       Linux version of madvise() ignores them and applies the call to
       the rest (but returns ENOMEM from the system call, as it should).

I have learned about ENOMEM case only now. And it seems this is indeed
what we are implementing. So if we want to add a new mode to
opportunistically attempt madvise on the whole given range without a
failure then we need a specific flag for that. Advice is a number rather
than a bitmask but (ab)using the top bit or use negative number space
(e.g. -MADV_DONTNEED) for that sounds possible albeit bit hackish.

[...]
> > I do have a vague recollection that we have discussed a kill(2) based
> > approach as well in the past. Essentially SIG_KILL_SYNC which would
> > not only send the signal but it would start a teardown of resources
> > owned by the task - at least those we can remove safely. The interface
> > would be much more simple and less tricky to use. You just make your
> > userspace oom killer or potentially other users call SIG_KILL_SYNC which
> > will be more expensive but you would at least know that as many
> > resources have been freed as the kernel can afford at the moment.
> 
> Correct, my early RFC here
> https://patchwork.kernel.org/project/linux-mm/patch/20190411014353.113252-3-surenb@google.com
> was using a new flag for pidfd_send_signal() to request mm reaping by
> oom-reaper kthread. IIUC you propose to have a new SIG_KILL_SYNC
> signal instead of a new pidfd_send_signal() flag and otherwise a very
> similar solution. Is my understanding correct?

Well, I think you shouldn't focus too much on the oom-reaper aspect
of it. Sure it can be used for that but I believe that a new signal
should provide a sync behavior. People more familiar with the process
management would be better off defining what is possible for a new sync
signal.  Ideally not only pro-active process destruction but also sync
waiting until the target process is released so that you know that once
kill syscall returns the process is gone.

-- 
Michal Hocko
SUSE Labs
