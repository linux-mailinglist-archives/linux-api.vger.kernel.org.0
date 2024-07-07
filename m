Return-Path: <linux-api+bounces-1857-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A970392961F
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 02:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C51B28409F
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151FB1103;
	Sun,  7 Jul 2024 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="it5GFkvX"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840AA929;
	Sun,  7 Jul 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312037; cv=none; b=Pg3GIDQsqrAWGvPJexdH1WONSZ0YwSt/MgFznHfXtv+BdGMXxospTmQ7jOLp6mIwzz51jYPWfIOuC5Aw4OBtfqm2AjpCRHzFvWSs5CjR5+fn3sT3yVuYEsz35GIujNW3biOzg7mLhnKlok8xOm+E/9b6xjBnztq+pn/17ulruag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312037; c=relaxed/simple;
	bh=BIO+gSeP9FvtUTzwpbZmHxB4VXKEkmIQnsgXYxEFKe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUkJnyYuDqdxj2RvJLzQXrRbYhgVAAUaAgDrM15z0GVcxP+dRGupq8FI/Lhg/8zbF/0B9yOnbkRrW3XGOONjKbmfbH5Xrs+HiylRMXaNTrUOyr2NBwHEB/AcCD4f90HRPgGsMgCPKphzuXwjCsBrwQhYsC6gPrg9QY3BRDQnCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=it5GFkvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4085C4AF0A;
	Sun,  7 Jul 2024 00:27:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="it5GFkvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720312034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9VSBOMxm6lKeUazWjnnGoDhc3mNrTeAlD3qzewaHCY=;
	b=it5GFkvXYxxNtj2qyTkv4iwxMvYdZL6umXom/kvm1VLVIHLIzATo3sdcUUZ4y3lvxh0VBA
	v7siO8BBMTnH5nVUW/IRtP1svJLVOxIpQa2AxzvtKBvodJlJHCp+f9Xs98WCEa83MAl7Jn
	HHqB91U5dOMJRWmMVQK7RizESatSYWg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 50f9af59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 7 Jul 2024 00:27:13 +0000 (UTC)
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
	David Hildenbrand <dhildenb@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always lazily freeable mappings
Date: Sun,  7 Jul 2024 02:26:51 +0200
Message-ID: <20240707002658.1917440-2-Jason@zx2c4.com>
In-Reply-To: <20240707002658.1917440-1-Jason@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vDSO getrandom() implementation works with a buffer allocated with a
new system call that has certain requirements:

- It shouldn't be written to core dumps.
  * Easy: VM_DONTDUMP.
- It should be zeroed on fork.
  * Easy: VM_WIPEONFORK.

- It shouldn't be written to swap.
  * Uh-oh: mlock is rlimited.
  * Uh-oh: mlock isn't inherited by forks.

It turns out that the vDSO getrandom() function has three really nice
characteristics that we can exploit to solve this problem:

1) Due to being wiped during fork(), the vDSO code is already robust to
   having the contents of the pages it reads zeroed out midway through
   the function's execution.

2) In the absolute worst case of whatever contingency we're coding for,
   we have the option to fallback to the getrandom() syscall, and
   everything is fine.

3) The buffers the function uses are only ever useful for a maximum of
   60 seconds -- a sort of cache, rather than a long term allocation.

These characteristics mean that we can introduce VM_DROPPABLE, which
has the following semantics:

a) It never is written out to swap.
b) Under memory pressure, mm can just drop the pages (so that they're
   zero when read back again).
c) It is inherited by fork.
d) It doesn't count against the mlock budget, since nothing is locked.

This is fairly simple to implement, with the one snag that we have to
use 64-bit VM_* flags, but this shouldn't be a problem, since the only
consumers will probably be 64-bit anyway.

This way, allocations used by vDSO getrandom() can use:

    VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE

And there will be no problem with using memory when not in use, not
wiping on fork(), coredumps, or writing out to swap.

In order to let vDSO getrandom() use this, expose these via mmap(2) as
well, giving MAP_WIPEONFORK, MAP_DONTDUMP, and MAP_DROPPABLE.

Finally, the provided self test ensures that this is working as desired.

