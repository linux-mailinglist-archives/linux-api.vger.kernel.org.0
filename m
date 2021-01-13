Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17932F4F1B
	for <lists+linux-api@lfdr.de>; Wed, 13 Jan 2021 16:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhAMPqr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Jan 2021 10:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbhAMPqr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 13 Jan 2021 10:46:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67E37208BA;
        Wed, 13 Jan 2021 15:46:04 +0000 (UTC)
Date:   Wed, 13 Jan 2021 15:46:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v21 2/2] arm64: expose FAR_EL1 tag bits in siginfo
Message-ID: <20210113154601.GB27045@gaia>
References: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
 <0010296597784267472fa13b39f8238d87a72cf8.1605904350.git.pcc@google.com>
 <CAAeHK+xZJqqdcXyzx0G1P76Kfx_wa9XSCSc3mjOnwc3qervY+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xZJqqdcXyzx0G1P76Kfx_wa9XSCSc3mjOnwc3qervY+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 13, 2021 at 03:51:42PM +0100, Andrey Konovalov wrote:
> On Fri, Nov 20, 2020 at 9:34 PM Peter Collingbourne <pcc@google.com> wrote:
> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > the tag bits may be needed by tools in order to accurately diagnose
> > memory errors, such as HWASan [1] or future tools based on the Memory
> > Tagging Extension (MTE).
> >
> > Expose these bits via the arch_untagged_si_addr mechanism, so that
> > they are only exposed to signal handlers with the SA_EXPOSE_TAGBITS
> > flag set.
> >
> > [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Link: https://linux-review.googlesource.com/id/Ia8876bad8c798e0a32df7c2ce1256c4771c81446
[...]
> Not sure if it's expected, but this patch changes the way in-kernel
> MTE faults are reported. The address of any in-kernel fault now gets
> its top byte zeroed out, even though it was set to 0xf. However I
> guess it's related to the fact that MTE always uses pointer tags in
> 0x0_ format.

Is this for _any_ faults or just MTE tag check faults? I tried the
former and seems fine. Do you have a concrete example to make sure I
understand the issue?

-- 
Catalin
