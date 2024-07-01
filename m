Return-Path: <linux-api+bounces-1813-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6560B91E1A9
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2024 15:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A3F1F2103C
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2024 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F45615FD03;
	Mon,  1 Jul 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PXp71Ugp"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FF15EFB6;
	Mon,  1 Jul 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842305; cv=none; b=ozCad5zanZCsDP9HFEBun3rv42/DRIAlCK8nYZEk/HaYlb1QzJl9dJ2Sl3banNQC9LTiOA+7IRydJDHyypZFPWGQxvBsSB1XgSqyGORfxIMeUBULM2vBp8uDbvEr2umHheMBtwiTF2i/K4zvHIO1Lxo7aPx9/2i033k1ox257PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842305; c=relaxed/simple;
	bh=TPfuYSXl+p5QBRw+BQI54J9G8AeQZl0U/hLxHaSW6RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqWF9wcHlR4jg+yFRjxiCjlLNo1aCX5UoXQA+YX3A/+3aJNIM/RqVERSSUdBjTQkB61KWnXyVz2KoeyAlslYch4pTmZgVrqu0cbMTbvKyhlp+JEeL5bzr18GGLH1dGwjlTSX4B53dgIcEmEgFaxjyCnehIeMZolg5p3QjFCs+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=PXp71Ugp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB2EC4AF0D;
	Mon,  1 Jul 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PXp71Ugp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1719842302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtBkefDwCG5Ua2IrBC22KFVu5x+6eB/qzPWKFjFCZrQ=;
	b=PXp71UgpZuWBaejt41e6x/Orvx0hsqfagr/SempA+8aUEak+aa8MG/CEErXnh9fp1hP9qD
	YCM4XnR2vD2ifmYpbIg1aVYmS1h3KMzjaioPPI7yhacmJgEoAgUw1Lg+6ldlbQeJShgqKd
	+V7dAVoGDms86M5C5GiUsU1m7jgT210=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 583cb2b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jul 2024 13:58:22 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	tglx@linutronix.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: [PATCH v19 2/5] random: add vgetrandom_alloc() syscall
Date: Mon,  1 Jul 2024 15:57:56 +0200
Message-ID: <20240701135801.3698-3-Jason@zx2c4.com>
In-Reply-To: <20240701135801.3698-1-Jason@zx2c4.com>
References: <20240701135801.3698-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vDSO getrandom() works over an opaque per-thread state of an
unexported size, which must be marked VM_WIPEONFORK, VM_DONTDUMP,
VM_NORESERVE, and VM_DROPPABLE for proper operation. Over time, the
nuances of these allocations may change or grow or even differ based on
architectural features.

The syscall uses the extensible struct pattern:

  struct vgetrandom_alloc_args {
      u64 flags;
      u64 num;
      u64 size_per_each;
      u64 bytes_allocated;
  };
  void *vgetrandom_alloc(struct vgetrandom_alloc_args *args, size_t args_len);

This takes a hinted number of opaque states in @num, and returns a
pointer to an array of opaque states, the number of states actually
allocated back in @num, the size in bytes of each one in @size_per_each,
and the size of the total allocation in @bytes_allocated, enabling a
libc to slice up the returned array into a state per each thread, while
ensuring that no single state straddles a page boundary. (The @flags
argument, as well as the @size_per_each and @bytes_allocated input
values, are reserved for the future and are forced to be zero for now.)

Libc is expected to allocate a chunk of these on first use, and then
dole them out to threads as they're created, allocating more when
needed. The returned address of the first state may be passed to
munmap(2) with a length @bytes_allocated in order to deallocate the
memory.

We very intentionally do *not* leave state allocation for vDSO
getrandom() up to userspace itself, but rather provide this new syscall
for such allocations. vDSO getrandom() must not store its state in just
any old memory address, but rather just ones that the kernel specially
allocates for it, leaving the particularities of those allocations up to
the kernel.

