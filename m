Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1992BB283
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 19:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKTSXA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 13:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgKTSW7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 13:22:59 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F81C0613CF
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 10:22:59 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id s10so10909859ioe.1
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCfFuYZZlWB5ExQQOfzBtfdRwBOthQXJS/5Cge7iPXk=;
        b=pfP2jn/oy3/1fDKh7vHx3fYxYDEhIpZHB3Xzte6UqPNSVYUpmgr5TY21x2dRyA+vFp
         vDSWNo5oM1ZwSvG88w57ZzPDqnJ9pX4KR00bPctzhRLbod5IFbRJbCLVgRYUFxjK2nKy
         5RixmBzUVA4WWOE+Mstlh8IQzYd8aRHo8AURvpWsFTm0EwS2B/X0d+k+T3KEku09rj2A
         yxOUmrlzR4XYBx+mqYC7O061eHwsjPhqrdNxi5yFD4Hn3Bt1QNcShvWsuYbZHqLT0Zkn
         qIx7k91EFvg9AgeQJU8RJzb//MUrZ0QjMgHkkp3IDz+5mGzSurCxhCcqYsPnmkBtcH8G
         aaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCfFuYZZlWB5ExQQOfzBtfdRwBOthQXJS/5Cge7iPXk=;
        b=iaAHuxlm+W5qQi1D7vRox2wdIBT/UAJ9Z5C6mv6USH6ekx76/LgPEOc4ukAM5kvRPc
         M3YgaLkjTKGC9gUxoSnR49yfNHtivtJfh1MTApqEoE+rDghyDNH6LpwXTCPb79qiCu0b
         diKlDntarmN251OaiwKnF/LD0xT7Y8LZzzzlO7Hc0/4s6W+QWSx6dI5m1+HJktlbskiN
         gRaClnVvz+e89+pcS6y/ZCZBl/YjDj/xGMB5gJ9WYGnviwUttD6aah36gfN5INDX4cyC
         rF+DDlfA4AvulmEkR48XDZ0eXFVZw18gOXgUoXrcNPaQwcpepG8LN/Tvezl769Kn+z9O
         vSLA==
X-Gm-Message-State: AOAM530t5N/2zT5c3JLGPBNOdM+fGWGC0XzB2+eL3CfuZx/r7LJ8NixC
        M69P8dj8eBdsAx6bFrPr1sOxRUkx/+c9t7x3Tquh1w==
X-Google-Smtp-Source: ABdhPJxqzpsD3gYJdukGH6Lrz7eaIkN75Zf3+OMCG+rDxjhD+LB04gOs2yVushEtp9Yu9A0W6bvv5OBn9fy9Dv+l2S8=
X-Received: by 2002:a5e:9706:: with SMTP id w6mr15442711ioj.132.1605896578494;
 Fri, 20 Nov 2020 10:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20201119190921.3589081-1-pcc@google.com> <87wnyf3ovs.fsf@x220.int.ebiederm.org>
