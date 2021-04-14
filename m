Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3935EDBE
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhDNGvw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 02:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349406AbhDNGvv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 02:51:51 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D1C061756
        for <linux-api@vger.kernel.org>; Tue, 13 Apr 2021 23:51:30 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dp18so4754768qvb.5
        for <linux-api@vger.kernel.org>; Tue, 13 Apr 2021 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KLZzVXsHHgJTPi9/Y2IIbzvR3FePP4MCJ3ecMxx4dqc=;
        b=JL6hA6+QcQLMoXUbtqIdHUyo2NzJQBbZYzeHvrGRShfPChqWNdglR38HGeljB2fxtP
         M/EB8Cp4oGJ5EKc4EqKIx/b+me/Kc6zIFiWhY/5nvoWnDAVJyyAvnJbQ/cSo7mLxmdN/
         HI/+hYSkQsHt+TP8W1gHJr+SoC5GGpvSZLOSR9POOCRR3SR8+oVVKxMymufxPxTpC2nC
         +sMBHPpf81IfgL4N10W+2rFzsZ2vyOHFMVCeGYwQ+Sz0l0IsXp+v4eutMkcd/rzhXdvy
         4h2kM4L1NjPbWvhMXaxD87NF550bFO546K5O4RrXtIXNxcXA2+SCnR9IrB2TA7oxqgiJ
         mg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KLZzVXsHHgJTPi9/Y2IIbzvR3FePP4MCJ3ecMxx4dqc=;
        b=pqN8SMGdQqrvtBnSzGNNGfcCl0+uN39fzw/F1lf/8YBV3kDil6hNCICn8G8ctynk9o
         yZm4osx2N4iu/lhIroI1qfwwfIJ0Q2DIAIQvMIPqpQwYmSKuPovHcSnzpp9o0xkeP0L8
         TBej53YLB3O+7UJvyg7CGQzfgOg2CPIKiK056Y2kiUWp+Sy5Tg6lk6+ADuq/N9pihpez
         D7/T8A7zEqO/KGk/b5z5C8rONCYF9EOAt8HnhAe/iL1dvH6noAs6G6i2Ky4oN8qTfXqD
         c004wwrt/zJfywuHpTIJSe9GW349W/jASx8nGHoVymo4PQI15x8oTHuwQnTOo0INhL2j
         0pjg==
X-Gm-Message-State: AOAM531RrWZ7u+35KQpKOEo4toWUIYZcOMI/VLNL8CVUznhRi396ptLF
        k4V0DyJRjrKMqO3fgLR7Q7SQlQ==
X-Google-Smtp-Source: ABdhPJxmAr7PP6sm3oGIRXGR/ODKnISgo8n9Q9oaRuJpnITPKeqa2LTT9fH+Z1Hu79UBjol+6eJo9A==
X-Received: by 2002:a05:6214:f6c:: with SMTP id iy12mr24408311qvb.15.1618383089927;
        Tue, 13 Apr 2021 23:51:29 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x22sm5183213qtq.93.2021.04.13.23.51.27
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 13 Apr 2021 23:51:29 -0700 (PDT)
Date:   Tue, 13 Apr 2021 23:51:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 2/9] userfaultfd/shmem: combine
 shmem_{mcopy_atomic,mfill_zeropage}_pte
In-Reply-To: <20210413051721.2896915-3-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104132344120.9086@eggly.anvils>
References: <20210413051721.2896915-1-axelrasmussen@google.com> <20210413051721.2896915-3-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 12 Apr 2021, Axel Rasmussen wrote:

> Previously, we did a dance where we had one calling path in
> userfaultfd.c (mfill_atomic_pte), but then we split it into two in
> shmem_fs.h (shmem_{mcopy_atomic,mfill_zeropage}_pte), and then rejoined
> into a single shared function in shmem.c (shmem_mfill_atomic_pte).
> 
> This is all a bit overly complex. Just call the single combined shmem
> function directly, allowing us to clean up various branches,
> boilerplate, etc.
> 
> While we're touching this function, two other small cleanup changes:
> - offset is equivalent to pgoff, so we can get rid of offset entirely.
> - Split two VM_BUG_ON cases into two statements. This means the line
>   number reported when the BUG is hit specifies exactly which condition
>   was true.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>
though you've dropped one minor fix I did like, see below...

> ---
>  include/linux/shmem_fs.h | 15 +++++-------
>  mm/shmem.c               | 52 +++++++++++++---------------------------
>  mm/userfaultfd.c         | 10 +++-----
>  3 files changed, 25 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index d82b6f396588..919e36671fe6 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -122,21 +122,18 @@ static inline bool shmem_file(struct file *file)
>  extern bool shmem_charge(struct inode *inode, long pages);
>  extern void shmem_uncharge(struct inode *inode, long pages);
>  
> +#ifdef CONFIG_USERFAULTFD
>  #ifdef CONFIG_SHMEM
>  extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  				  struct vm_area_struct *dst_vma,
>  				  unsigned long dst_addr,
>  				  unsigned long src_addr,
> +				  bool zeropage,
>  				  struct page **pagep);
> -extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
> -				    pmd_t *dst_pmd,
> -				    struct vm_area_struct *dst_vma,
> -				    unsigned long dst_addr);
> -#else
> +#else /* !CONFIG_SHMEM */
>  #define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \

