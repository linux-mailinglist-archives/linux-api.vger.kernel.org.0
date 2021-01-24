Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782FC301E98
	for <lists+linux-api@lfdr.de>; Sun, 24 Jan 2021 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbhAXUCj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 15:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbhAXUCi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Jan 2021 15:02:38 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D43C061573
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 12:01:58 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id p13so12800856ljg.2
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 12:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMRNPU76m9SCxoil+gI3XXtJmPRmnQ29SdbiUNuTwYA=;
        b=lTkge773O0w5SrCSjVHmj9thNU1felBxLTJlpRQnnjV+wBdicdpp6fxWFjbGozHYF5
         15mA+jKpeh0xkQvRCgakEBDfFJLBjzYzDkAYkZX9ykbdn5d/EdUi7bUoCcgWD+pM+LZW
         BLclJeeT+JtRHP7l3uCcNOGIB8X3nvfs0CEf8xOgkWYr3opm1J4qNg2x+NRiuDIpNzup
         QGNavPMcHGFENkKtCB1mDOKZLlufkfLOk40cwP1cp23Z71XY16jOaVJmdjd7wj9VqaGy
         LLD42Z22/+lHjVwxrHDxFsi0VhqczpgB2AMYeeOyhwHiO8ZsJ7bow3lxhWFqQD1I5Q1m
         qGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMRNPU76m9SCxoil+gI3XXtJmPRmnQ29SdbiUNuTwYA=;
        b=DDZgxUMcQnqwAUVvxeJJuK+uNRC4OIzlmkVOCOkxCzujiY7NwDxc7adUf3RuB3vDxn
         +qxkkHPpxNopasYyN9AuKc3UOFbmWsgpjwlBiEFeN7bx6/Ypa6jHUZiV0JWNf2jO6Cam
         14T3gSQscuCbvRnT/iNgyGnOeYe9NSb21GqGovs7RYKLUn1il+mL6G9uQVqIVV17kNAm
         1L4/OcezVz7u5IAcGb5FPF7gPcYOQllep9xDJl8G1eb71AieJgp02anyOj6Ujddhi8ff
         TWMmGLzZiWC5vYsVvjZUkdBTh4uAJmvSWJgbj9mOBb0LlGrpCnOQYqJz6Rjpy1CQal0b
         IzGw==
X-Gm-Message-State: AOAM533eC60cLFiszc/nD9E0lb/D9xyJXaSIzbiObSGLfuOKScFVvkPD
        ryqbEP64hiU66pT82/Oq5heGARzh+97nthhT6YU=
X-Google-Smtp-Source: ABdhPJy4zsV5waxaWI4RLQcOBucztiJuT2X2exTGDl09P5UhI8V7jjaVzFTzkX2/zQjxsCAbG3pacg9cZwwUzHsuEEc=
X-Received: by 2002:a2e:8044:: with SMTP id p4mr76238ljg.464.1611518516604;
 Sun, 24 Jan 2021 12:01:56 -0800 (PST)
MIME-Version: 1.0
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com> <YA2ztHUATu1gOxoV@clue.drijf.net>
In-Reply-To: <YA2ztHUATu1gOxoV@clue.drijf.net>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 24 Jan 2021 13:01:45 -0700
Message-ID: <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
To:     Otto Moerbeek <otto@drijf.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        Christian Groessler <chris@groessler.org>,
        =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>,
        William Ahern <william@25thandclement.com>,
        Erik Auerswald <auerswal@unix-ag.uni-kl.de>,
        Eric Pruitt <eric.pruitt@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org,
        juli@clockworksquid.com, ed@nuxi.nl, oshogbo@freebsd.org,
        Roman Czyborra <roman@czyborra.com>,
        Jim Meyering <jim@meyering.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Jan 24, 2021 at 10:51 AM Otto Moerbeek <otto@drijf.net> wrote:
>
> Please stop pushing your diff to this list. So far nobody showed any
> interest.

I am definitely interested. Bernhard Voelker seemed to express
interest as well, conditional on -q being added to POSIX first.[1]
Also, a --quiet flag was proposed back in 2001 by Roman Czyborra [2]
and Jim Meyering expressed support for the idea.[3]

-Alex

[1] https://lists.gnu.org/archive/html/coreutils/2021-01/msg00043.html
[2] https://lists.gnu.org/archive/html/bug-sh-utils/2001-05/msg00024.html
[3] https://lists.gnu.org/archive/html/bug-sh-utils/2001-05/msg00039.html
