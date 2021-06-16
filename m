Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454583AA08B
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhFPP7a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Jun 2021 11:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234576AbhFPP7L (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Jun 2021 11:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E29D61159;
        Wed, 16 Jun 2021 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623859024;
        bh=A9uRrgtYuXjZBvKG1G1ksde7QEiWz1DMn0BPMHSsLac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VS393SWeovakbaPYHVZLoxEK45UztnMkIHcqUgYdyxuvfq8piF4r0HsYjgU0lhg/p
         ayb6mC3K+i2FY9nV6U3axe/D6iVcUL3nX4Gqy7INqqdbD6zNRaefiXLnZkBUJFPam5
         fcvR9tPrAHksD/VV/3jwPaeRRbwxk9HGRFOXq8lA=
Date:   Wed, 16 Jun 2021 17:57:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org
Subject: Re: Discussion of a possible modern alternate of the removed Sysctl
 syscall
Message-ID: <YMofTuYpeKUY5qcc@kroah.com>
References: <CAEzXK1q7SR-CpMyP0jpdHx4GSCr5qkO_-+Dnn5xjmtVLSkDH0g@mail.gmail.com>
 <YMoKh90UsYkLV7Fh@kroah.com>
 <CAEzXK1rxj4WsQbF=enUvbkum3abeq8dooDfE=LuMYnWaFOBgnw@mail.gmail.com>
 <CAEzXK1rWFjeWBdxm74zuuyH2AzT2bVsmmeo0NuDPuEfRXhr-yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1rWFjeWBdxm74zuuyH2AzT2bVsmmeo0NuDPuEfRXhr-yA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 16, 2021 at 04:35:32PM +0100, Luís Mendes wrote:
> Hi Greg,
> 
> Replies follow below.
> 
> Thanks,
> Luis
> 
> On Wed, Jun 16, 2021 at 3:28 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 16, 2021 at 02:40:13PM +0100, Luís Mendes wrote:
> > > Dear Linux kernel maintainers/developers,
> > >
> > >
> > > I would like to discuss a modern alternate to Sysctl syscall and its
> > > feasibility for armhf and aarch64 for supporting ioperm, iopl, inb,
> > > outb and their siblings APIs emulation in Glibc, or even on an
> > > external library to provide such sys/io.h API compatibility with
> > > x86_64.
> > >
> > > The advantage of having ioperm, iopl, inb and outb emulation for armhf
> >
> > What is "armhf"?
> 
> armhf is a common acronym for arm 32-bits with an hardware floating point unit.
> 
> >
> > > and aarch64 is that they can provide cross-compilation ability of
> > > x86_64 applications and constitutes an easy and practical API for
> > > simple I/O. This was not only useful for old ISA cards as it is today
> > > for PCIe cards with I/O space, like I/O cards, LPT Parallel interface
> > > cards, as well as many other cards that may have PCIe I/O space
> > > (network cards, etc). PCIe LPT interface cards as well as
> > > multi-function cards are still widely available, just search ebay or
> > > amazon, and many suggestions will pop up.
> > >
> > > I know for instance that LPT interface cards have their ppdev driver
> > > which already provides an ioctl interface to access the card I/O
> > > lines, but it is not performant for applications like bit-banging an
> > > LPT card to load firmware into a micro-controller, for instance,
> > > Microchip/ATMEL 8-bit micro-controllers. Plus the ioperm, iopl, inb,
> > > outb has a simpler API for doing simple interactions with the I/O
> > > space, like is the case with the IO lines of the LPT parallel
> > > interface card.
> >
> > You should never use iopl, inb, and outb on modern systems, sorry.
> > Please use the bus-specific ways to access the devices needed, or mmap
> > the needed memory ranges into your program and directly access them that
> > way if you know what you are doing for your specific hardware type (the
> > UIO api provides this for you.)
> 
> I understand that. It is just that since it is allowed and has been
> allowed on x86_64 for a long time, and is in use by many
> applications...

Was it really in use by any arm systems in a way that worked?  IO ports
were semi-standardized in some places on x86, but NEVER on arm, so what
programs used them that need to do so in a cross-platform way?

> so that for simplicity and cross-compatibility that it
> could be made available once again for armhf as it was up until kernel
> 5.5 and the glibc version available at that time.

But the backing hardware is so different, why does it need to be
"compatible"?  What programs are using this on arm that expect to do so
in a way that would also work on x86?  What hardware accesses are they
wanting to do?

> If the roadmap for user applications is towards UIO api, while
> deprecating the inb, outb, I will have a look at that API for armhf. I
> do know that mmap will not work for accessing PCIe IO spaces for
> armhf, or at least not consistently across kernel versions, from my
> experience. It only worked for PCIe memory regions. I will re-check
> all that.

mmap works with the UIO api, please look into that, it's what it is
there for when you know _EXACTLY_ what hardware you have and want to
access it directly from userspace.

thanks,

greg k-h
