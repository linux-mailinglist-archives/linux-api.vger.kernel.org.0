Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA9FA7EE
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2019 05:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMEZ4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 23:25:56 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:32324 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKMEZ4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Nov 2019 23:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573619151;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fweAIs1NsQUyJq3CnTKSiNwVcFJ1aHqrYO1LnCTNAwI=;
        b=EvkwOakq9oY4TsH9JsiTYOV5dmhFZcry0bk7sn8zFXuNz7rlEBPXOLXzLqIrUvtPMi
        eF5dSgN3sTKFKXVcEL4jvNtRP6wegxFcg5bEppoQwoGip0saOukCXzzPqmWH0CsrWacL
        oAbjRFFyu5BYELXTMlPmzw/nmqAY5fKPfhGlbLOriH/kbacN7mqN3W6io4DH3Llsltav
        fET0OiWgHAosPhrWSu1qrfEoDicR7LZ6EU/KeBZmvyYNE0/3Rkthof3b2maxHbnJI8h0
        mT7egWnZy1z/ViLjGpRzlm482o1/WjLbUDWXYWtPnYkG/EHgOv/0hZRVZUwPgTtJrgUu
        BOiA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmwdNLqV/Nz7PsNPEA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id N09a57vAD4OTATE
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 05:24:29 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
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
Subject: Re: [PATCH v24 00/12] /dev/random - a new approach with full SP800-90B compliance
Date:   Wed, 13 Nov 2019 05:24:26 +0100
Message-ID: <3208655.cZiRAY37Id@positron.chronox.de>
In-Reply-To: <CALCETrVBzuOsDfaz5y3V4v+6xmeWufOYsOGnpZrRju6Pfsi6gg@mail.gmail.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <CALCETrVBzuOsDfaz5y3V4v+6xmeWufOYsOGnpZrRju6Pfsi6gg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 12. November 2019, 16:33:59 CET schrieb Andy Lutomirski:

Hi Andy,

> On Mon, Nov 11, 2019 at 11:13 AM Stephan M=FCller <smueller@chronox.de> w=
rote:
> > The following patch set provides a different approach to /dev/random wh=
ich
> > is called Linux Random Number Generator (LRNG) to collect entropy within
> > the Linux kernel. The main improvements compared to the existing
> > /dev/random is to provide sufficient entropy during boot time as well as
> > in virtual environments and when using SSDs. A secondary design goal is
> > to limit the impact of the entropy collection on massive parallel syste=
ms
> > and also allow the use accelerated cryptographic primitives. Also, all
> > steps of the entropic data processing are testable.
>=20
> This is very nice!
>=20
> > The LRNG patch set allows a user to select use of the existing /dev/ran=
dom
> > or the LRNG during compile time. As the LRNG provides API and ABI
> > compatible interfaces to the existing /dev/random implementation, the
> > user can freely chose the RNG implementation without affecting kernel or
> > user space operations.
> >=20
> > This patch set provides early boot-time entropy which implies that no
> > additional flags to the getrandom(2) system call discussed recently on
> > the LKML is considered to be necessary.
>=20
> I'm uneasy about this.  I fully believe that, *on x86*, this works.
> But on embedded systems with in-order CPUs, a single clock, and very
> lightweight boot processes, most or all of boot might be too
> deterministic for this to work.
>=20
> I have a somewhat competing patch set here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=3Dr=
andom
> /kill-it
>=20
> (Ignore the "horrible test hack" and the debugfs part.)
>=20
> The basic summary is that I change /dev/random so that it becomes
> functionally identical to getrandom(..., 0) -- in other words, it
> blocks until the CRNG is initialized but is then identical to
> /dev/urandom.  And I add getrandom(...., GRND_INSECURE) that is
> functionally identical to the existing /dev/urandom: it always returns
> *something* immediately, but it may or may not actually be
> cryptographically random or even random at all depending on system
> details.
>=20
> In other words, my series simplifies the ABI that we support.  Right
> now, we have three ways to ask for random numbers with different
> semantics and we need to have to RNGs in the kernel at all time.  With
> my changes, we have only two ways to ask for random numbers, and the
> /dev/random pool is entirely gone.
>=20
> Would you be amenable to merging this into your series (i.e. either
> merging the code or just the ideas)?  This would let you get rid of
> things like the compile-time selection of the blocking TRNG, since the
> blocking TRNG would be entirely gone.

