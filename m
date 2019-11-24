Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5410828D
	for <lists+linux-api@lfdr.de>; Sun, 24 Nov 2019 10:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfKXJFM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Nov 2019 04:05:12 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:25853 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKXJFM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Nov 2019 04:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574586307;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NCcS9u41FbIM9Hbw16/dqmjn7AU8piAM0dAqvSlzR2Q=;
        b=GaM38xK45w2IXMhZlg3R5vfrqhoXIQYLVMeMhUzlbdESVrEA7Pq6lTa0F5TZMdbpqe
        2+/t3ute8u+BlAFfqS6EJgUJkbxg0tbg/H6cvMtv00wS7KgA2pOlzInXzInPhIqofcNH
        0KCrQ9NlXMNSZHBe6jzZ8uTNXwZs6LicoCBIFg9x7Jf4K234hhsErRgWDx0Q0wm+Vi5d
        gDQbNoPh0PiQmTRisjpLPcxDkwSxhzlM/Q32DjAXKN2kv6W+w6/X/qaemOzqBhjpRubI
        Yq4NitBltd+U5yYaUqiMUf6awVzxNKX71TODTRiAaLxbzATsTocuW6IRTaJ0IiFlYRCK
        fDdg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSbPHo="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAO92U5Vl
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 24 Nov 2019 10:02:30 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
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
Subject: Re: [PATCH v24 01/12] Linux Random Number Generator
Date:   Sun, 24 Nov 2019 10:02:43 +0100
Message-ID: <3143116.x4sn03gNaX@tauon.chronox.de>
In-Reply-To: <CACXcFmkBQAZd4bSfQvqeCsoTjMr0-uSjKciD6y9EkMN3c9ppJw@mail.gmail.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2369119.jSEA3qhmGI@positron.chronox.de> <CACXcFmkBQAZd4bSfQvqeCsoTjMr0-uSjKciD6y9EkMN3c9ppJw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Sonntag, 24. November 2019, 05:51:19 CET schrieb Sandy Harris:

Hi Sandy,

> Stephan M=FCller <smueller@chronox.de> wrote:
> > In an effort to provide a flexible implementation for a random number
> > generator that also ...
>=20
> As usual, some of your proposals make considerable sense to me &
> others do not, at least on first reading. I may have more comments
> after reflecting some.
>=20
> Meanwhile, a couple of things jump out at me:
> >  (a) When an interrupt occurs, the high-resolution time stamp is mixed
> >=20
> > into the LFSR. ...
> >=20
> >  (b) HID event data like the key stroke or the mouse coordinates are
> >=20
> > mixed into the LFSR. ...
> >=20
> >  (c) Device drivers may provide data that is mixed into the LFSR. ...
>=20
> Why into the LFSR instead of into the entropy pool?

The LFSR is the state transitioning function of the entropy pool. Thus, whe=
n=20
handing data to the LFSR, it is "mixed" into the entropy pool. Thus, the LR=
NG=20
should perform the action you would expect, i.e. mixing the data into the=20
entropy pool.

>=20
> > The LRNG allows the TRNG and secondary DRNG mechanism to be changed
> > at runtime.
>=20
> Why? This strikes me as pointless complication.

The reason for this is the construction definition of the German AIS 31.

The TRNG is considered to operate as an NTG.1 in the terms of AIS 31. The=20
secondary DRNG(s) act as a DRG.3 in terms of AIS 31.

AIS 31 requires that DRGs (including a DRG.3) must be seeded from either an=
=20
NTG.1 (i.e. the TRNG) or a PTG (a physical noise source which we do not hav=
e=20
in the kernel).

This implies that the TRNG (NTG.1) seeds the secondary DRNG (DRG.3) and thu=
s=20
would be compliant to AIS 31.

Since this construction method does not violate other construction methods,=
=20
such as the recommendations in SP800-90C, the LRNG architecture can be clai=
med=20
to be compliant with multiple different construction methods and requiremen=
ts=20
where the output of either the TRNG or the secondary DRNGs always provide=20
random data from a compliant RNG.

Note, this construction is only applied if the TRNG is selected and compile=
d.=20
If the TRNG is not present (i.e. not compiled based on the Linux kernel=20
compilation configuration), the secondary DRNGs seed directly from the entr=
opy=20
pool. Using this flexibility, the LRNG is intended to be able to serve=20
different use cases and requirements.
>=20
> > * high performance of interrupt handling code: The LRNG impact on the
> > interrupt handling has been reduced to a minimum. On one example
> > system, the LRNG interrupt handling code executes within an average
> > of 65 cycles whereas the existing /dev/random on the same device
> > takes about 97 cycles when measuring the execution time of
> > add_interrupt_randomness().
>=20
> Assuming you do this without sacrificing the input mixing, this
> would be worth submitting as a separate patch. Saving cycles
> on every interrupt definitely looks worth doing.
>=20
> > * lockless LFSR to collect raw entropy
>=20
> This too.

=46or both comments, the issue is that patches should always provide code t=
hat=20
compiles. The issue is that this logic cannot be extracted into a separate=
=20
patch without sacrificing the requirement to make it compile.

Though, the code you refer to is extracted into its own C file which allows=
 an=20
independent assessment: please see lrng_sw_noise.c whose purpose is to only=
=20
provide the high-performance interrupt handling code. The lockless LFSR is=
=20
provided with the lrng_pool.c with the function lrng_pool_lfsr_u32.

PS: For those two functions and the ChaCha20 DRNG I have another patch in t=
he=20
pipeline that will add power-on self tests which are automatically executed=
=20
during boot. Considering that these three functions are essential to the=20
maintenance of entropy, adding the self test for those should provide=20
additional assurance to users that the code runs properly.

PPS: If you want to study the operations of both, the high-performance=20
interrupt collection and the lockless LFSR, there is user space test code t=
hat=20
provides the implementation as a user space application: please see the tes=
t=20
code in [1] and use the code in:

=2D lfsr_demonstration.c: Full operational LFSR to generate arbitrary amoun=
ts of=20
data from arbitrary seed data.

=2D lfsr_testvector_generation.c: LFSR code that I used to generate self-te=
st=20
vectors for the pending patch

=2D time_storage.c: Test code for the high-performance interrupt handling c=
ode

In addition the essential ChaCha20 DRNG is available as a user space DRNG f=
or=20
study at [2].


[1] https://www.chronox.de/lrng.html

[2] https://www.chronox.de/chacha20_drng.html


Thank you very much for your considerations.

Ciao
Stephan


