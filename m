Return-Path: <linux-api+bounces-1632-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFEA8D1B1F
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 14:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869E1285BE1
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3516E892;
	Tue, 28 May 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LSgXGLb+"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC416E887;
	Tue, 28 May 2024 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899054; cv=none; b=HL2qVH6BwDS5kTtGgJPHTOshjkRBrH77JLLrAIf4SZNdxTXqmza2r7jo4Es/fGFhsj1tjCnZ2wUUoXNSuI+xQCE0qfrt1jROL5PZJQeh6MEAnole8BSdSdaJPL656Pn6si/u50JRZSG3LCOehcaEnvVUAS0WtPDJlur9b1KH8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899054; c=relaxed/simple;
	bh=PI3shgmh8h1E6hjWxCClVD9DmlvkJ/e0TX0lxCdE1L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvxMTHHLVZGEmVVSrAo2kEwQlZpqrAyXVXdoayKg6ox7OpThr+r7mzXqPgUsh7geLeiwJZrHxo28X6rtWN8+mDvVCaC4T0GqDxxWUrzkUxTjuiyMnu2SoUHGZNFoIS54uDOLtb+D07qZOKW+9BQ64u65e7o+7NLIf70RIAJBrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LSgXGLb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B76C32782;
	Tue, 28 May 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LSgXGLb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1716899051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4W6WzA4HYo/mY8kW9y8CD4GZeHFtsh5soZvsbsrPE5s=;
	b=LSgXGLb+htZyxcUaf2irFFJiGpUfWO0m+0AcRMNTMl8c8S/1Xnun3msKhEoubpGTyvd/Jx
	llpdCWAAGbcZppEJzPs92WS3/FWYka6zCklCV+CbbkjueLmtU6zgMDcWIT32a5Df3SJMos
	LZuIfZ2bIQO3NwwiWW3UaTDxXkuSc9U=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3b03570f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 12:24:10 +0000 (UTC)
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
Subject: [PATCH v16 2/5] random: add vgetrandom_alloc() syscall
Date: Tue, 28 May 2024 14:19:51 +0200
Message-ID: <20240528122352.2485958-3-Jason@zx2c4.com>
In-Reply-To: <20240528122352.2485958-1-Jason@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
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

The syscall has the signature:

  void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each,
                         unsigned long addr, unsigned int flags);

This takes a hinted number of opaque states in `num`, and returns a
pointer to an array of opaque states, the number actually allocated back
in `num`, and the size in bytes of each one in `size_per_each`, enabling
a libc to slice up the returned array into a state per each thread,
while ensuring that no single state straddles a page boundary. (The
`flags` and `addr` arguments, as well as the `*size_per_each` input
value, are reserved for the future and are forced to be zero zero for
now.)

Libc is expected to allocate a chunk of these on first use, and then
dole them out to threads as they're created, allocating more when
needed. The returned address of the first state may be passed to
munmap(2) with a length of `num * size_per_each`, in order to deallocate
the memory.

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

  static void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each)
  {
    *size_per_each = 0; /* Must be zero on input. */
    return (void *)syscall(__NR_vgetrandom_alloc, &num, &size_per_each,
                           0 /* reserved @addr */, 0 /* reserved @flags */);
  }

  static struct {
    pthread_mutex_t lock;
    void **states;
    size_t len, cap;
  } grnd_allocator = {
    .lock = PTHREAD_MUTEX_INITIALIZER
  };

  static void *vgetrandom_get_state(void)
  {
    void *state = NULL;

    pthread_mutex_lock(&grnd_allocator.lock);
    if (!grnd_allocator.len) {
      size_t new_cap;
      size_t page_size = getpagesize();
      unsigned int num = sysconf(_SC_NPROCESSORS_ONLN); /* Could be arbitrary, just a hint. */
      unsigned int size_per_each;
      void *new_block = vgetrandom_alloc(&num, &size_per_each);
      void *new_states;

      if (new_block == MAP_FAILED)
        goto out;
      new_cap = grnd_allocator.cap + num;
      new_states = reallocarray(grnd_allocator.states, new_cap, sizeof(*grnd_allocator.states));
      if (!new_states) {
        munmap(new_block, num * size_per_each);
        goto out;
      }
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
    }
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
 MAINTAINERS              |   1 +
 drivers/char/random.c    | 132 +++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h |   3 +
 include/vdso/getrandom.h |  16 +++++
 kernel/sys_ni.c          |   3 +
 lib/vdso/Kconfig         |   6 ++
 6 files changed, 161 insertions(+)
 create mode 100644 include/vdso/getrandom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 82f9fb4c0493..522c88b38550 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18697,6 +18697,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 F:	Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	include/vdso/getrandom.h
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2597cb43f438..b066b8e0bbcb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
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
@@ -169,6 +174,133 @@ int __cold execute_with_initialized_rng(struct notifier_block *nb)
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
+ * @num:	   On input, a pointer to a suggested hint of how many states to
+ * 		   allocate, and on return the number of states actually allocated.
+ *
+ * @size_per_each: On input, must be zero. On return, the size of each state allocated,
+ * 		   so that the caller can split up the returned allocation into
+ * 		   individual states.
+ *
+ * @addr:	   Reserved, must be zero.
+ *
+ * @flags:	   Reserved, must be zero.
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
+ * length of `(size_t)num * (size_t)size_per_each`, in order to deallocate the
+ * memory, after which it is invalid to pass it to vDSO getrandom().
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
+SYSCALL_DEFINE4(vgetrandom_alloc, unsigned int __user *, num,
+		unsigned int __user *, size_per_each, unsigned long, addr,
+		unsigned int, flags)
+{
+	size_t state_size, alloc_size, num_states;
+	unsigned long pages_addr, populate;
+	unsigned int num_hint;
+	vm_flags_t vm_flags;
+	int ret;
+
+	/*
+	 * @flags and @addr are currently unused, so in order to reserve them
+	 * for the future, force them to be set to zero by current callers.
+	 */
+	if (flags || addr)
+		return -EINVAL;
+
+	/*
+	 * Also enforce that *size_per_each is zero on input, in case this becomes
+	 * useful later on.
+	 */
+	if (get_user(num_hint, size_per_each))
+		return -EFAULT;
+	if (num_hint)
+		return -EINVAL;
+
+	if (get_user(num_hint, num))
+		return -EFAULT;
+
+	state_size = sizeof(struct vgetrandom_state);
+	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / state_size);
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
+	ret = -EFAULT;
+	if (put_user(num_states, num) || put_user(state_size, size_per_each))
+		goto err_unmap;
+
+	return pages_addr;
+
+err_unmap:
+	vm_munmap(pages_addr, alloc_size);
+	return ret;
+}
+#endif
+
 /*********************************************************************
  *
  * Fast key erasure RNG, the "crng".
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e619ac10cd23..df3f2016f3b4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -905,6 +905,9 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 			    void __user *uargs);
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
+asmlinkage long sys_vgetrandom_alloc(unsigned int __user *num,
+				     unsigned int __user *size_per_each,
+				     unsigned long addr, unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
 asmlinkage long sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
new file mode 100644
index 000000000000..e3ceb1976386
--- /dev/null
+++ b/include/vdso/getrandom.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
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
index faad00cce269..3e94650d28a5 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -271,6 +271,9 @@ COND_SYSCALL(pkey_free);
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
2.44.0


