Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4801918AE1D
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 09:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgCSILN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 04:11:13 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:43130 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSILN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 04:11:13 -0400
Received: by mout-p-202.mailbox.org (Postfix, from userid 51)
        id 48jfk71G2BzQlGs; Thu, 19 Mar 2020 08:10:17 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48hb5f6dqzzQlGj;
        Tue, 17 Mar 2020 15:24:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id zRiPUP04n628; Tue, 17 Mar 2020 15:24:19 +0100 (CET)
Date:   Wed, 18 Mar 2020 01:23:50 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200317142350.ssraami3a4vnk5po@yavin>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAKgNAkh7=2Noyn0o3880xbbi4w5oiwqs9ibTYLtheqzxne3mbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iakfd3bjzr4y3tmr"
Content-Disposition: inline
In-Reply-To: <CAKgNAkh7=2Noyn0o3880xbbi4w5oiwqs9ibTYLtheqzxne3mbQ@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--iakfd3bjzr4y3tmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-17, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> [CC +=3D linux-api; please CC on future versions]
>=20
> On Tue, 17 Mar 2020 at 09:32, Adrian Reber <areber@redhat.com> wrote:
> > Requiring nanoseconds as well as seconds for two clocks during clone3()
> > means that it would require 4 additional members to 'struct clone_args':
> >
> >         __aligned_u64 tls;
> >         __aligned_u64 set_tid;
> >         __aligned_u64 set_tid_size;
> > +       __aligned_u64 boottime_offset_seconds;
> > +       __aligned_u64 boottime_offset_nanoseconds;
> > +       __aligned_u64 monotonic_offset_seconds;
> > +       __aligned_u64 monotonic_offset_nanoseconds;
> >  };
> >
> > To avoid four additional members to 'struct clone_args' this patchset
> > uses another approach:
> >
> >         __aligned_u64 tls;
> >         __aligned_u64 set_tid;
> >         __aligned_u64 set_tid_size;
> > +       __aligned_u64 timens_offset;
> > +       __aligned_u64 timens_offset_size;
> >  };
> >
> > timens_offset is a pointer to an array just as previously done with
> > set_tid and timens_offset_size is the size of the array.
> >
> > The timens_offset array is expected to contain a struct like this:
> >
> > struct set_timens_offset {
> >        int clockid;
> >        struct timespec val;
> > };
> >
> > This way it is possible to pass the information of multiple clocks with
> > seconds and nanonseconds to clone3().
> >
> > To me this seems the better approach, but I am not totally convinced
> > that it is the right thing. If there are other ideas how to pass two
> > clock offsets with seconds and nanonseconds to clone3() I would be happy
> > to hear other ideas.

While I agree this does make the API cleaner, I am a little worried that
it risks killing some of the ideas we discussed for seccomp deep
inspection. In particular, having a pointer to variable-sized data
inside the struct means that now the cBPF program can't just be given a
copy of the struct data from userspace to check.

I'm sure it's a solveable problem (and it was one we were bound to run
into at some point), it'll just mean we'll need a more complicated way
of filtering such syscalls.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--iakfd3bjzr4y3tmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXnDdcwAKCRCdlLljIbnQ
EkDfAP4oqBtz79HrO5K84v1Oc+8BJnHtioYyEbAw6bApHUzizwEA/y+FnNZfg354
lxpGstBAS/4Qjyki4qqo9BOYoQimPwI=
=qITz
-----END PGP SIGNATURE-----

--iakfd3bjzr4y3tmr--
