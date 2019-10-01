Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7507C2B56
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 02:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfJAA0r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 20:26:47 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:35180 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfJAA0r (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Sep 2019 20:26:47 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 95AAFA1FF2;
        Tue,  1 Oct 2019 02:26:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id OqSFqd3gxv0h; Tue,  1 Oct 2019 02:26:37 +0200 (CEST)
Date:   Tue, 1 Oct 2019 10:26:13 +1000
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
Subject: Re: [PATCH RESEND v3 1/4] lib: introduce copy_struct_from_user()
 helper
Message-ID: <20191001002613.r3j7atz5pxas7ary@yavin.dot.cyphar.com>
References: <20190930191526.19544-1-asarai@suse.de>
 <20190930191526.19544-2-asarai@suse.de>
 <201909301622.90B70079@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="szzqvqqqxiiljkez"
Content-Disposition: inline
In-Reply-To: <201909301622.90B70079@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--szzqvqqqxiiljkez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-30, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Oct 01, 2019 at 05:15:23AM +1000, Aleksa Sarai wrote:
> > From: Aleksa Sarai <cyphar@cyphar.com>
> >=20
> > A common pattern for syscall extensions is increasing the size of a
> > struct passed from userspace, such that the zero-value of the new fields
> > result in the old kernel behaviour (allowing for a mix of userspace and
> > kernel vintages to operate on one another in most cases).
> >=20
> > While this interface exists for communication in both directions, only
> > one interface is straightforward to have reasonable semantics for
> > (userspace passing a struct to the kernel). For kernel returns to
> > userspace, what the correct semantics are (whether there should be an
> > error if userspace is unaware of a new extension) is very
> > syscall-dependent and thus probably cannot be unified between syscalls
> > (a good example of this problem is [1]).
> >=20
> > Previously there was no common lib/ function that implemented
> > the necessary extension-checking semantics (and different syscalls
> > implemented them slightly differently or incompletely[2]). Future
> > patches replace common uses of this pattern to make use of
> > copy_struct_from_user().
> >=20
> > Some in-kernel selftests that insure that the handling of alignment and
> > various byte patterns are all handled identically to memchr_inv() usage.
> >=20
> > [1]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
> >      robustify sched_read_attr() ABI logic and code")
> >=20
> > [2]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
> >      similar checks to copy_struct_from_user() while rt_sigprocmask(2)
> >      always rejects differently-sized struct arguments.
> >=20
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  include/linux/bitops.h  |   7 +++
> >  include/linux/uaccess.h |   4 ++
> >  lib/strnlen_user.c      |   8 +--
> >  lib/test_user_copy.c    | 133 ++++++++++++++++++++++++++++++++++++++--
> >  lib/usercopy.c          | 123 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 262 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index cf074bce3eb3..c94a9ff9f082 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -4,6 +4,13 @@
> >  #include <asm/types.h>
> >  #include <linux/bits.h>
> > =20
> > +/* Set bits in the first 'n' bytes when loaded from memory */
> > +#ifdef __LITTLE_ENDIAN
> > +#  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
> > +#else
> > +#  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
> > +#endif
> > +
> >  #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
> >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
> > =20
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index 70bbdc38dc37..94f20e6ec6ab 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -231,6 +231,10 @@ __copy_from_user_inatomic_nocache(void *to, const =
void __user *from,
> > =20
> >  #endif		/* ARCH_HAS_NOCACHE_UACCESS */
> > =20
> > +extern int check_zeroed_user(const void __user *from, size_t size);
> > +extern int copy_struct_from_user(void *dst, size_t ksize,
> > +				 const void __user *src, size_t usize);
> > +
> >  /*
> >   * probe_kernel_read(): safely attempt to read from a location
> >   * @dst: pointer to the buffer that shall take the data
> > diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> > index 28ff554a1be8..6c0005d5dd5c 100644
> > --- a/lib/strnlen_user.c
> > +++ b/lib/strnlen_user.c
> > @@ -3,16 +3,10 @@
> >  #include <linux/export.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/mm.h>
> > +#include <linux/bitops.h>
> > =20
> >  #include <asm/word-at-a-time.h>
> > =20
> > -/* Set bits in the first 'n' bytes when loaded from memory */
> > -#ifdef __LITTLE_ENDIAN
> > -#  define aligned_byte_mask(n) ((1ul << 8*(n))-1)
> > -#else
> > -#  define aligned_byte_mask(n) (~0xfful << (BITS_PER_LONG - 8 - 8*(n)))
> > -#endif
> > -
> >  /*
> >   * Do a strnlen, return length of string *with* final '\0'.
> >   * 'count' is the user-supplied count, while 'max' is the
> > diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> > index 67bcd5dfd847..3a17f71029bb 100644
> > --- a/lib/test_user_copy.c
> > +++ b/lib/test_user_copy.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/random.h>
> > =20
> >  /*
> >   * Several 32-bit architectures support 64-bit {get,put}_user() calls.
> > @@ -31,14 +32,129 @@
> >  # define TEST_U64
> >  #endif
> > =20
> > -#define test(condition, msg)		\
> > -({					\
> > -	int cond =3D (condition);		\
> > -	if (cond)			\
> > -		pr_warn("%s\n", msg);	\
> > -	cond;				\
> > +#define test(condition, msg, ...)					\
> > +({									\
> > +	int cond =3D (condition);						\
> > +	if (cond)							\
> > +		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
> > +	cond;								\
> >  })
> > =20
> > +static bool is_zeroed(void *from, size_t size)
> > +{
> > +	return memchr_inv(from, 0x0, size) =3D=3D NULL;
> > +}
> > +
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
> > +
> > +	return ret;
> > +}
> > +
> > +static int test_copy_struct_from_user(char *kmem, char __user *umem,
> > +				      size_t size)
> > +{
> > +	int ret =3D 0;
> > +	char *rand =3D NULL, *expected =3D NULL;
> > +	size_t ksize, usize;
> > +
> > +	rand =3D kmalloc(size, GFP_KERNEL);
> > +	if (ret |=3D test(rand =3D=3D NULL, "kmalloc failed"))
> > +		goto out_free;
> > +
> > +	expected =3D kmalloc(size, GFP_KERNEL);
> > +	if (ret |=3D test(expected =3D=3D NULL, "kmalloc failed"))
> > +		goto out_free;
> > +
> > +	/* Fill umem with random bytes. */
> > +	memset(kmem, 0x0, size);
> > +	prandom_bytes(rand, size);
>=20
> I don't really like using random() in tests on the chance that we get
> failures we can't reproduced. If you want to do this (instead of using a
> byte-fill pattern), you need to dump the entire state of the memory
> region. Why not just memset(rand, 0xff, ...)? (And obviously rename
> "rand")

Fair enough.

> > +	ret |=3D test(copy_to_user(umem, rand, size),
> > +		    "legitimate copy_to_user failed");
> > +
> > +	/* Check basic case -- (usize =3D=3D ksize). */
> > +	ksize =3D size;
> > +	usize =3D size;
>=20
> I'd move the memset(kmem, 0x0, size); down to here.
>=20
> > +	memcpy(expected, rand, ksize);
> > +
> > +	ret |=3D test(copy_struct_from_user(kmem, ksize, umem, usize),
> > +		    "copy_struct_from_user(usize =3D=3D ksize) failed");
> > +	ret |=3D test(memcmp(kmem, expected, ksize),
> > +		    "copy_struct_from_user(usize =3D=3D ksize) gives unexpected copy=
");
> > +
> > +	/* Old userspace case -- (usize < ksize). */
> > +	ksize =3D size;
> > +	usize =3D ksize / 2;
> > +
>=20
> I would expect memset(kmem, 0x0, size); again here since a new test of
> that region is starting.
>=20
> > +	memcpy(expected, rand, usize);
> > +	memset(expected + usize, 0x0, ksize - usize);
> > +
> > +	ret |=3D test(copy_struct_from_user(kmem, ksize, umem, usize),
> > +		    "copy_struct_from_user(usize < ksize) failed");
> > +	ret |=3D test(memcmp(kmem, expected, ksize),
> > +		    "copy_struct_from_user(usize < ksize) gives unexpected copy");
> > +
> > +	/* New userspace (-E2BIG) case -- (usize > ksize). */
> > +	usize =3D size;
> > +	ksize =3D usize / 2;
>=20
> and here?
>=20
> > +
> > +	ret |=3D test(copy_struct_from_user(kmem, ksize, umem, usize) !=3D -E=
2BIG,
> > +		    "copy_struct_from_user(usize > ksize) didn't give E2BIG");
> > +
> > +	/* New userspace (success) case -- (usize > ksize). */
> > +	usize =3D size;
> > +	ksize =3D usize / 2;
> > +
>=20
> and here?

Will do all of the above.

> > +	memcpy(expected, rand, ksize);
> > +
> > +	ret |=3D test(clear_user(umem + ksize, usize - ksize),
> > +		    "legitimate clear_user failed");
> > +	ret |=3D test(copy_struct_from_user(kmem, ksize, umem, usize),
> > +		    "copy_struct_from_user(usize > ksize) failed");
> > +	ret |=3D test(memcmp(kmem, expected, ksize),
> > +		    "copy_struct_from_user(usize > ksize) gives unexpected copy");
> > +
> > +out_free:
> > +	kfree(expected);
> > +	kfree(rand);
> > +	return ret;
> > +}
> > +
> >  static int __init test_user_copy_init(void)
> >  {
> >  	int ret =3D 0;
> > @@ -106,6 +222,11 @@ static int __init test_user_copy_init(void)
> >  #endif
> >  #undef test_legit
> > =20
> > +	/* Test usage of check_nonzero_user(). */
> > +	ret |=3D test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
> > +	/* Test usage of copy_struct_from_user(). */
> > +	ret |=3D test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
> > +
> >  	/*
> >  	 * Invalid usage: none of these copies should succeed.
> >  	 */
> > diff --git a/lib/usercopy.c b/lib/usercopy.c
> > index c2bfbcaeb3dc..cf7f854ed9c8 100644
> > --- a/lib/usercopy.c
> > +++ b/lib/usercopy.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/uaccess.h>
> > +#include <linux/bitops.h>
> > =20
> >  /* out-of-line parts */
> > =20
> > @@ -31,3 +32,125 @@ unsigned long _copy_to_user(void __user *to, const =
void *from, unsigned long n)
> >  }
> >  EXPORT_SYMBOL(_copy_to_user);
> >  #endif
> > +
> > +/**
> > + * check_zeroed_user: check if a userspace buffer only contains zero b=
ytes
> > + * @from: Source address, in userspace.
> > + * @size: Size of buffer.
> > + *
> > + * This is effectively shorthand for "memchr_inv(from, 0, size) =3D=3D=
 NULL" for
> > + * userspace addresses (and is more efficient because we don't care wh=
ere the
> > + * first non-zero byte is).
> > + *
> > + * Returns:
> > + *  * 0: There were non-zero bytes present in the buffer.
> > + *  * 1: The buffer was full of zero bytes.
> > + *  * -EFAULT: access to userspace failed.
> > + */
> > +int check_zeroed_user(const void __user *from, size_t size)
> > +{
> > +	unsigned long val;
> > +	uintptr_t align =3D (uintptr_t) from % sizeof(unsigned long);
> > +
> > +	if (unlikely(size =3D=3D 0))
> > +		return 1;
> > +
> > +	from -=3D align;
> > +	size +=3D align;
> > +
> > +	if (!user_access_begin(from, size))
> > +		return -EFAULT;
> > +
> > +	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> > +	if (align)
> > +		val &=3D ~aligned_byte_mask(align);
> > +
> > +	while (size > sizeof(unsigned long)) {
> > +		if (unlikely(val))
> > +			goto done;
> > +
> > +		from +=3D sizeof(unsigned long);
> > +		size -=3D sizeof(unsigned long);
> > +
> > +		unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> > +	}
> > +
> > +	if (size < sizeof(unsigned long))
> > +		val &=3D aligned_byte_mask(size);
> > +
> > +done:
> > +	user_access_end();
> > +	return (val =3D=3D 0);
> > +err_fault:
> > +	user_access_end();
> > +	return -EFAULT;
> > +}
> > +EXPORT_SYMBOL(check_zeroed_user);
> > +
> > +/**
> > + * copy_struct_from_user: copy a struct from userspace
> > + * @dst:   Destination address, in kernel space. This buffer must be @=
ksize
> > + *         bytes long.
> > + * @ksize: Size of @dst struct.
> > + * @src:   Source address, in userspace.
> > + * @usize: (Alleged) size of @src struct.
> > + *
> > + * Copies a struct from userspace to kernel space, in a way that guara=
ntees
> > + * backwards-compatibility for struct syscall arguments (as long as fu=
ture
> > + * struct extensions are made such that all new fields are *appended* =
to the
> > + * old struct, and zeroed-out new fields have the same meaning as the =
old
> > + * struct).
> > + *
> > + * @ksize is just sizeof(*dst), and @usize should've been passed by us=
erspace.
> > + * The recommended usage is something like the following:
> > + *
> > + *   SYSCALL_DEFINE2(foobar, const struct foo __user *, uarg, size_t, =
usize)
> > + *   {
> > + *      int err;
> > + *      struct foo karg =3D {};
> > + *
> > + *      if (usize > PAGE_SIZE)
> > + *        return -E2BIG;
> > + *      if (usize < FOO_SIZE_VER0)
> > + *        return -EINVAL;
> > + *
> > + *      err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, usize=
);
> > + *      if (err)
> > + *        return err;
> > + *
> > + *      // ...
> > + *   }
> > + *
> > + * There are three cases to consider:
> > + *  * If @usize =3D=3D @ksize, then it's copied verbatim.
> > + *  * If @usize < @ksize, then the userspace has passed an old struct =
to a
> > + *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @=
usize)
> > + *    are to be zero-filled.
> > + *  * If @usize > @ksize, then the userspace has passed a new struct t=
o an
> > + *    older kernel. The trailing bytes unknown to the kernel (@usize -=
 @ksize)
> > + *    are checked to ensure they are zeroed, otherwise -E2BIG is retur=
ned.
> > + *
> > + * Returns (in all cases, some data may have been copied):
> > + *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes=
 in @src.
> > + *  * -EFAULT: access to userspace failed.
> > + */
> > +int copy_struct_from_user(void *dst, size_t ksize,
> > +			  const void __user *src, size_t usize)
>=20
> I'd like to see this be marked __always_inline so the dst type is known
> to the compiler during the copy_from_user() size sanity checks, etc.

Sure, will do. I'll put it in uaccess.h.

> > +{
> > +	size_t size =3D min(ksize, usize);
> > +	size_t rest =3D max(ksize, usize) - size;
> > +
> > +	/* Deal with trailing bytes. */
> > +	if (usize < ksize) {
> > +		memset(dst + size, 0, rest);
> > +	} else if (usize > ksize) {
> > +		int ret =3D check_zeroed_user(src + size, rest);
> > +		if (ret <=3D 0)
> > +			return ret ?: -E2BIG;
> > +	}
> > +	/* Copy the interoperable parts of the struct. */
> > +	if (copy_from_user(dst, src, size))
> > +		return -EFAULT;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(copy_struct_from_user);
> > --=20
> > 2.23.0

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--szzqvqqqxiiljkez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZKdIgAKCRCdlLljIbnQ
EvSDAQCPiK+1MciPgIXXNuWdtukjcD1Xp7gQVC6xs8ZsZd37fQD/ZLRSz5fhQDFY
F0mnJsoby5JBzFLyacQKg6O6LQGXlQM=
=+pTM
-----END PGP SIGNATURE-----

--szzqvqqqxiiljkez--
