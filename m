Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04FE6203
	for <lists+linux-api@lfdr.de>; Sun, 27 Oct 2019 11:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJ0KRs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 27 Oct 2019 06:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfJ0KRs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 27 Oct 2019 06:17:48 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F7721928;
        Sun, 27 Oct 2019 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572171466;
        bh=XcDNNr1lSjoZ71C21xXil1q2LAn/91D5/VdEOiQ7efg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qV37bkY1iKAnuX+bg6sJWNN+NvE3xGfkNwF/bowLcNW9GcRk9OHibHBSTH1ZKe+ts
         R/4PV83TYt6LAOtcJPZpn5y8VaKsuUOTHrMDzb9ALwM4zSHLwOJfK/+qqfvAGQPk7j
         568fahlzGtKth+I/pXzTJm1FhHnV2qC97vAbdkpk=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
Date:   Sun, 27 Oct 2019 12:17:32 +0200
Message-Id: <1572171452-7958-2-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572171452-7958-1-git-send-email-rppt@kernel.org>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The mappings created with MAP_EXCLUSIVE are visible only in the context of
the owning process and can be used by applications to store secret
information that will not be visible not only to other processes but to the
kernel as well.

The pages in these mappings are removed from the kernel direct map and
marked with PG_user_exclusive flag. When the exclusive area is unmapped,
the pages are mapped back into the direct map.

The MAP_EXCLUSIVE flag implies MAP_POPULATE and MAP_LOCKED.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/fault.c                    | 14 ++++++++++
 fs/proc/task_mmu.c                     |  1 +
 include/linux/mm.h                     |  9 +++++++
 include/linux/page-flags.h             |  7 +++++
 include/linux/page_excl.h              | 49 ++++++++++++++++++++++++++++++++++
 include/trace/events/mmflags.h         |  9 ++++++-
 include/uapi/asm-generic/mman-common.h |  1 +
 kernel/fork.c                          |  3 ++-
 mm/Kconfig                             |  3 +++
 mm/gup.c                               |  8 ++++++
 mm/memory.c                            |  3 +++
 mm/mmap.c                              | 16 +++++++++++
 mm/page_alloc.c                        |  5 ++++
 13 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/page_excl.h

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9ceacd1..8f73a75 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -17,6 +17,7 @@
 #include <linux/context_tracking.h>	/* exception_enter(), ...	*/
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_recover_from_page_fault()*/
+#include <linux/page_excl.h>		/* page_is_user_exclusive()	*/
 #include <linux/mm_types.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
@@ -1218,6 +1219,13 @@ static int fault_in_kernel_space(unsigned long address)
 	return address >= TASK_SIZE_MAX;
 }
 
+static bool fault_in_user_exclusive_page(unsigned long address)
+{
+	struct page *page = virt_to_page(address);
+
+	return page_is_user_exclusive(page);
+}
+
 /*
  * Called for all faults where 'address' is part of the kernel address
  * space.  Might get called for faults that originate from *code* that
@@ -1261,6 +1269,12 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	if (spurious_kernel_fault(hw_error_code, address))
 		return;
 
+	/* FIXME: warn and handle gracefully */
+	if (unlikely(fault_in_user_exclusive_page(address))) {
+		pr_err("page fault in user exclusive page at %lx", address);
+		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)address);
+	}
+
 	/* kprobes don't want to hook the spurious faults: */
 	if (kprobe_page_fault(regs, X86_TRAP_PF))
 		return;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9442631..99e14d1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -655,6 +655,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_X86_INTEL_MPX
 		[ilog2(VM_MPX)]		= "mp",
 #endif
+		[ilog2(VM_EXCLUSIVE)]	= "xl",
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc29227..9c43375 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -298,11 +298,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -340,6 +342,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MPX		VM_NONE
 #endif
 
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+# define VM_EXCLUSIVE	VM_HIGH_ARCH_5
+#else
+# define VM_EXCLUSIVE	VM_NONE
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
@@ -2594,6 +2602,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_ANON	0x8000	/* don't do file mappings */
 #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
+#define FOLL_EXCLUSIVE	0x40000	/* mapping is exclusive to owning mm */
 
 /*
  * NOTE on FOLL_LONGTERM:
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f91cb88..32d0aee 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -131,6 +131,9 @@ enum pageflags {
 	PG_young,
 	PG_idle,
 #endif
+#if defined(CONFIG_EXCLUSIVE_USER_PAGES)
+	PG_user_exclusive,
+#endif
 	__NR_PAGEFLAGS,
 
 	/* Filesystems */
@@ -431,6 +434,10 @@ TESTCLEARFLAG(Young, young, PF_ANY)
 PAGEFLAG(Idle, idle, PF_ANY)
 #endif
 
