Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0873AD8E3
	for <lists+linux-api@lfdr.de>; Sat, 19 Jun 2021 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhFSJXv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 19 Jun 2021 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFSJXu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 19 Jun 2021 05:23:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D89C061574
        for <linux-api@vger.kernel.org>; Sat, 19 Jun 2021 02:21:39 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k11so8660727ioa.5
        for <linux-api@vger.kernel.org>; Sat, 19 Jun 2021 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTsKyp/eCJ6V5JSSfCF+z8G/5CCEJEdoE/G3TmDQtWA=;
        b=sCc4nwcoNQ1iXDkCZouVEmzRCIAWN82TTZLeCv5+bSoHRfbCzs6TVwIua9Sa/9Ouim
         YnALk61ULGDABN4MfxSima3QfZE7v+EsfH79xCfSRO4XDiwvhGNJgTfze99NBJA/7Ox9
         04HHwTCUeg35XaniH3GS12xjV7xXNYX5FliWjrAuMmzn4VF05ld0uSchEAkAaEzzrlTF
         OcwHJl3u2iKRiMJqK4RXAzULfaz0OwVZaD1jGpKiZVx3YAuWLWwd73N7xgjERCxZJnrG
         r0lo60YtW57s6oIgaMVw8kHllhrb7DfcAkHEcYjBz8xlFALexIQ3KTHF4uDtXMTbT388
         sdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTsKyp/eCJ6V5JSSfCF+z8G/5CCEJEdoE/G3TmDQtWA=;
        b=NcaeL+4PbGNjnYAqbJAMHJLpyzX/gbOObQXso9VNlDvdGFpr8Q7O79UsvyoMbAjfoD
         TogchS9r+GxjCGAAGM2OprgdmkZcitFfGXs4hYHOub2z5aXlClcpQosZBulLFiAEn0XL
         p2thyoQ6gPXZYegG/frBIKB3bZ4EYftNu45ZxZQowKGvqcJcm+PLdLvPys6yzydaU6Pr
         +7D0Rv7jsHF29fm6BVKd7pQTpZERRMEh1U1ngWQTZuXb4Re8TeVhovewdRL/DluY9SSb
         nm58CRpbI2R6ZZ4C0+FO2v/mAWkavDUy7jhEWECTDDuhNRZMas+td4Q6rL9K9Kk3Oar3
         pu5A==
X-Gm-Message-State: AOAM533gywJGfwWAhPd8RpQGhuMsPdNz4uwfxwRfj42bSyY56IAhbsto
        UrGBv9gF8qd5eHhIfME4ekpV8IagYSZploBP6kcyOA==
X-Google-Smtp-Source: ABdhPJyidjGvE+jgXQ3IQmEWap1fVV5R+PUaU2WEGwGjlNWEnijcTCPelVCnSHbTXkRccCo2upiLr3g4zr82usHDGhw=
X-Received: by 2002:a05:6638:b86:: with SMTP id b6mr7485991jad.36.1624094498184;
 Sat, 19 Jun 2021 02:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200814213310.42170-1-pcc@google.com> <c2f7efa7-0b52-b92f-79bc-a0cc26b0d92c@nvidia.com>
In-Reply-To: <c2f7efa7-0b52-b92f-79bc-a0cc26b0d92c@nvidia.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Sat, 19 Jun 2021 02:21:27 -0700
Message-ID: <CAMn1gO7PdrEhc11WW3SiRswfG1TqfmVCcXH+AbqQGMdEjDR7qw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: introduce reference pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Apologies for the delay in getting back to you; other work ended up
taking priority and now I'm back to looking at this.]

On Mon, Aug 17, 2020 at 7:31 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/14/20 2:33 PM, Peter Collingbourne wrote:
> > Introduce a new syscall, refpage_create, which returns a file
> > descriptor which may be mapped using mmap. Such a mapping is similar
>
> Hi,
>
> For new syscalls, I think we need to put linux-api on CC, at the very
> least. Adding them now. This would likely need man page support as well.
> I'll put linux-doc on Cc, too.

Thanks.

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
>
> That is good information, and it belongs in a man page, and/or Documentation/.

I plan to write a man page for refpage_create(2) once this is closer to landing.

