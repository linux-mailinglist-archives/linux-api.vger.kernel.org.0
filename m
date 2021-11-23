Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D9459BE4
	for <lists+linux-api@lfdr.de>; Tue, 23 Nov 2021 06:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhKWFsI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Nov 2021 00:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhKWFsH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Nov 2021 00:48:07 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57889C061574;
        Mon, 22 Nov 2021 21:45:00 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id j7so13210444ilk.13;
        Mon, 22 Nov 2021 21:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5hsIcQcnvyDWXD3QyyHaUUo4fAVQ+szFlIF7sIqfyyM=;
        b=Id0y4YXJOOoknFyUbQsif0apMa5fgtmG8XmCEXOHrXS6DKuschmyk1vPx/oZorbVpx
         h56YqinmeHWYA/7Xu5ofwpDdYQ+rn8ypf/KzEAz30OeR2SFdtbNfIi+jFAwHM/iLEMe6
         anbjmcPBWLqMd+wFn3D1vA4Mlo1o+fqb6DLOwbBpwrCHPf7LIOZ+KtFZd6TaQYb/hPOB
         k9RuCHOhDcFaYJhmL6J/M+hqgA5OnNafBLT6lfPXJ90BX6aJ4qPvohaa0TgIwyfJzlJq
         HM/f+rdgxnhad6XWa6Z5lIOzW5683lgEA8zIfr/KKPd1rl3htrhP7LKEGBPg14eR5R/E
         IesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5hsIcQcnvyDWXD3QyyHaUUo4fAVQ+szFlIF7sIqfyyM=;
        b=MDtk3bt4xGa51eF0jkrr3bfUn9Zrof4XQd5NY8cbiIduPm+NZzhqayO9LjRUSBFoQy
         42cg0+XvisyRSm899Q4wOSTAD2U5ey9NTNATjG85nWIBy2jfacJ0kGigjKMWVeSLOhqB
         15aoHs96a4MhXhlq5tu3C8m9eK50aodcBNjAdtlFNhlCj6+a0S/zpXFc3epCxu3niQGi
         GzthBy2n5gkxN7GUEAGYICxxF/XKesd8u3dPJfDbkkkYSzQXLZUtZ6icsRFGeFbFF3F5
         Ja9DPKOknBv8uUsNCCZjBoM0MyhVtDKJqm2b6poWvxYI/TfSweeU02PBPGaC5UUBDSPf
         V9bg==
X-Gm-Message-State: AOAM5304N5yJSh0o0JzlA/VfCWMMiiEPD5dvQut+jj8bVspA44LQnFtN
        dP9KTTn4SY7lXMj/ESz1BRlC2yd1LGX/Qnhb0R0=
X-Google-Smtp-Source: ABdhPJxVTJkrfk3BaKxB4NLltIBR9EgWGZQqg6GxOmdcQwWkXkketZe9gkMv35HKjOgZxNFdp3nL+E5uoiN6WD9ko2M=
X-Received: by 2002:a92:cda2:: with SMTP id g2mr3404478ild.46.1637646299779;
 Mon, 22 Nov 2021 21:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20211021055408.4006408-1-alistair.francis@opensource.wdc.com>
 <1e24268a-fd6a-10cd-cb1d-c479bb2f930f@collabora.com> <CAK8P3a2R=e7we11Gi2zTVwFYrEt9Di6Bgzi9xtjMAX9BZex7Cw@mail.gmail.com>
In-Reply-To: <CAK8P3a2R=e7we11Gi2zTVwFYrEt9Di6Bgzi9xtjMAX9BZex7Cw@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 23 Nov 2021 15:44:33 +1000
Message-ID: <CAKmqyKNKmJrNf-enEFSnNEy6tPvawrjptF9SuhX=L-14ba2etw@mail.gmail.com>
Subject: Re: [PATCH v2] uapi: futex: Add a futex syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Alistair Francis <alistair.francis@opensource.wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 26, 2021 at 3:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 25, 2021 at 6:33 PM Andr=C3=A9 Almeida <andrealmeid@collabora=
.com> wrote:
> > =C3=80s 02:54 de 21/10/21, Alistair Francis escreveu:
> > > From: Alistair Francis <alistair.francis@wdc.com>
>
> > > +#if defined(__NR_futex)
> > > +     if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec=
))
> > > +             return syscall(__NR_futex, uaddr, op, val, timeout, uad=
dr2, val3);
> > > +
> > > +     if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
> > > +             struct __kernel_old_timespec ts32;
> > > +
> > > +             ts32.tv_sec =3D (__kernel_long_t) timeout->tv_sec;> +  =
           ts32.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
> > > +
> > > +             return syscall(__NR_futex, uaddr, op, val, &ts32, uaddr=
2, val3);
> > > +     } else if (!timeout) {
> > > +             return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2=
, val3);
> > > +     }
> > > +#endif
> >
> > If I read this part right, you will always use ts32 for __NR_futex. I
> > know that it can be misleading, but __NR_futex uses ts64 in 64-bit
> > archs, so they shouldn't be converted to ts32 in those cases.
>
> __kernel_old_timespec is the correct type for sys_futex() on all
> architectures.
>
> Maybe name the local variable 'ts' or 'ts_old' instead of 'ts32' then?
>
> > > +{
> > > +#if defined(__NR_futex_time64)
> > > +     int ret =3D  syscall(__NR_futex_time64, uaddr, op, val, nr_requ=
eue, uaddr2, val3);
> > > +
> > > +     if (ret =3D=3D 0 || errno !=3D ENOSYS)
> > > +             return ret;
> > > +#endif
> > > +
> > > +#if defined(__NR_futex)
> > > +     return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, =
val3);
> > > +#endif
> > > +
> > > +     errno =3D ENOSYS;
> > > +     return -1;
> > > +}
> > > +
> > > +#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
> > >
> >
> > Sorry if this question was already asked but I didn't find it in the
> > thread: Should we go with wrappers for the most common op? Like:
> >
> > __kernel_futex_wait(volatile uint32_t *uaddr, uint32_t val, struct
> > timespec *timeout)
> >
> > __kernel_futex_wake(volatile uint32_t *uaddr, uint32_t nr_wake)
>
> I had suggested having just a single function definition here, but having=
 one
> per argument type seems reasonable as well. Having one definition
> per futex_op value would also be possible, but in that case I suppose
> we need all 13 of them, not just two.

Sorry I have taken so long to look at this again. I have addressed
your other comments.

I don't have a strong preference here. I do like that by having a
generic __kernel_futex_syscall_timeout() it should be easier to
convert existing uses of SYSCALL() to the new function (the requeue is
it's own thing anyway).

Alistair

>
>         Arnd
