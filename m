Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BDD2A3168
	for <lists+linux-api@lfdr.de>; Mon,  2 Nov 2020 18:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgKBRXx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Nov 2020 12:23:53 -0500
Received: from foss.arm.com ([217.140.110.172]:34910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbgKBRXw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 2 Nov 2020 12:23:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 142321FB;
        Mon,  2 Nov 2020 09:23:51 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6F8F3F719;
        Mon,  2 Nov 2020 09:23:48 -0800 (PST)
Date:   Mon, 2 Nov 2020 17:23:45 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Helge Deller <deller@gmx.de>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-api@vger.kernel.org,
        David Spickett <david.spickett@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH v12 3/8] arch: move SA_* definitions to generic headers
Message-ID: <20201102172343.GC6882@arm.com>
References: <cover.1602892799.git.pcc@google.com>
 <9f610ad69ca2f4935f4589c404858a004e913fe2.1602892799.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f610ad69ca2f4935f4589c404858a004e913fe2.1602892799.git.pcc@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 16, 2020 at 05:12:28PM -0700, Peter Collingbourne wrote:
> Most architectures with the exception of alpha, mips, parisc and
> sparc use the same values for these flags. Move their definitions into
> asm-generic/signal-defs.h and allow the architectures with non-standard
> values to override them. Also, document the non-standard flag values
> in order to make it easier to add new generic flags in the future.
> 
> A consequence of this change is that on powerpc and x86, the constants'
> values aside from SA_RESETHAND change signedness from unsigned
> to signed. This is not expected to impact realistic use of these
> constants. In particular the typical use of the constants where they
> are or'ed together and assigned to sa_flags (or another int variable)
> would not be affected.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I haven't checked exhaustively that all the constant values definitely
match up, or that every arch to which this change is applicable has
been patched, but where I have looked, it checks out.

