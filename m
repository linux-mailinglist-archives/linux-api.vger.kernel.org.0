Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D07B15D972
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 15:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgBNO2h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 09:28:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40943 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgBNO2h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 09:28:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so10956779ljo.7
        for <linux-api@vger.kernel.org>; Fri, 14 Feb 2020 06:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AafOgySyVAzNy0c2ESmrKX2K4Va55RytPel0n9VaSzQ=;
        b=nHSn54izT9Msimbur8SPtDE3YxZvL5kxU+xWVBaAscT1fbbIdKw83O2OvwloH0I5n5
         QievxaE0p4d/SwFB2vQRyII4ea75N1wGlUVU+Lz/LHfbWA2V1szE4HxJYd2kjC+2BZq8
         GG+t4QpWHrn45qA0KMo1bmJh8LLBejR1KrE9+Ak9WENSGwHSA2NA/zJDDoqMpXOPKcue
         50nqBRxhURgBbPUVFCR8vSVNVBeG1J/qzsnprAYXmyUdSn/po4s8AuzezOSXe/1uresb
         WaIEZfm02srJijxWKIsw4BlIreBDeCVfxlU+6Y8EiX6SDr9MQAMucUSzX4j68bXil+Cm
         bSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AafOgySyVAzNy0c2ESmrKX2K4Va55RytPel0n9VaSzQ=;
        b=PhQZPUlp3a2McKEN8vBV++PI6+4Z8I+aWXirod4r8V0OVR27lP5HrKvN4UZwxhL/fv
         Nld7h9sSwVXTykiVeKeeeS3GNY/Xz4Y3kgqIbugOaqChmRTme+SRVzLlHfEyGmiw7QNi
         MTuzQ6UQbTkbT6w3geU1Lv7p9EBJ5zv1gC3gLcy8IRyTVETTmzggt13Mf5Y3emq29YHR
         LNEhJDKvBPzW/jPGqJJJyQ36sq65F3P6LlTSiKc05YNdzRBln+j0wZPp1vRjbHLLx5mA
         4PuFs1HXckoBofabHZQF8OPurW3Nr45MewtUoM3rLdNgvMo/UsTnIp77rLrbbqUX5juH
         myxQ==
X-Gm-Message-State: APjAAAUtSjbwB1j5Ct6UzCLRlakPDDoXm5hLIrnePFANZoNJSh9jP7Ni
        3Ty6i3Kp9i1awdHxAcBnrbScPg==
X-Google-Smtp-Source: APXvYqyNgbOD18Nh05jEbTbR/WGlDFR4IPYAZjI0gDO74z2U9weVu95HKeKUBL3KbdshfB+UFiX7cw==
X-Received: by 2002:a2e:860c:: with SMTP id a12mr2344290lji.146.1581690515304;
        Fri, 14 Feb 2020 06:28:35 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i1sm3594789lji.71.2020.02.14.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:28:34 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 37EF1100F30; Fri, 14 Feb 2020 17:28:57 +0300 (+03)
Date:   Fri, 14 Feb 2020 17:28:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
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
Subject: Re: [PATCH v5 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200214142857.kcmjiequhfl3sot2@box>
References: <20200207201856.46070-1-bgeffon@google.com>
 <20200214040952.43195-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214040952.43195-1-bgeffon@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 13, 2020 at 08:09:51PM -0800, Brian Geffon wrote:
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. The remap operation
> will be performed as it would have been normally by moving over the
> page tables to the new mapping. The old vma will have any locked
> flags cleared, have no pagetables, and any userfaultfds that were
> watching that range will continue watching it.
> 
> For a mapping that is shared or not anonymous, MREMAP_DONTUNMAP will cause
> the mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
> a VMA you MUST use the MREMAP_MAYMOVE flag. The final result is two
> equally sized VMAs where the destination contains the PTEs of the source.
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
>   v4 -> v5:
>     - Correct commit message to more accurately reflect the behavior.
>     - Clear VM_LOCKED and VM_LOCKEDONFAULT on the old vma.
>            
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> 
> ---
>  include/uapi/linux/mman.h |   5 +-
>  mm/mremap.c               | 106 ++++++++++++++++++++++++++++++--------
>  2 files changed, 88 insertions(+), 23 deletions(-)
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
> index 1fc8a29fbe3f..a2a792fdbc64 100644
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
> @@ -408,11 +408,49 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (unlikely(vma->vm_flags & VM_PFNMAP))
>  		untrack_pfn_moved(vma);
>  
> +	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
> +		if (vm_flags & VM_ACCOUNT) {
> +			/* Always put back VM_ACCOUNT since we won't unmap */
> +			vma->vm_flags |= VM_ACCOUNT;
> +
> +			vm_acct_memory(vma_pages(new_vma));
> +		}
> +
> +		/*
> +		 * locked_vm accounting: if the mapping remained the same size
> +		 * it will have just moved and we don't need to touch locked_vm
> +		 * because we skip the do_unmap. If the mapping shrunk before
> +		 * being moved then the do_unmap on that portion will have
> +		 * adjusted vm_locked. Only if the mapping grows do we need to
> +		 * do something special; the reason is locked_vm only accounts
> +		 * for old_len, but we're now adding new_len - old_len locked
> +		 * bytes to the new mapping.
> +		 */
> +		if (vm_flags & VM_LOCKED) {
> +			/* We always clear VM_LOCKED[ONFAULT] on the old vma */
> +			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
> +
> +			if (new_len > old_len) {
> +				mm->locked_vm +=
> +					(new_len - old_len) >> PAGE_SHIFT;
> +				*locked = true;

This level of code indentation suggests that code restructuring is
required.

> +			}
> +		}
> +
> +		goto out;
> +	}
> +
>  	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
>  		/* OOM: unable to split vma, just get accounts right */
>  		vm_unacct_memory(excess >> PAGE_SHIFT);
>  		excess = 0;
>  	}
> +
> +	if (vm_flags & VM_LOCKED) {
> +		mm->locked_vm += new_len >> PAGE_SHIFT;
> +		*locked = true;
> +	}

