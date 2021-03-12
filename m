Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE26338DE5
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhCLM4B (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Mar 2021 07:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhCLMz4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Mar 2021 07:55:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2DC061574;
        Fri, 12 Mar 2021 04:55:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so11027042pjg.5;
        Fri, 12 Mar 2021 04:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wKJ2USCqob2dPGSJ2s/55BxqmSQ03/ILkHfh+eqP1nw=;
        b=A+5YNZBSJatoaEvBF9DiCeQsl7H8nsFWBxl1ufbwCHHQ6WSp2N8W/PckhkDAh+7oQD
         nZFvlhrqUjbCDV+pt4xXjaaPjlaO4hYRWJhrEBqwqSoHtqsuoDGyvmzFi3PYou2qWuEd
         uY2N3QBSndxDFTPWOcd397M9v9Fu/m3/+zY0D4VY7djOuARzd0ED/os1iPrfxaWQC7ZQ
         e8vtOniiXG13cbOSKnU5DQfIXDdq535WwVA/R/PMhn85x5fze06PMFX2G0pKBTK9z+7r
         XlAVMhPB6FvWQELixO8hJ5H07tZbiUA0ba99tbVmgiZ84P9hCkRItu3PIG4RzYv6rOze
         /sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wKJ2USCqob2dPGSJ2s/55BxqmSQ03/ILkHfh+eqP1nw=;
        b=rFSvATsYxqXtKeS1yMvSmJMeuyB3z9FNJr2FapDM79+yyeU/S2KPyWZ5Td4RmBlnEx
         9NdxLWEtNOqERfCXgpFTjpaEVeK7bsGDzD7/YWcP9fDP7vEpK6loUYnGNV2GKTQ9ke5s
         hNb+mrbUaGoF1/vivzX30JI1+Vxtp/xkwv3JNrCSG2x01sSABU8hYtE7bIGV1VHI/giv
         XYjJ+WWy6Vx82qodOdku8RyZx5M7DFuKxIS4lue1tEpnoucSf0MX4tYOrOu1R8G5HyyE
         RNGCSyjOpIrY1jm2gx6Rx8WVcYxDSz+2sS+qpwpYf5azLHG5a61DEvQGai6ThaTV5Ave
         Ln9A==
X-Gm-Message-State: AOAM532lJqW+UnWcg1ZNVBzdjxgceS2g+2uWGBbvIT+gOZKtXbm0zU4J
        wc4wzB3QBtSsrp9kYExZrMPprmtShPEffh/sbuE=
X-Google-Smtp-Source: ABdhPJxeovDEBL+2f/HKvqKuIlEoXeagjVFgcRnFFft+vW4V+kfxKrL57CmOKiv/4FBYv3bQpgwdba/VbcGOcSYSRFc=
X-Received: by 2002:a17:90a:cca:: with SMTP id 10mr13911532pjt.103.1615553756156;
 Fri, 12 Mar 2021 04:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20210226172634.26905-1-yu-cheng.yu@intel.com> <20210226172634.26905-3-yu-cheng.yu@intel.com>
 <20210308212936.GD12548@zn.tnic> <40c3c4cc-e135-1355-51ee-4d0f16e47e71@intel.com>
 <20210309143141.GD699@zn.tnic> <CACKs7VBLnQTc_RgnXk8X-XgVRvR5_uXY0wL0snW7P5iDjpb8fA@mail.gmail.com>
 <92fa4a4b-3100-cbd3-47cb-11072e4c6844@intel.com>
In-Reply-To: <92fa4a4b-3100-cbd3-47cb-11072e4c6844@intel.com>
From:   Stefan Puiu <stefan.puiu@gmail.com>
Date:   Fri, 12 Mar 2021 14:55:45 +0200
Message-ID: <CACKs7VAFa5LCYLfhg7U3SfpUrMWcP-GMOU6nMfOd3xzUXDyrRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sigaction.2: wfix - Clarify si_addr description.
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        lnx-man <linux-man@vger.kernel.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 11, 2021 at 7:33 PM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 3/11/2021 9:17 AM, Stefan Puiu wrote:
> > Hi,
> >
> > My 2 cents below.
> >
> > On Tue, Mar 9, 2021, 16:33 Borislav Petkov <bp@alien8.de
> > <mailto:bp@alien8.de>> wrote:
> >
> >     On Mon, Mar 08, 2021 at 01:46:07PM -0800, Yu, Yu-cheng wrote:
> >      > I think the sentence above is vague, but probably for the reason
> >     that each
> >      > arch is different.  Maybe this patch is unnecessary and can be
> >     dropped?
> >
> >     Maybe.
> >
> >     If you want to clarify it, you should audit every arch. But what
> >     would that bring? IOW, is it that important to specify when si_addr
> >     is populated and when not...? I don't know of an example but I'm
> >     no userspace programmer anyway, to know when this info would be
> >     beneficial...
> >
> >
> > I've worked on projects where the SIGSEGV sig handler would also print
> > si_addr. When diagnosing a crash, the address that triggered the fault
> > is useful to know. If you can't reproduce the crash in a debugger, or
> > there's no core dump, at least you have an idea if it's a NULL pointer
> > dereference or some naked pointer dereferencing. So I think it's useful
> > to know when si_addr can be used to infer such information and when not=
.
>
> At least for x86, the faulting ip is already in ucontext, and si_addr is
> mostly the memory address being accessed if that was the reason of the
> fault (i.e. the memory is not supposed to be accessed).  That way, the
> signal handler has both the instruction pointer and the memory address.

Interesting that you mention ucontext. I think the ability to fetch
the IP from it is not that well documented. See for example the
sigaction man page
(https://man7.org/linux/man-pages/man2/sigaction.2.html):

              Further information about the ucontext_t structure can be
              found in getcontext(3) and signal(7).  Commonly, the
              handler function doesn't make any use of the third
              argument.

Michael's book ("The Linux Programming Interface") has similar text on
ucontext ("This information is rarely used in signal handlers, so we
don=E2=80=99t go into further details"). I could find one example on google
for fetching the IP at
https://www.oracle.com/technical-resources/articles/it-infrastructure/dev-s=
ignal-handlers-studio.html,
but it pertains to SPARC. Also I've found one older of our projects
that uses this, and it seems each architecture has its own layout (the
code handles ppc, mips and x86-64). Is this documented somewhere?
Outside of the arch-specific kernel definition of the uc_mcontext
member in the code, I mean :).

Thanks,
Stefan.

>
> For shadow stack violation, for example, it is not because the memory
> being accessed; it is the instruction itself causing the violation.  It
> is unnecessary to duplicate the ip in si_addr.  Setting si_addr to zero
> also indicates this is not a memory type fault.
>
> --
> Yu-cheng
