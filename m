Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2594C3CC0C6
	for <lists+linux-api@lfdr.de>; Sat, 17 Jul 2021 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhGQDBD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 23:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhGQDBC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 23:01:02 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA98C06175F
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 19:58:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y3-20020ae9f4030000b02903b916ae903fso979298qkl.6
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 19:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dU+ZZukSXSr4M828fVeC5vwq/z89wtN2G6i/plizSoQ=;
        b=jHTY4FVOxPAr7OPPcE8deUuqTFHp0H4JhRjJBBN555P2eMOOD3Ub/twiv0JpB8fJWQ
         ruTdEKdZ7N7UIeDTW9fqmy5VlXstlFEisJBHhS5jw11amA51ZUKqpNSkn053vK2+R/5Q
         VrByFKL896ZFA4EziZRbipsEbQoKo7ik15GwT0Fhj778UoBG1OGf+4wWn1pOf1yvXb0t
         Tt/ilGc00ch68yClqdr7Vvtx38OL2lVN5+vWQij/hKo3ByJ1BZ3JYrIR3r7u+v4Luz8e
         6fa7QLcCGbVn44TvtSUMbicH/rkjlGyrSkw1vK6VOobNci7Io9ReFy+MG5kO+daK1+M6
         VCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dU+ZZukSXSr4M828fVeC5vwq/z89wtN2G6i/plizSoQ=;
        b=Lp+6hp6gq/ObxVeGergciy39mYBynl1D3eJlOwMgLcU66wUfITMjmTBClifsLpSSap
         l47JoLrD/4tLOFSeAOvuvHwm0ZVLQT332QuRqruhPd10nwLwObPtdOcHZOstWxDEwLtH
         1gfo39RoGGwJkyKinmXF3ebnVhyczOathb8sGFtbkaLxXs4DkzNmglrNDljNNDHsPTeC
         ESzCsu0Whp3I5L7Sz4KOzpgYYyMnVrLWjHmIYLTkLc7vxOCrihuaufQv6knSuGWck2jg
         0MZd9lV+aEkL0sP5xMoIUEftN1vQ4FIm79xV8SOyg2iP/dswEzOpjw3BnRdS8qVp5Cvv
         IVzQ==
X-Gm-Message-State: AOAM530jIzb9pw2T8b/ov50JPMskR+F0lvr6wBw85bGShjsj5TwH2txO
        DTPo/wkvi1qsWMjpbowl+Inz1/0=
X-Google-Smtp-Source: ABdhPJxYn0dSgzEQKqBdYBVl14q82VUS79gnnd19IPD/1VEGdw9T5AJWcIm1EocYHt9XAlp1WB2ZJqQ=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:fc3c:d89a:88e2:5cfc])
 (user=pcc job=sendgmr) by 2002:a05:6214:cac:: with SMTP id
 s12mr13481304qvs.29.1626490685852; Fri, 16 Jul 2021 19:58:05 -0700 (PDT)
Date:   Fri, 16 Jul 2021 19:57:57 -0700
Message-Id: <20210717025757.3945742-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v5] mm: introduce reference pages
From:   Peter Collingbourne <pcc@google.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Peter Collingbourne <pcc@google.com>, Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Introduce a new syscall, refpage_create, which returns a file
descriptor which may be mapped using mmap. Such a mapping is similar
to an anonymous mapping, but instead of clean pages being backed by the
zero page, they are instead backed by a so-called reference page, whose
contents are specified using an argument to refpage_create. Loads from
the mapping will load directly from the reference page, and initial
stores to the mapping will copy-on-write from the reference page.

Reference pages are useful in circumstances where anonymous mappings
combined with manual stores to memory would impose undesirable costs,
either in terms of performance or RSS. Use cases are focused on heap
allocators and include:

- Pattern initialization for the heap. This is where malloc(3) gives
  you memory whose contents are filled with a non-zero pattern
  byte, in order to help detect and mitigate bugs involving use
  of uninitialized memory. Typically this is implemented by having
  the allocator memset the allocation with the pattern byte before
  returning it to the user, but for large allocations this can result
  in a significant increase in RSS, especially for allocations that
  are used sparsely. Even for dense allocations there is a needless
  impact to startup performance when it may be better to amortize it
  throughout the program. By creating allocations using a reference
  page filled with the pattern byte, we can avoid these costs.

