Return-Path: <linux-api+bounces-1765-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2114390FB36
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 04:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81525B20A9D
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 02:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D3518026;
	Thu, 20 Jun 2024 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="WG8oGYTT"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4003182AE;
	Thu, 20 Jun 2024 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849635; cv=none; b=TxMf5TfoUvpDqNa3Lt2wtfKSo4vniHePUtO8FItLeHAbbQpVvf0j3vJODjmK9C7LSkIyI0/1/JUoQ+VmrEwTpHItY2pqCLxPLGQUidYm28WMNY+vKqfS8HvDCFJsIRtebGwmZALfIfeHIT28lYT1ol843O9ga+jmRWuYz8e0/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849635; c=relaxed/simple;
	bh=izAGwy0d9LxgWIhGAXgVlTf7rfUwpQZjum8X2aM5WUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avF2YoBwEFUnhI90FdzXAzZQHL+np62H6OADtQmEXhgH3nK/UReay1K5spQrE2wnNsF60M012pkz3hn7OD/9z/lPjvfzzPS5UsjZlDB+6k1v2Cvn9rrZLzSemHO8iUjegeU1KcvGqWv0qXYVaELrjKhOrMsv8bGSzOBprQtXNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=WG8oGYTT; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W4PDQ0RKtz9ssx;
	Thu, 20 Jun 2024 04:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1718849622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XXvyAWGpUnrLwuQ6pAeqVMjSFTiG5J7bldjTumzHZg=;
	b=WG8oGYTTxLhmFliD3BDBAkSvNmJJCb/8RuZ8Gwu+yuLvq5PyNjIkFj8295WU+NrzdtWY2G
	4qXmK9Gwa9WNIQuAwjQP+/BWVg+6zHm6xJdE4am2YcBsVnJNCTTWjDiHUC2Q6aIe7Ha1Xq
	JqdgQSjSRAgwXtMtGV6hwRhee0fvAtJE9S4sJrqI8JsulPREwaO+vHtnkDwgsXtrgKw2rP
	9Bb2i4B91uWvmjpEfY9mHkfiFQRfvTOMSz0ETNd7MmCF8Dz6vBImk+0VgGfL4XE1P9d5hg
	0PJYLQvOj60roQEEw8Hng7KQgz9lqvh6NqmCnafl7hXQ8cpjPseV9smEMSSMOw==
Date: Wed, 19 Jun 2024 19:13:26 -0700
From: Aleksa Sarai <cyphar@cyphar.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v18 2/5] random: add vgetrandom_alloc() syscall
Message-ID: <20240620.020423-puny.wheat.mobile.arm-1wWnJHwWYyAl@cyphar.com>
References: <20240620005339.1273434-1-Jason@zx2c4.com>
 <20240620005339.1273434-3-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2qj3nz6gwvyxnnh"
Content-Disposition: inline
In-Reply-To: <20240620005339.1273434-3-Jason@zx2c4.com>
X-Rspamd-Queue-Id: 4W4PDQ0RKtz9ssx


--t2qj3nz6gwvyxnnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-20, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The vDSO getrandom() works over an opaque per-thread state of an
> unexported size, which must be marked VM_WIPEONFORK, VM_DONTDUMP,
> VM_NORESERVE, and VM_DROPPABLE for proper operation. Over time, the
> nuances of these allocations may change or grow or even differ based on
> architectural features.
>=20
> The syscall has the signature:
>=20
>   void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each,
>                          unsigned long addr, unsigned int flags);
>=20
> This takes a hinted number of opaque states in `num`, and returns a
> pointer to an array of opaque states, the number actually allocated back
> in `num`, and the size in bytes of each one in `size_per_each`, enabling
> a libc to slice up the returned array into a state per each thread,
> while ensuring that no single state straddles a page boundary. (The
> `flags` and `addr` arguments, as well as the `*size_per_each` input
> value, are reserved for the future and are forced to be zero zero for
> now.)

Given how many flags are going to be reserved at the outset, what about
using an extensible struct (copy_struct_from_user) instead? If you're
absolutely sure you'll never need more arguments that's fine, but it
seems entirely possible to me that you might need an extra argument in a
few years.

Since you need to write to *num in the current syscall, I suspect the
following would be nicer as well.

   struct vgetrandom_args {
           u64 num;
   }

   void *vgetrandom_alloc(struct vgetrandom_args *arg, size_t size);

If you'd prefer to have flags from the outset (even though you could
extend them later without issues), then

   struct vgetrandom_args {
           u64 flags;
           u64 num;
   }

would also work.

Then again, I guess since libc is planned to be the primary user,
creating a new syscall in a decade if necessary is probably not that big
of an issue.

