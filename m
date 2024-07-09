Return-Path: <linux-api+bounces-1905-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F9992BA96
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 15:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C31C21D33
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E316DC37;
	Tue,  9 Jul 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hckwwZO0"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421916DC08;
	Tue,  9 Jul 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530358; cv=none; b=WQDEXA3SX9wp168TSt+Z3M9+6e37ZkdzcdcfyNEHbH15Lc+6NxSw53KXzxpQSNBNCbHh4mBYaQYK2mHFcQZqCN+K0H7iMQ7sC8mQkZvc88BT5y4TOM2AJmvGm9AwwzJiPy6NbsKi4Tz3NMf5LwTsujvz2q+4j7ek3q5UK0aXitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530358; c=relaxed/simple;
	bh=PhOruH4jorV4IsiW+1lopcgKRGFH/MEcG4miHi0PylQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=askVP+VaLGokmkWYaInjrsobdi2OTHKplFRXafOHg2prt4TkXhDDRh9JFFEBHtEl34TiCfshdgKbjaRf0dkyPf0z40QvKiy9I10KWRbsHVrLzF8tFu5wMgYqqTf6Vt36tayyEaBzPCuv2jiEaO4/AHYpSpVikgWmnr9b6u673nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hckwwZO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D82C4DDE5;
	Tue,  9 Jul 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hckwwZO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720530350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NDlvd7vphuZkLcBEMboN228fJffKS/FrJObgiKBLEA=;
	b=hckwwZO0d9rFh7hy1ra+z5OzSd77xOq7irk3VWuGmvSNEvJVBPkejqMLCYWLnFF8OmO9HK
	qlRly3s5IrGWQBq7oe40FaC2fbPjGSXCLx1VuHcwawB/BHOjkyWProcUtpwtdSVO/92YF8
	+LuwYrXaP71ta9oIHe3ZHSjL1fJ4TuI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ecc5be7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jul 2024 13:05:50 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	tglx@linutronix.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: [PATCH v22 2/4] random: introduce generic vDSO getrandom() implementation
Date: Tue,  9 Jul 2024 15:05:10 +0200
Message-ID: <20240709130513.98102-3-Jason@zx2c4.com>
In-Reply-To: <20240709130513.98102-1-Jason@zx2c4.com>
References: <20240709130513.98102-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a generic C vDSO getrandom() implementation, which operates on
an opaque state returned by vgetrandom_alloc() and produces random bytes
the same way as getrandom(). This has the following API signature:

  ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags,
                     void *opaque_state, size_t opaque_len);

The return value and the first three arguments are the same as ordinary
getrandom(), while the last two arguments are a pointer to the opaque
allocated state and its size. Were all five arguments passed to the
getrandom() syscall, nothing different would happen, and the functions
would have the exact same behavior.

The actual vDSO RNG algorithm implemented is the same one implemented by
drivers/char/random.c, using the same fast-erasure techniques as that.
Should the in-kernel implementation change, so too will the vDSO one.

It requires an implementation of ChaCha20 that does not use any stack,
in order to maintain forward secrecy if a multi-threaded program forks
(though this does not account for a similar issue with SA_SIGINFO
copying registers to the stack), so this is left as an
architecture-specific fill-in. Stack-less ChaCha20 is an easy algorithm
to implement on a variety of architectures, so this shouldn't be too
onerous.

Initially, the state is keyless, and so the first call makes a
getrandom() syscall to generate that key, and then uses it for
subsequent calls. By keeping track of a generation counter, it knows
when its key is invalidated and it should fetch a new one using the
syscall. Later, more than just a generation counter might be used.

Since MADV_WIPEONFORK is set on the opaque state, the key and related
state is wiped during a fork(), so secrets don't roll over into new
processes, and the same state doesn't accidentally generate the same
random stream. The generation counter, as well, is always >0, so that
the 0 counter is a useful indication of a fork() or otherwise
uninitialized state.

If the kernel RNG is not yet initialized, then the vDSO always calls the
syscall, because that behavior cannot be emulated in userspace, but
fortunately that state is short lived and only during early boot. If it
has been initialized, then there is no need to inspect the `flags`
argument, because the behavior does not change post-initialization
regardless of the `flags` value.

