Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3C2B8313
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 18:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgKRRTw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 12:19:52 -0500
Received: from foss.arm.com ([217.140.110.172]:60164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgKRRTv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Nov 2020 12:19:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 256E31534;
        Wed, 18 Nov 2020 09:19:51 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81EAC3F718;
        Wed, 18 Nov 2020 09:19:49 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:19:45 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Collingbourne <pcc@google.com>, libc-alpha@sourceware.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-api@vger.kernel.org, Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201118171945.GG6882@arm.com>
References: <20201014055106.25164-1-pcc@google.com>
 <87blfv6fj3.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blfv6fj3.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 17, 2020 at 06:48:16PM +0100, Florian Weimer wrote:
> * Peter Collingbourne:
> 
> > This prctl allows the user program to control which PAC keys are enabled
> > in a particular task. The main reason why this is useful is to enable a
> > userspace ABI that uses PAC to sign and authenticate function pointers
> > and other pointers exposed outside of the function, while still allowing
> > binaries conforming to the ABI to interoperate with legacy binaries that
> > do not sign or authenticate pointers.
> >
> > The idea is that a dynamic loader or early startup code would issue
> > this prctl very early after establishing that a process may load legacy
> > binaries, but before executing any PAC instructions.
> 
> I thought that the silicon did not support this?
> 
> What exactly does this switch on and off?  The signing itself (so that
> the bits are zero again), or just the verification?
> 
> I do not know how easy it will be to adjust the glibc dynamic linker
> to this because I expect it to use PAC instructions itself.  (It is an
> interesting target, I suppose, so this makes sense to me.)  The loader
> code used for initial process setup and later dlopen is the same.
> Worst case, we could compile the loader twice.

I don't think this would matter if only the B key is turned on and off,
since the compiler and libc should only be using the A key (or no key at
all) when built standard compiler options.

IIUC the default compiler options when using PAC will only use the
A key, and only use the PAC instructions that execute as NOPs when the
affected key is disabled (precisely so that the code still runs on non-
PAC supporting hardware).  But you can't simply flip it on and off while
there are function frames on the stack that assume it's either on or off.


However, the kernel interface should not assume any particular userspace
environment, so the controls offered should be general.  There are
plenty of other prctl()s (as well as regular syscalls) that will confuse
or break glibc; this is not really any different.

[...]

Cheers
---Dave
