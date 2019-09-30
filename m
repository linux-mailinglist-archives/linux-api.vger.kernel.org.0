Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5185AC2AFE
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 01:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfI3Xh6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 19:37:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39364 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfI3Xh5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Sep 2019 19:37:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so6519330pff.6
        for <linux-api@vger.kernel.org>; Mon, 30 Sep 2019 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=91VYKir+8JQ78iOBXSsaytQPYr2VNMDv6h2d/zqwG0E=;
        b=KWgsOjLNOQPYFfX0XwomaSXuahNOHNkzgy0ul+wKxMemMhm6HuuchdVtayc2YcjWMo
         cem6a8ygzDxq4UNsps+KKHWUzJfQCUem+DKJmBWcpOJSkI/9at+CXHrCTaepfPrjT3ZA
         PaEo8JzAwQhFhPvL3tkwqCofGvyNf1ggA93Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91VYKir+8JQ78iOBXSsaytQPYr2VNMDv6h2d/zqwG0E=;
        b=XE1dm9ZWs5wuU1exZKf38tRC9SkNWTZcjEwpFruQwmVnRAOA0JdRZhbTWPZIeKu6/K
         j0jWJBmS/TvtKbdu1oR1MFmoIQ2d2k65r2+PH90YYTr8VAZHhOwyE4kS1YAyngIvNLdQ
         dwrZk1c7EAQ4+kBjLXLncGoxR31LmE/EqqWkuSA7yVtUcp+yc6SXNSSbzjCG3Ib0wYFf
         2ZYS5nBKhsJMZtZ3+qUNiha0gBoBpTzbIkGSM7ERJQSnHX0RiVLNJ1CLaJRAUEHmu4Qs
         YykGHQSUuG3rtZChgQY+xtFLUSdUoqXqubg6XvZQVLqRK1uzPgp87KR0sAMZEZPs0wug
         KtoA==
X-Gm-Message-State: APjAAAVrZxZjJ36nyz7DD1/LeT9sepHnkJtPBNYXHmNPqiM0gaI9EN+Z
        z0D3cASNFXu1Ewqq582l/Q9ybA==
X-Google-Smtp-Source: APXvYqyUxTT+UPZgN/L82Q4GjTNZOvmLRPIV7N6Q2A75HGj77Jyrql4sZ704NAp36gGhvyXYVdJf0Q==
X-Received: by 2002:a63:606:: with SMTP id 6mr26655293pgg.181.1569886676028;
        Mon, 30 Sep 2019 16:37:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l24sm14852047pff.151.2019.09.30.16.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:37:55 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:37:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/4] lib: introduce copy_struct_from_user()
 helper
Message-ID: <201909301622.90B70079@keescook>
References: <20190930191526.19544-1-asarai@suse.de>
 <20190930191526.19544-2-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930191526.19544-2-asarai@suse.de>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 05:15:23AM +1000, Aleksa Sarai wrote:
