Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0F30F685
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 16:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhBDPiC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 10:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237167AbhBDPhH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 4 Feb 2021 10:37:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAE2064F3C;
        Thu,  4 Feb 2021 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612452980;
        bh=V2+LJ8z1KQnNgpVRjLeJbDwIcI5psNklwq0UR+e71Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlhYQNe7yZFHun18Iv/OtdC4lYOA60k12RugBYQGdC4Tj78W9V84V84pyZZmTGs12
         9ZjhJIaW4p1uqsuoNshWx4ZtTcrNi8EXT/XDAbcDXA/2yavrKD47ZSFItuKSnU+9o9
         G1NN7Rbex/GdwzlhEXOjnUTxXtGKSXFEmd/4g/iSUbVQPfm3c+SaxlaFKfzysmFNo2
         Of3a527jfeyY0PVkAHafTs69zccRXsa4rMaRcxnXkVLLtQkJ++yhy44bmvw8EHAG6q
         Q0w7yrU9JyeRlids1I3QvQkUxAti3EcHLWtEtg0jZdkjZ3Fmcf6Wf2L0aeh3AW/4pl
         JqVavM4fpD1Mw==
Date:   Thu, 4 Feb 2021 15:36:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 2/3] arm64/ptrace: introduce PTRACE_O_ARM64_RAW_REGS
Message-ID: <20210204153615.GB21058@willie-the-truck>
References: <20210201194012.524831-1-avagin@gmail.com>
 <20210201194012.524831-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201194012.524831-3-avagin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 01, 2021 at 11:40:11AM -0800, Andrei Vagin wrote:
> We have some ABI weirdness in the way that we handle syscall
> exit stops because we indicate whether or not the stop has been
> signalled from syscall entry or syscall exit by clobbering a general
> purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
> and restoring its old value after the stop.
> 
> This behavior was inherited from ARM and it isn't common for other
> architectures. Now, we have PTRACE_GET_SYSCALL_INFO that gives all
> required information about system calls, so the hack with clobbering
> registers isn't needed anymore.
> 
> This change adds the new ptrace option PTRACE_O_ARM64_RAW_REGS.  If it
> is set, PTRACE_GETREGSET returns values of all registers without
> clobbering r12 or x7 and PTRACE_SETREGSE sets all registers even if a
> process has been stopped in syscall-enter or syscall-exit.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  arch/arm64/include/uapi/asm/ptrace.h |  4 ++
>  arch/arm64/kernel/ptrace.c           | 70 ++++++++++++++++------------
>  include/linux/ptrace.h               |  1 +
>  include/uapi/linux/ptrace.h          |  9 +++-
>  4 files changed, 52 insertions(+), 32 deletions(-)

Please split this up so that the arm64-specific changes are separate to
the core changes.

> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index 83ee45fa634b..bcc8c362ddd9 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -7,6 +7,7 @@
>  /* has the defines to get at the registers. */
>  
>  #include <linux/types.h>
> +#include <asm/ptrace.h>
>  
>  #define PTRACE_TRACEME		   0
>  #define PTRACE_PEEKTEXT		   1
> @@ -137,8 +138,14 @@ struct ptrace_syscall_info {
>  #define PTRACE_O_EXITKILL		(1 << 20)
>  #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
>  
> +/* (1<<28) is reserved for arch specific options. */
> +#ifndef _PTRACE_O_ARCH_OPTIONS
> +#define _PTRACE_O_ARCH_OPTIONS 0
> +#endif

It seems a bit fragile to rely on a comment here to define the user ABI;
why not define _PTRACE_O_ARCH_OPTIONS to the right value unconditionally?

Also, it seems as though we immediately burn this bit on arm64, so if we
ever wanted another option we'd have to come back here and allocate another
bit. Could we do better, e.g. by calling into an arch hook
(arch_ptrace_setoptions()) and passing the 'addr' parameter?

How do other architectures manage this sort of thing? I'm wondering whether
a separate regset containing just "real x7" and orig_x0 would be preferable
after all...

Will
