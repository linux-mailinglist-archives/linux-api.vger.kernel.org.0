Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD14BE8E2
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2019 01:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfIYXWF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 19:22:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59719 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfIYXWF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 19:22:05 -0400
Received: from mon75-17-88-175-211-167.fbx.proxad.net ([88.175.211.167] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iDGbS-0000Wo-Fs; Wed, 25 Sep 2019 23:21:48 +0000
Date:   Thu, 26 Sep 2019 01:21:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v2 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20190925232139.45sbhj34fj7yvxer@wittgenstein>
References: <20190925230332.18690-1-cyphar@cyphar.com>
 <20190925230332.18690-2-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925230332.18690-2-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 26, 2019 at 01:03:29AM +0200, Aleksa Sarai wrote:
> A common pattern for syscall extensions is increasing the size of a
> struct passed from userspace, such that the zero-value of the new fields
> result in the old kernel behaviour (allowing for a mix of userspace and
> kernel vintages to operate on one another in most cases).
> 
> While this interface exists for communication in both directions, only
> one interface is straightforward to have reasonable semantics for
> (userspace passing a struct to the kernel). For kernel returns to
> userspace, what the correct semantics are (whether there should be an
> error if userspace is unaware of a new extension) is very
> syscall-dependent and thus probably cannot be unified between syscalls
> (a good example of this problem is [1]).
> 
> Previously there was no common lib/ function that implemented
> the necessary extension-checking semantics (and different syscalls
> implemented them slightly differently or incompletely[2]). Future
> patches replace common uses of this pattern to make use of
> copy_struct_from_user().
> 
> Some in-kernel selftests that insure that the handling of alignment and
> various byte patterns are all handled identically to memchr_inv() usage.
> 
> [1]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
>      robustify sched_read_attr() ABI logic and code")
> 
> [2]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
>      similar checks to copy_struct_from_user() while rt_sigprocmask(2)
>      always rejects differently-sized struct arguments.
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  include/linux/bitops.h  |   7 +++
>  include/linux/uaccess.h |   4 ++
>  lib/strnlen_user.c      |   8 +--
>  lib/test_user_copy.c    |  59 ++++++++++++++++++---
>  lib/usercopy.c          | 115 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 180 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index cf074bce3eb3..a23f4c054768 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -4,6 +4,13 @@
>  #include <asm/types.h>
>  #include <linux/bits.h>
>  
> +/* Set bits in the first 'n' bytes when loaded from memory */
> +#ifdef __LITTLE_ENDIAN
> +#  define aligned_byte_mask(n) ((1ul << 8*(n))-1)
> +#else
> +#  define aligned_byte_mask(n) (~0xfful << (BITS_PER_LONG - 8 - 8*(n)))
> +#endif
> +
>  #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
>  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 34a038563d97..824569e309e4 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -230,6 +230,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
>  
>  #endif		/* ARCH_HAS_NOCACHE_UACCESS */
>  
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
>  
>  #include <asm/word-at-a-time.h>
>  
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
>  
> -#define test(condition, msg)		\
> -({					\
> -	int cond = (condition);		\
> -	if (cond)			\
> -		pr_warn("%s\n", msg);	\
> -	cond;				\
> +#define test(condition, msg, ...)					\
> +({									\
> +	int cond = (condition);						\
> +	if (cond)							\
> +		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
> +	cond;								\
>  })
>  
> +static int test_is_zeroed_user(char *kmem, char __user *umem, size_t size)
> +{
> +	int ret = 0;
> +	size_t start, end, i;
> +	size_t zero_start = size / 4;
> +	size_t zero_end = size - zero_start;
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
> +	for (i = 0; i < zero_start; i += 2)
> +		kmem[i] = 0x00;
> +	for (i = 1; i < zero_start; i += 2)
> +		kmem[i] = 0xff;
> +
> +	for (i = zero_end; i < size; i += 2)
> +		kmem[i] = 0xff;
> +	for (i = zero_end + 1; i < size; i += 2)
> +		kmem[i] = 0x00;
> +
> +	ret |= test(copy_to_user(umem, kmem, size),
> +		    "legitimate copy_to_user failed");
> +
> +	for (start = 0; start <= size; start++) {
> +		for (end = start; end <= size; end++) {
> +			int retval = is_zeroed_user(umem + start, end - start);
> +			int expected = memchr_inv(kmem + start, 0, end - start) == NULL;
> +
> +			ret |= test(retval != expected,
> +				    "is_zeroed_user(=%d) != memchr_inv(=%d) mismatch (start=%lu, end=%lu)",
> +				    retval, expected, start, end);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int __init test_user_copy_init(void)
>  {
>  	int ret = 0;
> @@ -106,6 +150,9 @@ static int __init test_user_copy_init(void)
>  #endif
>  #undef test_legit
>  
> +	/* Test usage of is_zeroed_user(). */
> +	ret |= test_is_zeroed_user(kmem, usermem, PAGE_SIZE);
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
>  
>  /* out-of-line parts */
>  
> @@ -31,3 +32,117 @@ unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
>  }
>  EXPORT_SYMBOL(_copy_to_user);
>  #endif
> +
> +/**
> + * is_zeroed_user: check if a userspace buffer is full of zeros
> + * @from:  Source address, in userspace.
> + * @size: Size of buffer.
> + *
> + * This is effectively shorthand for "memchr_inv(from, 0, size) == NULL" for
> + * userspace addresses. If there are non-zero bytes present then false is
> + * returned, otherwise true is returned.
> + *
> + * Returns:
> + *  * -EFAULT: access to userspace failed.
> + */
> +int is_zeroed_user(const void __user *from, size_t size)
> +{
> +	unsigned long val;
> +	uintptr_t align = (uintptr_t) from % sizeof(unsigned long);
> +
> +	if (unlikely(!size))
> +		return true;

You're returning "true" and another implicit boolean with (val == 0)
down below but -EFAULT in other places. But that function is
int is_zeroed_user()
Would probably be good if you either switch to
bool is_zeroed_user()
as the name suggests or rename the function and have it return an int
everywhere.

> +
> +	from -= align;
> +	size += align;
> +
> +	if (!user_access_begin(from, size))
> +		return -EFAULT;
> +
> +	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> +	if (align)
> +		val &= ~aligned_byte_mask(align);
> +
> +	while (size > sizeof(unsigned long)) {
> +		if (unlikely(val))
> +			goto done;
> +
> +		from += sizeof(unsigned long);
> +		size -= sizeof(unsigned long);
> +
> +		unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> +	}
> +
> +	if (size < sizeof(unsigned long))
> +		val &= aligned_byte_mask(size);
> +
> +done:
> +	user_access_end();
> +	return (val == 0);
> +err_fault:
> +	user_access_end();
> +	return -EFAULT;
> +}
> +EXPORT_SYMBOL(is_zeroed_user);
> +
> +/**
> + * copy_struct_from_user: copy a struct from userspace
> + * @dst:   Destination address, in kernel space. This buffer must be @ksize
> + *         bytes long.
> + * @ksize: Size of @dst struct.
> + * @src:   Source address, in userspace.
> + * @usize: (Alleged) size of @src struct.
> + *
> + * Copies a struct from userspace to kernel space, in a way that guarantees
> + * backwards-compatibility for struct syscall arguments (as long as future
> + * struct extensions are made such that all new fields are *appended* to the
> + * old struct, and zeroed-out new fields have the same meaning as the old
> + * struct).
> + *
> + * @ksize is just sizeof(*dst), and @usize should've been passed by userspace.
> + * The recommended usage is something like the following:
> + *
> + *   SYSCALL_DEFINE2(foobar, const struct foo __user *, uarg, size_t, usize)
> + *   {
> + *      int err;
> + *      struct foo karg = {};
> + *
> + *      err = copy_struct_from_user(&karg, sizeof(karg), uarg, size);
> + *      if (err)
> + *        return err;
> + *
> + *      // ...
> + *   }
> + *
> + * There are three cases to consider:
> + *  * If @usize == @ksize, then it's copied verbatim.
> + *  * If @usize < @ksize, then the userspace has passed an old struct to a
> + *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @usize)
> + *    are to be zero-filled.
> + *  * If @usize > @ksize, then the userspace has passed a new struct to an
> + *    older kernel. The trailing bytes unknown to the kernel (@usize - @ksize)
> + *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
> + *
> + * Returns (in all cases, some data may have been copied):
> + *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes in @src.
> + *  * -EFAULT: access to userspace failed.
> + */
> +int copy_struct_from_user(void *dst, size_t ksize,
> +			  const void __user *src, size_t usize)
> +{
> +	size_t size = min(ksize, usize);
> +	size_t rest = max(ksize, usize) - size;
> +
> +	/* Deal with trailing bytes. */
> +	if (usize < ksize) {
> +		memset(dst + size, 0, rest);
> +	} else if (usize > ksize) {
> +		int ret = is_zeroed_user(src + size, rest);
> +		if (ret <= 0)
> +			return ret ?: -E2BIG;
> +	}
> +	/* Copy the interoperable parts of the struct. */
> +	if (copy_from_user(dst, src, size))
> +		return -EFAULT;
> +	return 0;
> +}
> -- 
> 2.23.0
> 
