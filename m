Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC5FC509
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2019 12:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKNLGr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 14 Nov 2019 06:06:47 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNLGr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 14 Nov 2019 06:06:47 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MlbPO-1i5Svn2nj8-00ioCd; Thu, 14 Nov 2019 12:06:45 +0100
Received: by mail-qk1-f176.google.com with SMTP id 15so4582176qkh.6;
        Thu, 14 Nov 2019 03:06:45 -0800 (PST)
X-Gm-Message-State: APjAAAUVDamB+kFhgmXl3RazZSTz/eVHRcVLM8CVzC2pKhyJB7ROhXUc
        iRxmXoI/t1P86WVDIhVLReG/d2qdJYgaCczBi/Y=
X-Google-Smtp-Source: APXvYqzuWjjhFCIcZYtGLnK9DULSkbiErHMxA6APMDCxNqfE+JmCPgKHQpndMIjwNnMuY67LjOBRJOmqKprQGPFQu3M=
X-Received: by 2002:a37:4f13:: with SMTP id d19mr3283562qkb.138.1573729604436;
 Thu, 14 Nov 2019 03:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-8-arnd@arndb.de>
 <alpine.DEB.2.21.1911132250010.2507@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911132250010.2507@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Nov 2019 12:06:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2bxDZVKgcJoa99wr3tDyYckQAdk2f=RnL4vTFPjm3tXQ@mail.gmail.com>
Message-ID: <CAK8P3a2bxDZVKgcJoa99wr3tDyYckQAdk2f=RnL4vTFPjm3tXQ@mail.gmail.com>
Subject: Re: [PATCH 17/23] y2038: time: avoid timespec usage in settimeofday()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
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
X-Provags-ID: V03:K1:XU+O07OEppNgCbV/MswPwPvwuk4SG/gjpyBETZ/Rtoi0ffsCLJv
 bFepRb19fTjs3LSJYop7cAscxCdpbICzPet4phFwy+iDzRvoO8bVzIrxgZ/+CZmi5boA61n
 /h04CadxCvv3D6LL6O9owjHVmKfwyveLhPrwRhDWTVaq6eVjz136bCL0h3SzxE+wr1la9+T
 9zPZZdLmqQ7ZQdwmy/ufg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJWgKZ0krKA=:VeEhRpbH9TLovZYTQW+TaY
 87CLodxBplXGcmU8Odz0PzoGhqvVJCqLa25I2Di5vI+b3R8vLRZ82eQRUqNalOwK+rub4ECQ1
 Cq7VnTuH7eGw5tr0IyA/6+VozxTlhwq4DgU8CJxjOv5kn9JJB+mAqy7LzSdUH3FzBjfaHS8uz
 qFpesnu9MoWyX8aXB9rhru6tOi4Q+c+MHmiyi67z3ZZ9fdnmOJY5w0avQ1H41pwEZgNXNd+wT
 7hApMbhGprQ3V70ZJSrahveXtBY1nISzelLl+Z6ltDQRsBLhs+vWRp+SeCzrkb2egRrHabtGp
 B6DcgLf0QZGEcUcrldActLjtByzgSB5wh3yIoxbeulbQgAWBS7TIilG4/a0SCwW2nw/szOL+q
 jePVpnqq0Bk28csevzxgHjX+0B1w9GiQEehzRD5nhZVx4DRLfeKY2d4QqDi5Ke1du54mylNab
 ibja/h5XWTdimkVuDZRZ6TW9f0gkTsrz010COJ4VW1D5942MsXL5JuxcSv8iQakUSl905Xda8
 8DnguBM73j5oRT25Y571AuBjOW9dOkxiMFKhWSyKRoqm+JYtFgwx7KEtMRxJ7ZyUx4JC1R/7u
 dSaXQ+sJ7zG7bdDY/gMzSMbT3KXZseIUKd1flvvh0dquW+H4DZmMHqcULY80IEntyveWz9hQG
 +CY6211rC8/Li9GLJSnKBufMexrge7CPfYkrcxokFHxSov0BHJNTtYSJCnrH/zWRCp5FKpTDH
 /WTJDMZMi84TbgX5L7RF2Fk4FiRyXOtbIZCN3NMUx5UR9m/xNFbxowtpXKhDZej15nR/1EG/r
 0Mx1A9nJqyDPGewUKQuIlq7danHo/b5omxRJ0pUHjUhFx9mN874MtVy10xiP0zmqa0w/ycj6h
 zCELIyYxT5ebGn7JPVPg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 13, 2019 at 10:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 8 Nov 2019, Arnd Bergmann wrote:
> > -SYSCALL_DEFINE2(settimeofday, struct timeval __user *, tv,
> > +SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
> >               struct timezone __user *, tz)
> >  {
> >       struct timespec64 new_ts;
> > -     struct timeval user_tv;
> >       struct timezone new_tz;
> >
> >       if (tv) {
> > -             if (copy_from_user(&user_tv, tv, sizeof(*tv)))
> > +             if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
> > +                 get_user(new_ts.tv_nsec, &tv->tv_usec))
> >                       return -EFAULT;
>
> How is that supposed to be correct on a 32bit kernel?

I don't see the problem you are referring to. This should behave the
same way on a 32-bit kernel and on a 64-bit kernel, sign-extending
the tv_sec field, and copying the user tv_usec field into the
kernel tv_nsec, to be multiplied by 1000 a few lines later.

Am I missing something?

> > -             if (!timeval_valid(&user_tv))
> > +             if (tv->tv_usec > USEC_PER_SEC)
> >                       return -EINVAL;
>
> That's incomplete:
>
> static inline bool timeval_valid(const struct timeval *tv)
> {
>         /* Dates before 1970 are bogus */
>         if (tv->tv_sec < 0)
>                 return false;
>
>         /* Can't have more microseconds then a second */
>         if (tv->tv_usec < 0 || tv->tv_usec >= USEC_PER_SEC)
>                 return false;
>
>         return true;
> }

My idea was to not duplicate the range check that is done
in do_sys_settimeofday64() and again in do_settimeofday64:

        if (!timespec64_valid_settod(ts))
                return -EINVAL;

The only check we should need in addition to this is to ensure
that passing an invalid tv_usec number doesn't become an
unexpectedly valid tv_nsec after the multiplication.

I agree the patch looks like I'm missing a check here, but
the code after the patch appears clear enough to me.

          Arnd
