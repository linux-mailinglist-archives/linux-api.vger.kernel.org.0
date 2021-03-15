Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D533C4D4
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 18:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCORwT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 13:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhCORwS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 13:52:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AF3C06174A
        for <linux-api@vger.kernel.org>; Mon, 15 Mar 2021 10:42:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v9so58233259lfa.1
        for <linux-api@vger.kernel.org>; Mon, 15 Mar 2021 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9br/rn+NQflaMLsYItA6lA+2r86TI92WxzRjOD18sA=;
        b=pu/uaYHl6nqaImhbz35F0IwdgLow1IqdUyUz+5SAh3JCmkSkdzqMe+IRRB/5+PmYSM
         B+XS6RJvYd+lb9QeKYYYe0sZsLQntudB/eG3V+ybQK7xviWm+QIgwgO5rQlrG1Z94poT
         dQoOqtUqKsQhjTBejliC5gtZ9ucrIr4uGVucGvbZwGtDEGZhasLA/l3hRdQlqAjSai80
         fJabJWfZXf7Spo+6IRVOBXQsJ080JyAN/c5UAjhl/xZ3Fz9OdKaSBWFrRmuurnYr7hn8
         06RU/X2F5/pbwIQ7wm5rbVLK5JhbvBSogjMT3xRvH+iFreJbsZj1wSz2qL/M9zytEyDt
         +FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9br/rn+NQflaMLsYItA6lA+2r86TI92WxzRjOD18sA=;
        b=oJYJP04DN+QqAq9f21IVbVWH4nHOAWRVVR4eAYBVxIFOzfE0RMYXMZwGU4v78vVtHV
         gWGTsMiJFzuf1zsJ4+bazKnN9GLtUxExDEFAow2nDHe+iwI+HNcZacBZo967KAmlTAkR
         dUvrJrHVG+vk0v0GhJvGhComRZHEv6ANLHzBQ5qy0JNrraRPyYBVceqss6XvfsOPUXuT
         2tqn3wSQHoNUicrfmsJk2DivnyBWNJJsPkRtZVnPo2hgER8rdGCwBH3V5oq2vOyH0nTL
         42oguGVH5GDNtDFU+Ms8U2CPMICJo3/Y7T8OK2GmoI/QAFXy75a6UEmaqH4u3S0rHEk1
         EVMQ==
X-Gm-Message-State: AOAM531WVHEBII1U5CrZxVaSB0T8ajrvvqJ005O5iiAkaCp4yznDqIOW
        BJzmQpcICxQJhzIwDvTvTC8kLYK3C9ZseSXNeRQ=
X-Google-Smtp-Source: ABdhPJxyCU9tS9e6kUOOcX4DN0PBEqaLeBoAXzQRK5Ms3eGHZZKk77CITmiuG/PI9dhsqetxZEvHrbQ1Ql+hMqewk+A=
X-Received: by 2002:a19:520b:: with SMTP id m11mr8446632lfb.42.1615830167987;
 Mon, 15 Mar 2021 10:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com> <YA2ztHUATu1gOxoV@clue.drijf.net>
 <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
 <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de> <48228481-c1b0-dcce-8598-4c88aedb2ef9@gmail.com>
In-Reply-To: <48228481-c1b0-dcce-8598-4c88aedb2ef9@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 15 Mar 2021 11:42:36 -0600
Message-ID: <CAMMLpeS2qSzoVhsjAih1VpCwGwnCsrVBzwe5D0tqXyA-3d5nTg@mail.gmail.com>
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

On Sun, Mar 14, 2021 at 3:44 AM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> On 1/25/21 5:03 AM, Bernhard Voelker wrote:
> > OTOH I understand that there's a little gap in the tool landscape.
> > Astonishingly, there doesn't seem to exist a trivial tool to redirect
> > from standard input (or any other input file descriptor) to a file.
> > I wrote such a little tool in the attached:
> >
> >    $ src/sink --help
> >    Usage: src/sink [OPTION]... FILE
> >    Copy input stream to FILE.
> >
> >    Mandatory arguments to long options are mandatory for short options too.
> >
> >      -a, --append              append to the given FILE, do not overwrite
> >      -c, --create              ensure to create FILE, error if exists
> >      -i, --input-stream=FD     read from stream FD instead of standard input
> >
> >    The default input stream number FD is 0, representing the standard input.
> >
> > This allows not only to copy data from standard input, but from any
> > file descriptor open for reading.  It also allows control over
> > how the output file will be opened (e.g. with O_CREAT|E_EXCL).
> >
> > The OPs case would look like:
> >
> >    echo 'foo' | sudo sink /etc/foo
> > or
> >    echo 'foo' | sudo sink -a /etc/foo  # append.
> > or
> >    echo 'foo' | sudo sink -c /etc/foo  # ensure creation of the file.
> >
> > I'm not sure if this will ever be considered for inclusion -
> > I just did it "for fun". ;-)
> >
> > Have a nice day,
> > Berny
> >
>
> By chance, I just found out that there is a tool very similar to 'sink'
> in moreutils [1].  It's called 'sponge'.
>
> [1]: <https://joeyh.name/code/moreutils/>
>
> So this feature already exists, and therefore I drop my patches.
>
> Cheers,
>
> Alex

Interesting, thanks for sharing. There's still no `sponge -q` option
though--it always writes either to a file or to standard output.

-Alex
