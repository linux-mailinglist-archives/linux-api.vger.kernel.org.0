Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2F410CDF
	for <lists+linux-api@lfdr.de>; Sun, 19 Sep 2021 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhISS1T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Sep 2021 14:27:19 -0400
Received: from out0.migadu.com ([94.23.1.103]:49328 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhISS0R (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 19 Sep 2021 14:26:17 -0400
Date:   Mon, 20 Sep 2021 02:25:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632075890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4C3lEksWVzl3mg3d/cunricm5QlTEZMFKSvIlQVBpWg=;
        b=abCZfzG1VbVqBys9KEt3lv8KP3u5+1lAc83bNzesSPxEKQhpLFl5guFeE0vxXiHcn4yoIz
        zP7ZcCFzNq2lyoqBGmIT3qx0+/WAoQqfnvib+59/418J64BIXGscD5I8FYJbjhu9amHWt+
        vIFiBZ0E1j/F4XxPS+xcj8Q5/FUl9OA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH 2/5 v0.6] sched/umcg: RFC: add userspace atomic helpers
Message-ID: <YUeApJQ6AiFcy1+Z@geo.homenetwork>
References: <20210917180323.278250-1-posk@google.com>
 <20210917180323.278250-3-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917180323.278250-3-posk@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 17, 2021 at 11:03:20AM -0700, Peter Oskolkov wrote:

> Add helper functions to work atomically with userspace 32/64 bit values -
> there are some .*futex.* named helpers, but they are not exactly
> what is needed for UMCG; I haven't found what else I could use, so I
> rolled these.
> 
> At the moment only X86_64 is supported.
> 
> Note: the helpers should probably go into arch/ somewhere; I have
> them in kernel/sched/umcg_uaccess.h temporarily for convenience. Please
> let me know where I should put them.
> 
> Changelog:
> v0.5->v0.6:
>  - replaced mmap_read_lock with mmap_read_lock_killable in fix_pagefault();
>  - fix_pagefault now validates proper uaddr alignment;
>  - renamed umcg.h to umcg_uaccess.h;
> v0.4->v0.5:
>  - added xchg_user_** helpers;
> v0.3->v0.4:
>  - added put_user_nosleep;
>  - removed linked list/stack operations patch;
> v0.2->v0.3:
>  - renamed and refactored the helpers a bit, as described above;
>  - moved linked list/stack operations into a separate patch.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
>  kernel/sched/umcg_uaccess.h | 344 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 344 insertions(+)
>  create mode 100644 kernel/sched/umcg_uaccess.h
> 
> diff --git a/kernel/sched/umcg_uaccess.h b/kernel/sched/umcg_uaccess.h
> new file mode 100644
> index 000000000000..e4ead8d2fd62
> --- /dev/null
> +++ b/kernel/sched/umcg_uaccess.h
> @@ -0,0 +1,344 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _KERNEL_SCHED_UMCG_UACCESS_H
> +#define _KERNEL_SCHED_UMCG_UACCESS_H
> +
> +#ifdef CONFIG_X86_64
> +
> +#include <linux/uaccess.h>
> +
> +#include <asm/asm.h>
> +#include <linux/atomic.h>
> +#include <asm/uaccess.h>
> +
> +/* TODO: move atomic operations below into arch/ headers */
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
> +static inline int fix_pagefault(unsigned long uaddr, bool write_fault, int bytes)
> +{
> +	struct mm_struct *mm = current->mm;
> +	int ret;
> +
> +	/* Validate proper alignment. */
> +	if (uaddr % bytes)
> +		return -EINVAL;
> +
> +	if (mmap_read_lock_killable(mm))
> +		return -EINTR;
> +	ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
> +			NULL);
> +	mmap_read_unlock(mm);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +/**
> + * cmpxchg_32_user_nosleep - compare_exchange 32-bit values
      ^^^^^^^^^^^^^^^^^^^^^^^
Need to be consistent with the function name below.

> + * Return:
> + * 0 - OK
> + * -EFAULT: memory access error
> + * -EAGAIN: @expected did not match; consult @prev
> + */
> +static inline int cmpxchg_user_32_nosleep(u32 __user *uaddr, u32 *old, u32 new)
> +{
> +	int ret = -EFAULT;
> +	u32 __old = *old;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	__uaccess_begin_nospec();
> +	ret = __try_cmpxchg_user_32(old, uaddr, __old, new);
> +	user_access_end();
> +
> +	if (!ret)
> +		ret =  *old == __old ? 0 : -EAGAIN;
> +
> +	pagefault_enable();
> +	return ret;
> +}
> +
> +/**
> + * cmpxchg_64_user_nosleep - compare_exchange 64-bit values
      ^^^^^^^^^^^^^^^^^^^^^^^
Ditto.

> + * Return:
> + * 0 - OK
> + * -EFAULT: memory access error
> + * -EAGAIN: @expected did not match; consult @prev
> + */
> +static inline int cmpxchg_user_64_nosleep(u64 __user *uaddr, u64 *old, u64 new)
> +{
> +	int ret = -EFAULT;
> +	u64 __old = *old;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	__uaccess_begin_nospec();
> +	ret = __try_cmpxchg_user_64(old, uaddr, __old, new);
> +	user_access_end();
> +
> +	if (!ret)
> +		ret =  *old == __old ? 0 : -EAGAIN;
> +
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +
> +/**
> + * cmpxchg_32_user - compare_exchange 32-bit values
      ^^^^^^^^^^^^^^^
Ditto.

> + * Return:
> + * 0 - OK
> + * -EFAULT: memory access error
> + * -EAGAIN: @expected did not match; consult @prev
> + */
> +static inline int cmpxchg_user_32(u32 __user *uaddr, u32 *old, u32 new)
> +{
> +	int ret = -EFAULT;
> +	u32 __old = *old;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +		__uaccess_begin_nospec();
> +		ret = __try_cmpxchg_user_32(old, uaddr, __old, new);
> +		user_access_end();
> +
> +		if (!ret) {
> +			ret =  *old == __old ? 0 : -EAGAIN;
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
> + * cmpxchg_64_user - compare_exchange 64-bit values
      ^^^^^^^^^^^^^^^
Ditto.

> + * Return:
> + * 0 - OK
> + * -EFAULT: memory access error
> + * -EAGAIN: @expected did not match; consult @prev
> + */
> +static inline int cmpxchg_user_64(u64 __user *uaddr, u64 *old, u64 new)
> +{
> +	int ret = -EFAULT;
> +	u64 __old = *old;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +		__uaccess_begin_nospec();
> +		ret = __try_cmpxchg_user_64(old, uaddr, __old, new);
> +		user_access_end();
> +
> +		if (!ret) {
> +			ret =  *old == __old ? 0 : -EAGAIN;
> +			break;
> +		}
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
> +static inline int __try_xchg_user_32(u32 *oval, u32 __user *uaddr, u32 newval)
> +{
> +	u32 oldval = 0;
> +	int ret = 0;
> +
> +	asm volatile("\n"
> +		"1:\txchgl %0, %2\n"
> +		"2:\n"
> +		"\t.section .fixup, \"ax\"\n"
> +		"3:\tmov     %3, %0\n"
> +		"\tjmp     2b\n"
> +		"\t.previous\n"
> +		_ASM_EXTABLE_UA(1b, 3b)
> +		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
> +		: "i" (-EFAULT), "0" (newval), "1" (0)
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
> +		"3:\tmov     %3, %0\n"
> +		"\tjmp     2b\n"
> +		"\t.previous\n"
> +		_ASM_EXTABLE_UA(1b, 3b)
> +		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
> +		: "i" (-EFAULT), "0" (newval), "1" (0)
> +	);
> +
> +	if (ret)
> +		return ret;
> +
> +	*oval = oldval;
> +	return 0;
> +}
> +
> +/**
> + * xchg_32_user - atomically exchange 64-bit values
      ^^^^^^^^^^^^
Ditto.

> + * Return:
> + * 0 - OK
> + * -EFAULT: memory access error
> + */
> +static inline int xchg_user_32(u32 __user *uaddr, u32 *val)
> +{
> +	int ret = -EFAULT;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +
> +		__uaccess_begin_nospec();
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
> +/**
> + * xchg_64_user - atomically exchange 64-bit values
      ^^^^^^^^^^^^
Ditto.

> + * Return:
> + * 0 - OK
> + * -EFAULT: memory access error
> + */
> +static inline int xchg_user_64(u64 __user *uaddr, u64 *val)
> +{
> +	int ret = -EFAULT;
> +
> +	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +
> +	while (true) {
> +
> +		__uaccess_begin_nospec();
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
> +
> +/**
> + * get_user_nosleep - get user value without sleeping.
> + *
> + * get_user() might sleep and therefore cannot be used in preempt-disabled
> + * regions.
> + */
> +#define get_user_nosleep(out, uaddr)			\
> +({							\
> +	int ret = -EFAULT;				\
> +							\
> +	if (access_ok((uaddr), sizeof(*(uaddr)))) {	\
> +		pagefault_disable();			\
> +							\
> +		if (!__get_user((out), (uaddr)))	\
> +			ret = 0;			\
> +							\
> +		pagefault_enable();			\
> +	}						\
> +	ret;						\
> +})
> +
> +#endif  /* CONFIG_X86_64 */
> +#endif  /* _KERNEL_SCHED_UMCG_UACCESS_H */
> --
> 2.25.1
> 



Thanks,
Tao
