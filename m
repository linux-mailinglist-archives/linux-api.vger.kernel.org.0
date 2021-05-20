Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E749389B91
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 04:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhETDBL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 23:01:11 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59622 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhETDBL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 23:01:11 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7D45C72C8BA;
        Thu, 20 May 2021 05:59:48 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 700037CC8A6; Thu, 20 May 2021 05:59:48 +0300 (MSK)
Date:   Thu, 20 May 2021 05:59:48 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Rich Felker <dalias@libc.org>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, musl@lists.openwall.com,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Linux powerpc new system call instruction and ABI
Message-ID: <20210520025948.GA27081@altlinux.org>
References: <1621410291.c7si38sa9q.astroid@bobo.none>
 <fb9b6a6099855bd00efc6ffe540ccad14dd9a365.camel@infinera.com>
 <1621413143.oec64jaci5.astroid@bobo.none>
 <20210519143836.GJ10366@gate.crashing.org>
 <11d62aa2488e51ec00fe77f24a1d7cdcc21af0b8.camel@infinera.com>
 <20210519152205.GL10366@gate.crashing.org>
 <adec4377144a44b6f9ddd10c1b5256b80c9ceb50.camel@infinera.com>
 <20210519234846.GS2546@brightrain.aerifal.cx>
 <20210520010612.GA25599@altlinux.org>
 <1621478448.743zqcrxza.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621478448.743zqcrxza.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 12:45:57PM +1000, Nicholas Piggin wrote:
> Excerpts from Dmitry V. Levin's message of May 20, 2021 11:06 am:
> > On Wed, May 19, 2021 at 07:48:47PM -0400, Rich Felker wrote:
> >> On Wed, May 19, 2021 at 06:09:25PM +0000, Joakim Tjernlund wrote:
> > [...]
> >> > W.r.t breaking ABI, isn't that what PowerPC is trying to do with the new syscall I/F? 
> >> 
> >> No, it's a new independent interface.
> > 
> > Unfortunately, being a new independent interface doesn't mean it isn't
> > an ABI break.  In fact, it was a severe ABI break, and this thread is
> > an attempt to find a hotfix.
> 
> It is an ABI break, that was known. The ptrace info stuff I fixed with 
> the patch earlier was obviously a bug in my initial implementation and 
> not intended (sorry my ptrace testing was not sufficient, and thanks for
> reporting it, by the way).

Could you check whether tools/testing/selftests/ptrace/get_syscall_info.c
passes again with your fix, please?
If yes, then PTRACE_GET_SYSCALL_INFO is fixed.

By the way, kernel tracing and audit subsystems also use those functions
from asm/syscall.h and asm/ptrace.h, so your ptrace fix is likely to fix
these subsystems as well.


-- 
ldv
