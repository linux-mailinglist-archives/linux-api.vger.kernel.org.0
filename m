Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847252C302C
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 19:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404275AbgKXSrv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 13:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbgKXSru (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 24 Nov 2020 13:47:50 -0500
Received: from C02TF0J2HF1T.local (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D05206E5;
        Tue, 24 Nov 2020 18:47:46 +0000 (UTC)
Date:   Tue, 24 Nov 2020 18:47:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH 2/2] arm64: allow TCR_EL1.TBID0 to be configured
Message-ID: <20201124184742.GC42276@C02TF0J2HF1T.local>
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
 <64c0fa360333fd5275582d25019614156a8302bc.1605952129.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c0fa360333fd5275582d25019614156a8302bc.1605952129.git.pcc@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 21, 2020 at 01:59:03AM -0800, Peter Collingbourne wrote:
> Introduce a Kconfig option that controls whether TCR_EL1.TBID0 is
> set at boot time.
> 
> Setting TCR_EL1.TBID0 increases the number of signature bits used by
> the pointer authentication instructions for instruction addresses by 8,
> which improves the security of pointer authentication, but it also has
> the consequence of changing the operation of the branch instructions
> so that they no longer ignore the top byte of the target address but
> instead fault if they are non-zero. Since this is a change to the
> userspace ABI the option defaults to off.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/Ife724ad708142bc475f42e8c1d9609124994bbbd
> ---
> This is more of an RFC. An open question is how to expose this.
> Having it be a build-time flag is probably the simplest option
> but I guess it could also be a boot flag. Since it involves an
> ABI change we may also want a prctl() so that userspace can
> figure out which mode it is in.
> 
> I think we should try to avoid it being a per-task property
> so that we don't need to swap yet another system register on
> task switch.

Having it changed per task at run-time is problematic as this bit may be
cached in the TLB, so it would require a synchronisation across all CPUs
followed by TLBI. It's not even clear to me from the ARM ARM whether
this bit is tagged by ASID, which, if not, would make a per-process
setting impossible.

So this leaves us with a cmdline option. If we are confident that no
software makes use of tagged instruction pointers, we could have it
default on.

Adding Szabolcs on the gcc/glibc side.

-- 
Catalin
