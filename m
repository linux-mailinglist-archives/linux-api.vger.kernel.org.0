Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DD3899D1
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 01:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhESX2u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 19:28:50 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53624 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhESX2s (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 19:28:48 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 615D172C8BA;
        Thu, 20 May 2021 02:27:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 53BB17CC8A6; Thu, 20 May 2021 02:27:26 +0300 (MSK)
Date:   Thu, 20 May 2021 02:27:26 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        libc-alpha@sourceware.org, libc-dev@lists.llvm.org,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Matheus Castanho <msc@linux.ibm.com>, musl@lists.openwall.com
Subject: Re: Linux powerpc new system call instruction and ABI
Message-ID: <20210519232726.GA24134@altlinux.org>
References: <20210519132656.GA17204@altlinux.org>
 <1621464056.o9t21cquw8.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621464056.o9t21cquw8.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 08:51:53AM +1000, Nicholas Piggin wrote:
> Excerpts from Dmitry V. Levin's message of May 19, 2021 11:26 pm:
> > On Wed, May 19, 2021 at 08:59:05PM +1000, Nicholas Piggin wrote:
> >> Excerpts from Dmitry V. Levin's message of May 19, 2021 8:24 pm:
> >> > On Wed, May 19, 2021 at 12:50:24PM +1000, Nicholas Piggin wrote:
> >> > [...]
> >> >> With this patch, I think the ptrace ABI should mostly be fixed. I think 
> >> >> a problem remains with applications that look at system call return 
> >> >> registers directly and have powerpc specific error cases. Those probably
> >> >> will just need to be updated unfortunately. Michael thought it might be
> >> >> possible to return an indication via ptrace somehow that the syscall is
> >> >> using a new ABI, so such apps can be updated to test for it. I don't 
> >> >> know how that would be done.
> >> > 
> >> > Is there any sane way for these applications to handle the scv case?
> >> > How can they tell that the scv semantics is being used for the given
> >> > syscall invocation?  Can this information be obtained e.g. from struct
> >> > pt_regs?
> >> 
> >> Not that I know of. Michael suggested there might be a way to add 
> >> something. ptrace_syscall_info has some pad bytes, could
> >> we use one for flags bits and set a bit for "new system call ABI"?
> > 
> > PTRACE_GET_SYSCALL_INFO is an architecture-agnostic API, it hides all
> > architecture-specific details behind struct ptrace_syscall_info which has
> > the same meaning on all architectures.  ptrace_syscall_info.exit contains
> > both rval and is_error fields to support every architecture regardless of
> > its syscall ABI.
> > 
> > ptrace_syscall_info.exit is extensible, but every architecture would have
> > to define a method of telling whether the system call follows the "new
> > system call ABI" conventions to export this bit of information.
> 
> It's already architecture speicfic if you look at registers of syscall 
> exit state so I don't see a problem with a flag that ppc can use for
> ABI.

To be honest, I don't see anything architecture-specific in
PTRACE_GET_SYSCALL_INFO API.  Yes, it's implementation uses various
functions defined in asm/syscall.h, but this doesn't make the interface
architecture-specific.

PTRACE_GET_SYSCALL_INFO saves its users from necessity to be aware of
tracee registers.  That's why the only place where strace has to deal
with tracee registers nowadays is syscall tampering.  The most reliable
solution is to introduce PTRACE_SET_SYSCALL_INFO, this would make the
whole syscall abi issue irrelevant for ptracers, maybe the time has come
to implement it.

Unfortunately, extending ptrace API takes time, and it's not going to be
backported to older kernels anyway, but scv-enabled kernels are already
in the wild, so we need a quick powerpc-specific fix that would be
backported to all maintained scv-enabled kernels.

[...]
> > I wonder why can't this information be just exported to the tracer via
> > struct pt_regs?
> 
> It might be able to, I don't see why that would be superior though.
> 
> Where could you put it... I guess it could go in the trap field in a 
> high bit. But could that break things that just test for syscall 
> trap number (and don't care about register ABI)? I'm not sure.

Looks like struct pt_regs.trap already contains the information that could
be used to tell 'sc' from 'scv': if (pt_regs.trap & ~0xf) == 0x3000, then
it's scv.  Is my reading of arch/powerpc/include/asm/ptrace.h correct?


-- 
ldv
