Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965BEF9E2C
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2019 00:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLX1u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 18:27:50 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.104]:25896 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLX1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Nov 2019 18:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573601266;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=iqzxLkf9K+HSS4DGB5MgITWBOt1JRX4SRIPlx34+8UM=;
        b=k6e/sw/1717upMa3Mi3YWXjrstgYixIoVGQcJkw4UQRMySjYMOCdAAPgaqPIzEvlG2
        0LZGYpQ9w+2PdU+ySS68gKfxDXFEOQrqZL1HmsBRpIUSpQpHZER72XvKBB2UNqHnyClf
        BNK+4Dp2BzvexL/e4cPJrkLhXcKOhrDGcYWZGHhTnR+A0i+MTzm27Xf1vwh10UYsOZv+
        xQuqXyGTs2B8GOKKCY+pBfBNfdbVMzqUQuz/8hH8lh2EclHbu7F5uTtwSenHKDentodE
        Cn5kd1J8gWcCs8g0d6hmykJFvwcvY9DEBIou4El6jEXahhViuv0OtwSKcZoUr3hJPiqw
        Bgyg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmwdNLqV/Nz7PsNPEA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id N09a57vACNQaA5M
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 00:26:36 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v24 00/12] /dev/random - a new approach with full SP800-90B compliance
Date:   Wed, 13 Nov 2019 00:26:34 +0100
Message-ID: <1708605.HZ0Ruzqnhc@positron.chronox.de>
In-Reply-To: <3282061.iY3hP4IT6m@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <CALCETrVBzuOsDfaz5y3V4v+6xmeWufOYsOGnpZrRju6Pfsi6gg@mail.gmail.com> <3282061.iY3hP4IT6m@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Mittwoch, 13. November 2019, 00:03:47 CET schrieb Stephan M=FCller:

Hi Stephan,

> Am Dienstag, 12. November 2019, 16:33:59 CET schrieb Andy Lutomirski:
>=20
> Hi Andy,
>=20
> > On Mon, Nov 11, 2019 at 11:13 AM Stephan M=FCller <smueller@chronox.de>=
=20
wrote:
> > > The following patch set provides a different approach to /dev/random
> > > which
> > > is called Linux Random Number Generator (LRNG) to collect entropy wit=
hin
> > > the Linux kernel. The main improvements compared to the existing
> > > /dev/random is to provide sufficient entropy during boot time as well=
 as
> > > in virtual environments and when using SSDs. A secondary design goal =
is
> > > to limit the impact of the entropy collection on massive parallel
> > > systems
> > > and also allow the use accelerated cryptographic primitives. Also, all
> > > steps of the entropic data processing are testable.
> >=20
> > This is very nice!
> >=20
> > > The LRNG patch set allows a user to select use of the existing
> > > /dev/random
> > > or the LRNG during compile time. As the LRNG provides API and ABI
> > > compatible interfaces to the existing /dev/random implementation, the
> > > user can freely chose the RNG implementation without affecting kernel=
 or