I don't follow why this is required.

> +out:
>  	mm->hiwater_vm = hiwater_vm;
>  
>  	/* Restore VM_ACCOUNT if one or two pieces of vma left */
> @@ -422,16 +460,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  			vma->vm_next->vm_flags |= VM_ACCOUNT;
>  	}
>  
> -	if (vm_flags & VM_LOCKED) {
> -		mm->locked_vm += new_len >> PAGE_SHIFT;
> -		*locked = true;
> -	}
> -

Ah. You moved this piece. Why?

>  	return new_addr;
>  }
>  
>  static struct vm_area_struct *vma_to_resize(unsigned long addr,
> -	unsigned long old_len, unsigned long new_len, unsigned long *p)
> +	unsigned long old_len, unsigned long new_len, unsigned long flags,
> +	unsigned long *p)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = find_vma(mm, addr);
> @@ -453,6 +487,10 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> +			vma->vm_flags & VM_SHARED))
> +		return ERR_PTR(-EINVAL);
> +
>  	if (is_vm_hugetlb_page(vma))
>  		return ERR_PTR(-EINVAL);
>  
> @@ -497,7 +535,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  
>  static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		unsigned long new_addr, unsigned long new_len, bool *locked,
> -		struct vm_userfaultfd_ctx *uf,
> +		unsigned long flags, struct vm_userfaultfd_ctx *uf,
>  		struct list_head *uf_unmap_early,
>  		struct list_head *uf_unmap)
>  {
> @@ -505,7 +543,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	struct vm_area_struct *vma;
>  	unsigned long ret = -EINVAL;
>  	unsigned long charged = 0;
> -	unsigned long map_flags;
> +	unsigned long map_flags = 0;
>  
>  	if (offset_in_page(new_addr))
>  		goto out;
> @@ -534,9 +572,11 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
>  		return -ENOMEM;
>  
> -	ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
> -	if (ret)
> -		goto out;
> +	if (flags & MREMAP_FIXED) {

I think it has to be

	if (!(flags & MREMAP_DONTUNMAP)) {

No?


> +		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	if (old_len >= new_len) {
>  		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
> @@ -545,13 +585,26 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		old_len = new_len;
>  	}
>  
> -	vma = vma_to_resize(addr, old_len, new_len, &charged);
> +	vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
>  		goto out;
>  	}
>  
> -	map_flags = MAP_FIXED;
> +	/*
> +	 * MREMAP_DONTUNMAP expands by new_len - (new_len - old_len), we will
> +	 * check that we can expand by new_len and vma_to_resize will handle
> +	 * the vma growing which is (new_len - old_len).
> +	 */
> +	if (flags & MREMAP_DONTUNMAP &&
> +		!may_expand_vm(mm, vma->vm_flags, new_len >> PAGE_SHIFT)) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (flags & MREMAP_FIXED)
> +		map_flags |= MAP_FIXED;
> +
>  	if (vma->vm_flags & VM_MAYSHARE)
>  		map_flags |= MAP_SHARED;
>  
> @@ -561,10 +614,16 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if (offset_in_page(ret))
>  		goto out1;
>  
> -	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, uf,
> +	/* We got a new mapping */
> +	if (!(flags & MREMAP_FIXED))
> +		new_addr = ret;
> +
> +	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
>  		       uf_unmap);
> +
>  	if (!(offset_in_page(ret)))
>  		goto out;
> +
>  out1:
>  	vm_unacct_memory(charged);
>  
> @@ -609,12 +668,16 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
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
> +	/* MREMAP_DONTUNMAP is always a move */
> +	if (flags & MREMAP_DONTUNMAP && !(flags & MREMAP_MAYMOVE))
> +		return ret;
> +
>  	if (offset_in_page(addr))
>  		return ret;
>  
> @@ -632,9 +695,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	if (down_write_killable(&current->mm->mmap_sem))
>  		return -EINTR;
>  
> -	if (flags & MREMAP_FIXED) {
> +	if (flags & MREMAP_FIXED || flags & MREMAP_DONTUNMAP) {

	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {

>  		ret = mremap_to(addr, old_len, new_addr, new_len,
> -				&locked, &uf, &uf_unmap_early, &uf_unmap);
> +				&locked, flags, &uf, &uf_unmap_early,
> +				&uf_unmap);
>  		goto out;
>  	}
>  
> @@ -662,7 +726,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	/*
>  	 * Ok, we need to grow..
>  	 */
> -	vma = vma_to_resize(addr, old_len, new_len, &charged);
> +	vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
>  		goto out;
> @@ -712,7 +776,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		}
>  
>  		ret = move_vma(vma, addr, old_len, new_len, new_addr,
> -			       &locked, &uf, &uf_unmap);
> +			       &locked, flags, &uf, &uf_unmap);
>  	}
>  out:
>  	if (offset_in_page(ret)) {
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

-- 
 Kirill A. Shutemov
