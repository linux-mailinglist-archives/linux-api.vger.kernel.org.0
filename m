Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5922B7E67
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgKRNhx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 08:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKRNhx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Nov 2020 08:37:53 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 271312083E;
        Wed, 18 Nov 2020 13:37:50 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:37:47 +0000
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
Message-ID: <X7Ujq6RCzEQKFVId@trantor>
References: <20201014055106.25164-1-pcc@google.com>
 <87blfv6fj3.fsf@mid.deneb.enyo.de>
 <CAMn1gO7a-uyP93P4KapbsXy1+HRSuJR4r_kyy0_-FCY69qO_nA@mail.gmail.com>
 <20201117183911.GI15033@arm.com>
 <X7UUoFcmtuHEhoz9@trantor>
 <20201118133121.GA20578@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118133121.GA20578@arm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 18, 2020 at 01:31:21PM +0000, Szabolcs Nagy wrote:
> The 11/18/2020 12:33, Catalin Marinas wrote:
> > On Tue, Nov 17, 2020 at 06:39:13PM +0000, Szabolcs Nagy wrote:
> > > The 11/17/2020 10:17, Peter Collingbourne via Libc-alpha wrote:
> > > > On Tue, Nov 17, 2020 at 9:48 AM Florian Weimer <fw@deneb.enyo.de> wrote:
> > > > >
> > > > > * Peter Collingbourne:
> > > > >
> > > > > > This prctl allows the user program to control which PAC keys are enabled
> > > > > > in a particular task. The main reason why this is useful is to enable a
> > > > > > userspace ABI that uses PAC to sign and authenticate function pointers
> > > > > > and other pointers exposed outside of the function, while still allowing
> > > > > > binaries conforming to the ABI to interoperate with legacy binaries that
> > > > > > do not sign or authenticate pointers.
> > > > > >
> > > > > > The idea is that a dynamic loader or early startup code would issue
> > > > > > this prctl very early after establishing that a process may load legacy
> > > > > > binaries, but before executing any PAC instructions.
> > > > >
> > > > > I thought that the silicon did not support this?
> > 
> > I think the past discussion we had was around enabling PAC for kernel
> > while disabling it for user. The hardware doesn't give us separate bits,
> > so Peter's patch toggles them on kernel entry/return, with some overhead
> > given by the MSR+ISB (to be added).
> 
> ah ok. i probably incorrectly thought that toggling that sys
> register bit is too much overhead at kernel entry so assumed
> we cannot have PAC off by default or set per process.

I think Peter can rerun his benchmarks but with the ISB added after MSR.
If they are not too bad, we can take this series.

> (i think with the proposed prctl it's possible to disable PAC
> at early ld.so startup and reenable it before calling into the
> main exe entry code, if we ever need to disable PAC-RET.)
> 
> i assume thread creation/fork inherits the setting but exec
> does not (this is another point that may be worth adding to
> the documentation).

Yes, that's my understanding from the patch. It should be documented
explicitly (I haven't read the doc updates, maybe it does this already).

> if we run into issues in userspace with PAC then a prctl that
> can be inherited across exec is a possible workaround (so PAC
> can be disabled for an entire process tree).

Can you do something similar to MTE with an environment variable forcing
PAC off?

-- 
Catalin
