Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9960A2A6B96
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgKDRY4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 12:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgKDRY4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Nov 2020 12:24:56 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391AD20781;
        Wed,  4 Nov 2020 17:24:50 +0000 (UTC)
Date:   Wed, 4 Nov 2020 17:24:48 +0000
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
Subject: Re: [PATCH v13 1/8] parisc: Drop parisc special case for
 __sighandler_t
Message-ID: <20201104172447.GF28902@gaia>
References: <cover.1604376407.git.pcc@google.com>
 <7e26600459cb08c5016611b37fe88c23098b40eb.1604376407.git.pcc@google.com>
 <87a6vx6p11.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6vx6p11.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 04, 2020 at 10:54:34AM -0600, Eric W. Biederman wrote:
> Peter Collingbourne <pcc@google.com> writes:
> > From: Helge Deller <deller@gmx.de>
> >
> > I believe we can and *should* drop this parisc-specific typedef for
> > __sighandler_t when compiling a 64-bit kernel. The reasons:
> >
> > 1. We don't have a 64-bit userspace yet, so nothing (on userspace side)
> > can break.
> >
> > 2. Inside the Linux kernel, this is only used in kernel/signal.c, in
> > function kernel_sigaction() where the signal handler is compared against
> > SIG_IGN.  SIG_IGN is defined as (__sighandler_t)1), so only the pointers
> > are compared.
> >
> > 3. Even when a 64-bit userspace gets added at some point, I think
> > __sighandler_t should be defined what it is: a function pointer struct.
> >
> > I compiled kernel/signal.c with and without the patch, and the produced code
> > is identical in both cases.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Reviewed-by: Peter Collingbourne <pcc@google.com>
> > Link:
> > https://linux-review.googlesource.com/id/I21c43f21b264f339e3aa395626af838646f62d97
> 
> Peter as you have sent this, this also needs your Signed-off-by.
> 
> Otherwise this looks reasonable to me.
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> While the final bits look like they are still under discussion it looks
> like the preceding cleanups are pretty solid at this point.

Minor nits, unless you nak the whole approach of SA_FAULTFLAGS and
SA_UNSUPPORTED ;) (it looks a bit complicated to me but I don't have a
better idea for a generic implementation).

> Any chance we can get the cleanups into a tree in linux-next so that
> the discussion can focus on the core parts of this work?
> 
> Perhaps I should pick up the clenaups?

However you prefer (I usually start queuing patches at -rc3). If you
pick them up, please provide a stable branch somewhere so that we can
add the others on top.

Thanks.

-- 
Catalin
