Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DC2D88D4
	for <lists+linux-api@lfdr.de>; Sat, 12 Dec 2020 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439618AbgLLR51 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Dec 2020 12:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436464AbgLLR51 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Dec 2020 12:57:27 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2EC0613CF;
        Sat, 12 Dec 2020 09:56:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id m25so19700927lfc.11;
        Sat, 12 Dec 2020 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pK/TauEwOQxjwMKh9S4vhOg5BDCl+TEdAralgbPgXms=;
        b=aukVNiw0MKku0nqBpuYaenetr6qzqZ2SZk7xS+AVbbG0DdWO6e9O7GAESr+p0RrhPW
         Py6ZQYc6Ifj47A3Z1giRxjGfEqI1AI8dR5xkBzrVc908UOKrGN2YE66MH3lynSc5+5Bo
         LL01huvcKfRfndHEi3xX9dK+0Em5+2m7Di0CyIbXVoTqzDfLrXFOuRG8dlH2H3VgCSgs
         MaqqVnwf8+aMzO2b61SgjThqBsA8phFJE81uqp53cqe/IPcv9+UsgTxzqoLUVV40k+5a
         OdTzUYORTvlld7Tj2+x1gQ+aKPUcZCI5G5slYVFACzx9Mve8JC0iaDR7N41Q62enF9gz
         Cmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pK/TauEwOQxjwMKh9S4vhOg5BDCl+TEdAralgbPgXms=;
        b=neXCKPR2uMp7e6juoocghuJN6vUS0lufuGOCKYI5hZmcYqDixYp0sSgo9qbtX5/lDj
         fTmtSYPVk5fdGymxG51Od0SqVBF8r9JLpF74oAJll+P0ZNDad5+QabT0j9GhsloPYls3
         Nhp2cGMAnfcDVtMblFeDY0AZ+FVQWMACn1EpGFQVCqIhJ8i7DStUD0XK+uXNrJR7QnQv
         iRNrbS/tGplwWu8iRXpKxY2mst4Y6kGPayJq/PXpOe/bv47wsZtuATRUz5PbZXKAfmr6
         XgidD2jNvU4wjgNQktuwTP4Xo2rj9aLExQu30jO4ZZjV1eqM9FGUVaVugMboZygfgVnb
         VoSA==
X-Gm-Message-State: AOAM532zyQw+B7XfQtM20HSQvuYNzFzZmLBwQtiKCPN/pQ9y2da40HMa
        W27blTQTl+IMI78ToQuaaJR9rYYUWa8=
X-Google-Smtp-Source: ABdhPJyE+QJMmowLy3ikdGLmYMZmOGXu61IyfrtCPMiyLL18flvhK4t1ZPDRNRSbRqobFtId5YSVZA==
X-Received: by 2002:a19:cb05:: with SMTP id b5mr6258564lfg.61.1607795804802;
        Sat, 12 Dec 2020 09:56:44 -0800 (PST)
Received: from localhost.localdomain (88-114-222-21.elisa-laajakaista.fi. [88.114.222.21])
        by smtp.gmail.com with ESMTPSA id w12sm1325418lff.181.2020.12.12.09.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 09:56:44 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2] mm/vmalloc: randomize vmalloc() allocations
Date:   Sat, 12 Dec 2020 19:56:35 +0200
Message-Id: <20201212175635.4217-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Memory mappings inside kernel allocated with vmalloc() are in
predictable order and packed tightly toward the low addresses. With
new kernel boot parameter 'randomize_vmalloc=1', the entire area is
used randomly to make the allocations less predictable and harder to
guess for attackers. Also module and BPF code locations get randomized
(within their dedicated and rather small area though) and if
CONFIG_VMAP_STACK is enabled, also kernel thread stack locations.

On 32 bit systems this may cause problems due to increased VM
fragmentation if the address space gets crowded.

On all systems, it will reduce performance and increase memory and
cache usage due to less efficient use of page tables and inability to
merge adjacent VMAs with compatible attributes. On x86_64 with 5 level
page tables, in the worst case, additional page table entries of up to
4 pages are created for each mapping, so with small mappings there's
considerable penalty.

Without randomize_vmalloc=1:
$ cat /proc/vmallocinfo
0xffffc90000000000-0xffffc90000002000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe1000 ioremap
0xffffc90000002000-0xffffc90000005000   12288 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe0000 ioremap
0xffffc90000005000-0xffffc90000007000    8192 hpet_enable+0x36/0x4a9 phys=0x00000000fed00000 ioremap
0xffffc90000007000-0xffffc90000009000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffc90000009000-0xffffc9000000b000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffc9000000b000-0xffffc9000000d000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffc9000000d000-0xffffc9000000f000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffc90000011000-0xffffc90000015000   16384 n_tty_open+0x16/0xe0 pages=3 vmalloc
0xffffc900003de000-0xffffc900003e0000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x00000000fed00000 ioremap
0xffffc900003e0000-0xffffc900003e2000    8192 memremap+0x1a1/0x280 phys=0x00000000000f5000 ioremap
0xffffc900003e2000-0xffffc900003f3000   69632 pcpu_create_chunk+0x80/0x2c0 pages=16 vmalloc
0xffffc900003f3000-0xffffc90000405000   73728 pcpu_create_chunk+0xb7/0x2c0 pages=17 vmalloc
0xffffc90000405000-0xffffc9000040a000   20480 pcpu_create_chunk+0xed/0x2c0 pages=4 vmalloc
0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x1a40 vmalloc

