Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8002A4EEC
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 19:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKCSdb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 13:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCSdb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Nov 2020 13:33:31 -0500
Received: from C02TF0J2HF1T.local (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF0D2076E;
        Tue,  3 Nov 2020 18:33:24 +0000 (UTC)
Date:   Tue, 3 Nov 2020 18:33:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v13 8/8] arm64: expose FAR_EL1 tag bits in siginfo
Message-ID: <20201103183321.GB81026@C02TF0J2HF1T.local>
References: <cover.1604376407.git.pcc@google.com>
 <c8a229473591a7bf98dc79e92403fe2de854ffef.1604376407.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a229473591a7bf98dc79e92403fe2de854ffef.1604376407.git.pcc@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 02, 2020 at 08:09:44PM -0800, Peter Collingbourne wrote:
> The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> the tag bits may be needed by tools in order to accurately diagnose
> memory errors, such as HWASan [1] or future tools based on the Memory
> Tagging Extension (MTE).
> 
> We should not stop clearing these bits in the existing fault address
> fields, because there may be existing userspace applications that are
> expecting the tag bits to be cleared. Instead, create a new pair of
> union fields in siginfo._sigfault, and store the tag bits of FAR_EL1
> there, together with a mask specifying which bits are valid.

This comment is slightly confusing as they are not union fields in
_sigfault.

> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index f43778355b77..2b2ed0394457 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -94,6 +94,8 @@ union __sifields {
>  			void *_pad[6];
>  		};
>  		__u32 _faultflags;
> +		unsigned long _addr_tag_bits;
> +		unsigned long _addr_tag_bits_mask;
>  	} _sigfault;

Can we not actually add these as a struct to the union? Do we expect the
other fields to be valid?

Also there's a 32-bit gap I mentioned on the previous patch between
_faultflags and _addr_tag_bits.

That said, I wonder whether we could solve this for MTE without new
fields by always setting the tag in si_addr when si_code is SEGV_MTE*.
Alternatively, we could add a prctl() bit to require tagged si_addr.

Well, I don't mind the _addr_tag_bits* fields if they are part of the
union and keep si_addr intact.

-- 
Catalin
