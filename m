Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C38215CF5
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 19:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgGFRVZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 13:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgGFRVZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 6 Jul 2020 13:21:25 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063D120722;
        Mon,  6 Jul 2020 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594056084;
        bh=KWxR6mRU/GFOXIHUDBV7Fo+VmYibiF7rALXmdUu7XHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVD7dRWjMXMMZFvE4ZL1idqQBVWov9lTmPqkY4r/8GpnlrqsGrRYbvvh6+GDkqUmC
         wMdUhTIqKbrJyUHQuvEk7Ti6pcMUF9eBvhKlDQh98freJVZrrPomDkfF7GmYbpXZqz
         V6Ziz0964HsWhgTNtGNx2C1nuae+TOz44EGUTESQ=
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
Subject: [RFC PATCH v2 5/5] mm: secretmem: add ability to reserve memory at boot
Date:   Mon,  6 Jul 2020 20:20:51 +0300
Message-Id: <20200706172051.19465-6-rppt@kernel.org>
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

Taking pages out from the direct map and bringing them back may create
undesired fragmentation and usage of the smaller pages in the direct
mapping of the physical memory.

This can be avoided if a significantly large area of the physical memory
would be reserved for secretmem purposes at boot time.

Add ability to reserve physical memory for secretmem at boot time using
"secretmem" kernel parameter and then use that reserved memory as a global
pool for secret memory needs.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/secretmem.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 137 insertions(+), 8 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index c6fcf6d76951..d50ac9ea1844 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -6,6 +6,8 @@
 #include <linux/printk.h>
 #include <linux/pagemap.h>
 #include <linux/genalloc.h>
+#include <linux/memblock.h>
+#include <linux/mm_inline.h>
 #include <linux/pseudo_fs.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
@@ -28,6 +30,39 @@ struct secretmem_ctx {
 	unsigned int mode;
 };
 
+struct secretmem_pool {
+	struct gen_pool *pool;
+	unsigned long reserved_size;
+	void *reserved;
+};
+
+static struct secretmem_pool secretmem_pool;
+
+static struct page *secretmem_alloc_huge_page(gfp_t gfp)
+{
+	struct gen_pool *pool = secretmem_pool.pool;
+	unsigned long addr = 0;
+	struct page *page = NULL;
+
+	if (pool) {
+		if (gen_pool_avail(pool) < HPAGE_PMD_SIZE)
+			return NULL;
+
+		addr = gen_pool_alloc(pool, HPAGE_PMD_SIZE);
+		if (!addr)
+			return NULL;
+
+		page = virt_to_page(addr);
+	} else {
+		page = alloc_pages(gfp, HPAGE_PMD_ORDER);
+
+		if (page)
+			split_page(page, HPAGE_PMD_ORDER);
+	}
+
+	return page;
+}
+
 static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 {
 	unsigned long nr_pages = (1 << HPAGE_PMD_ORDER);
@@ -36,12 +71,11 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 	struct page *page;
 	int err;
 
-	page = alloc_pages(gfp, HPAGE_PMD_ORDER);
+	page = secretmem_alloc_huge_page(gfp);
 	if (!page)
 		return -ENOMEM;
 
 	addr = (unsigned long)page_address(page);
-	split_page(page, HPAGE_PMD_ORDER);
 
 	err = gen_pool_add(pool, addr, HPAGE_PMD_SIZE, NUMA_NO_NODE);
 	if (err) {
@@ -250,11 +284,23 @@ struct file *secretmem_file_create(const char *name, unsigned int flags)
 	return file;
 }
 
-static void secretmem_cleanup_chunk(struct gen_pool *pool,
-				    struct gen_pool_chunk *chunk, void *data)
+static void secretmem_recycle_range(unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		struct page *page = virt_to_page(addr);
+		struct lruvec *lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+
+		__ClearPageLRU(page);
+		del_page_from_lru_list(page, lruvec, page_off_lru(page));
+	}
+
+	gen_pool_free(secretmem_pool.pool, start, HPAGE_PMD_SIZE);
+}
+
+static void secretmem_release_range(unsigned long start, unsigned long end)
 {
-	unsigned long start = chunk->start_addr;
-	unsigned long end = chunk->end_addr;
 	unsigned long nr_pages, addr;
 
 	nr_pages = (end - start + 1) / PAGE_SIZE;
@@ -264,6 +310,18 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
 		put_page(virt_to_page(addr));
 }
 
