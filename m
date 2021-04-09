Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD07C35A821
	for <lists+linux-api@lfdr.de>; Fri,  9 Apr 2021 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhDIUxS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Apr 2021 16:53:18 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39606 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDIUxQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Apr 2021 16:53:16 -0400
Received: by mail-ed1-f48.google.com with SMTP id g17so7302148edm.6;
        Fri, 09 Apr 2021 13:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVVvekJcw/qutLmuIXgXFcn3GNTWVwIRza5epNRIOXU=;
        b=tUfFfbTCoebpjaB8Nyr0/sbK8r97YK722W2KFEeB1gMTTfbk3QQSjup+64nHylY7UI
         MPrKxXoCcs+cRcWlOQZx3/SrTVlf5UnDwBl1PECu4ujLp8+Sg+Ilxx/r2lGJan3YiOEP
         19CGuVZsnzqgk9MMpbqhL8Z08ZIfIpnLSqOHGcYkZ5m+a99rDuvmxGQcMUQnpo/5HD78
         /NQoT8ygsL4SRpNEsZpU825qJjfTE6MFWqC48INgIkazZjKn28iCJzGRjy2cPdmdS68v
         j5uNEF6wlxYEt4qztvOfMqnNkwBjCSz3mZHw44ol6vcbioIV++r9id7/e5wpOJefh7eJ
         JkxQ==
X-Gm-Message-State: AOAM5316pANPYRfK1rCFc4ZentgN3OJksO2+33Q2isSn+XSrdY1fQERo
        BxW552TaQBV5EIu192ocsugs8KHz3FEzEg4O5fU=
X-Google-Smtp-Source: ABdhPJyQszy6COXyLAFUPtL7QC/F1gSDc3ZM8xKLorbpSgnCQ1S+fABV2MJ/wgD7HF1DySoQrJ65mDvaWiQ4n0p71/4=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr19229111edc.94.1618001582078;
 Fri, 09 Apr 2021 13:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net> <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
 <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com>
In-Reply-To: <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 9 Apr 2021 16:52:50 -0400
Message-ID: <CAJvTdKkDUywOUxb8Toth-7d4U4_S_9_EYHO38XqAPKc2_MXtdA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 31, 2021 at 6:45 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Mar 31, 2021 at 3:28 PM Len Brown <lenb@kernel.org> wrote:
>
> > We added compiler annotation for user-level interrupt handlers.
> > I'm not aware of it failing, or otherwise being confused.
>
> I followed your link and found nothing. Can you elaborate?  In the
> kernel, we have noinstr, and gcc gives approximately no help toward
> catching problems.

A search for the word "interrupt" on this page
https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html#x86-Function-Attributes
comes to the description of this attribute:

__attribute__ ((interrupt))

> > dynamic XCR0 breaks the installed base, I thought we had established that.
>
> I don't think this is at all established.  If some code thinks it
> knows the uncompacted XSTATE size and XCR0 changes, it crashes.  This
> is not necessarily a showstopper.

My working assumption is that crashing applications actually *is* a showstopper.
Please clarify.

> > We've also established that when running in a VMM, every update to
> > XCR0 causes a VMEXIT.
>
> This is true, it sucks, and Intel could fix it going forward.

What hardware fix do you suggest?
If a guest is permitted to set XCR0 bits without notifying the VMM,
what happens when it sets bits that the VMM doesn't know about?

> > I thought the goal was to allow new programs to have fast signal handlers.
> > By default, those fast signal handlers would have a stable state
> > image, and would
> > not inherit large architectural state on their stacks, and could thus
> > have minimal overhead on all hardware.
>
> That is *a* goal, but not necessarily the only goal.

I fully support coming up with a scheme for fast future-proof signal handlers,
and I'm willing to back that up by putting work into it.

I don't see any other goals articulated in this thread.

thanks,
Len Brown, Intel Open Source Technology Center
