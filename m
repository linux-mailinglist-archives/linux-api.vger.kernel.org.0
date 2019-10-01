Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF025C2B61
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 02:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfJAAkx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 20:40:53 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:12442 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfJAAkx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Sep 2019 20:40:53 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E4B4FA2044;
        Tue,  1 Oct 2019 02:40:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 9PZF1t-ogI4m; Tue,  1 Oct 2019 02:40:47 +0200 (CEST)
Date:   Tue, 1 Oct 2019 10:40:19 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Aleksa Sarai <asarai@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 2/4] clone3: switch to copy_struct_from_user()
Message-ID: <20191001004019.bnjtligwhdbl7vij@yavin.dot.cyphar.com>
References: <20190930191526.19544-1-asarai@suse.de>
 <20190930191526.19544-3-asarai@suse.de>
 <201909301640.4FC92294FF@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4cdmb4s5xhqgzz3m"
Content-Disposition: inline
In-Reply-To: <201909301640.4FC92294FF@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--4cdmb4s5xhqgzz3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-30, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Oct 01, 2019 at 05:15:24AM +1000, Aleksa Sarai wrote:
> > From: Aleksa Sarai <cyphar@cyphar.com>
> >=20
> > The change is very straightforward, and helps unify the syscall
> > interface for struct-from-userspace syscalls. Additionally, explicitly
> > define CLONE_ARGS_SIZE_VER0 to match the other users of the
> > struct-extension pattern.
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  include/uapi/linux/sched.h |  2 ++
> >  kernel/fork.c              | 34 +++++++---------------------------
> >  2 files changed, 9 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index b3105ac1381a..0945805982b4 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -47,6 +47,8 @@ struct clone_args {
> >  	__aligned_u64 tls;
> >  };
> > =20
> > +#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> > +
> >  /*
> >   * Scheduling policies
> >   */
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index f9572f416126..2ef529869c64 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2525,39 +2525,19 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_fla=
gs, unsigned long, newsp,
> >  #ifdef __ARCH_WANT_SYS_CLONE3
> >  noinline static int copy_clone_args_from_user(struct kernel_clone_args=
 *kargs,
> >  					      struct clone_args __user *uargs,
> > -					      size_t size)
> > +					      size_t usize)
> >  {
> > +	int err;
> >  	struct clone_args args;
> > =20
> > -	if (unlikely(size > PAGE_SIZE))
> > +	if (unlikely(usize > PAGE_SIZE))
> >  		return -E2BIG;
>=20
> I quickly looked through the earlier threads and couldn't find it, but
> I have a memory of some discussion about moving this test into the
> copy_struct_from_user() function itself? That would seems like a
> reasonable idea? ("4k should be enough for any structure!")

Yes (and this also seemed the most reasonable way to do it to me), but
the main counter-arguments which swayed me were:

 1. Putting it in the hands of the caller allows them to decide if they
    want to have a limit, because if you institute a limit in one kernel
    vintage then expanding it later will be less-than-ideally-smooth.

 2. There is no amplification, so doing copy_struct_from_user() for a
    really big usize boils down to the userspace program blocking for
    the kernel to check if some of your memory is zeroed. Thus there
    doesn't seem to be much DoS potential.

Not to mention that users of copy_struct_from_user() will end up doing
some kind of usize comparison anyway (to check if it's smaller than
the version-0 size).

> Either way:
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20
>=20
> > -
> > -	if (unlikely(size < sizeof(struct clone_args)))
> > +	if (unlikely(usize < CLONE_ARGS_SIZE_VER0))
> >  		return -EINVAL;
> > =20
> > -	if (unlikely(!access_ok(uargs, size)))
> > -		return -EFAULT;
> > -
> > -	if (size > sizeof(struct clone_args)) {
> > -		unsigned char __user *addr;
> > -		unsigned char __user *end;
> > -		unsigned char val;
> > -
> > -		addr =3D (void __user *)uargs + sizeof(struct clone_args);
> > -		end =3D (void __user *)uargs + size;
> > -
> > -		for (; addr < end; addr++) {
> > -			if (get_user(val, addr))
> > -				return -EFAULT;
> > -			if (val)
> > -				return -E2BIG;
> > -		}
> > -
> > -		size =3D sizeof(struct clone_args);
> > -	}
> > -
> > -	if (copy_from_user(&args, uargs, size))
> > -		return -EFAULT;
> > +	err =3D copy_struct_from_user(&args, sizeof(args), uargs, usize);
> > +	if (err)
> > +		return err;
> > =20
> >  	/*
> >  	 * Verify that higher 32bits of exit_signal are unset and that
> > --=20
> > 2.23.0
> >=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--4cdmb4s5xhqgzz3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZKgcAAKCRCdlLljIbnQ
EoJiAPsG4itrHQ5XO5zjlOeiD57T+Nb6ZfG9WzbCSY1LDI0wcAD+MPCUZzs1cNNE
KlkERzCb82aGD3s6EZipjiBQo04rRQ4=
=eLT6
-----END PGP SIGNATURE-----

--4cdmb4s5xhqgzz3m--
