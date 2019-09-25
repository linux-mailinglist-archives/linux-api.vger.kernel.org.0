Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEBBE344
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 19:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442935AbfIYRUR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 13:20:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50917 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442934AbfIYRUR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 13:20:17 -0400
Received: from [185.81.138.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iDAxP-0007bi-4j; Wed, 25 Sep 2019 17:20:03 +0000
Date:   Wed, 25 Sep 2019 19:20:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20190925172000.5lgfi4vdkol5rlhs@wittgenstein>
References: <20190925165915.8135-1-cyphar@cyphar.com>
 <20190925165915.8135-2-cyphar@cyphar.com>
 <20190925171810.ajfx4zlmj5scct4m@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925171810.ajfx4zlmj5scct4m@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 25, 2019 at 07:18:11PM +0200, Christian Brauner wrote:
> On Wed, Sep 25, 2019 at 06:59:12PM +0200, Aleksa Sarai wrote:
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
> > [1]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
> >      robustify sched_read_attr() ABI logic and code")
> > 
> > [2]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
> >      similar checks to copy_struct_from_user() while rt_sigprocmask(2)
> >      always rejects differently-sized struct arguments.
> > 
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  include/linux/uaccess.h |  4 +++
> >  lib/Makefile            |  2 +-
> >  lib/strnlen_user.c      | 52 +++++++++++++++++++++++++++++
> >  lib/struct_user.c       | 73 +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 130 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/struct_user.c
> 
> Hm, why the new file?
> Couldn't this just live in usercopy.c?
> 
> > 
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index 34a038563d97..824569e309e4 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -230,6 +230,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
> >  
> >  #endif		/* ARCH_HAS_NOCACHE_UACCESS */
> >  
> > +extern int is_zeroed_user(const void __user *from, size_t count);
> > +extern int copy_struct_from_user(void *dst, size_t ksize,
> > +				 const void __user *src, size_t usize);
> > +
> >  /*
> >   * probe_kernel_read(): safely attempt to read from a location
> >   * @dst: pointer to the buffer that shall take the data
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 29c02a924973..d86c71feaf0a 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -28,7 +28,7 @@ endif
> >  CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
> >  endif
> >  
> > -lib-y := ctype.o string.o vsprintf.o cmdline.o \
> > +lib-y := ctype.o string.o struct_user.o vsprintf.o cmdline.o \
> >  	 rbtree.o radix-tree.o timerqueue.o xarray.o \
> >  	 idr.o extable.o \
> >  	 sha1.o chacha.o irq_regs.o argv_split.o \
> > diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> > index 7f2db3fe311f..7eb665732954 100644
> > --- a/lib/strnlen_user.c
> > +++ b/lib/strnlen_user.c
> > @@ -123,3 +123,55 @@ long strnlen_user(const char __user *str, long count)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(strnlen_user);
> > +
> > +/**
> > + * is_zeroed_user: check if a userspace buffer is full of zeros
> > + * @from:  Source address, in userspace.
> > + * @size: Size of buffer.
> > + *
> > + * This is effectively shorthand for "memchr_inv(from, 0, size) == NULL" for
> > + * userspace addresses. If there are non-zero bytes present then false is
> > + * returned, otherwise true is returned.
> > + *
> > + * Returns:
> > + *  * -EFAULT: access to userspace failed.
> > + */
> > +int is_zeroed_user(const void __user *from, size_t size)
> 
> *sigh*, I'm probably going to get yelled at because of this but: does
> this really provide any _performance_ benefits over the dumb get_user()
> loop that we currently have that we care about right now? My point
> being, that the loop - imho - is much easier to understand than what is
> going on here with all the masking, and aligning etc. that we have here.
> But I'm not going to fight it.
> 
> > +{
> > +	u64 val;
> > +	uintptr_t align = (uintptr_t) from % 8;
> > +
> > +	if (unlikely(!size))
> > +		return true;
> 
> Nit: I'd prefer int variables be checked with if (size != 0) :)
> 
> > +
> > +	from -= align;
> > +	size += align;
> > +
> > +	if (!user_access_begin(from, size))
> > +		return -EFAULT;
> > +
> > +	while (size >= 8) {
> > +		unsafe_get_user(val, (u64 __user *) from, err_fault);
> > +		if (align) {
> > +			/* @from is unaligned. */
> > +			val &= ~aligned_byte_mask(align);
> > +			align = 0;
> > +		}
> > +		if (val)
> > +			goto done;
> > +		from += 8;
> > +		size -= 8;
> > +	}
> > +	if (size) {
> > +		/* (@from + @size) is unaligned. */
> > +		unsafe_get_user(val, (u64 __user *) from, err_fault);
> > +		val &= aligned_byte_mask(size);
> > +	}
> > +
> > +done:
> > +	user_access_end();
> > +	return (val == 0);
> > +err_fault:
> > +	user_access_end();
> > +	return -EFAULT;
> > +}
> > diff --git a/lib/struct_user.c b/lib/struct_user.c
> > new file mode 100644
> > index 000000000000..57d79eb53bfa
> > --- /dev/null
> > +++ b/lib/struct_user.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2019 SUSE LLC
> > + * Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/export.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +
> > +/**
> > + * copy_struct_from_user: copy a struct from userspace
> > + * @dst:   Destination address, in kernel space. This buffer must be @ksize
> > + *         bytes long.
> > + * @ksize: Size of @dst struct.
> > + * @src:   Source address, in userspace.
> > + * @usize: (Alleged) size of @src struct.
> > + *
> > + * Copies a struct from userspace to kernel space, in a way that guarantees
> > + * backwards-compatibility for struct syscall arguments (as long as future
> > + * struct extensions are made such that all new fields are *appended* to the
> > + * old struct, and zeroed-out new fields have the same meaning as the old
> > + * struct).
> > + *
> > + * @ksize is just sizeof(*dst), and @usize should've been passed by userspace.
> > + * The recommended usage is something like the following:
> > + *
> > + *   SYSCALL_DEFINE2(foobar, const struct foo __user *, uarg, size_t, usize)
> > + *   {
> > + *      int err;
> > + *      struct foo karg = {};
> > + *
> > + *      err = copy_struct_from_user(&karg, sizeof(karg), uarg, size);
> > + *      if (err)
> > + *        return err;
> > + *
> > + *      // ...
> > + *   }
> > + *
> > + * There are three cases to consider:
> > + *  * If @usize == @ksize, then it's copied verbatim.
> > + *  * If @usize < @ksize, then the userspace has passed an old struct to a
> > + *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @usize)
> > + *    are to be zero-filled.
> > + *  * If @usize > @ksize, then the userspace has passed a new struct to an
> > + *    older kernel. The trailing bytes unknown to the kernel (@usize - @ksize)
> > + *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
> > + *
> > + * Returns (in all cases, some data may have been copied):
> > + *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes in @src.
> > + *  * -EFAULT: access to userspace failed.
> > + */
> > +int copy_struct_from_user(void *dst, size_t ksize,
> > +			  const void __user *src, size_t usize)

Hm, and should that get tests in test_usercopy.c?

Christian
