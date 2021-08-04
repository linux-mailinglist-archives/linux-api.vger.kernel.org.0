Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28C13E062E
	for <lists+linux-api@lfdr.de>; Wed,  4 Aug 2021 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhHDQyj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbhHDQyi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 12:54:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80184C0613D5
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 09:54:25 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id j77so4857763ybj.3
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN6+s2skg1cQMKmJXP1gEppbA6Yu/yhjKK82lWQnCnM=;
        b=RPnPRoc8iKAsaPqqQNjqaVwHWGrkxjKMuFopfvnxvMqSsAZaeJ1wNkdFdL146W5pZv
         pfZnOtJt5PjrMUXAl979FTJ0LLGbQ1G5nkKu6g9VKxcAKuSiB/iSGzD5ICo7S7vTFfDr
         ZuwENH41eo28rKjtoBx2jwfst5bX/JJ0PR7KYfwYlggjNcKvW0azFQZZU+sv554GrDad
         qpxoDLz36EtxdpjcZGzJoB7btq4LqOUXofKJP831jL+rwRMraX2MfHwWYxNlGYihVSvZ
         MvSmK9RgZjg4hJkdpMYx08jORZEXMxhH4lwmYWwL46qQqNohfr2ZEKgfqDElhC6XIgsg
         CNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN6+s2skg1cQMKmJXP1gEppbA6Yu/yhjKK82lWQnCnM=;
        b=CsCaUn1YAuCaG4s2Ewc1OevuifS4XKVsZOBUIKDGXuvKM9Nsc0XLvDjZbuWOiR1vTg
         G/a8kIp6k1N67ZdlZF2y+d8A1we/R/01uEhpcfy7IRKvH/C08CqYdlbKB9bJFq0twOGN
         dnf9Ih3M9jj7lFQiEb1rl7Fl2vjJ+wNFhhN1MZv+ng1pkFfsil+qIrk1crmvkP8vBedL
         Zxart3EDEG/thKf+LrIMTaWMZ9AzPuNFA6OT03pp+dd7zKMl7YOKCN34PmgYe7MRvaq0
         L7R/7+clb1dEVfujJeXQiI0xOmNeNCieprLxa3tkzX5Qwi54W+q6Igxx8XxZNwGAEjZG
         Q4vg==
X-Gm-Message-State: AOAM532dkl2DmPPvkvPHAmSsMUZ3CT/OvUXkp5N+w65gKNS6f7zppP82
        A3pC+z9DSEURqG6kiQmtxbXVeFaXdfTUXO65HJJOGw==
X-Google-Smtp-Source: ABdhPJxPn/6uYOUWAMU+RHYMsTFL8YmkD7GufT2JGUw3Tr/B220J2elCakmRm5hFcPBgL9rtDUkv+rV72fghjOYpmpM=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr369533ybc.136.1628096064532;
 Wed, 04 Aug 2021 09:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210802221431.2251210-1-surenb@google.com> <YQkAqwZIF+AnpexA@dhcp22.suse.cz>
 <CAJuCfpGiYAdvOydimHbK73oKS-ZfMMBtADXxWCYpxkX2qJX08g@mail.gmail.com>
 <CAJuCfpEjb+o_TuQqxYALcvpr+4kq7tVNjq7A3oahB=1=JPyWtw@mail.gmail.com> <YQox2Ems40WXmJ3z@dhcp22.suse.cz>
In-Reply-To: <YQox2Ems40WXmJ3z@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 4 Aug 2021 09:54:12 -0700
Message-ID: <CAJuCfpFX4t_SpWs5de=dSvW8jWvJ6tYJPFeesY2mYuGtxSDOxg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: introduce process_mrelease system call
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
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 3, 2021 at 11:21 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 03-08-21 15:09:43, Suren Baghdasaryan wrote:
> > On Tue, Aug 3, 2021 at 10:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
> [...]
> > > > > +     if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> > > > > +             mm = task->mm;
> > > > > +             mmget(mm);
> > > > > +     }
> > > > > +     task_unlock(task);
> > > > > +     if (!mm) {
> > > >
> > > > Do we want to treat MMF_OOM_SKIP as a failure?
> > >
> > > Yeah, I don't think we want to create additional contention if
> > > oom-killer is already working on this mm. Should we return EBUSY in
> > > this case? Other possible options is ESRCH, indicating that this
> > > process is a goner, so don't bother. WDYT?
> >
> > After considering this some more I think ESRCH would be more
> > appropriate. EBUSY might be understood as "I need to retry at a better
> > time", which is not what we want here.
>
> Why cannot we simply return 0 in that case. The work has been done
> already by the kernel so why should we tell the caller that there was
> something wrong?

Ah, you are right. I was under the impression that MMF_OOM_SKIP means
oom-killer is reaping the mm, but looks like it means that mm was
already reaped. If that's true then I agree, returning 0 is the right
move here. Will fix.

>
> --
> Michal Hocko
> SUSE Labs
