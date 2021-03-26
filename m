Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC034B2D6
	for <lists+linux-api@lfdr.de>; Sat, 27 Mar 2021 00:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCZXUP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Mar 2021 19:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231708AbhCZXS1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 26 Mar 2021 19:18:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 531AA61A44
        for <linux-api@vger.kernel.org>; Fri, 26 Mar 2021 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616800707;
        bh=gOUhHgYPRp8RB7xmeqPi4U4o0hzbDr/hS2GiFjT/kzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kgkWB2u0z8UWDa8pvMaIT0HQqVRWxkNt40dKPnB/UJQT32ZX8crLoTkNYRaQs6Nq6
         972T99eypWVXa2yGsV5rJgQ3yne9dLXrl7h2wYw+ZuzTOxr+NJZYV6YcLzXTEPCwMT
         eXhhn5QdYjokxIi8O0TQEX84yyXsmZeq8xq33JaNFHW+OkS/M+KXOfW88BGQnzo2Gv
         TN7Rk1E9Z70kkdpErTY8c59hT2qf49TMmx0a3Ql46t/H1+pDjBOk+ACJ/UOGtXC9FH
         1Cb3+KgTJVf0k0CHPakHkpdQeweY8xCEJnfq1oMHYe3rWX2g+EMNOtn+PACrBcPrns
         NoTdgBMgoc12g==
Received: by mail-ej1-f52.google.com with SMTP id kt15so10725862ejb.12
        for <linux-api@vger.kernel.org>; Fri, 26 Mar 2021 16:18:27 -0700 (PDT)
X-Gm-Message-State: AOAM531yfQLCvQyPLFIN4kdaHwCwjBofB7lfzKiiPHxcR+sx2h16yF2/
        kn3Cp4B5Rk7o3c2wJo016kYi5u2cWvMhZVSR6KCQiw==
X-Google-Smtp-Source: ABdhPJylU2XbFt9PHP5lGoF8AZirX2vZ3noGscbH0Ac2SIz92hjPabPPw0Ykc232lCcWj6+X8owIFNdVYBaP6jdHfvo=
X-Received: by 2002:a17:906:1494:: with SMTP id x20mr17630167ejc.101.1616800705721;
 Fri, 26 Mar 2021 16:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
In-Reply-To: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Mar 2021 16:18:14 -0700
X-Gmail-Original-Message-ID: <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
Message-ID: <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sigh, cc linux-api, not linux-abi.

On Fri, Mar 26, 2021 at 4:12 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Hi all-
>
> After some discussion on IRC, I have a proposal for a Linux ABI for
> using Intel AMX and other similar features.  It works like this:
>
> First, we make XCR0 dynamic.  This looks a lot like Keno's patch but
> with a different API, outlined below.  Different tasks can have
> different XCR0 values.  The default XCR0 for new tasks does not
> include big features like AMX.  XMM and YMM are still there.  The AVX2
> states are debatable -- see below.
>
> To detect features and control XCR0, we add some new arch_prctls:
>
> arch_prctl(ARCH_GET_XCR0_SUPPORT, 0, ...);
>
> returns the set of XCR0 bits supported on the current kernel.
>
> arch_prctl(ARCH_GET_XCR0_LAZY_SUPPORT, 0, ...);
>
> returns 0.  See below.
>
> arch_prctl(ARCH_SET_XCR0, xcr0, lazy_states, sigsave_states,
> sigclear_states, 0);
>
> Sets xcr0.  All states are preallocated except that states in
> lazy_states may be unallocated in the kernel until used.  (Not
> supported at all in v1.  lazy_states & ~xcr0 != 0 is illegal.)  States
> in sigsave_states are saved in the signal frame.  States in
> sigclear_states are reset to the init state on signal delivery.
> States in sigsave_states are restored by sigreturn, and states not in
> sigsave_states are left alone by sigreturn.
>
> Optionally we do not support PKRU at all in XCR0 -- it doesn't make
> that much sense as an XSAVE feature, and I'm not convinced that trying
> to correctly context switch XINUSE[PKRU] is worthwhile.  I doubt we
> get it right today.
>
> Optionally we come up with a new format for new features in the signal
> frame, since the current format is showing its age.  Taking 8kB for a
> signal with AMX is one thing.  Taking another 8kB for a nested signal
> if AMX is not in use is worse.
>
> Optionally we make AVX-512 also default off, which fixes what is
> arguably a serious ABI break with AVX-512: lots of programs, following
> POSIX (!), seem to think that they know much much space to allocate
> for sigaltstack().   AVX-512 is too big.
>
> Thoughts?
>
> --Andy
