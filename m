Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BE5157D1F
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 15:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgBJONJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 09:13:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42256 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBJONI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 09:13:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id e10so403959edv.9
        for <linux-api@vger.kernel.org>; Mon, 10 Feb 2020 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wf4e7kPdeIlR7B2PF4Li/BskNnaF9BNb5AtyMbRKOb0=;
        b=r77yba+el8su8MsJ5fvHC4C48dyn/FGPgo1CIBD3cjZrRPybyqleH7TNBvuXrqo1Na
         hhJOBd3Wi3xTSYjlZBFvTtceT04IynAjM48nIMbFxMaNlWpAnx4Hc+mZyQI/U10KZN0S
         TfE/crwdR0foLKFayS22P2S2o+KdtdtaFB77XtzDXO5xarntOrfTjrnAKTJTRYvaxrNx
         GOrcvMTAhczXtMXU+HZ0KT082668lGBlfvpC1/N19f8Md17vNf4C0kP4k18SH4/WL4y9
         ltCJtB+PTCHgUXSV8MJ3pfz4UebiiV2koV75eQXOYl7QfJp5g3wjhe3DzO1Gd8M/ykpe
         195w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wf4e7kPdeIlR7B2PF4Li/BskNnaF9BNb5AtyMbRKOb0=;
        b=rUuN1pRLO2kCgQJw1KLQUIWjwrvjR5qfy2oYesUMSGAQ79JTNtBpiXcm4fKqFXwEvO
         qU8rmjmVdglG7m6w7CCgC5qtGc2rz3dbsZI7l9nBmuv1Rxe+A1ihkzRQkUoYXqogBhir
         PUlOobKN9Nsxf1LjeUb6zbVQHXeaIwt87bwAwzMFzyRobk2mxHPIcbXlF3yCOZctav94
         L/GG9Ht8Dg1OZpXp9S1Tr03rN7kENo12CmOZ2Oe9Pk72RAAyG0uwjqoGC2i5DwiXLgpF
         X/lM7yCXdLul5pAMU7xxouG3wm786tELcR7DpJMepyqeUUOOHOErkCDSuR1iYyIG6IzI
         g8dQ==
X-Gm-Message-State: APjAAAVvTp2lRq5/SIZ70tvWRIyR8AxaFr9Ksopo6N70obmlM/JbUcMh
        MebfYfZwbsjqM1ZJ3NcG6akdLfVM5IAkjoKxsWZIUA==
X-Google-Smtp-Source: APXvYqwAD2SBT/hEJad2wViokulx8jDGBJB2jI2+4XmTPfB/uY3mdosgs20MW5YtWDEPSnrnlToW46tMY84Kz35iyfA=
X-Received: by 2002:a05:6402:6c7:: with SMTP id n7mr1317419edy.177.1581343986147;
 Mon, 10 Feb 2020 06:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <20200210104520.cfs2oytkrf5ihd3m@box>
In-Reply-To: <20200210104520.cfs2oytkrf5ihd3m@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 10 Feb 2020 06:12:39 -0800
Message-ID: <CADyq12wcwvRLwueucHFV2ErL67etOJdFGYQdqVFM2WAeOkMGQA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Kirill,
If the old_len == new_len then there is no change in the number of
locked pages they just moved, if the new_len < old_len then the
process of unmapping (new_len - old_len) bytes from the old mapping
will handle the locked page accounting. So in this special case where
we're growing the VMA, vma_to_resize() will enforce that growing the
vma doesn't exceed RLIMIT_MEMLOCK, but vma_to_resize() doesn't handle
incrementing mm->locked_bytes which is why we have that special case
incrementing it here.

Thanks,
Brian

On Mon, Feb 10, 2020 at 2:45 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Feb 07, 2020 at 12:18:56PM -0800, Brian Geffon wrote:
> > When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> > set, the source mapping will not be removed. Instead it will be
> > cleared as if a brand new anonymous, private mapping had been created
> > atomically as part of the mremap() call.  If a userfaultfd was watching
> > the source, it will continue to watch the new mapping.  For a mapping
> > that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> > mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
> > a VMA you MUST use the MREMAP_MAYMOVE flag. The final result is two
> > equally sized VMAs where the destination contains the PTEs of the source.
> >
> > We hope to use this in Chrome OS where with userfaultfd we could write
> > an anonymous mapping to disk without having to STOP the process or worry
> > about VMA permission changes.
> >
> > This feature also has a use case in Android, Lokesh Gidra has said
> > that "As part of using userfaultfd for GC, We'll have to move the physical
> > pages of the java heap to a separate location. For this purpose mremap
> > will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> > heap, its virtual mapping will be removed as well. Therefore, we'll
> > require performing mmap immediately after. This is not only time consuming
> > but also opens a time window where a native thread may call mmap and
> > reserve the java heap's address range for its own usage. This flag
> > solves the problem."
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  include/uapi/linux/mman.h |  5 +-
> >  mm/mremap.c               | 98 ++++++++++++++++++++++++++++++---------
> >  2 files changed, 80 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> > index fc1a64c3447b..923cc162609c 100644
> > --- a/include/uapi/linux/mman.h
> > +++ b/include/uapi/linux/mman.h
> > @@ -5,8 +5,9 @@
> >  #include <asm/mman.h>
> >  #include <asm-generic/hugetlb_encode.h>
> >
> > -#define MREMAP_MAYMOVE       1
> > -#define MREMAP_FIXED 2
> > +#define MREMAP_MAYMOVE               1
> > +#define MREMAP_FIXED         2
> > +#define MREMAP_DONTUNMAP     4
> >
> >  #define OVERCOMMIT_GUESS             0
> >  #define OVERCOMMIT_ALWAYS            1
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 122938dcec15..9f4aa17f178b 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -318,8 +318,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  static unsigned long move_vma(struct vm_area_struct *vma,
> >               unsigned long old_addr, unsigned long old_len,
> >               unsigned long new_len, unsigned long new_addr,
> > -             bool *locked, struct vm_userfaultfd_ctx *uf,
> > -             struct list_head *uf_unmap)
> > +             bool *locked, unsigned long flags,
> > +             struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
> >  {
> >       struct mm_struct *mm = vma->vm_mm;
> >       struct vm_area_struct *new_vma;
> > @@ -408,11 +408,41 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >       if (unlikely(vma->vm_flags & VM_PFNMAP))
> >               untrack_pfn_moved(vma);
> >
> > +     if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
> > +             if (vm_flags & VM_ACCOUNT) {
> > +                     /* Always put back VM_ACCOUNT since we won't unmap */
> > +                     vma->vm_flags |= VM_ACCOUNT;
> > +
> > +                     vm_acct_memory(vma_pages(new_vma));
> > +             }
> > +
> > +             /*
> > +              * locked_vm accounting: if the mapping remained the same size
> > +              * it will have just moved and we don't need to touch locked_vm
> > +              * because we skip the do_unmap. If the mapping shrunk before
> > +              * being moved then the do_unmap on that portion will have
> > +              * adjusted vm_locked. Only if the mapping grows do we need to
> > +              * do something special; the reason is locked_vm only accounts
> > +              * for old_len, but we're now adding new_len - old_len locked
> > +              * bytes to the new mapping.
> > +              */
> > +             if (new_len > old_len)
> > +                     mm->locked_vm += (new_len - old_len) >> PAGE_SHIFT;
>
> Hm. How do you enforce that we're not over RLIMIT_MEMLOCK?
>
>
> --
>  Kirill A. Shutemov