Since the opaque state passed to it is mutated, vDSO getrandom() is not
reentrant, when used with the same opaque state, which libc should be
mindful of.

The function works over an opaque per-thread state of a particular size,
which must be marked VM_WIPEONFORK, VM_DONTDUMP, VM_NORESERVE, and
VM_DROPPABLE for proper operation. Over time, the nuances of these
allocations may change or grow or even differ based on architectural
features.

The opaque state passed to vDSO getrandom() must be allocated using the
mmap_flags and mmap_prot parameters provided by the vgetrandom_opaque_params
struct, which also contains the size of each state. That struct can be
obtained with a call to vgetrandom(NULL, 0, 0, &params, ~0UL). Then,
libc can call mmap(2) and slice up the returned array into a state per
each thread, while ensuring that no single state straddles a page
boundary. Libc is expected to allocate a chunk of these on first use,
and then dole them out to threads as they're created, allocating more
when needed.

vDSO getrandom() provides the ability for userspace to generate random
bytes quickly and safely, and is intended to be integrated into libc's
thread management. As an illustrative example, the introduced code in
the vdso_test_getrandom self test later in this series might be used to
do the same outside of libc. In a libc the various pthread-isms are
expected to be elided into libc internals.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS                 |   2 +
 drivers/char/random.c       |  18 ++-
 include/uapi/linux/random.h |  15 +++
 include/vdso/datapage.h     |  11 ++
 include/vdso/getrandom.h    |  46 +++++++
 lib/vdso/Kconfig            |   5 +
 lib/vdso/getrandom.c        | 251 ++++++++++++++++++++++++++++++++++++
 7 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 include/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c4fdf74a3f9..798158329ad8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18747,6 +18747,8 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 F:	Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	include/vdso/getrandom.h
+F:	lib/vdso/getrandom.c
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2597cb43f438..b02a12436750 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
- * Copyright (C) 2017-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ * Copyright (C) 2017-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  * Copyright Matt Mackall <mpm@selenic.com>, 2003, 2004, 2005
  * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999. All rights reserved.
  *
@@ -56,6 +56,10 @@
 #include <linux/sched/isolation.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
+#ifdef CONFIG_VDSO_GETRANDOM
+#include <vdso/getrandom.h>
+#include <vdso/datapage.h>
+#endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>
 #include <asm/irq.h>
@@ -271,6 +275,15 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
+#ifdef CONFIG_VDSO_GETRANDOM
+	/* base_crng.generation's invalid value is ULONG_MAX, while
+	 * _vdso_rng_data.generation's invalid value is 0, so add one to the
+	 * former to arrive at the latter. Use smp_store_release so that this
+	 * is ordered with the write above to base_crng.generation. Pairs with
+	 * the smp_rmb() before the syscall in the vDSO code.
+	 */
+	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
+#endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -721,6 +734,9 @@ static void __cold _credit_init_bits(size_t bits)
 		if (static_key_initialized && system_unbound_wq)
 			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
+#ifdef CONFIG_VDSO_GETRANDOM
+		WRITE_ONCE(_vdso_rng_data.is_ready, true);
+#endif
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index e744c23582eb..2a3fe4c2cdc9 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -55,4 +55,19 @@ struct rand_pool_info {
 #define GRND_RANDOM	0x0002
 #define GRND_INSECURE	0x0004
 
+/**
+ * struct vgetrandom_opaque_params - arguments for allocating memory for vgetrandom
+ *
+ * @size_per_opaque_state:	Size of each state that is to be passed to vgetrandom().
+ * @mmap_prot:			Value of the prot argument in mmap(2).
+ * @mmap_flags:			Value of the flags argument in mmap(2).
+ * @reserved:			Reserved for future use.
+ */
+struct vgetrandom_opaque_params {
+	__u32 size_of_opaque_state;
+	__u32 mmap_prot;
+	__u32 mmap_flags;
+	__u32 reserved[13];
+};
+
 #endif /* _UAPI_LINUX_RANDOM_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d04d394db064..05e5787beb73 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -113,6 +113,16 @@ struct vdso_data {
 	struct arch_vdso_data	arch_data;
 };
 
