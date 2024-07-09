Return-Path: <linux-api+bounces-1904-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF392BA8E
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 15:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C6E1C224B9
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBF161904;
	Tue,  9 Jul 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ERR3F/o6"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B021581E5;
	Tue,  9 Jul 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530349; cv=none; b=Z2Wirc0MX4GLibMuybAi9/njpOKeh0PQ50vuxKQCxW+NugRbFooopqk4Z5ABiWEc9JJawLvBRmO0Aq6+FBlM3n9XIB3BYhKEuuuDBCJfGWeAbimkaCSOywCxGxic0kcmfqoTlXjmxtj7rVRLoll+iwdVXQaskzlWG35WH+mA2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530349; c=relaxed/simple;
	bh=9wdZ5sVt0c4A/D3Yh/yobH8NMbbI7CHMST996cSp6bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsyjF0kPjkdOHzqT2UKOW9AZcDTZ/dczesMKftushhphjr4XnWKQI9Rln6tc4jKOaoqhSUU1AAA3ZgGfewObcDrOtkV/JXDDPCTYqRXXr+YBXNzb1U0eTukV+/ICv+AWKadBQxeb3hygxAxH1p/rToWw/YoiGIujHjaL2rhqQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ERR3F/o6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B34EC4AF16;
	Tue,  9 Jul 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ERR3F/o6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720530342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubjl3tE6+mQntptDlzqV+aY5O8n98Zz2oPpx+dM0WuA=;
	b=ERR3F/o6XUuSSpHV0vnp/yiwaz7nAwUCMR0mosvGnH6GNOu6JFXuQOu9fWmy4BrKwdX0GW
	LfVlln/Eeqvs5pvlKDtNxEajdc0hDnVmOVQnGpGwURAruY8AdEGPKQNRiESr2WYH2r4IjQ
	lyiJsRpNEIz1GaMRW7ObvZPNOtBoSkI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7b0d0d59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jul 2024 13:05:42 +0000 (UTC)
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
Subject: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always lazily freeable mappings
Date: Tue,  9 Jul 2024 15:05:09 +0200
Message-ID: <20240709130513.98102-2-Jason@zx2c4.com>
In-Reply-To: <20240709130513.98102-1-Jason@zx2c4.com>
References: <20240709130513.98102-1-Jason@zx2c4.com>
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
MAP_DROPPABLE.

Finally, the provided self test ensures that this is working as desired.

Cc: linux-mm@kvack.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/proc/task_mmu.c                     |  1 +
 include/linux/mm.h                     |  7 ++++
 include/trace/events/mmflags.h         |  7 ++++
 include/uapi/linux/mman.h              |  1 +
 mm/madvise.c                           |  5 ++-
 mm/mlock.c                             |  2 +-
 mm/mmap.c                              | 30 +++++++++++++++
 mm/rmap.c                              | 22 +++++++++--
 tools/include/uapi/linux/mman.h        |  1 +
 tools/testing/selftests/mm/.gitignore  |  1 +
 tools/testing/selftests/mm/Makefile    |  1 +
 tools/testing/selftests/mm/droppable.c | 53 ++++++++++++++++++++++++++
 12 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/mm/droppable.c

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 71e5039d940d..46f0b0fe9ee3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -708,6 +708,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 #ifdef CONFIG_64BIT
+		[ilog2(VM_DROPPABLE)] = "dp",
 		[ilog2(VM_SEALED)] = "sl",
 #endif
 	};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb7c96d24ac0..e078c2890bf8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -406,6 +406,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_ALLOW_ANY_UNCACHED		VM_NONE
 #endif
 
+#ifdef CONFIG_64BIT
+#define VM_DROPPABLE_BIT	40
+#define VM_DROPPABLE		BIT(VM_DROPPABLE_BIT)
+#else
+#define VM_DROPPABLE		VM_NONE
+#endif
+
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
 #define VM_SEALED	_BITUL(63)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e46d6e82765e..b63d211bd141 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -165,6 +165,12 @@ IF_HAVE_PG_ARCH_X(arch_3)
 # define IF_HAVE_UFFD_MINOR(flag, name)
 #endif
 
+#ifdef CONFIG_64BIT
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
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index a246e11988d5..e89d00528f2f 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -17,6 +17,7 @@
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
 #define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+#define MAP_DROPPABLE	0x08		/* Zero memory under memory pressure. */
 
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
diff --git a/mm/madvise.c b/mm/madvise.c
index a77893462b92..cba5bc652fc4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1068,13 +1068,16 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		new_flags |= VM_WIPEONFORK;
 		break;
 	case MADV_KEEPONFORK:
