Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0B3CFF4A
	for <lists+linux-api@lfdr.de>; Tue, 20 Jul 2021 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhGTPpQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Jul 2021 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbhGTPjp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Jul 2021 11:39:45 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33545C0613DE
        for <linux-api@vger.kernel.org>; Tue, 20 Jul 2021 09:18:51 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r135so33536109ybc.0
        for <linux-api@vger.kernel.org>; Tue, 20 Jul 2021 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BF4wPFMGvJMx+e9zXgrbf4Lj5+O/3oIlVh3I/7nAW28=;
        b=ebloSyKUKkgIs+5bbIXrcys7dZ7H0YEYo0N3DdxsuSL9UXqyZuvkKRH2OU/kRrCCzc
         nrHXcBFtkbYxBzYRNuWL+IQ+SNmmEGc3glpp8pV3QGWQIwWHD1P5RjuFU3lUoNKle/xW
         2pT/H/qKUo3Qg57gz+9bpwPRICh5bZWXv2dZYQMo7iZZh6AJiO3oZE6Tz8A4q2xumRpW
         HvfY0IfHo37kn+xkdC6mbcZBYXo0KQBV/2KsgF6D9gGPLeKp3bb/DeuwLjQYu8j0KI0k
         bnx5lMqWKM09WiuKJPZnqa1CqxIA54VJgk/9w7ICvF8ivLOEgtbXlQZ+k6ffUB4g7pH/
         FrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF4wPFMGvJMx+e9zXgrbf4Lj5+O/3oIlVh3I/7nAW28=;
        b=T89p7cbHhLopROrxTrZrgPlcwfSNmobPVsabAJshb1Ct94ibqzPYKQMYd4sDBbiN57
         Rb+jit/ken8uAzZ+gz9dtK0E8tQtNDN3oYv92QhGYT5Xh/REtGZ8axRNFF6yy0e3y1HB
         i7esIlyLuFhvxcouUVKXKcXF/HYXCskCpBctppDqiD79PK6jfI3Jcv5oz1pmXiK8nmKL
         R+wrbfsgX+f024vJxE/g9A1plAihziDvXtSqxqnLInVueS+t4YbEU22yzjR/IJ4ThP0T
         8kJoItoHUedzRoVO6hAplH6BDfDLMo8heQTfqKosTw5iJniMTXw2Y4ycHVxbP6cQr2WW
         4VdQ==
X-Gm-Message-State: AOAM532NZQ6nLvdKI6jFq3JVlOCPjnZB76bAtWxMoj4at7Yd9oL4hSiI
        L55/kHy5Gc3JW4X+UiREeFwUITt+q71c/KaT4eHdLg==
X-Google-Smtp-Source: ABdhPJzYpjDzF/VTmmB9Zr65reHxTvduNEHmYOd+EstkNRz17MA1cqBnwnCKvsbHziUq9ZfkgYN06+i9RPZ43L1s9Yk=
X-Received: by 2002:a25:2341:: with SMTP id j62mr39877955ybj.190.1626797930203;
 Tue, 20 Jul 2021 09:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210718214134.2619099-1-surenb@google.com> <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
In-Reply-To: <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 20 Jul 2021 09:18:39 -0700
Message-ID: <CAJuCfpHRm8HshtVSgVQAOdttL4=25qC=sEEgKU2mN1FP4dFJKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to
 be used in process_mrelease
To:     David Hildenbrand <david@redhat.com>
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
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
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

On Tue, Jul 20, 2021 at 5:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 18.07.21 23:41, Suren Baghdasaryan wrote:
> > process_mrelease needs to be added in the CONFIG_MMU-dependent block which
> > comes before __task_will_free_mem and task_will_free_mem. Move these
> > functions before this block so that new process_mrelease syscall can use
> > them.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > changes in v2:
> > - Fixed build error when CONFIG_MMU=n, reported by kernel test robot. This
> > required moving task_will_free_mem implemented in the first patch
> > - Renamed process_reap to process_mrelease, per majority of votes
> > - Replaced "dying process" with "process which was sent a SIGKILL signal" in
> > the manual page text, per Florian Weimer
> > - Added ERRORS section in the manual page text
> > - Resolved conflicts in syscall numbers caused by the new memfd_secret syscall
> > - Separated boilerplate code wiring-up the new syscall into a separate patch
> > to facilitate the review process
> >
> >   mm/oom_kill.c | 150 +++++++++++++++++++++++++-------------------------
> >   1 file changed, 75 insertions(+), 75 deletions(-)
>
> TBH, I really dislike this move as it makes git blame a lot harder with
> any real benefit.
>
> Can't you just use prototypes to avoid the move for now in patch #2?
>
> static bool task_will_free_mem(struct task_struct *task);

Sure, I can use a forward-declaration. Just thought this would be
cleaner. Will change in the next rev. Thanks!

>
>
> --
> Thanks,
>
> David / dhildenb
>
