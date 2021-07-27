Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7553D7B61
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhG0QvO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Jul 2021 12:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhG0QvO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 27 Jul 2021 12:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF3460240;
        Tue, 27 Jul 2021 16:51:12 +0000 (UTC)
Date:   Tue, 27 Jul 2021 17:51:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2] arm64: allow TCR_EL1.TBID0 to be configured
Message-ID: <20210727165109.GB13920@arm.com>
References: <20210622051204.3682580-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622051204.3682580-1-pcc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

On Mon, Jun 21, 2021 at 10:12:04PM -0700, Peter Collingbourne wrote:
> Introduce a command line flag that controls whether TCR_EL1.TBID0
> is set at boot time. Since this is a change to the userspace ABI the
> option defaults to off for now, although it seems likely that we'll
> be able to change the default at some future point.
> 
> Setting TCR_EL1.TBID0 increases the number of signature bits used by
> the pointer authentication instructions for instruction addresses by 8,
> which improves the security of pointer authentication, but it also has
> the consequence of changing the operation of the branch instructions
> so that they no longer ignore the top byte of the target address but
> instead fault if they are non-zero.

I'm a bit uneasy about the ABI change and not so keen on constraining
the ABI through the kernel command line. Ideally we should make this an
opt-in per application (prctl()) but that has some aspects to address
first: (a) this bit is permitted to be cached in the TLB so we'd need
some TLBI when setting it (and a clarification in the specs that it is
tagged by ASID/VMID, probably fine) and (b) we'd need to context-switch
TCR_EL1, with a small performance penalty (I don't think it's
significant but worth testing).

Unfortunately, we can't turn TBID0 off dynamically when we detect a
tagged PC since this would break authentication of already encoded
pointers.

Prior to hwasan and MTE, I doubt anyone would have noticed this change
but once malloc() and friends started returning tagged pointers,
programs executing code from malloc()'ed regions would fall apart with
TBID0. I think it's a bit of stretch to argue that it's hwasan and MTE
causing the application breakage rather than a user-kernel ABI change,
since that's already working currently (though such programs should be
re-written).

Longer term, I'd like the TBID0 to be the default but transitioning
without breaking the user is tricky, hence my first option would be
per-application with an opt-in.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 871c82ab0a30..9ee32afe121c 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -529,11 +529,23 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
>  	vm_fault_t fault;
>  	unsigned long vm_flags;
>  	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
> -	unsigned long addr = untagged_addr(far);
> +	unsigned long addr;
>  
>  	if (kprobe_page_fault(regs, esr))
>  		return 0;
>  
> +	/*
> +	 * If TBID0 is set then we may get an IABT with a tagged address here as
> +	 * a result of branching to a tagged address. In this case we want to
> +	 * avoid untagging the address, let the VMA lookup fail and get a
> +	 * SIGSEGV. Leaving the address as is will also work if TBID0 is clear
> +	 * or unsupported because the tag bits of FAR_EL1 will be clear.
> +	 */
> +	if (is_el0_instruction_abort(esr))
> +		addr = far;
> +	else
> +		addr = untagged_addr(far);

Should this also check for tcr_tbid0_enabled() before deciding not to
untag the address?

-- 
Catalin
