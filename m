Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2732F28E4EF
	for <lists+linux-api@lfdr.de>; Wed, 14 Oct 2020 18:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgJNQ5d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Oct 2020 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgJNQ5d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Oct 2020 12:57:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E59C0613D2
        for <linux-api@vger.kernel.org>; Wed, 14 Oct 2020 09:57:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n15so4755404wrq.2
        for <linux-api@vger.kernel.org>; Wed, 14 Oct 2020 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSHCbaEyUdgYr4W73XWrJpL61ND8ROtoqZ3ozneFNQk=;
        b=a7znJ4ElJwDe6D0yt/SYlVbVmioRwWwFAAcj3Aq+7ExGefuKmI+ud/ShJefgEpu22o
         BNAQa5XEEUAgXcTooqoDSDyAQZXsiml8g86hIGxcU5GYpP4r10JOBkbEJf1MTFPOz35Q
         4WCN6uzCFTCCDnfeesQrJrHEFtNuhIw6U85A1LM8l7UqSZxEsgDFQo1yH8SyNvFyh6KU
         CXRRJlUaOMXSeKO/+ZLfDSnfbdAM3YLZxhdCYUNJ1mCTbpg1uXu/CTdMorveW5quMLWS
         zFa36GsqTkFzzyXoMJVTINPez+uLCAtLC10CPGNKzKQWnc5WCYfJhb9NRMdUSQE6PZmM
         sAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSHCbaEyUdgYr4W73XWrJpL61ND8ROtoqZ3ozneFNQk=;
        b=aLP6KwiJTvfXzmQG85C+l2rjKjtKgEt710084wlbjBAatfD9jfDWemXmNt10qRHFGA
         WkWCmVltVK49McvoeBcQ2mweOIiZemLFkcPDOh5jwLXz/kfIg74stXF7+8uyuKNApiGC
         TONPsZmtt/cs63kd75/OFBxtWdEftb1zILDYGdf5H9VFA5aHfE3RlnRFZCKRBJu4WwXc
         7VpDLWwiaJ39jL1k/l5iPaFvZXcGGcIOzbjGmrHDPYhPWpbczvW0kvM8s5Q8Ip1e1KNR
         lar57L3TNAi4Je/E8JKVrxw/ND8kfwJU4Y1hnSi7E7iWHxdbPgQYfUOomswdrQ+jIDOx
         nKHg==
X-Gm-Message-State: AOAM531E/stWFCzes9Gs2oOt1wlvKqY921ykXRrH5Uf+Xk8yB1ixSsKG
        d4RMTM6cJaAkdpd5pyGEjl2Iyii5btV30H8e3Zgyww==
X-Google-Smtp-Source: ABdhPJwbICUQNXFGsATSc7E1U/mbUyCalp1qtZtBrh+R0ftarCYCf2vgd5UhlzmGF2Zt9bJh6Xeh9TlmWHYgUi0yJ6U=
X-Received: by 2002:adf:8484:: with SMTP id 4mr6913222wrg.334.1602694651494;
 Wed, 14 Oct 2020 09:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com> <20201014120937.GC4440@dhcp22.suse.cz>
