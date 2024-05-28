Return-Path: <linux-api+bounces-1631-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F048D1B1B
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 14:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0A1285987
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 12:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0E16D9BF;
	Tue, 28 May 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PW69izLe"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4CC16D9BD;
	Tue, 28 May 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899050; cv=none; b=PBWpWo+bZ2V/VVAqrvoZUHRS8PA8d9G0YNPj11HkAaNN5QRIrwLmbzHFzVK8sFGqhlpJiltZS4Emlr++JqvtGs9tnDva9p7xk4oSNVsdvP/tpfg+8UPNLVirU7SiAAoMfP5qJcbQgfUWX9MmUnxTHy5D61ejgh8u3JgoHDBo7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899050; c=relaxed/simple;
	bh=84wpPzC8m38yhwXEEQO7yTcgx69fJA0uAPMdZeb3mPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlHrhRidVkjceRYQBq2oMp7b2X6PUE2pHaDnq5s/pd2opCKEKOueGzlzxOrpT4rNIJR7tM35E9FVUgLswKPbw+CivEGNjHzU8Vsdihv6xVhZhUi6XoBgu+/g6SuSJA8Sp+6OToz95P8cFTWeev+WcfOBnpgdQjmbiw4GXum/A/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=PW69izLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9361C32786;
	Tue, 28 May 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PW69izLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1716899047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2TusckAmXjFcKfhFnjtVhxg0y8DYmNmR6FzQPjccUY=;
	b=PW69izLe9moMyd6pz2e1e2+uW9nqO3yqWrxBVR2PPcma9ni4pgkKZW0TCyQ2zjiW9m0sjj
	0YCIuo2KF/smRxDeORpX4dnINGaYCxNbbRCivIGeyBnq9dUd/SHR3TFhLJhHAMrt2Oc+9C
	KgW8Eo5nHQSuA/m5FTIctQjHK4ivCTI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c76d505b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 12:24:06 +0000 (UTC)
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
	David Hildenbrand <dhildenb@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always lazily freeable mappings
Date: Tue, 28 May 2024 14:19:50 +0200
Message-ID: <20240528122352.2485958-2-Jason@zx2c4.com>
In-Reply-To: <20240528122352.2485958-1-Jason@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
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

- It shouldn't reserve actual memory, but it also shouldn't crash when
  page faulting in memory if none is available
  * Uh-oh: MAP_NORESERVE respects vm.overcommit_memory=2.
  * Uh-oh: VM_NORESERVE means segfaults.

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
c) If there's not enough memory to service a page fault, it's not fatal.
d) It is inherited by fork.
e) It doesn't count against the mlock budget, since nothing is locked.

This is fairly simple to implement, with the one snag that we have to
use 64-bit VM_* flags, but this shouldn't be a problem, since the only
consumers will probably be 64-bit anyway.

This way, allocations used by vDSO getrandom() can use:

    VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE

And there will be no problem with OOMing, crashing on overcommitment,
using memory when not in use, not wiping on fork(), coredumps, or
writing out to swap.

Cc: linux-mm@kvack.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/proc/task_mmu.c             | 3 +++
 include/linux/mm.h             | 8 ++++++++
 include/trace/events/mmflags.h | 7 +++++++
 mm/Kconfig                     | 3 +++
 mm/memory.c                    | 4 ++++
 mm/mempolicy.c                 | 3 +++
 mm/mprotect.c                  | 2 +-
 mm/rmap.c                      | 8 +++++---
 8 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e5a5f015ff03..b5a59e57bde1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -706,6 +706,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
+#ifdef CONFIG_NEED_VM_DROPPABLE
+		[ilog2(VM_DROPPABLE)]	= "dp",
 #endif
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..5978cb4cc21c 100644
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
diff --git a/mm/memory.c b/mm/memory.c
index b5453b86ec4b..57b03fc73159 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5689,6 +5689,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	lru_gen_exit_fault();
 
+	/* If the mapping is droppable, then errors due to OOM aren't fatal. */
+	if (vma->vm_flags & VM_DROPPABLE)
+		ret &= ~VM_FAULT_OOM;
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index aec756ae5637..a66289f1d931 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2300,6 +2300,9 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct
 	pgoff_t ilx;
 	struct page *page;
 
+	if (vma->vm_flags & VM_DROPPABLE)
+		gfp |= __GFP_NOWARN | __GFP_NORETRY;
+
 	pol = get_vma_policy(vma, addr, order, &ilx);
 	page = alloc_pages_mpol_noprof(gfp | __GFP_COMP, order,
 				       pol, ilx, numa_node_id());
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 94878c39ee32..88ff3ecc08a1 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -622,7 +622,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 				may_expand_vm(mm, oldflags, nrpages))
 			return -ENOMEM;
 		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_HUGETLB|
-						VM_SHARED|VM_NORESERVE))) {
+				  VM_SHARED|VM_NORESERVE|VM_DROPPABLE))) {
 			charged = nrpages;
 			if (security_vm_enough_memory_mm(mm, charged))
 				return -ENOMEM;
diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ecb59b2..d873a3f06506 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1397,7 +1397,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
-	__folio_set_swapbacked(folio);
+	if (!(vma->vm_flags & VM_DROPPABLE))
+		__folio_set_swapbacked(folio);
 	__folio_set_anon(folio, vma, address, true);
 
 	if (likely(!folio_test_large(folio))) {
@@ -1841,7 +1842,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * plus the rmap(s) (dropped by discard:).
 				 */
 				if (ref_count == 1 + map_count &&
-				    !folio_test_dirty(folio)) {
+				    (!folio_test_dirty(folio) || (vma->vm_flags & VM_DROPPABLE))) {
 					dec_mm_counter(mm, MM_ANONPAGES);
 					goto discard;
 				}
@@ -1851,7 +1852,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * discarded. Remap the page to page table.
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				folio_set_swapbacked(folio);
+				if (!(vma->vm_flags & VM_DROPPABLE))
+					folio_set_swapbacked(folio);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
-- 
2.44.0


