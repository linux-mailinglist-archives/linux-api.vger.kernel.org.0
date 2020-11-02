Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381AE2A3519
	for <lists+linux-api@lfdr.de>; Mon,  2 Nov 2020 21:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKBU3h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Nov 2020 15:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgKBU3h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Nov 2020 15:29:37 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24BDC061A04
        for <linux-api@vger.kernel.org>; Mon,  2 Nov 2020 12:29:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so10737421wmj.5
        for <linux-api@vger.kernel.org>; Mon, 02 Nov 2020 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECOxljNhNX/s1sQ6iseERJZz03J3Iz4bJCTWa11aECk=;
        b=jPO0UrA+g8o1Z94W0ABEZZV+bkPHrnTbfSRspSkgKKEvySDQKARqABAqhAPSZhyPPu
         egtFdNIu1i1Ue/xxkt0NhC2mEbVb59sN81GRBmSf7cnvvmDcVV7B20mnMXionPtPiRCZ
         7Tp/ALKy6GXTAPbbS/mcYUxxtVngeYdwZH6xE9u6gnIbdPkes8jzXHjkGPlJhtRCRHOJ
         YrIFb90mCDqzB55cBoXZjHARhiQUBIaVH+2iAnGHyYW22ppskRea8zUb97CO2UBPXWKk
         mnHySbK9GOyi0eQ0GKdGsfg2KDJXiBW+Q+pgSC7Z82uxMbeIpAOYvh8NJmnTn0s9+Ha6
         8wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECOxljNhNX/s1sQ6iseERJZz03J3Iz4bJCTWa11aECk=;
        b=ngs1mLNf8ABg5XC5Lw0cqZ6VezJPOfvvOZ7KhrpSLoOenW3qI5tSwZCmvrzb89eILE
         NTwFElYl54/OYquuZu5atXRHtWNIr6YXZUVSHp3lLjvrBm5YuTVkbS7dVDsUtjc1j7gG
         dWT+5jcRmajNq8287AHhBAJ8hiYO+ZgTX0bFEpeBjvOkcTyj0Rc/wlwzlw4+LDt0cnb6
         ay92OWlQgfMGhtJCsXGwihNHgQ8c2H7acUEOVAswrVmFN8ITdVuJscxC/fVxTXc/QMHI
         SWA2G90WL4DoDHX/74bnQZdHVNggCzNpj9H+AkKGkIbw2EZmEZxjsbkJvX1750Z7ml0x
         gi/A==
X-Gm-Message-State: AOAM530xunxLiil7s6xPqwCYWqoPbFjdFHYVVPwNAwIG/62YDYJSgo6u
        Qf7/vj1UJx/30F5kNKbSXXZJqHqx4ErD3Oj8ukWUIA==
X-Google-Smtp-Source: ABdhPJyBqPT7hImxXae117HZTa3xYjk6cLTEcHGERmKQOGcQAtw23SsJ9EEH1gW1YbRM9hOa//4svSCGGim8n//N9+I=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr8999674wmf.37.1604348975030;
 Mon, 02 Nov 2020 12:29:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz> <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz> <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
In-Reply-To: <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 2 Nov 2020 12:29:24 -0800
Message-ID: <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
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

