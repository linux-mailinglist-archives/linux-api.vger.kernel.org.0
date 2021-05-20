Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CBA38B930
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 23:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhETVvI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 17:51:08 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:36513 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhETVvH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 17:51:07 -0400
Received: by mail-ej1-f42.google.com with SMTP id c20so27587251ejm.3;
        Thu, 20 May 2021 14:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYS+jyPXn/IZkXpqRRQGfz2nyMwZ8AwOrIg/GoY6f6k=;
        b=n38RkA1ZV1lYvZaDMa89FJGOVw+vCU/mZQ7xSGG3X9T5OyTBJBjAxF1cjMyzlYLVoX
         I+ocooJ6aDBBzG2SZmwcUNyZzoUNoAGSk4cLa9e0QuPn45bOp/UWUYKhf6wo/+QlDPDH
         lNHee982ihiieN1Fqjs4exbK05s657XXBgkBh4zsPuX4vBAt/zmVGCXZGDBvFQ90Z4oC
         XAZT7zFwD+Iv/tpnoYECJjTlQuAvs7lrguQqGmiFmWrqUCIHgJRAPfesiRkOjPZuZIO2
         Euujpgnav4UGa88AppZ6nWwtwFNSl0Igf2lMSvCf0IE2l8RmsnF5/om6LesubVvZ2g5S
         5uGA==
X-Gm-Message-State: AOAM533y4Nh6qklKqRm/t8aGul+3DksRwE/AN+6cpPkT/ucS1BpeR4E0
        OsLn2KydQ0u9q+HahDBJ6GPtiPDpkNie2k1Qt1Q=
X-Google-Smtp-Source: ABdhPJzsshM0w0yH5TT8of2ZM+vR9qHCD0DOiJ+QZ+08sPqmOuzJ2WGuRFQQxs5bxDdButcMlHpn8uuHqOBk7HcHqG4=
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr6858899ejz.501.1621547384808;
 Thu, 20 May 2021 14:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de> <CAJvTdK=DCdwc86VdCVsCH+et6aGuAE3hi-wKmE5769SA0g1H-Q@mail.gmail.com>
 <87h7ixaxs9.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87h7ixaxs9.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 20 May 2021 17:49:33 -0400
Message-ID: <CAJvTdKmC3dY3BZafPvh1M880kGAusViCAZNBQ3NoLvOQgWuuBA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 5:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Len,
>
> On Thu, May 20 2021 at 17:22, Len Brown wrote:
> > On Thu, May 20, 2021 at 4:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > AMX is analogous to the multiplier used by AVX-512.
> >> > The architectural state must exist on every CPU, including HT siblings.
> >> > Today, the HT siblings share the same execution unit,
> >> > and I have no reason to expect that will change.
> >>
> >> I'm well aware that HT siblings share the same execution unit for
> >> AVX.
> >>
> >> Though AMX is if I remember the discussions two years ago correctly
> >> shared by more than the HT siblings which makes things worse.
> >
> > I regret that we were unable to get together in the last year to have
> > an updated discussion.  I think if we had, then we would have saved
> > a lot of mis-understanding and a lot of email!
> >
> > So let me emphasize here:
> >
> > There is one TMUL execution unit per core.
> > It is shared by the HT siblings within that core.
> >
> > So the comparison to the AVX-512 multiplier is a good one.
>
> Fine, but that does not at all change the facts that:
>
>   1) It's shared between logical CPUs
>
>   2) It has effects on power/thermal and therefore effects which reach
>      outside of the core scope

FWIW, this is true of *every* instruction in the CPU.
Indeed, even when the CPU is executing *no* instructions at all,
the C-state chosen by that CPU has power/thermal impacts on its peers.

Granted, high performance instructions such as AVX-512 and TMUL
are the most extreme case.

>   3) Your approach of making it unconditionally available via the
>      proposed #NM prevents the OS and subsequently the system admin /
>      system designer to implement fine grained control over that
>      resource.
>
>      And no, an opt-in approach by providing a non-mandatory
>      preallocation prctl does not solve that problem.

I'm perfectly fine with making the explicit allocation (aka opt-in) mandatory,
and enforcing it.

Len Brown, Intel Open Source Technology Center
