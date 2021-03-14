Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492F933A2C4
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 06:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhCNFLj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Mar 2021 00:11:39 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:60917 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhCNFLb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Mar 2021 00:11:31 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 12E5BEOk012841;
        Sun, 14 Mar 2021 14:11:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 12E5BEOk012841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615698675;
        bh=MruVtPwUcls26B+Ziu0aaXEtzSZ7hGy9dYXMkXU8rDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kc02TqJfoG9iiTBl1f2KS1d4MjS9H33VKjUST4Jwkbj4GnZp/PX0ZCiBr+DWJW+eI
         0/6JKvaQRdaA5lwumnR1WG8MLVcE6ZAhNFiEo3rRcTdcrXejePBeJ1LJyWSObMyAAT
         2/8KMFe2ErqxeMrkKxHn+TdsGJqvEnLsGOYXAv0saSOC2pIc/eW6inmPB8ZhAt808X
         xErxhq2hRmh9tvYsArh8PDrssQzPDl0d+EDs1uMnfeAxavqgIgf0Pm69XqvIlvAnKF
         Ekm1Xpp/cTMnL24DF0Hf2N5wov3ICRpi0LLQGJUUv56D/sewpuDujg+4FWxsK/cmTb
         Q7DX/+OqbxTdQ==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso13057457pjb.3;
        Sat, 13 Mar 2021 21:11:14 -0800 (PST)
X-Gm-Message-State: AOAM532mRqxb6shjhLWfnY6NDmQkFeUh6+ABIp+EkeQIZLToZrQ240dL
        uf8HmDxxMsOOni4nYetTV0Tv0aqiDQwdO1DSTWE=
X-Google-Smtp-Source: ABdhPJyFZGhOncAg7Noju7UzseBN6p8Q/OprsF+AiFDFOCywavy1PSblGzVXdVdfv8fayEJGEDwa8jUf00PZgBBD2js=
X-Received: by 2002:a17:90a:fb54:: with SMTP id iq20mr6228331pjb.153.1615698673916;
 Sat, 13 Mar 2021 21:11:13 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQYMKqixm8dVbbMvgt+=MEROSg-JG_kHS8T+xmrgeLABg@mail.gmail.com>
 <20210312032712.GB27924@1wt.eu>
In-Reply-To: <20210312032712.GB27924@1wt.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 14 Mar 2021 14:10:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASEHi6e4AyqDvCH_94DQ6AVWeS8yw0Sz4nHdaB=CMVAtQ@mail.gmail.com>
Message-ID: <CAK7LNASEHi6e4AyqDvCH_94DQ6AVWeS8yw0Sz4nHdaB=CMVAtQ@mail.gmail.com>
Subject: Re: Why is the bit size different between a syscall and its wrapper?
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Willy,

Thanks for the explanation.

On Fri, Mar 12, 2021 at 12:27 PM Willy Tarreau <w@1wt.eu> wrote:
>
> On Fri, Mar 12, 2021 at 11:48:11AM +0900, Masahiro Yamada wrote:
> > Hi.
> >
> > I think I am missing something, but
> > is there any particular reason to
> > use a different bit size between
> > a syscall and its userspace wrapper?
> >
> >
> >
> > For example, for the unshare syscall,
> >
> > unshare(2) says the parameter is int.
> >
> >
> > SYNOPSIS
> >        #define _GNU_SOURCE
> >        #include <sched.h>
> >
> >        int unshare(int flags);
> >
> >
> >
> >
> > In the kernel, it is unsigned long.
> >
> >
> > SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
> > {
> >         return ksys_unshare(unshare_flags);
> > }
>
> The syscalls must have a well defined interface for a given architecture.
> Thus in practice the ABI will define that arg1 goes into this register,
> arg2 into this one etc, regardless of their type (plenty of them are
> pointers for example). The long is the size of a register so it can carry
> any of the types we care about. So by defining each syscall as a function
> taking 1 to 6 fixed-size arguments you can implement about all syscalls.
>
> Regarding the libc, it has to offer an interface which is compatible with
> the standard definition of the syscalls as defined by POSIX or as commonly
> found on other OSes, and this regardless of the platform.
>
> For example look at recv(), it takes an int, a pointer, a size_t and an
> int. It requires to be defined like this for portability, but at the OS
> level all these will typically be passed as a register each.
>

You are right.
Functions in POSIX such as 'recv' should be portable with other OSes.
For the syscall ABI level, we have more freedom to choose
parameter types more convenient for the kernel.

IIUC, 'unshare' seems to be Linux-specific, and
I think "other OSes" do not exist.



Using types that have the same width as registers
avoids the ambiguity about the upper 32-bits
in 64-bit registers anyway. This is a benefit.

Historically, it caused a issue:
https://nvd.nist.gov/vuln/detail/CVE-2009-0029

We do not need to be worried since
commit 1a94bc34768e463a93cb3751819709ab0ea80a01.
All parameters are properly sign-extended by
forcibly casting to (long).


--
Best Regards
Masahiro Yamada
