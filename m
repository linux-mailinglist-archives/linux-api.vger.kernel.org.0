Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED449FDF56
	for <lists+linux-api@lfdr.de>; Fri, 15 Nov 2019 14:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKONvC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Nov 2019 08:51:02 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52799 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKONvB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 Nov 2019 08:51:01 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Md6V1-1hw0GW2mzD-00aDvG; Fri, 15 Nov 2019 14:50:59 +0100
Received: by mail-qt1-f179.google.com with SMTP id y10so10883521qto.3;
        Fri, 15 Nov 2019 05:50:59 -0800 (PST)
X-Gm-Message-State: APjAAAVi4jSzAlgflXq28TSpWwZP5YRJTQx97DJw/pD70gYTJ+JrsQvE
        hILrZ4NikA3wHXEXSGiC2LddNcOytyz4kVEs7T0=
X-Google-Smtp-Source: APXvYqySGzOlrZax7Nm6dMlXs7IcHnybF78ToMuOjZ0eVyxnfr5cLMelGHGOLaVZ8RVtRW9i6+ne+ZBli87v0F2PbJg=
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr13719843qtp.7.1573825858520;
 Fri, 15 Nov 2019 05:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-8-arnd@arndb.de>
 <20191114230127.GA3580@ryzen.lan> <CAK8P3a3jn8GcedX=HaTFiPY+fyHPoyVUnpcX19nMZqmuUA1RzA@mail.gmail.com>
 <73a56955-552a-3a95-a410-3064401913f7@rasmusvillemoes.dk>
In-Reply-To: <73a56955-552a-3a95-a410-3064401913f7@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Nov 2019 14:50:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0KOVG7STctuPW9gzhCo_yR6uM82LohoQML8CcwQF68Xw@mail.gmail.com>
Message-ID: <CAK8P3a0KOVG7STctuPW9gzhCo_yR6uM82LohoQML8CcwQF68Xw@mail.gmail.com>
Subject: Re: [PATCH 17/23] y2038: time: avoid timespec usage in settimeofday()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Abel Vesa <abelvesa@linux.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        zhengbin <zhengbin13@huawei.com>,
        Li RongQing <lirongqing@baidu.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jHB0x6fRsPnzpNFyb+1NJrilgD4CNqdaXZmVSaGhkkYSKMgAacB
 V+LdUTBuGQ2GnZHO/m+/jU0kyr7k9XFUwgucqn8XwE9WJ/7JKz8cwV7Ys/P/3em/GFwg5tW
 STwCk/uXxCstdV8eX3yHnSe5/VPoYoArG3NOcaBdMLmgwe+8sBPzLCt8rzhDsGJtcNg3oKu
 a7ZIndIXEvAtiCNUAAYjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A+yImEslHZE=:G2GdYWswIMESMsn7k29FfK
 wGYs5kFwkzYv9ACilyuXwIyC7e1YqsF5ldKqpzW4FDa1DYIUwYCQK4l3EK4KmvJB2mh3+7Ckj
 bByj37HmEzOMNo5pYKM7GfpNZoewB3tgw/YiZvhbJ15vR2eMPdC2uS8E5qos23exLWQT5VNfb
 3jwkKsc20PLWOxpGSp7ewJ0sKKUBR7Reb45YBdpELpQUowr0uZMh6N6DFTxhivchMr7ZmmtWl
 fCroTe/nZNngqhM55yzwYyF9xdJZYhSsbQm7QqJNXvXsqU6WFxJWnB7Ql5RFD+1x/fzHCWluw
 D8JAv6cRcOWpWW26sbr92NhHG4BV6utvnyEs1x3g7E6R2k/Yg7kGbVRVNakla5ZyIuDtQF8C9
 DoQNsoBhFrIesF6U1F02JI3FUScF7EoMBwveG1qlpAmJZl+mgbgHCdQ2zXNLu4P+sSMZe8P6H
 4Gg/hhtdvQfnfYJvAQsUZpUINggwOe4lJokxsbzU8CzU0iSy3BshqbcBWb23M3/NeSCVT3/6t
 XsbFgnWjLouHCGvbgcOp6f15Ls/ztZgbujGXbVE0JcNk1eOhDxDNN4K/x6WS6HEdfMAnSZ+rp
 s6n90hy5xYvi8LbXwMXpFBvpY9FRK0LzJdD6MWpJVoUyNiaBsP76tp18gMg09ioe33Lnkjdrm
 2il9/n2UWrzs96zLu6DmifSZNPeA9Rv7uqgydSWo1lJ0kopK+BBF2ZtQyO/O0b/KKN+QfE5CX
 TagHs+vhe+JotVCcjGAeRC0x/htk+t6PWomxOjT217URXhzrfQvMBUNdkYwxcjEm9lxYQFjwG
 zGPuYCRpGChvt1ReorUB8sWAMIvEvwlm/wHjGrOi4+MtAm6W5tdErgccZU8TvS59/D+JAp++z
 WbfG4sXcc+4CthJl3OhA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 15, 2019 at 11:27 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 15/11/2019 08.58, Arnd Bergmann wrote:
> > On Fri, Nov 15, 2019 at 12:01 AM Abel Vesa <abelvesa@linux.com> wrote:
> >>
> > --- a/kernel/time/time.c
> > +++ b/kernel/time/time.c
> > @@ -207,7 +207,7 @@ SYSCALL_DEFINE2(settimeofday, struct
> > __kernel_old_timeval __user *, tv,
> >                     get_user(new_ts.tv_nsec, &tv->tv_usec))
> >                         return -EFAULT;
> >
> > -               if (tv->tv_usec > USEC_PER_SEC)
> > +               if (new_ts->tv_usec > USEC_PER_SEC)
> >                         return -EINVAL;
>
> Hopefully not :)

No, I misquoted from a fix that I had temporarily applied, not the
version in linux-next.

>
> >                 new_ts.tv_nsec *= NSEC_PER_USEC;
>
> So the actual patch in next-20191115 does
>
> -               if (copy_from_user(&user_tv, tv, sizeof(*tv)))
> +               if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
> +                   get_user(new_ts.tv_nsec, &tv->tv_usec))
>                         return -EFAULT;
>
> -               if (!timeval_valid(&user_tv))
> +               if (new_ts.tv_nsec > USEC_PER_SEC)
>                         return -EINVAL;
>
> -               new_ts.tv_sec = user_tv.tv_sec;
> -               new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
> +               new_ts.tv_nsec *= NSEC_PER_USEC;
>
> But removing the "user value is < 0" check, relying on the timespec
> value being rejected later, is wrong

You are right of course, so many ways to get this one line wrong...
Pushed more more update to the branch now.

Thanks for the careful review!

        Arnd
