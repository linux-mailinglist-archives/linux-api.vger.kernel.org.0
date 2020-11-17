Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211062B6F5C
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 20:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgKQTwK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 14:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgKQTwK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 14:52:10 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6277C0613CF
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 11:52:08 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id s8so20070908yba.13
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 11:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDZcGdePgVeYpDLaIyI2peZ4cyjzvIaXM4ViqIRHJNE=;
        b=KrCEoS6QAHTZJGHplCr234tl2qUmnC3s1s2MV0ZkbWZWe7y/n22RqaERf2CmCLxHLl
         la27bFgpBhu8BTcBnDJZOiMkKirOfUPRPneUrKXKXvEntV3J0ueHTxmdlTyAMRr4CBNO
         1RooHX6ipPq81M4hBYcOvf8SI39RhGHylcKeQ7GXGfN/2m2kVn5Gu0NHjMVOkD4HLZBy
         ZHgKfZWgVIYZBbiJd7MDu9fsw2a9NtbxXLqdjx0ZXe3NYBba5KsAFBhEQHZvlvjsS62E
         SU0eL8G+8jF8m+D7NLNegtOihSShz3LsDLr6vOfdSkvN6IP7DSrFAkY0DpWt1u2UAr3X
         BTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDZcGdePgVeYpDLaIyI2peZ4cyjzvIaXM4ViqIRHJNE=;
        b=KkzeG9lICgdzhwvlZZt9UG4IbUxtqn15pvq106BD7ZGyt7XwwJ5NOFVOloAzMMBasD
         jpo8NsQp67QHxqxhOjdomegtBE0dJO6ZqOqOUfNAwpZbDkIVAUnsCsImhlnfMUqpF8Ob
         eUHq9uMsj0yNB1lqBtqwYL4l2Tt0btPdMvBVCAn39bvQAwL4QP/szcx+GctDhXz67R+E
         f8EBuKxQcZZ8kubhtZYqkvM12alABLxyYBbdizaRTlT4Xluo4wl0DI6uV+usVtjAnGCC
         xZnsznFrlK5aAFHd7d6n54oeK6A/itDOHtebroSQNwVFKG0JWWoBx++uwR23OsAulWmu
         hvoQ==
X-Gm-Message-State: AOAM532bheMCZOYSAdtZDa5Wvb1163PeIYzG9WhRt2zizK/Bi3dpl5Qc
        u5lp16HKLuR8V9+awIuQXb4QC67lySpqOP/XLBnxrw==
X-Google-Smtp-Source: ABdhPJxICsH16CsHdngQfRe3UGP0Sc2/J3+hitRWDf06m/oxrG+A/v4rxAHu5jT0sCHS4dDvksgqFZzaFMLaKQf8aI0=
X-Received: by 2002:a25:a43:: with SMTP id 64mr2129383ybk.499.1605642727601;
 Tue, 17 Nov 2020 11:52:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605582887.git.pcc@google.com> <f296f270d97a4fbf496e1015461566407d02152f.1605582887.git.pcc@google.com>
 <87mtzgcdb7.fsf@x220.int.ebiederm.org>
In-Reply-To: <87mtzgcdb7.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 17 Nov 2020 11:51:56 -0800
Message-ID: <CAMn1gO4+nrwNGPqtAr6gPg=zMQ+kCH-e1YWqCz1kZgS6kHZXkA@mail.gmail.com>
Subject: Re: [PATCH v17 3/3] arm64: expose FAR_EL1 tag bits in siginfo
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

On Tue, Nov 17, 2020 at 5:40 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 8f34819e80de..16be62e6d341 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1650,6 +1650,15 @@ void force_sigsegv(int sig)
> >       force_sig(SIGSEGV);
> >  }
> >
> > +static void __user *get_si_addr(void __user *addr, unsigned long sig,
> > +                             unsigned long si_code)
> > +{
> > +     if (current->sighand->action[sig - 1].sa.sa_flags & SA_EXPOSE_TAGBITS)
> > +             return addr;
>
> Apologies for not seeing this before but this part of the patch is
> buggy.
>
> It is using current->sighand->action when the destination task may not
> be current.  send_sig_fault and send_sig_mcerr may somewhat legitimately
> be used to send faults to other processes.
>
> Now that I think about it there are interactions with
> PTRACE_GETSIGINFO/PTRACE_SETSIGINFO.
>
> Can we move the masking into get_signal after the ptrace handling?
>
> That way everything in the core of the kernel deals with unmasked
> si_addr values and we only mask the address just before sending it to
> userspace?

Makes sense, done in v18.

Peter
