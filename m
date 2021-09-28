Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC841B9B4
	for <lists+linux-api@lfdr.de>; Tue, 28 Sep 2021 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbhI1WAF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Sep 2021 18:00:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbhI1WAE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Sep 2021 18:00:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632866303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XR+T+4Yz7vkyWVX7zGt6efMFvlpokGhPisZF/3hhTbs=;
        b=0X9eMmEL8b2e7Q0egDdfX+psnLY1wdt5LR2yJPPo5OtUnDYUHSsCV0HDjuCWh6/wvsPZrC
        iGJKf47i+P0dd9x/OzAnnLRLiI9i6/zMW5FNi4qzpH7Q5DYO//LUhO7CVtGsItKHCQAbNS
        RhI6+AQTjJ63GscJchjsn9ZcO+vV8MVxQbfU7l3u75VlbukEPBNkCMZNAq+a7KixU9tKdD
        L8gTWKgoBPJAukhj6BpO9xDirbVGGiP9B7yXrmS5ogCevyVSvkwLPVKyP6Z1URHMULs5b/
        xd5T1LHGRvMc+XOpIQCxom1D0E1/ueSFu7jarQzr1fhw2QkgG0/gdJYGsors/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632866303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XR+T+4Yz7vkyWVX7zGt6efMFvlpokGhPisZF/3hhTbs=;
        b=BUMSEcsCZcgPUpZ8rPOVtXlYqrcbr7K15XgcQPCvyHw0jA7unvoMIQzrmiiA8hrwCqqh+j
        QgdVh/ABQHREPKCQ==
To:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5 v0.6] sched/umcg: RFC: add userspace atomic helpers
In-Reply-To: <20210917180323.278250-3-posk@google.com>
References: <20210917180323.278250-1-posk@google.com>
 <20210917180323.278250-3-posk@google.com>
Date:   Tue, 28 Sep 2021 23:58:23 +0200
Message-ID: <87ilyk9xc0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter,

On Fri, Sep 17 2021 at 11:03, Peter Oskolkov wrote:

> Add helper functions to work atomically with userspace 32/64 bit values -
> there are some .*futex.* named helpers, but they are not exactly
> what is needed for UMCG; I haven't found what else I could use, so I
> rolled these.
>
> At the moment only X86_64 is supported.
>
> Note: the helpers should probably go into arch/ somewhere; I have
> them in kernel/sched/umcg_uaccess.h temporarily for convenience. Please
> let me know where I should put them.

Again: This does not qualify as a changelog, really.

That aside, you already noticed that there are futex helpers. Your
reasoning that they can't be reused is only partially correct.

What you named __try_cmpxchg_user_32() is pretty much a verbatim copy of
X86 futex_atomic_cmpxchg_inatomic(). The only difference is that you placed
the uaccess_begin()/end() into the inline.

Not going anywhere. You have the bad luck to have the second use case
for such an infrastucture and therefore you have the honours of mopping
it up by making it a generic facility which replaces the futex specific
variant.

Also some of the other instances are just a remix of the futex_op()
mechanics so your argument is even more weak.

> +static inline int fix_pagefault(unsigned long uaddr, bool write_fault, int bytes)
> +{
> +	struct mm_struct *mm = current->mm;
> +	int ret;
> +
> +	/* Validate proper alignment. */
> +	if (uaddr % bytes)
> +		return -EINVAL;

Why do you want to make this check _after_ the page fault? Checks
on user supplied pointers have to be done _before_ trying to access
them.

> +
> +	if (mmap_read_lock_killable(mm))
> +		return -EINTR;
> +	ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
> +			NULL);
> +	mmap_read_unlock(mm);
> +
> +	return ret < 0 ? ret : 0;
> +}

There is no point in making this inline. Fault handling is not a hotpath
by any means.

Aside of that it's pretty much what futex.c::fault_in_user_writeable()
does. So it's pretty obvious to factor this out in the first step into
mm/gup.c or whatever place the mm people fancy and make the futex code
use it.

> +/**
> + * cmpxchg_32_user_nosleep - compare_exchange 32-bit values
> + *
> + * Return:
> + * 0 - OK
> + * -EFAULT: memory access error
> + * -EAGAIN: @expected did not match; consult @prev
> + */
> +static inline int cmpxchg_user_32_nosleep(u32 __user *uaddr, u32 *old, u32 new)
> +{
> +	int ret = -EFAULT;
> +	u32 __old = *old;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	__uaccess_begin_nospec();

Why exactly do you need _nospec() here? Just to make sure that this code
is x86 only or just because you happened to copy a x86 implementation
which uses these nospec() variants?

Again, 90% of this is generic and not at all x86 specific and this
nospec() thing is very well hidden in the architecture code for a good
reason while

       if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
		return -EFAULT;

	pagefault_disable();
        ret = user_op(.....);
	pagefault_enable();
        
is completely generic and does not have any x86 or other architecture
dependency in it.

> +	ret = __try_cmpxchg_user_32(old, uaddr, __old, new);
> +	user_access_end();
> +
> +	if (!ret)
> +		ret =  *old == __old ? 0 : -EAGAIN;
> +
> +	pagefault_enable();
> +	return ret;
> +}

Aside of that this should go into mm/maccess.c or some other reasonable
place where people can find it along with other properly named
_nofault() helpers.

Nothing except the ASM wrappers is architecture specific here. So 90% of
this can be made generic infrastructure as out of line library code.

And yes, I mean out of line library code unless you can come up with a
compelling reason backed by actual numbers why this has to be inlined.

May I recommend to read this for inspiration:

  https://lore.kernel.org/lkml/alpine.LFD.2.00.1001251002430.3574@localhost.localdomain/

Thanks,

        tglx
