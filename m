Return-Path: <linux-api+bounces-1760-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE290FA78
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 02:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729241C21596
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 00:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F063FC2;
	Thu, 20 Jun 2024 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wy1GiSRp"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B0101C8;
	Thu, 20 Jun 2024 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844838; cv=none; b=eXuxIh/pli1X6OgiaOfy28HaHRhInJ48AKb0J4viqym4svn627foS8BnUS20WbkR4+HmSFrCLD1wJkeApiw0jXt/OrD6OU0uxyGPVkrjVpFLuWEU9ClkxvWqhhKiYuyMJkrawP1+/SpsZMikqmz9vnx1K0dyDnhK7548e07xz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844838; c=relaxed/simple;
	bh=aqohGs3aIrPLO3G/JEY5ulSWtojjAg6DDIkDitbXrnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk+gTvWQjt26oiHfSuQ0D4bs5jl0tfSVIyvA3L+sSDEm7hr9adRlKDnMYwnJcQz9aKiVPDDSkqFuPB6YCovxfOnGcUV9JyVqvaOY2VHTUboO/ZyNjTv4/mA2akhrOqgwmypfCXpvfm15oTMCzee1J1LuH8LWbvsaB5IpggPxYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Wy1GiSRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE43C4AF07;
	Thu, 20 Jun 2024 00:53:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wy1GiSRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718844836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIMpXESIZrvLDlNkbefExpVi2+GH2WoPeJxzWPkZD3s=;
	b=Wy1GiSRpjhNsHn9qVAbJoz3aTmgx+UwkCBCrXvetGSx0fpRQggPQJeiKHmKHETFO+pAPSy
	z0tr/DVKQCuWhqUgE9gKabZy9rhUMCnaJNxaCOK5tinl4kycBw/hJRHI19NsFDExBjqUaF
	MmaFuD/ddGMWswF63lXcs2l49f+hjPo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a4359615 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Jun 2024 00:53:55 +0000 (UTC)
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
Subject: [PATCH v18 1/5] mm: add VM_DROPPABLE for designating always lazily freeable mappings
Date: Thu, 20 Jun 2024 02:53:33 +0200
Message-ID: <20240620005339.1273434-2-Jason@zx2c4.com>
In-Reply-To: <20240620005339.1273434-1-Jason@zx2c4.com>
References: <20240620005339.1273434-1-Jason@zx2c4.com>
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

Cc: linux-mm@kvack.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/proc/task_mmu.c             | 3 +++
 include/linux/mm.h             | 8 ++++++++
 include/trace/events/mmflags.h | 7 +++++++
 mm/Kconfig                     | 3 +++
 mm/mprotect.c                  | 2 +-
 mm/rmap.c                      | 8 +++++---
 6 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f8d35f993fe5..1883d6462ca8 100644
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
2.45.2


