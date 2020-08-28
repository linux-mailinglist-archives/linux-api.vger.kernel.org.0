Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4976F2561E1
	for <lists+linux-api@lfdr.de>; Fri, 28 Aug 2020 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgH1UPp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Aug 2020 16:15:45 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48187 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgH1UPn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Aug 2020 16:15:43 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MS43X-1k0w3a1rdj-00TU2H; Fri, 28 Aug 2020 22:15:41 +0200
Received: by mail-qk1-f175.google.com with SMTP id g72so204338qke.8;
        Fri, 28 Aug 2020 13:15:41 -0700 (PDT)
X-Gm-Message-State: AOAM5331iSCAYRtGmzgu+rq3Lq2kDdtGxdGldSh7WOtPnW/VNRPyAgqC
        boaVuzk+1UouW8HWvJ8PblfeaOVw4CCZCClGYEI=
X-Google-Smtp-Source: ABdhPJyFxFIv+GcJZpKlS+lPDRy1qPULULsQ3S/m8TXtBVzsR15m6l0uoJmkbm1MsalFQvPRw8Dsa1/8I63jaxHy9uo=
X-Received: by 2002:a37:a04b:: with SMTP id j72mr892253qke.352.1598645740122;
 Fri, 28 Aug 2020 13:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200622192900.22757-1-minchan@kernel.org> <20200622192900.22757-4-minchan@kernel.org>
 <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
 <9c339413-68c7-344e-dd01-327cb988d385@kernel.dk> <ffe549f6-bed5-07f9-43a7-ec8cc12ab59d@kernel.dk>
In-Reply-To: <ffe549f6-bed5-07f9-43a7-ec8cc12ab59d@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Aug 2020 22:15:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0rWjvSTDO_p7mKDv24OcdnWvMaM+_pHPEDGZGwn5BG=Q@mail.gmail.com>
Message-ID: <CAK8P3a0rWjvSTDO_p7mKDv24OcdnWvMaM+_pHPEDGZGwn5BG=Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nyLHj6ZpuzHpQ/Rd2Zu2ZXBe+DoHH8w3eBCH+32bWGdcQqn303K
 /toMw6tB1D0VEVbfcBpipXwuXza07IgVsiY6a1nX4T/okWht3ONmbaiWoBfg7WkLg2xDUo0
 JnWfRr2eAG31Xl7tZ06m50/3gEY2iGyZoryyr0eupPi1V4KQ2qjC0XW6WpEvtKBsW0susOp
 VqSXHs4R2Ls4zQu7Tx70Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7msRCAyRGig=:DAPNv7qMT9UJ8LGCCJMsYg
 i9VkG4C7kuFe9V9lQ3fFeZnp54+jORtKOSaBCTchQWjnHDeKFkuUYEQ7x5PC2R0dhgmpYTL8T
 EJvbZ27r4EC0qcpRs5T5E0Yi5ZVTXnylbdOiJ4pvNlOE8tmpeNOScD0oGM9wb0Tr1Tl78swol
 vdhL9izIxBzx1ebZ8hPHzR9YLRH6dAMGPiHwH0By7YLILRMJehpec+9PTfk6nNqx3mgQXYrU5
 FkeQqdZBryVgG8qSEDEhKJAkNKuqlfB03zuc/Z/32p5lujRx4TkcBqvMLteb+I/0s8b1S6mXD
 MHY8AnS4yXtZjkB9R8nONJJTxVeqSNIFx/JwfyxQAI03sVpG7/Yne1/XPn81NAPev3PFgbONc
 McLl0MQNN9HpfyJbU1xj25suvPMsJMIMlbpn0EIH2N8cXlmE1eMTPwNiUcmZi11m5stcWqNYK
 aPn6YkJ3dLXgYIBNZ7bFwG2qH9N2uknSXE5i52zH2uZmq17QLVPksdSMWcHRxSNa+u4mkKpjI
 0O8012W/3RBizbqFYxXUw1DcPjcvom2Aqqz4YJhmtFMxaVo9/xda/ofktyLGIJn+pS6jZzHFH
 Uh9q/WEHR8BAVtmsf9yFJzf0fbWQF7bvHLPZ4rG/0tt7jZjC5gZkeDUmFUGikTWRyiAGm9ycS
 nnS66N/IZ2S+rRYLrB30mqpON3X/cEhLNrWiOT/gyxVc/r2dhvpEA6ey5LnoKQiZaif9Pewuq
 2YWb+9HmLgI0O7VWq0pRDui9KQiBwTigdT5wwg16wW7RxCELirjHu3IA+Q06fkVc9s+txrR63
 xUVE7RIQp3aJ/tEZLVkT6+iSgfWn41SayDMenKgLpe+4Vo49iqU6Wsow03ny4rZEl+s5xFn
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 28, 2020 at 9:27 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 8/28/20 12:24 PM, Jens Axboe wrote:

> >> @@ -1683,8 +1683,13 @@ ssize_t import_iovec(int type, const struct
> >> iovec __user * uvector,
> >>  {
> >>         ssize_t n;
> >>         struct iovec *p;
> >> -       n = rw_copy_check_uvector(type, uvector, nr_segs, fast_segs,
> >> -                                 *iov, &p);
> >> +
> >> +       if (in_compat_syscall())
> >> +               n = compat_rw_copy_check_uvector(type, uvector, nr_segs,
> >> +                                                fast_segs, *iov, &p);
> >> +       else
> >> +               n = rw_copy_check_uvector(type, uvector, nr_segs,
> >> +                                         fast_segs, *iov, &p);
> >>         if (n < 0) {
> >>                 if (p != *iov)
> >>                         kfree(p);
> >
> > Doesn't work for the async case, where you want to be holding on to the
> > allocated iovec. But in general I think it's a good helper for the sync
> > case, which is by far the majority.
>
> Nevermind, I'm an idiot for reading this totally wrong.
>

I think you are right about the need to pick the compat vs native
behavior based on req->ctx->compat instead of in_compat_syscall()
inside of io_import_iovec().

That one can probably call a lower-level version and when all other
callers get changed to calling

ssize_t import_iovec(int type, const struct iovec __user * uvector,
                 unsigned nr_segs, unsigned fast_segs,
                 struct iovec **iov, struct iov_iter *i)
{
       return __import_iovec(type, uvector, nr_segs, fast_segs, iov,
i, in_compat_syscall());
}

      Arnd
