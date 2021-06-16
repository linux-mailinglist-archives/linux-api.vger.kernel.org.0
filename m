Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71B63AA25D
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFPR0A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Jun 2021 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPRZ7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Jun 2021 13:25:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4B8C061574
        for <linux-api@vger.kernel.org>; Wed, 16 Jun 2021 10:23:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z12so205551edc.1
        for <linux-api@vger.kernel.org>; Wed, 16 Jun 2021 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TXSm43d5hW5fktldnsR2Dq6JdK7cuhwAgUhQHhcaqWw=;
        b=YH6ybSyxnVL/NFGD3s0m2fPL5y3gLYMEAjwB/czefI8Z6P5zcGNoktT40xE+/lg+uM
         G3FoeW46z+MkJDFChf7JyljBCwlRgXLVo7Pm63FFj/dTkm7L65RzXwYEbdpoQki/A0CY
         /R+WFzlBIFS1/hz6E0JQUFMg3zm5abscKS/PkDRnrWgjT/NFm8cmWn+V4Mt856PtN+dK
         6uf4mwslmSGpV/4wDR4M7ouynCGebYADXZp8F9vpCHrLB/MbJPWfkc09vrgDnU2X33C9
         ml7Sq23hbWMwY530V+ZzVtBzNnZPlY704XxYEt2J043h8QXCzK+f1xEdlUn7PQI/JVwv
         baPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TXSm43d5hW5fktldnsR2Dq6JdK7cuhwAgUhQHhcaqWw=;
        b=C5My+USj05x+NmYB0mG2zpZwRa9FGm8BQMfdKo82mZ8ea3mVMs21HFdljzC/81A5wq
         n15e5YtLhAksl1wbDUSeIwxmswxYb0yG1ERiu/K6ZUYom6aqHl3L9kxpDJdWWyvED1yG
         OWFZGXAUPvTNDiM9axin8290shCMaV2fcz9K8oeF4KussJwH3riwud0cUQC2M4/TRDUg
         Ree5sQ2tJ2SGuqAcFkYYBZtymB8biNd5HpCWO9ycyRu/i0tHBu80ff3R/jdcDpdl9bVP
         vGe0WzeIwYrLRmyCxVI2qsV6zKMnUjMO6stDfcDGTqZJFtvZJ7uwKsSV9+3+tH9HjJHw
         wXNw==
X-Gm-Message-State: AOAM531dxv6YMratTfrqPCwX269ZHvgnIhho/+9LZ3aoZmNlmAgNRiKg
        c8iuOpiDvPUOUqtoQ6BLU9ZmH1XRPVJxrOOOBEk=
X-Google-Smtp-Source: ABdhPJyjAIp6aNaYrmVlu8GxmROZwemA1hOSJr1PVeDznm5pmtjp9XfY4VkD4EVMuDbGf1nlUEfm5mgH1hHMdJvfO50=
X-Received: by 2002:a50:99d5:: with SMTP id n21mr937970edb.223.1623864230839;
 Wed, 16 Jun 2021 10:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1q7SR-CpMyP0jpdHx4GSCr5qkO_-+Dnn5xjmtVLSkDH0g@mail.gmail.com>
 <YMoKh90UsYkLV7Fh@kroah.com> <CAEzXK1rxj4WsQbF=enUvbkum3abeq8dooDfE=LuMYnWaFOBgnw@mail.gmail.com>
 <CAEzXK1rWFjeWBdxm74zuuyH2AzT2bVsmmeo0NuDPuEfRXhr-yA@mail.gmail.com> <YMofTuYpeKUY5qcc@kroah.com>
In-Reply-To: <YMofTuYpeKUY5qcc@kroah.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 16 Jun 2021 18:23:39 +0100
Message-ID: <CAEzXK1rekCXBk-1RzJpL=_XGQxKhyEwS71yH-RRx3TWHf241Rg@mail.gmail.com>
Subject: Re: Discussion of a possible modern alternate of the removed Sysctl syscall
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Replies follow below.