> >
> > In order to measure the performance and RSS impact of reference pages,
> > a version of this patch backported to kernel version 4.14 was tested on
> > a Pixel 4 together with a modified [2] version of the Scudo allocator
> > that uses reference pages to implement pattern initialization. A
> > PDFium test program was used to collect the measurements like so:
> >
> > $ wget https://static.docs.arm.com/ddi0487/fb/DDI0487F_b_armv8_arm.pdf
> > $ /system/bin/time -v ./pdfium_test --pages=1-100 DDI0487F_b_armv8_arm.pdf
> >
> > and the median of 100 runs measurement was taken with three variants
> > of the allocator:
> >
> > - "anon" is the baseline (no pattern init)
> > - "memset" is with pattern init of allocator pages implemented by
> >    initializing anonymous pages with memset
> > - "refpage" is with pattern init of allocator pages implemented
> >    by creating reference pages
> >
> > All three variants are measured using the patch that I linked. "anon"
> > is without the patch, "refpage" is with the patch and "memset" is
> > with a previous version of the patch [3] with "#if 0" in place of
> > "#if 1" in linux.cpp. The measurements are as follows:
> >
> >            Real time (s)    Max RSS (KiB)
> > anon        2.237081         107088
> > memset      2.252241         112180
> > refpage     2.243786         107128
> >
> > We can see that RSS for refpage is almost the same as anon, and real
> > time overhead is 44% that of memset.
> >
>
> Are some of the numbers stale, maybe? Try as I might, I cannot combine
> anything above to come up with 44%. :)
>
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
>
>
> That whole blurb is good for a cover letter, and perhaps an "alternatives
> considered" section in Documentation/. However, it should be omitted from
> the patch commit description, IMHO.

Okay, I moved it to the notes section of the commit message.

> ...
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 467302056e17..a1dc07ff914a 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -175,6 +175,13 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >
> >       if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> >               return false;
> > +
> > +     /*
> > +      * Transparent hugepages not currently supported for anonymous VMAs with
> > +      * reference pages
> > +      */
> > +     if (unlikely(vma->vm_private_data))
>
>
> This should use a helper function, such as is_reference_page_vma(). Because the
> assumption that "vma->vm_private_data means a reference page vma" is much too
> fragile. More below.

That makes sense. In v4 I've introduced a helper function.

> > +             return false;
> >       return true;
> >   }
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index e7602a3bcef1..ac375e398690 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3122,5 +3122,15 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
> >
> >   extern int sysctl_nr_trim_pages;
> >
> > +static inline int is_zero_or_refpage_pfn(struct vm_area_struct *vma,
> > +                                      unsigned long pfn)
> > +{
> > +     if (is_zero_pfn(pfn))
> > +             return true;
> > +     if (unlikely(!vma->vm_ops && vma->vm_private_data))
> > +             return pfn == page_to_pfn((struct page *)vma->vm_private_data);
>
> As foreshadowed above, this needs a helper function. And the criteria for
> deciding that it's a reference page needs to be more robust than just "no vm_ops,
> vm_private_data is set, and it matches my page". Needs some more decisive
> information.
>
> Maybe setting vm_ops to some new "refpage" ops would be the way to go, for that.

As I mentioned in my reply to Jann, we can't set vm_ops without
introducing some unwanted behavior as a result of following the
non-anonymous VMA code path. What I ended up doing instead was to
check whether vm_file->f_op refers to the refpage file_operations
struct.

It might be nice to introduce a VM_REFPAGE flag to make this check
more efficient, but this would first require extending vm_flags to 64
bits on 32-bit platforms since we're out of bits in vm_flags. From
looking around it looks like many people have attempted this over the
years; it looks like the most recent attempt is from this month:
https://www.spinics.net/lists/kernel/msg3961408.html

Let's see if it actually happens this time.

> ...
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 5053439be6ab..6e9246d09e95 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2841,8 +2841,8 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
> >       pmd_t *pmdp;
> >       pte_t *ptep;
> >
> > -     /* Only allow populating anonymous memory */
> > -     if (!vma_is_anonymous(vma))
> > +     /* Only allow populating anonymous memory without a reference page */
> > +     if (!vma_is_anonymous(vma) || vma->private_data)
>
> Same thing here: helper function, instead of open-coding the assumption about
> what makes a refpage vma.

Done.

> ...
>
> > +SYSCALL_DEFINE2(refpage_create, const void *__user, content, unsigned long,
> > +             flags)
> > +{
> > +     unsigned long content_addr = (unsigned long)content;
> > +     struct page *userpage, *refpage;
> > +     int fd;
> > +
> > +     if (flags != 0)
> > +             return -EINVAL;
> > +
> > +     refpage = alloc_page(GFP_KERNEL);
> > +     if (!refpage)
> > +             return -ENOMEM;
> > +
> > +     if ((content_addr & (PAGE_SIZE - 1)) != 0 ||
> > +         get_user_pages(content_addr, 1, 0, &userpage, 0) != 1) {
> > +             put_page(refpage);
> > +             return -EFAULT;
> > +     }
> > +
> > +     copy_highpage(refpage, userpage);
> > +     put_page(userpage);
> > +
> > +     fd = anon_inode_getfd("[refpage]", &refpage_file_operations, refpage,
> > +                           O_RDONLY | O_CLOEXEC);
>
> Seems like the flags argument should have an influence on these flags, rather
> than hard-coding O_CLOEXEC, right?

I couldn't see a use case for having one of these FDs without
O_CLOEXEC. If someone really wants a non-CLOEXEC refpage FD, they can
use fcntl to clear the CLOEXEC bit.

I only added the flags argument to support future extension as described in:
https://www.kernel.org/doc/html/v5.12/process/adding-syscalls.html#designing-the-api-planning-for-extension

Peter
