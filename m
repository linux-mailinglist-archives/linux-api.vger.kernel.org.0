Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D53FC85D
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2019 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNOFO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 14 Nov 2019 09:05:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40734 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfKNOFO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 14 Nov 2019 09:05:14 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVFjv-0003mN-UV; Thu, 14 Nov 2019 15:04:52 +0100
Date:   Thu, 14 Nov 2019 15:04:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     y2038 Mailman List <y2038@lists.linaro.org>,
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
Subject: Re: [PATCH 17/23] y2038: time: avoid timespec usage in
 settimeofday()
In-Reply-To: <CAK8P3a2bxDZVKgcJoa99wr3tDyYckQAdk2f=RnL4vTFPjm3tXQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911141457120.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-8-arnd@arndb.de> <alpine.DEB.2.21.1911132250010.2507@nanos.tec.linutronix.de> <CAK8P3a2bxDZVKgcJoa99wr3tDyYckQAdk2f=RnL4vTFPjm3tXQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 14 Nov 2019, Arnd Bergmann wrote:
> On Wed, Nov 13, 2019 at 10:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Fri, 8 Nov 2019, Arnd Bergmann wrote:
> > > -SYSCALL_DEFINE2(settimeofday, struct timeval __user *, tv,
> > > +SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
> > >               struct timezone __user *, tz)
> > >  {
> > >       struct timespec64 new_ts;
> > > -     struct timeval user_tv;
> > >       struct timezone new_tz;
> > >
> > >       if (tv) {
> > > -             if (copy_from_user(&user_tv, tv, sizeof(*tv)))
> > > +             if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
> > > +                 get_user(new_ts.tv_nsec, &tv->tv_usec))
> > >                       return -EFAULT;
> >
> > How is that supposed to be correct on a 32bit kernel?
> 
> I don't see the problem you are referring to. This should behave the
> same way on a 32-bit kernel and on a 64-bit kernel, sign-extending
> the tv_sec field, and copying the user tv_usec field into the
> kernel tv_nsec, to be multiplied by 1000 a few lines later.

You're right. Tired brain failed to see the implicit sign extension in
get_user().

> Am I missing something?

No.

> > > -             if (!timeval_valid(&user_tv))
> > > +             if (tv->tv_usec > USEC_PER_SEC)
> > >                       return -EINVAL;
> >
> > That's incomplete:
> >
> > static inline bool timeval_valid(const struct timeval *tv)
> > {
> >         /* Dates before 1970 are bogus */
> >         if (tv->tv_sec < 0)
> >                 return false;
> >
> >         /* Can't have more microseconds then a second */
> >         if (tv->tv_usec < 0 || tv->tv_usec >= USEC_PER_SEC)
> >                 return false;
> >
> >         return true;
> > }
> 
> My idea was to not duplicate the range check that is done
> in do_sys_settimeofday64() and again in do_settimeofday64:
> 
>         if (!timespec64_valid_settod(ts))
>                 return -EINVAL;
> 
> The only check we should need in addition to this is to ensure
> that passing an invalid tv_usec number doesn't become an
> unexpectedly valid tv_nsec after the multiplication.

Right, but please add a proper comment as you/we are going to scratch heads
4 weeks from now when staring at that check and wondering why it is
incomplete.

Thanks,

	tglx
