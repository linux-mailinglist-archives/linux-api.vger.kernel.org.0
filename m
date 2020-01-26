Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B9C1498DA
	for <lists+linux-api@lfdr.de>; Sun, 26 Jan 2020 06:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAZFQq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 26 Jan 2020 00:16:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38843 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAZFQp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 26 Jan 2020 00:16:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so5449531oth.5;
        Sat, 25 Jan 2020 21:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tdQTRj4tn9tyIE0eFvqPGjSncUurrjE+KZhOiMRqlSw=;
        b=QFBpyFiyYi30eufmid3l4fBcrNHHIdw0YE/SGUQJg3fJ8wwhtHcc1+8QEnEOCNGEks
         PWB4fp8g7RX7osJx0nFmrxVUcy6H+q9H8alOX4UBGoVZLtkyRu1FJeL9H3w1f0QuU5wP
         9X1R0k/TMNwOJhEoSMF90hqM+kTh4pAzsXwPl95tF8UmsXXRz5XzslrEK9MTIYG774Dm
         ZS9X0vXbIfVygtvqS3dq2lH6Eq0ZWnosUogebCHR3v7GERP27MLQLakLeJRhOb8JHVMj
         Wmw7ujcJg3QRvNamfgJHHdkftd0wT0ZikrjMMD/IeSqICzWwj8Q1fUUFEyqzVQKQnWQf
         2tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tdQTRj4tn9tyIE0eFvqPGjSncUurrjE+KZhOiMRqlSw=;
        b=lZ7tAtvfXjdz0HzCLLZaUb4BXoB+URtJUo6AGoXS/jWLz5blAacyK9QWnyBrRAa7jZ
         jQDytq/7/vVsyS4/spmy9OT8Whu/Q/R/RJAmijQSFx4dWRFZPCKVcGpHWJJIj1rvbXRY
         hilbhTcD4Nl4vxMTONxxRqemEHESoBTx1w4sfAbORmxFhBrOhzfVtpMZsTeeOYSF00V8
         FJ8x+iU83zDohq1T4+q07TA4UDzyJZbg1O8lWSdojdHYAbm9X/J7QOmdBdCnk7m8QpFT
         QJ3T0AvKOK3hn7ya3wx7DAC6yAMaSZrWkV2380vH08T2NvR1EommUfTd3fMLWMMbC2z0
         YAbw==
X-Gm-Message-State: APjAAAWshR4F+rA9BInNEx89bMGGbSCtjLcLfUvRf5sdmgMS0aWRDlPs
        7ZmxA+2ujhG37y27ReDpwz4=
X-Google-Smtp-Source: APXvYqw+T0nTz7FZTNyYQa6PNva693dpOnOCsEbqHWCdz/moPGw+C0mwxoAvbsv8yhFmztTkZ4wv6Q==
X-Received: by 2002:a9d:4f15:: with SMTP id d21mr3172415otl.253.1580015804395;
        Sat, 25 Jan 2020 21:16:44 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b49sm1756561otc.6.2020.01.25.21.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 21:16:43 -0800 (PST)
Date:   Sat, 25 Jan 2020 22:16:42 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200126051642.GA39508@ubuntu-x2-xlarge-x86>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200124190625.257659-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124190625.257659-1-bgeffon@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Brian,