The allocation of states is intended to be integrated into libc's thread
management. As an illustrative example, the following code might be used
to do the same outside of libc. Though, vgetrandom_alloc() is not
expected to be exposed outside of libc, and the pthread usage here is
expected to be elided into libc internals. This allocation scheme is
very naive and does not shrink; other implementations may choose to be
more complex.

  static void *vgetrandom_alloc(size_t *num, size_t *size_per_each, size_t *bytes_allocated)
  {
    enum { __NR_vgetrandom_alloc = 463 };
    struct vgetrandom_alloc_args args = { .num = *num };
    void *ret = (void *)syscall(__NR_vgetrandom_alloc, &args, VGETRANDOM_ALLOC_ARGS_SIZE_VER0);
    if (ret != MAP_FAILED) {
      *num = args.num;
      *size_per_each = args.size_per_each;
      *bytes_allocated = args.bytes_allocated;
    }
    return ret;
  }

  static struct {
    pthread_mutex_t lock;
    void **states;
    size_t len, cap, size_per_each;
  } grnd_allocator = {
    .lock = PTHREAD_MUTEX_INITIALIZER
  };

  static void *vgetrandom_get_state(void)
  {
    void *state = NULL;

    pthread_mutex_lock(&grnd_allocator.lock);
    if (!grnd_allocator.len) {
      size_t page_size = getpagesize();
      size_t new_cap;
      size_t bytes_allocated, size_per_each, num = sysconf(_SC_NPROCESSORS_ONLN); /* Just a decent heuristic. */
      void *new_block = vgetrandom_alloc(&num, &size_per_each, &bytes_allocated);
      void *new_states;

      if (new_block == MAP_FAILED)
        goto out;
      if (grnd_allocator.size_per_each && grnd_allocator.size_per_each != size_per_each)
        goto unmap;
      grnd_allocator.size_per_each = size_per_each;
      new_cap = grnd_allocator.cap + num;
      new_states = reallocarray(grnd_allocator.states, new_cap, sizeof(*grnd_allocator.states));
      if (!new_states)
        goto unmap;
      grnd_allocator.cap = new_cap;
      grnd_allocator.states = new_states;

      for (size_t i = 0; i < num; ++i) {
        grnd_allocator.states[i] = new_block;
        if (((uintptr_t)new_block & (page_size - 1)) + size_per_each > page_size)
          new_block = (void *)(((uintptr_t)new_block + page_size) & (page_size - 1));
        else
          new_block += size_per_each;
      }
      grnd_allocator.len = num;
      goto success;

    unmap:
      munmap(new_block, bytes_allocated);
      goto out;
    }
  success:
    state = grnd_allocator.states[--grnd_allocator.len];

  out:
    pthread_mutex_unlock(&grnd_allocator.lock);
    return state;
  }

  static void vgetrandom_put_state(void *state)
  {
    if (!state)
      return;
    pthread_mutex_lock(&grnd_allocator.lock);
    grnd_allocator.states[grnd_allocator.len++] = state;
    pthread_mutex_unlock(&grnd_allocator.lock);
  }

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS                 |   1 +
 drivers/char/random.c       | 127 +++++++++++++++++++++++++++++++++++-
 include/linux/syscalls.h    |   3 +
 include/uapi/linux/random.h |  17 +++++
 include/vdso/getrandom.h    |  16 +++++
 kernel/sys_ni.c             |   3 +
 lib/vdso/Kconfig            |   6 ++
 7 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 include/vdso/getrandom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c4fdf74a3f9..2fbd8f11093c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18747,6 +18747,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 F:	Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	include/vdso/getrandom.h
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2597cb43f438..be95affc0638 100644
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
@@ -8,6 +8,7 @@
  * into roughly six sections, each with a section header:
  *
  *   - Initialization and readiness waiting.
+ *   - vDSO support helpers.
  *   - Fast key erasure RNG, the "crng".
  *   - Entropy accumulation and extraction routines.
  *   - Entropy collection routines.