In-Reply-To: <87wnyf3ovs.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 20 Nov 2020 10:22:47 -0800
Message-ID: <CAMn1gO6mzzpnYbKfn3gXAwX2tejD-g+2S_ShkyWVCLskFWSqvg@mail.gmail.com>
Subject: Re: [PATCH v20] arm64: expose FAR_EL1 tag bits in siginfo
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 20, 2020 at 9:44 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > the tag bits may be needed by tools in order to accurately diagnose
> > memory errors, such as HWASan [1] or future tools based on the Memory
> > Tagging Extension (MTE).
> >
> > We should not stop clearing these bits in the existing fault address
> > fields, because there may be existing userspace applications that are
> > expecting the tag bits to be cleared. Instead, introduce a flag in
> > sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
> > there if the signal handler has this flag set.
> >
> > [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
>
> For the generic bits:
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks for the review.

> Some of the arm bits look wrong.  There are a couple of cases where
> it looks like you are deliberately passing an untagged address into
> functions that normally take tagged addresses.
>
> It might be a good idea to have a type distinction between the two.
> Perhaps "(void __user *)" vs "(unsigned long)" so that accidentally
> using the wrong one generates a type error.
>
> I don't think I am really qualified to review all of the arm details,
> and I certainly don't want to be in the middle of any arm bugs this
> code might introduce.  If you will split out the generic bits of this
> patch I will take it.  The this whole thing can be merged into the arm

Okay, I'll do that.

> tree and you can ensure the arm bits are correct.

So you want Catalin to merge your signal-for-v5.11 branch with the
generic patches into the arm64 tree and then add the arm64-specific
patch on top? Works for me.

> Eric
>
>
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 1ee94002801f..c5375cb7763d 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -596,33 +596,35 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
> >       return 0;
> >  }
> >
> > -static int __kprobes do_translation_fault(unsigned long addr,
> > +static int __kprobes do_translation_fault(unsigned long far,
> >                                         unsigned int esr,
> >                                         struct pt_regs *regs)
> >  {
> > +     unsigned long addr = untagged_addr(far);
> > +
> >       if (is_ttbr0_addr(addr))
> > -             return do_page_fault(addr, esr, regs);
> > +             return do_page_fault(far, esr, regs);
> >
> > -     do_bad_area(addr, esr, regs);
> > +     do_bad_area(far, esr, regs);
> >       return 0;
> >  }
> >
> > -static int do_alignment_fault(unsigned long addr, unsigned int esr,
> > +static int do_alignment_fault(unsigned long far, unsigned int esr,
> >                             struct pt_regs *regs)
> >  {
> > -     do_bad_area(addr, esr, regs);
> > +     do_bad_area(far, esr, regs);
> >       return 0;
> >  }
> >
> > -static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> > +static int do_bad(unsigned long far, unsigned int esr, struct pt_regs *regs)
> >  {
> >       return 1; /* "fault" */
> >  }
> >
> > -static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> > +static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
> >  {
> >       const struct fault_info *inf;
> > -     void __user *siaddr;
> > +     unsigned long siaddr;
> >
> >       inf = esr_to_fault_info(esr);
> >
> > @@ -635,18 +637,23 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> >       }
> >
> >       if (esr & ESR_ELx_FnV)
> > -             siaddr = NULL;
> > +             siaddr = 0;
> >       else
> > -             siaddr  = (void __user *)addr;
> > +             siaddr  = untagged_addr(far);
> >       arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
> >
> What is going on in this function?
>
> Are you deliberately removing the tag bits?

Yes, this function handles synchronous external aborts, and the
architecture defines the tag bits as UNKNOWN for these types of
aborts. This is similar to the tag check fault case where bits 63:60
are UNKNOWN.

> >       return 0;
> >  }
> >
> > -static int do_tag_check_fault(unsigned long addr, unsigned int esr,
> > +static int do_tag_check_fault(unsigned long far, unsigned int esr,
> >                             struct pt_regs *regs)
> >  {
> > -     do_bad_area(addr, esr, regs);
> > +     /*
> > +      * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN for tag
> > +      * check faults. Mask them out now so that userspace doesn't see them.
> > +      */
> > +     far &= (1UL << 60) - 1;
> > +     do_bad_area(far, esr, regs);
> >       return 0;
> >  }
> >
> > @@ -717,11 +724,12 @@ static const struct fault_info fault_info[] = {
> >       { do_bad,               SIGKILL, SI_KERNEL,     "unknown 63"                    },
> >  };
> >
> > -void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> > +void do_mem_abort(unsigned long far, unsigned int esr, struct pt_regs *regs)
> >  {
> >       const struct fault_info *inf = esr_to_fault_info(esr);
> > +     unsigned long addr = untagged_addr(far);
> >
> > -     if (!inf->fn(addr, esr, regs))
> > +     if (!inf->fn(far, esr, regs))
> >               return;
> >
> >       if (!user_mode(regs)) {
> > @@ -730,8 +738,7 @@ void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> >               show_pte(addr);
> >       }
> >
> > -     arm64_notify_die(inf->name, regs,
> > -                      inf->sig, inf->code, (void __user *)addr, esr);
> > +     arm64_notify_die(inf->name, regs, inf->sig, inf->code, addr, esr);
>
> What is going on in this function?
>
> Are you deliberately removing the tag bits?

This part of the function handles the case where the type of the abort
is unrecognized. In this case we conservatively remove the tag bits
since they may have been defined as UNKNOWN.

Peter
