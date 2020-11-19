Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0BB2B9B3B
	for <lists+linux-api@lfdr.de>; Thu, 19 Nov 2020 20:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgKSTJp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Nov 2020 14:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgKSTJo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Nov 2020 14:09:44 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94561C0613CF
        for <linux-api@vger.kernel.org>; Thu, 19 Nov 2020 11:09:44 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id z14so6322837ilp.11
        for <linux-api@vger.kernel.org>; Thu, 19 Nov 2020 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHFByHnrdkzvdTBVAGaWiV1Mo3tWTaGpbgo/J8n5inw=;
        b=oSJQ0U8VkEBvgz/jq0WSa0KWbF5YSxCEn2TWNsYeVYg8/ECi+WsOaawOl6qR4jj193
         OTVzddYWla/0lerRNmPDyVcgqG/dOjvPRqRMatF3gWla3NEj6oGhUCAvdNvTgY6V9kDk
         WOCu6Vt8vit2jn7mtuZi/psER5jbbTxmkKEanubUd8InjJeTotw2S9s/6q4PZfvXac5n
         ZSLUElI36BTQMDq8LArnX9sur/agcfvEmTBGqt2ifV0OXZaNhXVvmiXLXr4a0j0zInS6
         O7WtR3YSrIthiZ++LDDNYzv0MbJ+ln3yWIdmi1OYj9wNu1TF8b4U/PkqYHBq2Qp46Jiu
         Lt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHFByHnrdkzvdTBVAGaWiV1Mo3tWTaGpbgo/J8n5inw=;
        b=PTBOSgdtl1EQTdAZtAVxmnq/zBR5R2CaTaBp8ecl6vTxppwc4oSKCS/eN82iI8s/zt
         ZJADHRLM1JykUopGVeNoSiegmJlX1ofCI2wHOUgP8dv+GcmwTk8yKe5RSYVYV5DsLtFC
         Ydhe+c3FGUa8EOK8EEIvng88kvDsHBVVfsy7YN4uK7Bar5wc3Ie96SHg81Ds0vtMBViE
         YUQWm++C723dIYUUysYACM21OXcQyj4Yjy/tIejLcSAIz3jkYZDuRD1YC+xhnkzwcNuL
         psKlUZJebZg0MkHkStwXEO7LpMcLoNq0JwKk+vv3ETIaxBDEdVdhme1Ak6bY9zbrHctG
         5RGQ==
X-Gm-Message-State: AOAM532aFIjo2dzmP/tqVcjOm/5M+4JQwHrpdHm/iNP0n2+KQyM5QCtE
        eCljFnin1hxxPJlMZwSDH+Tc/BzgrtMH/02X+LxQSQ==
X-Google-Smtp-Source: ABdhPJyjjFhFXHwFgku/GTvNXbm/c5iCYBKlUyA6TQrWT6WyA1iTN9eWzAhzZbekHo4VnIVwU3wcifhGq/hvixPDzGs=
X-Received: by 2002:a92:8b12:: with SMTP id i18mr20852661ild.278.1605812983759;
 Thu, 19 Nov 2020 11:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118003853.926143-1-pcc@google.com> <87d0095w7c.fsf@x220.int.ebiederm.org>
In-Reply-To: <87d0095w7c.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 19 Nov 2020 11:09:32 -0800
Message-ID: <CAMn1gO78omRSdRA-xO51C52ohhLMrpQkkhH_hk+BcTYT5482=w@mail.gmail.com>
Subject: Re: [PATCH v19] arm64: expose FAR_EL1 tag bits in siginfo
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

On Thu, Nov 19, 2020 at 5:10 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 8f34819e80de..678cdeb235ae 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2524,6 +2524,26 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
> >       return signr;
> >  }
> >
> > +static void hide_si_addr_tag_bits(struct ksignal *ksig)
> > +{
> > +     switch (siginfo_layout(ksig->sig, ksig->info.si_code)) {
> > +     case SIL_FAULT:
> > +     case SIL_FAULT_MCEERR:
> > +     case SIL_FAULT_BNDERR:
> > +     case SIL_FAULT_PKUERR:
> > +             ksig->info.si_addr = arch_untagged_si_addr(
> > +                     ksig->info.si_addr, ksig->sig, ksig->info.si_code);
> > +             break;
> > +     case SIL_KILL:
> > +     case SIL_TIMER:
> > +     case SIL_POLL:
> > +     case SIL_CHLD:
> > +     case SIL_RT:
> > +     case SIL_SYS:
> > +             break;
> > +     }
> > +}
> > +
> >  bool get_signal(struct ksignal *ksig)
> >  {
> >       struct sighand_struct *sighand = current->sighand;
> > @@ -2761,6 +2781,10 @@ bool get_signal(struct ksignal *ksig)
> >       spin_unlock_irq(&sighand->siglock);
> >
> >       ksig->sig = signr;
> > +
> > +     if (!(sighand->action[signr - 1].sa.sa_flags & SA_EXPOSE_TAGBITS))
> > +             hide_si_addr_tag_bits(ksig);
> > +
> >       return ksig->sig > 0;
> >  }
>
> Ok.  Seeing that this code compiles out I don't have any concerns about
> it's impact on other architectures.  And I like having it always
> present as that makes all of the concerns the code has to deal with
> easier to discover.

Ack.

> There is one small issue.  The test should be:
>         if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
>                 hide_si_addr_tag_bits(ksig);
>
> Outside of sighand->siglock it is racy to access sighand->action and we
> already have an atomic snapshot of the values for exactly this reason.
>
> Is there some reason you didn't use ksig->ka?  Am I missing something?

No, I missed that we were copying the sigaction for this reason. I've
changed the code to use the copy as suggested in v20.

> I agree that our consumption of SA bits is slow enough that my other
> concerns are a non-issue.

Ack.

Peter
