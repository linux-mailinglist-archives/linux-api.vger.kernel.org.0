Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE9EE3FA
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2019 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKDPiH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 Nov 2019 10:38:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPiG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 Nov 2019 10:38:06 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iReQX-0000TV-VZ; Mon, 04 Nov 2019 16:37:58 +0100
Date:   Mon, 4 Nov 2019 16:37:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Shawn Landden <shawn@git.icu>
cc:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking
 ABIs at the same time.
In-Reply-To: <20191104002909.25783-1-shawn@git.icu>
Message-ID: <alpine.DEB.2.21.1911041423510.5102@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, 3 Nov 2019, Shawn Landden wrote:

While you Cc'ed various people for whatever reasons, you missed to Cc 3/4
of the FUTEX maintainers/reviewers from the MAINTAINERS file:

FUTEX SUBSYSTEM
M:      Thomas Gleixner <tglx@linutronix.de>
M:      Ingo Molnar <mingo@redhat.com>
R:      Peter Zijlstra <peterz@infradead.org>
R:      Darren Hart <dvhart@infradead.org>

> The robust futexes ABI was designed to be flexible to changing ABIs in
> glibc, however it did not take into consideration that this ABI is
> particularly sticky, and suffers from lock-step problems, due to the
> fact that the ABI is shared between processes. This introduces a new
> size in set_robust_list that takes an additional futex_offset2 value
> so that two locking ABIs can be used at the same time.

This text does not really explain the problem you are trying to solve. I
can crystalball something out of it, but that's not what a changelog should
force people to do.

> If this new ABI is used, then bit 1 of the *next pointer of the
> user-space robust_list indicates that the futex_offset2 value should
> be used in place of the existing futex_offset.
> 
> The use case for this is sharing locks between 32-bit and 64-bit
> processes, which Linux supports, but glibc does not, and is difficult
> to implement with the current Linux support because of mix-matched
> ABIs.

The problem with mixed processes is that the *next pointer in the robust
list points to some random data structure, but not to the actual futex
value itself. The pointer to the underlying futex value is calculated from
there with 'futex_offset'.

I assume that pthread_mutex and friends have different layouts on 32 and 64
bit and therefore futex_offset is different, right?

But even if you manage to keep track of the offsets per futex, I don't see
how sharing the actual pthread_mutex between a 32bit and a 64bit process
would work at all if the underlying data structures are not fundamentally
the same. The contain more than the robust list.

> Keith Packard has complained about this:
> https://keithp.com/blogs/Shared_Memory_Fences/

That complaint is important because the info there is missing in the
changelog, right? Such links are mostly useless as they are outdated sooner
than later.

Aside of that the blog entry is absolutely not useful to fill the blanks in
your changelog.

> This can also be used to add a new ABI that uses smaller structs, as the
> existing ABI on x86_64 is a minimum of 32 bytes, and 20 bytes would
> suffice.

I have no idea how you make that a minimum of 32 bytes. It's fixed 24 bytes
sized on x86_64.

struct robust_list_head {
	struct robust_list         list;                 /*     0     8 */
	long int                   futex_offset;         /*     8     8 */
	struct robust_list *       list_op_pending;      /*    16     8 */

	/* size: 24, cachelines: 1, members: 3 */
};

>

This lacks a Signed-off-by: ....

> 
> v2: fix size of compat_extended_robust_list_head
>     fix some issues with number literals being implicitly ints

Please move the vN change history after a --- separator so tools can
discard it. It's not part of the changelog. Additionally a link to the
previous submission would be helpful for keeping track.

i.e.

---
v2: Fix ....

v1: https://lore.kernel.org/r/$MESSAGE_ID
---
diffstat
....

