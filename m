Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C913D3E08
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhGWQUH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhGWQUH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 12:20:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB6C061757
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 10:00:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u3so3115086lff.9
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYrZg+fpRQAmubKOisYlI4PP99r2kR+Pc+emzbHA1zU=;
        b=VIsnpgjCvbquqGy8008dby3WGq1lkP0WIKEXONe2zP3+7E8+Bqd70Z+nw+8CTxPdVG
         fTF4I0uoy5w17M0iQl1dD64gcIXcr2NbpNJiRuoWnI2R4Nq8b9/4kritGYxRVpL+5Srq
         Ontytx421RfBfulHBx4pTLtcUXqVFYwoX3BnhAaHltHe1YK1DFjT9yVaLkNq8wSLrXHC
         ZAuOR1hE6s6zZrgvJFjs0y1eWGw9+dsO9w+ojiQbGaADbEXT4/RnUTJKpVZ70s5xFLv3
         PTCtCXIz23hGMJvKvyJAPEpH4nKokDR+RvbDiNBfjqOH+sTZ2P4Zi6AP98qsI0pcz/Vn
         aOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYrZg+fpRQAmubKOisYlI4PP99r2kR+Pc+emzbHA1zU=;
        b=exiAt80D3khvUG91u1/wbAe+bTFj4cEPzvnEG3KIjTjTGNiLE9aFz6JT6x+cg1Zi8Z
         qXA9+uRyg7c4w67l+Luzq6nISB18vlj6VRvKAE4kIhVEDfV8GROKbypn8Ekak3dNeUaD
         xNWDPVGvnwbMjiz4pNzICck9ShgwS47hJ+A2mtUNK1B4czzp/6Xgmgcrl9Q1FSQNM5KL
         ULOPsQxc3epKfhvW/U2sOiEEaNaFagZxr+K1MMG4CT2lralkWbS12LVHMjLCusTbcD7o
         xQBWjuEjLR9z56e9+EeYla4J6YG4V2l836XB7gbyRoD+VVz9YUwPJz9WM9FQOZxR6m0G
         cJQg==
X-Gm-Message-State: AOAM5309M5obDxFmzr10BG5yz/unSqkWd5iz7yDzIYtO1pt4ekOWbW+k
        KFOjTKNu96NiMj/Z+c8fNCeSX47KA59xUFj3LxtngA==
X-Google-Smtp-Source: ABdhPJx+E64jFTPgcU+HWdNxXsKIHIGys4KGyK9bevyN+71SfSiqn0Ofw2Xe2zbrnwRUnVeYmcbPMNQdf80YQ2Nx5bA=
X-Received: by 2002:a05:6512:c23:: with SMTP id z35mr3714473lfu.299.1627059638178;
 Fri, 23 Jul 2021 10:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz> <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
 <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 23 Jul 2021 10:00:26 -0700
Message-ID: <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 23, 2021 at 9:09 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Jul 23, 2021 at 6:46 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Fri, Jul 23, 2021 at 1:53 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > [...]
> > > > However
> > > > retrying means issuing another syscall, so additional overhead...
> > > > I guess such "best effort" approach would be unusual for a syscall, so
> > > > maybe we can keep it as it is now and if such "do not block" mode is needed
> > > > we can use flags to implement it later?
> > >
> > > Yeah, an explicit opt-in via flags would be an option if that turns out
> > > to be really necessary.
> > >
> >
> > I am fine with keeping it as it is but we do need the non-blocking
> > option (via flags) to enable userspace to act more aggressively.
>
> I think you want to check memory conditions shortly after issuing
> kill/reap requests irrespective of mmap_sem contention. The reason is
> that even when memory release is not blocked, allocations from other
> processes might consume memory faster than we release it. For example,
> in Android we issue kill and start waiting on pidfd for its death
> notification. As soon as the process is dead we reassess the situation
> and possibly kill again. If the process is not dead within a
> configurable timeout we check conditions again and might issue more
> kill requests (IOW our wait for the process to die has a timeout). If
> process_mrelease() is blocked on mmap_sem, we might timeout like this.
> I imagine that a non-blocking option for process_mrelease() would not
> really change this logic.

On a containerized system, killing a job requires killing multiple
processes and then process_mrelease() them. Now there is cgroup.kill
to kill all the processes in a cgroup tree but we would still need to
process_mrelease() all the processes in that tree. There is a chance
that we get stuck in reaping the early process. Making
process_mrelease() non-blocking will enable the userspace to go to
other processes in the list.

An alternative would be to have a cgroup specific interface for
reaping similar to cgroup.kill.

> Adding such an option is trivial but I would like to make sure it's
> indeed useful. Maybe after the syscall is in place you can experiment
> with it and see if such an option would really change the way you use
> it?

SGTM.
