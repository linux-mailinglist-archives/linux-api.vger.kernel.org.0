Return-Path: <linux-api+bounces-1675-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D6A8FD811
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2024 23:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E633B225D2
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2024 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F9713A897;
	Wed,  5 Jun 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNorgy+J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPepGnJX"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB384965B;
	Wed,  5 Jun 2024 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621386; cv=none; b=Zy+F+SpPxeJgoPkh+l53XS7tVjcUxU1NiPy2ppWncASFvN+rmf9Civo3/qm6H2Fbl83gkyetMClVfSa3y70RIOD+REDCP5NXfIMq9cIH9Sx9shz/Lu/bK10fIYJt9rTgHlRWyg040EPDGq6fdMs1vLuJvPDZqiCpLfR4rppgFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621386; c=relaxed/simple;
	bh=vfI+XyntMxmAI6O3/rFI5Y7+85AiQSh7448Su6HkL0I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=mY1wf+00ZIbOU+I6EBxaMS4clzG4ZAxh0HcbsXL/rFcJxONVH9S0NJVRz4NTm8c6L9qXApT+ph9s52bhkV/9rUMkHKtNe3Dk7wSCLtOO3Djtnt+l9ECFagDPPqz87AoyZ6lwRtcZnuLkKkvRNjhaEai9HcUvVwko6TdgDQTZsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNorgy+J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LPepGnJX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717621381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=8DOUd1z26K2knCIWSgj8FMgcXpFTrWvUtY/7BVdEfEw=;
	b=fNorgy+JGm9AENDN8YUp+RbIqtXI8EnmdN5qHvaLEyTlRGW1KBrkhUNJ2HWqoA8jsl9xNk
	3zQmTQ3FuNHwZMhK6R7JVXtchsxmZ1arGW+3eS8v5X+2wmqkoDNVjXJi7ldoUXAnUpf+Ds
	gqmuJZwkE1ZEoXQJDofwze5nbFaKvPocTpGXj/k673g1TTNYl1Nzz+oUY9zRrKPnnS9/H8
	VnjohfoLJI1qFLHevai8WwaAIJj6CGiPZvBaCgHLSRrPHBmeSgF8JYIK88vqo9alzcssF0
	rcRPyjwsAIbCE/rrkdp+64Ltbr1+BOdwyilfefZJcQf8Oe/aC8IUeQU8yfeUWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717621381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=8DOUd1z26K2knCIWSgj8FMgcXpFTrWvUtY/7BVdEfEw=;
	b=LPepGnJXLg7QRH7lIFbHZYS9VUJlzcUZ36zts/3nj/l+4PtPABkc5yZE5owExP9aZvQyZV
	Y8ozeupyt1/ybkAA==
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v16 4/5] random: introduce generic vDSO getrandom()
 implementation
In-Reply-To: <20240528122352.2485958-5-Jason@zx2c4.com>
Date: Wed, 05 Jun 2024 23:03:00 +0200
Message-ID: <874ja73xx7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason!

On Tue, May 28 2024 at 14:19, Jason A. Donenfeld wrote:
> diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
> index e3ceb1976386..7dc93d5f72dc 100644
> --- a/include/vdso/getrandom.h
> +++ b/include/vdso/getrandom.h
> @@ -6,11 +6,39 @@
>  #ifndef _VDSO_GETRANDOM_H
>  #define _VDSO_GETRANDOM_H
>=20=20
> +#include <crypto/chacha.h>

Can you please split the required defines into a seperate header
preferrably in include/vdso/ and include that from crypto/chacha.h

The point is that VDSO is very intentionally not using anything outside
include/uapi/ and include/vdso/ except for include/linux/compiler.h and
include/linux/types.h.

We've had too much trouble of random include chains which magically
break the build dependent on architectures and configurations. VDSO is a us=
erspace
library after all.

