Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785033C2066
	for <lists+linux-api@lfdr.de>; Fri,  9 Jul 2021 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhGIIE7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Jul 2021 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhGIIE6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Jul 2021 04:04:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA89C0613DD;
        Fri,  9 Jul 2021 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CQxNwFkcX7A/c1W/IMz29S1TRXoiDHFmDA3Gc++dNQY=; b=FNzjBumOfS4kLskp2K+DaMEk5R
        mpz3GygAszOVKQ4lPiUUHrAdP4Duh7mcPgsabu7cwzmNW9suFoyTX9Q57uF+ND/uw1ovS62/hWJWw
        EBxzO6omqO6yD2NAaANAa8j2UJnHoop93adPTpRaJ+13F17MnlSVCt8jKFwdqvS9aObiMcVIuC1Ce
        GHO17AdGROSa2c7LTbCAuuxKqJlZ37Kidd+zGBSIBnElGMD+dnhOPBs5Ak0MM2vXhJFxznJJlNb2W
        Acexc4zUKLlNfOrgNV4v4RCYJ3FW69P9S4CvnD1C+U56FTxEDIuxKy3FNdb8D0HBUAGu/xxK156Aa
        GOft4mFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1lST-00G1c1-L3; Fri, 09 Jul 2021 08:02:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C535930022B;
        Fri,  9 Jul 2021 10:01:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A09072008EF3D; Fri,  9 Jul 2021 10:01:56 +0200 (CEST)
Date:   Fri, 9 Jul 2021 10:01:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic
 helpers
Message-ID: <YOgCdMWE9OXvqczk@hirez.programming.kicks-ass.net>
References: <20210708194638.128950-1-posk@google.com>
 <20210708194638.128950-3-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708194638.128950-3-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 08, 2021 at 12:46:37PM -0700, Peter Oskolkov wrote:

> +static inline int umcg_atomic_cmpxchg_64(u64 *uval, u64 __user *uaddr,
> +						u64 oldval, u64 newval)
> +{
> +	int ret = 0;
> +
> +	if (!user_access_begin(uaddr, sizeof(u64)))
> +		return -EFAULT;
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
> +	user_access_end();
> +	*uval = oldval;
> +	return ret;
> +}

> +static inline int fix_pagefault(unsigned long uaddr, bool write_fault)
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

> +static inline int umcg_cmpxchg_64_user(u64 __user *uaddr, u64 *prev, u64 val)
> +{
> +	while (true) {
> +		int ret;
> +		u64 expected = *prev;
> +
> +		pagefault_disable();
> +		ret = umcg_atomic_cmpxchg_64(prev, uaddr, expected, val);
> +		pagefault_enable();
> +
> +		if (!ret)
> +			return *prev == expected ? 0 : -EAGAIN;
> +
> +		if (WARN_ONCE(ret != -EFAULT, "Unexpected error"))
> +			return -EFAULT;
> +
> +		ret = fix_pagefault((unsigned long)uaddr, true);
> +		if (ret)
> +			return -EFAULT;
> +	}
> +}
> +
> +/**
> + * atomic_stack_push_user - push a node onto the stack
> + * @head - a pointer to the head of the stack;
> + * @node - a pointer to the node to push.
> + *
> + * Push a node onto a single-linked list (stack). Atomicity/correctness
> + * is guaranteed by locking the head via settings its first bit (assuming
> + * the pointer is aligned).
> + *
> + * Return: 0 on success, -EFAULT on error.
> + */
> +static inline int atomic_stack_push_user(u64 __user *head, u64 __user *node)
> +{
> +	while (true) {
> +		int ret;
> +		u64 first;
> +
> +		smp_mb();  /* Make the read below clean. */
> +		if (get_user(first, head))
> +			return -EFAULT;
> +
> +		if (first & 1UL) {
> +			cpu_relax();
> +			continue;  /* first is being deleted. */
> +		}
> +
> +		if (put_user(first, node))
> +			return -EFAULT;
> +		smp_mb();  /* Make the write above visible. */
> +
> +		ret = umcg_cmpxchg_64_user(head, &first, (u64)node);
> +		if (!ret)
> +			return 0;
> +
> +		if (ret == -EAGAIN) {
> +			cpu_relax();
> +			continue;
> +		}
> +
> +		if (WARN_ONCE(ret != -EFAULT, "unexpected umcg_cmpxchg result"))
> +			return -EFAULT;
> +
> +		return -EFAULT;
> +	}
> +}


This is horrible... Jann is absolutely right, you do not, *ever* do
userspace spinlocks. What's wrong with the trivial lockless single
linked list approach?

On top of that, you really want to avoid all that endless stac/clac
nonsense and only have that once, at the outer edges of things.

Something like the *completely* untested below (except it needs lots of
extra gunk to support compilers without asm-goto-output, and more widths
and ...


#define __try_cmpxchg_user_size(ptr, oldp, new, size, label)		\
({									\
	_Bool __success;						\
	__chk_user_ptr(ptr);						\
	__typeof__(ptr) _old = (__typeof__(ptr))(oldp);			\
	__typeof__(*(ptr)) __old = *_old;				\
	__typeof__(*(ptr)) __new = (new);				\
	switch (size) {							\
	case 8:								\
		volatile u64 *__ptr = (volatile u64 *)(ptr);		\
		asm_volatile_goto("1: " LOCK_PREFIX "cmpxchgq %[new], %[ptr]" \
				  CC_SET(z)				\
				  _ASM_EXTABLE_UA(1b, %l[label])	\
				  : CC_OUT(x) (__success),		\
				    [ptr] "+m" (*__ptr),		\
				    [old] "+a" (__old),			\
				  : [new] "r" (__new)			\
				  : "memory"				\
				  : label);				\
		break;							\
	}								\
	if (unlikely(!success))						\
		*_old = __old;						\
	__success;							\
})

#define unsafe_try_cmpxchg_user(ptr, oldp, new, label)			\
	__try_cmpxchg_user_size((ptr), (oldp), (new), sizeof(*(ptr)), label);

int user_llist_add(u64 __user *new, u64 __user *head)
{
	u64 first;
	int ret;

	if (unlikely(!access_ok(new, sizeof(*new)) ||
		     !access_ok(head, sizeof(*head))))
		return -EFAULT;

again:
	__uaccess_begin_nospec();

	unsafe_get_user(first, head, Efault_head);
	do {
		unsafe_put_user(first, new, Efault_new);
	} while (!unsafe_try_cmpxchg_user(head, &first, new, Efault_head));

	user_access_end();

	return 0;

Efault_new:
	user_access_end();

	ret = fixup_fault(new);
	if (ret < 0)
		return ret;

	goto again;

Efault_head:
	user_access_end();

	ret = fixup_fault(head);
	if (ret < 0)
		return ret;

	goto again;
}
