Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 146681021A4
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 11:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbfKSKH4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Nov 2019 05:07:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfKSKHz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 19 Nov 2019 05:07:55 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E02722360
        for <linux-api@vger.kernel.org>; Tue, 19 Nov 2019 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574158073;
        bh=raQvysGezMOTdzZhLbXQVgeelzwMcf+XsBZN45+Jnr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RjQMR4rU1In9lM+kAb4soSF9t2AJfvrcdffTs2mzM8uL6Cad3vzhxR46A+cnPjzxn
         IbVrdWOO3lWPGCxxz4HG/NKbdQqe5Ky2v0SIN7DghQNfbG7hDIRteoctcksF2NfgXM
         RG9O1yHUUaXaQFTAOb31qHoXc7t73yJh86cTH7t8=
Received: by mail-wr1-f47.google.com with SMTP id n1so23028144wra.10
        for <linux-api@vger.kernel.org>; Tue, 19 Nov 2019 02:07:53 -0800 (PST)
X-Gm-Message-State: APjAAAV12VABmzizpriv0+IdAjJKfHCVFom/CoTqq8rG+G5km3frhEBq
        dPKXF/KzSzkFoZAcp19Ce785WTbUEtXo6SyJXy87Vg==
X-Google-Smtp-Source: APXvYqzIDjHYabEFDKNGNz1GeBkQRlFBAp+pdbYkngDyg4rogH0rFpf7wiaTn8LWmx1If1ARFOOJ5Qjs8JwSWm8TNDM=
X-Received: by 2002:a5d:490b:: with SMTP id x11mr34652314wrq.111.1574158071890;
 Tue, 19 Nov 2019 02:07:51 -0800 (PST)
MIME-Version: 1.0
References: <5390778.VeFRgus4bQ@positron.chronox.de> <DDB907EA-3FCC-40C7-B55B-A84BC77FD7A1@amacapital.net>
 <3159012.PsEOTp9LqO@positron.chronox.de>
In-Reply-To: <3159012.PsEOTp9LqO@positron.chronox.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 Nov 2019 02:07:40 -0800
X-Gmail-Original-Message-ID: <CALCETrUKDO1LSMnHNcPiAFQh2ri6saRiRBi9b5e699cm1_Mgsw@mail.gmail.com>
Message-ID: <CALCETrUKDO1LSMnHNcPiAFQh2ri6saRiRBi9b5e699cm1_Mgsw@mail.gmail.com>
Subject: Re: [PATCH v25 10/12] LRNG - add TRNG support
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

On Sun, Nov 17, 2019 at 3:11 AM Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
>
> Am Samstag, 16. November 2019, 17:09:09 CET schrieb Andy Lutomirski:
>
> Hi Andy,
>
> > > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.de=
> wrote:
> > >
> > > =EF=BB=BFThe True Random Number Generator (TRNG) provides a random nu=
mber
> > > generator with prediction resistance (SP800-90A terminology) or an NT=
G.1
> > > (AIS 31 terminology).
> >
> > ...
> >
> > > The secondary DRNGs seed from the TRNG if it is present. In addition,
> > > the /dev/random device accesses the TRNG.
> > >
> > > If the TRNG is disabled, the secondary DRNGs seed from the entropy po=
ol
> > > and /dev/random behaves like getrandom(2).
> >
> > As mentioned before, I don=E2=80=99t like this API.  An application tha=
t, for some
> > reason, needs a TRNG, should have an API by which it either gets a TRNG=
 or
> > an error. Similarly, an application that wants cryptographically secure
> > random numbers efficiently should have an API that does that.  With you=
r
> > design, /dev/random tries to cater to both use cases, but one of the us=
e
> > cases fails depending on kernel config.
> >
> > I think /dev/random should wait for enough entropy to initialize the sy=
stem
> > but should not block after that. A TRNG should have an entirely new API
> > that is better than /dev/random.
>
> I apologize for the misunderstanding. I assumed we would introduce such /=
dev/
> true_random at a later stage.
>
> If you agree, I can certainly add /dev/true_random right now that links w=
ith
> the TRNG and make /dev/random behave as discussed, i.e. behave exactly li=
ke
> getrandom(..., 0);

Given that your series is already a decently large ABI change, I think
it would be polite to users to make all the anticipated changes all at
once to reduce the amount of churn everyone needs to deal with.

>
> As this would introduce a new device file now, is there a special process=
 that
> I need to follow or do I need to copy? Which major/minor number should I =
use?
>
> Looking into static const struct memdev devlist[] I see
>
>          [8] =3D { "random", 0666, &random_fops, 0 },
>          [9] =3D { "urandom", 0666, &urandom_fops, 0 },
>
> Shall a true_random be added here with [10]?

I am not at all an expert on chardevs, but this sounds generally
reasonable.  gregkh is probably the real authority here.
