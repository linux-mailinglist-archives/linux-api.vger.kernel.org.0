Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE7352F55
	for <lists+linux-api@lfdr.de>; Fri,  2 Apr 2021 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhDBSde (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Apr 2021 14:33:34 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38310 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBSdd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Apr 2021 14:33:33 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0BDAE92009C; Fri,  2 Apr 2021 20:33:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 05AAC92009B;
        Fri,  2 Apr 2021 20:33:30 +0200 (CEST)
Date:   Fri, 2 Apr 2021 20:33:30 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
cc:     Dmitry Vyukov <dvyukov@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
In-Reply-To: <CAEn-LTqTXCEC=bXTvGyo8SNL0JMWRKtiSwQB7R=Pc4uhxZUruA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2104022022300.18977@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2103302221590.18977@angie.orcam.me.uk> <mhng-08e5e4fb-8a42-4f7b-8ceb-ff549784100e@palmerdabbelt-glaptop> <CACT4Y+Z0PaAuUFrOBenztWkw8OV=J-qaeD1FASPM4ufcLg5a5A@mail.gmail.com>
 <CAEn-LTqTXCEC=bXTvGyo8SNL0JMWRKtiSwQB7R=Pc4uhxZUruA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 2 Apr 2021, David Abdurachmanov wrote:

> > > >  This macro is exported as a part of the user API so it must not depend on
> > > > Kconfig.  Also changing it (rather than say adding COMMAND_LINE_SIZE_V2 or
> > > > switching to an entirely new data object that has its dimension set in a
> > > > different way) requires careful evaluation as external binaries have and
> > > > will have the value it expands to compiled in, so it's a part of the ABI
> > > > too.
> > >
> > > Thanks, I didn't realize this was part of the user BI.  In that case we
> > > really can't chage it, so we'll have to sort out some other way do fix
> > > whatever is going on.
> > >
> > > I've dropped this from fixes.
> >
> > Does increasing COMMAND_LINE_SIZE break user-space binaries? I would
> > expect it to work the same way as adding new enum values, or adding
> > fields at the end of versioned structs, etc.
> > I would assume the old bootloaders/etc will only support up to the
> > old, smaller max command line size, while the kernel will support
> > larger command line size, which is fine.
> > However, if something copies /proc/cmdline into a fixed-size buffer
> > and expects that to work, that will break... that's quite unfortunate
> > user-space code... is it what we afraid of?
> >
> > Alternatively, could expose the same COMMAND_LINE_SIZE, but internally
> > support a larger command line?
> 
> Looking at kernel commit history I see PowerPC switched from 512 to
> 2048, and I don't see complaints about the ABI on the mailing list.
> 
> If COMMAND_LINE_SIZE is used by user space applications and we
> increase it there shouldn't be problems. I would expect things to
> work, but just get truncated boot args? That is the application will
> continue only to look at the initial 512 chars.

 The macro is in an include/uapi header, so it's exported to the userland 
and a part of the user API.  I don't know what the consequences are for 
the RISC-V port specifically, but it has raised my attention, and I think 
it has to be investigated.

 Perhaps it's OK to change it after all, but you'd have to go through 
known/potential users of this macro.  I guess there shouldn't be that many 
of them.

 In any case it cannot depend on Kconfig, because the userland won't have 
access to the configuration, and then presumably wants to handle any and 
all.

  Maciej
