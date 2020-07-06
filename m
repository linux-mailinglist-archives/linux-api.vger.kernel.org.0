Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01564215CF3
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgGFRVU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 13:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgGFRVU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 6 Jul 2020 13:21:20 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 188D420720;
        Mon,  6 Jul 2020 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594056079;
        bh=HnBXNgi2qMQGGh+5sWPUWq04Tsq65N/aqIq2MmaYGEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yynfct9RCgwmmU1XhrFRra9IagOCufD4Px41dHNiova2I/xRUkMyXFOK0+joi7k94
         qIEWkpYeutLh46JhxonyGVN93bjvy18GdpD3nCIUr2rDqtq9Vp11u97as907YQv9Rb
         q/0QuRvezXKamERIQ9oqBX1fY0VUsllVziGet1Jc=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC PATCH v2 4/5] mm: secretmem: use PMD-size pages to amortize direct map fragmentation
Date:   Mon,  6 Jul 2020 20:20:50 +0300
Message-Id: <20200706172051.19465-5-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706172051.19465-1-rppt@kernel.org>
References: <20200706172051.19465-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Removing a PAGE_SIZE page from the direct map every time such page is
allocated for a secret memory mapping will cause severe fragmentation of
the direct map. This fragmentation can be reduced by using PMD-size pages
as a pool for small pages for secret memory mappings.

Add a gen_pool per secretmem inode and lazily populate this pool with
PMD-size pages.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/secretmem.c | 107 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 19 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index df8f8c958cc2..c6fcf6d76951 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -5,6 +5,7 @@
 #include <linux/memfd.h>
 #include <linux/printk.h>
 #include <linux/pagemap.h>
+#include <linux/genalloc.h>
 #include <linux/pseudo_fs.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
@@ -23,24 +24,66 @@
 #define SECRETMEM_UNCACHED	0x2
 
 struct secretmem_ctx {
+	struct gen_pool *pool;
 	unsigned int mode;
 };
 
-static struct page *secretmem_alloc_page(gfp_t gfp)
+static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 {
-	/*
-	 * FIXME: use a cache of large pages to reduce the direct map
-	 * fragmentation
-	 */
-	return alloc_page(gfp);
+	unsigned long nr_pages = (1 << HPAGE_PMD_ORDER);
+	struct gen_pool *pool = ctx->pool;
+	unsigned long addr;
+	struct page *page;
+	int err;
+
+	page = alloc_pages(gfp, HPAGE_PMD_ORDER);
+	if (!page)
+		return -ENOMEM;
+
+	addr = (unsigned long)page_address(page);
+	split_page(page, HPAGE_PMD_ORDER);
+
+	err = gen_pool_add(pool, addr, HPAGE_PMD_SIZE, NUMA_NO_NODE);
+	if (err) {
+		__free_pages(page, HPAGE_PMD_ORDER);
+		return err;
+	}
+
+	__kernel_map_pages(page, nr_pages, 0);
+
+	return 0;
+}
+
+static struct page *secretmem_alloc_page(struct secretmem_ctx *ctx,
+					 gfp_t gfp)
+{
+	struct gen_pool *pool = ctx->pool;
+	unsigned long addr;
+	struct page *page;
+	int err;
+
+	if (gen_pool_avail(pool) < PAGE_SIZE) {
+		err = secretmem_pool_increase(ctx, gfp);
+		if (err)
+			return NULL;
+	}
+
+	addr = gen_pool_alloc(pool, PAGE_SIZE);
+	if (!addr)
+		return NULL;
+
+	page = virt_to_page(addr);
+	get_page(page);
+
+	return page;
 }
 
 static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 {
+	struct secretmem_ctx *ctx = vmf->vma->vm_file->private_data;
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	pgoff_t offset = vmf->pgoff;
-	unsigned long addr;
 	struct page *page;
 	int ret = 0;
 
@@ -49,7 +92,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 
 	page = find_get_entry(mapping, offset);
 	if (!page) {
-		page = secretmem_alloc_page(vmf->gfp_mask);
+		page = secretmem_alloc_page(ctx, vmf->gfp_mask);
 		if (!page)
 			return vmf_error(-ENOMEM);
 
@@ -57,14 +100,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		if (unlikely(ret))
 			goto err_put_page;
 
-		ret = set_direct_map_invalid_noflush(page);
-		if (ret)
-			goto err_del_page_cache;
-
-		addr = (unsigned long)page_address(page);
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-
 		__SetPageUptodate(page);
+		set_page_private(page, (unsigned long)ctx);
 
 		ret = VM_FAULT_LOCKED;
 	}
@@ -72,8 +109,6 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 	vmf->page = page;
 	return ret;
 
-err_del_page_cache:
-	delete_from_page_cache(page);
 err_put_page:
 	put_page(page);
 	return vmf_error(ret);
@@ -155,7 +190,11 @@ static int secretmem_migratepage(struct address_space *mapping,
 
 static void secretmem_freepage(struct page *page)
 {
-	set_direct_map_default_noflush(page);
+	unsigned long addr = (unsigned long)page_address(page);
+	struct secretmem_ctx *ctx = (struct secretmem_ctx *)page_private(page);
+	struct gen_pool *pool = ctx->pool;
+
+	gen_pool_free(pool, addr, PAGE_SIZE);
 }
 
 static const struct address_space_operations secretmem_aops = {
@@ -179,13 +218,18 @@ struct file *secretmem_file_create(const char *name, unsigned int flags)
 	if (!ctx)
 		goto err_free_inode;
 
+	ctx->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!ctx->pool)
+		goto err_free_ctx;
+
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
-		goto err_free_ctx;
+		goto err_free_pool;
 
 	mapping_set_unevictable(inode->i_mapping);
 
+	inode->i_private = ctx;
 	inode->i_mapping->private_data = ctx;
 	inode->i_mapping->a_ops = &secretmem_aops;
 
@@ -197,6 +241,8 @@ struct file *secretmem_file_create(const char *name, unsigned int flags)
 
 	return file;
 
+err_free_pool:
+	gen_pool_destroy(ctx->pool);
 err_free_ctx:
 	kfree(ctx);
 err_free_inode:
@@ -204,11 +250,34 @@ struct file *secretmem_file_create(const char *name, unsigned int flags)
 	return file;
 }
 
+static void secretmem_cleanup_chunk(struct gen_pool *pool,
+				    struct gen_pool_chunk *chunk, void *data)
+{
+	unsigned long start = chunk->start_addr;
+	unsigned long end = chunk->end_addr;
+	unsigned long nr_pages, addr;
+
+	nr_pages = (end - start + 1) / PAGE_SIZE;
+	__kernel_map_pages(virt_to_page(start), nr_pages, 1);
+
+	for (addr = start; addr < end; addr += PAGE_SIZE)
+		put_page(virt_to_page(addr));
+}
+
+static void secretmem_cleanup_pool(struct secretmem_ctx *ctx)
+{
+	struct gen_pool *pool = ctx->pool;
+
+	gen_pool_for_each_chunk(pool, secretmem_cleanup_chunk, ctx);
+	gen_pool_destroy(pool);
+}
+
 static void secretmem_evict_inode(struct inode *inode)
 {
 	struct secretmem_ctx *ctx = inode->i_private;
 
 	truncate_inode_pages_final(&inode->i_data);
+	secretmem_cleanup_pool(ctx);
 	clear_inode(inode);
 	kfree(ctx);
 }
-- 
2.26.2