> +#include <vdso/types.h>
> +
>  /**
>   * struct vgetrandom_state - State used by vDSO getrandom() and allocate=
d by vgetrandom_alloc().
>   *
> - * Currently empty, as the vDSO getrandom() function has not yet been im=
plemented.
> + * @batch:	One and a half ChaCha20 blocks of buffered RNG output.
> + *
> + * @key:	Key to be used for generating next batch.
> + *
> + * @batch_key:	Union of the prior two members, which is exactly two full
> + * 		ChaCha20 blocks in size, so that @batch and @key can be filled
> + * 		together.
> + *
> + * @generation:	Snapshot of @rng_info->generation in the vDSO data page =
at
> + *		the time @key was generated.
> + *
> + * @pos:	Offset into @batch of the next available random byte.
> + *
> + * @in_use:	Reentrancy guard for reusing a state within the same thread
> + *		due to signal handlers.
>   */
> -struct vgetrandom_state { int placeholder; };
> +struct vgetrandom_state {
> +	union {
> +		struct {
> +			u8	batch[CHACHA_BLOCK_SIZE * 3 / 2];
> +			u32	key[CHACHA_KEY_SIZE / sizeof(u32)];

CHACHA_STATE_WORDS ?

> +		};
> +		u8		batch_key[CHACHA_BLOCK_SIZE * 2];

Lot's of magic constants here *3/2 *2 ....

> +	};
> +	vdso_kernel_ulong	generation;
> +	u8			pos;

What does the u8 buy here over a simple unsigned int?

> +	bool 			in_use;
> +};
>=20=20
>  #endif /* _VDSO_GETRANDOM_H */
> diff --git a/include/vdso/types.h b/include/vdso/types.h
> new file mode 100644
> index 000000000000..ce131463aeff
> --- /dev/null
> +++ b/include/vdso/types.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Why does this need an extra header when it's clearly getrandom specific?
Please put this into getrandom.h

> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights R=
eserved.
> + */
> +#ifndef __VDSO_TYPES_H
> +#define __VDSO_TYPES_H
> +
> +#include <linux/types.h>
> +
> +/**
> + * type vdso_kernel_ulong - unsigned long type that matches kernel's uns=
igned long
> + *
> + * Data shared between userspace and the kernel must operate the same wa=
y in both 64-bit code and in
> + * 32-bit compat code, over the same potentially 64-bit kernel. This typ=
e represents the size of an
> + * unsigned long as used by kernel code. This isn't necessarily the same=
 as an unsigned long as used
> + * by userspace, however.

This is confusing at best.

First of all 64-bit code can run only on a 64-bit kernel, so what does
'the same potentially 64-bit kernel' even mean in that sentence?

What means: 'This type represents the size of an unsigned long as used by k=
ernel
code'?=20

> + *                 +-------------------+-------------------+------------=
------+-------------------+
> + *                 | 32-bit userspace  | 32-bit userspace  | 64-bit user=
space | 64-bit userspace  |
> + *                 | unsigned long     | vdso_kernel_ulong | unsigned lo=
ng    | vdso_kernel_ulong |
> + * +---------------+-------------------+-------------------+------------=
------+-------------------+
> + * | 32-bit kernel | =E2=9C=93 same size       | =E2=9C=93 same size    =
   |
> + * | unsigned long |                   |                   |
> + * +---------------+-------------------+-------------------+------------=
------+-------------------+
> + * | 64-bit kernel | =E2=9C=98 different size! | =E2=9C=93 same size    =
   | =E2=9C=93 same size      | =E2=9C=93 same size       |
> + * | unsigned long |                   |                   |            =
      |                   |
> + * +---------------+-------------------+-------------------+------------=
------+-------------------+

I have no idea what this table tries to tell me, but I clearly can see
what you are trying to achieve here:

> + */
> +#ifdef CONFIG_64BIT
> +typedef u64 vdso_kernel_ulong;
> +#else
> +typedef u32 vdso_kernel_ulong;
> +#endif

All of this is pointless because if a 32-bit application runs on a
64-bit kernel it has to use the 64-bit 'generation'. So why on earth do
we need magic here for a 32-bit kernel?

Just use u64 for both and spare all this voodoo. We're seriously not
"optimizing" for 32-bit kernels.

