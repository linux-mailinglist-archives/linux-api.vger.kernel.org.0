Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7474716641F
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 18:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgBTRP7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 12:15:59 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52213 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgBTRP6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 12:15:58 -0500
Received: by mail-pj1-f67.google.com with SMTP id fa20so1144308pjb.1;
        Thu, 20 Feb 2020 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BdLnOLtpkZ7p2jNHIeXvc8PC8eB39stw8weuKrfaLvw=;
        b=Jy63nqupJJONuxc5srODyPvpnG54C01QB28GKJgbn9P7FU/5+QDgNv0Z+9KIJg2W9H
         kLu4melVM3wu/x8FzbH6VVwMziHdfNkBVRkTvZA1kn0zcixzM9zX1/nqVv6jvK2Ao3SB
         f7lsJeW1pwD0XblZH5zNFe08VuxqkUU6ceor0oIk0F616UXIJdL4z0W87KMisd3+kai3
         Un4S8nlUAgYgt8+Us1I01ZdSBU2jvF9G77J3VfEqsxv6/unJxIESduU6pvzNLikAx8yi
         T7OBGzjeN+v0yPLAq2bGLCzA6NpN6/hPDgmm9nN+KwuOoNowNf4TWZxmKb7qnip5eJA4
         S5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BdLnOLtpkZ7p2jNHIeXvc8PC8eB39stw8weuKrfaLvw=;
        b=TMxZ5Q2J+xjAje7yBgNLtFHDOX/DNXNp7RxzizMg5nGICpe8NeovRbnVwPJG3mqn80
         3F2w0qfRH3tLlQWJsr45HGNErc1ly4nkR5ng66y7GYQs6L9UIS8akvI3/Xb31YBMM5h8
         E+eeAJ7lNr8gMIw4QPS+7I2Nl56bZVrTWTYU55wYj71wQPIy6s405kGn6TKrTJ3zHtIM
         m8LwS0U+HQWOa2wVb+BmghIquAVKkzD5JKNSeAle5AxOmje+fpj4iFEpmpK6zmchHxi9
         Arut/EM+2xwzbIDOyr4b/eiQIhqgWZiE8cb+KxNgh9koMBCwlkjtflYdE5pH6UOPj4ut
         iIFw==
X-Gm-Message-State: APjAAAXygCsyaPOoO3zInAGgvZ9BEVrmf4RMwlp6ThcvN+oZ+q3a9m5R
        ltd/fy0IW0niLgLJQBVR3hs=
X-Google-Smtp-Source: APXvYqwjFKb+ro42DU1lcWBNDFRgH2E5i6ewtvz6fb5ueF6Yy0gri6H7Wdloa0ZzaKcVjgiepSUszA==
X-Received: by 2002:a17:90a:2808:: with SMTP id e8mr4788906pjd.63.1582218957870;
        Thu, 20 Feb 2020 09:15:57 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id v25sm155447pfe.147.2020.02.20.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:15:56 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:15:54 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200220171554.GA44866@google.com>
References: <20200218173221.237674-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200218173221.237674-1-bgeffon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 18, 2020 at 09:32:20AM -0800, Brian Geffon wrote:
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
>   v5 -> v6:
>     - Code cleanup suggested by Kirill.
> 
>   v4 -> v5:
>     - Correct commit message to more accurately reflect the behavior.
>     - Clear VM_LOCKED and VM_LOCKEDONFAULT on the old vma.
>            
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  include/uapi/linux/mman.h |   5 +-
>  mm/mremap.c               | 103 ++++++++++++++++++++++++++++++--------
>  2 files changed, 85 insertions(+), 23 deletions(-)
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
> index 1fc8a29fbe3f..fa27103502c5 100644
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
> @@ -408,11 +408,46 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
> +		if (vm_flags & VM_LOCKED && new_len > old_len) {
> +			mm->locked_vm += (new_len - old_len) >> PAGE_SHIFT;
> +			*locked = true;
> +		}
> +
> +		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
> +		vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
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
> +out:
>  	mm->hiwater_vm = hiwater_vm;
>  
>  	/* Restore VM_ACCOUNT if one or two pieces of vma left */
> @@ -422,16 +457,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  			vma->vm_next->vm_flags |= VM_ACCOUNT;
>  	}
>  
> -	if (vm_flags & VM_LOCKED) {
> -		mm->locked_vm += new_len >> PAGE_SHIFT;
> -		*locked = true;
> -	}
> -
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
> @@ -453,6 +484,10 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
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
> @@ -497,7 +532,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  
>  static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		unsigned long new_addr, unsigned long new_len, bool *locked,
> -		struct vm_userfaultfd_ctx *uf,
> +		unsigned long flags, struct vm_userfaultfd_ctx *uf,
>  		struct list_head *uf_unmap_early,
>  		struct list_head *uf_unmap)
>  {
> @@ -505,7 +540,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	struct vm_area_struct *vma;
>  	unsigned long ret = -EINVAL;
>  	unsigned long charged = 0;
> -	unsigned long map_flags;
> +	unsigned long map_flags = 0;
>  
>  	if (offset_in_page(new_addr))
>  		goto out;
> @@ -534,9 +569,11 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
>  		return -ENOMEM;
>  
> -	ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
> -	if (ret)
> -		goto out;
> +	if (flags & MREMAP_FIXED) {
> +		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	if (old_len >= new_len) {
>  		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);

So we remove old map here.

> @@ -545,13 +582,26 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		old_len = new_len;
>  	}
>  
> -	vma = vma_to_resize(addr, old_len, new_len, &charged);
> +	vma = vma_to_resize(addr, old_len, new_len, flags, &charged);

And here we got error if the addr is in non-anonymous-private vma so the
syscall will fail but old vma is gone? I guess it's not your intention?

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
> @@ -561,10 +611,16 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
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
> @@ -609,12 +665,16 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
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
> @@ -632,9 +692,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	if (down_write_killable(&current->mm->mmap_sem))
>  		return -EINTR;
>  
> -	if (flags & MREMAP_FIXED) {
> +	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
>  		ret = mremap_to(addr, old_len, new_addr, new_len,
> -				&locked, &uf, &uf_unmap_early, &uf_unmap);
> +				&locked, flags, &uf, &uf_unmap_early,
> +				&uf_unmap);
>  		goto out;
>  	}
>  
> @@ -662,7 +723,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	/*
>  	 * Ok, we need to grow..
>  	 */
> -	vma = vma_to_resize(addr, old_len, new_len, &charged);
> +	vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
>  		goto out;
> @@ -712,7 +773,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
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
