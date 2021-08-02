Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233B43DE068
	for <lists+linux-api@lfdr.de>; Mon,  2 Aug 2021 22:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhHBUIz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Aug 2021 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHBUIz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Aug 2021 16:08:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B32EC06175F
        for <linux-api@vger.kernel.org>; Mon,  2 Aug 2021 13:08:44 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z18so3650940ybg.8
        for <linux-api@vger.kernel.org>; Mon, 02 Aug 2021 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxYj5zYVZBv3JoffDNb2oh5CmT3tQ9PMXwExh030AyY=;
        b=gAPpLlsnvFmwBUS/RotmADz0y1jFOql5yavKhcCuzzhLGTP773gam1KzfrZLjUiUYO
         vrAdGUXVwwnk8xF6hSlYaZJU5HSNoWJtsrFGI53HS/FHYIy8Hno1yff7dhDKmQeyunHV
         f28TBibGXlCmbZuBlJ8rmpIJZPLbsIxxPPsrmRK4lqEEgLeX/8aC67V01aohnUg+Jc7T
         iKlXYtFeVY1IJkCXrxJnd6mljaBfHQpRuS89jLXqDs/tI50kmbOBR3bLyxdG4zJtS2qZ
         y0BpBof9eCh/YBq1qLt/IJliATGCMu/M4cdho12OVjzlmqq48CkKt562vpTPlwBxHyxE
         hn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxYj5zYVZBv3JoffDNb2oh5CmT3tQ9PMXwExh030AyY=;
        b=oKzyW+Fcdsg1SOsc+pc2zhRRjA4vEkni5FdOQsIz9xkroRViP3jkEq0GGPQ05GHYcY
         Ex73LSjq8TUfz0NHeXBKQiCMNVESXntJ4Hy/RbAUqO/oOUtFB/egOBvtK0qNeAFB6Plo
         jlqVbYhDknV3TDVp90zofXaA/3F9/hyh3Owrrl9OfEFVwHBt6XOimwkQLTWtkTuAXCyR
         cO+QTI815FFaCo0aVOAUqfgjGBC6UzYH1/dIhbs4k5jeYsFa05FBkXm4YKU1L9BACV99
         sipD6VgIxz6cKGaHZh/flfvSv0GWFrEHENvFG2/c/TsNHYe7p75BuJfPprh0/+wPpeQI
         ZKxw==
X-Gm-Message-State: AOAM532iYIgTFHOIbTXgEpUV9yxmGGtQ71fUttXnbM+rtMRFc4/N6c2j
        o8yEFOHyY5jqbbhUjhgWmnALwOPpmIIaOAAoW0zVEA==
X-Google-Smtp-Source: ABdhPJw9JDr+e+SrPj7jJ/TgU+U9CAwlGhl01CB2D6tdPsR4tGrBGm8zKZFdiwctNmPUMtVoabAkddYuwkdLfCl+uXw=
X-Received: by 2002:a25:9ac6:: with SMTP id t6mr23179320ybo.190.1627934923594;
 Mon, 02 Aug 2021 13:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz> <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
 <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
 <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com>
 <YP5jyLeYsN3JtdX8@dhcp22.suse.cz> <CALvZod4M6mF3VvAdade3n5fE1E0LQp+CeJHWLc+pHmZqqAhepg@mail.gmail.com>
 <CAJuCfpHObuK7jOcqdme9fU5=zFoteaY+5f2_uKdW0VQJa6H7OQ@mail.gmail.com> <CALvZod7-0zra65jTUUYx6Oi17GPbRtHpAtVysiTX4_=bfqthPA@mail.gmail.com>
In-Reply-To: <CALvZod7-0zra65jTUUYx6Oi17GPbRtHpAtVysiTX4_=bfqthPA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 2 Aug 2021 13:08:32 -0700
Message-ID: <CAJuCfpHVUZZFPBFc6SPWOT7TrH5=SczegruB1+j=2N_ka7DG4A@mail.gmail.com>
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

On Mon, Aug 2, 2021 at 1:05 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Aug 2, 2021 at 12:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Jul 26, 2021 at 6:44 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Mon, Jul 26, 2021 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > [...]
> > > >
> > > > Is process_mrelease on all of them really necessary? I thought that the
> > > > primary reason for the call is to guarantee a forward progress in cases
> > > > where the userspace OOM victim cannot die on SIGKILL. That should be
> > > > more an exception than a normal case, no?
> > > >
> > >
> > > I am thinking of using this API in this way: On user-defined OOM
> > > condition, kill a job/cgroup and unconditionally reap all of its
> > > processes. Keep monitoring the situation and if it does not improve go
> > > for another kill and reap.
> > >
> > > I can add additional logic in between kill and reap to see if reap is
> > > necessary but unconditionally reaping is more simple.
> > >
> > > >
> > > > > An alternative would be to have a cgroup specific interface for
> > > > > reaping similar to cgroup.kill.
> > > >
> > > > Could you elaborate?
> > > >
> > >
> > > I mentioned this in [1] where I was thinking if it makes sense to
> > > overload cgroup.kill to also add the SIGKILLed processes in
> > > oom_reaper_list. The downside would be that there will be one thread
> > > doing the reaping and the syscall approach allows userspace to reap in
> > > multiple threads. I think for now, I would go with whatever Suren is
> > > proposing and we can always add more stuff if need arises.
> > >
> > > [1] https://lore.kernel.org/containers/CALvZod4jsb6bFzTOS4ZRAJGAzBru0oWanAhezToprjACfGm+ew@mail.gmail.com/
> >
> > Hi Folks,
> > So far I don't think there was any request for further changes.
> > Anything else you would want me to address or are we in a good shape
> > wrt this feature?
> > If so, would people who had a chance to review this patchset be
> > willing to endorse it with their Reviewed-by or Acked-by?
>
> I think with Michal's suggestion to use a killable mmap lock, at least
> I am good with the patch.

Ah, yes. Thanks for pointing this out! I'll replace mmap_read_lock()
with mmap_read_lock_killable(). Will post an updated version later
today.