- Pre-tagged heap memory. Memory tagging [1] is an upcoming ARMv8.5
  feature which allows for memory to be tagged in order to detect
  certain kinds of memory errors with low overhead. In order to set
  up an allocation to allow memory errors to be detected, the entire
  allocation needs to have the same tag. The issue here is similar to
  pattern initialization in the sense that large tagged allocations
  will be expensive if the tagging is done up front. The idea is that
  the allocator would create reference pages with each of the possible
  memory tags, and use those reference pages for the large allocations.

This patch includes specific optimizations for these use cases in
order to reduce memory traffic. If the reference page consists of a
single repeating byte, the page is initialized using memset, and on
arm64 if the reference page consists of a uniformly tagged zero page,
the DC GZVA instruction is used to initialize the page.

In order to measure the performance and RSS impact of reference pages,
I used the following microbenchmark program, which is intended to
compare an implementation of heap pattern initialization that uses
memset to initialize the pages against an implementation that uses
reference pages:

  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mman.h>
  #include <unistd.h>

  constexpr unsigned char pattern_byte = 0xaa;

  #define PAGE_SIZE 4096

  _Alignas(PAGE_SIZE) static unsigned char pattern[PAGE_SIZE];

  int main(int argc, char **argv) {
    if (argc < 3)
      return 1;
    bool use_refpage = argc > 3;
    size_t mmap_size = atoi(argv[1]);
    size_t touch_size = atoi(argv[2]);

    int refpage_fd;
    if (use_refpage) {
      memset(pattern, pattern_byte, PAGE_SIZE);
      refpage_fd = syscall(447, pattern, 0);
    }
    for (unsigned i = 0; i != 1000; ++i) {
      char *p;
      if (use_refpage) {
        p = (char *)mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE,
                         refpage_fd, 0);
      } else {
        p = (char *)mmap(0, mmap_size, PROT_READ | PROT_WRITE,
                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        memset(p, pattern_byte, mmap_size);
      }
      for (unsigned j = 0; j < touch_size; j += PAGE_SIZE)
        p[j] = 0;
      munmap(p, mmap_size);
    }
  }

On a DragonBoard 845c with the powersave governor, and taking the
median of 10 runs for each measurement, I measured the following
results for real time (s):

touch_size/mmap_size   memset   refpages     improvement (95% CI)
      4096/4096000    3.962194   0.026726   98.8015% +/- 1.14684%
   2048000/4096000    3.925309   1.48081    61.8271% +/- 1.11911%
   4096000/4096000    3.986275   3.385003   15.1205% +/- 0.227235%

And the following for max RSS (KiB):

touch_size/mmap_size   memset   refpages     improvement (95% CI)
      4096/4096000      6656      3448      49.3815% +/- 1.30339%
   2048000/4096000      6696      4580      31.7053% +/- 1.16411%
   4096000/4096000      6716      6684              none

So we see a large improvement for sparsely used allocations, and even
a modest perf improvement for fully utilized allocations as a result
of touching the pages one fewer time (with memset: once in the kernel
and once in userspace; with refpages: just once in the kernel).

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If84b146620631938bbebd77085c2e79362ff0c56
Link: [1] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
---
v5:
- rebased to 5.15rc2
- changed the API to take a size argument, including the prep hook
- made tag_clear_highpage a helper function
- renamed optzn -> content_type, optzn_info -> content_info
- outlined part of the is_refpage_vma check
- removed is_zero_or_refpage_pfn
- added a comment at the top of refpage.c
- restructured syscall handler to use goto
- inlined put_refpage_private_data into remaining caller

v4:
- rebased to linux-next
- added arch hooks to support MTE tagged reference pages
- added optimizations for pages with pattern byte as well as uniformly MTE-tagged pages
- added helper functions to avoid open-coding the reference page detection
- wrote a microbenchmark program and got new perf results for the commit message

