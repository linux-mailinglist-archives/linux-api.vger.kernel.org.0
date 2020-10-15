Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE628F95C
	for <lists+linux-api@lfdr.de>; Thu, 15 Oct 2020 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbgJOT0C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Oct 2020 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391450AbgJOT0C (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Oct 2020 15:26:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC210C0613D2
        for <linux-api@vger.kernel.org>; Thu, 15 Oct 2020 12:26:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i1so5080829wro.1
        for <linux-api@vger.kernel.org>; Thu, 15 Oct 2020 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BM5j8lFQHmLcRInx4ruZjAKix1kTSPiqlMHVrc6IXZk=;
        b=RQ38oRb0HDdpyJFT4QueSLjg4Jba/1+K+imPMYvEzhEj8x0iJd4uroXsyHUp+xyEXE
         p4Z/AgcUID1tuzqUpWPbP9GnN0pDXG/Z6h95HcmBgj5164uijucopL9B5+2ffsjsdZPI
         zkcwLujawBscI0HizUBM9XECG8twNArBnGmjCZOxWygRrxa3vduez/Z5vtjetIrAcCfm
         1W68d+tsSrfhFi4vioRPido2vmr1sWz1xpDarY3mBO1cwYnjHnWKfQU3Dhp2VPZ5nKz1
         tdaDkT3x2fyS82L+C2pfrinntVs2HXorzxuNmLWtIvbR7fM2rbJgPxeo002IM9E73cua
         9Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BM5j8lFQHmLcRInx4ruZjAKix1kTSPiqlMHVrc6IXZk=;
        b=tVvOu/TIPQxgiwS4UmHMSMKHNr/pQA3isFra5+vyuGrTrqSlWffmh3vOENajzojUDe
         Ak7oJloy1Tic8WqCzsYjA0iCoU+4n/MPYERp1gcF7NfPHIzLcK0zAwrjTSu7/P10LZJr
         2Kx+itu+WRCm0cYVaWMalC0afSrvtBf+zpSkOHdqMGyTbe/H+wPuAKklbpqFq9Vr3Wbp
         bKTIRuFBKnO3q1mD3DImYEvUwijvAGy8j53HAg8vzdiailyFOkWCfAeQ4TOVijUhAfK7
         RWgrbAI9lhNaUBvUCku6JpLYwGFinTr1B6e2xD5wrOU0Dt8GQ5YvdeN7WawOjJ5gbRcr
         A4iA==
X-Gm-Message-State: AOAM5327hEKub4j06s4jc7WQaWtSdmM9tFQKvHcbLYB9L5/jXw9q7pmh
        jrhPxYOpPZSsLBEt7woul8LD7rma8AOpjfmnTOU61A==
X-Google-Smtp-Source: ABdhPJxkkb+qmNoeoJdvu/rhJW682Savil74aegbnLYZMmBT7v7xPl/T9j5ZrOhc3OwiCZGEIMJOL5dRdwyqGVaBxVc=
X-Received: by 2002:a5d:498a:: with SMTP id r10mr6072067wrq.106.1602789959057;
 Thu, 15 Oct 2020 12:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz> <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
In-Reply-To: <20201015092030.GB22589@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 15 Oct 2020 12:25:43 -0700
Message-ID: <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
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

On Thu, Oct 15, 2020 at 2:20 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 14-10-20 09:57:20, Suren Baghdasaryan wrote:
> > On Wed, Oct 14, 2020 at 5:09 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > > The need is similar to why oom-reaper was introduced - when a process
> > > > > is being killed to free memory we want to make sure memory is freed
> > > > > even if the victim is in uninterruptible sleep or is busy and reaction
> > > > > to SIGKILL is delayed by an unpredictable amount of time. I
> > > > > experimented with enabling process_madvise(MADV_DONTNEED) operation
> > > > > and using it to force memory reclaim of the target process after
> > > > > sending SIGKILL. Unfortunately this approach requires the caller to
> > > > > read proc/pid/maps to extract the list of VMAs to pass as an input to
> > > > > process_madvise().
> > >
> > > Well I would argue that this is not really necessary. You can simply
> > > call process_madvise with the full address range and let the kernel
> > > operated only on ranges which are safe to tear down asynchronously.
> > > Sure that would require some changes to the existing code to not fail
> > > on those ranges if they contain incompatible vmas but that should be
> > > possible. If we are worried about backward compatibility then a
> > > dedicated flag could override.
> > >
> >
> > IIUC this is very similar to the last option I proposed. I think this
> > is doable if we treat it as a special case. process_madvise() return
> > value not being able to handle a large range would still be a problem.
> > Maybe we can return MAX_INT in those cases?
>
> madvise is documented to return
>        On success, madvise() returns zero.  On error, it returns -1 and
>        errno is set appropriately.
> [...]
> NOTES
>    Linux notes
>        The Linux implementation requires that the address addr be
>        page-aligned, and allows length to be zero.  If there are some
>        parts of the specified address range that are not mapped, the
>        Linux version of madvise() ignores them and applies the call to
>        the rest (but returns ENOMEM from the system call, as it should).
>
> I have learned about ENOMEM case only now. And it seems this is indeed
> what we are implementing. So if we want to add a new mode to
> opportunistically attempt madvise on the whole given range without a
> failure then we need a specific flag for that. Advice is a number rather
> than a bitmask but (ab)using the top bit or use negative number space
> (e.g. -MADV_DONTNEED) for that sounds possible albeit bit hackish.

process_madvise() has an additional flag parameter. Why not have a
separate flag to denote that we want to just skip VMA gaps and proceed
without error? Something like MADVF_SKIP_GAPS?

>
> [...]
> > > I do have a vague recollection that we have discussed a kill(2) based
> > > approach as well in the past. Essentially SIG_KILL_SYNC which would
> > > not only send the signal but it would start a teardown of resources
> > > owned by the task - at least those we can remove safely. The interface
> > > would be much more simple and less tricky to use. You just make your
> > > userspace oom killer or potentially other users call SIG_KILL_SYNC which
> > > will be more expensive but you would at least know that as many
> > > resources have been freed as the kernel can afford at the moment.
> >
> > Correct, my early RFC here
> > https://patchwork.kernel.org/project/linux-mm/patch/20190411014353.113252-3-surenb@google.com
> > was using a new flag for pidfd_send_signal() to request mm reaping by
> > oom-reaper kthread. IIUC you propose to have a new SIG_KILL_SYNC
> > signal instead of a new pidfd_send_signal() flag and otherwise a very
> > similar solution. Is my understanding correct?
>
> Well, I think you shouldn't focus too much on the oom-reaper aspect
> of it. Sure it can be used for that but I believe that a new signal
> should provide a sync behavior. People more familiar with the process
> management would be better off defining what is possible for a new sync
> signal.  Ideally not only pro-active process destruction but also sync
> waiting until the target process is released so that you know that once
> kill syscall returns the process is gone.

If your suggestion is for SIG_KILL_SYNC to perform victim's resource
cleanup in the context of the caller while the victim is in
uninterruptible sleep that would definitely be useful. I assume there
are some resources which can't be reclaimed until the process itself
wakes up and handles the SIGKILL. If so, I hope kill(SIG_KILL_SYNC)
would not have to wait for the victim to wake up and handle the
signal. This would really complicate the userspace in cases when we
just want to reclaim whatever we can without victim's involvement and
continue. For cases when waiting is required waitid() with P_PIDFD can
be used.
Would this semantic work?

>
> --
> Michal Hocko
> SUSE Labs
