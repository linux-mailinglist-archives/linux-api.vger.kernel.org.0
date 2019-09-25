Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D730BE8CA
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2019 01:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfIYXHy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 19:07:54 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:37700 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfIYXHy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Sep 2019 19:07:54 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 352AAA01BD;
        Thu, 26 Sep 2019 01:07:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id k6CNMmxAREPJ; Thu, 26 Sep 2019 01:07:47 +0200 (CEST)
Date:   Thu, 26 Sep 2019 01:07:26 +0200
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20190925230726.psnejhuhf2hnr7bg@yavin>
References: <20190925230332.18690-1-cyphar@cyphar.com>
 <20190925230332.18690-2-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jvalwglzgyhvrmbg"
Content-Disposition: inline
In-Reply-To: <20190925230332.18690-2-cyphar@cyphar.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--jvalwglzgyhvrmbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Damn, I forgot to add Kees to Cc.)

On 2019-09-26, Aleksa Sarai <cyphar@cyphar.com> wrote:
> A common pattern for syscall extensions is increasing the size of a
> struct passed from userspace, such that the zero-value of the new fields
> result in the old kernel behaviour (allowing for a mix of userspace and
> kernel vintages to operate on one another in most cases).
>=20
> While this interface exists for communication in both directions, only
> one interface is straightforward to have reasonable semantics for
> (userspace passing a struct to the kernel). For kernel returns to
> userspace, what the correct semantics are (whether there should be an
> error if userspace is unaware of a new extension) is very
> syscall-dependent and thus probably cannot be unified between syscalls
> (a good example of this problem is [1]).
>=20
> Previously there was no common lib/ function that implemented
> the necessary extension-checking semantics (and different syscalls
> implemented them slightly differently or incompletely[2]). Future
> patches replace common uses of this pattern to make use of
> copy_struct_from_user().
>=20
> Some in-kernel selftests that insure that the handling of alignment and
> various byte patterns are all handled identically to memchr_inv() usage.
>=20
> [1]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
>      robustify sched_read_attr() ABI logic and code")
>=20
> [2]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
>      similar checks to copy_struct_from_user() while rt_sigprocmask(2)
>      always rejects differently-sized struct arguments.
>=20
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  include/linux/bitops.h  |   7 +++
>  include/linux/uaccess.h |   4 ++
>  lib/strnlen_user.c      |   8 +--
>  lib/test_user_copy.c    |  59 ++++++++++++++++++---
>  lib/usercopy.c          | 115 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 180 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index cf074bce3eb3..a23f4c054768 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -4,6 +4,13 @@
>  #include <asm/types.h>
>  #include <linux/bits.h>
> =20
> +/* Set bits in the first 'n' bytes when loaded from memory */
> +#ifdef __LITTLE_ENDIAN
> +#  define aligned_byte_mask(n) ((1ul << 8*(n))-1)
> +#else
> +#  define aligned_byte_mask(n) (~0xfful << (BITS_PER_LONG - 8 - 8*(n)))
> +#endif
> +
>  #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
>  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
> =20
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 34a038563d97..824569e309e4 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -230,6 +230,10 @@ static inline unsigned long __copy_from_user_inatomi=
c_nocache(void *to,
> =20
>  #endif		/* ARCH_HAS_NOCACHE_UACCESS */
> =20
> +extern int is_zeroed_user(const void __user *from, size_t count);
> +extern int copy_struct_from_user(void *dst, size_t ksize,
> +				 const void __user *src, size_t usize);
> +
>  /*
>   * probe_kernel_read(): safely attempt to read from a location
>   * @dst: pointer to the buffer that shall take the data
> diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> index 7f2db3fe311f..39d588aaa8cd 100644
> --- a/lib/strnlen_user.c
> +++ b/lib/strnlen_user.c
> @@ -2,16 +2,10 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/uaccess.h>
> +#include <linux/bitops.h>
> =20
>  #include <asm/word-at-a-time.h>
> =20
> -/* Set bits in the first 'n' bytes when loaded from memory */
> -#ifdef __LITTLE_ENDIAN
> -#  define aligned_byte_mask(n) ((1ul << 8*(n))-1)
> -#else
> -#  define aligned_byte_mask(n) (~0xfful << (BITS_PER_LONG - 8 - 8*(n)))
> -#endif
> -
>  /*
>   * Do a strnlen, return length of string *with* final '\0'.
>   * 'count' is the user-supplied count, while 'max' is the
> diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> index 67bcd5dfd847..f7cde3845ccc 100644
> --- a/lib/test_user_copy.c
> +++ b/lib/test_user_copy.c
> @@ -31,14 +31,58 @@
>  # define TEST_U64
>  #endif
> =20
> -#define test(condition, msg)		\
> -({					\
> -	int cond =3D (condition);		\
> -	if (cond)			\
> -		pr_warn("%s\n", msg);	\
> -	cond;				\
> +#define test(condition, msg, ...)					\
> +({									\
> +	int cond =3D (condition);						\
> +	if (cond)							\
> +		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
> +	cond;								\
>  })
> =20
> +static int test_is_zeroed_user(char *kmem, char __user *umem, size_t siz=
e)
> +{
> +	int ret =3D 0;
> +	size_t start, end, i;
> +	size_t zero_start =3D size / 4;
> +	size_t zero_end =3D size - zero_start;
> +
> +	/*
> +	 * We conduct a series of is_zeroed_user() tests on a block of memory
> +	 * with the following byte-pattern (trying every possible [start,end]
> +	 * pair):
> +	 *
> +	 *   [ 00 ff 00 ff ... 00 00 00 00 ... ff 00 ff 00 ]
> +	 *
> +	 * And we verify that is_zeroed_user() acts identically to memchr_inv().
> +	 */
> +
> +	for (i =3D 0; i < zero_start; i +=3D 2)
> +		kmem[i] =3D 0x00;
> +	for (i =3D 1; i < zero_start; i +=3D 2)
> +		kmem[i] =3D 0xff;
> +
> +	for (i =3D zero_end; i < size; i +=3D 2)
> +		kmem[i] =3D 0xff;
> +	for (i =3D zero_end + 1; i < size; i +=3D 2)
> +		kmem[i] =3D 0x00;
> +
> +	ret |=3D test(copy_to_user(umem, kmem, size),
> +		    "legitimate copy_to_user failed");
> +
> +	for (start =3D 0; start <=3D size; start++) {
> +		for (end =3D start; end <=3D size; end++) {
> +			int retval =3D is_zeroed_user(umem + start, end - start);
> +			int expected =3D memchr_inv(kmem + start, 0, end - start) =3D=3D NULL;
> +
> +			ret |=3D test(retval !=3D expected,
> +				    "is_zeroed_user(=3D%d) !=3D memchr_inv(=3D%d) mismatch (start=3D=
%lu, end=3D%lu)",
> +				    retval, expected, start, end);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int __init test_user_copy_init(void)
>  {
>  	int ret =3D 0;
> @@ -106,6 +150,9 @@ static int __init test_user_copy_init(void)
>  #endif
>  #undef test_legit
> =20
> +	/* Test usage of is_zeroed_user(). */
> +	ret |=3D test_is_zeroed_user(kmem, usermem, PAGE_SIZE);
> +
>  	/*
>  	 * Invalid usage: none of these copies should succeed.
>  	 */
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index c2bfbcaeb3dc..f795cf0946ad 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/uaccess.h>
> +#include <linux/bitops.h>
> =20
>  /* out-of-line parts */
> =20
> @@ -31,3 +32,117 @@ unsigned long _copy_to_user(void __user *to, const vo=
id *from, unsigned long n)
>  }
>  EXPORT_SYMBOL(_copy_to_user);
>  #endif
> +
> +/**
> + * is_zeroed_user: check if a userspace buffer is full of zeros
> + * @from:  Source address, in userspace.
> + * @size: Size of buffer.
> + *
> + * This is effectively shorthand for "memchr_inv(from, 0, size) =3D=3D N=
ULL" for
> + * userspace addresses. If there are non-zero bytes present then false is
> + * returned, otherwise true is returned.
> + *
> + * Returns:
> + *  * -EFAULT: access to userspace failed.
> + */
> +int is_zeroed_user(const void __user *from, size_t size)
> +{
> +	unsigned long val;
> +	uintptr_t align =3D (uintptr_t) from % sizeof(unsigned long);
> +
> +	if (unlikely(!size))
> +		return true;
> +
> +	from -=3D align;
> +	size +=3D align;
> +
> +	if (!user_access_begin(from, size))
> +		return -EFAULT;
> +
> +	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> +	if (align)
> +		val &=3D ~aligned_byte_mask(align);
> +
> +	while (size > sizeof(unsigned long)) {
> +		if (unlikely(val))
> +			goto done;
> +
> +		from +=3D sizeof(unsigned long);
> +		size -=3D sizeof(unsigned long);
> +
> +		unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> +	}
> +
> +	if (size < sizeof(unsigned long))
> +		val &=3D aligned_byte_mask(size);
> +
> +done:
> +	user_access_end();
> +	return (val =3D=3D 0);
> +err_fault:
> +	user_access_end();
> +	return -EFAULT;
> +}
> +EXPORT_SYMBOL(is_zeroed_user);
> +
> +/**
> + * copy_struct_from_user: copy a struct from userspace
> + * @dst:   Destination address, in kernel space. This buffer must be @ks=
ize
> + *         bytes long.
> + * @ksize: Size of @dst struct.
> + * @src:   Source address, in userspace.
> + * @usize: (Alleged) size of @src struct.
> + *
> + * Copies a struct from userspace to kernel space, in a way that guarant=
ees
> + * backwards-compatibility for struct syscall arguments (as long as futu=
re
> + * struct extensions are made such that all new fields are *appended* to=
 the
> + * old struct, and zeroed-out new fields have the same meaning as the old
> + * struct).
> + *
> + * @ksize is just sizeof(*dst), and @usize should've been passed by user=
space.
> + * The recommended usage is something like the following:
> + *
> + *   SYSCALL_DEFINE2(foobar, const struct foo __user *, uarg, size_t, us=
ize)
> + *   {
> + *      int err;
> + *      struct foo karg =3D {};
> + *
> + *      err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, size);
> + *      if (err)
> + *        return err;
> + *
> + *      // ...
> + *   }
> + *
> + * There are three cases to consider:
> + *  * If @usize =3D=3D @ksize, then it's copied verbatim.
> + *  * If @usize < @ksize, then the userspace has passed an old struct to=
 a
> + *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @us=
ize)
> + *    are to be zero-filled.
> + *  * If @usize > @ksize, then the userspace has passed a new struct to =
an
> + *    older kernel. The trailing bytes unknown to the kernel (@usize - @=
ksize)
> + *    are checked to ensure they are zeroed, otherwise -E2BIG is returne=
d.
> + *
> + * Returns (in all cases, some data may have been copied):
> + *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes i=
n @src.
> + *  * -EFAULT: access to userspace failed.
> + */
> +int copy_struct_from_user(void *dst, size_t ksize,
> +			  const void __user *src, size_t usize)
> +{
> +	size_t size =3D min(ksize, usize);
> +	size_t rest =3D max(ksize, usize) - size;
> +
> +	/* Deal with trailing bytes. */
> +	if (usize < ksize) {
> +		memset(dst + size, 0, rest);
> +	} else if (usize > ksize) {
> +		int ret =3D is_zeroed_user(src + size, rest);
> +		if (ret <=3D 0)
> +			return ret ?: -E2BIG;
> +	}
> +	/* Copy the interoperable parts of the struct. */
> +	if (copy_from_user(dst, src, size))
> +		return -EFAULT;
> +	return 0;
> +}
> --=20
> 2.23.0
>=20


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--jvalwglzgyhvrmbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXYvzKQAKCRCdlLljIbnQ
EjidAQCyz4DMHzuSD4bL2DB3qMF3mvj2iz8nkzz3nmHQ7osMHwD+IoAOMUK1UkFn
G8BnQSf1zIqMw/WtX3ySkGnLS5iEswY=
=S0Tk
-----END PGP SIGNATURE-----

--jvalwglzgyhvrmbg--
