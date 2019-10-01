Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A371DC2BC2
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfJAB6m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 21:58:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34851 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfJAB6m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Sep 2019 21:58:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so6776296pfw.2
        for <linux-api@vger.kernel.org>; Mon, 30 Sep 2019 18:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V13OWGdOgQZc0p8jcFcksNKGAg1h1vgIDhJUeYe6EjA=;
        b=CQkP+Pn4SrN43elxLPl3lRSSih8N/K+RJ8mCbFGae73ZgNBdriOIuOQVTRwHPqoBaw
         2uSWTdQXM4T1vmiSq2j/950XSKLhl7SlHbdYlo8JF2bxpSy6vFSvqeRy94C2Q2QpI4N1
         fLdAvgmAXRFaGfry1lmfc1QcesO48+B6XIk6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V13OWGdOgQZc0p8jcFcksNKGAg1h1vgIDhJUeYe6EjA=;
        b=K2fQcoPyAv6EKgkuoO+jko1xbxHHwc0zkW65JaFsxkct3gn94BxU4W1WJBOMTa6T1n
         VMuDnS6Kgy5Sl6ss0qkU7tRrpi3fhejvOSJxbqKDe5z3aMErjj0qJHIX7RU5dMX3hC8A
         sM7a+ZF9ehpcsFQe7izx68T5UfAhNvC/3zY0juipjQ+KRQIIHh2WSBKghG7gdnsoeMUl
         qEKZ/C53owAQz5wQWDyhdx0xV4o4af2ArW8FvrceB4oIda471Lh1U2KeJMTyrwCy1Beu
         s/qXc0/5OxoSclRwfPUj3G9rmrq+CSumsdi+an9WP31XNe61Mdd21PG1FC4WaJM7JH7I
         OVSA==
X-Gm-Message-State: APjAAAUGj+IPqDJ/n0kPvRc8/auDN7DcA5YHGA6CE/Pr9fi/upIpq0rK
        OMC6LU6FErUHZtbbC5n7xqEbm21Gj9c=
X-Google-Smtp-Source: APXvYqwfQ7ZP6YE7B7tN65nhMUqu79o93n2Y6H0GpdorOuxDSEdq01lxwsgs9lqlYCV4LblozdDPcw==
X-Received: by 2002:a62:76d1:: with SMTP id r200mr25943545pfc.27.1569895121675;
        Mon, 30 Sep 2019 18:58:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l12sm19539490pgs.44.2019.09.30.18.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 18:58:40 -0700 (PDT)
Date:   Mon, 30 Sep 2019 18:58:39 -0700
From:   Kees Cook <keescook@chromium.org>
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
Subject: Re: [PATCH v4 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <201909301856.01255535BD@keescook>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-2-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001011055.19283-2-cyphar@cyphar.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 11:10:52AM +1000, Aleksa Sarai wrote:
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
>  include/linux/uaccess.h |  70 +++++++++++++++++++++
>  lib/strnlen_user.c      |   8 +--
>  lib/test_user_copy.c    | 136 ++++++++++++++++++++++++++++++++++++++--
>  lib/usercopy.c          |  55 ++++++++++++++++
>  5 files changed, 263 insertions(+), 13 deletions(-)
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
> index 70bbdc38dc37..8abbc713f7fb 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -231,6 +231,76 @@ __copy_from_user_inatomic_nocache(void *to, const void __user *from,
>  
>  #endif		/* ARCH_HAS_NOCACHE_UACCESS */
>  
> +extern int check_zeroed_user(const void __user *from, size_t size);
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
> +static __always_inline
> +int copy_struct_from_user(void *dst, size_t ksize,
> +			  const void __user *src, size_t usize)

And of course I forgot to realize both this and check_zeroed_user()
should also have the __must_check attribute. Sorry for forgetting that
earlier!

With that, please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for working on this!

-- 
Kees Cook