> +struct compat_extended_robust_list_head {
> +	struct compat_robust_list_head list_head;
> +	compat_long_t			futex_offset2;

Please align the names of the members properly. list head should be
separated from the type by a tab not by a space.

>  #ifdef CONFIG_FUTEX
> +    /*
> +     * bottom two bits are masked
> +     * 0: struct extended_robust_list_head
> +     * 1: struct robust_list_head
> +     * same for compat_robust_list

What? That's not what the code does. It merily sets bit 0.

> +/*
> + * Extensible per-thread list head:
> + *
> + * As locks are shared between processes, the futex_offset field
> + * has ABI lock-stepping issues, which the original robust_list_head
> + * structure did not anticipate. (And which prevents 32-bit/64-bit
> + * interoperability, as well as shrinking of mutex structures).
> + * This new extensible_robust_list_head allows multiple
> + * concurrent futex_offset values, chosen using the bottom 2 bits of the
> + * robust_list *next pointer, which are now masked in BOTH the old and
> + * new ABI.
> + *
> + * Note: this structure is part of the syscall ABI like
> + * robust_list_head above, and must have a different size than
> + * robust_list_head.

Versioning an ABI by different sizes is an horrible idea.

> + *
> + */
> +struct extended_robust_list_head {
> +	struct robust_list_head list_head;
> +
> +	/*
> +	 * These relative offsets are set by user-space. They give the kernel
> +	 * the relative position of the futex field to examine, based on the
> +	 * bit 1 *next pointer.

What on earth is a 'bit 1 *next pointer'?

> +	 * The original version was insufficiently flexible. Locks are held
> +	 * in shared memory between processes, and a process might want to hold
> +	 * locks of two ABIs at the same time.
> +	 */
> +	long futex_offset2;

Where is *list_op_pending gone and how is that supposed to work? Are you
now enqueueing the next lock into list_head list right away?

Please provide proper design information about this.

> +};
> +
>  /*
>   * Are there any waiters for this robust futex:
>   */
>  #define FUTEX_WAITERS		0x80000000
>  
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 6d50728ef2e7..3a17d2d63178 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3396,17 +3396,20 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
>  SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
>  		size_t, len)
>  {
>  	if (!futex_cmpxchg_enabled)
>  		return -ENOSYS;
> -	/*
> -	 * The kernel knows only one size for now:
> -	 */
> -	if (unlikely(len != sizeof(*head)))
> +
> +	if (unlikely(len != sizeof(struct robust_list_head) &&
> +		     len != sizeof(struct extensible_robust_list_head)))
>  		return -EINVAL;
>  
> -	current->robust_list = head;
> +	current->robust_list = head & 0b11UL;

What? This results in:

	0 <= current->robust_list <=3

How is that supposed to work and why would the 'head' argument ever have
any of those bits set in the first place?

>  void exit_robust_list(struct task_struct *curr)
>  {
> -	struct robust_list_head __user *head = curr->robust_list;
> -	struct robust_list __user *entry, *next_entry, *pending;
> -	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
> -	unsigned int uninitialized_var(next_pi);
> -	unsigned long futex_offset;
> +	struct robust_list_head __user *head_ptr = curr->robust_list & ~1UL;
> +	unsigned int is_extended_list = curr->robust_list & 1 == 0;
> +	struct extended_robust_list_head head;
> +	struct robust_list __user *entry = &head->list_head.list.next,
> +					   *next_entry, *pending;
> +	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip, second_abi,
> +			     second_abip;
> +	unsigned int uninitialized_var(next_pi),
> +		     uninitialized_var(next_second_abi);
>  	int rc;
>  
>  	if (!futex_cmpxchg_enabled)
>  		return;
>  
>  	/*
> -	 * Fetch the list head (which was registered earlier, via
> -	 * sys_set_robust_list()):
> +	 * fetch_robust_entry code is duplicated here to avoid excessive calls
> +	 * to get_user()
>  	 */
> -	if (fetch_robust_entry(&entry, &head->list.next, &pi))
> -		return;
> -	/*
> -	 * Fetch the relative futex offset:
> -	 */
> -	if (get_user(futex_offset, &head->futex_offset))
> -		return;
> -	/*
> -	 * Fetch any possibly pending lock-add first, and handle it
> -	 * if it exists:
> -	 */
> -	if (fetch_robust_entry(&pending, &head->list_op_pending, &pip))
> -		return;
> +	if (is_extended_list) {
> +		if (get_user(head, (struct extended_robust_list_head *)
> +			     head_ptr))
> +			return;
> +	} else {
> +		if (get_user(head.list_head, head_ptr))
> +			return;
> +	}
> +
> +	pi = head.list_head.list.next & 1;
> +	second_abi = head.list_head.list.next & 0b10;

That's truly consistent. For current->robust_list you use bit 0 to
determine whether it is the extended one, but in user space you use bit 1
because bit 0 is already occupied for PI.

> +	head.list_head.list.next &= ~0b11UL;
> +	pip = head.list_head.list_op_pending & 1;
> +	second_abip = head.list_head.list_op_pending & 0b10;
> +	head.list_head.list_op_pending &= ~0b11UL;

So you are seriously trying to mix both ABIs in one robust list? Why on
earth?

One thread can hardly use two different libraries accessing the robust list
with two different versions of the ABI. That's just a recipe for
disaster. Futexes are complicated enough and the robust list is a fragile
beast to begin with.

To be honest. The result of this approach is just unreadable garbage and
this combo patch does too many things in one go to be reviewable at all.

Please provide a proper design and explain how this should work together
with existing robust list using code first.

Thanks,

	tglx
