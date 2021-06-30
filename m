Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3D53B88FD
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhF3TJU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhF3TJU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 15:09:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEACC061756
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 12:06:51 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s129so6758533ybf.3
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBXYzxuYbrUfubIQ6UvGkUSdg+WS39I5c22pRkza8yU=;
        b=T2Nrl9yc5bjJCN2r4qbI6DLyowI5EaeRUrMata/pmX303u6wAyJIcw4NJy6H2IG0jx
         ayfcoRDTEG8x5PfQm04GcJhdXQHmohsFJTcUv1ye1wBNsknk8ank0NgypWy1vnbB7ZHZ
         FDgGaFmvQFbTPZCQ36V/HyXzi9EGwi5c4D+LJ9C93+bnZZB31GaQj8jG/y1f6Ku/P/by
         ZPO0N8K1ZMHgRzaMHFE13qhg6v2Ia+Bf28IlNYSvUVczDNqNHecB2AEpG3CUcdV4slwt
         AsYWsHTL4OLFBRXMIyUcizgchgRt9zZykuOmi6il6g+O5PKN49ikvHvYHbBiMQqETs/z
         nyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBXYzxuYbrUfubIQ6UvGkUSdg+WS39I5c22pRkza8yU=;
        b=r3CcXm2rYOQq+j5Nf/K0emhpWEO6uIP5G+UayHffkQldjKTPIdL6Cx4iuM9Aa9sLhz
         +cAsK1Z5NDG8mxCo1BjHomB+ijfGLyYeuBuxNHYn/kaMxqoJgppnJkoW2nvuJh30A5zU
         r4pyKIXmojJS8JYOUsaEGBtQav0wKYKwDHJuhVaZgorZL7TQeTpzccXm46IRYbbKGaLy
         6Qt+dankwWmokmGMW43vU8MFU9PSAjQ3r+qYCxpJmJNKFnWjdHjvpv3gxN8/SSUgzwvs
         4DfHMOfH6ZQMW4jqjuB10UPd9NM03XRN2mIZBmjyLfRdA8pYpsh66VoMJKp4EhAsEkDM
         B8IA==
X-Gm-Message-State: AOAM533Yd6f2jUBya1bNxph+lI2p0svwusLC/hTVwNog0VZROtHSsuon
        dq2FIewQ0cGPZ7ON5ZXogRndjE2tq/zDejjzhZ138A==
X-Google-Smtp-Source: ABdhPJw7XehJAJ/lTBUWul5miVd/lSGPIC8Gj7POEguNh9f02XyBFfJ2p2aSbCed9UbXE8en6B/RWG9jpWX4AJT5NwQ=
X-Received: by 2002:a25:9945:: with SMTP id n5mr39428387ybo.294.1625080010148;
 Wed, 30 Jun 2021 12:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALvZod7GPeB6ArrU8oBPx-1NT-ZDBQzTiJHJDojjO2kAgALkHw@mail.gmail.com>
 <CAJuCfpG4M=ZnqR9D9MPNB88nwWgQ9qA9Z9a6dymZ5abOxNucGg@mail.gmail.com> <CALvZod6deRap_tE_dSPhQnpe7XNgQ6w9hZAEirRRB-bWBK+zBA@mail.gmail.com>
In-Reply-To: <CALvZod6deRap_tE_dSPhQnpe7XNgQ6w9hZAEirRRB-bWBK+zBA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 30 Jun 2021 12:06:39 -0700
Message-ID: <CAJuCfpE_d9w9vSbcvfDLTeVpEmTFWN65gSSyLntZYF51Bov+hg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Shakeel Butt <shakeelb@google.com>
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

On Wed, Jun 30, 2021 at 12:00 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Jun 30, 2021 at 11:44 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> [...]
> > > > +       /*
> > > > +        * If the task is dying and in the process of releasing its memory
> > > > +        * then get its mm.
> > > > +        */
> > > > +       task_lock(task);
> > > > +       if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> > >
> > > task_will_free_mem() is fine here but I think in parallel we should
> > > optimize this function. At the moment it is traversing all the
> > > processes on the machine. It is very normal to have tens of thousands
> > > of processes on big machines, so it would be really costly when
> > > reaping a bunch of processes.
> >
> > Hmm. But I think we still need to make sure that the mm is not shared
> > with another non-dying process. IIUC that's the point of that
> > traversal. Am I mistaken?
>
> You are right. I am talking about efficiently finding all processes
> which are sharing mm (maybe linked into another list) instead of
> traversing all the processes on the system.

Oh, I see. I think that's a good idea but belongs to a separate patch
as an optimization for task_will_free_mem().
Thanks for reviewing and for good suggestions!
