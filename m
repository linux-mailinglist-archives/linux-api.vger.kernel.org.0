Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CDD303DB0
	for <lists+linux-api@lfdr.de>; Tue, 26 Jan 2021 13:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbhAZMu6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 07:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403998AbhAZMup (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 26 Jan 2021 07:50:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3F3C23104;
        Tue, 26 Jan 2021 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611665404;
        bh=q4oX4T75qfWKcUAgbiXEqfTO9YmhG1JKbBL7GViYtBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmCIdX4lGOs1R9IlyfQiNrg6I8Ou07qJVfH09b0Pa49T66g+MTZ0xcy5oy7kSqiW1
         LkA4XAoYk/G5uNoAUcBBM36WIhkqLwo0x/sYNwgE+yt8TZVxT/9bnu3eUT3Cuswqvd
         amncBSy78benJWebvhPeu5eyFnL0pcqDbjG61R+yvjRvHXL+QGEfm4U8aRc9hIZCVi
         FZVm/dzxoeMiV/6QH9ch8Ifgqv+fZ6o3cJZHVRy/+zAQLSucRiVKhwUQ+fxHPPg3yr
         rOvVjtW/5Gv9ZUz4qfgqPcpImhW5jNxiKxMl1mUjKsaxbFI/EBDrEHXK2PHu7hP5kj
         obvZA2Tia2egA==
Date:   Tue, 26 Jan 2021 12:49:59 +0000
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
Subject: Re: [PATCH v6 1/3] arm64: mte: make the per-task SCTLR_EL1 field
 usable elsewhere
Message-ID: <20210126124958.GC29702@willie-the-truck>
References: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 29, 2020 at 10:59:13PM -0800, Peter Collingbourne wrote:
> In an upcoming change we are going to introduce per-task SCTLR_EL1
> bits for PAC. Move the existing per-task SCTLR_EL1 field out of the
> MTE-specific code so that we will be able to use it from both the
> PAC and MTE code paths and make the task switching code more efficient.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/Ic65fac78a7926168fa68f9e8da591c9e04ff7278
> ---
>  arch/arm64/Kconfig                 |  4 +++
>  arch/arm64/include/asm/mte.h       |  4 ---
>  arch/arm64/include/asm/processor.h | 10 ++++++-
>  arch/arm64/kernel/mte.c            | 47 ++++++------------------------
>  arch/arm64/kernel/process.c        | 34 +++++++++++++++++----
>  5 files changed, 50 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 05e17351e4f3..82e38d1ca012 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -348,6 +348,9 @@ config KASAN_SHADOW_OFFSET
>  	default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>  	default 0xffffffffffffffff
>  
> +config ARM64_NEED_SCTLR_USER
> +	bool
> +
>  source "arch/arm64/Kconfig.platforms"
>  
>  menu "Kernel Features"
> @@ -1653,6 +1656,7 @@ config ARM64_MTE
>  	# Required for tag checking in the uaccess routines
>  	depends on ARM64_PAN
>  	select ARCH_USES_HIGH_VMA_FLAGS
> +	select ARM64_NEED_SCTLR_USER

I'm not sure I'd bother with this; is it the end of the world if we do this
unconditionally?

Will
