Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE66D2830
	for <lists+linux-api@lfdr.de>; Thu, 10 Oct 2019 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbfJJLk2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 07:40:28 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:19131 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732944AbfJJLk2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 Oct 2019 07:40:28 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 61D8BA1848;
        Thu, 10 Oct 2019 13:40:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id wqXRyBJtFPSM; Thu, 10 Oct 2019 13:40:18 +0200 (CEST)
Date:   Thu, 10 Oct 2019 22:40:07 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-2-cyphar@cyphar.com>
 <87eezkx2y7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6pornvxjev4s7kei"
Content-Disposition: inline
In-Reply-To: <87eezkx2y7.fsf@mpe.ellerman.id.au>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--6pornvxjev4s7kei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-10, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Aleksa Sarai <cyphar@cyphar.com> writes:
> > A common pattern for syscall extensions is increasing the size of a
> > struct passed from userspace, such that the zero-value of the new fields
> > result in the old kernel behaviour (allowing for a mix of userspace and
> > kernel vintages to operate on one another in most cases).
> >
> > While this interface exists for communication in both directions, only
> > one interface is straightforward to have reasonable semantics for
> > (userspace passing a struct to the kernel). For kernel returns to
> > userspace, what the correct semantics are (whether there should be an
> > error if userspace is unaware of a new extension) is very
> > syscall-dependent and thus probably cannot be unified between syscalls
> > (a good example of this problem is [1]).
> >
> > Previously there was no common lib/ function that implemented
> > the necessary extension-checking semantics (and different syscalls
> > implemented them slightly differently or incompletely[2]). Future
> > patches replace common uses of this pattern to make use of
> > copy_struct_from_user().
> >
> > Some in-kernel selftests that insure that the handling of alignment and
> > various byte patterns are all handled identically to memchr_inv() usage.
> ...
> > diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> > index 67bcd5dfd847..950ee88cd6ac 100644
> > --- a/lib/test_user_copy.c
> > +++ b/lib/test_user_copy.c
> > @@ -31,14 +31,133 @@
> ...
> > +static int test_check_nonzero_user(char *kmem, char __user *umem, size=
_t size)
> > +{
> > +	int ret =3D 0;
> > +	size_t start, end, i;
> > +	size_t zero_start =3D size / 4;
> > +	size_t zero_end =3D size - zero_start;
> > +
> > +	/*
> > +	 * We conduct a series of check_nonzero_user() tests on a block of me=
mory
> > +	 * with the following byte-pattern (trying every possible [start,end]
> > +	 * pair):
> > +	 *
> > +	 *   [ 00 ff 00 ff ... 00 00 00 00 ... ff 00 ff 00 ]
> > +	 *
> > +	 * And we verify that check_nonzero_user() acts identically to memchr=
_inv().
> > +	 */
> > +
> > +	memset(kmem, 0x0, size);
> > +	for (i =3D 1; i < zero_start; i +=3D 2)
> > +		kmem[i] =3D 0xff;
> > +	for (i =3D zero_end; i < size; i +=3D 2)
> > +		kmem[i] =3D 0xff;
> > +
> > +	ret |=3D test(copy_to_user(umem, kmem, size),
> > +		    "legitimate copy_to_user failed");
> > +
> > +	for (start =3D 0; start <=3D size; start++) {
> > +		for (end =3D start; end <=3D size; end++) {
> > +			size_t len =3D end - start;
> > +			int retval =3D check_zeroed_user(umem + start, len);
> > +			int expected =3D is_zeroed(kmem + start, len);
> > +
> > +			ret |=3D test(retval !=3D expected,
> > +				    "check_nonzero_user(=3D%d) !=3D memchr_inv(=3D%d) mismatch (st=
art=3D%zu, end=3D%zu)",
> > +				    retval, expected, start, end);
> > +		}
> > +	}
>=20
> This is causing soft lockups for me on powerpc, eg:
>=20
>   [  188.208315] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [modpr=
obe:611]
>   [  188.208782] Modules linked in: test_user_copy(+) vmx_crypto gf128mul=
 crc32c_vpmsum virtio_balloon ip_tables x_tables autofs4
>   [  188.209594] CPU: 4 PID: 611 Comm: modprobe Tainted: G             L =
   5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty #1151
>   [  188.210392] NIP:  c000000000173650 LR: c000000000379cb0 CTR: c000000=
0007b20d0
>   [  188.210612] REGS: c0000000ec213560 TRAP: 0901   Tainted: G          =
   L     (5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty)