But otherwise, this looks reasonable to me.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> Link: https://linux-review.googlesource.com/id/Ia3849f18b8009bf41faca374e701cdca36974528
> ---
> v11:
> - tweak the commit message to point out the change from unsigned
>   to signed
> 
> v10:
> - move the comments around and add one for SA_SIGINFO
> 
>  arch/alpha/include/uapi/asm/signal.h   | 14 --------
>  arch/arm/include/uapi/asm/signal.h     | 28 ++-------------
>  arch/h8300/include/uapi/asm/signal.h   | 24 -------------
>  arch/ia64/include/uapi/asm/signal.h    | 24 -------------
>  arch/m68k/include/uapi/asm/signal.h    | 24 -------------
>  arch/mips/include/uapi/asm/signal.h    | 12 -------
>  arch/parisc/include/uapi/asm/signal.h  | 13 -------
>  arch/powerpc/include/uapi/asm/signal.h | 24 -------------
>  arch/s390/include/uapi/asm/signal.h    | 24 -------------
>  arch/sparc/include/uapi/asm/signal.h   |  4 +--
>  arch/x86/include/uapi/asm/signal.h     | 24 -------------
>  arch/xtensa/include/uapi/asm/signal.h  | 24 -------------
>  include/uapi/asm-generic/signal-defs.h | 47 ++++++++++++++++++++++++++
>  include/uapi/asm-generic/signal.h      | 29 ----------------
>  14 files changed, 51 insertions(+), 264 deletions(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/signal.h b/arch/alpha/include/uapi/asm/signal.h
> index 74c750bf1c1a..a69dd8d080a8 100644
> --- a/arch/alpha/include/uapi/asm/signal.h
> +++ b/arch/alpha/include/uapi/asm/signal.h
> @@ -60,20 +60,6 @@ typedef unsigned long sigset_t;
>  #define SIGRTMIN	32
>  #define SIGRTMAX	_NSIG
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -
>  #define SA_ONSTACK	0x00000001
>  #define SA_RESTART	0x00000002
>  #define SA_NOCLDSTOP	0x00000004
> diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
> index 9b4185ba4f8a..7727f0984d26 100644
> --- a/arch/arm/include/uapi/asm/signal.h
> +++ b/arch/arm/include/uapi/asm/signal.h
> @@ -60,33 +60,11 @@ typedef unsigned long sigset_t;
>  #define SIGSWI		32
>  
>  /*
> - * SA_FLAGS values:
> - *
> - * SA_NOCLDSTOP		flag to turn off SIGCHLD when children stop.
> - * SA_NOCLDWAIT		flag on SIGCHLD to inhibit zombies.
> - * SA_SIGINFO		deliver the signal with SIGINFO structs
> - * SA_THIRTYTWO		delivers the signal in 32-bit mode, even if the task 
> - *			is running in 26-bit.
> - * SA_ONSTACK		allows alternate signal stacks (see sigaltstack(2)).
> - * SA_RESTART		flag to get restarting signals (which were the default long ago)
> - * SA_NODEFER		prevents the current signal from being masked in the handler.
> - * SA_RESETHAND		clears the handler when the signal is delivered.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> + * SA_THIRTYTWO historically meant deliver the signal in 32-bit mode, even if
> + * the task is running in 26-bit. But since the kernel no longer supports
> + * 26-bit mode, the flag has no effect.
>   */
> -#define SA_NOCLDSTOP	0x00000001
> -#define SA_NOCLDWAIT	0x00000002
> -#define SA_SIGINFO	0x00000004
>  #define SA_THIRTYTWO	0x02000000
> -#define SA_RESTORER	0x04000000
> -#define SA_ONSTACK	0x08000000
> -#define SA_RESTART	0x10000000
> -#define SA_NODEFER	0x40000000
> -#define SA_RESETHAND	0x80000000
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
>  
>  #define MINSIGSTKSZ	2048
>  #define SIGSTKSZ	8192
> diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
> index e15521037348..2cd0dce2b6a6 100644
> --- a/arch/h8300/include/uapi/asm/signal.h
> +++ b/arch/h8300/include/uapi/asm/signal.h
> @@ -57,30 +57,6 @@ typedef unsigned long sigset_t;
>  #define SIGRTMIN	32
>  #define SIGRTMAX	_NSIG
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -#define SA_NOCLDSTOP	0x00000001
> -#define SA_NOCLDWAIT	0x00000002 /* not supported yet */
> -#define SA_SIGINFO	0x00000004
> -#define SA_ONSTACK	0x08000000
> -#define SA_RESTART	0x10000000
> -#define SA_NODEFER	0x40000000
> -#define SA_RESETHAND	0x80000000
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
> -
>  #define SA_RESTORER	0x04000000
>  
>  #define MINSIGSTKSZ	2048
> diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
> index aa98ff1b9e22..38166a88e4c9 100644
> --- a/arch/ia64/include/uapi/asm/signal.h
> +++ b/arch/ia64/include/uapi/asm/signal.h
> @@ -53,30 +53,6 @@
>  #define SIGRTMIN	32
>  #define SIGRTMAX	_NSIG
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -#define SA_NOCLDSTOP	0x00000001
> -#define SA_NOCLDWAIT	0x00000002
> -#define SA_SIGINFO	0x00000004
> -#define SA_ONSTACK	0x08000000
> -#define SA_RESTART	0x10000000
> -#define SA_NODEFER	0x40000000
> -#define SA_RESETHAND	0x80000000
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
> -
>  #define SA_RESTORER	0x04000000
>  
>  /*
> diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
> index 915cc755a184..4619291df601 100644
> --- a/arch/m68k/include/uapi/asm/signal.h
> +++ b/arch/m68k/include/uapi/asm/signal.h
> @@ -57,30 +57,6 @@ typedef unsigned long sigset_t;
>  #define SIGRTMIN	32
>  #define SIGRTMAX	_NSIG
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -#define SA_NOCLDSTOP	0x00000001
> -#define SA_NOCLDWAIT	0x00000002
> -#define SA_SIGINFO	0x00000004
> -#define SA_ONSTACK	0x08000000
> -#define SA_RESTART	0x10000000
> -#define SA_NODEFER	0x40000000
> -#define SA_RESETHAND	0x80000000
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
> -
>  #define MINSIGSTKSZ	2048
>  #define SIGSTKSZ	8192
>  
> diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
> index 53104b10aae2..e6c78a15cb2f 100644
> --- a/arch/mips/include/uapi/asm/signal.h
> +++ b/arch/mips/include/uapi/asm/signal.h
> @@ -62,18 +62,6 @@ typedef unsigned long old_sigset_t;		/* at least 32 bits */
>  #define SIGRTMAX	_NSIG
>  
>  /*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - *
>   * SA_RESTORER used to be defined as 0x04000000 but only the O32 ABI ever
>   * supported its use and no libc was using it, so the entire sa-restorer
>   * functionality was removed with lmo commit 39bffc12c3580ab for 2.5.48
> diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
> index 9e6f87bc8a73..e5a2657477ac 100644
> --- a/arch/parisc/include/uapi/asm/signal.h
> +++ b/arch/parisc/include/uapi/asm/signal.h
> @@ -41,19 +41,6 @@
>  #define SIGRTMIN	32
>  #define SIGRTMAX	_NSIG
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
>  #define SA_ONSTACK	0x00000001
>  #define SA_RESETHAND	0x00000004
>  #define SA_NOCLDSTOP	0x00000008
> diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
> index 85b0a7aa43e7..04873dd311c2 100644
> --- a/arch/powerpc/include/uapi/asm/signal.h
> +++ b/arch/powerpc/include/uapi/asm/signal.h
> @@ -60,30 +60,6 @@ typedef struct {
>  #define SIGRTMIN	32
>  #define SIGRTMAX	_NSIG
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK is not currently supported, but will allow sigaltstack(2).
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -#define SA_NOCLDSTOP	0x00000001U
> -#define SA_NOCLDWAIT	0x00000002U
> -#define SA_SIGINFO	0x00000004U
> -#define SA_ONSTACK	0x08000000U
> -#define SA_RESTART	0x10000000U
> -#define SA_NODEFER	0x40000000U
> -#define SA_RESETHAND	0x80000000U
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
> -
>  #define SA_RESTORER	0x04000000U
>  
>  #define MINSIGSTKSZ	2048
> diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
> index 9a14a611ed82..0189f326aac5 100644
> --- a/arch/s390/include/uapi/asm/signal.h
> +++ b/arch/s390/include/uapi/asm/signal.h
> @@ -65,30 +65,6 @@ typedef unsigned long sigset_t;
>  #define SIGRTMIN        32
>  #define SIGRTMAX        _NSIG
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -#define SA_NOCLDSTOP    0x00000001
> -#define SA_NOCLDWAIT    0x00000002
> -#define SA_SIGINFO      0x00000004
> -#define SA_ONSTACK      0x08000000
> -#define SA_RESTART      0x10000000
> -#define SA_NODEFER      0x40000000
> -#define SA_RESETHAND    0x80000000
> -
> -#define SA_NOMASK       SA_NODEFER
> -#define SA_ONESHOT      SA_RESETHAND
> -
>  #define SA_RESTORER     0x04000000
>  
>  #define MINSIGSTKSZ     2048
> diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
> index ff9505923b9a..53758d53ac0e 100644
> --- a/arch/sparc/include/uapi/asm/signal.h
> +++ b/arch/sparc/include/uapi/asm/signal.h
> @@ -137,13 +137,11 @@ struct sigstack {
>  #define SA_STACK	_SV_SSTACK
>  #define SA_ONSTACK	_SV_SSTACK
>  #define SA_RESTART	_SV_INTR
> -#define SA_ONESHOT	_SV_RESET
> +#define SA_RESETHAND	_SV_RESET
>  #define SA_NODEFER	0x20u
>  #define SA_NOCLDWAIT    0x100u
>  #define SA_SIGINFO      0x200u
>  
> -#define SA_NOMASK	SA_NODEFER
> -
>  #define SIG_BLOCK          0x01	/* for blocking signals */
>  #define SIG_UNBLOCK        0x02	/* for unblocking signals */
>  #define SIG_SETMASK        0x04	/* for setting the signal mask */
> diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
> index e5745d593dc7..164a22a72984 100644
> --- a/arch/x86/include/uapi/asm/signal.h
> +++ b/arch/x86/include/uapi/asm/signal.h
> @@ -62,30 +62,6 @@ typedef unsigned long sigset_t;
>  #define SIGRTMIN	32
>  #define SIGRTMAX	_NSIG
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -#define SA_NOCLDSTOP	0x00000001u
> -#define SA_NOCLDWAIT	0x00000002u
> -#define SA_SIGINFO	0x00000004u
> -#define SA_ONSTACK	0x08000000u
> -#define SA_RESTART	0x10000000u
> -#define SA_NODEFER	0x40000000u
> -#define SA_RESETHAND	0x80000000u
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
> -
>  #define SA_RESTORER	0x04000000
>  
>  #define MINSIGSTKSZ	2048
> diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
> index 005dec5bfde4..79ddabaa4e5d 100644
> --- a/arch/xtensa/include/uapi/asm/signal.h
> +++ b/arch/xtensa/include/uapi/asm/signal.h
> @@ -72,30 +72,6 @@ typedef struct {
>  #define SIGRTMIN	32
>  #define SIGRTMAX	(_NSIG-1)
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -#define SA_NOCLDSTOP	0x00000001
> -#define SA_NOCLDWAIT	0x00000002 /* not supported yet */
> -#define SA_SIGINFO	0x00000004
> -#define SA_ONSTACK	0x08000000
> -#define SA_RESTART	0x10000000
> -#define SA_NODEFER	0x40000000
> -#define SA_RESETHAND	0x80000000
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
> -
>  #define SA_RESTORER	0x04000000
>  
>  #define MINSIGSTKSZ	2048
> diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
> index e9304c95ceea..493953fe319b 100644
> --- a/include/uapi/asm-generic/signal-defs.h
> +++ b/include/uapi/asm-generic/signal-defs.h
> @@ -4,6 +4,53 @@
>  
>  #include <linux/compiler.h>
>  
> +/*
> + * SA_FLAGS values:
> + *
> + * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> + * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> + * SA_SIGINFO delivers the signal with SIGINFO structs.
> + * SA_ONSTACK indicates that a registered stack_t will be used.
> + * SA_RESTART flag to get restarting signals (which were the default long ago)
> + * SA_NODEFER prevents the current signal from being masked in the handler.
> + * SA_RESETHAND clears the handler when the signal is delivered.
> + *
> + * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> + * Unix names RESETHAND and NODEFER respectively.
> + *
> + * The following bits are used in architecture-specific SA_* definitions and
> + * should be avoided for new generic flags: 3, 4, 5, 6, 7, 8, 9, 16, 24, 25, 26.
> + */
> +#ifndef SA_NOCLDSTOP
> +#define SA_NOCLDSTOP	0x00000001
> +#endif
> +#ifndef SA_NOCLDWAIT
> +#define SA_NOCLDWAIT	0x00000002
> +#endif
> +#ifndef SA_SIGINFO
> +#define SA_SIGINFO	0x00000004
> +#endif
> +#ifndef SA_ONSTACK
> +#define SA_ONSTACK	0x08000000
> +#endif
> +#ifndef SA_RESTART
> +#define SA_RESTART	0x10000000
> +#endif
> +#ifndef SA_NODEFER
> +#define SA_NODEFER	0x40000000
> +#endif
> +#ifndef SA_RESETHAND
> +#define SA_RESETHAND	0x80000000
> +#endif
> +
> +#define SA_NOMASK	SA_NODEFER
> +#define SA_ONESHOT	SA_RESETHAND
> +
> +/*
> + * New architectures should not define the obsolete
> + *	SA_RESTORER	0x04000000
> + */
> +
>  #ifndef SIG_BLOCK
>  #define SIG_BLOCK          0	/* for blocking signals */
>  #endif
> diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
> index 5c716a952cbe..f634822906e4 100644
> --- a/include/uapi/asm-generic/signal.h
> +++ b/include/uapi/asm-generic/signal.h
> @@ -52,35 +52,6 @@
>  #define SIGRTMAX	_NSIG
>  #endif
>  
> -/*
> - * SA_FLAGS values:
> - *
> - * SA_ONSTACK indicates that a registered stack_t will be used.
> - * SA_RESTART flag to get restarting signals (which were the default long ago)
> - * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
> - * SA_RESETHAND clears the handler when the signal is delivered.
> - * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
> - * SA_NODEFER prevents the current signal from being masked in the handler.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> - */
> -#define SA_NOCLDSTOP	0x00000001
> -#define SA_NOCLDWAIT	0x00000002
> -#define SA_SIGINFO	0x00000004
> -#define SA_ONSTACK	0x08000000
> -#define SA_RESTART	0x10000000
> -#define SA_NODEFER	0x40000000
> -#define SA_RESETHAND	0x80000000
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
> -
> -/*
> - * New architectures should not define the obsolete
> - *	SA_RESTORER	0x04000000
> - */
> -
>  #if !defined MINSIGSTKSZ || !defined SIGSTKSZ
>  #define MINSIGSTKSZ	2048
>  #define SIGSTKSZ	8192
> -- 
> 2.29.0.rc1.297.gfa9743e501-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