@@ -39,6 +40,7 @@
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
@@ -56,6 +58,9 @@
 #include <linux/sched/isolation.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
+#ifdef CONFIG_VDSO_GETRANDOM
+#include <vdso/getrandom.h>
+#endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>
 #include <asm/irq.h>
@@ -169,6 +174,126 @@ int __cold execute_with_initialized_rng(struct notifier_block *nb)
 				__func__, (void *)_RET_IP_, crng_init)
 
 
+
+/********************************************************************
+ *
+ * vDSO support helpers.
+ *
+ * The actual vDSO function is defined over in lib/vdso/getrandom.c,
+ * but this section contains the kernel-mode helpers to support that.
+ *
+ ********************************************************************/
+
+#ifdef CONFIG_VDSO_GETRANDOM
+/**
+ * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
+ *
+ * This takes a struct vgetrandom_alloc_args argument and its size, versioning
+ * it, which contains these members:
+ *
+ * @flags:           Reserved flags, must currently always be zero.
+ *
+ * @num:	     On input, a suggested hint of how many states to allocate. On
+ *                   return, the number of states actually allocated.
+ *
+ * @size_per_each:   On input, must currently be zero. On return, the size of each
+ *                   state allocated, so that the caller can split up the returned
+ *                   allocation into individual states.
+ *
+ * @bytes_allocated: On input, must currently be zero. On return, the total number
+ *                   of bytes allocated, which may be passed to munmap(2) for
+ *                   deallocating.
+ *
+ * The getrandom() vDSO function in userspace requires an opaque state, which
+ * this function allocates by mapping a certain number of special pages into
+ * the calling process. It takes a hint as to the number of opaque states
+ * desired, and provides the caller with the number of opaque states actually
+ * allocated, the size of each one in bytes, and the address of the first
+ * state, which may be split up into @num states of @size_per_each bytes each,
+ * by adding @size_per_each to the returned first state @num times, while
+ * ensuring that no single state straddles a page boundary.
+ *
+ * Returns the address of the first state in the allocation on success, or a
+ * negative error value on failure.
+ *
+ * The returned address of the first state may be passed to munmap(2) with a
+ * length of @bytes_allocated, in order to deallocate the memory, after which
+ * it is invalid to pass it to vDSO getrandom().
+ *
+ * States allocated by this function must not be dereferenced, written, read,
+ * or otherwise manipulated. The *only* supported operations are:
+ *   - Splitting up the states in intervals of @size_per_each, no more than
+ *     @num times from the first state, while ensuring that no single state
+ *     straddles a page boundary.
+ *   - Passing a state to the getrandom() vDSO function's @opaque_state
+ *     parameter, but not passing the same state at the same time to two such
+ *     calls.
+ *   - Passing the first state and the total length to munmap(2), as described
+ *     above.
+ * All other uses are undefined behavior, which is subject to change or removal.
+ */
+SYSCALL_DEFINE2(vgetrandom_alloc, struct vgetrandom_alloc_args __user *, uargs,
+		size_t, uargs_size)
+{
+	size_t state_size, alloc_size, num_states;
+	unsigned long pages_addr, populate;
+	struct vgetrandom_alloc_args args;
+	vm_flags_t vm_flags;
+
+	/* Currently only one published version of the struct. */
+	if (uargs_size != sizeof(args))
+		return -EINVAL;
+	if (copy_from_user(&args, uargs, sizeof(args)))
+		return -EFAULT;
+	/* These are currently reserved to be zero on input. */
+	if (args.flags || args.size_per_each || args.bytes_allocated)
+		return -EINVAL;
+
+	state_size = sizeof(struct vgetrandom_state);
+	num_states = clamp_t(size_t, args.num, 1, (SIZE_MAX & PAGE_MASK) / state_size);
+	alloc_size = PAGE_ALIGN(num_states * state_size);
+	/*
+	 * States cannot straddle page boundaries, so calculate the number of
+	 * states that can fit inside of a page without being split, and then
+	 * multiply that out by the number of pages allocated.
+	 */
+	num_states = (PAGE_SIZE / state_size) * (alloc_size / PAGE_SIZE);
+
+	vm_flags =
+		/*
+		 * Don't allow state to be written to swap, to preserve forward secrecy.
+		 * But also don't mlock it or pre-reserve it, and allow it to
+		 * be discarded under memory pressure. If no memory is available, returns
+		 * zeros rather than segfaulting.
+		 */
+		VM_DROPPABLE | VM_NORESERVE |
+
+		/* Don't allow the state to survive forks, to prevent random number re-use. */
+		VM_WIPEONFORK |
+
+		/* Don't write random state into coredumps. */
+		VM_DONTDUMP;
+
+	if (mmap_write_lock_killable(current->mm))
+		return -EINTR;
+	pages_addr = do_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS, vm_flags, 0, &populate, NULL);
+	mmap_write_unlock(current->mm);
+	if (IS_ERR_VALUE(pages_addr))
+		return pages_addr;
+
+	args.num = num_states;
+	args.size_per_each = state_size;
+	args.bytes_allocated = alloc_size;
+	if (copy_to_user(uargs, &args, sizeof(args))) {
+		vm_munmap(pages_addr, alloc_size);
+		return -EFAULT;
+	}
+
+	return pages_addr;
+}
+#endif
+
 /*********************************************************************
  *
  * Fast key erasure RNG, the "crng".
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 63424af87bba..14e47fec5089 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -906,6 +906,9 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 			    void __user *uargs);
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
+asmlinkage long sys_vgetrandom_alloc(unsigned int __user *num,
+				     unsigned int __user *size_per_each,
+				     unsigned long addr, unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
 asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index e744c23582eb..c61b02335e19 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -55,4 +55,21 @@ struct rand_pool_info {
 #define GRND_RANDOM	0x0002
 #define GRND_INSECURE	0x0004
 
+/**
+ * struct vgetrandom_alloc_args - arguments for the vgetrandom_alloc syscall
+ *
+ * The arguments are described in the doc comment of vgetrandom_alloc.
+ *
+ * The structure is versioned by size and thus extensible. New struct members
+ * must go at the end of the struct and must be properly 64-bit aligned.
+ */
+struct vgetrandom_alloc_args {
+	__aligned_u64 flags;
+	__aligned_u64 num;
+	__aligned_u64 size_per_each;
+	__aligned_u64 bytes_allocated;
+};
+
+#define VGETRANDOM_ALLOC_ARGS_SIZE_VER0 32 /* sizeof first published struct */
+
 #endif /* _UAPI_LINUX_RANDOM_H */
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
new file mode 100644
index 000000000000..69037519d20b
--- /dev/null
+++ b/include/vdso/getrandom.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _VDSO_GETRANDOM_H
+#define _VDSO_GETRANDOM_H
+
+/**
+ * struct vgetrandom_state - State used by vDSO getrandom() and allocated by vgetrandom_alloc().
+ *
+ * Currently empty, as the vDSO getrandom() function has not yet been implemented.
+ */
+struct vgetrandom_state { int placeholder; };
+
+#endif /* _VDSO_GETRANDOM_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index b696b85ac63e..4e3728a8a8f4 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -272,6 +272,9 @@ COND_SYSCALL(pkey_free);
 /* memfd_secret */
 COND_SYSCALL(memfd_secret);
 
+/* random */
+COND_SYSCALL(vgetrandom_alloc);
+
 /*
  * Architecture specific weak syscall entries.
  */
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index c46c2300517c..99661b731834 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -38,3 +38,9 @@ config GENERIC_VDSO_OVERFLOW_PROTECT
 	  in the hotpath.
 
 endif
+
+config VDSO_GETRANDOM
+	bool
+	select NEED_VM_DROPPABLE
+	help
+	  Selected by architectures that support vDSO getrandom().
-- 
2.45.2


