Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D93CEFBD
	for <lists+linux-api@lfdr.de>; Tue, 20 Jul 2021 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbhGSWio (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Jul 2021 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441863AbhGSWN7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Jul 2021 18:13:59 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D04C061762
        for <linux-api@vger.kernel.org>; Mon, 19 Jul 2021 15:27:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w1so17430824ilg.10
        for <linux-api@vger.kernel.org>; Mon, 19 Jul 2021 15:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOkdDiJNyKSDja5MB+OAae9DgBN08tMYuqsG7LdNoFg=;
        b=XYwrzqlroQPSkm0oXs9gZub17sPxJHOqB1a/lX50vNHpGitb9EybL1O8gBMR39oZt+
         2O6/Lxw0Qj4nz7fdnEiZApDHSB6ksM6JZv0awniMydLUPf2nbechkuMY+zoul3gayoZn
         T9S3qziTwZSUlj1mVRuOWwcj+UrSdXJaQevr6AE6T5U9JmnkdpHGw2Jw1Vn4/Fl2Qayx
         ejtWiXPlYkLd7uv4ba801g8vQLYrN8F2hQ2lXAK2QSVDEyvGBQRKsZjaizQVvskwLAhj
         XWpoH6TrfLX55Gp+ZOIuCWupMJy370JcA4FwXQGRQvNXFAZLtf+IVUFjg9Iu6TVjnRpJ
         r7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOkdDiJNyKSDja5MB+OAae9DgBN08tMYuqsG7LdNoFg=;
        b=bL5UJsb27blv+RxeNONFZEXRuct4oOVOcoXDQm6X8FT1FZvv3amIc2BbJrk+nORRyS
         b8/DXX+dbLyCcwTUHifQJfbhoe52dPfmQt1f5omWjvxc3F6Wc/yYrdjn5TXiZF3YroHb
         52f2At+BKMJwY4Ci+9JZ6KqUwjdeov0/CXkWffkRKeLxmIECOMe5/IyRksk92+hoh4Aq
         FT70ulZrzbbT0l6sFpD2C9pcM6PQSD2GxmIhYfXHu1URb9cokwrZgudtSVh9vD7vFx6r
         doKvtDZmFFLuRlEj1Xz+QpyWUCCLBT1pFpkg64yOgBp5KLEAj/QvNQHMoPEoLewKSY0i
         bkTw==
X-Gm-Message-State: AOAM532RA7lvtdN/41VV1VoS5l9LG6vu+GlngpU+l/zRQmpmt5p4PX0C
        B2oPdn4Zf5IoRNuIEczZgKT7dwqFeBcI939x6dQnNA==
X-Google-Smtp-Source: ABdhPJwKg2qspIOA+PembwFkXbVx2Dth/MCs1uiVBVzOjmw9feMfVG3ec2QsIGoNZ7fxso9m2YCiKPWjMf0o3YyhvjA=
X-Received: by 2002:a92:c143:: with SMTP id b3mr17808568ilh.145.1626733622932;
 Mon, 19 Jul 2021 15:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210619092002.1791322-1-pcc@google.com> <30e92457-d540-159c-4c4e-0b8f0d2a1838@redhat.com>
In-Reply-To: <30e92457-d540-159c-4c4e-0b8f0d2a1838@redhat.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 19 Jul 2021 15:26:51 -0700
Message-ID: <CAMn1gO529Ua1LJBM=vdwT8Cz+CXSvJcuGhuqotSuiUyjTBDfAQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm: introduce reference pages
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 19, 2021 at 1:50 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.06.21 11:20, Peter Collingbourne wrote:
> > Introduce a new syscall, refpage_create, which returns a file
> > descriptor which may be mapped using mmap. Such a mapping is similar
> > to an anonymous mapping, but instead of clean pages being backed by the
> > zero page, they are instead backed by a so-called reference page, whose
> > contents are specified using an argument to refpage_create. Loads from
> > the mapping will load directly from the reference page, and initial
> > stores to the mapping will copy-on-write from the reference page.
> >
> > Reference pages are useful in circumstances where anonymous mappings
> > combined with manual stores to memory would impose undesirable costs,
> > either in terms of performance or RSS. Use cases are focused on heap
> > allocators and include:
> >
> > - Pattern initialization for the heap. This is where malloc(3) gives
> >    you memory whose contents are filled with a non-zero pattern
> >    byte, in order to help detect and mitigate bugs involving use
> >    of uninitialized memory. Typically this is implemented by having
> >    the allocator memset the allocation with the pattern byte before
> >    returning it to the user, but for large allocations this can result
> >    in a significant increase in RSS, especially for allocations that
> >    are used sparsely. Even for dense allocations there is a needless
> >    impact to startup performance when it may be better to amortize it
> >    throughout the program. By creating allocations using a reference
> >    page filled with the pattern byte, we can avoid these costs.
> >
> > - Pre-tagged heap memory. Memory tagging [1] is an upcoming ARMv8.5
> >    feature which allows for memory to be tagged in order to detect
> >    certain kinds of memory errors with low overhead. In order to set
> >    up an allocation to allow memory errors to be detected, the entire
> >    allocation needs to have the same tag. The issue here is similar to
> >    pattern initialization in the sense that large tagged allocations
> >    will be expensive if the tagging is done up front. The idea is that
> >    the allocator would create reference pages with each of the possible
> >    memory tags, and use those reference pages for the large allocations.
> >
> > This patch includes specific optimizations for these use cases in
> > order to reduce memory traffic. If the reference page consists of a
> > single repeating byte, the page is initialized using memset, and on
> > arm64 if the reference page consists of a uniformly tagged zero page,
> > the DC GZVA instruction is used to initialize the page.
> >
> > In order to measure the performance and RSS impact of reference pages,
> > I used the following microbenchmark program, which is intended to
> > compare an implementation of heap pattern initialization that uses
> > memset to initialize the pages against an implementation that uses
> > reference pages:
> >
> >    #include <stdio.h>
> >    #include <stdlib.h>
> >    #include <string.h>
> >    #include <sys/mman.h>
> >    #include <unistd.h>
> >
> >    constexpr unsigned char pattern_byte = 0xaa;
> >
> >    #define PAGE_SIZE 4096
> >
> >    _Alignas(PAGE_SIZE) static unsigned char pattern[PAGE_SIZE];
> >
> >    int main(int argc, char **argv) {
> >      if (argc < 3)
> >        return 1;
> >      bool use_refpage = argc > 3;
> >      size_t mmap_size = atoi(argv[1]);
> >      size_t touch_size = atoi(argv[2]);
> >
> >      int refpage_fd;
> >      if (use_refpage) {
> >        memset(pattern, pattern_byte, PAGE_SIZE);
> >        refpage_fd = syscall(448, pattern, 0);
> >      }
> >      for (unsigned i = 0; i != 1000; ++i) {
> >        char *p;
> >        if (use_refpage) {
> >          p = (char *)mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE,
> >                           refpage_fd, 0);
> >        } else {
> >          p = (char *)mmap(0, mmap_size, PROT_READ | PROT_WRITE,
> >                           MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >          memset(p, pattern_byte, mmap_size);
> >        }
> >        for (unsigned j = 0; j < touch_size; j += PAGE_SIZE)
> >          p[j] = 0;
> >        munmap(p, mmap_size);
> >      }
> >    }
> >
> > On a DragonBoard 845c with the powersave governor, and taking the
> > median of 10 runs for each measurement, I measured the following
> > results for real time (s):
> >
> > touch_size/mmap_size   memset   refpages     improvement (95% CI)
> >        4096/4096000    3.962194   0.026726   98.8015% +/- 1.14684%
> >     2048000/4096000    3.925309   1.48081    61.8271% +/- 1.11911%
> >     4096000/4096000    3.986275   3.385003   15.1205% +/- 0.227235%
> >
> > And the following for max RSS (KiB):
> >
> > touch_size/mmap_size   memset   refpages     improvement (95% CI)
> >        4096/4096000      6656      3448      49.3815% +/- 1.30339%
> >     2048000/4096000      6696      4580      31.7053% +/- 1.16411%
> >     4096000/4096000      6716      6684              none
> >
> > So we see a large improvement for sparsely used allocations, and even
> > a modest perf improvement for fully utilized allocations as a result
> > of touching the pages one fewer time (with memset: once in the kernel
> > and once in userspace; with refpages: just once in the kernel).
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: [1] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
> > ---
> > v4:
> > - rebased to linux-next
> > - added arch hooks to support MTE tagged reference pages
> > - added optimizations for pages with pattern byte as well as uniformly MTE-tagged pages
> > - added helper functions to avoid open-coding the reference page detection
> > - wrote a microbenchmark program and got new perf results for the commit message
> >
> > As an alternative to introducing this syscall, I considered using
> > userfaultfd to implement reference pages. However, after having taken
> > a detailed look at the interface, it does not seem suitable to be
> > used in the context of a general purpose allocator. For example,
> > UFFD_FEATURE_FORK support would be required in order to correctly
> > support fork(2) in a process that uses the allocator (although POSIX
> > does not guarantee support for allocating after fork, many allocators
> > including Scudo support it, and nothing stops the forked process from
> > page faulting pre-existing allocations after forking anyway), but
> > UFFD_FEATURE_FORK has been restricted to root by commit 3c1c24d91ffd
> > ("userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK"),
> > making it unsuitable for use in an allocator. Furthermore, even if
> > the interface issues are resolved, I suspect (but have not measured)
> > that the cost of the multiple context switches between kernel and
> > userspace would be too high to be used in an allocator anyway.
> >
> >   arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
> >   arch/arm/tools/syscall.tbl                  |  1 +
> >   arch/arm64/include/asm/mman.h               | 15 ++++
> >   arch/arm64/include/asm/mte.h                |  9 +-
> >   arch/arm64/include/asm/page.h               |  2 +-
> >   arch/arm64/include/asm/unistd.h             |  2 +-
> >   arch/arm64/include/asm/unistd32.h           |  2 +
> >   arch/arm64/kernel/mte.c                     | 24 +++++
> >   arch/arm64/lib/mte.S                        |  7 +-
> >   arch/arm64/mm/fault.c                       | 41 ++++++++-
> >   arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
> >   arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
> >   arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
> >   arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
> >   arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
> >   arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
> >   arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
> >   arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
> >   arch/s390/kernel/syscalls/syscall.tbl       |  1 +
> >   arch/sh/kernel/syscalls/syscall.tbl         |  1 +
> >   arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
> >   arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
> >   arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
> >   arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
> >   include/linux/gfp.h                         | 11 ++-
> >   include/linux/highmem.h                     |  2 +-
> >   include/linux/huge_mm.h                     |  7 ++
> >   include/linux/mm.h                          | 39 ++++++++
> >   include/linux/mman.h                        | 19 ++++
> >   include/linux/syscalls.h                    |  3 +
> >   include/uapi/asm-generic/unistd.h           |  5 +-
> >   kernel/sys_ni.c                             |  1 +
> >   mm/Makefile                                 |  4 +-
> >   mm/gup.c                                    |  2 +-
> >   mm/kasan/hw_tags.c                          |  2 +-
> >   mm/memory.c                                 | 47 +++++++---
> >   mm/migrate.c                                |  4 +-
> >   mm/page_alloc.c                             |  2 +-
> >   mm/refpage.c                                | 98 +++++++++++++++++++++
> >   39 files changed, 330 insertions(+), 34 deletions(-)
> >   create mode 100644 mm/refpage.c
> >
> > diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> > index a17687ed4b51..494edc5ca61c 100644
> > --- a/arch/alpha/kernel/syscalls/syscall.tbl
> > +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> > @@ -486,3 +486,4 @@
> >   554 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   555 common  landlock_add_rule               sys_landlock_add_rule
> >   556 common  landlock_restrict_self          sys_landlock_restrict_self
> > +558  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> > index c5df1179fc5d..8fd7045f46b9 100644
> > --- a/arch/arm/tools/syscall.tbl
> > +++ b/arch/arm/tools/syscall.tbl
> > @@ -460,3 +460,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> > index e3e28f7daf62..5c0da3f76ec7 100644
> > --- a/arch/arm64/include/asm/mman.h
> > +++ b/arch/arm64/include/asm/mman.h
> > @@ -84,4 +84,19 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
> >   }
> >   #define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> >
> > +struct refpage_private_data;
> > +
> > +void arch_prep_refpage_private_data(struct refpage_private_data *priv);
> > +#define arch_prep_refpage_private_data arch_prep_refpage_private_data
> > +
> > +static inline void arch_prep_refpage_vma(struct vm_area_struct *vma)
> > +{
> > +     vma->vm_flags |= VM_MTE_ALLOWED;
> > +}
> > +#define arch_prep_refpage_vma arch_prep_refpage_vma
> > +
> > +void arch_copy_refpage(struct page *page, unsigned long addr,
> > +                                  struct vm_area_struct *vma);
> > +#define arch_copy_refpage arch_copy_refpage
> > +
> >   #endif /* ! __ASM_MMAN_H__ */
> > diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> > index 67bf259ae768..b513f83010c7 100644
> > --- a/arch/arm64/include/asm/mte.h
> > +++ b/arch/arm64/include/asm/mte.h
> > @@ -37,7 +37,7 @@ void mte_free_tag_storage(char *storage);
> >   /* track which pages have valid allocation tags */
> >   #define PG_mte_tagged       PG_arch_2
> >
> > -void mte_zero_clear_page_tags(void *addr);
> > +void mte_zero_set_page_tags(void *addr);
> >   void mte_sync_tags(pte_t *ptep, pte_t pte);
> >   void mte_copy_page_tags(void *kto, const void *kfrom);
> >   void mte_thread_init_user(void);
> > @@ -48,13 +48,14 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg);
> >   long get_mte_ctrl(struct task_struct *task);
> >   int mte_ptrace_copy_tags(struct task_struct *child, long request,
> >                        unsigned long addr, unsigned long data);
> > +u8 mte_check_tag_zero_page(struct page *userpage);
> >
> >   #else /* CONFIG_ARM64_MTE */
> >
> >   /* unused if !CONFIG_ARM64_MTE, silence the compiler */
> >   #define PG_mte_tagged       0
> >
> > -static inline void mte_zero_clear_page_tags(void *addr)
> > +static inline void mte_zero_set_page_tags(void *addr)
> >   {
> >   }
> >   static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
> > @@ -89,6 +90,10 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
> >   {
> >       return -EIO;
> >   }
> > +static inline u8 mte_check_tag_zero_page(struct page *userpage)
> > +{
> > +     return 0;
> > +}
> >
> >   #endif /* CONFIG_ARM64_MTE */
> >
> > diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> > index 993a27ea6f54..234f48688b1a 100644
> > --- a/arch/arm64/include/asm/page.h
> > +++ b/arch/arm64/include/asm/page.h
> > @@ -33,7 +33,7 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
> >                                               unsigned long vaddr);
> >   #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE_MOVABLE
> >
> > -void tag_clear_highpage(struct page *to);
> > +void tag_set_highpage(struct page *to, unsigned long tag);
> >   #define __HAVE_ARCH_TAG_CLEAR_HIGHPAGE
> >
> >   #define clear_user_page(page, vaddr, pg)    clear_page(page)
> > diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> > index 727bfc3be99b..3cb206aea3db 100644
> > --- a/arch/arm64/include/asm/unistd.h
> > +++ b/arch/arm64/include/asm/unistd.h
> > @@ -38,7 +38,7 @@
> >   #define __ARM_NR_compat_set_tls             (__ARM_NR_COMPAT_BASE + 5)
> >   #define __ARM_NR_COMPAT_END         (__ARM_NR_COMPAT_BASE + 0x800)
> >
> > -#define __NR_compat_syscalls         447
> > +#define __NR_compat_syscalls         449
> >   #endif
> >
> >   #define __ARCH_WANT_SYS_CLONE
> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 99ffcafc736c..2a116aa17fe7 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -901,6 +901,8 @@ __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
> >   __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
> >   #define __NR_landlock_restrict_self 446
> >   __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
> > +#define __NR_refpage_create 448
> > +__SYSCALL(__NR_refpage_create, sys_refpage_create)
> >
> >   /*
> >    * Please add new compat syscalls above this comment and update
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index 125a10e413e9..6a79240d5a77 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -453,3 +453,27 @@ int mte_ptrace_copy_tags(struct task_struct *child, long request,
> >
> >       return ret;
> >   }
> > +
> > +u8 mte_check_tag_zero_page(struct page *userpage)
> > +{
> > +     char *userpage_addr = page_address(userpage);
> > +     u8 tag;
> > +     int i;
> > +
> > +     if (!test_bit(PG_mte_tagged, &userpage->flags))
> > +             return 0;
> > +
> > +     tag = mte_get_mem_tag(userpage_addr) & 0xF;
> > +     if (tag == 0)
> > +             return 0;
> > +
> > +     for (i = 0; i != PAGE_SIZE; ++i)
> > +             if (userpage_addr[i] != 0)
> > +                     return 0;
> > +
> > +     for (i = MTE_GRANULE_SIZE; i != PAGE_SIZE; i += MTE_GRANULE_SIZE)
> > +             if ((mte_get_mem_tag(userpage_addr + i) & 0xF) != tag)
> > +                     return 0;
> > +
> > +     return tag;
> > +}
> > diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> > index e83643b3995f..45be436c97af 100644
> > --- a/arch/arm64/lib/mte.S
> > +++ b/arch/arm64/lib/mte.S
> > @@ -37,24 +37,23 @@ SYM_FUNC_START(mte_clear_page_tags)
> >   SYM_FUNC_END(mte_clear_page_tags)
> >
> >   /*
> > - * Zero the page and tags at the same time
> > + * Zero the page and set tags at the same time
> >    *
> >    * Parameters:
> >    *  x0 - address to the beginning of the page
> >    */
> > -SYM_FUNC_START(mte_zero_clear_page_tags)
> > +SYM_FUNC_START(mte_zero_set_page_tags)
> >       mrs     x1, dczid_el0
> >       and     w1, w1, #0xf
> >       mov     x2, #4
> >       lsl     x1, x2, x1
> > -     and     x0, x0, #(1 << MTE_TAG_SHIFT) - 1       // clear the tag
> >
> >   1:  dc      gzva, x0
> >       add     x0, x0, x1
> >       tst     x0, #(PAGE_SIZE - 1)
> >       b.ne    1b
> >       ret
> > -SYM_FUNC_END(mte_zero_clear_page_tags)
> > +SYM_FUNC_END(mte_zero_set_page_tags)
> >
> >   /*
> >    * Copy the tags from the source page to the destination one
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 349c488765ca..36355758ffc7 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -25,6 +25,7 @@
> >   #include <linux/perf_event.h>
> >   #include <linux/preempt.h>
> >   #include <linux/hugetlb.h>
> > +#include <linux/mman.h>
> >
> >   #include <asm/acpi.h>
> >   #include <asm/bug.h>
> > @@ -939,9 +940,45 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
> >       return alloc_page_vma(flags, vma, vaddr);
> >   }
> >
> > -void tag_clear_highpage(struct page *page)
> > +void tag_set_highpage(struct page *page, unsigned long tag)
> >   {
> > -     mte_zero_clear_page_tags(page_address(page));
> > +     unsigned long addr = (unsigned long)page_address(page);
> > +
> > +     addr &= ~MTE_TAG_MASK;
> > +     addr |= tag << MTE_TAG_SHIFT;
> > +     mte_zero_set_page_tags((void *)addr);
> >       page_kasan_tag_reset(page);
> >       set_bit(PG_mte_tagged, &page->flags);
> >   }
> > +
> > +#define REFPAGE_OPTZN_MTE_TAGGED REFPAGE_OPTZN_ARCH
> > +
> > +void arch_prep_refpage_private_data(struct refpage_private_data *priv)
> > +{
> > +     if (system_supports_mte()) {
> > +             u8 tag;
> > +
> > +             if (!test_and_set_bit(PG_mte_tagged, &priv->refpage->flags))
> > +                     mte_clear_page_tags(page_address(priv->refpage));
> > +
> > +             tag = mte_check_tag_zero_page(priv->refpage);
> > +             if (tag) {
> > +                     priv->optzn_kind = REFPAGE_OPTZN_MTE_TAGGED;
> > +                     priv->optzn_info = tag;
> > +                     return;
> > +             }
> > +     }
> > +
> > +     prep_refpage_private_data(priv);
> > +}
> > +
> > +void arch_copy_refpage(struct page *page, unsigned long addr,
> > +                    struct vm_area_struct *vma)
> > +{
> > +     struct refpage_private_data *priv = vma->vm_private_data;
> > +
> > +     if (priv->optzn_kind == REFPAGE_OPTZN_MTE_TAGGED)
> > +             tag_set_highpage(page, priv->optzn_info);
> > +     else
> > +             copy_refpage(page, addr, vma);
> > +}
> > diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> > index 6d07742c57b8..c2209d83f3c3 100644
> > --- a/arch/ia64/kernel/syscalls/syscall.tbl
> > +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> > @@ -367,3 +367,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> > index 541bc1b3a8f9..0360cf474a49 100644
> > --- a/arch/m68k/kernel/syscalls/syscall.tbl
> > +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> > @@ -446,3 +446,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> > index a176faca2927..de85d758e564 100644
> > --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> > +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> > @@ -452,3 +452,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> > index c2d2e19abea8..b07c7293d2a3 100644
> > --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> > @@ -385,3 +385,4 @@
> >   444 n32     landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 n32     landlock_add_rule               sys_landlock_add_rule
> >   446 n32     landlock_restrict_self          sys_landlock_restrict_self
> > +448  n32     refpage_create                  sys_refpage_create
> > diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > index ac653d08b1ea..7ebabb99dd06 100644
> > --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > @@ -361,3 +361,4 @@
> >   444 n64     landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 n64     landlock_add_rule               sys_landlock_add_rule
> >   446 n64     landlock_restrict_self          sys_landlock_restrict_self
> > +448  n64     refpage_create                  sys_refpage_create
> > diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> > index 253f2cd70b6b..a51149ac101c 100644
> > --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> > @@ -434,3 +434,4 @@
> >   444 o32     landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 o32     landlock_add_rule               sys_landlock_add_rule
> >   446 o32     landlock_restrict_self          sys_landlock_restrict_self
> > +448  o32     refpage_create                  sys_refpage_create
> > diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > index e26187b9ab87..385565864861 100644
> > --- a/arch/parisc/kernel/syscalls/syscall.tbl
> > +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> > @@ -444,3 +444,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> > index aef2a290e71a..95cdd9f7dc06 100644
> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> > @@ -526,3 +526,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> > index 64d51ab5a8b4..92ed1260ffd9 100644
> > --- a/arch/s390/kernel/syscalls/syscall.tbl
> > +++ b/arch/s390/kernel/syscalls/syscall.tbl
> > @@ -449,3 +449,4 @@
> >   444  common landlock_create_ruleset sys_landlock_create_ruleset     sys_landlock_create_ruleset
> >   445  common landlock_add_rule       sys_landlock_add_rule           sys_landlock_add_rule
> >   446  common landlock_restrict_self  sys_landlock_restrict_self      sys_landlock_restrict_self
> > +448  common  refpage_create          sys_refpage_create              sys_refpage_create
> > diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> > index e0a70be77d84..f9d198cc2541 100644
> > --- a/arch/sh/kernel/syscalls/syscall.tbl
> > +++ b/arch/sh/kernel/syscalls/syscall.tbl
> > @@ -449,3 +449,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> > index 603f5a821502..83533aa49340 100644
> > --- a/arch/sparc/kernel/syscalls/syscall.tbl
> > +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> > @@ -492,3 +492,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index ce763a12311c..054c69e395b5 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -452,3 +452,4 @@
> >   445 i386    landlock_add_rule       sys_landlock_add_rule
> >   446 i386    landlock_restrict_self  sys_landlock_restrict_self
> >   447 i386    memfd_secret            sys_memfd_secret
> > +448  i386    refpage_create          sys_refpage_create
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index f6b57799c1ea..1f24f0b66cbd 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -369,6 +369,7 @@
> >   445 common  landlock_add_rule       sys_landlock_add_rule
> >   446 common  landlock_restrict_self  sys_landlock_restrict_self
> >   447 common  memfd_secret            sys_memfd_secret
> > +448  common  refpage_create          sys_refpage_create
> >
> >   #
> >   # Due to a historical design error, certain syscalls are numbered differently
> > diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> > index 235d67d6ceb4..96c27fb404ca 100644
> > --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> > +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> > @@ -417,3 +417,4 @@
> >   444 common  landlock_create_ruleset         sys_landlock_create_ruleset
> >   445 common  landlock_add_rule               sys_landlock_add_rule
> >   446 common  landlock_restrict_self          sys_landlock_restrict_self
> > +448  common  refpage_create                  sys_refpage_create
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 55b2ec1f965a..ae3c763eb9e9 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -55,8 +55,9 @@ struct vm_area_struct;
> >   #define ___GFP_ACCOUNT              0x400000u
> >   #define ___GFP_ZEROTAGS             0x800000u
> >   #define ___GFP_SKIP_KASAN_POISON    0x1000000u
> > +#define ___GFP_NOZERO                0x2000000u
>
> Oh god, please no. We've discussed this a couple of times already:
> whatever leaves the page allcoator shall be zeroed. No exceptions, not
> even for other allocators (like hugetlb).
>
> Introducing something like that to the whole system, including random
> drivers, destroys the whole purpose of the security feature. Please
> don't burry something so controversial in your patch.

Got it -- I was unaware that this was controversial.

Avoiding the double initialization does help a bit in benchmarks, at
least for the fully faulted case. The alternative approach that I was
thinking of was to somehow plumb the required pattern into the page
allocator (which would maintain the invariant that the pages are
initialized, but not necessarily with zeroes), but this would require
touching several layers of the allocator.  I suppose that this doesn't
need to be done immediately though -- we can deal with the double
initialization for now and avoid it somehow in a followup.

Peter