In-Reply-To: <20201014120937.GC4440@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 14 Oct 2020 09:57:20 -0700
Message-ID: <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
Subject: Re: [RFC]: userspace memory reaping
To:     Michal Hocko <mhocko@suse.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 14, 2020 at 5:09 AM Michal Hocko <mhocko@suse.com> wrote:
>
> [Sorry for a late reply]
>
> On Mon 14-09-20 17:45:44, Suren Baghdasaryan wrote:
> > + linux-kernel@vger.kernel.org
> >
> > On Mon, Sep 14, 2020 at 5:43 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > Last year I sent an RFC about using oom-reaper while killing a
> > > process: https://patchwork.kernel.org/cover/10894999. During LSFMM2019
> > > discussion https://lwn.net/Articles/787217 a couple of alternative
> > > options were discussed with the most promising one (outlined in the
> > > last paragraph of https://lwn.net/Articles/787217) suggesting to use a
> > > remote version of madvise(MADV_DONTNEED) operation to force memory
> > > reclaim of a killed process. With process_madvise() making its way
> > > through reviews (https://patchwork.kernel.org/patch/11747133/), I
> > > would like to revive this discussion and get feedback on several
> > > possible options, their pros and cons.
>
> Thanks for reviving this!

Thanks for your feedback!

>
> > > The need is similar to why oom-reaper was introduced - when a process
> > > is being killed to free memory we want to make sure memory is freed
> > > even if the victim is in uninterruptible sleep or is busy and reaction
> > > to SIGKILL is delayed by an unpredictable amount of time. I
> > > experimented with enabling process_madvise(MADV_DONTNEED) operation
> > > and using it to force memory reclaim of the target process after
> > > sending SIGKILL. Unfortunately this approach requires the caller to
> > > read proc/pid/maps to extract the list of VMAs to pass as an input to
> > > process_madvise().
>
> Well I would argue that this is not really necessary. You can simply
> call process_madvise with the full address range and let the kernel
> operated only on ranges which are safe to tear down asynchronously.
> Sure that would require some changes to the existing code to not fail
> on those ranges if they contain incompatible vmas but that should be
> possible. If we are worried about backward compatibility then a
> dedicated flag could override.
>

IIUC this is very similar to the last option I proposed. I think this
is doable if we treat it as a special case. process_madvise() return
value not being able to handle a large range would still be a problem.
Maybe we can return MAX_INT in those cases?

> [...]
>
> > > While the objective is to guarantee forward progress even when the
> > > victim cannot terminate, we still want this mechanism to be efficient
> > > because we perform these operations to relieve memory pressure before
> > > it affects user experience.
> > >
> > > Alternative options I would like your feedback are:
> > > 1. Introduce a dedicated process_madvise(MADV_DONTNEED_MM)
> > > specifically for this case to indicate that the whole mm can be freed.
>
> This shouldn't be any different from madvise on the full address range,
> right?
>

Yep, just a matter of choosing the most appropriate API.

> > > 2. A new syscall to efficiently obtain a vector of VMAs (start,
> > > length, flags) of the process instead of reading /proc/pid/maps. The
> > > size of the vector is still limited by UIO_MAXIOV (1024), so several
> > > calls might be needed to query larger number of VMAs, however it will
> > > still be an order of magnitude more efficient than reading
> > > /proc/pid/maps file in 4K or smaller chunks.
>
> While this might be interesting for other usecases - userspace memory
> management in general - I do not think it is directly related to this
> particular feature.
>

True but such a syscall would be useful for other use cases, like
MADV_COLD/MADV_PAGEOUT that Minchan was working on. Maybe we can kill
more than one bird here? Minchan, any thought?

> > > 3. Use process_madvise() flags parameter to indicate a bulk operation
> > > which ignores input vectors. Sample usage: process_madvise(pidfd,
> > > MADV_DONTNEED, vector=NULL, vlen=0, flags=PMADV_FLAG_FILE |
> > > PMADV_FLAG_ANON);
>
> Similar to above.
>

Similar to option 1 I suppose. If so, I agree, just a matter of choosing API.

> > > 4. madvise()/process_madvise() handle gaps between VMAs, so we could
> > > provide one vector element spanning the entire address space. There
> > > are technical issues with this approach (process_madvise return value
> > > can't handle such a large number of bytes and there is MAX_RW_COUNT
> > > limit on max number of bytes one process_madvise call can handle) but
> > > I would still like to hear opinions about it. If this option is
> > > preferable maybe we can deal with these limitations.
>
> To be really honest, the more I am thinking about remove MADV_DONTNEED
> the less I like it. Sure we can limit this functionality to killed tasks
> but there is still a need to MMF_UNSTABLE that the current oom reaper
> sets to prevent from memory corruption while the kernel is still in
> kernel. Userspace memory reaper would need something similar.
>
> I do have a vague recollection that we have discussed a kill(2) based
> approach as well in the past. Essentially SIG_KILL_SYNC which would
> not only send the signal but it would start a teardown of resources
> owned by the task - at least those we can remove safely. The interface
> would be much more simple and less tricky to use. You just make your
> userspace oom killer or potentially other users call SIG_KILL_SYNC which
> will be more expensive but you would at least know that as many
> resources have been freed as the kernel can afford at the moment.

Correct, my early RFC here
https://patchwork.kernel.org/project/linux-mm/patch/20190411014353.113252-3-surenb@google.com
was using a new flag for pidfd_send_signal() to request mm reaping by
oom-reaper kthread. IIUC you propose to have a new SIG_KILL_SYNC
signal instead of a new pidfd_send_signal() flag and otherwise a very
similar solution. Is my understanding correct?

I remember Mel Gorman (who I forgot to CC in my original email and
added now) and Matthew Wilcox were actively participating in that
discussion during LSFMM. Would love to hear their opinions before
jumping into development.

Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
