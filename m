Return-Path: <linux-api+bounces-1689-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D7900A8B
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 18:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9264FB27812
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5019AD93;
	Fri,  7 Jun 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bR2Zm0at"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D95190060;
	Fri,  7 Jun 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777985; cv=none; b=QH0ObAxCOnP+tORnMT95UWZdvmBWHdn3tXG3Q7E+QAJRkjO4xDQRoq3f4mWEM3AQA3VtShAMKw7X2zF1ocoKAvcdV5l+Qwg7OmZypqQT8BxoooC5kUBgVQ/pdoEWdTJ0a1VHzItwYctm8rOanNIe3z30sAKqq29c7zm2eVqEpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777985; c=relaxed/simple;
	bh=W6g6i9oWpso+MN74XfYv84WGY25V0nmPdLTUYO4UEyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpCCt8l6/nag/grmG0sCsbAPjc4y93Qghnw5SPVkRJ79Zo5ES1vOQjzyR3CHff8BnfGFX8+N68uwtJFSXh1Cr84GlpzCv1gaOVXNKBPuR+7Do6bEpHji/gIYyZKu8D54vu5CuFntn4j5MLTOp3htewKLRFo0Pmoj+rEPxD7RNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bR2Zm0at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EA1C2BBFC;
	Fri,  7 Jun 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bR2Zm0at"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717777982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=398CSylYW3aU5yDlQqUS8n51ZHJoO1PuzaIOtonBJck=;
	b=bR2Zm0atsEJbd8EqXZHzvOaQPsgB5pUD8YS4RetAtvh5ar0R54k21SUcwwNLK8HjkKdrvr
	3TMwokYT16HaQGS13RXsJXIScLAx8q8RxqyNrtH4J2dCVgk8PT3XT7OqJkhugUMhPLnWT+
	FuAf2u+rIyJSIy33nuqZMJUGcLr5TYg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cbbbdb82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 16:33:02 +0000 (UTC)
Date: Fri, 7 Jun 2024 18:32:58 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v16 4/5] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <ZmM2Olwd4hr0teMT@zx2c4.com>
References: <20240528122352.2485958-5-Jason@zx2c4.com>
 <874ja73xx7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874ja73xx7.ffs@tglx>

On Wed, Jun 05, 2024 at 11:03:00PM +0200, Thomas Gleixner wrote:
> Jason!
Thomas!

> Can you please split the required defines into a seperate header
> preferrably in include/vdso/ and include that from crypto/chacha.h

Sure. It only actually uses two straight forward constants from there.
> > +			u32	key[CHACHA_KEY_SIZE / sizeof(u32)];
> 
> CHACHA_STATE_WORDS ?

Nah, that's for CHACHA_BLOCK_SIZE / sizeof(u32), but here is
CHACHA_KEY_SIZE.

> 
> > +		};
> > +		u8		batch_key[CHACHA_BLOCK_SIZE * 2];
> 
> What does the u8 buy here over a simple unsigned int?
> 
> > +	bool 			in_use;

It means that the structure can be more compact, because `pos` and the
`in_use` boolean will be closer together.


> > diff --git a/include/vdso/types.h b/include/vdso/types.h
> > new file mode 100644
> > index 000000000000..ce131463aeff
> > --- /dev/null
> > +++ b/include/vdso/types.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Why does this need an extra header when it's clearly getrandom specific?
> Please put this into getrandom.h

From your followup, I just killed the whole thing and now use u64.

