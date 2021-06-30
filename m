Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3353B88E3
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhF3TDX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 15:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhF3TDW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 15:03:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9B6C0617A8
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 12:00:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h15so6972848lfv.12
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEgh9Jy+v2hf9QQxXrhqFRUWrnkAgTuVo3us79cOIOw=;
        b=ZKBY6VftutgEegz48judWjWXy81U7xX6OZgRzr3GXzWpadR6jP1iqlLNU7Y0d91WTG
         Beq8K5ZKgeKbUwLlCcz/aYP37Gj8UvZH42R94ZAq7P0Rc43sFsmak+4n6NY8UGlVWZBt
         DDCSUjd/HrmFRtzM5nWojlT5UF+iBDUCSRMJq5cbRi+d4m93TcHPHdB6yHVlIV8p8Ko6
         Qj0HTt7jrncgZ4ntXM0Xazu8x5iwm77s+HJe7YvmCAJFyZcNXez8Oez4IdvPIMf/M9tw
         bLbErz1qi1vxtLpvIBXoPpc5K9bdOU+yS/Ifv/UG3pA9BpwzpqV+e1vd5kSLvUmOWBe5
         AnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEgh9Jy+v2hf9QQxXrhqFRUWrnkAgTuVo3us79cOIOw=;
        b=CLX9+jPbN1Rghs4H6J+A3JgEnXmi7O9RNAi4E57h4ahYg81wNXCTE8PXQioxkd0GHI
         6sidGIDksSK5TWN+m/tJU8Ak/Xn6fcDIdt6JI7/hPLAdc58LIvrxjbQKCWQMSsmMXa14
         Bd21km6/37piTXaXOosmS+qz9DEh8sLqEPrqCcDbblyh6iYCzfF1eXuwG/cNS5NgMyxM
         LFkMjf+PbDQ+m1o+vUt8r2I+QOiuYkF7HOrbHu617776+PGuaf97Ly3svPVK0jSVpzTw
         YpRkIkxI7PFsq9mCCTpTNSygTZ961PIGukYkvINBeGPPiw7rx2zT5oriXRegP+Bm+y7C
         O5Ig==
X-Gm-Message-State: AOAM531GEQD7RNn97JceE4fJMX+mVd2Y6tW8WhrYVpfVX2y/ymZk2Ty/
        UDInk7n5+c3C/7gNbkmFiSa0jl+aKDM/hMGaUtLvdw==
X-Google-Smtp-Source: ABdhPJzDjoniOT1Bd7VA+hYgwG7DePFjKijlt9GhP+NN1iQALNtamNNzBBHpZmLXaQL0UebX9WZd5/yC9rRoLL/gt2g=
X-Received: by 2002:a05:6512:442:: with SMTP id y2mr27208904lfk.117.1625079650220;
 Wed, 30 Jun 2021 12:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALvZod7GPeB6ArrU8oBPx-1NT-ZDBQzTiJHJDojjO2kAgALkHw@mail.gmail.com>
 <CAJuCfpG4M=ZnqR9D9MPNB88nwWgQ9qA9Z9a6dymZ5abOxNucGg@mail.gmail.com>
In-Reply-To: <CAJuCfpG4M=ZnqR9D9MPNB88nwWgQ9qA9Z9a6dymZ5abOxNucGg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Jun 2021 12:00:38 -0700
Message-ID: <CALvZod6deRap_tE_dSPhQnpe7XNgQ6w9hZAEirRRB-bWBK+zBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
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
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 30, 2021 at 11:44 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
[...]
> > > +       /*
> > > +        * If the task is dying and in the process of releasing its memory
> > > +        * then get its mm.
> > > +        */
> > > +       task_lock(task);
> > > +       if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> >
> > task_will_free_mem() is fine here but I think in parallel we should
> > optimize this function. At the moment it is traversing all the
> > processes on the machine. It is very normal to have tens of thousands
> > of processes on big machines, so it would be really costly when
> > reaping a bunch of processes.
>
> Hmm. But I think we still need to make sure that the mm is not shared
> with another non-dying process. IIUC that's the point of that
> traversal. Am I mistaken?

You are right. I am talking about efficiently finding all processes
which are sharing mm (maybe linked into another list) instead of
traversing all the processes on the system.