>   [  188.210876] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28222=
422  XER: 20000000
>   [  188.211060] CFAR: c000000000379cac IRQMASK: 0=20
>   [  188.211060] GPR00: c000000000379cb0 c0000000ec2137f0 c0000000013bbb0=
0 c000000000f527f0=20
>   [  188.211060] GPR04: 000000000000004b 0000000000000000 00000000000085f=
5 c00000000fffb780=20
>   [  188.211060] GPR08: 0000000000000000 0000000000000000 c0000000fb9a308=
0 c008000000411478=20
>   [  188.211060] GPR12: c0000000007b20d0 c00000000fffb780=20
>   [  188.211802] NIP [c000000000173650] __might_sleep+0x20/0xc0
>   [  188.211924] LR [c000000000379cb0] __might_fault+0x40/0x60
>   [  188.212037] Call Trace:
>   [  188.212101] [c0000000ec2137f0] [c0000000001b99b4] vprintk_func+0xc4/=
0x230 (unreliable)
>   [  188.212274] [c0000000ec213810] [c0000000007b21fc] check_zeroed_user+=
0x12c/0x200
>   [  188.212478] [c0000000ec213860] [c0080000004106cc] test_user_copy_ini=
t+0x67c/0x1210 [test_user_copy]
>   [  188.212681] [c0000000ec2139a0] [c000000000010440] do_one_initcall+0x=
60/0x340
>   [  188.212859] [c0000000ec213a70] [c000000000213d4c] do_init_module+0x7=
c/0x2f0
>   [  188.213004] [c0000000ec213b00] [c000000000216f24] load_module+0x2d94=
/0x30e0
>   [  188.213150] [c0000000ec213d00] [c000000000217578] __do_sys_finit_mod=
ule+0xc8/0x150
>   [  188.213350] [c0000000ec213e20] [c00000000000b5d8] system_call+0x5c/0=
x68
>   [  188.213494] Instruction dump:
>   [  188.213587] 409efec0 4e800020 60000000 60000000 3c4c0125 384284d0 7c=
0802a6 60000000=20
>   [  188.213767] fba1ffe8 fbc1fff0 fbe1fff8 7c9e2378 <f821ff81> 7c7f1b78 =
7cbd2b78 e94d0958=20
>=20
>=20
> I think it's partly because I have DEBUG_ATOMIC_SLEEP enabled, which
> means each unsafe_get_user() calls __might_fault() etc.
>=20
> But even turning that off, it still takes forever.
>=20
> > @@ -106,6 +225,11 @@ static int __init test_user_copy_init(void)
> >  #endif
> >  #undef test_legit
> > =20
> > +	/* Test usage of check_nonzero_user(). */
> > +	ret |=3D test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
>=20
> I suspect it's just that PAGE_SIZE for me is 64K, and so the nested loop
> above gets too big too fast.
>=20
> If my math is right it's doing about 500 million iterations, vs ~2
> million on a 4K kernel.
>=20
> If I do the change below the entire test_user_copy module loads and runs
> all the tests in about 10 seconds.
>=20
> diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> index 950ee88cd6ac..03b617a36144 100644
> --- a/lib/test_user_copy.c
> +++ b/lib/test_user_copy.c
> @@ -226,7 +226,7 @@ static int __init test_user_copy_init(void)
>  #undef test_legit
> =20
>         /* Test usage of check_nonzero_user(). */
> -       ret |=3D test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
> +       ret |=3D test_check_nonzero_user(kmem, usermem, 2 * 4096);
>         /* Test usage of copy_struct_from_user(). */
>         ret |=3D test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
> =20
>=20
> How long does it take on your systems? Is 10s in the ball park, or is
> there something else pathological happening on my machine, and shrinking
> it to 4096 is just papering over it?

Yeah, it takes about 5-10s on my laptop. We could switch it to just
everything within a 4K block, but the main reason for testing with
2*PAGE_SIZE is to make sure that check_nonzero_user() works across page
boundaries. Though we could only do check_nonzero_user() in the region
of the page boundary (maybe i E (PAGE_SIZE-512,PAGE_SIZE+512]?)

Making a single test run for ~40min doesn't seem like that good of an
idea in retrospect. :P

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6pornvxjev4s7kei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZ8YlAAKCRCdlLljIbnQ
EpPTAPsGR56dqwiG/tFX3zGyboRfTqZNEaEetyMoqpKQNbvM9gD9HvdAtntJrDrY
N3vkKP26VuH2OkXO/Zar+NLTYL+T9QA=
=1EH3
-----END PGP SIGNATURE-----

--6pornvxjev4s7kei--
