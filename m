Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965501BF1A0
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgD3Hhp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:37:45 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:15326 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgD3Hhp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 03:37:45 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 49CS064LPwzKmtQ;
        Thu, 30 Apr 2020 09:37:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 81pM1XsQLRWv; Thu, 30 Apr 2020 09:37:39 +0200 (CEST)
Date:   Thu, 30 Apr 2020 17:37:28 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Arseny Maslennikov <ar@cs.msu.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Subject: Re: [PATCH v3 4/7] linux/signal.h: Ignore SIGINFO by default in new
 tasks
Message-ID: <20200430073728.36zehjhqmcllglbu@yavin.dot.cyphar.com>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
 <20200430064301.1099452-5-ar@cs.msu.ru>
 <780cb05e-a749-77a0-dabc-bd09982aa028@suse.cz>
 <20200430071437.x3ilwkh3lyf4iq6u@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v3ogqyuov3acrw6t"
Content-Disposition: inline
In-Reply-To: <20200430071437.x3ilwkh3lyf4iq6u@wittgenstein>
X-Rspamd-Queue-Id: 0D1FC1788
X-Rspamd-Score: -9.47 / 15.00 / 15.00
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--v3ogqyuov3acrw6t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-30, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Thu, Apr 30, 2020 at 08:53:56AM +0200, Jiri Slaby wrote:
> > On 30. 04. 20, 8:42, Arseny Maslennikov wrote:
> > > This matches the behaviour of other Unix-like systems that have SIGIN=
FO
> > > and causes less harm to processes that do not install handlers for th=
is
> > > signal, making the keyboard status character non-fatal for them.
> > >=20
> > > This is implemented with the assumption that SIGINFO is defined
> > > to be equivalent to SIGPWR; still, there is no reason for PWR to
> > > result in termination of the signal recipient anyway =E2=80=94 it doe=
s not
> > > indicate there is a fatal problem with the recipient's execution
> > > context (like e.g. FPE/ILL do), and we have TERM/KILL for explicit
> > > termination requests.
> > >=20
> > > To put it another way:
> > > The only scenario where system behaviour actually changes is when the
> > > signal recipient has default disposition for SIGPWR. If a process
> > > chose to interpret a SIGPWR as an incentive to cleanly terminate, it
> > > would supply its own handler =E2=80=94 and this commit does not affec=
t processes
> > > with non-default handlers.
> > >=20
> > > Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> > > ---
> > >  include/linux/signal.h | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > > index 05bacd2ab..dc31da8fc 100644
> > > --- a/include/linux/signal.h
> > > +++ b/include/linux/signal.h
> > > @@ -369,7 +369,7 @@ extern bool unhandled_signal(struct task_struct *=
tsk, int sig);
> > >   *	|  SIGSYS/SIGUNUSED  |	coredump 	|
> > >   *	|  SIGSTKFLT         |	terminate	|
> > >   *	|  SIGWINCH          |	ignore   	|
> > > - *	|  SIGPWR            |	terminate	|
> > > + *	|  SIGPWR            |	ignore   	|
> >=20
> > You need to update signal.7 too:
> > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man7/s=
ignal.7#n285
>=20
> (I fail this whole thread via b4 and it appears that a bunch of messages
> are missing on lore. Might just be delay though.)
>=20
> How this is this not going to break userspace? Just for a start,
> SIGPWR (for better or worse) was used for a long time by some
> sandboxing/container runtimes to shutdown a process and still is.

To play Devil's advocate -- pid1 has also always had a default-ignore
signal mask (which included SIGPWR), so any pid1 that obeyed SIGPWR
already had a non-default signal mask (and thus wouldn't be affected by
this patch).

But I do agree that this seems like a strange change to make (SIGPWR
seems like a signal you don't want to ignore by default). Unfortunately
the fact that it appears to always be equal to SIGINFO means that while
SIGINFO (to me at least) seems like it should be a no-op, the necessary
SIGPWR change makes it harder to justify IMHO.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--v3ogqyuov3acrw6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXqqANgAKCRCdlLljIbnQ
Eub2AQCluzOxSj+tvwJotIXGcOQKLxQUkinBm2PLac1iqBa8FgD9Gura/pVR8Oqi
RNyo5p3+mxhBzhlOrn6o3DjEbYe3FA0=
=lC9X
-----END PGP SIGNATURE-----

--v3ogqyuov3acrw6t--