As an alternative to introducing this syscall, I considered using
userfaultfd to implement reference pages. However, after having taken
a detailed look at the interface, it does not seem suitable to be
used in the context of a general purpose allocator. For example,
UFFD_FEATURE_FORK support would be required in order to correctly
support fork(2) in a process that uses the allocator (although POSIX
does not guarantee support for allocating after fork, many allocators
including Scudo support it, and nothing stops the forked process from
page faulting pre-existing allocations after forking anyway), but
UFFD_FEATURE_FORK has been restricted to root by commit 3c1c24d91ffd
("userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK"),
making it unsuitable for use in an allocator. Furthermore, even if
the interface issues are resolved, I suspect (but have not measured)
that the cost of the multiple context switches between kernel and
userspace would be too high to be used in an allocator anyway.

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/mman.h               |  16 +++
 arch/arm64/include/asm/mte.h                |  10 +-
 arch/arm64/include/asm/page.h               |   4 +-
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/arm64/kernel/mte.c                     |  24 ++++
 arch/arm64/lib/mte.S                        |  26 +++-
 arch/arm64/mm/fault.c                       |  48 ++++++-
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 include/linux/gfp.h                         |  11 +-
 include/linux/highmem.h                     |   9 +-
 include/linux/huge_mm.h                     |   7 +
 include/linux/mm.h                          |  32 +++++
 include/linux/mman.h                        |  19 +++
 include/linux/syscalls.h                    |   3 +
 include/uapi/asm-generic/unistd.h           |   5 +-
 kernel/sys_ni.c                             |   1 +
 mm/Makefile                                 |   4 +-
 mm/gup.c                                    |   3 +-
 mm/memory.c                                 |  47 ++++--
 mm/migrate.c                                |   4 +-
 mm/refpage.c                                | 151 ++++++++++++++++++++
 37 files changed, 413 insertions(+), 31 deletions(-)
 create mode 100644 mm/refpage.c

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index a17687ed4b51..494edc5ca61c 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -486,3 +486,4 @@
 554	common	landlock_create_ruleset		sys_landlock_create_ruleset
 555	common	landlock_add_rule		sys_landlock_add_rule
 556	common	landlock_restrict_self		sys_landlock_restrict_self
+558	common	refpage_create			sys_refpage_create
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index c5df1179fc5d..8fd7045f46b9 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -460,3 +460,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index e3e28f7daf62..018e3c8913ea 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -84,4 +84,20 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
 }
 #define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
 
+struct refpage_private_data;
+
+void arch_prep_refpage_private_data(struct refpage_private_data *priv,
+				    char *content_kaddr, unsigned long size);
+#define arch_prep_refpage_private_data arch_prep_refpage_private_data
+
+static inline void arch_prep_refpage_vma(struct vm_area_struct *vma)
+{
+	vma->vm_flags |= VM_MTE_ALLOWED;
+}
+#define arch_prep_refpage_vma arch_prep_refpage_vma
+
+void arch_copy_refpage(struct page *page, unsigned long addr,
+				     struct vm_area_struct *vma);
+#define arch_copy_refpage arch_copy_refpage
+
 #endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 58c7f80f5596..e37bcb0e285e 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -31,13 +31,14 @@ void mte_invalidate_tags(int type, pgoff_t offset);
 void mte_invalidate_tags_area(int type);
 void *mte_allocate_tag_storage(void);
 void mte_free_tag_storage(char *storage);
+void mte_memcpy(char *to, char *from, unsigned long size);
 
 #ifdef CONFIG_ARM64_MTE
 
 /* track which pages have valid allocation tags */
 #define PG_mte_tagged	PG_arch_2
 
-void mte_zero_clear_page_tags(void *addr);
+void mte_zero_set_page_tags(void *addr);
 void mte_sync_tags(pte_t old_pte, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void mte_thread_init_user(void);
@@ -48,13 +49,14 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg);
 long get_mte_ctrl(struct task_struct *task);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
 			 unsigned long addr, unsigned long data);
+u8 mte_check_tag_zero_page(struct page *userpage);
 
 #else /* CONFIG_ARM64_MTE */
 
 /* unused if !CONFIG_ARM64_MTE, silence the compiler */
 #define PG_mte_tagged	0
 
-static inline void mte_zero_clear_page_tags(void *addr)
+static inline void mte_zero_set_page_tags(void *addr)
 {
 }
 static inline void mte_sync_tags(pte_t old_pte, pte_t pte)
@@ -89,6 +91,10 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
 {
 	return -EIO;
 }
+static inline u8 mte_check_tag_zero_page(struct page *userpage)
+{
+	return 0;
+}
 
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 993a27ea6f54..80e74d9ecaf0 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -33,8 +33,8 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 						unsigned long vaddr);
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE_MOVABLE
 
-void tag_clear_highpage(struct page *to);
-#define __HAVE_ARCH_TAG_CLEAR_HIGHPAGE
+void tag_set_highpage(struct page *to, unsigned long tag);
+#define __HAVE_ARCH_TAG_SET_HIGHPAGE
 
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 727bfc3be99b..3cb206aea3db 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		447
+#define __NR_compat_syscalls		449
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 99ffcafc736c..2a116aa17fe7 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -901,6 +901,8 @@ __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
 __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 #define __NR_landlock_restrict_self 446
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
+#define __NR_refpage_create 448
+__SYSCALL(__NR_refpage_create, sys_refpage_create)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 36f51b0e438a..876997703d7b 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -450,3 +450,27 @@ int mte_ptrace_copy_tags(struct task_struct *child, long request,
 
 	return ret;
 }
