Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D0219769
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 06:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgGIEeN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 00:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgGIEeN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 00:34:13 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F8C061A0B;
        Wed,  8 Jul 2020 21:34:13 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4B2Nc34nrTz9sRR; Thu,  9 Jul 2020 14:34:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1594269251; bh=0vflje8iQykW6xAQTgpYROqiG9MTRc6uT+kAmyWkOkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mdhv0xEwxQFAx6A9eiN/ntEepUWd2HRs2jU9CZrCRyFo2Dj+WkbTY3xiXpI8MxWC6
         ur+5kQqaiCpGOBkvtkcNk39V8G65GYQI5IWZV48ni3Mgdx7zSRn/7npj2ZYa0eKaH6
         yHRuFm/R4hLfMF4ki8/j8mmnpQn1BiHOLLiDs1v+DNsq1NN+8oYyvC70rahe7P+7gr
         ZX1QR3R2+v2VNEO66kqHHR1xjDiH6OjtMcYydEnXgCGXZg5CfcVwtapV8zOStxaDp2
         3EFaxLssb+lX0o9gKEzgtI1TDWBvtbxPZxUcLd4MYmJyENjQwJomEEe9kQpblL03df
         dbM2rBzIqXdVg==
Date:   Thu, 9 Jul 2020 14:34:06 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Nicholas Piggin <npiggin@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 2/3] powerpc/64s: remove PROT_SAO support
Message-ID: <20200709043406.GB2822576@thinks.paulus.ozlabs.org>
References: <20200703011958.1166620-1-npiggin@gmail.com>
 <20200703011958.1166620-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703011958.1166620-3-npiggin@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 03, 2020 at 11:19:57AM +1000, Nicholas Piggin wrote:
> ISA v3.1 does not support the SAO storage control attribute required to
> implement PROT_SAO. PROT_SAO was used by specialised system software
> (Lx86) that has been discontinued for about 7 years, and is not thought
> to be used elsewhere, so removal should not cause problems.
> 
> We rather remove it than keep support for older processors, because
> live migrating guest partitions to newer processors may not be possible
> if SAO is in use (or worse allowed with silent races).

This is actually a real problem for KVM, because now we have the
capabilities of the host affecting the characteristics of the guest
virtual machine in a manner which userspace (e.g. QEMU) is unable to
control.

It would probably be better to disallow SAO on all machines than have
it available on some hosts and not others.  (Yes I know there is a
check on CPU_FTR_ARCH_206 in there, but that has been a no-op since we
removed the PPC970 KVM support.)

Solving this properly will probably require creating a new KVM host
capability and associated machine parameter in QEMU, along with a new
machine type.

[snip]

> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
> index 9bb9bb370b53..fac39ff659d4 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -398,9 +398,10 @@ static inline bool hpte_cache_flags_ok(unsigned long hptel, bool is_ci)
>  {
>  	unsigned int wimg = hptel & HPTE_R_WIMG;
>  
> -	/* Handle SAO */
> +	/* Handle SAO for POWER7,8,9 */
>  	if (wimg == (HPTE_R_W | HPTE_R_I | HPTE_R_M) &&
> -	    cpu_has_feature(CPU_FTR_ARCH_206))
> +	    cpu_has_feature(CPU_FTR_ARCH_206) &&
> +	    !cpu_has_feature(CPU_FTR_ARCH_31))
>  		wimg = HPTE_R_M;

Paul.