I pulled your code and found the following based on my explanation that I=20
would suggest to keep the TRNG at least as an option.

=2D 7d54ef8512b06baf396f12584f7f48a9558ecd0f does not seem applicable: I al=
so do=20
have an equivalent "lrng_init_wait" wait queue. This wait queue is used to =
let=20
in-kernel users wait until the LRNG obtained 128 bits of entropy. In additi=
on,=20
this wait queue is used to let user space is invoked after the LRNG has=20
received 256 bits of entropy (which implies that the kernel waiters are=20
invoked earlier). In kernel waiters are all that call wait_for_random_bytes=
=20
and its derivatives. User space callers have to call getrandom(..., 0); to =
be=20
registered in this wait queue. So, I think the wakeup calls I have in the L=
RNG=20
for lrng_init_wait should remain.

=2D 6a26a3146e5fb90878dca9fde8caa1ca4233156a: My handler for /dev/urandom a=
nd=20
getrandom(..., 0) are using one callback which issues a warning in both use=
=20
cases (see lrng_sdrng_read). So I think this patch may not be applicable as=
=20
the LRNG code implements warning about being unseeded.

=2D 3e8e159da49b44ae0bb08e68fa2be760722fa033: I am happy to take that code =
which=20
would almost directly apply. The last hunk however would be:

if (!(flags & GRND_INSECURE) && unlikely(!lrng_state_operational())) {

=3D=3D> Shall I apply it to my code base? If yes, how shall the changes to=
=20
random.h be handled?


=2D 920e97e7fc508e6f0da9c7dec94c8073fd63ab4d: I would pass on this patch du=
e to=20
the following: it unconditionally starts removing the access to the TRNG (t=
he=20
LRNG's logical equivalent to the blocking_pool). As patch 10/12 of the LRNG=
=20
patch series provides the TRNG that is a compile time option, your patch wo=
uld=20
logically and functionally be equivalent when deselecting=20
CONFIG_LRNG_TRNG_SUPPORT in the LRNG without any further changes to the LRN=
G=20
code.

=2D 693b9ffdf0fdc93456b5ad293ac05edf240a531b: This patch is applicable to t=
he=20
LRNG. In case CONFIG_LRNG_TRNG_SUPPORT is not set, the TRNG is not present.=
=20
Yet, the /dev/random and getrandom(GRND_RANDOM) would behave blocked until=
=20
fully initialized. I have now added the general blocking until the LRNG is=
=20
fully initialized to the common /dev/random and getrandom(GRND_RANDOM)=20
interface function of lrng_trng_read_common. With that, the LRNG would be=20
fully equivalent to this patch if CONFIG_LRNG_TRNG_SUPPORT is not set.

=2D 66f660842ec6d34134b9c3c1c9c65972834797f6: This patch is implicit with=20
CONFIG_LRNG_TRNG_SUPPORT being not set.

=2D d8f59b5c25af22fb9d85b7fa96de601ea03f2eac: This patch is not applicable =
to=20
the LRNG as the deactivation of CONFIG_LRNG_TRNG_SUPPORT implies that there=
=20
should be no unused code left in the LRNG.

=2D 4046ac638761821aef67af10537ebcbc80715785: In theory that patch is appli=
cable=20
to the LRNG as well. The LRNG has the lrng_read_wait queue. If=20
CONFIG_LRNG_TRNG_SUPPORT is not set, there will never be the code triggered=
 to=20
add a caller to this wait queue. To avoid cluttering the LRNG code with=20
ifdefs, may I suggest to leave these several lines even though it is dead=20
code?



Bottom line: the only patch that I seems to be relevant and that I would be=
=20
happy to apply is the one adding GRND_INSECURE. All other patches are=20
implicitly covered by deselecting CONFIG_LRNG_TRNG_SUPPORT.

By making the TRNG compile-time selectable, I was hoping to serve all users=
: I=20
wanted to cover the conclusions of the discussion to remove the blocking_po=
ol.=20
On the other hand, however, I want to support requirements that need the=20
blocking behavior.

The current LRNG patch set, however, defaults to Y for=20
CONFIG_LRNG_TRNG_SUPPORT. I would see no issue if it defaults to N.


Thank you very much.

Ciao
Stephan