+
+u8 mte_check_tag_zero_page(struct page *userpage)
+{
+	char *userpage_addr = page_address(userpage);
+	u8 tag;
+	int i;
+
+	if (!test_bit(PG_mte_tagged, &userpage->flags))
+		return 0;
+
+	tag = mte_get_mem_tag(userpage_addr) & 0xF;
+	if (tag == 0)
+		return 0;
+
+	for (i = 0; i != PAGE_SIZE; ++i)
+		if (userpage_addr[i] != 0)
+			return 0;
+
+	for (i = MTE_GRANULE_SIZE; i != PAGE_SIZE; i += MTE_GRANULE_SIZE)
+		if ((mte_get_mem_tag(userpage_addr + i) & 0xF) != tag)
+			return 0;
+
+	return tag;
+}
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index e83643b3995f..47de7f3c0baf 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -37,24 +37,23 @@ SYM_FUNC_START(mte_clear_page_tags)
 SYM_FUNC_END(mte_clear_page_tags)
 
 /*
- * Zero the page and tags at the same time
+ * Zero the page and set tags at the same time
  *
  * Parameters:
  *	x0 - address to the beginning of the page
  */
-SYM_FUNC_START(mte_zero_clear_page_tags)
+SYM_FUNC_START(mte_zero_set_page_tags)
 	mrs	x1, dczid_el0
 	and	w1, w1, #0xf
 	mov	x2, #4
 	lsl	x1, x2, x1
-	and	x0, x0, #(1 << MTE_TAG_SHIFT) - 1	// clear the tag
 
 1:	dc	gzva, x0
 	add	x0, x0, x1
 	tst	x0, #(PAGE_SIZE - 1)
 	b.ne	1b
 	ret
-SYM_FUNC_END(mte_zero_clear_page_tags)
+SYM_FUNC_END(mte_zero_set_page_tags)
 
 /*
  * Copy the tags from the source page to the destination one
@@ -169,3 +168,22 @@ SYM_FUNC_START(mte_restore_page_tags)
 
 	ret
 SYM_FUNC_END(mte_restore_page_tags)
+
+/*
+ * Copies memory and tags
+ *   x0 - destination address
+ *   x1 - source address
+ *   x2 - size
+ * Preconditions: size != 0, all arguments must be aligned to 16.
+ */
+SYM_FUNC_START(mte_memcpy)
+1:
+	ldg	x3, [x1]
+	stg	x3, [x0]
+	ldp	x3, x4, [x1], #16
+	stp	x3, x4, [x0], #16
+	sub	x2, x2, #16
+	cbnz	x2, 1b
+
+	ret
+SYM_FUNC_END(mte_memcpy)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 349c488765ca..73fe728787f0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -25,6 +25,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/mman.h>
 
 #include <asm/acpi.h>
 #include <asm/bug.h>
@@ -939,9 +940,52 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 	return alloc_page_vma(flags, vma, vaddr);
 }
 
-void tag_clear_highpage(struct page *page)
+void tag_set_highpage(struct page *page, unsigned long tag)
 {
-	mte_zero_clear_page_tags(page_address(page));
+	unsigned long addr = (unsigned long)page_address(page);
+
+	addr &= ~MTE_TAG_MASK;
+	addr |= tag << MTE_TAG_SHIFT;
+	mte_zero_set_page_tags((void *)addr);
 	page_kasan_tag_reset(page);
 	set_bit(PG_mte_tagged, &page->flags);
 }