> > +/**
> > + * __cvdso_getrandom_data - Generic vDSO implementation of getrandom() syscall.
> > + * @rng_info:		Describes state of kernel RNG, memory shared with kernel.
> > + * @buffer:		Destination buffer to fill with random bytes.
> > + * @len:		Size of @buffer in bytes.
> > + * @flags:		Zero or more GRND_* flags.
> > + * @opaque_state:	Pointer to an opaque state area.
> > + *
> > + * This implements a "fast key erasure" RNG using ChaCha20, in the same way that the kernel's
> > + * getrandom() syscall does. It periodically reseeds its key from the kernel's RNG, at the same
> > + * schedule that the kernel's RNG is reseeded. If the kernel's RNG is not ready, then this always
> > + * calls into the syscall.
> > + *
> > + * @opaque_state *must* be allocated using the vgetrandom_alloc() syscall.  Unless external locking
> > + * is used, one state must be allocated per thread, as it is not safe to call this function
> > + * concurrently with the same @opaque_state. However, it is safe to call this using the same
> > + * @opaque_state that is shared between main code and signal handling code, within the same thread.
> > + *
> > + * Returns the number of random bytes written to @buffer, or a negative value indicating an error.
> > + */
> > +static __always_inline ssize_t
> > +__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
> > +		       unsigned int flags, void *opaque_state)
> > +{
> > +	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
> 
> We really need to allow reading almost 2GB of random data in one go?

It's just copying the precise semantics as the syscall by bounding the
requested length. The idea is to make this have basically identical
semantics as the syscall (while being way faster).

> > +	/*
> > +	 * @state->in_use is basic reentrancy protection against this running in a signal handler
> > +	 * with the same @opaque_state, but obviously not atomic wrt multiple CPUs or more than one
> > +	 * level of reentrancy. If a signal interrupts this after reading @state->in_use, but before
> > +	 * writing @state->in_use, there is still no race, because the signal handler will run to
> > +	 * its completion before returning execution.
> 
> Can you please add an explanation that the syscall does not touch the
> state and just fills the buffer?

Will do.

> > +	 */
> > +	in_use = READ_ONCE(state->in_use);
> > +	if (unlikely(in_use))
> > +		goto fallback_syscall;
> > +	WRITE_ONCE(state->in_use, true);
> > +
> > +retry_generation:
> > +	/*
> > +	 * @rng_info->generation must always be read here, as it serializes @state->key with the
> > +	 * kernel's RNG reseeding schedule.
> > +	 */
> > +	current_generation = READ_ONCE(rng_info->generation);
> > +
> > +	/*
> > +	 * If @state->generation doesn't match the kernel RNG's generation, then it means the
> > +	 * kernel's RNG has reseeded, and so @state->key is reseeded as well.
> > +	 */
> > +	if (unlikely(state->generation != current_generation)) {
> > +		/*
> > +		 * Write the generation before filling the key, in case of fork. If there is a fork
> > +		 * just after this line, the two forks will get different random bytes from the
> 
> the two forks? You mean the parent and the child, no?

Yes, nice catch, thanks.

> > +		 * syscall, which is good. However, were this line to occur after the getrandom
> > +		 * syscall, then both child and parent could have the same bytes and the same
> > +		 * generation counter, so the fork would not be detected. Therefore, write
> > +		 * @state->generation before the call to the getrandom syscall.
> > +		 */
> > +		WRITE_ONCE(state->generation, current_generation);
> > +
> > +		/* Prevent the syscall from being reordered wrt current_generation. */
> > +		barrier();
> > +
> > +		/* Reseed @state->key using fresh bytes from the kernel. */
> > +		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key)) {
> > +			/*
> > +			 * If the syscall failed to refresh the key, then @state->key is now
> > +			 * invalid, so invalidate the generation so that it is not used again, and
> > +			 * fallback to using the syscall entirely.
> > +			 */
> > +			WRITE_ONCE(state->generation, 0);
> > +
> > +			/*
> > +			 * Set @state->in_use to false only after the last write to @state in the
> > +			 * line above.
> > +			 */
> > +			WRITE_ONCE(state->in_use, false);
> 
> So here you rely on the compiler not reordering vs. WRITE_ONCE(),
> i.e. volatile, but above you have a barrier() to prevent the write being
> reordered vs. the syscall, confused.
> 
> But even when the compiler does not reorder, what prevents a weakly
> ordered CPU from doing so?

The issue isn't that this code will race between CPUs -- that's
explicitly disallowed by the design. The issue is that this code is
signal-reentrant. So it's mostly a matter of compiler ordering the
instructions correctly. Then, in addition, the write of
current_generation to state->generation must come before the syscall
fires.

> > +	if (!len) {
> > +		/* Prevent the loop from being reordered wrt ->generation. */
> > +		barrier();
> 
> Same question as above.

This came out of discussions here:
https://lore.kernel.org/all/878rjlr85s.fsf@oldenburg.str.redhat.com/
And on IRC with Jann.

> > +	/* Refill the batch and then overwrite the key, in order to preserve forward secrecy. */
> 
> 'and then overwrite'?
> 
> Isn't this overwriting it implicitely because batch_key and key are at
> the same place in the union?

Yes, I'll remove the `then`.

Thanks for the review!

Jason