+#ifdef CONFIG_EXCLUSIVE_USER_PAGES
+__PAGEFLAG(UserExclusive, user_exclusive, PF_ANY)
+#endif
+
 /*
  * On an anonymous page mapped into a user virtual memory area,
  * page->mapping points to its anon_vma, not to a struct address_space;
diff --git a/include/linux/page_excl.h b/include/linux/page_excl.h
new file mode 100644
index 0000000..b7ea3ce
--- /dev/null
+++ b/include/linux/page_excl.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_EXCLUSIVE_H
+#define _LINUX_MM_PAGE_EXCLUSIVE_H
+
+#include <linux/bitops.h>
+#include <linux/page-flags.h>
+#include <linux/set_memory.h>
+#include <asm/tlbflush.h>
+
+#ifdef CONFIG_EXCLUSIVE_USER_PAGES
+
+static inline bool page_is_user_exclusive(struct page *page)
+{
+	return PageUserExclusive(page);
+}
+
+static inline void __set_page_user_exclusive(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	__SetPageUserExclusive(page);
+	set_direct_map_invalid_noflush(page);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+}
+
+static inline void __clear_page_user_exclusive(struct page *page)
+{
+	__ClearPageUserExclusive(page);
+	set_direct_map_default_noflush(page);
+}
+
+#else /* !CONFIG_EXCLUSIVE_USER_PAGES */
+
+static inline bool page_is_user_exclusive(struct page *page)
+{
+	return false;
+}
+
+static inline void __set_page_user_exclusive(struct page *page)
+{
+}
+
+static inline void __clear_page_user_exclusive(struct page *page)
+{
+}
+
+#endif /* CONFIG_EXCLUSIVE_USER_PAGES */
+
+#endif /* _LINUX_MM_PAGE_EXCLUSIVE_H */
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a1675d4..2d3c14a 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -79,6 +79,12 @@
 #define IF_HAVE_PG_IDLE(flag,string)
 #endif
 
+#ifdef CONFIG_EXCLUSIVE_USER_PAGES
+#define IF_HAVE_PG_USER_EXCLUSIVE(flag,string) ,{1UL << flag, string}
+#else
+#define IF_HAVE_PG_USER_EXCLUSIVE(flag,string)
+#endif
+
 #define __def_pageflag_names						\
 	{1UL << PG_locked,		"locked"	},		\
 	{1UL << PG_waiters,		"waiters"	},		\
@@ -105,7 +111,8 @@ IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
 IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
 IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
-IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
+IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
+IF_HAVE_PG_USER_EXCLUSIVE(PG_user_exclusive,	"user_exclusive" )
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index c160a53..bf8f23e 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -27,6 +27,7 @@
 #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_EXCLUSIVE		0x200000	/* mapping is exclusive to the owning task; the pages in it are dropped from the direct map */
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
diff --git a/kernel/fork.c b/kernel/fork.c
index bcdf531..d63adec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -518,7 +518,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	for (mpnt = oldmm->mmap; mpnt; mpnt = mpnt->vm_next) {
 		struct file *file;
 
-		if (mpnt->vm_flags & VM_DONTCOPY) {
+		if (mpnt->vm_flags & VM_DONTCOPY ||
+		    mpnt->vm_flags & VM_EXCLUSIVE) {
 			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
 			continue;
 		}
diff --git a/mm/Kconfig b/mm/Kconfig
index a5dae9a..9d60141 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -736,4 +736,7 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+config EXCLUSIVE_USER_PAGES
+        def_bool ARCH_USES_HIGH_VMA_FLAGS && ARCH_HAS_SET_DIRECT_MAP
+
 endmenu
diff --git a/mm/gup.c b/mm/gup.c
index 8f236a3..a98c0ca0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -17,6 +17,7 @@
 #include <linux/migrate.h>
 #include <linux/mm_inline.h>
 #include <linux/sched/mm.h>
+#include <linux/page_excl.h>
 
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
@@ -868,6 +869,10 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			ret = PTR_ERR(page);
 			goto out;
 		}
+
+		if (gup_flags & FOLL_EXCLUSIVE)
+			__set_page_user_exclusive(page);
+
 		if (pages) {
 			pages[i] = page;
 			flush_anon_page(vma, page, start);
@@ -1216,6 +1221,9 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	if (vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC))
 		gup_flags |= FOLL_FORCE;
 
+	if (vma->vm_flags & VM_EXCLUSIVE)
+		gup_flags |= FOLL_EXCLUSIVE;
+
 	/*
 	 * We made sure addr is within a VMA, so the following will
 	 * not result in a stack expansion that recurses back here.
diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a..a4b4cff 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -71,6 +71,7 @@
 #include <linux/dax.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/page_excl.h>
 
 #include <asm/io.h>
 #include <asm/mmu_context.h>
@@ -1062,6 +1063,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			page_remove_rmap(page, false);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
+			if (page_is_user_exclusive(page))
+				__clear_page_user_exclusive(page);
 			if (unlikely(__tlb_remove_page(tlb, page))) {
 				force_flush = 1;
 				addr += PAGE_SIZE;
diff --git a/mm/mmap.c b/mm/mmap.c
index a7d8c84..d8cc82d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1574,6 +1574,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
+	if (flags & MAP_EXCLUSIVE)
+		vm_flags |= VM_EXCLUSIVE;
+
 	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
@@ -1591,6 +1594,19 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 
 	addr = untagged_addr(addr);
 
+	if (flags & MAP_EXCLUSIVE) {
+		/*
+		 * MAP_EXCLUSIVE is only supported for private
+		 * anonymous memory not backed by hugetlbfs
+		 */
+		if (!(flags & MAP_ANONYMOUS) || !(flags & MAP_PRIVATE) ||
+		    (flags & MAP_HUGETLB))
+			return -EINVAL;
+
+		/* and impies MAP_LOCKED and MAP_POPULATE */
+		flags |= (MAP_LOCKED | MAP_POPULATE);
+	}
+
 	if (!(flags & MAP_ANONYMOUS)) {
 		audit_mmap_fd(fd, flags);
 		file = fget(fd);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ecc3dba..2f1de9d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -68,6 +68,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/page_excl.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -4779,6 +4780,10 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 		page = NULL;
 	}
 
+	/* FIXME: should not happen! */
+	if (WARN_ON(page_is_user_exclusive(page)))
+		__clear_page_user_exclusive(page);
+
 	trace_mm_page_alloc(page, order, alloc_mask, ac.migratetype);
 
 	return page;
-- 
2.7.4

