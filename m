Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C96C21D477
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2020 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgGMLFG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgGMLFF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jul 2020 07:05:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331BC061755
        for <linux-api@vger.kernel.org>; Mon, 13 Jul 2020 04:05:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so7109899ljc.5
        for <linux-api@vger.kernel.org>; Mon, 13 Jul 2020 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMyl+DQ3wUP7LyKaQbtUTzhYmTGh5/AfbpvUJG7a5ls=;
        b=Rft6X8JySjAdtd8ZOqc7q3dmZuvgmr8DFADHx4kiiR5QLdP+cYAFgjzxpv9jXjGaMT
         16qsX4EokaeT5nTzhJYUCsQN842um+qnbYEvSe4UL2IVaTfwqkdEx4Fufaw51nGKkTD1
         YUiskzdo9+ctPgxalAEkxvKKMWclza+LxK7nDzAOielTwLjnXmaRikhQoinT55jwg4AV
         XxErdNivqlj6Ey/nH/81snWWP+HJFxFVGNs2Uxpium4lRpIiWep46QsPda1zGtkDY4X9
         WRc0tms2iD9qOByTwiwwHuQ6D5FIuVR4SlqUdRJmsnNHB9Z4KrF/sJeMDAzSYK+cDhnV
         7hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMyl+DQ3wUP7LyKaQbtUTzhYmTGh5/AfbpvUJG7a5ls=;
        b=oxXHArI62Fr1MNJXoOnpmQfT9ogwt2ZM6ESwlqdKRn87LqELaBunMzUPu0NDLrkmQn
         Faf5QWnDH3Oj5VlWJEqteIrao0cxos592WUPiaqukKTZ7fmmjKkGh2TXGYeTSkwhgtlT
         bnxqK7EiSWIlHx9xu8Ne8TLombd+oQjNyBrirdk1yVlyUhDkMOx3ImLv4MToCUxJLiI2
         E/G+/3auoVEU4qoUviqRLCn+38w00ubvmucCjDrDHE8QaIyu3jZmThNm8CGMOzBhMLZr
         y9cmdmFLv8OpURR2A0K2li1fREKE/zvSIf+0D6mmgDBBiSChwqWOAMJphneY1lwCnOPs
         lV6w==
X-Gm-Message-State: AOAM531H1IlFWFEFMWdqwRaXsgsg9i5kSOewT5Rlz1eo57TIA21LrqJk
        TtWfdV7S9oOisCwGhFp6CqnRUg==
X-Google-Smtp-Source: ABdhPJzjw22IqhxfcTvaIWH79wsfmKt8zy/aiPeEIyBjc4mZCobpKUuUpBlhDZ+mM6Rj+7J3gdc1Pw==
X-Received: by 2002:a2e:9a47:: with SMTP id k7mr36682076ljj.96.1594638303344;
        Mon, 13 Jul 2020 04:05:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h18sm3997783lji.136.2020.07.13.04.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:05:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id DB3B71018FF; Mon, 13 Jul 2020 14:05:05 +0300 (+03)
Date:   Mon, 13 Jul 2020 14:05:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH v2 4/5] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200713110505.mesvinqjbj7imsdz@box>
References: <20200706172051.19465-1-rppt@kernel.org>
 <20200706172051.19465-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706172051.19465-5-rppt@kernel.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 06, 2020 at 08:20:50PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Removing a PAGE_SIZE page from the direct map every time such page is
