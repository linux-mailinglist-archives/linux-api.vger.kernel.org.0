Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3974F303DAE
	for <lists+linux-api@lfdr.de>; Tue, 26 Jan 2021 13:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbhAZMuz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 07:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404007AbhAZMub (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 26 Jan 2021 07:50:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96FC023109;
        Tue, 26 Jan 2021 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611665390;
        bh=xTKZZjPyyTa3jyDBmC3PhRNSWSN5FlJQnDqhElm3O2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p02hTXiVZ6moMxrw9NhBX3g5RorfBQjNq7GiFktAQSAhRIoDPhwyWCdi0EqojfwK+
         8SUxoIp5K4k/1JtuislUPTq4uxrsV+vKpv8mk1H6sRVpTBLHL++1nyKqidx6V+tAxg
         X3y5KduJwdD/QGXRAkhAquAHxiDUznhN26CFGI378on1lZHme25DW7op1eaTUGQSPR
         TH+C54jfIYrmZbVjAyKVKu7DyxFbsYrn/6K9XfGLycookYkrgMOuurWp6Xc0J2XF8s
         39iELPsFll8PV35ZTzokUdVfBCGkm4DpEpMn2hsFNvRaYSeDhXN/inLZ1ZYOsry9/t
         Riz3AMHBTDlqA==
Date:   Tue, 26 Jan 2021 12:49:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH v6 2/3] arm64: Introduce
 prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20210126124945.GB29702@willie-the-truck>
References: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
 <295aec08a383cb9cb4a6062cf2ab21b4f59082b9.1609311499.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295aec08a383cb9cb4a6062cf2ab21b4f59082b9.1609311499.git.pcc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 29, 2020 at 10:59:14PM -0800, Peter Collingbourne wrote:
> This change introduces a prctl that allows the user program to control
> which PAC keys are enabled in a particular task. The main reason
> why this is useful is to enable a userspace ABI that uses PAC to
> sign and authenticate function pointers and other pointers exposed
> outside of the function, while still allowing binaries conforming
> to the ABI to interoperate with legacy binaries that do not sign or
> authenticate pointers.
> 
> The idea is that a dynamic loader or early startup code would issue
> this prctl very early after establishing that a process may load legacy
> binaries, but before executing any PAC instructions.
> 
> This change adds a small amount of overhead to kernel entry and exit
> due to additional required instruction sequences.
> 
> On a DragonBoard 845c (Cortex-A75) with the powersave governor, the
> overhead of similar instruction sequences was measured as 4.9ns when
> simulating the common case where IA is left enabled, or 43.7ns when
> simulating the uncommon case where IA is disabled. These numbers can
> be seen as the worst case scenario, since in more realistic scenarios
> a better performing governor would be used and a newer chip would be
> used that would support PAC unlike Cortex-A75 and would be expected
> to be faster than Cortex-A75.
> 
> On an Apple M1 under a hypervisor, the overhead of the entry/exit
> instruction sequences introduced by this patch was measured as 0.3ns
> in the case where IA is left enabled, and 33.0ns in the case where
> IA is disabled.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5

[...]

> diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
> index adb955fd9bdd..f03e5bfe4490 100644
> --- a/arch/arm64/kernel/pointer_auth.c
> +++ b/arch/arm64/kernel/pointer_auth.c
> @@ -46,3 +46,65 @@ int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
>  
>  	return 0;
>  }
> +
> +static u64 arg_to_enxx_mask(unsigned long arg)
> +{
> +	u64 sctlr_enxx_mask = 0;
> +
> +	WARN_ON(arg & ~PR_PAC_ENABLED_KEYS_MASK);
> +	if (arg & PR_PAC_APIAKEY)
> +		sctlr_enxx_mask |= SCTLR_ELx_ENIA;
> +	if (arg & PR_PAC_APIBKEY)
> +		sctlr_enxx_mask |= SCTLR_ELx_ENIB;
> +	if (arg & PR_PAC_APDAKEY)
> +		sctlr_enxx_mask |= SCTLR_ELx_ENDA;
> +	if (arg & PR_PAC_APDBKEY)
> +		sctlr_enxx_mask |= SCTLR_ELx_ENDB;
> +	return sctlr_enxx_mask;
> +}
> +
> +int ptrauth_set_enabled_keys(struct task_struct *tsk, unsigned long keys,
> +			     unsigned long enabled)
> +{
> +	u64 sctlr = tsk->thread.sctlr_user;
> +
> +	if (!system_supports_address_auth())
> +		return -EINVAL;
> +
> +	if (is_compat_thread(task_thread_info(tsk)))
> +		return -EINVAL;
> +
> +	if ((keys & ~PR_PAC_ENABLED_KEYS_MASK) || (enabled & ~keys))
> +		return -EINVAL;
> +
> +	sctlr &= ~arg_to_enxx_mask(keys);
> +	sctlr |= arg_to_enxx_mask(enabled);
> +	if (tsk == current)
> +		set_task_sctlr_el1(sctlr);
> +	else
> +		tsk->thread.sctlr_user = sctlr;

Who synchronizes all these modifications to 'sctlr_user'? Seems like it gets
hit by two independent prctl()s as well as ptrace.

Will