+/**
+ * struct vdso_rng_data - vdso RNG state information
+ * @generation:	counter representing the number of RNG reseeds
+ * @is_ready:	boolean signaling whether the RNG is initialized
+ */
+struct vdso_rng_data {
+	u64	generation;
+	u8	is_ready;
+};
+
 /*
  * We use the hidden visibility to prevent the compiler from generating a GOT
  * relocation. Not only is going through a GOT useless (the entry couldn't and
@@ -124,6 +134,7 @@ struct vdso_data {
  */
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")));
 
 /**
  * union vdso_data_store - Generic vDSO data page
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
new file mode 100644
index 000000000000..a8b7c14b0ae0
--- /dev/null
+++ b/include/vdso/getrandom.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _VDSO_GETRANDOM_H
+#define _VDSO_GETRANDOM_H
+
+#include <linux/types.h>
+
+#define CHACHA_KEY_SIZE         32
+#define CHACHA_BLOCK_SIZE       64
+
+/**
+ * struct vgetrandom_state - State used by vDSO getrandom().
+ *
+ * @batch:	One and a half ChaCha20 blocks of buffered RNG output.
+ *
+ * @key:	Key to be used for generating next batch.
+ *
+ * @batch_key:	Union of the prior two members, which is exactly two full
+ * 		ChaCha20 blocks in size, so that @batch and @key can be filled
+ * 		together.
+ *
+ * @generation:	Snapshot of @rng_info->generation in the vDSO data page at
+ *		the time @key was generated.
+ *
+ * @pos:	Offset into @batch of the next available random byte.
+ *
+ * @in_use:	Reentrancy guard for reusing a state within the same thread
+ *		due to signal handlers.
+ */
+struct vgetrandom_state {
+	union {
+		struct {
+			u8	batch[CHACHA_BLOCK_SIZE * 3 / 2];
+			u32	key[CHACHA_KEY_SIZE / sizeof(u32)];
+		};
+		u8		batch_key[CHACHA_BLOCK_SIZE * 2];
+	};
+	u64			generation;
+	u8			pos;
+	bool 			in_use;
+};
+
+#endif /* _VDSO_GETRANDOM_H */
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index c46c2300517c..82fe827af542 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -38,3 +38,8 @@ config GENERIC_VDSO_OVERFLOW_PROTECT
 	  in the hotpath.
 
 endif