With randomize_vmalloc=1, the allocations are randomized:
$ cat /proc/vmallocinfo
0xffffca3a36442000-0xffffca3a36447000   20480 pcpu_create_chunk+0xed/0x2c0 pages=4 vmalloc
0xffffca63034d6000-0xffffca63034d9000   12288 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe0000 ioremap
0xffffcce23d32e000-0xffffcce23d330000    8192 memremap+0x1a1/0x280 phys=0x00000000000f5000 ioremap
0xffffcfb9f0e22000-0xffffcfb9f0e24000    8192 hpet_enable+0x36/0x4a9 phys=0x00000000fed00000 ioremap
0xffffd1df23e9e000-0xffffd1df23eb0000   73728 pcpu_create_chunk+0xb7/0x2c0 pages=17 vmalloc
0xffffd690c2990000-0xffffd690c2992000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe1000 ioremap
0xffffd8460c718000-0xffffd8460c71c000   16384 n_tty_open+0x16/0xe0 pages=3 vmalloc
0xffffd89aba709000-0xffffd89aba70b000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffe0ca3f2ed000-0xffffe0ca3f2ef000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x00000000fed00000 ioremap
0xffffe3ba44802000-0xffffe3ba44804000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffe4524b2a2000-0xffffe4524b2a4000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffe61372b2e000-0xffffe61372b30000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffe704d2f7c000-0xffffe704d2f8d000   69632 pcpu_create_chunk+0x80/0x2c0 pages=16 vmalloc
0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x1a40 vmalloc

With CONFIG_VMAP_STACK, also kernel thread stacks are placed in
vmalloc area and therefore they also get randomized (only one example
line from /proc/vmallocinfo shown for brevity):

unrandomized:
0xffffc90000018000-0xffffc90000021000   36864 kernel_clone+0xf9/0x560 pages=8 vmalloc

randomized:
0xffffcb57611a8000-0xffffcb57611b1000   36864 kernel_clone+0xf9/0x560 pages=8 vmalloc

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Andy Lutomirski <luto@kernel.org>
CC: Jann Horn <jannh@google.com>
CC: Kees Cook <keescook@chromium.org>
CC: Linux API <linux-api@vger.kernel.org>
CC: Matthew Wilcox <willy@infradead.org>
CC: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v2: retry allocation from other end of vmalloc space in case of
failure (Matthew Wilcox), improve commit message and documentation
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++++
 mm/vmalloc.c                                  | 29 +++++++++++++++++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..9386b1b40a27 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4017,6 +4017,29 @@
 
 	ramdisk_start=	[RAM] RAM disk image start address
 
+	randomize_vmalloc= [KNL] Randomize vmalloc() allocations. With 1,
+			the entire vmalloc() area is used randomly to
+			make the allocations less predictable and
+			harder to guess for attackers. Also module and
+			BPF code locations get randomized (within
+			their dedicated and rather small area though)
+			and if CONFIG_VMAP_STACK is enabled, also
+			kernel thread stack locations.
+
+			On 32 bit systems this may cause problems due
+			to increased VM fragmentation if the address
+			space gets crowded.
+
+			On all systems, it will reduce performance and
+			increase memory and cache usage due to less
+			efficient use of page tables and inability to
+			merge adjacent VMAs with compatible
+			attributes. On x86_64 with 5 level page
+			tables, in the worst case, additional page
+			table entries of up to 4 pages are created for
+			each mapping, so with small mappings there's
+			considerable penalty.
+
 	random.trust_cpu={on,off}
 			[KNL] Enable or disable trusting the use of the
 			CPU's random number generator (if available) to
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a8b210..d78528af6316 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -34,6 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
+#include <linux/random.h>
 
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>
@@ -1079,6 +1080,17 @@ adjust_va_to_fit_type(struct vmap_area *va,
 	return 0;
 }
 
+static int randomize_vmalloc = 0;
+
+static int __init set_randomize_vmalloc(char *str)
+{
+	if (!str)
+		return 0;
+	randomize_vmalloc = simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("randomize_vmalloc=", set_randomize_vmalloc);
+
 /*
  * Returns a start address of the newly allocated area, if success.
  * Otherwise a vend is returned that indicates failure.
@@ -1152,7 +1164,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				int node, gfp_t gfp_mask)
 {
 	struct vmap_area *va, *pva;
-	unsigned long addr;
+	unsigned long addr, voffset;
 	int purged = 0;
 	int ret;
 
@@ -1207,11 +1219,24 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
 		kmem_cache_free(vmap_area_cachep, pva);
 
+	/* Randomize allocation */
+	if (randomize_vmalloc) {
+		voffset = get_random_long() & (roundup_pow_of_two(vend - vstart) - 1);
+		voffset = PAGE_ALIGN(voffset);
+		if (voffset + size > vend - vstart)
+			voffset = vend - vstart - size;
+	} else
+		voffset = 0;
+
 	/*
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
 	 */
-	addr = __alloc_vmap_area(size, align, vstart, vend);
+	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
+
+	if (unlikely(addr == vend) && voffset)
+		/* Retry randomization from other end */
+		addr = __alloc_vmap_area(size, align, vstart, vstart + voffset + size);
 	spin_unlock(&free_vmap_area_lock);
 
 	if (unlikely(addr == vend))

base-commit: 7f376f1917d7461e05b648983e8d2aea9d0712b2
-- 
2.29.2

