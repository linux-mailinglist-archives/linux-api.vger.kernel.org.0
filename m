Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8D389303
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbhESPx3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 11:53:29 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:41394 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbhESPx3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 11:53:29 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 11:53:28 EDT
Date:   Wed, 19 May 2021 11:36:55 -0400
From:   Rich Felker <dalias@libc.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "musl@lists.openwall.com" <musl@lists.openwall.com>,
        "libc-dev@lists.llvm.org" <libc-dev@lists.llvm.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [musl] Re: Linux powerpc new system call instruction and ABI
Message-ID: <20210519153652.GQ2546@brightrain.aerifal.cx>
References: <20200611081203.995112-1-npiggin@gmail.com>
 <20210518231331.GA8464@altlinux.org>
 <9b5ea7059c5a5d4e9ccccd7d73ce2c66b2203f52.camel@infinera.com>
 <1621410291.c7si38sa9q.astroid@bobo.none>
 <fb9b6a6099855bd00efc6ffe540ccad14dd9a365.camel@infinera.com>
 <1621413143.oec64jaci5.astroid@bobo.none>
 <20210519143836.GJ10366@gate.crashing.org>
 <11d62aa2488e51ec00fe77f24a1d7cdcc21af0b8.camel@infinera.com>
 <20210519152205.GL10366@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519152205.GL10366@gate.crashing.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 19, 2021 at 10:22:05AM -0500, Segher Boessenkool wrote:
> On Wed, May 19, 2021 at 03:06:49PM +0000, Joakim Tjernlund wrote:
> > On Wed, 2021-05-19 at 09:38 -0500, Segher Boessenkool wrote:
> > > On Wed, May 19, 2021 at 06:42:40PM +1000, Nicholas Piggin wrote:
> > > > Excerpts from Joakim Tjernlund's message of May 19, 2021 6:08 pm:
> > > > > I always figured the ppc way was superior. It begs the question if not the other archs should
> > > > > change instead?
> > > > 
> > > > It is superior in some ways, not enough to be worth being different.
> > > 
> > > The PowerPC syscall ABI *requires* using cr0.3 for indicating errors,
> > > you will have to do that whether you conflate the concepts of return
> > > code and error indicator or not!
> > > 
> > > > Other archs are unlikely to change because it would be painful for
> > > > not much benefit.
> > > 
> > > Other archs cannot easily change for much the same reason :-)
> > 
> > Really? I figured you could just add extra error indication in kernel syscall I/F.
> > Eventually user space could migrate to the new indication.
> 
> You seem to assume all user space uses glibc, or *any* libc even?  This
> is false.  Some programs do system calls directly.  Do not break the
> kernel ABI :-)

Even if it were easy to change, the old ppc ABI with a separate error
indicator is much worse to use. In musl we paper over archs that do
this silliness by converting to a normal negated errno code. There are
literally no syscalls that need the ability to return negative values
in addition to error codes; historically there were one or two (I only
recall one fcntl command) but there were ways to disambiguate and
they're only fallbacks for ancient kernels nowadays, if used at all.

Rich