+
+void arch_prep_refpage_private_data(struct refpage_private_data *priv,
+				    char *content_kaddr, unsigned long size)
+{
+	if (system_supports_mte()) {
+		u64 *content_kaddr_u64 = (u64 *)content_kaddr;
+
+		if (size == MTE_GRANULE_SIZE && content_kaddr_u64[0] == 0 &&
+		    content_kaddr_u64[1] == 0) {
+			priv->content_type = REFPAGE_CONTENT_TYPE_MTE_TAGGED;
+			priv->content_info = mte_get_mem_tag(content_kaddr);
+		}
+
+		set_bit(PG_mte_tagged, &priv->refpage->flags);
+		if (size >= MTE_GRANULE_SIZE) {
+			char *refpage_kaddr = page_address(priv->refpage);
+			unsigned long i;
+
+			for (i = 0; i != PAGE_SIZE; i += size)
+				mte_memcpy(refpage_kaddr + i, content_kaddr,
+					   size);
+			return;
+		}
+		mte_clear_page_tags(page_address(priv->refpage));
+	}
+
+	prep_refpage_private_data(priv, content_kaddr, size);
+}
+
+void arch_copy_refpage(struct page *page, unsigned long addr,
+		       struct vm_area_struct *vma)
+{
+	struct refpage_private_data *priv = vma->vm_private_data;
+
+	if (priv->content_type == REFPAGE_CONTENT_TYPE_MTE_TAGGED)
+		tag_set_highpage(page, priv->content_info);
+	else
+		copy_refpage(page, addr, vma);
+}
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 6d07742c57b8..c2209d83f3c3 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -367,3 +367,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 541bc1b3a8f9..0360cf474a49 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -446,3 +446,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a176faca2927..de85d758e564 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index c2d2e19abea8..b07c7293d2a3 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -385,3 +385,4 @@
 444	n32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n32	landlock_add_rule		sys_landlock_add_rule
 446	n32	landlock_restrict_self		sys_landlock_restrict_self
+448	n32	refpage_create			sys_refpage_create
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index ac653d08b1ea..7ebabb99dd06 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -361,3 +361,4 @@
 444	n64	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n64	landlock_add_rule		sys_landlock_add_rule
 446	n64	landlock_restrict_self		sys_landlock_restrict_self
+448	n64	refpage_create			sys_refpage_create
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 253f2cd70b6b..a51149ac101c 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -434,3 +434,4 @@
 444	o32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	o32	landlock_add_rule		sys_landlock_add_rule
 446	o32	landlock_restrict_self		sys_landlock_restrict_self
+448	o32	refpage_create			sys_refpage_create
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e26187b9ab87..385565864861 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index aef2a290e71a..95cdd9f7dc06 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -526,3 +526,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 64d51ab5a8b4..92ed1260ffd9 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -449,3 +449,4 @@
 444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
 445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
+448  common	refpage_create		sys_refpage_create		sys_refpage_create
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index e0a70be77d84..f9d198cc2541 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -449,3 +449,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 603f5a821502..83533aa49340 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -492,3 +492,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ce763a12311c..054c69e395b5 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -452,3 +452,4 @@
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
+448	i386	refpage_create		sys_refpage_create
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f6b57799c1ea..1f24f0b66cbd 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -369,6 +369,7 @@
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
+448	common	refpage_create		sys_refpage_create
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 235d67d6ceb4..96c27fb404ca 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -417,3 +417,4 @@
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+448	common	refpage_create			sys_refpage_create
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 55b2ec1f965a..ae3c763eb9e9 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,8 +55,9 @@ struct vm_area_struct;
 #define ___GFP_ACCOUNT		0x400000u
 #define ___GFP_ZEROTAGS		0x800000u
 #define ___GFP_SKIP_KASAN_POISON	0x1000000u
+#define ___GFP_NOZERO		0x2000000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x2000000u
+#define ___GFP_NOLOCKDEP	0x4000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -238,18 +239,24 @@ struct vm_area_struct;
  * %__GFP_SKIP_KASAN_POISON returns a page which does not need to be poisoned
  * on deallocation. Typically used for userspace pages. Currently only has an
  * effect in HW tags mode.
+ *
+ * %__GFP_NOZERO disables any implicit zeroing of the page (e.g. as a result
+ * of init_on_alloc=on). This flag should only be used to address specific
+ * performance bottlenecks and only if the page is clearly being fully
+ * initialized following the allocation.
  */
 #define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
 #define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
 #define __GFP_SKIP_KASAN_POISON	((__force gfp_t)___GFP_SKIP_KASAN_POISON)
+#define __GFP_NOZERO	((__force gfp_t)___GFP_NOZERO)
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 8c6e8e996c87..038c235fd146 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -185,14 +185,19 @@ static inline void clear_highpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-#ifndef __HAVE_ARCH_TAG_CLEAR_HIGHPAGE
+#ifndef __HAVE_ARCH_TAG_SET_HIGHPAGE
 
-static inline void tag_clear_highpage(struct page *page)
+static inline void tag_set_highpage(struct page *page, unsigned long tag)
 {
 }
 
 #endif
 
+static inline void tag_clear_highpage(struct page *page)
+{
+	tag_set_highpage(page, 0);
+}
+
 /*
  * If we pass in a base or tail page, we can zero up to PAGE_SIZE.
  * If we pass in a head page, we can zero up to the size of the compound page.
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f123e15d966e..36ecfc391b46 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -127,6 +127,13 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 
 	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
 		return false;
+
+	/*
+	 * Transparent hugepages not currently supported for anonymous VMAs with
+	 * reference pages
+	 */
+	if (unlikely(is_refpage_vma(vma)))
+		return false;
 	return true;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..4a49ed7099cd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -722,6 +722,36 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
 #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
 
