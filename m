Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5215844EAEC
	for <lists+linux-api@lfdr.de>; Fri, 12 Nov 2021 17:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhKLQDH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Nov 2021 11:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhKLQDH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Nov 2021 11:03:07 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1FCC061767
        for <linux-api@vger.kernel.org>; Fri, 12 Nov 2021 08:00:16 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id u60so24790443ybi.9
        for <linux-api@vger.kernel.org>; Fri, 12 Nov 2021 08:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBw7nAjDOpIx54PL6CtGwWGYEgjR+E9SaAUwBkpc0jU=;
        b=WSQXrHTUecwEOSkMbrwVBr1/kG09TKAuuO8JuMhKDKK/fO1ZcBuQh+ygHQrscvvgJH
         tcjgPqYIkW/IqWlXpwfZrQ+F3IylFOhypk/ImwK439XxfSH3ffIWDNiGnxvhXsskudzh
         KpRPaNZecMQ+yI27VP+/1X0ar1tcVjyz0z8ptzTwAFRoFRNjwI6Gp2c7MQBQBc/GOQ03
         NkVdXim3hlPeXY/MOWeWfoez8vYrpjGorH9Ol0mW6lGuDCoOOpttS0lJztrD0ijaTD3d
         Iyzqhr6Q1SSs13vbRIUsCxyxlRXVobBrLnau+h6RiAC4oveffTcsPOiiuzX0/IEkYdur
         ygDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBw7nAjDOpIx54PL6CtGwWGYEgjR+E9SaAUwBkpc0jU=;
        b=dswymQrmGe6CaHNHHAv3G6R5kS0byH4bo05Z/bpafK3nmMmnCeyp4qLJO1wvLLw//c
         PqA+7dSAeMZmHajH3KgfvvG6/mC55++BcLt+e3RhGaSsMxkvyEKM4zghDCV+CF+T+PHY
         KXfkax1k1s2PpB7VDNV7hPMZN24lTct92Cy8IBXdI/RP2qC5VRXK6k9JQTessan0iKVx
         q1koVe+Z7LzO10mThZL9dDv52L/MLABgSEti6DWNkJz7JJMRTUz+NuXJ1SgTL1/Qc7ek
         YwUJc1eWUljVCvWLL+IwiyEeuSNRuRtyKSJo7UwFt9dqu/fi6FYcCVZ0OqqXkpRG2M2D
         qXjA==
X-Gm-Message-State: AOAM532xAfGPF3w4F+1zxeHKnnBuA6IZrw+7b2tkZnsfOuy7PlTEnDPU
        sRZ55t8z8m2efxg7BsT27teH3i8kZtqli7Jtx4pmlQ==
X-Google-Smtp-Source: ABdhPJwHn8mpOswus43mfCk29R4fAdhIqXVj+xv1CqLJYRPCfc06/HRFtJmqn2nab1RhER4AK8hBOKWBSACFO0H4H18=
X-Received: by 2002:a05:6902:134b:: with SMTP id g11mr17195784ybu.202.1636732815170;
 Fri, 12 Nov 2021 08:00:15 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz> <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
 <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz> <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
 <YYrVmi2xdo1Gr2Bb@dhcp22.suse.cz> <CAJuCfpGrYa2Ws4GrVp_nRqVEw8j_cGXk+gprLYUx7NWUOC-uRQ@mail.gmail.com>
 <CAJuCfpHJnVG7PMhKW-Snz38az-Bv=QCFXa7DxD=KgEMbHJOi6A@mail.gmail.com>
 <YYzgZARxi8csprIx@dhcp22.suse.cz> <CAJuCfpEK+yruF8D9rzS44N3n6OLASL7nK2dfNj9daWpk-BguwQ@mail.gmail.com>
 <YY4snVzZZZYhbigV@dhcp22.suse.cz>
In-Reply-To: <YY4snVzZZZYhbigV@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 12 Nov 2021 08:00:04 -0800
Message-ID: <CAJuCfpHXZvCCi=DW53i9qbmcjY48CmSVBCaYqbSyyBmmp9JqaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 12, 2021 at 12:58 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Thu 11-11-21 07:02:42, Suren Baghdasaryan wrote:
> > On Thu, Nov 11, 2021 at 1:20 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 10-11-21 17:49:37, Suren Baghdasaryan wrote:
> > > > On Tue, Nov 9, 2021 at 1:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > On Tue, Nov 9, 2021 at 12:10 PM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > > Yes, those can run concurrently. One thing I completely forgot about is
> > > > > > 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> > > > > > which is about interaction with the munlock.
> > > >
> > > > Agrh! This interaction with the munlock you mentioned requires us to
> > > > take mmap_write_lock before munlock_vma_pages_all and that prevents
> > > > __oom_reap_task_mm from running concurrently with unmap_vmas. The
> > > > reapers would not be as effective as they are now after such a change
> > > > :(
> > >
> > > __oom_reap_task_mm will not run concurrently with unmap_vmas even
> > > with the current code. The mmap_sem barrier right before munlock code
> > > prevents that.
> >
> > You are right, it will run concurrently with another
> > __oom_reap_task_mm in the exit_mmap. But I thought we wanted to get
> > rid of that call to __oom_reap_task_mm in exit_mmap or did I
> > misunderstand?
>
> I do not remember this to be objective or the motivation. IIRC we wanted
> to make the locking more robust which would help your process_mrelease
> use case. This one currently suffers from a much heavier cost if it
> turns out to be the last holder of the reference count on the address
> space.

Ok, I wrongly assumed the mmap_lock cleanup should be deeper. Will
keep pounding on it. Thanks!

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