In a previous version, you quietly corrected that "dst_pte" to "dst_pmd":
of course it makes no difference to the code generated, but it was a good
correction, helping to prevent confusion.

> -			       src_addr, pagep)        ({ BUG(); 0; })
> -#define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
> -				 dst_addr)      ({ BUG(); 0; })
> -#endif
> +			       src_addr, zeropage, pagep)       ({ BUG(); 0; })
> +#endif /* CONFIG_SHMEM */
> +#endif /* CONFIG_USERFAULTFD */
>  
>  #endif
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..b72c55aa07fc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2354,13 +2354,14 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>  	return inode;
>  }
>  
> -static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> -				  pmd_t *dst_pmd,
> -				  struct vm_area_struct *dst_vma,
> -				  unsigned long dst_addr,
> -				  unsigned long src_addr,
> -				  bool zeropage,
> -				  struct page **pagep)
> +#ifdef CONFIG_USERFAULTFD
> +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> +			   pmd_t *dst_pmd,
> +			   struct vm_area_struct *dst_vma,
> +			   unsigned long dst_addr,
> +			   unsigned long src_addr,
> +			   bool zeropage,
> +			   struct page **pagep)
>  {
>  	struct inode *inode = file_inode(dst_vma->vm_file);
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> @@ -2372,7 +2373,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	struct page *page;
>  	pte_t _dst_pte, *dst_pte;
>  	int ret;
> -	pgoff_t offset, max_off;
> +	pgoff_t max_off;
>  
>  	ret = -ENOMEM;
>  	if (!shmem_inode_acct_block(inode, 1))
> @@ -2383,7 +2384,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  		if (!page)
>  			goto out_unacct_blocks;
>  
> -		if (!zeropage) {	/* mcopy_atomic */
> +		if (!zeropage) {	/* COPY */
>  			page_kaddr = kmap_atomic(page);
>  			ret = copy_from_user(page_kaddr,
>  					     (const void __user *)src_addr,
> @@ -2397,7 +2398,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  				/* don't free the page */
>  				return -ENOENT;
>  			}
> -		} else {		/* mfill_zeropage_atomic */
> +		} else {		/* ZEROPAGE */
>  			clear_highpage(page);
>  		}
>  	} else {
> @@ -2405,15 +2406,15 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  		*pagep = NULL;
>  	}
>  
> -	VM_BUG_ON(PageLocked(page) || PageSwapBacked(page));
> +	VM_BUG_ON(PageLocked(page));
> +	VM_BUG_ON(PageSwapBacked(page));
>  	__SetPageLocked(page);
>  	__SetPageSwapBacked(page);
>  	__SetPageUptodate(page);
>  
>  	ret = -EFAULT;
> -	offset = linear_page_index(dst_vma, dst_addr);
>  	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> -	if (unlikely(offset >= max_off))
> +	if (unlikely(pgoff >= max_off))
>  		goto out_release;
>  
>  	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
> @@ -2439,7 +2440,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  
>  	ret = -EFAULT;
>  	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> -	if (unlikely(offset >= max_off))
> +	if (unlikely(pgoff >= max_off))
>  		goto out_release_unlock;
>  
>  	ret = -EEXIST;
> @@ -2476,28 +2477,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	shmem_inode_unacct_blocks(inode, 1);
>  	goto out;
>  }
> -
> -int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
> -			   pmd_t *dst_pmd,
> -			   struct vm_area_struct *dst_vma,
> -			   unsigned long dst_addr,
> -			   unsigned long src_addr,
> -			   struct page **pagep)
> -{
> -	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
> -				      dst_addr, src_addr, false, pagep);
> -}
> -
> -int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
> -			     pmd_t *dst_pmd,
> -			     struct vm_area_struct *dst_vma,
> -			     unsigned long dst_addr)
> -{
> -	struct page *page = NULL;
> -
> -	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
> -				      dst_addr, 0, true, &page);
> -}
> +#endif /* CONFIG_USERFAULTFD */
>  
>  #ifdef CONFIG_TMPFS
>  static const struct inode_operations shmem_symlink_inode_operations;
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e14b3820c6a8..23fa2583bbd1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -440,13 +440,9 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  						 dst_vma, dst_addr);
>  	} else {
>  		VM_WARN_ON_ONCE(wp_copy);
> -		if (!zeropage)
> -			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
> -						     dst_vma, dst_addr,
> -						     src_addr, page);
> -		else
> -			err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
> -						       dst_vma, dst_addr);
> +		err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> +					     dst_addr, src_addr, zeropage,
> +					     page);
>  	}
>  
>  	return err;
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 
> 