On Fri, Jan 24, 2020 at 11:06:25AM -0800, Brian Geffon wrote:
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. Instead it will be
> cleared as if a brand new anonymous, private mapping had been created
> atomically as part of the mremap() call.  If a userfaultfd was watching
> the source, it will continue to watch the new mapping.  For a mapping
> that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> mremap() call to fail. MREMAP_DONTUNMAP implies that MREMAP_FIXED is
> also used. The final result is two equally sized VMAs where the
> destination contains the PTEs of the source.
> 
> We hope to use this in Chrome OS where with userfaultfd we could write
> an anonymous mapping to disk without having to STOP the process or worry
> about VMA permission changes.
> 
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical
> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming
> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  include/uapi/linux/mman.h |  5 +++--
>  mm/mremap.c               | 37 ++++++++++++++++++++++++++++++-------
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index fc1a64c3447b..923cc162609c 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -5,8 +5,9 @@
>  #include <asm/mman.h>
>  #include <asm-generic/hugetlb_encode.h>
>  
> -#define MREMAP_MAYMOVE	1
> -#define MREMAP_FIXED	2
> +#define MREMAP_MAYMOVE		1
> +#define MREMAP_FIXED		2
> +#define MREMAP_DONTUNMAP	4
>  
>  #define OVERCOMMIT_GUESS		0
>  #define OVERCOMMIT_ALWAYS		1
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 122938dcec15..bf97c3eb538b 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -318,8 +318,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  static unsigned long move_vma(struct vm_area_struct *vma,
>  		unsigned long old_addr, unsigned long old_len,
>  		unsigned long new_len, unsigned long new_addr,
> -		bool *locked, struct vm_userfaultfd_ctx *uf,
> -		struct list_head *uf_unmap)
> +		bool *locked, unsigned long flags,
> +		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct vm_area_struct *new_vma;
> @@ -408,6 +408,13 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (unlikely(vma->vm_flags & VM_PFNMAP))
>  		untrack_pfn_moved(vma);
>  
> +	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
> +		if (vm_flags & VM_ACCOUNT)
> +			vma->vm_flags |= VM_ACCOUNT;
> +
> +		goto out;
> +	}
> +
>  	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
>  		/* OOM: unable to split vma, just get accounts right */
>  		vm_unacct_memory(excess >> PAGE_SHIFT);
> @@ -422,6 +429,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  			vma->vm_next->vm_flags |= VM_ACCOUNT;
>  	}
>  
> +out:
>  	if (vm_flags & VM_LOCKED) {
>  		mm->locked_vm += new_len >> PAGE_SHIFT;
>  		*locked = true;
> @@ -497,7 +505,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  
>  static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		unsigned long new_addr, unsigned long new_len, bool *locked,
> -		struct vm_userfaultfd_ctx *uf,
> +		unsigned long flags, struct vm_userfaultfd_ctx *uf,
>  		struct list_head *uf_unmap_early,
>  		struct list_head *uf_unmap)
>  {
> @@ -545,6 +553,17 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		old_len = new_len;
>  	}
>  
> +	/*
> +	 * MREMAP_DONTUNMAP expands by old_len + (new_len - old_len), we will
> +	 * check that we can expand by old_len and vma_to_resize will handle
> +	 * the vma growing.
> +	 */
> +	if (unlikely(flags & MREMAP_DONTUNMAP && !may_expand_vm(mm,
> +				vma->vm_flags, old_len >> PAGE_SHIFT))) {

We received a Clang build report that vma is used uninitialized here
(they aren't being publicly sent to LKML due to GCC vs Clang
warning/error overlap):

https://groups.google.com/d/msg/clang-built-linux/gE5wRaeHdSI/xVA0MBQVEgAJ

Sure enough, vma is initialized first in the next block. Not sure if
this section should be moved below that initialization or if something
else should be done to resolve it but that dereference will obviously be
fatal.

Cheers,
Nathan

> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	vma = vma_to_resize(addr, old_len, new_len, &charged);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
> @@ -561,7 +580,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if (IS_ERR_VALUE(ret))
>  		goto out1;
>  
> -	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, uf,
> +	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
>  		       uf_unmap);
>  	if (!(offset_in_page(ret)))
>  		goto out;
> @@ -609,12 +628,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	addr = untagged_addr(addr);
>  	new_addr = untagged_addr(new_addr);
>  
> -	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
> +	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
>  		return ret;
>  
>  	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
>  		return ret;
>  
> +	if (flags & MREMAP_DONTUNMAP && !(flags & MREMAP_FIXED))
> +		return ret;
> +
>  	if (offset_in_page(addr))
>  		return ret;
>  
> @@ -634,7 +656,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  
>  	if (flags & MREMAP_FIXED) {
>  		ret = mremap_to(addr, old_len, new_addr, new_len,
> -				&locked, &uf, &uf_unmap_early, &uf_unmap);
> +				&locked, flags, &uf, &uf_unmap_early,
> +				&uf_unmap);
>  		goto out;
>  	}
>  
> @@ -712,7 +735,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		}
>  
>  		ret = move_vma(vma, addr, old_len, new_len, new_addr,
> -			       &locked, &uf, &uf_unmap);
> +			       &locked, flags, &uf, &uf_unmap);
>  	}
>  out:
>  	if (offset_in_page(ret)) {
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
