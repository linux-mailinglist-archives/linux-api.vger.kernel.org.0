Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2544A5BE
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 05:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhKIEVE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Nov 2021 23:21:04 -0500
Received: from out2.migadu.com ([188.165.223.204]:50676 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236033AbhKIEVE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 8 Nov 2021 23:21:04 -0500
Date:   Tue, 9 Nov 2021 12:18:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636431497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zcx9kemVvvPfF/6pbo7VE2DObwW8ePDglZ/Or5HOZg8=;
        b=eehvuX76yvCqcTM6TuHcdgUGJ0CY2cbXVTVGlOLz5UDLS/c1A89cL550Z2ece0pi14KhW7
        RA1dDanAzEd7h7RkEod9yX8Iq/SjmpKsJCn9x9YpaF7YQaJBHMD8iVdPcl1G5otnCjBcuC
        5kQKhAf17z2wvupwhwAu9IWiluBYzFk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH v0.8 2/6] mm, x86/uaccess: add userspace atomic helpers
Message-ID: <YYn2s+S6kMrwMW43@geo.homenetwork>
References: <20211104195804.83240-1-posk@google.com>
 <20211104195804.83240-3-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104195804.83240-3-posk@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 04, 2021 at 12:58:00PM -0700, Peter Oskolkov wrote:

> In addition to futexes needing to do atomic operations in the userspace,
> a second use case is now in the works (UMCG, see
> https://lore.kernel.org/all/20210917180323.278250-1-posk@google.com/),
> so a generic facility to perform these operations has been called for
> (see https://lore.kernel.org/all/87ilyk9xc0.ffs@tglx/).
> 
> Add a set of generic helpers to perform 32/64-bit xchg and cmpxchg
> operations in the userspace. Also implement the required
> architecture-specific support on x86_64.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
>  arch/x86/include/asm/uaccess_64.h |  93 +++++++++++
>  include/linux/uaccess.h           |  46 ++++++
>  mm/maccess.c                      | 264 ++++++++++++++++++++++++++++++
>  3 files changed, 403 insertions(+)
> 
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index 45697e04d771..41e2f96d3ec4 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -79,4 +79,97 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
>  	kasan_check_write(dst, size);
>  	return __copy_user_flushcache(dst, src, size);
>  }
> +
> +#define ARCH_HAS_ATOMIC_UACCESS_HELPERS 1
> +
> +static inline int __try_cmpxchg_user_32(u32 *uval, u32 __user *uaddr,
> +						u32 oldval, u32 newval)
> +{
> +	int ret = 0;
> +
> +	asm volatile("\n"
> +		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
> +		"2:\n"
> +		"\t.section .fixup, \"ax\"\n"
> +		"3:\tmov     %3, %0\n"
> +		"\tjmp     2b\n"
> +		"\t.previous\n"
> +		_ASM_EXTABLE_UA(1b, 3b)
> +		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
> +		: "i" (-EFAULT), "r" (newval), "1" (oldval)
> +		: "memory"
> +	);
> +	*uval = oldval;
> +	return ret;
> +}
> +
> +static inline int __try_cmpxchg_user_64(u64 *uval, u64 __user *uaddr,
> +						u64 oldval, u64 newval)
> +{
> +	int ret = 0;
> +
> +	asm volatile("\n"
> +		"1:\t" LOCK_PREFIX "cmpxchgq %4, %2\n"
> +		"2:\n"
> +		"\t.section .fixup, \"ax\"\n"
> +		"3:\tmov     %3, %0\n"
> +		"\tjmp     2b\n"
> +		"\t.previous\n"
> +		_ASM_EXTABLE_UA(1b, 3b)
> +		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
> +		: "i" (-EFAULT), "r" (newval), "1" (oldval)
> +		: "memory"
> +	);
> +	*uval = oldval;
> +	return ret;
> +}
> +
> +static inline int __try_xchg_user_32(u32 *oval, u32 __user *uaddr, u32 newval)
> +{
> +	u32 oldval = 0;
> +	int ret = 0;
> +
> +	asm volatile("\n"
> +		"1:\txchgl %0, %2\n"
> +		"2:\n"
> +		"\t.section .fixup, \"ax\"\n"
> +		"3:\tmov     %3, %1\n"
> +		"\tjmp     2b\n"
> +		"\t.previous\n"
> +		_ASM_EXTABLE_UA(1b, 3b)
> +		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
> +		: "i" (-EFAULT), "0" (newval), "1" (0)

"1"(0) can be omitted, that ret is initialized. And the initialization
of oldval not need.

> +	);
> +
> +	if (ret)
> +		return ret;
> +
> +	*oval = oldval;
> +	return 0;
> +}
> +
> +static inline int __try_xchg_user_64(u64 *oval, u64 __user *uaddr, u64 newval)
> +{
> +	u64 oldval = 0;
> +	int ret = 0;
> +
> +	asm volatile("\n"
> +		"1:\txchgq %0, %2\n"
> +		"2:\n"
> +		"\t.section .fixup, \"ax\"\n"
> +		"3:\tmov     %3, %1\n"
> +		"\tjmp     2b\n"
> +		"\t.previous\n"
> +		_ASM_EXTABLE_UA(1b, 3b)
> +		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
> +		: "i" (-EFAULT), "0" (newval), "1" (0)

Same of above.

> +	);
> +
> +	if (ret)
> +		return ret;
> +
> +	*oval = oldval;
> +	return 0;
> +}
> +
>  #endif /* _ASM_X86_UACCESS_64_H */
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index ac0394087f7d..dcb3ac093075 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -408,4 +408,50 @@ void __noreturn usercopy_abort(const char *name, const char *detail,
>  			       unsigned long len);
>  #endif
> 
> +#ifdef ARCH_HAS_ATOMIC_UACCESS_HELPERS
> +/**
> + * cmpxchg_user_[32|64][_nofault|]() - compare_exchange 32/64-bit values
> + * @uaddr:     Destination address, in user space;
> + * @curr_val:  Source address, in kernel space;
> + * @new_val:   The value to write to the destination address.
> + *
> + * This is the standard cmpxchg: atomically: compare *@uaddr to *@curr_val;
> + * if the values match, write @new_val to @uaddr, return 0; if the values
> + * do not match, write *@uaddr to @curr_val, return -EAGAIN.
> + *
> + * The _nofault versions don't fault and can be used in
> + * atomic/preempt-disabled contexts.
> + *
> + * Return:
> + * 0      : OK/success;
> + * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
> + * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault);

(including mis-aligned @uaddr in _fault)

> + * -EAGAIN: @old did not match.
> + */
> +int cmpxchg_user_32_nofault(u32 __user *uaddr, u32 *curr_val, u32 new_val);
> +int cmpxchg_user_64_nofault(u64 __user *uaddr, u64 *curr_val, u64 new_val);
> +int cmpxchg_user_32(u32 __user *uaddr, u32 *curr_val, u32 new_val);
> +int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val);
> +
> +/**
> + * xchg_user_[32|64][_nofault|]() - exchange 32/64-bit values
> + * @uaddr:   Destination address, in user space;
> + * @val:     Source address, in kernel space.
> + *
> + * This is the standard atomic xchg: exchange values pointed to by @uaddr and @val.
> + *
> + * The _nofault versions don't fault and can be used in
> + * atomic/preempt-disabled contexts.
> + *
> + * Return:
> + * 0      : OK/success;
> + * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
> + * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault).

(including mis-aligned @uaddr in _fault)

> + */
> +int xchg_user_32_nofault(u32 __user *uaddr, u32 *val);
> +int xchg_user_64_nofault(u64 __user *uaddr, u64 *val);
> +int xchg_user_32(u32 __user *uaddr, u32 *val);
> +int xchg_user_64(u64 __user *uaddr, u64 *val);
> +#endif		/* ARCH_HAS_ATOMIC_UACCESS_HELPERS */
> +
>  #endif		/* __LINUX_UACCESS_H__ */
> diff --git a/mm/maccess.c b/mm/maccess.c
> index d3f1a1f0b1c1..620556b11550 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -335,3 +335,267 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count)
> 
>  	return ret;
>  }
> +
> +#ifdef ARCH_HAS_ATOMIC_UACCESS_HELPERS
> +
> +static int fix_pagefault(unsigned long uaddr, bool write_fault, int bytes)
> +{
> +	struct mm_struct *mm = current->mm;
> +	int ret;
> +
> +	mmap_read_lock(mm);
> +	ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
> +			NULL);
> +	mmap_read_unlock(mm);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +int cmpxchg_user_32_nofault(u32 __user *uaddr, u32 *curr_val, u32 new_val)
> +{
> +	int ret = -EFAULT;
> +	u32 __old = *curr_val;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
> +		pagefault_enable();
> +		return -EFAULT;
> +	}
> +	ret = __try_cmpxchg_user_32(curr_val, uaddr, __old, new_val);
> +	user_access_end();
> +
> +	if (!ret)
> +		ret =  *curr_val == __old ? 0 : -EAGAIN;
> +
> +	pagefault_enable();

May this can be moved to be sibling to user_access_end() even do not
know much about this to me.