+
+config VDSO_GETRANDOM
+	bool
+	help
+	  Selected by architectures that support vDSO getrandom().
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
new file mode 100644
index 000000000000..b230f0b10832
--- /dev/null
+++ b/lib/vdso/getrandom.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <linux/cache.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <vdso/datapage.h>
+#include <vdso/getrandom.h>
+#include <asm/vdso/getrandom.h>
+#include <asm/vdso/vsyscall.h>
+#include <asm/unaligned.h>
+#include <uapi/linux/mman.h>
+
+#define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
+	while (len >= sizeof(type)) {						\
+		__put_unaligned_t(type, __get_unaligned_t(type, src), dst);	\
+		__put_unaligned_t(type, 0, src);				\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}									\
+} while (0)
+
+static void memcpy_and_zero_src(void *dst, void *src, size_t len)
+{
+	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+		if (IS_ENABLED(CONFIG_64BIT))
+			MEMCPY_AND_ZERO_SRC(u64, dst, src, len);
+		MEMCPY_AND_ZERO_SRC(u32, dst, src, len);
+		MEMCPY_AND_ZERO_SRC(u16, dst, src, len);
+	}
+	MEMCPY_AND_ZERO_SRC(u8, dst, src, len);
+}
+
+/**
+ * __cvdso_getrandom_data - Generic vDSO implementation of getrandom() syscall.
+ * @rng_info:		Describes state of kernel RNG, memory shared with kernel.
+ * @buffer:		Destination buffer to fill with random bytes.
+ * @len:		Size of @buffer in bytes.
+ * @flags:		Zero or more GRND_* flags.
+ * @opaque_state:	Pointer to an opaque state area.
+ * @opaque_len:		Length of opaque state area.
+ *
+ * This implements a "fast key erasure" RNG using ChaCha20, in the same way that the kernel's
+ * getrandom() syscall does. It periodically reseeds its key from the kernel's RNG, at the same
+ * schedule that the kernel's RNG is reseeded. If the kernel's RNG is not ready, then this always
+ * calls into the syscall.
+ *
+ * If @buffer, @len, and @flags are 0, and @opaque_len is ~0UL, then @opaque_state is populated
+ * with a struct vgetrandom_opaque_params and the function returns 0; if it does not return 0,
+ * this function should not be used.
+ *
+ * @opaque_state *must* be allocated by calling mmap(2) using the mmap_prot and mmap_flags fields
+ * from the struct vgetrandom_opaque_params, and states must not straddle pages. Unless external
+ * locking is used, one state must be allocated per thread, as it is not safe to call this function
+ * concurrently with the same @opaque_state. However, it is safe to call this using the same
+ * @opaque_state that is shared between main code and signal handling code, within the same thread.
+ *
+ * Returns:	The number of random bytes written to @buffer, or a negative value indicating an error.
+ */
+static __always_inline ssize_t
+__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
+		       unsigned int flags, void *opaque_state, size_t opaque_len)
+{
+	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
+	struct vgetrandom_state *state = opaque_state;
+	size_t batch_len, nblocks, orig_len = len;
+	bool in_use, have_retried = false;
+	unsigned long current_generation;
+	void *orig_buffer = buffer;
+	u32 counter[2] = { 0 };
+
+	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
+		*(struct vgetrandom_opaque_params *)opaque_state = (struct vgetrandom_opaque_params) {
+			.size_of_opaque_state = sizeof(*state),
+			.mmap_prot = PROT_READ | PROT_WRITE,
+			.mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS
+		};
+		return 0;
+	}
+
+	/* The state must not straddle a page, since pages can be zeroed at any time. */
+	if (unlikely(((unsigned long)opaque_state & ~PAGE_MASK) + sizeof(*state) > PAGE_SIZE))
+		return -EFAULT;
+
+	/* If the caller passes the wrong size, which might happen due to CRIU, fallback. */
+	if (unlikely(opaque_len != sizeof(*state)))
+		goto fallback_syscall;
+
+	/*
+	 * If the kernel's RNG is not yet ready, then it's not possible to provide random bytes from
+	 * userspace, because A) the various @flags require this to block, or not, depending on
+	 * various factors unavailable to userspace, and B) the kernel's behavior before the RNG is
+	 * ready is to reseed from the entropy pool at every invocation.
+	 */
+	if (unlikely(!READ_ONCE(rng_info->is_ready)))
+		goto fallback_syscall;
+
+	/*
+	 * This condition is checked after @rng_info->is_ready, because before the kernel's RNG is
+	 * initialized, the @flags parameter may require this to block or return an error, even when
+	 * len is zero.
+	 */
+	if (unlikely(!len))
+		return 0;
+
+	/*
+	 * @state->in_use is basic reentrancy protection against this running in a signal handler
+	 * with the same @opaque_state, but obviously not atomic wrt multiple CPUs or more than one
+	 * level of reentrancy. If a signal interrupts this after reading @state->in_use, but before
+	 * writing @state->in_use, there is still no race, because the signal handler will run to
+	 * its completion before returning execution.
+	 */
+	in_use = READ_ONCE(state->in_use);
+	if (unlikely(in_use))
+		/* The syscall simply fills the buffer and does not touch @state, so fallback. */
+		goto fallback_syscall;
+	WRITE_ONCE(state->in_use, true);
+
+retry_generation:
+	/*
+	 * @rng_info->generation must always be read here, as it serializes @state->key with the
+	 * kernel's RNG reseeding schedule.
+	 */
+	current_generation = READ_ONCE(rng_info->generation);
+
+	/*
+	 * If @state->generation doesn't match the kernel RNG's generation, then it means the
+	 * kernel's RNG has reseeded, and so @state->key is reseeded as well.
+	 */
+	if (unlikely(state->generation != current_generation)) {
+		/*
+		 * Write the generation before filling the key, in case of fork. If there is a fork
+		 * just after this line, the parent and child will get different random bytes from
+		 * the syscall, which is good. However, were this line to occur after the getrandom
+		 * syscall, then both child and parent could have the same bytes and the same
+		 * generation counter, so the fork would not be detected. Therefore, write
+		 * @state->generation before the call to the getrandom syscall.
+		 */
+		WRITE_ONCE(state->generation, current_generation);
+
+		/*
+		 * Prevent the syscall from being reordered wrt current_generation. Pairs with the
+		 * smp_store_release(&_vdso_rng_data.generation) in random.c.
+		 */
+		smp_rmb();
+
+		/* Reseed @state->key using fresh bytes from the kernel. */
+		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key)) {
+			/*
+			 * If the syscall failed to refresh the key, then @state->key is now
+			 * invalid, so invalidate the generation so that it is not used again, and
+			 * fallback to using the syscall entirely.
+			 */
+			WRITE_ONCE(state->generation, 0);
+
+			/*
+			 * Set @state->in_use to false only after the last write to @state in the
+			 * line above.
+			 */
+			WRITE_ONCE(state->in_use, false);
+
+			goto fallback_syscall;
+		}
+
+		/*
+		 * Set @state->pos to beyond the end of the batch, so that the batch is refilled
+		 * using the new key.
+		 */
+		state->pos = sizeof(state->batch);
+	}
+
+	/* Set len to the total amount of bytes that this function is allowed to read, ret. */
+	len = ret;
+more_batch:
+	/*
+	 * First use bytes out of @state->batch, which may have been filled by the last call to this
+	 * function.
+	 */
+	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
+	if (batch_len) {
+		/* Zeroing at the same time as memcpying helps preserve forward secrecy. */
+		memcpy_and_zero_src(buffer, state->batch + state->pos, batch_len);
+		state->pos += batch_len;
+		buffer += batch_len;
+		len -= batch_len;
+	}
+
+	if (!len) {
+		/* Prevent the loop from being reordered wrt ->generation. */
+		barrier();
+
+		/*
+		 * Since @rng_info->generation will never be 0, re-read @state->generation, rather
+		 * than using the local current_generation variable, to learn whether a fork
+		 * occurred or if @state was zeroed due to memory pressure. Primarily, though, this
+		 * indicates whether the kernel's RNG has reseeded, in which case generate a new key
+		 * and start over.
+		 */
+		if (unlikely(READ_ONCE(state->generation) != READ_ONCE(rng_info->generation))) {
+			/*
+			 * Prevent this from looping forever in case of low memory or racing with a
+			 * user force-reseeding the kernel's RNG using the ioctl.
+			 */
+			if (have_retried) {
+				WRITE_ONCE(state->in_use, false);
+				goto fallback_syscall;
+			}
+
+			have_retried = true;
+			buffer = orig_buffer;
+			goto retry_generation;
+		}
+
+		/*
+		 * Set @state->in_use to false only when there will be no more reads or writes of
+		 * @state.
+		 */
+		WRITE_ONCE(state->in_use, false);
+		return ret;
+	}
+
+	/* Generate blocks of RNG output directly into @buffer while there's enough room left. */
+	nblocks = len / CHACHA_BLOCK_SIZE;
+	if (nblocks) {
+		__arch_chacha20_blocks_nostack(buffer, state->key, counter, nblocks);
+		buffer += nblocks * CHACHA_BLOCK_SIZE;
+		len -= nblocks * CHACHA_BLOCK_SIZE;
+	}
+
+	BUILD_BUG_ON(sizeof(state->batch_key) % CHACHA_BLOCK_SIZE != 0);
+
+	/* Refill the batch and overwrite the key, in order to preserve forward secrecy. */
+	__arch_chacha20_blocks_nostack(state->batch_key, state->key, counter,
+				       sizeof(state->batch_key) / CHACHA_BLOCK_SIZE);
+
+	/* Since the batch was just refilled, set the position back to 0 to indicate a full batch. */
+	state->pos = 0;
+	goto more_batch;
+
+fallback_syscall:
+	return getrandom_syscall(orig_buffer, orig_len, flags);
+}
+
+static __always_inline ssize_t
+__cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
+{
+	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flags, opaque_state, opaque_len);
+}
-- 
2.45.2


