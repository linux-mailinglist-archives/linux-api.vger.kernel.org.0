Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ADE2B5077
	for <lists+linux-api@lfdr.de>; Mon, 16 Nov 2020 20:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKPTBY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 14:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgKPTBY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 16 Nov 2020 14:01:24 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FBA206A1;
        Mon, 16 Nov 2020 19:01:21 +0000 (UTC)
Date:   Mon, 16 Nov 2020 19:01:18 +0000
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
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v16 6/6] arm64: expose FAR_EL1 tag bits in siginfo
Message-ID: <X7LMfrl/vQ8vA+Va@trantor>
References: <cover.1605235762.git.pcc@google.com>
 <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 12, 2020 at 06:53:36PM -0800, Peter Collingbourne wrote:
> diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
> index eab4323609b9..19d284b70384 100644
> --- a/Documentation/arm64/tagged-pointers.rst
> +++ b/Documentation/arm64/tagged-pointers.rst
> @@ -53,12 +53,25 @@ visibility.
>  Preserving tags
>  ---------------
>  
> -Non-zero tags are not preserved when delivering signals. This means that
> -signal handlers in applications making use of tags cannot rely on the
> -tag information for user virtual addresses being maintained for fields
> -inside siginfo_t. One exception to this rule is for signals raised in
> -response to watchpoint debug exceptions, where the tag information will
> -be preserved.
> +When delivering signals, non-zero tags are not preserved in
> +siginfo.si_addr unless the flag SA_EXPOSE_TAGBITS was set in
> +sigaction.sa_flags when the signal handler was installed. This means
> +that signal handlers in applications making use of tags cannot rely
> +on the tag information for user virtual addresses being maintained
> +in these fields unless the flag was set.
> +
> +Due to architecture limitations, bits 63:60 of the fault address
> +are not preserved in response to synchronous tag check faults
> +(SEGV_MTESERR) even if SA_EXPOSE_TAGBITS was set. Applications should
> +treat the values of these bits as undefined in order to accommodate
> +future architecture revisions which may preserve the bits.

If future architecture versions will preserve these bits, most likely
we'll add a new HWCAP bit so that the user knows what's going on. But
the user shouldn't rely on them being 0, just in case.

> +For signals raised in response to watchpoint debug exceptions, the
> +tag information will be preserved regardless of the SA_EXPOSE_TAGBITS
> +flag setting.
> +
> +Non-zero tags are never preserved in sigcontext.fault_address
> +regardless of the SA_EXPOSE_TAGBITS flag setting.

We could've done it the other way around (fault_address tagged, si_addr
untagged) but that would be specific to arm64, so I think we should
solve it for other architectures that implement (or plan to) tagging.
The fault_address in the arm64 sigcontext was an oversight, we should
have removed it but when we realised it was already ABI.

Anyway, I'm fine with the arm64 changes here:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

With Eric's ack, I'm happy to take the series through the arm64 tree,
otherwise Eric's tree is fine as well.

Thanks.

-- 
Catalin
