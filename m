Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB803C2BE1
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 04:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfJACbs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 22:31:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43970 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJACbs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Sep 2019 22:31:48 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iF7wl-0005MK-Uv; Tue, 01 Oct 2019 02:31:28 +0000
Date:   Tue, 1 Oct 2019 04:31:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20191001023126.qhzeiwmtoo4agy7t@wittgenstein>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-2-cyphar@cyphar.com>
 <201909301856.01255535BD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201909301856.01255535BD@keescook>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 30, 2019 at 06:58:39PM -0700, Kees Cook wrote:
> On Tue, Oct 01, 2019 at 11:10:52AM +1000, Aleksa Sarai wrote:
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
> >  include/linux/bitops.h  |   7 +++
> >  include/linux/uaccess.h |  70 +++++++++++++++++++++
> >  lib/strnlen_user.c      |   8 +--
> >  lib/test_user_copy.c    | 136 ++++++++++++++++++++++++++++++++++++++--
> >  lib/usercopy.c          |  55 ++++++++++++++++
> >  5 files changed, 263 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index cf074bce3eb3..c94a9ff9f082 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -4,6 +4,13 @@
> >  #include <asm/types.h>
> >  #include <linux/bits.h>
> >  
> > +/* Set bits in the first 'n' bytes when loaded from memory */
> > +#ifdef __LITTLE_ENDIAN
> > +#  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
> > +#else
> > +#  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
> > +#endif
> > +
> >  #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
> >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
> >  
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index 70bbdc38dc37..8abbc713f7fb 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -231,6 +231,76 @@ __copy_from_user_inatomic_nocache(void *to, const void __user *from,
> >  
> >  #endif		/* ARCH_HAS_NOCACHE_UACCESS */
> >  
> > +extern int check_zeroed_user(const void __user *from, size_t size);
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
> > + *      if (usize > PAGE_SIZE)
> > + *        return -E2BIG;
> > + *      if (usize < FOO_SIZE_VER0)
> > + *        return -EINVAL;
> > + *
> > + *      err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
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
> > +static __always_inline
> > +int copy_struct_from_user(void *dst, size_t ksize,
> > +			  const void __user *src, size_t usize)
> 
> And of course I forgot to realize both this and check_zeroed_user()
> should also have the __must_check attribute. Sorry for forgetting that
> earlier!

Just said to Aleksa that I'll just fix this up when I apply so he
doesn't have to resend. You ok with this, Kees?

> 
> With that, please consider it:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