> From: Aleksa Sarai <cyphar@cyphar.com>
> 
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
>  lib/test_user_copy.c    | 133 ++++++++++++++++++++++++++++++++++++++--
>  lib/usercopy.c          | 123 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 262 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index cf074bce3eb3..c94a9ff9f082 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -4,6 +4,13 @@
>  #include <asm/types.h>
>  #include <linux/bits.h>
>  
> +/* Set bits in the first 'n' bytes when loaded from memory */
> +#ifdef __LITTLE_ENDIAN
> +#  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
> +#else
> +#  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
> +#endif
> +
>  #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
>  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 70bbdc38dc37..94f20e6ec6ab 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -231,6 +231,10 @@ __copy_from_user_inatomic_nocache(void *to, const void __user *from,
>  
>  #endif		/* ARCH_HAS_NOCACHE_UACCESS */
>  
> +extern int check_zeroed_user(const void __user *from, size_t size);
> +extern int copy_struct_from_user(void *dst, size_t ksize,
> +				 const void __user *src, size_t usize);
> +
>  /*
>   * probe_kernel_read(): safely attempt to read from a location
>   * @dst: pointer to the buffer that shall take the data
> diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> index 28ff554a1be8..6c0005d5dd5c 100644
> --- a/lib/strnlen_user.c
> +++ b/lib/strnlen_user.c
> @@ -3,16 +3,10 @@
>  #include <linux/export.h>
>  #include <linux/uaccess.h>
>  #include <linux/mm.h>
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
> index 67bcd5dfd847..3a17f71029bb 100644
> --- a/lib/test_user_copy.c
> +++ b/lib/test_user_copy.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/vmalloc.h>
> +#include <linux/random.h>
>  
>  /*
>   * Several 32-bit architectures support 64-bit {get,put}_user() calls.
> @@ -31,14 +32,129 @@
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
> +static bool is_zeroed(void *from, size_t size)
> +{
> +	return memchr_inv(from, 0x0, size) == NULL;
> +}
> +
> +static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
> +{
> +	int ret = 0;
> +	size_t start, end, i;
> +	size_t zero_start = size / 4;
> +	size_t zero_end = size - zero_start;
> +
> +	/*
> +	 * We conduct a series of check_nonzero_user() tests on a block of memory
> +	 * with the following byte-pattern (trying every possible [start,end]
> +	 * pair):
> +	 *
> +	 *   [ 00 ff 00 ff ... 00 00 00 00 ... ff 00 ff 00 ]
> +	 *
> +	 * And we verify that check_nonzero_user() acts identically to memchr_inv().
> +	 */
> +
> +	memset(kmem, 0x0, size);
> +	for (i = 1; i < zero_start; i += 2)
> +		kmem[i] = 0xff;
> +	for (i = zero_end; i < size; i += 2)
> +		kmem[i] = 0xff;
> +
> +	ret |= test(copy_to_user(umem, kmem, size),
> +		    "legitimate copy_to_user failed");
> +
> +	for (start = 0; start <= size; start++) {
> +		for (end = start; end <= size; end++) {
> +			size_t len = end - start;
> +			int retval = check_zeroed_user(umem + start, len);
> +			int expected = is_zeroed(kmem + start, len);
> +
> +			ret |= test(retval != expected,
> +				    "check_nonzero_user(=%d) != memchr_inv(=%d) mismatch (start=%zu, end=%zu)",
> +				    retval, expected, start, end);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int test_copy_struct_from_user(char *kmem, char __user *umem,
> +				      size_t size)
> +{
> +	int ret = 0;
> +	char *rand = NULL, *expected = NULL;
> +	size_t ksize, usize;
> +
> +	rand = kmalloc(size, GFP_KERNEL);
> +	if (ret |= test(rand == NULL, "kmalloc failed"))
> +		goto out_free;
> +
> +	expected = kmalloc(size, GFP_KERNEL);
> +	if (ret |= test(expected == NULL, "kmalloc failed"))
> +		goto out_free;
> +
> +	/* Fill umem with random bytes. */
> +	memset(kmem, 0x0, size);
> +	prandom_bytes(rand, size);

I don't really like using random() in tests on the chance that we get
failures we can't reproduced. If you want to do this (instead of using a
byte-fill pattern), you need to dump the entire state of the memory
region. Why not just memset(rand, 0xff, ...)? (And obviously rename
"rand")

> +	ret |= test(copy_to_user(umem, rand, size),
> +		    "legitimate copy_to_user failed");
> +
> +	/* Check basic case -- (usize == ksize). */
> +	ksize = size;
> +	usize = size;

I'd move the memset(kmem, 0x0, size); down to here.

> +	memcpy(expected, rand, ksize);
> +
> +	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
> +		    "copy_struct_from_user(usize == ksize) failed");
> +	ret |= test(memcmp(kmem, expected, ksize),
> +		    "copy_struct_from_user(usize == ksize) gives unexpected copy");
> +
> +	/* Old userspace case -- (usize < ksize). */
> +	ksize = size;
> +	usize = ksize / 2;
> +

I would expect memset(kmem, 0x0, size); again here since a new test of
that region is starting.

> +	memcpy(expected, rand, usize);
> +	memset(expected + usize, 0x0, ksize - usize);
> +
> +	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
> +		    "copy_struct_from_user(usize < ksize) failed");
> +	ret |= test(memcmp(kmem, expected, ksize),
> +		    "copy_struct_from_user(usize < ksize) gives unexpected copy");
> +
> +	/* New userspace (-E2BIG) case -- (usize > ksize). */
> +	usize = size;
> +	ksize = usize / 2;

and here?

> +
> +	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize) != -E2BIG,
> +		    "copy_struct_from_user(usize > ksize) didn't give E2BIG");
> +
> +	/* New userspace (success) case -- (usize > ksize). */
> +	usize = size;
> +	ksize = usize / 2;
> +

