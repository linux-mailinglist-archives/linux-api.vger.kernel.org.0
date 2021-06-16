Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC43A9F98
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 17:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhFPPjO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Jun 2021 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbhFPPiK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Jun 2021 11:38:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E84BC0611BC
        for <linux-api@vger.kernel.org>; Wed, 16 Jun 2021 08:35:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dj8so3285227edb.6
        for <linux-api@vger.kernel.org>; Wed, 16 Jun 2021 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wLrPMUM00qJKeolATrIaefvsy45vs32Q6LM0sVxGSA=;
        b=tZ+lEWoh0lSRX6l8XC3EqLdmCZFy+m++3eUWGT6gjrieh/0vHlQ8Tv5ZzgPb4QPpCN
         cYEUPImM0rjR5HUtaY0HY5HKh5K6GgzMAjIur0f1xqF5oTU6zHwibUotsSaFkl5z+DmY
         7432n59C1SbiYzujuUFi0DQYZqNkT3k5IBOrIb0F4G/k+YEVCkUN4EST9d3/5wfXHgDo
         LAP0LBQXl2J0OFjM3ah1HtjEx9I7V14LEslorGE6kH+bnG5x6AzSiVBjjtjoMK0VXAnT
         DZEdxWILjmx1vpNM7xudZDiIb0zLt2+8DXklPJvfF1/rYPzB9dGaeursuCwXMj9Gj8JW
         lwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wLrPMUM00qJKeolATrIaefvsy45vs32Q6LM0sVxGSA=;
        b=m8x7/8K/0kCprvS6+4dZbxMlks4U90xECRPBNECbZjGldnMYcsSxqlgbIBFiacL64V
         Xy/g+zCm3ZheoNPqVI69xAmwVUJgI0wqEDsH4f6HkHL0OoKFi9wkz/DlgDhjFJasqCu7
         AR1F1P4P/TGuPbqvpo/RH5Piquyxjnat66sUy1aSBvP0kY0niWr1ecS4BQImuqfFf86h
         ZToUN826ilxuVQTAj9L0DugnFlfXxd8PMANZKf4WSeGpBGD2YoAHohgpurTWjzT37rec
         KQC7YecEWFJOvMsGu8V/vOYA2DyLpDWdcJinwpUcuahxd8Q7UHflVgEQUBjL/uad2W0a
         M30g==
X-Gm-Message-State: AOAM532hDSaxmwhhVn/XmwutVDRY5xVoCaS43uY9N6UwsjwKlOSXlMTt
        mOx8Wc7sDMvY5i13v5GGUeYI/9CJOfx1UsPHWpg=
X-Google-Smtp-Source: ABdhPJybB8Ojq3oeOcaYECrCey/uW6UYHLtFz/+WwJXEmHfFNO8nyIyvXwA7dYQ+0L5+t7el1RZVpY9mIdVJ1/jIVHQ=
X-Received: by 2002:aa7:db49:: with SMTP id n9mr201989edt.361.1623857743840;
 Wed, 16 Jun 2021 08:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1q7SR-CpMyP0jpdHx4GSCr5qkO_-+Dnn5xjmtVLSkDH0g@mail.gmail.com>
 <YMoKh90UsYkLV7Fh@kroah.com> <CAEzXK1rxj4WsQbF=enUvbkum3abeq8dooDfE=LuMYnWaFOBgnw@mail.gmail.com>
In-Reply-To: <CAEzXK1rxj4WsQbF=enUvbkum3abeq8dooDfE=LuMYnWaFOBgnw@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 16 Jun 2021 16:35:32 +0100
Message-ID: <CAEzXK1rWFjeWBdxm74zuuyH2AzT2bVsmmeo0NuDPuEfRXhr-yA@mail.gmail.com>
Subject: Re: Discussion of a possible modern alternate of the removed Sysctl syscall
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Greg,

Replies follow below.

Thanks,
Luis

On Wed, Jun 16, 2021 at 3:28 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 16, 2021 at 02:40:13PM +0100, Lu=C3=ADs Mendes wrote:
> > Dear Linux kernel maintainers/developers,
> >
> >
> > I would like to discuss a modern alternate to Sysctl syscall and its
> > feasibility for armhf and aarch64 for supporting ioperm, iopl, inb,
> > outb and their siblings APIs emulation in Glibc, or even on an
> > external library to provide such sys/io.h API compatibility with
> > x86_64.
> >
> > The advantage of having ioperm, iopl, inb and outb emulation for armhf
>
> What is "armhf"?

