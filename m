Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5253369A2
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 02:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhCKB2Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Mar 2021 20:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKB2Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Mar 2021 20:28:25 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B837C061574
        for <linux-api@vger.kernel.org>; Wed, 10 Mar 2021 17:28:25 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jt13so42870968ejb.0
        for <linux-api@vger.kernel.org>; Wed, 10 Mar 2021 17:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VpOIjQ3p9w0rNFfbAO51HuvtMJp/6aJrl+qPrZuKuR8=;
        b=aM/wmrMKYr9tu1cwciQttikcxEZH1/v/i+xHpN3cj4QpcL/AU7fKmsWFk9SGeEeUAl
         XPRFwqreWDxUrqnN+WDqh9pH3udYulUcseEJtij+krUz2w6yLZIBO72w7H/PytPOU0e2
         QmAagxnT+PmwAfCzV8VyX8VL3c8FH0PJwrZzjgDMO6vWECa/F3XMyH25193pxJTWq18m
         5wejTpNj21k/DNvUX2DyHlQG3osbrPUlZ33s1jbLzrAZZoIR/lydR1HenxDeUjb+wE+U
         w8P5ha3WaUO7prJow5sGuquFUmLi1UG/i0AyhEw7Hb0HD7XRKP1xbj67OrL0cbUnw6L5
         3StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VpOIjQ3p9w0rNFfbAO51HuvtMJp/6aJrl+qPrZuKuR8=;
        b=DMHghBzHCz5ZoxTvNJBjveQvYRwPI3rGhNpsORTxMGbbzZ39gX7XTpdG99vQq54BgO
         WVDrK9hbWJJJ2mYYTeTOqVk5GKXelyPt7yXk5xOp3xjf3x1q96eAIl9Gl/J7Y+mJMliw
         SgD6Zursx18Sjfb0ORiCX3QAb2u9sBs8qeO2/1NGGRKyPKZnQHg/Wq5ahS2zJgdWpz8M
         1pGG9SJ5hw4dxMFT96URVrXXO+YbVJbwQDImho0SA0gAVXcee5R8lZBS2qK/7MuWMRxI
         yWUIfrylxkZGo1Juw/xA1Rr7q6Un1MsYYox69MOHGYt91YMItzrdz4xOkY1mLKW4bibE
         V6PQ==
X-Gm-Message-State: AOAM531Dyfphv2WkUQnhQVhlni2vgeTKsTJRZiI7Hbl7ELygoaR14ZuM
        FrVqf/I+b/W/dH4H+nLMljVGmg8v5DZyDzUvm5iFBQ==
X-Google-Smtp-Source: ABdhPJyzKbaBgpWAEV4KmB44LDkGtgM1yTLos/iUC1Eu7napm28BHmC/ZQK21pLB22uKasKXJZ2WMcH9tvd3gLPonNY=
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr663334ejj.204.1615426103622;
 Wed, 10 Mar 2021 17:28:23 -0800 (PST)
MIME-Version: 1.0
References: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com> <047D5B49-FDBB-494C-81E9-DA811476747D@amacapital.net>
 <20210311091941.45790fcf@alex-virtual-machine>
In-Reply-To: <20210311091941.45790fcf@alex-virtual-machine>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 10 Mar 2021 17:28:12 -0800
Message-ID: <CALCETrVqkK29n=6wtVhd7qgTWf83x3SUk6+bkD30asHyWSqppw@mail.gmail.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        yangfeng1@kingsoft.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, sunhao2@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 10, 2021 at 5:19 PM Aili Yao <yaoaili@kingsoft.com> wrote:
>
> On Mon, 8 Mar 2021 11:00:28 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
>
> > > On Mar 8, 2021, at 10:31 AM, Luck, Tony <tony.luck@intel.com> wrote:
> > >
> > > =EF=BB=BF
> > >>
> > >> Can you point me at that SIGBUS code in a current kernel?
> > >
> > > It is in kill_me_maybe().  mce_vaddr is setup when we disassemble wha=
tever get_user()
> > > or copy from user variant was in use in the kernel when the poison me=
mory was consumed.
> > >
> > >        if (p->mce_vaddr !=3D (void __user *)-1l) {
> > >                force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHI=
FT);
> >
> > Hmm. On the one hand, no one has complained yet. On the other hand, har=
dware that supports this isn=E2=80=99t exactly common.
> >
> > We may need some actual ABI design here. We also need to make sure that=
 things like io_uring accesses or, more generally, anything using the use_m=
m / use_temporary_mm ends up either sending no signal or sending a signal t=
o the right target.
> >
> > >
> > > Would it be any better if we used the BUS_MCEERR_AO code that goes in=
to siginfo?
> >
> > Dunno.
>
> I have one thought here but don't know if it's proper:
>
> Previous patch use force_sig_mceerr to the user process for such a scenar=
io; with this method
> The SIGBUS can't be ignored as force_sig_mceerr() was designed to.
>
> If the user process don't want this signal, will it set signal config to =
ignore?
> Maybe we can use a send_sig_mceerr() instead of force_sig_mceerr(), if pr=
ocess want to
> ignore the SIGBUS, then it will ignore that, or it can also process the S=
IGBUS?

I don't think the signal blocking mechanism makes sense for this.
Blocking a signal is for saying that, if another process sends the
signal (or an async event like ctrl-C), then the process doesn't want
it.  Blocking doesn't block synchronous things like faults.

I think we need to at least fix the existing bug before we add more
signals.  AFAICS the MCE_IN_KERNEL_COPYIN code is busted for kernel
threads.

--Andy
