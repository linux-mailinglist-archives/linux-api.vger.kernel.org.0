Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6008A256069
	for <lists+linux-api@lfdr.de>; Fri, 28 Aug 2020 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgH1SZt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Aug 2020 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgH1SZr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Aug 2020 14:25:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA40C061232
        for <linux-api@vger.kernel.org>; Fri, 28 Aug 2020 11:25:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so413092ejc.2
        for <linux-api@vger.kernel.org>; Fri, 28 Aug 2020 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNcRyj9RyFCqhML1vaB3/0lTIN4FgUKY5VeSnjUCZmc=;
        b=fko4qsnU8XsIG5wTzcpyBnhk2ZNW7LMMDcERg5LQjJnk/nhoReV6uTCwCciCdnm9XQ
         td3jm8s3IxQzbIWItUTVIyQw2DIhHO70YwD88A3kwPuTc/XP41FHOFg1Mj4qIEk+GJE3
         lm12IAf3+JJzxbSyHX0MWuIwn/UsBFpZ5OZyCKjWx2inRtZv8dNaGYwhRZuvkPS7ojIs
         SVhPktB5+5MeeN94MPT5Xik4kyzOzDx+bmzMMtXd2VhwoeexqHsLj8I/lFCNu1rZsWl+
         0G0FoHC1mk8ny8gadNdX1AU5d2L3B4r9kSmr+1ZuFYSJ6wPbxkQcfyr3xxn7zPnQNEa9
         Rxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNcRyj9RyFCqhML1vaB3/0lTIN4FgUKY5VeSnjUCZmc=;
        b=dIAulOqQKxPFMovzQ6PTxfwDC6XZTZC1WC3lQoIbRv49tA2gOsJ/U0L6NO2rzzRsnk
         43QBPfHOUKwWfuljCZVY5KahBrzz2I1npnojK3z8G3dIoqz6pd8kGXOlYCCxoldpeAdu
         eOyt/OvWZVQ6EPuWpTRhDVahqLkIW0aMziizU8eViBIZmQEiWoC3E7WGQFdtHqEFcTym
         2uBXdCzF0EDcf2tofz8WYj5uzXelkFdIJCikVG+nk22hHyPXX5Kls5L3/OEzcddnL/3s
         SBWDbcXhFtRyStQ9uiadVwBRy21wJuenIPd4wDeUPa75JufBwIQfvcZEA9hGQnZrYHY0
         VIMw==
X-Gm-Message-State: AOAM532STZ6NhTDJZ/JeOw9rSq00/4laMqfG4k836ekigZML+YkEpImr
        mbAsvxqzA+sCw6cERI0FaUNt+JEzFtKcCmHuu8hMGQ==
X-Google-Smtp-Source: ABdhPJyTcpVzOcX+7dT85XsoWiLFbMeySiOrlyhBqqk1vP4uvGZ86jHVGBRMHXDc7GokaYdxJetDs3WNzeU8cdEwgNM=
X-Received: by 2002:a17:906:178d:: with SMTP id t13mr3428857eje.410.1598639145504;
 Fri, 28 Aug 2020 11:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200622192900.22757-1-minchan@kernel.org> <20200622192900.22757-4-minchan@kernel.org>
 <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com> <9c339413-68c7-344e-dd01-327cb988d385@kernel.dk>
In-Reply-To: <9c339413-68c7-344e-dd01-327cb988d385@kernel.dk>
From:   Christian Brauner <christian@brauner.io>
Date:   Fri, 28 Aug 2020 20:25:34 +0200
Message-ID: <CAHrFyr4-czbzaWg=oC2Gc1ALwLc+r4O+PYnG38STjYbkcfsdRA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sj38.park@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Colascione <dancol@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 28, 2020 at 8:24 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/28/20 11:40 AM, Arnd Bergmann wrote:
> > On Mon, Jun 22, 2020 at 9:29 PM Minchan Kim <minchan@kernel.org> wrote:
> >> So finally, the API is as follows,
> >>
> >>      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
> >>                unsigned long vlen, int advice, unsigned int flags);
> >
> > I had not followed the discussion earlier and only now came across
> > the syscall in linux-next, sorry for stirring things up this late.
> >
> >> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> >> index 94bf4958d114..8f959d90338a 100644
> >> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> >> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> >> @@ -364,6 +364,7 @@
> >>  440    common  watch_mount             sys_watch_mount
> >>  441    common  watch_sb                sys_watch_sb
> >>  442    common  fsinfo                  sys_fsinfo
> >> +443    64      process_madvise         sys_process_madvise
> >>
> >>  #
> >>  # x32-specific system call numbers start at 512 to avoid cache impact
> >> @@ -407,3 +408,4 @@
> >>  545    x32     execveat                compat_sys_execveat
> >>  546    x32     preadv2                 compat_sys_preadv64v2
> >>  547    x32     pwritev2                compat_sys_pwritev64v2
> >> +548    x32     process_madvise         compat_sys_process_madvise
> >
> > I think we should not add any new x32-specific syscalls. Instead I think
> > the compat_sys_process_madvise/sys_process_madvise can be
> > merged into one.
> >
> >> +       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> >> +       if (IS_ERR_OR_NULL(mm)) {
> >> +               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> >> +               goto release_task;
> >> +       }
> >
> > Minor point: Having to use IS_ERR_OR_NULL() tends to be fragile,
> > and I would try to avoid that. Can mm_access() be changed to
> > itself return PTR_ERR(-ESRCH) instead of NULL to improve its
> > calling conventions? I see there are only three other callers.
> >
> >
> >> +       ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
> >> +       if (ret >= 0) {
> >> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
> >> +               kfree(iov);
> >> +       }
> >> +       return ret;
> >> +}
> >> +
> >> +#ifdef CONFIG_COMPAT
> > ...
> >> +
> >> +       ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
> >> +                               &iov, &iter);
> >> +       if (ret >= 0) {
> >> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
> >> +               kfree(iov);
> >> +       }
> >
> > Every syscall that passes an iovec seems to do this. If we make import_iovec()
> > handle both cases directly, this syscall and a number of others can
> > be simplified, and you avoid the x32 entry point I mentioned above
> >
> > Something like (untested)
> >
> > index dad8d0cfaaf7..0de4ddff24c1 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -1683,8 +1683,13 @@ ssize_t import_iovec(int type, const struct
> > iovec __user * uvector,
> >  {
> >         ssize_t n;
> >         struct iovec *p;
> > -       n = rw_copy_check_uvector(type, uvector, nr_segs, fast_segs,
> > -                                 *iov, &p);
> > +
> > +       if (in_compat_syscall())

I suggested the exact same solutions roughly 1.5 weeks ago. :)
Fun when I saw you mentioning this in BBB I knew exactly what you were
referring too. :)

Christian