> allocated for a secret memory mapping will cause severe fragmentation of
> the direct map. This fragmentation can be reduced by using PMD-size pages
> as a pool for small pages for secret memory mappings.
> 
> Add a gen_pool per secretmem inode and lazily populate this pool with
> PMD-size pages.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/secretmem.c | 107 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 88 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index df8f8c958cc2..c6fcf6d76951 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -5,6 +5,7 @@
>  #include <linux/memfd.h>
>  #include <linux/printk.h>
>  #include <linux/pagemap.h>
> +#include <linux/genalloc.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/set_memory.h>
>  #include <linux/sched/signal.h>
> @@ -23,24 +24,66 @@
>  #define SECRETMEM_UNCACHED	0x2
>  
>  struct secretmem_ctx {
> +	struct gen_pool *pool;
>  	unsigned int mode;
>  };
>  
> -static struct page *secretmem_alloc_page(gfp_t gfp)
> +static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  {
> -	/*
> -	 * FIXME: use a cache of large pages to reduce the direct map
> -	 * fragmentation
> -	 */
> -	return alloc_page(gfp);
> +	unsigned long nr_pages = (1 << HPAGE_PMD_ORDER);
> +	struct gen_pool *pool = ctx->pool;
> +	unsigned long addr;
> +	struct page *page;
> +	int err;
> +
> +	page = alloc_pages(gfp, HPAGE_PMD_ORDER);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	addr = (unsigned long)page_address(page);
> +	split_page(page, HPAGE_PMD_ORDER);
> +
> +	err = gen_pool_add(pool, addr, HPAGE_PMD_SIZE, NUMA_NO_NODE);
> +	if (err) {
> +		__free_pages(page, HPAGE_PMD_ORDER);
> +		return err;
> +	}
> +
> +	__kernel_map_pages(page, nr_pages, 0);

It's worth nothing that unlike flush_tlb_kernel_range(),
__kernel_map_pages() only flushed local TLB, so other CPU may still have
access to the page. It's shouldn't be a blocker, but deserve a comment.


> +
> +	return 0;
> +}
> +
> +static struct page *secretmem_alloc_page(struct secretmem_ctx *ctx,
> +					 gfp_t gfp)
> +{
> +	struct gen_pool *pool = ctx->pool;
> +	unsigned long addr;
> +	struct page *page;
> +	int err;
> +
> +	if (gen_pool_avail(pool) < PAGE_SIZE) {
> +		err = secretmem_pool_increase(ctx, gfp);
> +		if (err)
> +			return NULL;
> +	}
> +
> +	addr = gen_pool_alloc(pool, PAGE_SIZE);
> +	if (!addr)
> +		return NULL;
> +
> +	page = virt_to_page(addr);
> +	get_page(page);
> +
> +	return page;
>  }
>  
>  static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  {
> +	struct secretmem_ctx *ctx = vmf->vma->vm_file->private_data;
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	pgoff_t offset = vmf->pgoff;
> -	unsigned long addr;
>  	struct page *page;
>  	int ret = 0;
>  
> @@ -49,7 +92,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  
>  	page = find_get_entry(mapping, offset);
>  	if (!page) {
> -		page = secretmem_alloc_page(vmf->gfp_mask);
> +		page = secretmem_alloc_page(ctx, vmf->gfp_mask);
>  		if (!page)
>  			return vmf_error(-ENOMEM);
>  
> @@ -57,14 +100,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  		if (unlikely(ret))
>  			goto err_put_page;
>  
> -		ret = set_direct_map_invalid_noflush(page);
> -		if (ret)
> -			goto err_del_page_cache;
> -
> -		addr = (unsigned long)page_address(page);
> -		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -
>  		__SetPageUptodate(page);
> +		set_page_private(page, (unsigned long)ctx);
>  
>  		ret = VM_FAULT_LOCKED;
>  	}
> @@ -72,8 +109,6 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  	vmf->page = page;
>  	return ret;
>  
> -err_del_page_cache:
> -	delete_from_page_cache(page);
>  err_put_page:
>  	put_page(page);
>  	return vmf_error(ret);
> @@ -155,7 +190,11 @@ static int secretmem_migratepage(struct address_space *mapping,
>  
>  static void secretmem_freepage(struct page *page)
>  {
> -	set_direct_map_default_noflush(page);
> +	unsigned long addr = (unsigned long)page_address(page);
> +	struct secretmem_ctx *ctx = (struct secretmem_ctx *)page_private(page);
> +	struct gen_pool *pool = ctx->pool;
> +
> +	gen_pool_free(pool, addr, PAGE_SIZE);
>  }
>  
>  static const struct address_space_operations secretmem_aops = {
> @@ -179,13 +218,18 @@ struct file *secretmem_file_create(const char *name, unsigned int flags)
>  	if (!ctx)
>  		goto err_free_inode;
>  
> +	ctx->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!ctx->pool)
> +		goto err_free_ctx;
> +
>  	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
>  				 O_RDWR, &secretmem_fops);
>  	if (IS_ERR(file))
> -		goto err_free_ctx;
> +		goto err_free_pool;
>  
>  	mapping_set_unevictable(inode->i_mapping);
>  
> +	inode->i_private = ctx;
>  	inode->i_mapping->private_data = ctx;
>  	inode->i_mapping->a_ops = &secretmem_aops;
>  
> @@ -197,6 +241,8 @@ struct file *secretmem_file_create(const char *name, unsigned int flags)
>  
>  	return file;
>  
> +err_free_pool:
> +	gen_pool_destroy(ctx->pool);
>  err_free_ctx:
>  	kfree(ctx);
>  err_free_inode:
> @@ -204,11 +250,34 @@ struct file *secretmem_file_create(const char *name, unsigned int flags)
>  	return file;
>  }
>  
> +static void secretmem_cleanup_chunk(struct gen_pool *pool,
> +				    struct gen_pool_chunk *chunk, void *data)
> +{
> +	unsigned long start = chunk->start_addr;
> +	unsigned long end = chunk->end_addr;
> +	unsigned long nr_pages, addr;
> +
> +	nr_pages = (end - start + 1) / PAGE_SIZE;
> +	__kernel_map_pages(virt_to_page(start), nr_pages, 1);
> +
> +	for (addr = start; addr < end; addr += PAGE_SIZE)
> +		put_page(virt_to_page(addr));
> +}
> +
> +static void secretmem_cleanup_pool(struct secretmem_ctx *ctx)
> +{
> +	struct gen_pool *pool = ctx->pool;
> +
> +	gen_pool_for_each_chunk(pool, secretmem_cleanup_chunk, ctx);
> +	gen_pool_destroy(pool);
> +}
> +
>  static void secretmem_evict_inode(struct inode *inode)
>  {
>  	struct secretmem_ctx *ctx = inode->i_private;
>  
>  	truncate_inode_pages_final(&inode->i_data);
> +	secretmem_cleanup_pool(ctx);
>  	clear_inode(inode);
>  	kfree(ctx);
>  }
> -- 
> 2.26.2
> 

-- 
 Kirill A. Shutemov