Cc: linux-mm@kvack.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/alpha/include/uapi/asm/mman.h           |  3 ++
 arch/mips/include/uapi/asm/mman.h            |  3 ++
 arch/parisc/include/uapi/asm/mman.h          |  3 ++
 arch/xtensa/include/uapi/asm/mman.h          |  3 ++
 fs/proc/task_mmu.c                           |  3 ++
 include/linux/mm.h                           |  8 +++
 include/trace/events/mmflags.h               |  7 +++
 include/uapi/asm-generic/mman-common.h       |  4 ++
 mm/Kconfig                                   |  3 ++
 mm/mmap.c                                    | 15 ++++++
 mm/mprotect.c                                |  2 +-
 mm/rmap.c                                    | 16 ++++--
 tools/include/uapi/asm-generic/mman-common.h |  4 ++
 tools/testing/selftests/mm/.gitignore        |  1 +
 tools/testing/selftests/mm/Makefile          |  1 +
 tools/testing/selftests/mm/droppable.c       | 53 ++++++++++++++++++++
 16 files changed, 125 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/mm/droppable.c

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..951c54a45676 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -31,6 +31,9 @@
 #define MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x100000	/* create a huge page mapping */
 #define MAP_FIXED_NOREPLACE	0x200000/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_WIPEONFORK	0x08000000	/* Zero memory in child forks. */
+#define MAP_DONTDUMP	0x10000000	/* Do not write to coredumps. */
+#define MAP_DROPPABLE	0x20000000	/* Zero memory under memory pressure. */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 9c48d9a21aa0..7490a28ec960 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -49,6 +49,9 @@
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
 #define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_WIPEONFORK	0x08000000	/* Zero memory in child forks. */
+#define MAP_DONTDUMP	0x10000000	/* Do not write to coredumps. */
+#define MAP_DROPPABLE	0x20000000	/* Zero memory under memory pressure. */
 
 /*
  * Flags for msync
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..ed03f1d7d06c 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -26,6 +26,9 @@
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
 #define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 #define MAP_UNINITIALIZED 0		/* uninitialized anonymous mmap */
+#define MAP_WIPEONFORK	0x08000000	/* Zero memory in child forks. */
+#define MAP_DONTDUMP	0x10000000	/* Do not write to coredumps. */
+#define MAP_DROPPABLE	0x20000000	/* Zero memory under memory pressure. */
 
 #define MS_SYNC		1		/* synchronous memory sync */
 #define MS_ASYNC	2		/* sync memory asynchronously */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..2e777670b7fa 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -58,6 +58,9 @@
 #define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
+#define MAP_WIPEONFORK	0x08000000	/* Zero memory in child forks. */
+#define MAP_DONTDUMP	0x10000000	/* Do not write to coredumps. */
+#define MAP_DROPPABLE	0x20000000	/* Zero memory under memory pressure. */
 
 /*
  * Flags for msync
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 71e5039d940d..b3bd8432f869 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -709,6 +709,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif
 #ifdef CONFIG_64BIT
 		[ilog2(VM_SEALED)] = "sl",
+#endif
+#ifdef CONFIG_NEED_VM_DROPPABLE
+		[ilog2(VM_DROPPABLE)]	= "dp",
 #endif
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb7c96d24ac0..92454a0272ce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -321,12 +321,14 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
 #define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
+#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -357,6 +359,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 
+#ifdef CONFIG_NEED_VM_DROPPABLE
+# define VM_DROPPABLE		VM_HIGH_ARCH_6
+#else
+# define VM_DROPPABLE		VM_NONE
+#endif
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e46d6e82765e..fab7848df50a 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -165,6 +165,12 @@ IF_HAVE_PG_ARCH_X(arch_3)
 # define IF_HAVE_UFFD_MINOR(flag, name)
 #endif
 
+#ifdef CONFIG_NEED_VM_DROPPABLE
+# define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_DROPPABLE(flag, name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -197,6 +203,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
+IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
 	{VM_MERGEABLE,			"mergeable"	}		\
 
 #define show_vma_flags(flags)						\
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..65a3069462a8 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -33,6 +33,10 @@
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
 
+#define MAP_WIPEONFORK		0x08000000	/* Zero memory in child forks. */
+#define MAP_DONTDUMP		0x10000000	/* Do not write to coredumps. */
+#define MAP_DROPPABLE		0x20000000	/* Zero memory under memory pressure. */
+
 /*
  * Flags for mlock
  */
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..6cd65ea4b3ad 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1056,6 +1056,9 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config NEED_VM_DROPPABLE
+	select ARCH_USES_HIGH_VMA_FLAGS
+	bool
 
 config ARCH_USES_PG_ARCH_X
 	bool
diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..e361f6750201 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1278,6 +1278,21 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
+	if (flags & MAP_WIPEONFORK) {
+		/* MAP_WIPEONFORK is only supported on anonymous memory. */
+		if (file || !(flags & MAP_PRIVATE))
+			return -EINVAL;
+		vm_flags |= VM_WIPEONFORK;
+	}
+	if (flags & MAP_DONTDUMP)
+		vm_flags |= VM_DONTDUMP;
+	if (flags & MAP_DROPPABLE) {
+		/* MAP_DROPPABLE is only supported on anonymous memory. */
+		if (file || !(flags & MAP_PRIVATE))
+			return -EINVAL;
+		vm_flags |= VM_DROPPABLE;
+	}
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8c6cd8825273..57b8dad9adcc 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -623,7 +623,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 				may_expand_vm(mm, oldflags, nrpages))
 			return -ENOMEM;
 		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_HUGETLB|
-						VM_SHARED|VM_NORESERVE))) {
+				  VM_SHARED|VM_NORESERVE|VM_DROPPABLE))) {
 			charged = nrpages;
 			if (security_vm_enough_memory_mm(mm, charged))
 				return -ENOMEM;
diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ecb59b2..56d7535d5cf6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1397,7 +1397,10 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
-	__folio_set_swapbacked(folio);
+	/* VM_DROPPABLE mappings don't swap; instead they're just dropped when
+	 * under memory pressure. */
+	if (!(vma->vm_flags & VM_DROPPABLE))
+		__folio_set_swapbacked(folio);
 	__folio_set_anon(folio, vma, address, true);
 
 	if (likely(!folio_test_large(folio))) {
@@ -1841,7 +1844,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * plus the rmap(s) (dropped by discard:).
 				 */
 				if (ref_count == 1 + map_count &&
-				    !folio_test_dirty(folio)) {
+				    (!folio_test_dirty(folio) ||
+				     /* Unlike MADV_FREE mappings, VM_DROPPABLE
+				      * ones can be dropped even if they've
+				      * been dirtied. */
+				     (vma->vm_flags & VM_DROPPABLE))) {
 					dec_mm_counter(mm, MM_ANONPAGES);
 					goto discard;
 				}
@@ -1851,7 +1858,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * discarded. Remap the page to page table.
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				folio_set_swapbacked(folio);
+				/* Unlike MADV_FREE mappings, VM_DROPPABLE ones
+				 * never get swap backed on failure to drop. */
+				if (!(vma->vm_flags & VM_DROPPABLE))
+					folio_set_swapbacked(folio);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..65a3069462a8 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -33,6 +33,10 @@
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
 
+#define MAP_WIPEONFORK		0x08000000	/* Zero memory in child forks. */
+#define MAP_DONTDUMP		0x10000000	/* Do not write to coredumps. */
+#define MAP_DROPPABLE		0x20000000	/* Zero memory under memory pressure. */
+
 /*
  * Flags for mlock
  */
diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 0b9ab987601c..a8beeb43c2b5 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -49,3 +49,4 @@ hugetlb_fault_after_madv
 hugetlb_madv_vs_map
 mseal_test
 seal_elf
+droppable
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 3b49bc3d0a3b..e3e5740e13e1 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -73,6 +73,7 @@ TEST_GEN_FILES += ksm_functional_tests
 TEST_GEN_FILES += mdwe_test
 TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
+TEST_GEN_FILES += droppable
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/droppable.c b/tools/testing/selftests/mm/droppable.c
new file mode 100644
index 000000000000..846fb9aea4d1
--- /dev/null
+++ b/tools/testing/selftests/mm/droppable.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <assert.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <linux/mman.h>
+
+#include "../kselftest.h"
+
+int main(int argc, char *argv[])
+{
+	size_t alloc_size = 134217728;
+	size_t page_size = getpagesize();
+	void *alloc;
+	pid_t child;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	alloc = mmap(0, alloc_size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_DROPPABLE, -1, 0);
+	assert(alloc != MAP_FAILED);
+	memset(alloc, 'A', alloc_size);
+	for (size_t i = 0; i < alloc_size; i += page_size)
+		assert(*(uint8_t *)(alloc + i));
+
+	child = fork();
+	assert(child >= 0);
+	if (!child) {
+		for (;;)
+			memset(malloc(page_size), 'A', page_size);
+	}
+
+	for (bool done = false; !done;) {
+		for (size_t i = 0; i < alloc_size; i += page_size) {
+			if (!*(uint8_t *)(alloc + i)) {
+				done = true;
+				break;
+			}
+		}
+	}
+	kill(child, SIGTERM);
+
+	ksft_test_result_pass("VM_DROPPABLE: PASS\n");
+	exit(KSFT_PASS);
+}
-- 
2.45.2


