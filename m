Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38001F9456
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 16:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLPeN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 10:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfKLPeN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 12 Nov 2019 10:34:13 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF4321783
        for <linux-api@vger.kernel.org>; Tue, 12 Nov 2019 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573572852;
        bh=DXYIyanra3jNg47NQU0uVZtkQQqgQMq2XaV52IXf3Og=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BaEKCGQLPe+KFtrP/ScOjosruT1d1FXj5QHeMMrbSLUK2fYnTuWbNLNCCzVbLBeH4
         zo0gME3w00O1xW0xJdxWBThGw2L/siUTUSDBjFUGr7M2CQUrhKT89+BSM4fvL0n1uZ
         CK6WhP44e9J5L25Xq0ENqFp+KACu9/7qg1XRL1xk=
Received: by mail-wm1-f45.google.com with SMTP id j18so2617693wmk.1
        for <linux-api@vger.kernel.org>; Tue, 12 Nov 2019 07:34:12 -0800 (PST)
X-Gm-Message-State: APjAAAWvJkuhNcT0hSn+R1xgLpgTwvXoxR9wSGlaubd/9tqMTHLoGowH
        h0jvLGUfffWDakr4vJsDEvLX7/8O58mv7EtSJMNv7A==
X-Google-Smtp-Source: APXvYqxTDJMLUPvzsq/nAiAh1IFJuOAwbzKC6VPlu6JcodO6aU5gAbxzpC395iIuoKGovo5d72M8gyJmjOUVwXR/UfA=
X-Received: by 2002:a05:600c:1002:: with SMTP id c2mr4486257wmc.79.1573572850848;
 Tue, 12 Nov 2019 07:34:10 -0800 (PST)
MIME-Version: 1.0
References: <6157374.ptSnyUpaCn@positron.chronox.de>
In-Reply-To: <6157374.ptSnyUpaCn@positron.chronox.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 07:33:59 -0800
X-Gmail-Original-Message-ID: <CALCETrVBzuOsDfaz5y3V4v+6xmeWufOYsOGnpZrRju6Pfsi6gg@mail.gmail.com>
Message-ID: <CALCETrVBzuOsDfaz5y3V4v+6xmeWufOYsOGnpZrRju6Pfsi6gg@mail.gmail.com>
Subject: Re: [PATCH v24 00/12] /dev/random - a new approach with full
 SP800-90B compliance
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 11, 2019 at 11:13 AM Stephan M=C3=BCller <smueller@chronox.de> =
wrote:
>
> The following patch set provides a different approach to /dev/random whic=
h is
> called Linux Random Number Generator (LRNG) to collect entropy within the=
 Linux
> kernel. The main improvements compared to the existing /dev/random is to =
provide
> sufficient entropy during boot time as well as in virtual environments an=
d when
> using SSDs. A secondary design goal is to limit the impact of the entropy
> collection on massive parallel systems and also allow the use accelerated
> cryptographic primitives. Also, all steps of the entropic data processing=
 are
> testable.

This is very nice!

>
> The LRNG patch set allows a user to select use of the existing /dev/rando=
m or
> the LRNG during compile time. As the LRNG provides API and ABI compatible
> interfaces to the existing /dev/random implementation, the user can freel=
y chose
> the RNG implementation without affecting kernel or user space operations.
>
> This patch set provides early boot-time entropy which implies that no
> additional flags to the getrandom(2) system call discussed recently on
> the LKML is considered to be necessary.

I'm uneasy about this.  I fully believe that, *on x86*, this works.
But on embedded systems with in-order CPUs, a single clock, and very
lightweight boot processes, most or all of boot might be too
deterministic for this to work.

I have a somewhat competing patch set here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=3Dran=
dom/kill-it

(Ignore the "horrible test hack" and the debugfs part.)

The basic summary is that I change /dev/random so that it becomes
functionally identical to getrandom(..., 0) -- in other words, it
blocks until the CRNG is initialized but is then identical to
/dev/urandom.  And I add getrandom(...., GRND_INSECURE) that is
functionally identical to the existing /dev/urandom: it always returns
*something* immediately, but it may or may not actually be
cryptographically random or even random at all depending on system
details.

In other words, my series simplifies the ABI that we support.  Right
now, we have three ways to ask for random numbers with different
semantics and we need to have to RNGs in the kernel at all time.  With
my changes, we have only two ways to ask for random numbers, and the
/dev/random pool is entirely gone.

Would you be amenable to merging this into your series (i.e. either
merging the code or just the ideas)?  This would let you get rid of
things like the compile-time selection of the blocking TRNG, since the
blocking TRNG would be entirely gone.

Or do you think that a kernel-provided blocking TRNG is a genuinely
useful thing to keep around?

--Andy