armhf is a common acronym for arm 32-bits with an hardware floating point u=
nit.

>
> > and aarch64 is that they can provide cross-compilation ability of
> > x86_64 applications and constitutes an easy and practical API for
> > simple I/O. This was not only useful for old ISA cards as it is today
> > for PCIe cards with I/O space, like I/O cards, LPT Parallel interface
> > cards, as well as many other cards that may have PCIe I/O space
> > (network cards, etc). PCIe LPT interface cards as well as
> > multi-function cards are still widely available, just search ebay or
> > amazon, and many suggestions will pop up.
> >
> > I know for instance that LPT interface cards have their ppdev driver
> > which already provides an ioctl interface to access the card I/O
> > lines, but it is not performant for applications like bit-banging an
> > LPT card to load firmware into a micro-controller, for instance,
> > Microchip/ATMEL 8-bit micro-controllers. Plus the ioperm, iopl, inb,
> > outb has a simpler API for doing simple interactions with the I/O
> > space, like is the case with the IO lines of the LPT parallel
> > interface card.
>
> You should never use iopl, inb, and outb on modern systems, sorry.
> Please use the bus-specific ways to access the devices needed, or mmap
> the needed memory ranges into your program and directly access them that
> way if you know what you are doing for your specific hardware type (the
> UIO api provides this for you.)

I understand that. It is just that since it is allowed and has been
allowed on x86_64 for a long time, and is in use by many
applications... so that for simplicity and cross-compatibility that it
could be made available once again for armhf as it was up until kernel
5.5 and the glibc version available at that time.
If the roadmap for user applications is towards UIO api, while
deprecating the inb, outb, I will have a look at that API for armhf. I
do know that mmap will not work for accessing PCIe IO spaces for
armhf, or at least not consistently across kernel versions, from my
experience. It only worked for PCIe memory regions. I will re-check
all that.

>
> > There are many complaints in the web, like bug reports and
> > cross-compilation issues/reports regarding sys/io.h removal on armhf.
> > There are also people wishing for such functionality on aarch64.
> >
> >
> > I had an application working up to two years ago on two armhf systems
> > (armv7) on imx6q and mvebu architectures, to be concrete. The
> > application did and does just that, currently only for x84_64, but it
> > is able to bit-bang the ports to load the firmware into the chips. I
> > just didn't got to up-stream these quite small changes, like selecting
> > (in the kernel configuration):
> > General setup->Configure standard Kernel features (expert
> > users)->Sysctl syscall support->Enable
> > and do:
> > arch/arm/mach-imx/mach-imx6q.c, function __init imx6q_init_late(void)
> > and appended:
> >
> >    register_isa_ports(0xfee0000, 0x1f80000, 0);
> >
> > Which is the PCIe IO memory region in the imx6q memory map. It was
> > just a matter of up-streaming the change. It maybe also useful to
> > rename register_isa_ports to register_pci_ports, or so in the kernel,
> > to avoid this confusion regarding to ISA bus only applicability.
>
> As I stated above, you can access PCI IO memory regious through the UIO
> api and mmap them and talk directly to them if you want to.  There is no
> need to do old-style inb commands anymore for stuff like this, and
> hasn't been for decades now.
>
I have tried mmap for PCIe I/O spaces but it didn't work on arhmf. It
only works for memory regions, or at least it was like that, last time
I tried. Regarding UIO I confess I have not tried UIO yet.

> > So I would like to have some opinions regarding the introduction of a
> > modern alternate for the sysctl syscall update in order to achieve
> > Glibc cross-compatibility for armhf and possibly aarch64 of what
> > already exists in Glibc for x86_64. What do you say?
>
> sysctl should not have anything to do with i/o accesses.  I don't know
> how that got somehow tied together in glibc, but that seems like a glibc
> issue, not a kernel one :)

I believe it had to do with user permissions management for accessing
I/O regions. Anyway all that code has been stripped off glibc once the
sysfs syscall was removed.

>
> thanks,
>
> greg k-h