+		if (vma->vm_flags & VM_DROPPABLE)
+			return -EINVAL;
 		new_flags &= ~VM_WIPEONFORK;
 		break;
 	case MADV_DONTDUMP:
 		new_flags |= VM_DONTDUMP;
 		break;
 	case MADV_DODUMP:
-		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL)
+		if ((!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) ||
+		    (vma->vm_flags & VM_DROPPABLE))
 			return -EINVAL;
 		new_flags &= ~VM_DONTDUMP;
 		break;
diff --git a/mm/mlock.c b/mm/mlock.c
index 30b51cdea89d..b87b3d8cc9cc 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -485,7 +485,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
-	    vma_is_dax(vma) || vma_is_secretmem(vma))
+	    vma_is_dax(vma) || vma_is_secretmem(vma) || (oldflags & VM_DROPPABLE))
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..8aeedeb784c2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1369,6 +1369,36 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			pgoff = 0;
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			break;
+		case MAP_DROPPABLE:
+			if (VM_DROPPABLE == VM_NONE)
+				return -ENOTSUPP;
+			/*
+			 * A locked or stack area makes no sense to be droppable.
+			 *
+			 * Also, since droppable pages can just go away at any time
+			 * it makes no sense to copy them on fork or dump them.
+			 *
+			 * And don't attempt to combine with hugetlb for now.
+			 */
+			if (flags & (MAP_LOCKED | MAP_HUGETLB))
+			        return -EINVAL;
+			if (vm_flags & (VM_GROWSDOWN | VM_GROWSUP))
+			        return -EINVAL;
+
+			vm_flags |= VM_DROPPABLE;
+
+			/*
+			 * If the pages can be dropped, then it doesn't make
+			 * sense to reserve them.
+			 */
+			vm_flags |= VM_NORESERVE;
+
+			/*
+			 * Likewise, they're volatile enough that they
+			 * shouldn't survive forks or coredumps.
+			 */
+			vm_flags |= VM_WIPEONFORK | VM_DONTDUMP;
+			fallthrough;
 		case MAP_PRIVATE:
 			/*
 			 * Set pgoff according to addr for anon_vma.
diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ecb59b2..1f9b5a9cb121 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1397,7 +1397,12 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
-	__folio_set_swapbacked(folio);
+	/*
+	 * VM_DROPPABLE mappings don't swap; instead they're just dropped when
+	 * under memory pressure.
+	 */
+	if (!(vma->vm_flags & VM_DROPPABLE))
+		__folio_set_swapbacked(folio);
 	__folio_set_anon(folio, vma, address, true);
 
 	if (likely(!folio_test_large(folio))) {
@@ -1841,7 +1846,13 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * plus the rmap(s) (dropped by discard:).
 				 */
 				if (ref_count == 1 + map_count &&
-				    !folio_test_dirty(folio)) {
+				    (!folio_test_dirty(folio) ||
+				     /*
+				      * Unlike MADV_FREE mappings, VM_DROPPABLE
+				      * ones can be dropped even if they've
+				      * been dirtied.
+				      */
+				     (vma->vm_flags & VM_DROPPABLE))) {
 					dec_mm_counter(mm, MM_ANONPAGES);
 					goto discard;
 				}
@@ -1851,7 +1862,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * discarded. Remap the page to page table.
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				folio_set_swapbacked(folio);
+				/*
+				 * Unlike MADV_FREE mappings, VM_DROPPABLE ones
+				 * never get swap backed on failure to drop.
+				 */
+				if (!(vma->vm_flags & VM_DROPPABLE))
+					folio_set_swapbacked(folio);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index a246e11988d5..e89d00528f2f 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -17,6 +17,7 @@
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
 #define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+#define MAP_DROPPABLE	0x08		/* Zero memory under memory pressure. */
 
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
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
index 000000000000..f3d9ecf96890
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
+	alloc = mmap(0, alloc_size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
+	assert(alloc != MAP_FAILED);
+	memset(alloc, 'A', alloc_size);
+	for (size_t i = 0; i < alloc_size; i += page_size)
+		assert(*(uint8_t *)(alloc + i));
+
+	child = fork();
+	assert(child >= 0);
+	if (!child) {
+		for (;;)
+			*(char *)malloc(page_size) = 'B';
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
+	ksft_test_result_pass("MAP_DROPPABLE: PASS\n");
+	exit(KSFT_PASS);
+}
-- 
2.45.2