+struct refpage_private_data {
+	struct page *refpage;
+	u8 content_type;
+	u8 content_info;
+};
+
+#define REFPAGE_CONTENT_TYPE_USER_SET	0
+#define REFPAGE_CONTENT_TYPE_PATTERN	1
+#define REFPAGE_CONTENT_TYPE_MTE_TAGGED	2
+
+bool is_refpage_file(struct file *file);
+
+static inline bool is_refpage_vma(struct vm_area_struct *vma)
+{
+	return vma->vm_file && is_refpage_file(vma->vm_file);
+}
+
+static inline struct page *get_vma_refpage(struct vm_area_struct *vma)
+{
+	struct refpage_private_data *priv = vma->vm_private_data;
+
+	BUG_ON(!is_refpage_vma(vma));
+	return priv->refpage;
+}
+
+static inline int is_refpage_pfn(struct vm_area_struct *vma, unsigned long pfn)
+{
+	return is_refpage_vma(vma) && pfn == page_to_pfn(get_vma_refpage(vma));
+}
+
 struct mmu_gather;
 struct inode;
 
@@ -2977,6 +3007,8 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
+	if (flags & __GFP_NOZERO)
+		return false;
 	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
 				&init_on_alloc))
 		return true;
diff --git a/include/linux/mman.h b/include/linux/mman.h
index ebb09a964272..03a4678d93c6 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -123,6 +123,25 @@ static inline bool arch_validate_flags(unsigned long flags)
 #define arch_validate_flags arch_validate_flags
 #endif
 
