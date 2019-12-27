Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9012B584
	for <lists+linux-api@lfdr.de>; Fri, 27 Dec 2019 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfL0PPX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Dec 2019 10:15:23 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:32214 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0PPW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Dec 2019 10:15:22 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 47kr3q4F8GzKmfB;
        Fri, 27 Dec 2019 16:15:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id FoRWcIzpKAMD; Fri, 27 Dec 2019 16:15:13 +0100 (CET)
Date:   Sat, 28 Dec 2019 02:15:01 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
Message-ID: <20191227151501.osy2m6o6p6odzk74@yavin.dot.cyphar.com>
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal>
 <20191226115245.usf7z5dkui7ndp4w@wittgenstein>
 <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
 <57C06925-0CC6-4251-AD57-8FF1BC28F049@ubuntu.com>
 <20191227022446.37e64ag4uaqms2w4@yavin.dot.cyphar.com>
 <20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com>
 <20191227114725.xsacnaoaaxdv6yg3@wittgenstein>
 <CAMp4zn8iMsRvDoDtrotfnEm2_UUULH9VRiR6q9u8CS4qham2Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qp3epnoas5ruktga"
Content-Disposition: inline
In-Reply-To: <CAMp4zn8iMsRvDoDtrotfnEm2_UUULH9VRiR6q9u8CS4qham2Eg@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--qp3epnoas5ruktga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-27, Sargun Dhillon <sargun@sargun.me> wrote:
> On Fri, Dec 27, 2019 at 6:47 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Fri, Dec 27, 2019 at 01:31:31PM +1100, Aleksa Sarai wrote:
> > > On 2019-12-27, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > >
> > > Scratch that -- as Tycho just mentioned, there is un-named padding in
> > > the struct so check_zeroed_user() is the wrong thing to do. But this
> >
> > Hm, I don't think so.
> > I understood Tycho's point as _if_ there ever is padding then this would
> > not be zeroed.
> > Right now, there is no padding since the struct is correctly padded:
> >
> > struct seccomp_data {
> >         int nr;
> >         __u32 arch;
> >         __u64 instruction_pointer;
> >         __u64 args[6];
> > };
> >
> > struct seccomp_notif {
> >         __u64 id;
> >         __u32 pid;
> >         __u32 flags;
> >         struct seccomp_data data;
> > };
> >
> > which would be - using pahole:
> >
> > struct seccomp_data {
> >         int                        nr;                   /*     0     4=
 */
> >         __u32                      arch;                 /*     4     4=
 */
> >         __u64                      instruction_pointer;  /*     8     8=
 */
> >         __u64                      args[6];              /*    16    48=
 */
> >
> >         /* size: 64, cachelines: 1, members: 4 */
> > };
> > struct seccomp_notif {
> >         __u64                      id;                   /*     0     8=
 */
> >         __u32                      pid;                  /*     8     4=
 */
> >         __u32                      flags;                /*    12     4=
 */
> >         struct seccomp_data data;                        /*    16    64=
 */
> >
> >         /* size: 80, cachelines: 2, members: 4 */
> >         /* last cacheline: 16 bytes */
> > };
> >
> > The only worry would be a 2byte int type but there's no architecture
> > we support which does this right now afaict.
> >
> > > also will make extensions harder to deal with because (presumably) th=
ey
> > > will also have un-named padding, making copy_struct_from_user() the
> >
> > This all will be a non-issue if we just use __u64 for extensions.
> >
> > My point about using copy_struct_from_user() was that we should verify
> > that _all_ fields are uninitialized and not just the flags argument
> > since we might introduce a flags argument that requires another already
> > existing member in seccomp_notif to be set to a value. We should do this
> > change now so we don't have to risk breaking someone in the future.
> >
> > I'm trying to get at least Mozilla/Firefox off of their crazy
> > SECCOMP_RET_TRAP way of implementing their broker onto the user notifier
> > and they will likely need some extensions. That includes the pidfd stuff
> > for seccomp that Sargun will likely be doing and the new pidfd_getfd()
> > syscall. So it's not unlikely that we might need other already existing
> > fields in that struct to be set to some value.
> >
> > I don't particulary care how we do it:
> > - We can do a simple copy_from_user() and check each field individually.
>=20
> Just doing a simple copy_from_user, and for now, calling memchr_inv
> on the whole thing. We can drop the memset, and just leave a note to
> indicate that if unpadded fields are introduced in the future, this struc=
ture
> must be manually zeroed out. Although, this might be laying a trap for
> ourselves.
>=20
> This leaves us in a good position for introducing a flag field in the fut=
ure.
> All we have to do is change the memchr_inv from checking on an
> entire struct basis to checking on a per-field basis.

There is no need to do memchr_inv() on copy_from_user() to check for
zero-ness. That's the entire point of check_zeroed_user() -- to not need
to do it that way.

> > - Use copy_struct_from_user().
> >   That is safe to do right now since there is no padding afaict and
> >   it'll automatically verify new fields as well.
> >   If I understand the worry correctly then the argument against
> >   copy_struct_from_user() here is that there might be padding introduced
> >   and userspace will not do an explicit memset() but rather rely on an
> >   empty inializer {} and will _accidently_ pass down a struct which has
> >   __all fields cleared__ but __uninitialized padding__ and we tell them
> >   EINVAL? That can only happen if we introduce padding in the struct
> >   which I'd argue we just don't do. That'll be in line with what we
> >   require from our ABIs already anyway.


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qp3epnoas5ruktga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXgYf8wAKCRCdlLljIbnQ
ElhMAP4zLWE+r++uvi/UC9ZcIHcddNH68CbKzBsKVgf88RALlAEAgjfH80XjQsXo
QCVHPhWjgbUafWOoPCP7x97K25qTVAc=
=aqat
-----END PGP SIGNATURE-----

--qp3epnoas5ruktga--
