Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D428F988
	for <lists+linux-api@lfdr.de>; Thu, 15 Oct 2020 21:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgJOTcf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Oct 2020 15:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgJOTce (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Oct 2020 15:32:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BACCC0613D2
        for <linux-api@vger.kernel.org>; Thu, 15 Oct 2020 12:32:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q5so218073wmq.0
        for <linux-api@vger.kernel.org>; Thu, 15 Oct 2020 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4HayBldfHnr9vzT+RQI1NZht7qEgetcfgLsh2qzQDc=;
        b=c3ipEjBIGCQrkIDwRMsWKNjMrVyvyC8372nQq5KeA2TZ6YUB3EdnHp5+D6+1BYCsFl
         zslNV27aKU0qEl6JWzc4IvaiRMoVOzL2xP58HqntHSxeJkcBzn+7eUyS0BsO3G5hYWdm
         htlxDaxUXjrY7OTOtPwK93gRPUk154t2iSD5yV7dc53BDOvfO955ueahKQdHan2dEwNM
         f8imtv8OTkaFuvm75kDp5eMpddgZSVc5sbTQJkpvM1wSrsJ0SQeJ5iILhKnH2PmMvBIi
         xRO7tSjmhO/O0I3EkHFjxWVEanPvd0JTl6rmo6n5D7z+SPTiJ9HdxaXhuBJD+mDBfwLw
         YTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4HayBldfHnr9vzT+RQI1NZht7qEgetcfgLsh2qzQDc=;
        b=dmcPjF3bUvHW0xRr6aJpMxnMXMSR+WmLBQZsvNXCPUvmElQ+g4i6l6f8ahrbiyz2fv
         KXhlVKq2jG5oCZbGEhwvC6SA6unVa5nqQzVwZwzjesT/a0bqBJc090r4ej9AXhB3QwLe
         qTB3NHSk947wfzmrUYesblRpSuaOp8aVnFoCrBjBJsCn/rZRHnapjVnmQernIe1NMlab
         jZ99nLk46hMoU2JphOJidXJvQSkDrERLgYdpgBgeV4NWk6nETd0T6xmZRj+Mub5y+NYE
         SH/TrFkfJASWkxzf075CkXXdeULRn2BpsvqOleTmmxSpH7M5Qx5uQrCh5rkC1gqlGhg0
         9a0A==
X-Gm-Message-State: AOAM532q2PiUe3iYZYbuwr0xhX4lArj2TMNvCaSmypbfjw+wSDL3CVsF
        i9w0SbQUp/ExXpAr5insNq8jsqpS3i6u3uR2c/a1cw==
X-Google-Smtp-Source: ABdhPJxXYX/Zl8p2deWeKmdwebpm8ejyMBd5EqRJXZoD2uNDwfMK5sT461+XZWIZ1ox7sntItqlyH+Vzw7IjUtinNN0=
X-Received: by 2002:a1c:111:: with SMTP id 17mr213767wmb.126.1602790352867;
 Thu, 15 Oct 2020 12:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz> <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz> <20201015184349.GA3930989@google.com>
In-Reply-To: <20201015184349.GA3930989@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 15 Oct 2020 12:32:22 -0700
Message-ID: <CAJuCfpF1MxHbUQ-eSGO5nPDVeGrFGUDrdvQgh7iVNX46-=0i4w@mail.gmail.com>
Subject: Re: [RFC]: userspace memory reaping
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
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

On Thu, Oct 15, 2020 at 11:43 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Thu, Oct 15, 2020 at 11:20:30AM +0200, Michal Hocko wrote:
>
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
> If we approach with signal, I am not sure we need to create new signal
> rather than pidfd and fsync(2) semantic.
>
> Furthermore, process_madvise makes the work in the caller context but
> signal might work somewhere else context depending on implemenation(
> oom reaper or CPU resumed the task). I am not sure it it fulfils Suren's
> requirement.
>
> One more thing to think over: Even though we spent some overhead to
> read /proc/pid/maps, we could make zapping in parallel in userspace
> with multi thread approach. I am not sure what's the win since Suren
> also care about zapping performance.

Sorry Minchan, I did not see your reply while replying to Michal...
Even if we do the reading/reaping in parallel, we still have to issue
10s of read() syscalls to consume the entire /proc/pid/maps file. Plus
I'm not sure how much mmap_sem contention such parallel operation
(reaping taking write lock and maps reading taking read lock) would
generate. If we go this route I think a syscall to read a vector of
VMAs would be way more performant and userspace usage would be much
simpler.
