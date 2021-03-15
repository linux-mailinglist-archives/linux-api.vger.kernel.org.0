Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90FD33C7A0
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 21:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhCOUVR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 16:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhCOUUy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 16:20:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312ADC06174A
        for <linux-api@vger.kernel.org>; Mon, 15 Mar 2021 13:20:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d3so58841071lfg.10
        for <linux-api@vger.kernel.org>; Mon, 15 Mar 2021 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5o+tdW+BV7Wm+7chs7B/caIMYJ3/SLZxEpYQvO4IUTw=;
        b=H9/XcVOnqaB+05V4nFAe/DIRo555bUX6rHMiUSrBpeFHqnIxjdztmQn8zbasu1KIfa
         /sVMt73yWhBLCK5XaOV7eIJAb7DiozjNFHfYwIm0DxTtT8ZL8diy4tNPVVF3UnBT9BbS
         0lAbbGXQBGT5u/3lA7rSV8RD2zK5ui6tcA/zhS0I2/s7MMuLaw0Hp1xo6ObEvV5HI5I+
         sgt0RoUUlzXr/HGBexmwX9YcnUWVzJDSSfAgFdW8A9SUuzJ1dj0lKR1r4iXObS+FQACX
         KSTDhDXaJGv0sqHMiwTSDuRmUqifUXPgBHyY5U/12dX8A9xE30xcNYWpF/7tOh+A8RCr
         szTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5o+tdW+BV7Wm+7chs7B/caIMYJ3/SLZxEpYQvO4IUTw=;
        b=spAj7PqA3KtVChOZrBe+yg4Y+bkMNBa4e/5iVUgFbVL6PMguTJBXZWhPR8lk72oP1q
         mldLv9pK8sdUTk+RvvblshpsTbTuS1fYPW/LOhXi1AETk0JYQ4pqQulsZqQqTXuLkvbw
         GXCEJWfN5Q4LyGuOq9CHBDdlhAKpvMoR/2WftoyMDZnv7DP4thFNZGRPWPJJYXTCMx+L
         CE3H3Ho6D+nexlaDE10OzmSsOSRBwQDTiNErsm3fIz9Y/M+0s9mj7HNqQfco7cGok5so
         7yUQcUAqaky5KAOpmAWAALE6S+rAXPldCNV4YQmM6S08vIaQb7gRs7+pQl2VurM55Ff7
         wx4g==
X-Gm-Message-State: AOAM530s+B/qYhnDsInH76yVbb+Ogo+5f9zT9/4hZ2hKJnjWQwa47p+M
        hC5nmH/cJFwfAM/MvM9HRxGi3QNc87/qMdkvbt4=
X-Google-Smtp-Source: ABdhPJwvGVF19aniHTtSRwoAzpZgDayRD56HV3hWLx5di0gQKHCAoaGF5qNB4u1qHrAUpU3Fe5kmmxzFscM9V9bsgbA=
X-Received: by 2002:a19:5213:: with SMTP id m19mr8835236lfb.203.1615839652612;
 Mon, 15 Mar 2021 13:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com> <YA2ztHUATu1gOxoV@clue.drijf.net>
 <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
 <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de>
 <48228481-c1b0-dcce-8598-4c88aedb2ef9@gmail.com> <CAMMLpeS2qSzoVhsjAih1VpCwGwnCsrVBzwe5D0tqXyA-3d5nTg@mail.gmail.com>
In-Reply-To: <CAMMLpeS2qSzoVhsjAih1VpCwGwnCsrVBzwe5D0tqXyA-3d5nTg@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 15 Mar 2021 14:20:40 -0600
Message-ID: <CAMMLpeT=Wos_dGTN9fYRovUOxHKxQicNDxAXatW2xKALDGVpdw@mail.gmail.com>
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Otto Moerbeek <otto@drijf.net>, Coreutils <coreutils@gnu.org>,
        Fabrice BAUZAC <noon@mykolab.com>,
        Juli Mallett <juli@clockworksquid.com>,
        Jeffrey Walton <noloader@gmail.com>,
        freebsd-hackers@freebsd.org,
        William Ahern <william@25thandclement.com>,
        Roman Czyborra <roman@czyborra.com>, oshogbo@freebsd.org,
        tech@openbsd.org, Christian Groessler <chris@groessler.org>,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Ed Schouten <ed@nuxi.nl>, Eric Pruitt <eric.pruitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 15, 2021 at 11:42 AM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Sun, Mar 14, 2021 at 3:44 AM Alejandro Colomar (man-pages)
> <alx.manpages@gmail.com> wrote:
> >
> > On 1/25/21 5:03 AM, Bernhard Voelker wrote:
> > > OTOH I understand that there's a little gap in the tool landscape.
> > > Astonishingly, there doesn't seem to exist a trivial tool to redirect
> > > from standard input (or any other input file descriptor) to a file.
> > > I wrote such a little tool in the attached:
> > >
> > >    $ src/sink --help
> > >    Usage: src/sink [OPTION]... FILE
> > >    Copy input stream to FILE.
> > >
> > >    Mandatory arguments to long options are mandatory for short options too.
> > >
> > >      -a, --append              append to the given FILE, do not overwrite
> > >      -c, --create              ensure to create FILE, error if exists
> > >      -i, --input-stream=FD     read from stream FD instead of standard input
> > >
> > >    The default input stream number FD is 0, representing the standard input.
> > >
> > > This allows not only to copy data from standard input, but from any
> > > file descriptor open for reading.  It also allows control over
> > > how the output file will be opened (e.g. with O_CREAT|E_EXCL).
> > >
> > > The OPs case would look like:
> > >
> > >    echo 'foo' | sudo sink /etc/foo
> > > or
> > >    echo 'foo' | sudo sink -a /etc/foo  # append.
> > > or
> > >    echo 'foo' | sudo sink -c /etc/foo  # ensure creation of the file.
> > >
> > > I'm not sure if this will ever be considered for inclusion -
> > > I just did it "for fun". ;-)
> > >
> > > Have a nice day,
> > > Berny
> > >
> >
> > By chance, I just found out that there is a tool very similar to 'sink'
> > in moreutils [1].  It's called 'sponge'.
> >
> > [1]: <https://joeyh.name/code/moreutils/>
> >
> > So this feature already exists, and therefore I drop my patches.
> >
> > Cheers,
> >
> > Alex
>
> Interesting, thanks for sharing. There's still no `sponge -q` option
> though--it always writes either to a file or to standard output.
>
> -Alex

Actually, it looks like `pee` (also from moreutils) can be used for
throwing input into the void. So between `sponge` and `pee`, I think
all the use cases are covered!

-Alex
