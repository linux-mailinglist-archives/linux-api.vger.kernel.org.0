Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720453891A1
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348031AbhESOpR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 10:45:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:41134 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354454AbhESOob (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 19 May 2021 10:44:31 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 14JEceF1026439;
        Wed, 19 May 2021 09:38:40 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 14JEcaGd026433;
        Wed, 19 May 2021 09:38:36 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 19 May 2021 09:38:36 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "libc-dev@lists.llvm.org" <libc-dev@lists.llvm.org>,
        "musl@lists.openwall.com" <musl@lists.openwall.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: Linux powerpc new system call instruction and ABI
Message-ID: <20210519143836.GJ10366@gate.crashing.org>
References: <20200611081203.995112-1-npiggin@gmail.com> <20210518231331.GA8464@altlinux.org> <9b5ea7059c5a5d4e9ccccd7d73ce2c66b2203f52.camel@infinera.com> <1621410291.c7si38sa9q.astroid@bobo.none> <fb9b6a6099855bd00efc6ffe540ccad14dd9a365.camel@infinera.com> <1621413143.oec64jaci5.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621413143.oec64jaci5.astroid@bobo.none>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 19, 2021 at 06:42:40PM +1000, Nicholas Piggin wrote:
> Excerpts from Joakim Tjernlund's message of May 19, 2021 6:08 pm:
> > I always figured the ppc way was superior. It begs the question if not the other archs should
> > change instead?
> 
> It is superior in some ways, not enough to be worth being different.

The PowerPC syscall ABI *requires* using cr0.3 for indicating errors,
you will have to do that whether you conflate the concepts of return
code and error indicator or not!

> Other archs are unlikely to change because it would be painful for
> not much benefit.

Other archs cannot easily change for much the same reason :-)

> New system calls just should be made to not return
> error numbers.

Which sometimes is a difficult / non-natural / clumsy thing to do.


Segher