> +/**
> + * __cvdso_getrandom_data - Generic vDSO implementation of getrandom() s=
yscall.
> + * @rng_info:		Describes state of kernel RNG, memory shared with kernel.
> + * @buffer:		Destination buffer to fill with random bytes.
> + * @len:		Size of @buffer in bytes.
> + * @flags:		Zero or more GRND_* flags.
> + * @opaque_state:	Pointer to an opaque state area.
> + *
> + * This implements a "fast key erasure" RNG using ChaCha20, in the same =
way that the kernel's
> + * getrandom() syscall does. It periodically reseeds its key from the ke=
rnel's RNG, at the same
> + * schedule that the kernel's RNG is reseeded. If the kernel's RNG is no=
t ready, then this always
> + * calls into the syscall.
> + *
> + * @opaque_state *must* be allocated using the vgetrandom_alloc() syscal=
l.  Unless external locking
> + * is used, one state must be allocated per thread, as it is not safe to=
 call this function
> + * concurrently with the same @opaque_state. However, it is safe to call=
 this using the same
> + * @opaque_state that is shared between main code and signal handling co=
de, within the same thread.
> + *
> + * Returns the number of random bytes written to @buffer, or a negative =
value indicating an error.
> + */
> +static __always_inline ssize_t
> +__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffe=
r, size_t len,
> +		       unsigned int flags, void *opaque_state)
> +{
> +	ssize_t ret =3D min_t(size_t, INT_MAX & PAGE_MASK /* =3D MAX_RW_COUNT *=
/, len);

We really need to allow reading almost 2GB of random data in one go?

> +	struct vgetrandom_state *state =3D opaque_state;
> +	size_t batch_len, nblocks, orig_len =3D len;
> +	unsigned long current_generation;
> +	void *orig_buffer =3D buffer;
> +	u32 counter[2] =3D { 0 };
> +	bool in_use, have_retried =3D false;

Please keep the reverse fir tree order.

> +	/* The state must not straddle a page, since pages can be zeroed at any=
 time. */
> +	if (unlikely(((unsigned long)opaque_state & ~PAGE_MASK) + sizeof(*state=
) > PAGE_SIZE))
> +		goto fallback_syscall;
> +
> +	/*
> +	 * If the kernel's RNG is not yet ready, then it's not possible to prov=
ide random bytes from
> +	 * userspace, because A) the various @flags require this to block, or n=
ot, depending on
> +	 * various factors unavailable to userspace, and B) the kernel's behavi=
or before the RNG is
> +	 * ready is to reseed from the entropy pool at every invocation.
> +	 */
> +	if (unlikely(!READ_ONCE(rng_info->is_ready)))
> +		goto fallback_syscall;
> +
> +	/*
> +	 * This condition is checked after @rng_info->is_ready, because before =
the kernel's RNG is
> +	 * initialized, the @flags parameter may require this to block or retur=
n an error, even when
> +	 * len is zero.
> +	 */
> +	if (unlikely(!len))
> +		return 0;
> +
> +	/*
> +	 * @state->in_use is basic reentrancy protection against this running i=
n a signal handler
> +	 * with the same @opaque_state, but obviously not atomic wrt multiple C=
PUs or more than one
> +	 * level of reentrancy. If a signal interrupts this after reading @stat=
e->in_use, but before
> +	 * writing @state->in_use, there is still no race, because the signal h=
andler will run to
> +	 * its completion before returning execution.

Can you please add an explanation that the syscall does not touch the
state and just fills the buffer?

> +	 */
> +	in_use =3D READ_ONCE(state->in_use);
> +	if (unlikely(in_use))
> +		goto fallback_syscall;
> +	WRITE_ONCE(state->in_use, true);
> +
> +retry_generation:
> +	/*
> +	 * @rng_info->generation must always be read here, as it serializes @st=
ate->key with the
> +	 * kernel's RNG reseeding schedule.
> +	 */
> +	current_generation =3D READ_ONCE(rng_info->generation);
> +
> +	/*
> +	 * If @state->generation doesn't match the kernel RNG's generation, the=
n it means the
> +	 * kernel's RNG has reseeded, and so @state->key is reseeded as well.
> +	 */
> +	if (unlikely(state->generation !=3D current_generation)) {
> +		/*
> +		 * Write the generation before filling the key, in case of fork. If th=
ere is a fork
> +		 * just after this line, the two forks will get different random bytes=
 from the

the two forks? You mean the parent and the child, no?

> +		 * syscall, which is good. However, were this line to occur after the =
getrandom
> +		 * syscall, then both child and parent could have the same bytes and t=
he same
> +		 * generation counter, so the fork would not be detected. Therefore, w=
rite
> +		 * @state->generation before the call to the getrandom syscall.
> +		 */
> +		WRITE_ONCE(state->generation, current_generation);
> +
> +		/* Prevent the syscall from being reordered wrt current_generation. */
> +		barrier();
> +
> +		/* Reseed @state->key using fresh bytes from the kernel. */
> +		if (getrandom_syscall(state->key, sizeof(state->key), 0) !=3D sizeof(s=
tate->key)) {
> +			/*
> +			 * If the syscall failed to refresh the key, then @state->key is now
> +			 * invalid, so invalidate the generation so that it is not used again=
, and
> +			 * fallback to using the syscall entirely.
> +			 */
> +			WRITE_ONCE(state->generation, 0);
> +
> +			/*
> +			 * Set @state->in_use to false only after the last write to @state in=
 the
> +			 * line above.
> +			 */
> +			WRITE_ONCE(state->in_use, false);

So here you rely on the compiler not reordering vs. WRITE_ONCE(),
i.e. volatile, but above you have a barrier() to prevent the write being
reordered vs. the syscall, confused.

But even when the compiler does not reorder, what prevents a weakly
ordered CPU from doing so?

> +			goto fallback_syscall;
> +		}
> +
> +		/*
> +		 * Set @state->pos to beyond the end of the batch, so that the batch i=
s refilled
> +		 * using the new key.
> +		 */
> +		state->pos =3D sizeof(state->batch);
> +	}
> +
> +	/* Set len to the total amount of bytes that this function is allowed t=
o read, ret. */
> +	len =3D ret;
> +more_batch:
> +	/*
> +	 * First use bytes out of @state->batch, which may have been filled by =
the last call to this
> +	 * function.
> +	 */
> +	batch_len =3D min_t(size_t, sizeof(state->batch) - state->pos, len);
> +	if (batch_len) {
> +		/* Zeroing at the same time as memcpying helps preserve forward secrec=
y. */
> +		memcpy_and_zero_src(buffer, state->batch + state->pos, batch_len);
> +		state->pos +=3D batch_len;
> +		buffer +=3D batch_len;
> +		len -=3D batch_len;
> +	}
> +
> +	if (!len) {
> +		/* Prevent the loop from being reordered wrt ->generation. */
> +		barrier();

Same question as above.

> +		/*
> +		 * Since @rng_info->generation will never be 0, re-read @state->genera=
tion, rather
> +		 * than using the local current_generation variable, to learn whether =
a fork
> +		 * occurred or if @state was zeroed due to memory pressure. Primarily,=
 though, this
> +		 * indicates whether the kernel's RNG has reseeded, in which case gene=
rate a new key
> +		 * and start over.
> +		 */
> +		if (unlikely(READ_ONCE(state->generation) !=3D READ_ONCE(rng_info->gen=
eration))) {
> +			/*
> +			 * Prevent this from looping forever in case of low memory or racing =
with a
> +			 * user force-reseeding the kernel's RNG using the ioctl.
> +			 */
> +			if (have_retried) {
> +				WRITE_ONCE(state->in_use, false);
> +				goto fallback_syscall;
> +			}
> +
> +			have_retried =3D true;
> +			buffer =3D orig_buffer;
> +			goto retry_generation;
> +		}
> +
> +		/*
> +		 * Set @state->in_use to false only when there will be no more reads o=
r writes of
> +		 * @state.
> +		 */
> +		WRITE_ONCE(state->in_use, false);
> +		return ret;
> +	}
> +
> +	/* Generate blocks of RNG output directly into @buffer while there's en=
ough room left. */
> +	nblocks =3D len / CHACHA_BLOCK_SIZE;
> +	if (nblocks) {
> +		__arch_chacha20_blocks_nostack(buffer, state->key, counter, nblocks);
> +		buffer +=3D nblocks * CHACHA_BLOCK_SIZE;
> +		len -=3D nblocks * CHACHA_BLOCK_SIZE;
> +	}
> +
> +	BUILD_BUG_ON(sizeof(state->batch_key) % CHACHA_BLOCK_SIZE !=3D 0);
> +
> +	/* Refill the batch and then overwrite the key, in order to preserve fo=
rward secrecy. */

'and then overwrite'?

Isn't this overwriting it implicitely because batch_key and key are at
the same place in the union?

> +	__arch_chacha20_blocks_nostack(state->batch_key, state->key, counter,
> +				       sizeof(state->batch_key) / CHACHA_BLOCK_SIZE);
> +
> +	/* Since the batch was just refilled, set the position back to 0 to ind=
icate a full batch. */
> +	state->pos =3D 0;
> +	goto more_batch;

Thanks,

        tglx

