Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB092560F7
	for <lists+linux-api@lfdr.de>; Fri, 28 Aug 2020 21:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgH1TEG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Aug 2020 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgH1TEE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Aug 2020 15:04:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E118C061264;
        Fri, 28 Aug 2020 12:04:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so114158plt.3;
        Fri, 28 Aug 2020 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7zI9d08ORhBadgXE5vt8IAQVQsfj3TKH+iNZP3hnVkQ=;
        b=Dun8fQKYFd3taaZ/a/zjL2l/Px3mapiQNOpZEjyjO+UMgPxrCTjcACFgXvy7x86UuS
         3C7grwBMXDxboFLdcyVECpTm7pF0Pj1QvYu+WjReyAKOZt3AY6VTISU+igeCD1S0NBfx
         rMhi36ADHAzYeVxV+slw9v+kTAP//9zflFVw5q4AGkTYic2f3bB69Mjwu7AV2j73VViH
         57/A78zA+imMCi+x2kMqfSx6HL9w2g9fUbS6hSQSU6olxZgV4T+8wv0rq/pC1QonBfj8
         S/oaXxUKSaXhOa3XJ/mZGHt/FRQyHF1Ey5ng1qRV12XTzGimEzuBDRBSvZZNBcxSS7mT
         B4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7zI9d08ORhBadgXE5vt8IAQVQsfj3TKH+iNZP3hnVkQ=;
        b=N0syziJ8bvGFAu6y2TEV4k9bUjHjQfqDvOWNP8GMs2vro4M599/9FdGzXHn5cqGiGm
         FC9YOvS8EKhpm7drGaDkk01Wi/anNbmED+azb0zz2eDOJ/EAhex941GpiWUujplrbTk2
         fnP+bMSQyqQsCDx1PayMrnIqI0mXvUtUUx41SZPI/4hvMpuV2STgVEaYxJ/x9fXf+0uL
         HHFxHoXVUrS/3tli+3AlVrss981wJsSmcolmPAkRlqfvoz3b5uq+WV3ite8p08UbAKCI
         DCBWMqMcmUu9LuBebYsVaOF6bmRy+8vR3jq2uVtkPkGDxP7qHtumMaVX6ooyK8HRZ5BQ
         bRIQ==
X-Gm-Message-State: AOAM531BBxXLOB1AnPJsbPgN3v/Flic0+3dKm0iKpRQ92oZrBzHbsF/N
        1j4TOje8n2OCRMdZ1X8VCu8=
X-Google-Smtp-Source: ABdhPJwOU3PcFhAezEM+UiYUjQDs1bCpJZY01P7AxZiOtPz5miPj2yYXTh0JBTh8+cp47sc1SYppIg==
X-Received: by 2002:a17:902:c24a:: with SMTP id 10mr242159plg.83.1598641443563;
        Fri, 28 Aug 2020 12:04:03 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id mw8sm73857pjb.47.2020.08.28.12.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:04:02 -0700 (PDT)
Date:   Fri, 28 Aug 2020 12:04:00 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
Message-ID: <20200828190400.GA725038@google.com>
References: <20200622192900.22757-1-minchan@kernel.org>
 <20200622192900.22757-4-minchan@kernel.org>
 <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
 <9c339413-68c7-344e-dd01-327cb988d385@kernel.dk>
 <CAHrFyr4-czbzaWg=oC2Gc1ALwLc+r4O+PYnG38STjYbkcfsdRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrFyr4-czbzaWg=oC2Gc1ALwLc+r4O+PYnG38STjYbkcfsdRA@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 28, 2020 at 08:25:34PM +0200, Christian Brauner wrote:
> On Fri, Aug 28, 2020 at 8:24 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 8/28/20 11:40 AM, Arnd Bergmann wrote:
> > > On Mon, Jun 22, 2020 at 9:29 PM Minchan Kim <minchan@kernel.org> wrote:
> > >> So finally, the API is as follows,
> > >>
> > >>      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
> > >>                unsigned long vlen, int advice, unsigned int flags);
> > >
> > > I had not followed the discussion earlier and only now came across
> > > the syscall in linux-next, sorry for stirring things up this late.
> > >
> > >> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > >> index 94bf4958d114..8f959d90338a 100644
> > >> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > >> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > >> @@ -364,6 +364,7 @@
> > >>  440    common  watch_mount             sys_watch_mount
> > >>  441    common  watch_sb                sys_watch_sb
> > >>  442    common  fsinfo                  sys_fsinfo
> > >> +443    64      process_madvise         sys_process_madvise
> > >>
> > >>  #
> > >>  # x32-specific system call numbers start at 512 to avoid cache impact
> > >> @@ -407,3 +408,4 @@
> > >>  545    x32     execveat                compat_sys_execveat
> > >>  546    x32     preadv2                 compat_sys_preadv64v2
> > >>  547    x32     pwritev2                compat_sys_pwritev64v2
> > >> +548    x32     process_madvise         compat_sys_process_madvise
> > >
> > > I think we should not add any new x32-specific syscalls. Instead I think
> > > the compat_sys_process_madvise/sys_process_madvise can be
> > > merged into one.
> > >
> > >> +       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > >> +       if (IS_ERR_OR_NULL(mm)) {
> > >> +               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > >> +               goto release_task;
> > >> +       }
> > >
> > > Minor point: Having to use IS_ERR_OR_NULL() tends to be fragile,
> > > and I would try to avoid that. Can mm_access() be changed to
> > > itself return PTR_ERR(-ESRCH) instead of NULL to improve its
> > > calling conventions? I see there are only three other callers.
> > >
> > >
> > >> +       ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
> > >> +       if (ret >= 0) {
> > >> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
> > >> +               kfree(iov);
> > >> +       }
> > >> +       return ret;
> > >> +}
> > >> +
> > >> +#ifdef CONFIG_COMPAT
> > > ...
> > >> +
> > >> +       ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
> > >> +                               &iov, &iter);
> > >> +       if (ret >= 0) {
> > >> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
> > >> +               kfree(iov);
> > >> +       }
> > >
> > > Every syscall that passes an iovec seems to do this. If we make import_iovec()
> > > handle both cases directly, this syscall and a number of others can
> > > be simplified, and you avoid the x32 entry point I mentioned above
> > >
> > > Something like (untested)
> > >
> > > index dad8d0cfaaf7..0de4ddff24c1 100644
> > > --- a/lib/iov_iter.c
> > > +++ b/lib/iov_iter.c
> > > @@ -1683,8 +1683,13 @@ ssize_t import_iovec(int type, const struct
> > > iovec __user * uvector,
> > >  {
> > >         ssize_t n;
> > >         struct iovec *p;
> > > -       n = rw_copy_check_uvector(type, uvector, nr_segs, fast_segs,
> > > -                                 *iov, &p);
> > > +
> > > +       if (in_compat_syscall())
> 
> I suggested the exact same solutions roughly 1.5 weeks ago. :)
> Fun when I saw you mentioning this in BBB I knew exactly what you were
> referring too. :)
> 

https://lore.kernel.org/linux-man/20200816081227.ngw3l45c5uncesmr@wittgenstein/

Yes, Christian suggested the idea but mostly for only this new syscall.
I don't have the time to revise the patchset yet but may have next week.
I will follow Christian's suggestion.

Thanks.
