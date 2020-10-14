Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98E28E04D
	for <lists+linux-api@lfdr.de>; Wed, 14 Oct 2020 14:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgJNMJl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Oct 2020 08:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbgJNMJl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Oct 2020 08:09:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602677378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GhZUoX5/2qP8+QgEqOmdFGXjO3Jiw6TuJYOusJ34txI=;
        b=sYCAM4nDvLN487xobez2jY+PJkZLikI8W+6U/Ne/NmRRJySGFBRjv+n8Wr5kh+d98wROh9
        LBY3zB0+W+FMM3IvS0RIrEny3VD8Ul8Z+76kRcuF1inIjBceEOlcTW1fpiLBO5lk+Yj6Gz
        X6jkyeyIvNXNNuHSiggWuDHWxVw7NQk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CF6EAECE;
        Wed, 14 Oct 2020 12:09:38 +0000 (UTC)
Date:   Wed, 14 Oct 2020 14:09:37 +0200
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
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201014120937.GC4440@dhcp22.suse.cz>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Sorry for a late reply]

On Mon 14-09-20 17:45:44, Suren Baghdasaryan wrote:
> + linux-kernel@vger.kernel.org
> 
> On Mon, Sep 14, 2020 at 5:43 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > Last year I sent an RFC about using oom-reaper while killing a
> > process: https://patchwork.kernel.org/cover/10894999. During LSFMM2019
> > discussion https://lwn.net/Articles/787217 a couple of alternative
> > options were discussed with the most promising one (outlined in the
> > last paragraph of https://lwn.net/Articles/787217) suggesting to use a
> > remote version of madvise(MADV_DONTNEED) operation to force memory
> > reclaim of a killed process. With process_madvise() making its way
> > through reviews (https://patchwork.kernel.org/patch/11747133/), I
> > would like to revive this discussion and get feedback on several
> > possible options, their pros and cons.

Thanks for reviving this!

> > The need is similar to why oom-reaper was introduced - when a process
> > is being killed to free memory we want to make sure memory is freed
> > even if the victim is in uninterruptible sleep or is busy and reaction
> > to SIGKILL is delayed by an unpredictable amount of time. I
> > experimented with enabling process_madvise(MADV_DONTNEED) operation
> > and using it to force memory reclaim of the target process after
> > sending SIGKILL. Unfortunately this approach requires the caller to
> > read proc/pid/maps to extract the list of VMAs to pass as an input to
> > process_madvise().

Well I would argue that this is not really necessary. You can simply
call process_madvise with the full address range and let the kernel
operated only on ranges which are safe to tear down asynchronously.
Sure that would require some changes to the existing code to not fail
on those ranges if they contain incompatible vmas but that should be
possible. If we are worried about backward compatibility then a
dedicated flag could override.

[...]

> > While the objective is to guarantee forward progress even when the
> > victim cannot terminate, we still want this mechanism to be efficient
> > because we perform these operations to relieve memory pressure before
> > it affects user experience.
> >
> > Alternative options I would like your feedback are:
> > 1. Introduce a dedicated process_madvise(MADV_DONTNEED_MM)
> > specifically for this case to indicate that the whole mm can be freed.

This shouldn't be any different from madvise on the full address range,
right?

> > 2. A new syscall to efficiently obtain a vector of VMAs (start,
> > length, flags) of the process instead of reading /proc/pid/maps. The
> > size of the vector is still limited by UIO_MAXIOV (1024), so several
> > calls might be needed to query larger number of VMAs, however it will
> > still be an order of magnitude more efficient than reading
> > /proc/pid/maps file in 4K or smaller chunks.

While this might be interesting for other usecases - userspace memory
management in general - I do not think it is directly related to this
particular feature.

> > 3. Use process_madvise() flags parameter to indicate a bulk operation
> > which ignores input vectors. Sample usage: process_madvise(pidfd,
> > MADV_DONTNEED, vector=NULL, vlen=0, flags=PMADV_FLAG_FILE |
> > PMADV_FLAG_ANON);

Similar to above.

> > 4. madvise()/process_madvise() handle gaps between VMAs, so we could
> > provide one vector element spanning the entire address space. There
> > are technical issues with this approach (process_madvise return value
> > can't handle such a large number of bytes and there is MAX_RW_COUNT
> > limit on max number of bytes one process_madvise call can handle) but
> > I would still like to hear opinions about it. If this option is
> > preferable maybe we can deal with these limitations.

To be really honest, the more I am thinking about remove MADV_DONTNEED
the less I like it. Sure we can limit this functionality to killed tasks
but there is still a need to MMF_UNSTABLE that the current oom reaper
sets to prevent from memory corruption while the kernel is still in
kernel. Userspace memory reaper would need something similar.

I do have a vague recollection that we have discussed a kill(2) based
approach as well in the past. Essentially SIG_KILL_SYNC which would
not only send the signal but it would start a teardown of resources
owned by the task - at least those we can remove safely. The interface
would be much more simple and less tricky to use. You just make your
userspace oom killer or potentially other users call SIG_KILL_SYNC which
will be more expensive but you would at least know that as many
resources have been freed as the kernel can afford at the moment.
-- 
Michal Hocko
SUSE Labs
