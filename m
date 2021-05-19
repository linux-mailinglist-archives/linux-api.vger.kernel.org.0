Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2413D388B9C
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347947AbhESKZZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 06:25:25 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34514 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbhESKZY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 06:25:24 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EC84772C8BA;
        Wed, 19 May 2021 13:24:03 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E2BF47CC8A6; Wed, 19 May 2021 13:24:03 +0300 (MSK)
Date:   Wed, 19 May 2021 13:24:03 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, libc-dev@lists.llvm.org,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        musl@lists.openwall.com, Matheus Castanho <msc@linux.ibm.com>,
        libc-alpha@sourceware.org
Subject: Re: Linux powerpc new system call instruction and ABI
Message-ID: <20210519102403.GA15207@altlinux.org>
References: <20200611081203.995112-1-npiggin@gmail.com>
 <20210518231331.GA8464@altlinux.org>
 <1621385544.nttlk5qugb.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621385544.nttlk5qugb.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 19, 2021 at 12:50:24PM +1000, Nicholas Piggin wrote:
[...]
> With this patch, I think the ptrace ABI should mostly be fixed. I think 
> a problem remains with applications that look at system call return 
> registers directly and have powerpc specific error cases. Those probably
> will just need to be updated unfortunately. Michael thought it might be
> possible to return an indication via ptrace somehow that the syscall is
> using a new ABI, so such apps can be updated to test for it. I don't 
> know how that would be done.

Is there any sane way for these applications to handle the scv case?
How can they tell that the scv semantics is being used for the given
syscall invocation?  Can this information be obtained e.g. from struct
pt_regs?

For example, in strace we have the following powerpc-specific code used
for syscall tampering:

$ cat src/linux/powerpc/set_error.c
/*
 * Copyright (c) 2016-2021 The strace developers.
 * All rights reserved.
 *
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

static int
arch_set_r3_ccr(struct tcb *tcp, const unsigned long r3,
		const unsigned long ccr_set, const unsigned long ccr_clear)
{
	if (ptrace_syscall_info_is_valid() &&
	    upeek(tcp, sizeof(long) * PT_CCR, &ppc_regs.ccr))
                return -1;
	const unsigned long old_ccr = ppc_regs.ccr;
	ppc_regs.gpr[3] = r3;
	ppc_regs.ccr |= ccr_set;
	ppc_regs.ccr &= ~ccr_clear;
	if (ppc_regs.ccr != old_ccr &&
	    upoke(tcp, sizeof(long) * PT_CCR, ppc_regs.ccr))
		return -1;
	return upoke(tcp, sizeof(long) * (PT_R0 + 3), ppc_regs.gpr[3]);
}

static int
arch_set_error(struct tcb *tcp)
{
	return arch_set_r3_ccr(tcp, tcp->u_error, 0x10000000, 0);
}

static int
arch_set_success(struct tcb *tcp)
{
	return arch_set_r3_ccr(tcp, tcp->u_rval, 0, 0x10000000);
}


-- 
ldv
