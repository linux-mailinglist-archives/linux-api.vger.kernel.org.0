Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEDD3D3686
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhGWHif (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 03:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhGWHif (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 03:38:35 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530FC061575
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 01:19:08 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k65so1040009yba.13
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fq4Fh4QeM8XI+vyUIqPOIRXCTIfB49cqBPc4/QtIH+U=;
        b=dloDLGg4fXJdm4/Wrm6ZB7K2+ON08uA2iW/97Bm40pzw8M0/y7TC+Ng9UT76mHJTHv
         C0ppKytkc/8u6eXp5NPtf8qz9fLJ4PnCfsAlWmJSEwVuOXPPfc5JrsZSiewGVn1O+j3E
         +9CIZ9AStO6ZN1E5axBcLR360dWP15ECEtw0YcmpOOL57pJfwMUbMbM5sfgYMo73zZKa
         87v3CqCZm5KRP1BTwwU3aiDizqsM5qdcfblypkxCZaLvV8Lj+mnOWHFF7CKGSREHryH1
         Oz5fmSrrkfNlopqiP/MEcHyTC28TQklU/D095rjZB28dYTRbOLA7Um0ywW2b0/uR6bl9
         Y5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fq4Fh4QeM8XI+vyUIqPOIRXCTIfB49cqBPc4/QtIH+U=;
        b=ZcwroWWn0T20wrdIiE706vXOpx2qq15D6G93diIvU8Cmk/GQTehMLhBTPQtarcJPra
         xsYSWYqGu5oF+wTbSUN3oHHF7ED+IHYS0F/u0YHvrPOnCjYGa8ZIxtYDrEs+ntKSBHM/
         7bd/FJ+U4zFd4xqlNtEpJIas9LyiUYn/JF7bHHDw5x+XljDEdkrw20xe9YEYnul6448o
         YfHIxcbfGQtupoW84QzuuFExTZNsiFvUIZOcBiHFndzQE4oIxoEah/9VM9NrmIQ/rDNB
         XiQzTPyEoC/axD5GKaMu1aW5gD6r72imf6zbmuLsj1akJegrJ/KLVEaJvVF5+zQMRXYS
         G34A==
X-Gm-Message-State: AOAM530Kt/6UpaN9bulEpEqNWubd5wVXy8sV+ZeV4PALGE6ppXEaYLTD
        YOu0kCzn48dBXX+F8FrNFA8Nz4v++0sYurAmXtx53g==
X-Google-Smtp-Source: ABdhPJwgDfc0aM41zUz0in82Zs/wTUFLmp89jRt6vYbZp2U5yjFxAH0SP/iwlkBSF3REEbD+9yUtJDVjnWKmWsf9TDk=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr5079566ybc.136.1627028347391;
 Fri, 23 Jul 2021 01:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <23ed1d8d-fe55-fdbc-ca33-01a3ce392dff@redhat.com>
In-Reply-To: <23ed1d8d-fe55-fdbc-ca33-01a3ce392dff@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 23 Jul 2021 01:18:56 -0700
Message-ID: <CAJuCfpFSi2eLQL1YkHOubX+53Aa1ngZ1hS2+QervFnt5dLEQSw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
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

On Fri, Jul 23, 2021 at 1:15 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 23.07.21 10:11, Suren Baghdasaryan wrote:
> >
> >
> > On Thu, Jul 22, 2021, 11:20 PM Michal Hocko <mhocko@suse.com
> > <mailto:mhocko@suse.com>> wrote:
> >
> >     On Thu 22-07-21 21:47:56, Suren Baghdasaryan wrote:
> >      > On Thu, Jul 22, 2021, 7:04 PM Shakeel Butt <shakeelb@google.com
> >     <mailto:shakeelb@google.com>> wrote:
> >      >
> >      > > On Thu, Jul 22, 2021 at 6:14 PM Suren Baghdasaryan
> >     <surenb@google.com <mailto:surenb@google.com>>
> >      > > wrote:
> >      > > >
> >      > > [...]
> >      > > > +
> >      > > > +       mmap_read_lock(mm);
> >      > >
> >      > > How about mmap_read_trylock(mm) and return -EAGAIN on failure?
> >      > >
> >      >
> >      > That sounds like a good idea. Thanks! I'll add that in the next
> >     respin.
> >
> >     Why is that a good idea? Can you do anything meaningful about the
> >     failure other than immediately retry the syscall and hope for the best?
> >
> >
> > I was thinking if this syscall implements "best effort without blocking"
> > approach then for a more strict usage user can simply retry. However
> > retrying means issuing another syscall, so additional overhead...
> > I guess such "best effort" approach would be unusual for a syscall, so
> > maybe we can keep it as it is now and if such "do not block" mode is
> > needed we can use flags to implement it later?
>
> The process is dying, so I am not sure what we are trying to optimize
> here in respect to locking ...

Trying not to block the caller, which is likely a system health
monitoring process. However, if not blocking is important, it can
issue this syscall from a separate thread... Let's scratch that "do
not block" mode and keep it simple as it is now.

>
>
> --
> Thanks,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
