Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A89102197
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfKSKGQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Nov 2019 05:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSKGP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 19 Nov 2019 05:06:15 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2C722312
        for <linux-api@vger.kernel.org>; Tue, 19 Nov 2019 10:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574157975;
        bh=rWQ/lkGgBOVp8kUnHcoEXqH8/pa6VQ2R1kl+dVXu2DM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HgEuceO+k7duJ5ZWetb2pSprvk67YQ3lLR55QT/dKRSFqKd5jdsyp90096gaCiqWK
         U1/1NRmX/v72AYEA+0d4UzKE26dgernmvyW11konXl1yiL3puHqL84IEJIvA9bo5bI
         7BEM7bQ4uTCCXs3dq2Af1HwkV+5UpLVkWulNNty8=
Received: by mail-wr1-f41.google.com with SMTP id s5so23077751wrw.2
        for <linux-api@vger.kernel.org>; Tue, 19 Nov 2019 02:06:15 -0800 (PST)
X-Gm-Message-State: APjAAAWtLl/iM8phooOBv7WZIDVtRsYBCtNpnoyU3q+32/lJ05lxP3m1
        NqiTKcmAOjKdDsW5jOIkzuFDMTr3pUxD3RsCXyXS7g==
X-Google-Smtp-Source: APXvYqwXqnJ2b6go4d2so794PYr2fq3ATh1U8fgULvNYyIHkM7sbcTs+xnBfZqXou6vX7C0E4cF57QGLaw14xCVaaZw=
X-Received: by 2002:a5d:640b:: with SMTP id z11mr34817132wru.195.1574157973828;
 Tue, 19 Nov 2019 02:06:13 -0800 (PST)
MIME-Version: 1.0
References: <2476454.l8LQlgn7Hv@positron.chronox.de> <4EB89769-7A2C-4A03-A832-9A0539DD3336@amacapital.net>
 <3043322.Kq9igzfA0K@positron.chronox.de>
In-Reply-To: <3043322.Kq9igzfA0K@positron.chronox.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 Nov 2019 02:06:02 -0800
X-Gmail-Original-Message-ID: <CALCETrVXGuShozaf5RpgmQnwtTpAbmaTVny+E0q8OE4OLuWwAQ@mail.gmail.com>
Message-ID: <CALCETrVXGuShozaf5RpgmQnwtTpAbmaTVny+E0q8OE4OLuWwAQ@mail.gmail.com>
Subject: Re: [PATCH v25 03/12] LRNG - /proc interface
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

On Sun, Nov 17, 2019 at 4:16 AM Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
>
> Am Samstag, 16. November 2019, 17:39:40 CET schrieb Andy Lutomirski:
>
> Hi Andy,
>
> > > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.de=
> wrote:
> > >
> > > =EF=BB=BFThe LRNG /proc interface provides the same files as the lega=
cy
> > > /dev/random. These files behave identically. Yet, all files are
> > > documented at [1].
> >
> > Why?
>
> I am not sure here: are you referring to the documentation? Or the one
> additional file?
>
> If it is the documentation, do you want me to add it to the patch descrip=
tion?
> I initially did not add it as these files were present and seemingly know=
n
> what they provide. But I would add that documentation to the patch descri=
ption
> if this is desired.

Sorry, I should have been a lot more explicit.  Why do you want to add
a new interface to read the RNG?  What's wrong with the old one?

I think your patch description should explain the purpose of the patch.