+void prep_refpage_private_data(struct refpage_private_data *priv,
+			       char *content_kaddr, unsigned long size);
+#ifndef arch_prep_refpage_private_data
+#define arch_prep_refpage_private_data prep_refpage_private_data
+#endif
+
+#ifndef arch_prep_refpage_vma
+static inline void arch_prep_refpage_vma(struct vm_area_struct *vma)
+{
+}
+#define arch_prep_refpage_vma arch_prep_refpage_vma
+#endif
+
+void copy_refpage(struct page *page, unsigned long addr,
+		  struct vm_area_struct *vma);
+#ifndef arch_copy_refpage
+#define arch_copy_refpage copy_refpage
+#endif
+
 /*
  * Optimisation macro.  It is equivalent to:
  *      (x & bit1) ? bit2 : 0
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 69c9a7010081..303a28a86500 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -864,6 +864,9 @@ asmlinkage long sys_mremap(unsigned long addr,
 			   unsigned long old_len, unsigned long new_len,
 			   unsigned long flags, unsigned long new_addr);
 
+/* mm/refpage.c */
+asmlinkage long sys_refpage_create(const void __user *content, unsigned long flags);
+
 /* security/keys/keyctl.c */
 asmlinkage long sys_add_key(const char __user *_type,
 			    const char __user *_description,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a9d6fcd95f42..54cede7db5f0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -878,8 +878,11 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
 
+#define __NR_refpage_create 448
+__SYSCALL(__NR_refpage_create, sys_refpage_create)
+
 #undef __NR_syscalls
-#define __NR_syscalls 448
+#define __NR_syscalls 449
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 30971b1dd4a9..bc65a54eb2a4 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -300,6 +300,7 @@ COND_SYSCALL(migrate_pages);
 COND_SYSCALL_COMPAT(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL_COMPAT(move_pages);
+COND_SYSCALL(refpage_create);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/Makefile b/mm/Makefile
index e3436741d539..137adc22bf50 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -35,10 +35,10 @@ CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
 CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
 
 mmu-y			:= nommu.o
-mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
+mmu-$(CONFIG_MMU)	:= highmem.o ioremap.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o ioremap.o
+			   pgtable-generic.o refpage.o rmap.o vmalloc.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/gup.c b/mm/gup.c
index 42b8b1fa6521..3beffc84c449 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -548,7 +548,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			goto out;
 		}
 
-		if (is_zero_pfn(pte_pfn(pte))) {
+		if (is_zero_pfn(pte_pfn(pte)) ||
+		    is_refpage_pfn(vma, pte_pfn(pte))) {
 			page = pte_page(pte);
 		} else {
 			ret = follow_pfn_pte(vma, address, ptep, flags);
diff --git a/mm/memory.c b/mm/memory.c
index 747a01d495f2..dfc08e17aa2a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -616,6 +616,8 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			return NULL;
 		if (is_zero_pfn(pfn))
 			return NULL;
+		if (is_refpage_pfn(vma, pfn))
+			return NULL;
 		if (pte_devmap(pte))
 			return NULL;
 
@@ -642,6 +644,8 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (is_zero_pfn(pfn))
 		return NULL;
+	if (is_refpage_pfn(vma, pfn))
+		return NULL;
 
 check_pfn:
 	if (unlikely(pfn > highest_memmap_pfn)) {
@@ -2168,6 +2172,8 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
 		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
 		return true;
+	if (is_refpage_pfn(vma, pfn_t_to_pfn(pfn)))
+		return true;
 	return false;
 }
 
@@ -2990,22 +2996,29 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
+	unsigned long pfn;
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
 
-	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
+	pfn = pte_pfn(vmf->orig_pte);
+	if (is_zero_pfn(pfn)) {
 		new_page = alloc_zeroed_user_highpage_movable(vma,
 							      vmf->address);
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
-				vmf->address);
+		bool refpage = is_refpage_pfn(vma, pfn);
+
+		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE |
+						  (refpage ? __GFP_NOZERO : 0),
+					  vma, vmf->address);
 		if (!new_page)
 			goto oom;
 
-		if (!cow_user_page(new_page, old_page, vmf)) {
+		if (refpage) {
+			arch_copy_refpage(new_page, vmf->address, vma);
+		} else if (!cow_user_page(new_page, old_page, vmf)) {
 			/*
 			 * COW failed, if the fault was solved by other,
 			 * it's fine. If not, userspace would re-fault on
@@ -3739,11 +3752,16 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (unlikely(pmd_trans_unstable(vmf->pmd)))
 		return 0;
 
-	/* Use the zero-page for reads */
+	/* Use the zero-page, or reference page if set, for reads */
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm)) {
-		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
-						vma->vm_page_prot));
+		unsigned long pfn;
+
+		if (unlikely(is_refpage_vma(vma)))
+			pfn = page_to_pfn(get_vma_refpage(vma));
+		else
+			pfn = my_zero_pfn(vmf->address);
+		entry = pte_mkspecial(pfn_pte(pfn, vma->vm_page_prot));
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				vmf->address, &vmf->ptl);
 		if (!pte_none(*vmf->pte)) {
@@ -3764,9 +3782,18 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Allocate our own private page. */
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
-	page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
-	if (!page)
-		goto oom;
+
+	if (unlikely(is_refpage_vma(vma))) {
+		page = alloc_page_vma(GFP_HIGHUSER_MOVABLE | __GFP_NOZERO, vma,
+				      vmf->address);
+		if (!page)
+			goto oom;
+		arch_copy_refpage(page, vmf->address, vma);
+	} else {
+		page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
+		if (!page)
+			goto oom;
+	}
 
 	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
 		goto oom_free_page;
diff --git a/mm/migrate.c b/mm/migrate.c
index 34a9ad3e0a4f..2ad41a69dd0e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2726,8 +2726,8 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	/* Only allow populating anonymous memory */
-	if (!vma_is_anonymous(vma))
+	/* Only allow populating anonymous memory without a reference page */
+	if (!vma_is_anonymous(vma) || is_refpage_vma(vma))
 		goto abort;
 
 	pgdp = pgd_offset(mm, addr);
diff --git a/mm/refpage.c b/mm/refpage.c
new file mode 100644
index 000000000000..13c0930dc926
--- /dev/null
+++ b/mm/refpage.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file implements the syscall refpage_create, which returns a file
+ * descriptor which may be mapped using mmap. Such a mapping is similar
+ * to an anonymous mapping, but instead of clean pages being backed by the
+ * zero page, they are instead backed by a so-called reference page, whose
+ * contents are specified using an argument to refpage_create. Loads from
+ * the mapping will load directly from the reference page, and initial
+ * stores to the mapping will copy-on-write from the reference page.
+ *
+ * Reference pages are useful in circumstances where anonymous mappings
+ * combined with manual stores to memory would impose undesirable costs,
+ * either in terms of performance or RSS. Use cases are focused on heap
+ * allocators and include:
+ *
+ * - Pattern initialization for the heap. This is where malloc(3) gives
+ *   you memory whose contents are filled with a non-zero pattern
+ *   byte, in order to help detect and mitigate bugs involving use
+ *   of uninitialized memory. Typically this is implemented by having
+ *   the allocator memset the allocation with the pattern byte before
+ *   returning it to the user, but for large allocations this can result
+ *   in a significant increase in RSS, especially for allocations that
+ *   are used sparsely. Even for dense allocations there is a needless
+ *   impact to startup performance when it may be better to amortize it
+ *   throughout the program. By creating allocations using a reference
+ *   page filled with the pattern byte, we can avoid these costs.
+ *
+ * - Pre-tagged heap memory. Memory tagging [1] is an upcoming ARMv8.5
+ *   feature which allows for memory to be tagged in order to detect
+ *   certain kinds of memory errors with low overhead. In order to set
+ *   up an allocation to allow memory errors to be detected, the entire
+ *   allocation needs to have the same tag. The issue here is similar to
+ *   pattern initialization in the sense that large tagged allocations
+ *   will be expensive if the tagging is done up front. The idea is that
+ *   the allocator would create reference pages with each of the possible
+ *   memory tags, and use those reference pages for the large allocations.
+ *
+ * [1] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/fs_context.h>
+#include <linux/highmem.h>
+#include <linux/mman.h>
+#include <linux/mount.h>
+#include <linux/syscalls.h>
+
+void prep_refpage_private_data(struct refpage_private_data *priv,
+			       char *content_kaddr, unsigned long size)
+{
+	char *refpage_kaddr = page_address(priv->refpage);
+	unsigned long i;
+
+	for (i = 0; i != PAGE_SIZE; i += size)
+		memcpy(refpage_kaddr + i, content_kaddr, size);
+
+	if (size == 1) {
+		priv->content_type = REFPAGE_CONTENT_TYPE_PATTERN;
+		priv->content_info = *content_kaddr;
+	}
+}
+
+void copy_refpage(struct page *page, unsigned long addr,
+		  struct vm_area_struct *vma)
+{
+	struct refpage_private_data *priv = vma->vm_private_data;
+
+	if (priv->content_type == REFPAGE_CONTENT_TYPE_PATTERN)
+		memset(page_address(page), priv->content_info, PAGE_SIZE);
+	else
+		copy_user_highpage(page, priv->refpage, addr, vma);
+}
+
+static int refpage_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	vma_set_anonymous(vma);
+	vma->vm_private_data = vma->vm_file->private_data;
+	arch_prep_refpage_vma(vma);
+	return 0;
+}
+
+static int refpage_release(struct inode *inode, struct file *file)
+{
+	struct refpage_private_data *priv = file->private_data;
+
+	put_page(priv->refpage);
+	kfree(priv);
+	return 0;
+}
+
+static const struct file_operations refpage_file_operations = {
+	.mmap = refpage_mmap,
+	.release = refpage_release,
+};
+
+bool is_refpage_file(struct file *file)
+{
+	return file->f_op == &refpage_file_operations;
+}
+
+SYSCALL_DEFINE3(refpage_create, const void *__user, content, unsigned int,
+		size, unsigned long, flags)
+{
+	unsigned long content_addr = (unsigned long)content;
+	char *content_kaddr;
+	struct page *userpage;
+	struct refpage_private_data *private_data;
+	long retval;
+
+	if (flags != 0)
+		return -EINVAL;
+
+	if (!is_power_of_2(size) || size > PAGE_SIZE ||
+	    (content_addr & (size - 1)) != 0)
+		return -EINVAL;
+
+	if (get_user_pages(content_addr & ~(PAGE_SIZE - 1), 1, 0, &userpage,
+			   0) != 1)
+		return -EFAULT;
+
+	private_data = kzalloc(sizeof(struct refpage_private_data), GFP_KERNEL);
+	if (!private_data) {
+		retval = -ENOMEM;
+		goto free_userpage;
+	}
+
+	private_data->refpage = alloc_page(GFP_KERNEL);
+	if (!private_data->refpage) {
+		retval = -ENOMEM;
+		goto free_private_data;
+	}
+
+	content_kaddr =
+		page_address(userpage) + (content_addr & (PAGE_SIZE - 1));
+	arch_prep_refpage_private_data(private_data, content_kaddr, size);
+
+	retval = anon_inode_getfd("[refpage]", &refpage_file_operations,
+				  private_data, O_RDONLY | O_CLOEXEC);
+	if (retval < 0)
+		goto free_refpage;
+
+	goto free_userpage;
+
+free_refpage:
+	put_page(private_data->refpage);
+free_private_data:
+	kfree(private_data);
+free_userpage:
+	put_page(userpage);
+	return retval;
+}
-- 
2.32.0.402.g57bb445576-goog