Thanks,
Lu=C3=ADs
On Wed, Jun 16, 2021 at 4:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 16, 2021 at 04:35:32PM +0100, Lu=C3=ADs Mendes wrote:
> > Hi Greg,
> >
> > Replies follow below.
> >
> > Thanks,
> > Luis
> >
> > On Wed, Jun 16, 2021 at 3:28 PM Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > > On Wed, Jun 16, 2021 at 02:40:13PM +0100, Lu=C3=ADs Mendes wrote:
> > > > Dear Linux kernel maintainers/developers,
> > > >
> > > >
> > > > I would like to discuss a modern alternate to Sysctl syscall and it=
s
> > > > feasibility for armhf and aarch64 for supporting ioperm, iopl, inb,
> > > > outb and their siblings APIs emulation in Glibc, or even on an
> > > > external library to provide such sys/io.h API compatibility with
> > > > x86_64.
> > > >
> > > > The advantage of having ioperm, iopl, inb and outb emulation for ar=
mhf
> > >
> > > What is "armhf"?
> >
> > armhf is a common acronym for arm 32-bits with an hardware floating poi=
nt unit.
> >
> > >
> > > > and aarch64 is that they can provide cross-compilation ability of
> > > > x86_64 applications and constitutes an easy and practical API for
> > > > simple I/O. This was not only useful for old ISA cards as it is tod=
ay
> > > > for PCIe cards with I/O space, like I/O cards, LPT Parallel interfa=
ce
> > > > cards, as well as many other cards that may have PCIe I/O space
> > > > (network cards, etc). PCIe LPT interface cards as well as
> > > > multi-function cards are still widely available, just search ebay o=
r
> > > > amazon, and many suggestions will pop up.
> > > >
> > > > I know for instance that LPT interface cards have their ppdev drive=
r
> > > > which already provides an ioctl interface to access the card I/O
> > > > lines, but it is not performant for applications like bit-banging a=
n
> > > > LPT card to load firmware into a micro-controller, for instance,
> > > > Microchip/ATMEL 8-bit micro-controllers. Plus the ioperm, iopl, inb=
,
> > > > outb has a simpler API for doing simple interactions with the I/O
> > > > space, like is the case with the IO lines of the LPT parallel
> > > > interface card.
> > >
> > > You should never use iopl, inb, and outb on modern systems, sorry.
> > > Please use the bus-specific ways to access the devices needed, or mma=
p
> > > the needed memory ranges into your program and directly access them t=
hat
> > > way if you know what you are doing for your specific hardware type (t=
he
> > > UIO api provides this for you.)
> >
> > I understand that. It is just that since it is allowed and has been
> > allowed on x86_64 for a long time, and is in use by many
> > applications...
>
> Was it really in use by any arm systems in a way that worked?  IO ports
> were semi-standardized in some places on x86, but NEVER on arm, so what
> programs used them that need to do so in a cross-platform way?

I had it working on two systems of mine, one with imx6q and another
with mvebu (Armada 388), besides the x86_64.
All it was needed was to make the address ranges available for the
inb/outb emulations. For imx6q all it was needed was:
Edit arch/arm/mach-imx/mach-imx6q.c, function __init
imx6q_init_late(void) and append:
   register_isa_ports(0xfee0000, 0x1f80000, 0);
This would make the PCIe IO memory region available for the inb/outb
emulations through glibc and the same code would run on armhf and
x86_64.
It is possible that some arm chips may have a non-fixed memory map,
and as such, that each consumer appliance ends up with different
memory maps, but that could be handled by the device tree if needed.
So surely it is possible to have it working in a cross-platform way.
That is somehow the OS job, to hide hardware differences between
devices, and if it is possible to do so between architectures I argue
that is even better for the user code.
I do understand that this may be a deprecated API, but if that is the
case, then why isn't it deprecated for all systems?

Existing applications that make use of this are diverse, I am not
aware of all of them, but for instance there is this one:
https://www.nongnu.org/avrdude/
another example, could be this one:
http://www.embeddedlinux.org.cn/EmbLinux/ch07.htm

There are diverse reports of compilation failures on the Internet for
armhf and aarch64 that are related to sys/io.h and inb/outb and
friends. Some relevant examples follow below, where I list four web
links for such issues. The first one even provides an alternate
implementation for aarch64
(https://github.com/machinekit/machinekit/issues/1269).

>
> > so that for simplicity and cross-compatibility that it
> > could be made available once again for armhf as it was up until kernel
> > 5.5 and the glibc version available at that time.
>
> But the backing hardware is so different, why does it need to be
> "compatible"?  What programs are using this on arm that expect to do so
> in a way that would also work on x86?  What hardware accesses are they
> wanting to do?
It is not an absolute requirement for sure, since applications can
also adapt to other APIs, but let me grab some cases reported that are
found on the internet:
https://github.com/machinekit/machinekit/issues/1269
https://bugzilla.redhat.com/show_bug.cgi?id=3D1116162
https://archlinuxarm.org/forum/viewtopic.php?f=3D9&t=3D14462
https://community.nxp.com/t5/i-MX-Processors/fatal-error-sys-io-h-file-not-=
found/td-p/1087388

For my particular case, the application is cross-platform, it supports
x86_64 (Windows/Linux) and armhf (Linux) it was tested and working on
those platforms since 2015, although it has no user base besides me at
the moment, I would like to make it available once I get the code
cleaned-up. By making use of code portability through glibc it was the
case that x86_64 and armhf implementations shared the same code for
Linux, and differed very little for Windows support through MingW. The
application makes use of a PCIe Multi-function IO card with serial and
parallel interfaces that is accessed through the corresponding
Parallel SPP/ECP registers (LPT). By accessing the SPP/ECP registers
directly it is possible to achieve higher throughput when generating
different serial protocols by bit-banging the LPT IO lines directly.
There is always the ppdev driver which also gives access to the
hardware IO lines from user-space, except that it is slow, requiring
multiple ioctl calls.
Examples: http://www.embeddedlinux.org.cn/EmbLinux/ch07lev1sec3.htm vs
http://www.embeddedlinux.org.cn/EmbLinux/ch07.htm

"
>
> > If the roadmap for user applications is towards UIO api, while
> > deprecating the inb, outb, I will have a look at that API for armhf. I
> > do know that mmap will not work for accessing PCIe IO spaces for
> > armhf, or at least not consistently across kernel versions, from my
> > experience. It only worked for PCIe memory regions. I will re-check
> > all that.
>
> mmap works with the UIO api, please look into that, it's what it is
> there for when you know _EXACTLY_ what hardware you have and want to
> access it directly from userspace.

I have to have a look at that, for sure.

>
> thanks,
>
> greg k-h
