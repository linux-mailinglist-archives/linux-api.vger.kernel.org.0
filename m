Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF641BABB
	for <lists+linux-api@lfdr.de>; Wed, 29 Sep 2021 01:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbhI1XJd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Sep 2021 19:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbhI1XJd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Sep 2021 19:09:33 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E176FC061745
        for <linux-api@vger.kernel.org>; Tue, 28 Sep 2021 16:07:52 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l19so801939vst.7
        for <linux-api@vger.kernel.org>; Tue, 28 Sep 2021 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pV/RLfvRzK8q/gUtLZsELt7IyUWHOS3sVaOuLJN3sNE=;
        b=O20w0uzWDkc+NN/Io88o7/x2bA1G7w3+E434p+32tPHymYrRSZz8DT0msfzzgRq0eL
         x/zKX694FbLGAx8XXo0/FI6fPLDZlTGcof/rL99dGC9SCK38ROTpkd4GSCV+HKIGHAIp
         dViUcdU/ckEScLMDQGJFxEbqF4DF+bsx73c96udgXu+G+WVKz3slIaHExM3guA/hH/C9
         7GJ7MV4XnWP3eaA2DhzUpBE2NHTDnUZU/9cNx1s0hNz7IJ02riFeJbF8h6X4nm+fiQ2o
         6GpAog513OdNOaNh2dJxRk14gxsMzMHoNfZzdXY6knDvTvHfoyo/zCh6OCSILBNtoxXd
         qKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pV/RLfvRzK8q/gUtLZsELt7IyUWHOS3sVaOuLJN3sNE=;
        b=qlQsqP9KQ6KrNJdJCKES8w+j/NzqCYVGqjrDebuHKGFdVK1zB3dkrvmqRvlfL3RpdN
         6e7eu1m18ylaOzJk6Nj3mM3KREFsG4pNaUAGlacBUPhfsRZQ0nF/gRJ1ZWloqpw7ylKw
         IyeXm1v1YiDTXdkU/OikTNpyfRZ92zlXX9KWa5YjhVR3WnYrYNOulF6iRlD0MnRL7+NH
         7zQOmEzvGDYdzDZRjIOj165bYb2U4Ygyr66IuIpyAGukJ82btZnN8CTKJmqKye/AaiVl
         +CDkd/0ANeR2vbWTw4ls4uE2JBkHo0hRcYrGHCaI/aISKACTcuzg2uiyc15YVXpfHqzr
         wGDg==
X-Gm-Message-State: AOAM530mXnY71VCs2qc0YRpwyByXy888ugVC8Ups+DNDcHO8QM54btpK
        jlu2RpIaN1xGAFrIC37Cp51Vf3FMWjAdIN7RWmLZYQ==
X-Google-Smtp-Source: ABdhPJxapIlh0hPb7iYYOx3Qgh8/4pYRGcsRbkLDMi1bbPEXE52O8mK9LNVTEqpjpOQqQn7N/x/U+FNQrRYYSS+FkHw=
X-Received: by 2002:a67:cd8b:: with SMTP id r11mr8319444vsl.16.1632870471995;
 Tue, 28 Sep 2021 16:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210917180323.278250-1-posk@google.com> <20210917180323.278250-3-posk@google.com>
 <87ilyk9xc0.ffs@tglx>
In-Reply-To: <87ilyk9xc0.ffs@tglx>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 28 Sep 2021 16:07:41 -0700
Message-ID: <CAFTs51UW4JEP6QTHsf02-sDFiu7_JtwqMQE=qDSUy0F1Np9e2Q@mail.gmail.com>
Subject: Re: [PATCH 2/5 v0.6] sched/umcg: RFC: add userspace atomic helpers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks for the review, Thomas!

I'll work on a patch(set) to put this stuff into mm/ somewhere. Let's
see how quickly that can happen...

Thanks,
Peter