> > > user space operations.
> > >=20
> > > This patch set provides early boot-time entropy which implies that no
> > > additional flags to the getrandom(2) system call discussed recently on
> > > the LKML is considered to be necessary.
> >=20
> > I'm uneasy about this.  I fully believe that, *on x86*, this works.
> > But on embedded systems with in-order CPUs, a single clock, and very
> > lightweight boot processes, most or all of boot might be too
> > deterministic for this to work.
>=20
> I agree that in such cases, my LRNG getrandom(2) would also block until t=
he
> LRNG thinks it collected 256 bits of entropy. However, I am under the
> impression that the LRNG collects that entropy faster that the existing
> /dev/ random implementation, even in this case.
>=20
> Nicolai is copied on this thread. He promised to have the LRNG tested on
> such a minimalistic system that you describe. I hope he could contribute
> some numbers from that test helping us to understand how much of a problem
> we face.
> > I have a somewhat competing patch set here:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=
=3Drand
> > om /kill-it
> >=20
> > (Ignore the "horrible test hack" and the debugfs part.)
> >=20
> > The basic summary is that I change /dev/random so that it becomes
> > functionally identical to getrandom(..., 0) -- in other words, it
> > blocks until the CRNG is initialized but is then identical to
> > /dev/urandom.
>=20
> This would be equal to the LRNG code without compiling the TRNG.
>=20
> > And I add getrandom(...., GRND_INSECURE) that is
> > functionally identical to the existing /dev/urandom: it always returns
> > *something* immediately, but it may or may not actually be
> > cryptographically random or even random at all depending on system
> > details.
>=20
> Ok, if it is suggested that getrandom(2) should also have a mode to behave
> exactly like /dev/urandom by not waiting until it is fully seeded, I am
> happy to add that.
>=20
> > In other words, my series simplifies the ABI that we support.  Right
> > now, we have three ways to ask for random numbers with different
> > semantics and we need to have to RNGs in the kernel at all time.  With
> > my changes, we have only two ways to ask for random numbers, and the
> > /dev/random pool is entirely gone.
>=20
> Again, I do not want to stand in the way of changing the ABI if this is t=
he
> agreed way. All I want to say is that the LRNG seemingly is initialized m=
uch
> faster than the existing /dev/random. If this is not fast enough for some
> embedded environments, I would not want to stand in the way to make their
> life easier.
>=20
> > Would you be amenable to merging this into your series (i.e. either
> > merging the code or just the ideas)?
>=20
> Absolutely. I would be happy to do that.
>=20
> Allow me to pull your code (I am currently behind a slow line) and review=
 it
> to see how best to integrate it.
>=20
> > This would let you get rid of
> > things like the compile-time selection of the blocking TRNG, since the
> > blocking TRNG would be entirely gone.
>=20
> Hm, I am not so sure we should do that.
>=20
> Allow me to explain: I am also collaborating on the European side with the
> German BSI. They love /dev/random as it is a "NTG.1" RNG based on their A=
IS
> 31 standard.
>=20
> In order to seed a deterministic RNG (like OpenSSL, GnuTLS, etc. which are
> all defined to be "DRG.3" or "DRG.2"), BSI mandates that the seed source =
is
> an NTG.1.
>=20
> By getting rid of the TRNG entirely and having /dev/random entirely behav=
ing
> like /dev/urandom or getrandom(2) without the GRND_RANDOM flag, the kernel
> would "only" provide a "DRG.3" type RNG. This type of RNG would be
> disallowed to seed another "DRG.3" or "DRG.2".
>=20
> In plain English that means that for BSI's requirements, if the TRNG is g=
one
> there would be no native seed source on Linux any more that can satisfy t=
he
> requirement. This is the ultimate reason why I made the TRNG compile-time
> selectable: to support embedded systems but also support use cases like t=
he
> BSI case.
>=20
> Please consider that I maintain a study over the last years for BSI trying
> to ensure that the NTG.1 property is always met [1] [2]. The sole purpose
> of that study is around this NTG.1.
>=20
> > Or do you think that a kernel-provided blocking TRNG is a genuinely
> > useful thing to keep around?
>=20
> Yes, as I hope I explained it appropriately above, there are standardizat=
ion
> requirements that need the TRNG.
>=20
> PS: When I was forwarding Linus' email on eliminating the blocking_pool to
> BSI, I saw unhappy faces. :-)
>=20
> I would like to help both sides here.
>=20
> [1]
> https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studies/
> LinuxRNG/NTG1_Kerneltabelle_EN.pdf?__blob=3DpublicationFile&v=3D3
>=20
> [2]
> https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studies/
> LinuxRNG/NTG1_Kerneltabelle_EN.pdf?__blob=3DpublicationFile&v=3D3

Sorry, the copy did not work:

[2] https://bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studies/
LinuxRNG/LinuxRNG_EN.pdf?__blob=3DpublicationFile&v=3D16
>=20
> Ciao
> Stephan


Ciao
Stephan