On Thu, Oct 15, 2020 at 12:25 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Oct 15, 2020 at 2:20 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 14-10-20 09:57:20, Suren Baghdasaryan wrote:
> > > On Wed, Oct 14, 2020 at 5:09 AM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > > > The need is similar to why oom-reaper was introduced - when a process
> > > > > > is being killed to free memory we want to make sure memory is freed
> > > > > > even if the victim is in uninterruptible sleep or is busy and reaction
> > > > > > to SIGKILL is delayed by an unpredictable amount of time. I
> > > > > > experimented with enabling process_madvise(MADV_DONTNEED) operation
> > > > > > and using it to force memory reclaim of the target process after
> > > > > > sending SIGKILL. Unfortunately this approach requires the caller to
> > > > > > read proc/pid/maps to extract the list of VMAs to pass as an input to
> > > > > > process_madvise().
> > > >
> > > > Well I would argue that this is not really necessary. You can simply
> > > > call process_madvise with the full address range and let the kernel
> > > > operated only on ranges which are safe to tear down asynchronously.
> > > > Sure that would require some changes to the existing code to not fail
> > > > on those ranges if they contain incompatible vmas but that should be
> > > > possible. If we are worried about backward compatibility then a
> > > > dedicated flag could override.
> > > >
> > >
> > > IIUC this is very similar to the last option I proposed. I think this
> > > is doable if we treat it as a special case. process_madvise() return
> > > value not being able to handle a large range would still be a problem.
> > > Maybe we can return MAX_INT in those cases?
> >
> > madvise is documented to return
> >        On success, madvise() returns zero.  On error, it returns -1 and
> >        errno is set appropriately.
> > [...]
> > NOTES
> >    Linux notes
> >        The Linux implementation requires that the address addr be
> >        page-aligned, and allows length to be zero.  If there are some
> >        parts of the specified address range that are not mapped, the
> >        Linux version of madvise() ignores them and applies the call to
> >        the rest (but returns ENOMEM from the system call, as it should).
> >
> > I have learned about ENOMEM case only now. And it seems this is indeed
> > what we are implementing. So if we want to add a new mode to
> > opportunistically attempt madvise on the whole given range without a
> > failure then we need a specific flag for that. Advice is a number rather
> > than a bitmask but (ab)using the top bit or use negative number space
> > (e.g. -MADV_DONTNEED) for that sounds possible albeit bit hackish.
>
> process_madvise() has an additional flag parameter. Why not have a
> separate flag to denote that we want to just skip VMA gaps and proceed
> without error? Something like MADVF_SKIP_GAPS?
>
> >
> > [...]
> > > > I do have a vague recollection that we have discussed a kill(2) based
> > > > approach as well in the past. Essentially SIG_KILL_SYNC which would
> > > > not only send the signal but it would start a teardown of resources
> > > > owned by the task - at least those we can remove safely. The interface
> > > > would be much more simple and less tricky to use. You just make your
> > > > userspace oom killer or potentially other users call SIG_KILL_SYNC which
> > > > will be more expensive but you would at least know that as many
> > > > resources have been freed as the kernel can afford at the moment.
> > >
> > > Correct, my early RFC here
> > > https://patchwork.kernel.org/project/linux-mm/patch/20190411014353.113252-3-surenb@google.com
> > > was using a new flag for pidfd_send_signal() to request mm reaping by
> > > oom-reaper kthread. IIUC you propose to have a new SIG_KILL_SYNC
> > > signal instead of a new pidfd_send_signal() flag and otherwise a very
> > > similar solution. Is my understanding correct?
> >
> > Well, I think you shouldn't focus too much on the oom-reaper aspect
> > of it. Sure it can be used for that but I believe that a new signal
> > should provide a sync behavior. People more familiar with the process
> > management would be better off defining what is possible for a new sync
> > signal.  Ideally not only pro-active process destruction but also sync
> > waiting until the target process is released so that you know that once
> > kill syscall returns the process is gone.
>
> If your suggestion is for SIG_KILL_SYNC to perform victim's resource
> cleanup in the context of the caller while the victim is in
> uninterruptible sleep that would definitely be useful. I assume there
> are some resources which can't be reclaimed until the process itself
> wakes up and handles the SIGKILL. If so, I hope kill(SIG_KILL_SYNC)
> would not have to wait for the victim to wake up and handle the
> signal. This would really complicate the userspace in cases when we
> just want to reclaim whatever we can without victim's involvement and
> continue. For cases when waiting is required waitid() with P_PIDFD can
> be used.
> Would this semantic work?
>

To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
which in addition to sending a kill signal would also reap the
victim's mm in the context of the caller? Maybe having some code will
get the discussion moving forward?

> >
> > --
> > Michal Hocko
> > SUSE Labs