and here?

> +	memcpy(expected, rand, ksize);
> +
> +	ret |= test(clear_user(umem + ksize, usize - ksize),
> +		    "legitimate clear_user failed");
> +	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
> +		    "copy_struct_from_user(usize > ksize) failed");
> +	ret |= test(memcmp(kmem, expected, ksize),
> +		    "copy_struct_from_user(usize > ksize) gives unexpected copy");
> +
> +out_free:
> +	kfree(expected);
> +	kfree(rand);
> +	return ret;
> +}
> +
>  static int __init test_user_copy_init(void)
>  {
>  	int ret = 0;
> @@ -106,6 +222,11 @@ static int __init test_user_copy_init(void)
>  #endif
>  #undef test_legit
>  
> +	/* Test usage of check_nonzero_user(). */
> +	ret |= test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
> +	/* Test usage of copy_struct_from_user(). */
> +	ret |= test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
> +
>  	/*
>  	 * Invalid usage: none of these copies should succeed.
>  	 */
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index c2bfbcaeb3dc..cf7f854ed9c8 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/uaccess.h>
> +#include <linux/bitops.h>
>  
>  /* out-of-line parts */
>  
> @@ -31,3 +32,125 @@ unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
>  }
>  EXPORT_SYMBOL(_copy_to_user);
>  #endif
> +
> +/**
> + * check_zeroed_user: check if a userspace buffer only contains zero bytes
> + * @from: Source address, in userspace.
> + * @size: Size of buffer.
> + *
> + * This is effectively shorthand for "memchr_inv(from, 0, size) == NULL" for
> + * userspace addresses (and is more efficient because we don't care where the
> + * first non-zero byte is).
> + *
> + * Returns:
> + *  * 0: There were non-zero bytes present in the buffer.
> + *  * 1: The buffer was full of zero bytes.
> + *  * -EFAULT: access to userspace failed.
> + */
> +int check_zeroed_user(const void __user *from, size_t size)
> +{
> +	unsigned long val;
> +	uintptr_t align = (uintptr_t) from % sizeof(unsigned long);
> +
> +	if (unlikely(size == 0))
> +		return 1;
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
> +EXPORT_SYMBOL(check_zeroed_user);
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
> + *      if (usize > PAGE_SIZE)
> + *        return -E2BIG;
> + *      if (usize < FOO_SIZE_VER0)
> + *        return -EINVAL;
> + *
> + *      err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
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

I'd like to see this be marked __always_inline so the dst type is known
to the compiler during the copy_from_user() size sanity checks, etc.

> +{
> +	size_t size = min(ksize, usize);
> +	size_t rest = max(ksize, usize) - size;
> +
> +	/* Deal with trailing bytes. */
> +	if (usize < ksize) {
> +		memset(dst + size, 0, rest);
> +	} else if (usize > ksize) {
> +		int ret = check_zeroed_user(src + size, rest);
> +		if (ret <= 0)
> +			return ret ?: -E2BIG;
> +	}
> +	/* Copy the interoperable parts of the struct. */
> +	if (copy_from_user(dst, src, size))
> +		return -EFAULT;
> +	return 0;
> +}
> +EXPORT_SYMBOL(copy_struct_from_user);
> -- 
> 2.23.0
> 

But besides those things, yes please. :)

-- 
Kees Cook
