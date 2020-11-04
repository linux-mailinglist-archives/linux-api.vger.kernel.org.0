Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC712A6C4D
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgKDSAd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 13:00:33 -0500
Received: from foss.arm.com ([217.140.110.172]:41310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgKDSAd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Nov 2020 13:00:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6807A139F;
        Wed,  4 Nov 2020 10:00:32 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE643F718;
        Wed,  4 Nov 2020 10:00:30 -0800 (PST)
Date:   Wed, 4 Nov 2020 18:00:26 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v13 1/8] parisc: Drop parisc special case for
 __sighandler_t
Message-ID: <20201104180026.GF6882@arm.com>
References: <cover.1604376407.git.pcc@google.com>
 <7e26600459cb08c5016611b37fe88c23098b40eb.1604376407.git.pcc@google.com>
 <87a6vx6p11.fsf@x220.int.ebiederm.org>
 <20201104172447.GF28902@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104172447.GF28902@gaia>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 04, 2020 at 05:24:48PM +0000, Catalin Marinas wrote:
> On Wed, Nov 04, 2020 at 10:54:34AM -0600, Eric W. Biederman wrote:
> > Peter Collingbourne <pcc@google.com> writes:
> > > From: Helge Deller <deller@gmx.de>
> > >
> > > I believe we can and *should* drop this parisc-specific typedef for
> > > __sighandler_t when compiling a 64-bit kernel. The reasons:
> > >
> > > 1. We don't have a 64-bit userspace yet, so nothing (on userspace side)
> > > can break.
> > >
> > > 2. Inside the Linux kernel, this is only used in kernel/signal.c, in
> > > function kernel_sigaction() where the signal handler is compared against
> > > SIG_IGN.  SIG_IGN is defined as (__sighandler_t)1), so only the pointers
> > > are compared.
> > >
> > > 3. Even when a 64-bit userspace gets added at some point, I think
> > > __sighandler_t should be defined what it is: a function pointer struct.
> > >
> > > I compiled kernel/signal.c with and without the patch, and the produced code
> > > is identical in both cases.
> > >
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > Reviewed-by: Peter Collingbourne <pcc@google.com>
> > > Link:
> > > https://linux-review.googlesource.com/id/I21c43f21b264f339e3aa395626af838646f62d97
> > 
> > Peter as you have sent this, this also needs your Signed-off-by.
> > 
> > Otherwise this looks reasonable to me.
> > Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > 
> > While the final bits look like they are still under discussion it looks
> > like the preceding cleanups are pretty solid at this point.
> 
> Minor nits, unless you nak the whole approach of SA_FAULTFLAGS and
> SA_UNSUPPORTED ;) (it looks a bit complicated to me but I don't have a
> better idea for a generic implementation).

It is a bit complicated, but we didn't come up with anything better so
far that can cope with the various historical quirks in the signal API.

A bigger overhaul of the whole interface might be a good idea at some
point, but it would probably be a mistake to rush that.


It may be possible to make the SA_UNSUPPORTED stuff a bit more
digestible via libc.  I'll try to get a discussion started on that.

[...]

Cheers
---Dave
