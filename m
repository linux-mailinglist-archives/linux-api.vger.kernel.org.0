Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E742B7DAB
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKRMdm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 07:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgKRMdm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Nov 2020 07:33:42 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AE6238E6;
        Wed, 18 Nov 2020 12:33:38 +0000 (UTC)
Date:   Wed, 18 Nov 2020 12:33:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Florian Weimer <fw@deneb.enyo.de>, libc-alpha@sourceware.org,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <X7UUoFcmtuHEhoz9@trantor>
References: <20201014055106.25164-1-pcc@google.com>
 <87blfv6fj3.fsf@mid.deneb.enyo.de>
 <CAMn1gO7a-uyP93P4KapbsXy1+HRSuJR4r_kyy0_-FCY69qO_nA@mail.gmail.com>
 <20201117183911.GI15033@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117183911.GI15033@arm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 17, 2020 at 06:39:13PM +0000, Szabolcs Nagy wrote:
> The 11/17/2020 10:17, Peter Collingbourne via Libc-alpha wrote:
> > On Tue, Nov 17, 2020 at 9:48 AM Florian Weimer <fw@deneb.enyo.de> wrote:
> > >
> > > * Peter Collingbourne:
> > >
> > > > This prctl allows the user program to control which PAC keys are enabled
> > > > in a particular task. The main reason why this is useful is to enable a
> > > > userspace ABI that uses PAC to sign and authenticate function pointers
> > > > and other pointers exposed outside of the function, while still allowing
> > > > binaries conforming to the ABI to interoperate with legacy binaries that
> > > > do not sign or authenticate pointers.
> > > >
> > > > The idea is that a dynamic loader or early startup code would issue
> > > > this prctl very early after establishing that a process may load legacy
> > > > binaries, but before executing any PAC instructions.
> > >
> > > I thought that the silicon did not support this?

I think the past discussion we had was around enabling PAC for kernel
while disabling it for user. The hardware doesn't give us separate bits,
so Peter's patch toggles them on kernel entry/return, with some overhead
given by the MSR+ISB (to be added).

> > See e.g. the documentation for SCTLR_EL1.EnIA [1] for details. There
> > are also enable bits for the other three keys.
> 
> i think it was insufficiently clear in the architecture
> spec how that can be context switched. (but it probably
> changed)

The bits that we can't toggle easily have the comment "This field is
permitted to be cached in the TLB" in the ARM ARM. Luckily, it's not the
case for EnI*.

-- 
Catalin
