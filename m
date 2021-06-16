Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F153A9D94
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhFPOac (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Jun 2021 10:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhFPOac (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Jun 2021 10:30:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74C2C61027;
        Wed, 16 Jun 2021 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623853705;
        bh=PpE29HBG23hfdZ+IhfbsTOKrT5VPQmXuD8x8wowETew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzSdMddRlEjZCbBFal3RbcR3zsy41U5JBRpkDDZ2gm1loZ8qCt+J5bAkOX3Txu5En
         T8rI2BmaflLtcE3IHH8s2+ZAtqplOrvcdc66thF3bsowqfPL/NfRdR6P813sR/iUo2
         z9lXZ97MuSKHaBj5mG6Vf/8ESSqa8hi5kcSAaOsE=
Date:   Wed, 16 Jun 2021 16:28:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org
Subject: Re: Discussion of a possible modern alternate of the removed Sysctl
 syscall
Message-ID: <YMoKh90UsYkLV7Fh@kroah.com>
References: <CAEzXK1q7SR-CpMyP0jpdHx4GSCr5qkO_-+Dnn5xjmtVLSkDH0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1q7SR-CpMyP0jpdHx4GSCr5qkO_-+Dnn5xjmtVLSkDH0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 16, 2021 at 02:40:13PM +0100, Luís Mendes wrote:
> Dear Linux kernel maintainers/developers,
> 
> 
> I would like to discuss a modern alternate to Sysctl syscall and its
> feasibility for armhf and aarch64 for supporting ioperm, iopl, inb,
> outb and their siblings APIs emulation in Glibc, or even on an
> external library to provide such sys/io.h API compatibility with
> x86_64.
> 
> The advantage of having ioperm, iopl, inb and outb emulation for armhf

What is "armhf"?

> and aarch64 is that they can provide cross-compilation ability of
> x86_64 applications and constitutes an easy and practical API for
> simple I/O. This was not only useful for old ISA cards as it is today
> for PCIe cards with I/O space, like I/O cards, LPT Parallel interface
> cards, as well as many other cards that may have PCIe I/O space
> (network cards, etc). PCIe LPT interface cards as well as
> multi-function cards are still widely available, just search ebay or
> amazon, and many suggestions will pop up.
> 
> I know for instance that LPT interface cards have their ppdev driver
> which already provides an ioctl interface to access the card I/O
> lines, but it is not performant for applications like bit-banging an
> LPT card to load firmware into a micro-controller, for instance,
> Microchip/ATMEL 8-bit micro-controllers. Plus the ioperm, iopl, inb,
> outb has a simpler API for doing simple interactions with the I/O
> space, like is the case with the IO lines of the LPT parallel
> interface card.

You should never use iopl, inb, and outb on modern systems, sorry.
Please use the bus-specific ways to access the devices needed, or mmap
the needed memory ranges into your program and directly access them that
way if you know what you are doing for your specific hardware type (the
UIO api provides this for you.)

> There are many complaints in the web, like bug reports and
> cross-compilation issues/reports regarding sys/io.h removal on armhf.
> There are also people wishing for such functionality on aarch64.
> 
> 
> I had an application working up to two years ago on two armhf systems
> (armv7) on imx6q and mvebu architectures, to be concrete. The
> application did and does just that, currently only for x84_64, but it
> is able to bit-bang the ports to load the firmware into the chips. I
> just didn't got to up-stream these quite small changes, like selecting
> (in the kernel configuration):
> General setup->Configure standard Kernel features (expert
> users)->Sysctl syscall support->Enable
> and do:
> arch/arm/mach-imx/mach-imx6q.c, function __init imx6q_init_late(void)
> and appended:
> 
>    register_isa_ports(0xfee0000, 0x1f80000, 0);
> 
> Which is the PCIe IO memory region in the imx6q memory map. It was
> just a matter of up-streaming the change. It maybe also useful to
> rename register_isa_ports to register_pci_ports, or so in the kernel,
> to avoid this confusion regarding to ISA bus only applicability.

As I stated above, you can access PCI IO memory regious through the UIO
api and mmap them and talk directly to them if you want to.  There is no
need to do old-style inb commands anymore for stuff like this, and
hasn't been for decades now.

> So I would like to have some opinions regarding the introduction of a
> modern alternate for the sysctl syscall update in order to achieve
> Glibc cross-compatibility for armhf and possibly aarch64 of what
> already exists in Glibc for x86_64. What do you say?

sysctl should not have anything to do with i/o accesses.  I don't know
how that got somehow tied together in glibc, but that seems like a glibc
issue, not a kernel one :)

thanks,

greg k-h