> Libc is expected to allocate a chunk of these on first use, and then
> dole them out to threads as they're created, allocating more when
> needed. The returned address of the first state may be passed to
> munmap(2) with a length of `DIV_ROUND_UP(num, PAGE_SIZE / size_per_each)
> * PAGE_SIZE`, in order to deallocate the memory.
>=20
> We very intentionally do *not* leave state allocation for vDSO
> getrandom() up to userspace itself, but rather provide this new syscall
> for such allocations. vDSO getrandom() must not store its state in just
> any old memory address, but rather just ones that the kernel specially
> allocates for it, leaving the particularities of those allocations up to
> the kernel.
>=20
> The allocation of states is intended to be integrated into libc's thread
> management. As an illustrative example, the following code might be used
> to do the same outside of libc. Though, vgetrandom_alloc() is not
> expected to be exposed outside of libc, and the pthread usage here is
> expected to be elided into libc internals. This allocation scheme is
> very naive and does not shrink; other implementations may choose to be
> more complex.
>=20
>   static void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per=
_each)
>   {
>     *size_per_each =3D 0; /* Must be zero on input. */
>     return (void *)syscall(__NR_vgetrandom_alloc, &num, &size_per_each,
>                            0 /* reserved @addr */, 0 /* reserved @flags *=
/);
>   }
>=20
>   static struct {
>     pthread_mutex_t lock;
>     void **states;
>     size_t len, cap, size_per_each;
>   } grnd_allocator =3D {
>     .lock =3D PTHREAD_MUTEX_INITIALIZER
>   };
>=20
>   static void *vgetrandom_get_state(void)
>   {
>     void *state =3D NULL;
>=20
>     pthread_mutex_lock(&grnd_allocator.lock);
>     if (!grnd_allocator.len) {
>       size_t new_cap;
>       size_t page_size =3D getpagesize();
>       unsigned int num =3D sysconf(_SC_NPROCESSORS_ONLN); /* Could be arb=
itrary, just a hint. */
>       unsigned int size_per_each;
>       void *new_block =3D vgetrandom_alloc(&num, &size_per_each);
>       void *new_states;
>=20
>       if (new_block =3D=3D MAP_FAILED)
>         goto out;
>       if (grnd_allocator.size_per_each && grnd_allocator.size_per_each !=
=3D size_per_each)
>         goto unmap;
>       grnd_allocator.size_per_each =3D size_per_each;
>       new_cap =3D grnd_allocator.cap + num;
>       new_states =3D reallocarray(grnd_allocator.states, new_cap, sizeof(=
*grnd_allocator.states));
>       if (!new_states)
>         goto unmap;
>       grnd_allocator.cap =3D new_cap;
>       grnd_allocator.states =3D new_states;
>=20
>       for (size_t i =3D 0; i < num; ++i) {
>         grnd_allocator.states[i] =3D new_block;
>         if (((uintptr_t)new_block & (page_size - 1)) + size_per_each > pa=
ge_size)
>           new_block =3D (void *)(((uintptr_t)new_block + page_size) & (pa=
ge_size - 1));
>         else
>           new_block +=3D size_per_each;
>       }
>       grnd_allocator.len =3D num;
>       goto success;
>=20
>     unmap:
>       munmap(new_block, DIV_ROUND_UP(num, page_size / size_per_each) * pa=
ge_size);
>       goto out;
>     }
>   success:
>     state =3D grnd_allocator.states[--grnd_allocator.len];
>=20
>   out:
>     pthread_mutex_unlock(&grnd_allocator.lock);
>     return state;
>   }
>=20
>   static void vgetrandom_put_state(void *state)
>   {
>     if (!state)
>       return;
>     pthread_mutex_lock(&grnd_allocator.lock);
>     grnd_allocator.states[grnd_allocator.len++] =3D state;
>     pthread_mutex_unlock(&grnd_allocator.lock);
>   }
>=20
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/char/random.c    | 135 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/syscalls.h |   3 +
>  include/vdso/getrandom.h |  16 +++++
>  kernel/sys_ni.c          |   3 +
>  lib/vdso/Kconfig         |   6 ++
>  6 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 include/vdso/getrandom.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8aa17e515ef3..8480c4c39915 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18747,6 +18747,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kerne=
l/git/crng/random.git
>  F:	Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
>  F:	drivers/char/random.c
>  F:	drivers/virt/vmgenid.c
> +F:	include/vdso/getrandom.h
> =20
>  RAPIDIO SUBSYSTEM
>  M:	Matt Porter <mporter@kernel.crashing.org>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 2597cb43f438..ccb35f390c85 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  /*
> - * Copyright (C) 2017-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rig=
hts Reserved.
> + * Copyright (C) 2017-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rig=
hts Reserved.
>   * Copyright Matt Mackall <mpm@selenic.com>, 2003, 2004, 2005
>   * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999. All righ=
ts reserved.
>   *
> @@ -8,6 +8,7 @@
>   * into roughly six sections, each with a section header:
>   *
>   *   - Initialization and readiness waiting.
> + *   - vDSO support helpers.
>   *   - Fast key erasure RNG, the "crng".
>   *   - Entropy accumulation and extraction routines.
>   *   - Entropy collection routines.
> @@ -39,6 +40,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/interrupt.h>
>  #include <linux/mm.h>
> +#include <linux/mman.h>
>  #include <linux/nodemask.h>
>  #include <linux/spinlock.h>
>  #include <linux/kthread.h>
> @@ -56,6 +58,9 @@
>  #include <linux/sched/isolation.h>
>  #include <crypto/chacha.h>
>  #include <crypto/blake2s.h>
> +#ifdef CONFIG_VDSO_GETRANDOM
> +#include <vdso/getrandom.h>
> +#endif
>  #include <asm/archrandom.h>
>  #include <asm/processor.h>
>  #include <asm/irq.h>
> @@ -169,6 +174,134 @@ int __cold execute_with_initialized_rng(struct noti=
fier_block *nb)
>  				__func__, (void *)_RET_IP_, crng_init)
> =20
> =20
> +
> +/********************************************************************
> + *
> + * vDSO support helpers.
> + *
> + * The actual vDSO function is defined over in lib/vdso/getrandom.c,
> + * but this section contains the kernel-mode helpers to support that.
> + *
> + ********************************************************************/
> +
> +#ifdef CONFIG_VDSO_GETRANDOM
> +/**
> + * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getra=
ndom().
> + *
> + * @num:	   On input, a pointer to a suggested hint of how many states to
> + * 		   allocate, and on return the number of states actually allocated.
> + *
> + * @size_per_each: On input, must be zero. On return, the size of each s=
tate allocated,
> + * 		   so that the caller can split up the returned allocation into
> + * 		   individual states.
> + *
> + * @addr:	   Reserved, must be zero.
> + *
> + * @flags:	   Reserved, must be zero.
> + *
> + * The getrandom() vDSO function in userspace requires an opaque state, =
which
> + * this function allocates by mapping a certain number of special pages =
into
> + * the calling process. It takes a hint as to the number of opaque states
> + * desired, and provides the caller with the number of opaque states act=
ually
> + * allocated, the size of each one in bytes, and the address of the first
> + * state, which may be split up into @num states of @size_per_each bytes=
 each,
> + * by adding @size_per_each to the returned first state @num times, while
> + * ensuring that no single state straddles a page boundary.
> + *
> + * Returns the address of the first state in the allocation on success, =
or a
> + * negative error value on failure.
> + *
> + * The returned address of the first state may be passed to munmap(2) wi=
th a
> + * length of `DIV_ROUND_UP(num, PAGE_SIZE / size_per_each) * PAGE_SIZE`,=
 in
> + * order to deallocate the memory, after which it is invalid to pass it =
to vDSO
> + * getrandom().
> + *
> + * States allocated by this function must not be dereferenced, written, =
read,
> + * or otherwise manipulated. The *only* supported operations are:
> + *   - Splitting up the states in intervals of @size_per_each, no more t=
han
> + *     @num times from the first state, while ensuring that no single st=
ate
> + *     straddles a page boundary.
> + *   - Passing a state to the getrandom() vDSO function's @opaque_state
> + *     parameter, but not passing the same state at the same time to two=
 such
> + *     calls.
> + *   - Passing the first state and the total length to munmap(2), as des=
cribed
> + *     above.
> + * All other uses are undefined behavior, which is subject to change or =
removal.
> + */
> +SYSCALL_DEFINE4(vgetrandom_alloc, unsigned int __user *, num,
> +		unsigned int __user *, size_per_each, unsigned long, addr,
> +		unsigned int, flags)
> +{
> +	size_t state_size, alloc_size, num_states;
> +	unsigned long pages_addr, populate;
> +	unsigned int num_hint;
> +	vm_flags_t vm_flags;
> +	int ret;
> +
> +	/*
> +	 * @flags and @addr are currently unused, so in order to reserve them
> +	 * for the future, force them to be set to zero by current callers.
> +	 */
> +	if (flags || addr)
> +		return -EINVAL;
> +
> +	/*
> +	 * Also enforce that *size_per_each is zero on input, in case this beco=
mes
> +	 * useful later on.
> +	 */
> +	if (get_user(num_hint, size_per_each))
> +		return -EFAULT;
> +	if (num_hint)
> +		return -EINVAL;
> +
> +	if (get_user(num_hint, num))
> +		return -EFAULT;
> +
> +	state_size =3D sizeof(struct vgetrandom_state);
> +	num_states =3D clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / st=
ate_size);
> +	alloc_size =3D PAGE_ALIGN(num_states * state_size);
> +	/*
> +	 * States cannot straddle page boundaries, so calculate the number of
> +	 * states that can fit inside of a page without being split, and then
> +	 * multiply that out by the number of pages allocated.
> +	 */
> +	num_states =3D (PAGE_SIZE / state_size) * (alloc_size / PAGE_SIZE);
> +
> +	vm_flags =3D
> +		/*
> +		 * Don't allow state to be written to swap, to preserve forward secrec=
y.
> +		 * But also don't mlock it or pre-reserve it, and allow it to
> +		 * be discarded under memory pressure. If no memory is available, retu=
rns
> +		 * zeros rather than segfaulting.
> +		 */
> +		VM_DROPPABLE | VM_NORESERVE |
> +
> +		/* Don't allow the state to survive forks, to prevent random number re=
-use. */
> +		VM_WIPEONFORK |
> +
> +		/* Don't write random state into coredumps. */
> +		VM_DONTDUMP;
> +
> +	if (mmap_write_lock_killable(current->mm))
> +		return -EINTR;
> +	pages_addr =3D do_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
> +			     MAP_PRIVATE | MAP_ANONYMOUS, vm_flags, 0, &populate, NULL);
> +	mmap_write_unlock(current->mm);
> +	if (IS_ERR_VALUE(pages_addr))
> +		return pages_addr;
> +
> +	ret =3D -EFAULT;
> +	if (put_user(num_states, num) || put_user(state_size, size_per_each))
> +		goto err_unmap;
> +
> +	return pages_addr;
> +
> +err_unmap:
> +	vm_munmap(pages_addr, alloc_size);
> +	return ret;
> +}
> +#endif
> +
>  /*********************************************************************
>   *
>   * Fast key erasure RNG, the "crng".
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 9104952d323d..56368ea4f510 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -906,6 +906,9 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned=
 int flags,
>  			    void __user *uargs);
>  asmlinkage long sys_getrandom(char __user *buf, size_t count,
>  			      unsigned int flags);
> +asmlinkage long sys_vgetrandom_alloc(unsigned int __user *num,
> +				     unsigned int __user *size_per_each,
> +				     unsigned long addr, unsigned int flags);
>  asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned =
int flags);
>  asmlinkage long sys_bpf(int cmd, union bpf_attr *attr, unsigned int size=
);
>  asmlinkage long sys_execveat(int dfd, const char __user *filename,
> diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
> new file mode 100644
> index 000000000000..69037519d20b
> --- /dev/null
> +++ b/include/vdso/getrandom.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rig=
hts Reserved.
> + */
> +
> +#ifndef _VDSO_GETRANDOM_H
> +#define _VDSO_GETRANDOM_H
> +
> +/**
> + * struct vgetrandom_state - State used by vDSO getrandom() and allocate=
d by vgetrandom_alloc().
> + *
> + * Currently empty, as the vDSO getrandom() function has not yet been im=
plemented.
> + */
> +struct vgetrandom_state { int placeholder; };
> +
> +#endif /* _VDSO_GETRANDOM_H */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index d7eee421d4bc..6b17fadb0f59 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -272,6 +272,9 @@ COND_SYSCALL(pkey_free);
>  /* memfd_secret */
>  COND_SYSCALL(memfd_secret);
> =20
> +/* random */
> +COND_SYSCALL(vgetrandom_alloc);
> +
>  /*
>   * Architecture specific weak syscall entries.
>   */
> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index c46c2300517c..99661b731834 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -38,3 +38,9 @@ config GENERIC_VDSO_OVERFLOW_PROTECT
>  	  in the hotpath.
> =20
>  endif
> +
> +config VDSO_GETRANDOM
> +	bool
> +	select NEED_VM_DROPPABLE
> +	help
> +	  Selected by architectures that support vDSO getrandom().
> --=20
> 2.45.2
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--t2qj3nz6gwvyxnnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZnOQMAAKCRAol/rSt+lE
byI7AQCFb9qBJajDVjn/01fhbN92Pb0EGChewlDVS3f4kkIIBQD/cMT4NeJA2BS+
SXCzv2/BknAWsi1addQkXbDPnioeBwU=
=cjUI
-----END PGP SIGNATURE-----

--t2qj3nz6gwvyxnnh--

