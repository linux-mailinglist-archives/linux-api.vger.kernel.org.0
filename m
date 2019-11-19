Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B9C10223C
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 11:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfKSKsz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Nov 2019 05:48:55 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:30305 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSKsz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 Nov 2019 05:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574160530;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=gPjxvO5Rr/ZhzjVabnFPel2PR7oXPN4jAOJIkIfrL3w=;
        b=V5mI8M5g/zcmQMfBuQScL5pLLfo2BcTLYpDkE8qc0aS3ZflQGszP+JFBsRJL3wYH6O
        qsBI4Lsf0O26+2t2ARyJP1VanbNf8UulxP347HJnpRl2LyVbqzQSV/V+afYDIpD7QT+H
        qOlyMfp8A4fAw7SqfG+SXnwZ9mVEdUYJppfQG00vvX6F3JzVXf08mLSDOv6BDkxLmrqN
        n5+JdwnSf5/YkBVV6tgPqj6ARtTHBoM4gPjDVomVTjYXzb/tttvhZRFf9K/Y2uJEHxba
        VP5WzIEIwpd6LW4v0fMmB+qYpvI7O6hz7Z43r5NOMuKRvGFq7N403cc4X7scCMQrG+RC
        0H8A==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIPmLqL6mXsiNby0r49Q+bn6Gzw6e9E9jMEY/jj9Sk"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id N09a57vAJAkqepr
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 19 Nov 2019 11:46:52 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Andy Lutomirski <luto@kernel.org>
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
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 10/12] LRNG - add TRNG support
Date:   Tue, 19 Nov 2019 11:46:51 +0100
Message-ID: <25235737.Vo4cOZQZay@tauon.chronox.de>
In-Reply-To: <CALCETrUKDO1LSMnHNcPiAFQh2ri6saRiRBi9b5e699cm1_Mgsw@mail.gmail.com>
References: <5390778.VeFRgus4bQ@positron.chronox.de> <3159012.PsEOTp9LqO@positron.chronox.de> <CALCETrUKDO1LSMnHNcPiAFQh2ri6saRiRBi9b5e699cm1_Mgsw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 19. November 2019, 11:07:40 CET schrieb Andy Lutomirski:

Hi Andy,

> On Sun, Nov 17, 2019 at 3:11 AM Stephan M=C3=BCller <smueller@chronox.de>=
 wrote:
> > Am Samstag, 16. November 2019, 17:09:09 CET schrieb Andy Lutomirski:
> >=20
> > Hi Andy,
> >=20
> > > > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.=
de>
> > > > wrote:
> > > >=20
> > > > =EF=BB=BFThe True Random Number Generator (TRNG) provides a random =
number
> > > > generator with prediction resistance (SP800-90A terminology) or an
> > > > NTG.1
> > > > (AIS 31 terminology).
> > >=20
> > > ...
> > >=20
> > > > The secondary DRNGs seed from the TRNG if it is present. In additio=
n,
> > > > the /dev/random device accesses the TRNG.
> > > >=20
> > > > If the TRNG is disabled, the secondary DRNGs seed from the entropy
> > > > pool
> > > > and /dev/random behaves like getrandom(2).
> > >=20
> > > As mentioned before, I don=E2=80=99t like this API.  An application t=
hat, for
> > > some
> > > reason, needs a TRNG, should have an API by which it either gets a TR=
NG
> > > or
> > > an error. Similarly, an application that wants cryptographically secu=
re
> > > random numbers efficiently should have an API that does that.  With y=
our
> > > design, /dev/random tries to cater to both use cases, but one of the =
use
> > > cases fails depending on kernel config.
> > >=20
> > > I think /dev/random should wait for enough entropy to initialize the
> > > system
> > > but should not block after that. A TRNG should have an entirely new A=
PI
> > > that is better than /dev/random.
> >=20
> > I apologize for the misunderstanding. I assumed we would introduce such
> > /dev/ true_random at a later stage.
> >=20
> > If you agree, I can certainly add /dev/true_random right now that links
> > with the TRNG and make /dev/random behave as discussed, i.e. behave
> > exactly like getrandom(..., 0);
>=20
> Given that your series is already a decently large ABI change, I think
> it would be polite to users to make all the anticipated changes all at
> once to reduce the amount of churn everyone needs to deal with.

I fully agree with that. This is the reason for my question to ask for how =
to=20
approach adding such additional interface for the TRNG. Considering that th=
ere=20
are use cases for the blocking interfaces, I would like to have it present=
=20
from the start.

That said, are you planning to keep the blocking_pool considering our=20
discussion?

But may I ask why you say that there are ABI changes? The LRNG set tries to=
 be=20
100% API and ABI compliant to the existing random.c interfaces.

The only change is the runtime-behavior (e.g. time when something is seeded=
),=20
performance of the interrupt handling and the kernel/user interfaces that m=
ay=20
be noticeable by users. I.e. there are timing changes, but no technical=20
changes.

The LRNG though would add one optional interface for kernel internal use an=
d=20
then the discussed /dev/true_random interface.
>=20
> > As this would introduce a new device file now, is there a special proce=
ss
> > that I need to follow or do I need to copy? Which major/minor number
> > should I use?
> >=20
> > Looking into static const struct memdev devlist[] I see
> >=20
> >          [8] =3D { "random", 0666, &random_fops, 0 },
> >          [9] =3D { "urandom", 0666, &urandom_fops, 0 },
> >=20
> > Shall a true_random be added here with [10]?
>=20
> I am not at all an expert on chardevs, but this sounds generally
> reasonable.  gregkh is probably the real authority here.

Thank you for the hint. Then I would like to wait for Greg on this.

Ciao
Stephan


