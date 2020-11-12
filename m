Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181E22B0D09
	for <lists+linux-api@lfdr.de>; Thu, 12 Nov 2020 19:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKLSxb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 13:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgKLSxb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 12 Nov 2020 13:53:31 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1009722228;
        Thu, 12 Nov 2020 18:53:27 +0000 (UTC)
Date:   Thu, 12 Nov 2020 18:53:25 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v14 8/8] arm64: expose FAR_EL1 tag bits in siginfo
Message-ID: <20201112185324.GP29613@gaia>
References: <cover.1604523707.git.pcc@google.com>
 <0ce3d90b5d6a4457b2fe3b0582f61fab70b17dfc.1604523707.git.pcc@google.com>
 <87eel2ypy3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eel2ypy3.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 09, 2020 at 07:13:08PM -0600, Eric W. Biederman wrote:
> Peter Collingbourne <pcc@google.com> writes:
> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > the tag bits may be needed by tools in order to accurately diagnose
> > memory errors, such as HWASan [1] or future tools based on the Memory
> > Tagging Extension (MTE).
> >
> > We should not stop clearing these bits in the existing fault address
> > fields, because there may be existing userspace applications that are
> > expecting the tag bits to be cleared. Instead, create a new pair of
> > fields in siginfo._sigfault, and store the tag bits of FAR_EL1 there,
> > together with a mask specifying which bits are valid.
> >
> > A flag is added to si_faultflags to allow userspace to determine whether
> > the values in the fields are valid.
[...]
> What prevents adding a sigaction sa_flag SA_EXPOSE_TABITS that when set
> causes the high bits to be set, and when clear (the default) will have
> the signal delivery code clear those bits.

Thanks for the review so far Eric.

If the SA_EXPOSE_TAGBITS idea works, I'd much rather have that than the
ultra generic xflags approach.

Given that Peter is going to rework this part, could you please pick the
first clean-up patches via your tree? If there are dependencies with the
reworked arm64 patches, I'm also happy for them to go via your tree.

Thanks.

-- 
Catalin