On Tue, Sep 28, 2021 at 2:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter,
>
> On Fri, Sep 17 2021 at 11:03, Peter Oskolkov wrote:
>
> > Add helper functions to work atomically with userspace 32/64 bit values -
> > there are some .*futex.* named helpers, but they are not exactly
> > what is needed for UMCG; I haven't found what else I could use, so I
> > rolled these.
> >
> > At the moment only X86_64 is supported.
> >
> > Note: the helpers should probably go into arch/ somewhere; I have
> > them in kernel/sched/umcg_uaccess.h temporarily for convenience. Please
> > let me know where I should put them.
>
> Again: This does not qualify as a changelog, really.
>
> That aside, you already noticed that there are futex helpers. Your
> reasoning that they can't be reused is only partially correct.
>
> What you named __try_cmpxchg_user_32() is pretty much a verbatim copy of
> X86 futex_atomic_cmpxchg_inatomic(). The only difference is that you placed
> the uaccess_begin()/end() into the inline.
>
> Not going anywhere. You have the bad luck to have the second use case
> for such an infrastucture and therefore you have the honours of mopping
> it up by making it a generic facility which replaces the futex specific
> variant.
>
> Also some of the other instances are just a remix of the futex_op()
> mechanics so your argument is even more weak.
>
> > +static inline int fix_pagefault(unsigned long uaddr, bool write_fault, int bytes)
> > +{
> > +     struct mm_struct *mm = current->mm;
> > +     int ret;
> > +
> > +     /* Validate proper alignment. */
> > +     if (uaddr % bytes)
> > +             return -EINVAL;
>
> Why do you want to make this check _after_ the page fault? Checks
> on user supplied pointers have to be done _before_ trying to access
> them.
>
> > +
> > +     if (mmap_read_lock_killable(mm))
> > +             return -EINTR;
> > +     ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
> > +                     NULL);
> > +     mmap_read_unlock(mm);
> > +
> > +     return ret < 0 ? ret : 0;
> > +}
>
> There is no point in making this inline. Fault handling is not a hotpath
> by any means.
>
> Aside of that it's pretty much what futex.c::fault_in_user_writeable()
> does. So it's pretty obvious to factor this out in the first step into
> mm/gup.c or whatever place the mm people fancy and make the futex code
> use it.
>
> > +/**
> > + * cmpxchg_32_user_nosleep - compare_exchange 32-bit values
> > + *
> > + * Return:
> > + * 0 - OK
> > + * -EFAULT: memory access error
> > + * -EAGAIN: @expected did not match; consult @prev
> > + */
> > +static inline int cmpxchg_user_32_nosleep(u32 __user *uaddr, u32 *old, u32 new)
> > +{
> > +     int ret = -EFAULT;
> > +     u32 __old = *old;
> > +
> > +     if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> > +             return -EFAULT;
> > +
> > +     pagefault_disable();
> > +
> > +     __uaccess_begin_nospec();
>
> Why exactly do you need _nospec() here? Just to make sure that this code
> is x86 only or just because you happened to copy a x86 implementation
> which uses these nospec() variants?
>
> Again, 90% of this is generic and not at all x86 specific and this
> nospec() thing is very well hidden in the architecture code for a good
> reason while
>
>        if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
>                 return -EFAULT;
>
>         pagefault_disable();
>         ret = user_op(.....);
>         pagefault_enable();
>
> is completely generic and does not have any x86 or other architecture
> dependency in it.
>
> > +     ret = __try_cmpxchg_user_32(old, uaddr, __old, new);
> > +     user_access_end();
> > +
> > +     if (!ret)
> > +             ret =  *old == __old ? 0 : -EAGAIN;
> > +
> > +     pagefault_enable();
> > +     return ret;
> > +}
>
> Aside of that this should go into mm/maccess.c or some other reasonable
> place where people can find it along with other properly named
> _nofault() helpers.
>
> Nothing except the ASM wrappers is architecture specific here. So 90% of
> this can be made generic infrastructure as out of line library code.
>
> And yes, I mean out of line library code unless you can come up with a
> compelling reason backed by actual numbers why this has to be inlined.
>
> May I recommend to read this for inspiration:
>
>   https://lore.kernel.org/lkml/alpine.LFD.2.00.1001251002430.3574@localhost.localdomain/
>
> Thanks,
>
>         tglx
