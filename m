Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485CA2C5C17
	for <lists+linux-api@lfdr.de>; Thu, 26 Nov 2020 19:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391715AbgKZSnq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Nov 2020 13:43:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391551AbgKZSnq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Nov 2020 13:43:46 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E21D121D1A;
        Thu, 26 Nov 2020 18:43:43 +0000 (UTC)
Date:   Thu, 26 Nov 2020 18:43:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201126184341.GC6722@gaia>
References: <20201119052011.3307433-1-pcc@google.com>
 <20201119180754.GM6882@arm.com>
 <CAMn1gO7CyxQZi5aZ5Q8qRv2DVSjSH_ts=wrUHS3XLhnhLktJGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO7CyxQZi5aZ5Q8qRv2DVSjSH_ts=wrUHS3XLhnhLktJGA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 19, 2020 at 07:30:08PM -0800, Peter Collingbourne wrote:
> On Thu, Nov 19, 2020 at 10:08 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > On Wed, Nov 18, 2020 at 09:20:11PM -0800, Peter Collingbourne wrote:
> > > +void mte_thread_init_user(void)
> > >  {
> > >       if (!system_supports_mte())
> > >               return;
> > > @@ -121,7 +101,8 @@ void flush_mte_state(void)
> > >       write_sysreg_s(0, SYS_TFSRE0_EL1);
> > >       clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> > >       /* disable tag checking */
> > > -     set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);
> > > +     set_task_sctlr_el1((current->thread.sctlr_user & ~SCTLR_EL1_TCF0_MASK) |
> > > +                        SCTLR_EL1_TCF0_NONE);
> >
> > This (and the corresponding ptrauth init code) feels fragile.
> >
> > We modify some random bits in bits of code that aren't next to each
> > other, and hope that they add up to the complete set of bits that are
> > under user control.
> >
> > Can we add code to purge thread->sctlr_el1 to 0 before making these
> > modifications or (perhaps simpler) just set it to a constant mask of the
> > wanted bits?
> >
> > Failing that, can we at least move the relevant bits of code next to
> > each other?
> 
> That's basically the way I had things in v2 with init_sctlr. I agree
> this is a bit fragile but it's how Catalin wanted it. To be honest I
> slightly prefer the way the code was originally so maybe if it's 2
> against 1 we could go back to the original approach.

The idea of init_sctlr as in v2 doesn't work that well since some bits
may be toggled later via the cpufeature framework as secondary CPUs come
up. We could update the final value as we finalise the CPU features,
though I thought it's simpler if we keep this for the user-specific bits
only. You'd need a mask anyway, unless you also maintain a master copy
of the sctlr_el1 value for the kernel.

-- 
Catalin
