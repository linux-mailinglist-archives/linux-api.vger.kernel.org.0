Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2964A3DE052
	for <lists+linux-api@lfdr.de>; Mon,  2 Aug 2021 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhHBTyN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Aug 2021 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhHBTyM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Aug 2021 15:54:12 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1826FC06175F
        for <linux-api@vger.kernel.org>; Mon,  2 Aug 2021 12:54:03 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b133so212610ybg.4
        for <linux-api@vger.kernel.org>; Mon, 02 Aug 2021 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r51pjfza8s2HZE4XW/GNL6Iowf+AIDCryqM3vDA5jF0=;
        b=DAYvA9rfP2uv0YWaF+1ehuOCq1YPB/a8+QNZRahtWdRbWaD6MEOHky451k9S8b7xeG
         B2Im902DswK42N/fylfIy3bOexB+GE0C9pLTSfbmBoR4Cm46UH7IIM4/TLdJqLcGQbsP
         w/PDxJq7kELy9/mdLj9CGkJhECn9IYBK7zNzfvZPtC5p0lWvbVsrj1fZT9mxL/2Y9I8N
         dOeFqVAloLTVBWcrlMMpvIBaCcquN2VC6GsGjlTXUVzoQKjcN3b2AHjIza5a0Gnrbu8B
         AS9CehPVUNe/wPrQJ4DPXbO8IuHri/i7LMBKnikgsKmNSyKLkE6gDAVangHIhcTq14go
         Bwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r51pjfza8s2HZE4XW/GNL6Iowf+AIDCryqM3vDA5jF0=;
        b=uXAiM3USlyzGOqcTz5fGXMbbCDYnPJyb4gg6xiolsMnIqamg0IVzmmJEiGlASbKyUu
         j8cGGsO/q7bYxqH6O/u4cnd/129XasQb0k1T3s8TeQyCzXCTyCd90KOJydrlKYSqSje1
         o9FVsUR/TIdeMJ08BLHt6c7TjT4Hz9W2ZR7AGC4DkGbBaTGGEbMP/RSc2GILiOkZfG0Z
         mHrBdkMmjIgSFe7Z3xGeOvxqxn6bSvHdaBjf8O9KEkNs9H83tRYFdASlSBbvqt7/pkzH
         RszVtvQ6vfeMSJUkF3B6krZkyfMFxhXxpbAt0GXrx2GptFdxt2hrPoaEdtTwsRanLUgT
         e3Ow==
X-Gm-Message-State: AOAM533+dr0UPT6CF/2345e/knYYLIP3oxbSvpbfPoW+rk93PmPRtYXx
        iq6LdA7fduRBW6YOjJSuxwwcPkPS4/JugJjWQc+5xw==
X-Google-Smtp-Source: ABdhPJxpo6fn/Ec+BXl6VDLMbnEoz80RcLHLkmWuS2+jWCgCgL5B6GLoLxGdD9dM5qOafDXt/CjrVtAJ+R98d8uKhMQ=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr23611603ybc.136.1627934042111;
 Mon, 02 Aug 2021 12:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz> <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
 <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
 <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com>
 <YP5jyLeYsN3JtdX8@dhcp22.suse.cz> <CALvZod4M6mF3VvAdade3n5fE1E0LQp+CeJHWLc+pHmZqqAhepg@mail.gmail.com>
In-Reply-To: <CALvZod4M6mF3VvAdade3n5fE1E0LQp+CeJHWLc+pHmZqqAhepg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 2 Aug 2021 12:53:51 -0700
Message-ID: <CAJuCfpHObuK7jOcqdme9fU5=zFoteaY+5f2_uKdW0VQJa6H7OQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Shakeel Butt <shakeelb@google.com>
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

On Mon, Jul 26, 2021 at 6:44 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Jul 26, 2021 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> >
> > Is process_mrelease on all of them really necessary? I thought that the
> > primary reason for the call is to guarantee a forward progress in cases
> > where the userspace OOM victim cannot die on SIGKILL. That should be
> > more an exception than a normal case, no?
> >
>
> I am thinking of using this API in this way: On user-defined OOM
> condition, kill a job/cgroup and unconditionally reap all of its
> processes. Keep monitoring the situation and if it does not improve go
> for another kill and reap.
>
> I can add additional logic in between kill and reap to see if reap is
> necessary but unconditionally reaping is more simple.
>
> >
> > > An alternative would be to have a cgroup specific interface for
> > > reaping similar to cgroup.kill.
> >
> > Could you elaborate?
> >
>
> I mentioned this in [1] where I was thinking if it makes sense to
> overload cgroup.kill to also add the SIGKILLed processes in
> oom_reaper_list. The downside would be that there will be one thread
> doing the reaping and the syscall approach allows userspace to reap in
> multiple threads. I think for now, I would go with whatever Suren is
> proposing and we can always add more stuff if need arises.
>
> [1] https://lore.kernel.org/containers/CALvZod4jsb6bFzTOS4ZRAJGAzBru0oWanAhezToprjACfGm+ew@mail.gmail.com/

Hi Folks,
So far I don't think there was any request for further changes.
Anything else you would want me to address or are we in a good shape
wrt this feature?
If so, would people who had a chance to review this patchset be
willing to endorse it with their Reviewed-by or Acked-by?
Thanks,
Suren.