> +	return ret;
> +}
> +
> +int cmpxchg_user_64_nofault(u64 __user *uaddr, u64 *curr_val, u64 new_val)
> +{
> +	int ret = -EFAULT;
> +	u64 __old = *curr_val;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
> +		pagefault_enable();
> +		return -EFAULT;
> +	}
> +	ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
> +	user_access_end();
> +
> +	if (!ret)
> +		ret =  *curr_val == __old ? 0 : -EAGAIN;
> +
> +	pagefault_enable();

The same.

> +	return ret;
> +}
> +
> +int cmpxchg_user_32(u32 __user *uaddr, u32 *curr_val, u32 new_val)
> +{
> +	int ret = -EFAULT;
> +	u32 __old = *curr_val;
> +
> +	/* Validate proper alignment. */
> +	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||

See address. sizeof(*uaddr) --> sizeof(uaddr).
The size of address length.

> +			((unsigned long)curr_val % sizeof(*curr_val))))

Same. sizeof(*curr_val) -->  sizeof(curr_val)

> +		return -EINVAL;

This return should be -EFAULT accord to the comment above
if not wrong to me.

> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +		ret = -EFAULT;
> +		if (!user_access_begin(uaddr, sizeof(*uaddr)))
> +			break;
> +
> +		ret = __try_cmpxchg_user_32(curr_val, uaddr, __old, new_val);
> +		user_access_end();
> +
> +		if (!ret) {
> +			ret =  *curr_val == __old ? 0 : -EAGAIN;
> +			break;
> +		}
> +
> +		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
> +			break;
> +	}
> +
> +	pagefault_enable();
> +	return ret;
> +}
> +
> +int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val)
> +{
> +	int ret = -EFAULT;
> +	u64 __old = *curr_val;
> +
> +	/* Validate proper alignment. */
> +	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
> +			((unsigned long)curr_val % sizeof(*curr_val))))
> +		return -EINVAL;

The same as above.. even the address size is equal to the value
size. Not use value size here.

> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +		ret = -EFAULT;
> +		if (!user_access_begin(uaddr, sizeof(*uaddr)))
> +			break;
> +
> +		ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
> +		user_access_end();
> +
> +		if (!ret) {
> +			ret =  *curr_val == __old ? 0 : -EAGAIN;
> +			break;
> +		}
> +
> +		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
> +			break;
> +	}
> +
> +	pagefault_enable();
> +	return ret;
> +}
> +
> +/**
> + * xchg_user_[32|64][_nofault|]() - exchange 32/64-bit values
> + * @uaddr:   Destination address, in user space;
> + * @val:     Source address, in kernel space.
> + *
> + * This is the standard atomic xchg: exchange values pointed to by @uaddr and @val.
> + *
> + * The _nofault versions don't fault and can be used in
> + * atomic/preempt-disabled contexts.
> + *
> + * Return:
> + * 0      : OK/success;
> + * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
> + * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault).
> + */
> +int xchg_user_32_nofault(u32 __user *uaddr, u32 *val)
> +{
> +	int ret;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
> +		pagefault_enable();
> +		return -EFAULT;
> +	}
> +
> +	ret = __try_xchg_user_32(val, uaddr, *val);
> +	user_access_end();
> +
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +
> +int xchg_user_64_nofault(u64 __user *uaddr, u64 *val)
> +{
> +	int ret;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
> +		pagefault_enable();
> +		return -EFAULT;
> +	}
> +
> +	ret = __try_xchg_user_64(val, uaddr, *val);
> +	user_access_end();
> +
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +
> +int xchg_user_32(u32 __user *uaddr, u32 *val)
> +{
> +	int ret = -EFAULT;
> +
> +	/* Validate proper alignment. */
> +	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
> +			((unsigned long)val % sizeof(*val))))
> +		return -EINVAL;

The same as above.

> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +		ret = -EFAULT;
> +		if (!user_access_begin(uaddr, sizeof(*uaddr)))
> +			break;
> +
> +		ret = __try_xchg_user_32(val, uaddr, *val);
> +		user_access_end();
> +
> +		if (!ret)
> +			break;
> +
> +		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
> +			break;
> +	}
> +
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +
> +int xchg_user_64(u64 __user *uaddr, u64 *val)
> +{
> +	int ret = -EFAULT;
> +
> +	/* Validate proper alignment. */
> +	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
> +			((unsigned long)val % sizeof(*val))))
> +		return -EINVAL;

The same as above..

> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +		ret = -EFAULT;
> +		if (!user_access_begin(uaddr, sizeof(*uaddr)))
> +			break;
> +
> +		ret = __try_xchg_user_64(val, uaddr, *val);
> +		user_access_end();
> +
> +		if (!ret)
> +			break;
> +
> +		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
> +			break;
> +	}
> +
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +#endif		/* ARCH_HAS_ATOMIC_UACCESS_HELPERS */
> --
> 2.25.1
> 
