Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7483C2A10
	for <lists+linux-api@lfdr.de>; Fri,  9 Jul 2021 22:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGIUIg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Jul 2021 16:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhGIUIf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Jul 2021 16:08:35 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC28FC0613DD
        for <linux-api@vger.kernel.org>; Fri,  9 Jul 2021 13:05:50 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e14so10702699qkl.9
        for <linux-api@vger.kernel.org>; Fri, 09 Jul 2021 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5+WmqauNzbChUW8XqTixtKA8dFJS+e/U7EkZz1A0EE=;
        b=iSgKXodyEj1EqcLcoxTixy6u1pO5YCAun7vY+u/KhEWcHHJgwfXA6g3XNiut6VaTVB
         lgk+FXZsyJ9zTHKFiIHltQuKku5R2gYNv70uOM1vvxxytHaNQaJ43aGv4c6rVPeuFTuq
         NB0nQVZHvAkhAIGIYcSzaJBiZ8Pxy6LflyAFo9QZ0p8gbmXj7K1j217OQMYCB6c2Xrn6
         NcJyt5Cu6Qd0BQijqleEB9j9Aju1BmPZ8yykdkvnoZmFThvncDOR5oPj2Oj92PScho6a
         C27ghu6HIsDBdBLIu33ce3uc+pr/SEDPZaZe9yzDFyNGQ3z9mZ47Yzu/qpVQLRdOWeEC
         Yq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5+WmqauNzbChUW8XqTixtKA8dFJS+e/U7EkZz1A0EE=;
        b=MAqXNUyOQK3JI1BZfjknpRm55hYTRvEI0Kjh0nRyZxHnd4OqSEvD/Q+HSaUbddW2aP
         ASvi287wp11MkNEH4yYj6/7IqLL+q8E2M+oqcNju31FfHYp9RLen/Jm7F73Iel8BB37e
         8FmkiZW/oNRDZk4UEPVx6H+wfmlldDnF6AmZ58T3Uc5AtbuSmQqTAl3uHi0UOtzFTmiu
         Eskt48CS6WTZNNR4ZzZEiCPfhWxwl3PNmTRBxD4JNke24gtYJDj7GLcT16J9bgmUaE/7
         M7DYLEkE/oqRhV36ym07epJK81tgVFZvw8gz9kP67dzhQ+bEQC6ieD8lOLqbVsajZDov
         AxTw==
X-Gm-Message-State: AOAM53005yytuj1mp1M0oBUFx0WhW5e8lcx+Df52e/KWhfVmSkvsa7/g
        i1/BIH6X/xgT1uDBYSomlf7zum2ZzC0ZjyBzHvnCgA==
X-Google-Smtp-Source: ABdhPJzJvR1wZq9AfX5vthaOvHt9sFNe4kSP3CmRNZ1+aIxNbfPPVIY8wNmMWEtvUzL4LbsqaBnidsC5UYvDm6CiFQU=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr48449448ybc.136.1625861149937;
 Fri, 09 Jul 2021 13:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
 <YNzl6XNu2vxyCJu8@cmpxchg.org> <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
 <CAJuCfpG5Ua7C4usJGEqTm6_UUd6VyRd0BsPgT97LWOzjb4Ry+g@mail.gmail.com>
 <20210702152724.7fv5tnik4qlap6do@wittgenstein> <af8e76f1-6625-25d1-98d2-a3c8a9bf2fd6@redhat.com>
 <YOWcj0+P238W1y+t@dhcp22.suse.cz> <CAJuCfpH8QQyxivztkC2-_Kk1MqA0mJVs91XXpvVsL=NzNebshw@mail.gmail.com>
 <20210709085857.zf5ik3btet3yw4ab@wittgenstein>
In-Reply-To: <20210709085857.zf5ik3btet3yw4ab@wittgenstein>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jul 2021 13:05:38 -0700
Message-ID: <CAJuCfpGgZQLso6VKm5QXMJok1iuioWiLGF0b2W+VbQOzqaKYww@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 9, 2021 at 1:59 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Jul 07, 2021 at 02:14:23PM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jul 7, 2021 at 5:38 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 05-07-21 09:41:54, David Hildenbrand wrote:
> > > > On 02.07.21 17:27, Christian Brauner wrote:
> > > [...]
> > > > > That one was my favorite from the list I gave too but maybe we can
> > > > > satisfy Andy too if we use one of:
> > > > > - process_mfree()
> > > > > - process_mrelease()
> > > > >
> > > >
> > > > FWIW, I tend to like process_mrelease(), due to the implied "release" ("free
> > > > the memory if there are no other references") semantics.
> > >
> > > Agreed.
> >
> > Ok, sounds like process_mrelease() would be an acceptable compromise.
> >
> > >
> > > > Further, a new
> > > > syscall feels cleaner than some magic sysfs/procfs toggle. Just my 2 cents.
> > >
> > > Yeah, proc based interface is both tricky to use and kinda ugly now that
> > > pidfd can solve all at in once.
> >
> > Sounds good. Will keep it as is then.
> >
> > > My original preference was a more generic kill syscall to allow flags
> > > but a dedicated syscall doesn't look really bad either.
> >
> > Yeah, I have tried that direction unsuccessfully before arriving at
> > this one. Hopefully it represents the right compromise which can
> > satisfy everyone's usecase.
>
> I think a syscall is fine and it's not we're running out of numbers
> (anymore). :)

Thanks everyone for the input!
So far I collected:
1. rename the syscall to process_mrelease()
2. replace "dying process" with "process which was sent a SIGKILL
signal" in the manual page text

I'll respin a v2 with these changes next week.
Have a great weekend!
Suren.

>
> Christian