+static void secretmem_cleanup_chunk(struct gen_pool *pool,
+				    struct gen_pool_chunk *chunk, void *data)
+{
+	unsigned long start = chunk->start_addr;
+	unsigned long end = chunk->end_addr;
+
+	if (secretmem_pool.pool)
+		secretmem_recycle_range(start, end);
+	else
+		secretmem_release_range(start, end);
+}
+
 static void secretmem_cleanup_pool(struct secretmem_ctx *ctx)
 {
 	struct gen_pool *pool = ctx->pool;
@@ -303,14 +361,85 @@ static struct file_system_type secretmem_fs = {
 	.kill_sb	= kill_anon_super,
 };
 
+static int secretmem_reserved_mem_init(void)
+{
+	struct gen_pool *pool;
+	struct page *page;
+	void *addr;
+	int err;
+
+	if (!secretmem_pool.reserved)
+		return 0;
+
+	pool = gen_pool_create(PMD_SHIFT, NUMA_NO_NODE);
+	if (!pool)
+		return -ENOMEM;
+
+	err = gen_pool_add(pool, (unsigned long)secretmem_pool.reserved,
+			   secretmem_pool.reserved_size, NUMA_NO_NODE);
+	if (err)
+		goto err_destroy_pool;
+
+	for (addr = secretmem_pool.reserved;
+	     addr < secretmem_pool.reserved + secretmem_pool.reserved_size;
+	     addr += PAGE_SIZE) {
+		page = virt_to_page(addr);
+		__ClearPageReserved(page);
+		set_page_count(page, 1);
+	}
+
+	secretmem_pool.pool = pool;
+	page = virt_to_page(secretmem_pool.reserved);
+	__kernel_map_pages(page, secretmem_pool.reserved_size / PAGE_SIZE, 0);
+	return 0;
+
+err_destroy_pool:
+	gen_pool_destroy(pool);
+	return err;
+}
+
 static int secretmem_init(void)
 {
-	int ret = 0;
+	int ret;
+
+	ret = secretmem_reserved_mem_init();
+	if (ret)
+		return ret;
 
 	secretmem_mnt = kern_mount(&secretmem_fs);
-	if (IS_ERR(secretmem_mnt))
+	if (IS_ERR(secretmem_mnt)) {
+		gen_pool_destroy(secretmem_pool.pool);
 		ret = PTR_ERR(secretmem_mnt);
+	}
 
 	return ret;
 }
 fs_initcall(secretmem_init);
+
+static int __init secretmem_setup(char *str)
+{
+	phys_addr_t align = HPAGE_PMD_SIZE;
+	unsigned long reserved_size;
+	void *reserved;
+
+	reserved_size = memparse(str, NULL);
+	if (!reserved_size)
+		return 0;
+
+	if (reserved_size * 2 > HPAGE_PUD_SIZE)
+		align = HPAGE_PUD_SIZE;
+
+	reserved = memblock_alloc(reserved_size, align);
+	if (!reserved) {
+		pr_err("failed to reserve %zu bytes\n", secretmem_pool.reserved_size);
+		return 0;
+	}
+
+	secretmem_pool.reserved_size = reserved_size;
+	secretmem_pool.reserved = reserved;
+
+	pr_info("reserved %zuM\n", reserved_size >> 20);
+
+	return 1;
+}
+__setup("secretmem=", secretmem_setup);
-- 
2.26.2

