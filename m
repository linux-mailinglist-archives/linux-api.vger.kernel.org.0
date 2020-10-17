Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE2291280
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438388AbgJQOmI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438360AbgJQOmI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 10:42:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8FDC061755
        for <linux-api@vger.kernel.org>; Sat, 17 Oct 2020 07:42:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 188so4304614qkk.12
        for <linux-api@vger.kernel.org>; Sat, 17 Oct 2020 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CncpsOILmLKwmuLD+64MGtHxizM1mPz6idw5KYbDws=;
        b=NoJwgQLbKZ7Hu0/tmLxhrQqwAEPpHHzII4ro9saGyVBh2KkMbPMebjoK6qIwZeVAiw
         Uqg1vJkUIACrR/ptH8JoOFqJBCqRSO3U4kzWdIXQncjOecN8OqPgYTg2/AP01ZRSLg+u
         1/hV5kSvRpHMkM+hgyzBWKB5HZoqjM0CwQARcaN0iZDM5FTw5oW+rJo7Jq6Jp4hbud21
         9uOZiVO5aXXWdpnPVNLmoaFzjoZ8/Z5r+XQONDB9y72QsECDJ4lp59UC+/LnjcdzVuez
         lwzpIZ80h9uLuwErVHGAk6Vnu4dt42UhqdCGXlDZVoM5xCQXtGliOd34H1NvtJ02fHXs
         pDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CncpsOILmLKwmuLD+64MGtHxizM1mPz6idw5KYbDws=;
        b=sezTwWoQstdY/p65N4Sj2e6YvcProo5bEBRX/j/f+fbtzZGJgwhtdG+Mu7JdWqiL4y
         uZ3Ydk+MiGUqJUubwHbqhE+motdyi9P8a45GFwVDNTJ9e4zEyOHJAReM1y8K0WUBFZV8
         XWFF5AWfBafA5xUcNZGkAfblTAqubCt/YgOnqv6HtRBAhyWiyL2HHt1zhAub9nC5zM+d
         LHM8yBXu8LV5X06P0IhYK0EA81nQ4npiuMycXjKDaBQM/rM9/gDLPSiMULWY89NXKKym
         CRPwDKyX2vE14dgUssIkGatxTF5oIVifUQOZUHqC0/u6dciIw4UkeBuFb53gOu96edAH
         p9PQ==
X-Gm-Message-State: AOAM530ynGS2u2rWVx35isjnB+uo3NS+RwWlxFORN45QfcOV1rIIJD+6
        vXs3NZhd8rxnpt4V6O1Mn4TZzhL6TNlcesDP7qUFkA==
X-Google-Smtp-Source: ABdhPJwRz4xCGWsXfmJotwOmnaXVke0rNvSDHk56uNYOReGF9ulLpLK3zw48BxNzjCGSB3ztI+OleQQ83/3me8zAsKI=
X-Received: by 2002:a37:9747:: with SMTP id z68mr8387175qkd.424.1602945726771;
 Sat, 17 Oct 2020 07:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014370305b1c55370@google.com> <202010162042.7C51549A16@keescook>
 <CACT4Y+bG=89ii+kzgGvNiZnB9ZEcAsy-3YofJeW5K_rynp_S7g@mail.gmail.com> <CAG48ez0LKk7iEersZe-S25SGJm-AFVW2jzG32X=NkKon+1Fuxw@mail.gmail.com>
In-Reply-To: <CAG48ez0LKk7iEersZe-S25SGJm-AFVW2jzG32X=NkKon+1Fuxw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 17 Oct 2020 16:41:55 +0200
Message-ID: <CACT4Y+beaHrWisaSsV90xQn+t2Xn-bxvVgmx8ih_h=yJYPjs4A@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in alg_bind
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        syzbot <syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-hardening@vger.kernel.org,
        Elena Petrova <lenaptr@google.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 17, 2020 at 1:02 PM Jann Horn <jannh@google.com> wrote:
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=92ead4eb8e26a26d465e
> > > > [...]
> > > > Reported-by: syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com
> > > > [...]
> > > > UBSAN: array-index-out-of-bounds in crypto/af_alg.c:166:2
> > > > index 91 is out of range for type '__u8 [64]'
> > >
> > > This seems to be an "as intended", if very odd. false positive (the actual
> > > memory area is backed by the on-stack _K_SS_MAXSIZE-sized sockaddr_storage
> > > "address" variable in __sys_bind. But yes, af_alg's salg_name member
> > > size here doesn't make sense.
> >
> > As Vegard noted elsewhere, compilers can start making assumptions
> > based on absence of UB and compile code in surprising ways as the
> > result leading to very serious and very real bugs.
> >
> > One example would be a compiler generating jump table for common sizes
> > during PGO and leaving size > 64 as wild jump.
> >
> > Another example would be a compiler assuming that copy size <= 64.
> > Then if there is another copy into a 64-byte buffer with a proper size
> > check, the compiler can now drop that size check (since it now knows
> > size <= 64) and we get real stack smash (for a copy that does have a
> > proper size check before!).
>
> FWIW, the kernel currently still has a bunch of places that use
> C89-style length-1 arrays (which were in the past used to work around
> C89's lack of proper flexible arrays). Gustavo A. R. Silva has a bunch
> of patches pending to change those places now, but those are not
> marked for stable backporting; so in all currently released kernels,
> we'll probably keep having length-1 arrays at the ends of C structs
> that are used as if they were flexible arrays. (Unless someone makes
> the case that these patches are not just cleanups but actually fix
> some sort of real bug, and therefore need to be backported.)
>
> The code in this example looks just like one of those C89-style
> length-1 arrays to me (except that the length isn't 1).
>
> Of course I do agree that this should be cleaned up, and that having
> bogus array lengths in the source code is a bad idea.
>
> > And we do want compilers to be that smart today. Because of all levels
> > of abstractions/macros/inlining we actually have lots of
> > redundant/nonsensical code in the end after all inlining and
> > expansions, and we do want compilers to infer things, remove redundant
> > checks, etc so that we can have both nice abstract source code and
> > efficient machine code at the same time.
>
> I guess that kinda leads to the question: Do we just need to fix the
> kernel code here (which is comparatively easy), or do you think that
> this is a sufficiently big problem that we need to go and somehow
> change the actual UAPI headers here (e.g. by deprecating the existing
> UAPI struct and making a new one with a different name)?

Good question. What I wrote is not based on some concrete
miscompilation at hand. I just meant that there are more things
involved that may appear at first glance.

Re proactively fixing UAPI, I would say if somebody is up to doing it
now, I would say it's good and a right change. Otherwise delaying
fixing it is also a reasonable strategy because (1) there are probably
more such cases, (2) any work on enabling more optimizations, global
optimizations, etc is only feasible if there is a tool that helps to
identify all places that need to be fixed. So whoever/whenever will be
fixing this, one more or one less case probably does not matter much.
It's a different story if there is already a tool/compiler warning
that traps on some code and that code harms deployment of the tool.
