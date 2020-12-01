Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594852CAF19
	for <lists+linux-api@lfdr.de>; Tue,  1 Dec 2020 22:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgLAVqv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Dec 2020 16:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLAVqu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Dec 2020 16:46:50 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F4C0613CF;
        Tue,  1 Dec 2020 13:46:04 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so7562579lfe.12;
        Tue, 01 Dec 2020 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NxeHTQJFJe0QHrIsWfxQ6Nd1Xqj4JEgCBCe5zjF9cHI=;
        b=Fkt8Z4qzXccvJ/MZeY0SCQrX8Gv3n3FDzR1n2KMlfH2jyqKufMCCPGP0pCvOuffcb4
         LczZsOQ7ksxf6TIkfnTEZc10H3sOJKkSXYJHEskkEIXKGV60np4WaTfiGm2UKni2UAVF
         KO8xWu+a67mqq3QfhnhlHGfx0eaugjdAdCmc/aml8k/k6U+R8McoK68ey/+NCelk2Lt9
         TxNnULZG1im0Wk3XEqeiGki/ylkqxSTE9V7Py2Np0eCeiNSzgGY3JsSfBTomZwdeNomy
         ju/xjNzcDKq00TSQQXXMO+FSq4QVkk+E+S43g2YOSb8Aha1R4iXdoe57V2AbLiIu5CPw
         g8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NxeHTQJFJe0QHrIsWfxQ6Nd1Xqj4JEgCBCe5zjF9cHI=;
        b=kMlOGrLbtRVNhypncMn42QHjO+NhvX6UQu/G+S347orR8TOYU2qUC22ke+euEkFAR+
         w9WZ1xPIYwbELA581CXNnLESjQhnNXczE8wWN5w7ugyQZhCtFFCZ1KqejRYnsuYSRdJI
         ZW93qZGosl/hj53CV1xr8N1xJ20q0Y9RVBYBzZWVp2X1zuBOwJ7bIkYkwNyJZcCAfLU2
         Wvo+fw+kjBQx7/qR+KPykoLK3r8uDNgyJah8dnlLvxfztwnMmDgADXlAx88r2E5KaH43
         Rsh0ZDPrNzC2B0HsibP53HNaWl7M9abfqjBGd5o7gqQqMs9DT3EaVwOEtH1IDW6S/VF1
         BgsQ==
X-Gm-Message-State: AOAM531Dt5hx4s6/bdHfOiGD+/7mYKgqYwc2/8IkP9ar1p8xFLn0F6M8
        fFhFQEGDe7a06G9yTI+GkKTutEuwzOE=
X-Google-Smtp-Source: ABdhPJydL359UenriJ2nPalNvSazB1ofowx4GFjifmrY8csqj24rZPfAQfzMDV/AFP0g7WUQBWVjGw==
X-Received: by 2002:ac2:4c8e:: with SMTP id d14mr2175175lfl.411.1606859162701;
        Tue, 01 Dec 2020 13:46:02 -0800 (PST)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id c14sm111761lfr.105.2020.12.01.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 13:46:02 -0800 (PST)
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
Subject: [PATCH] mm/vmalloc: randomize vmalloc() allocations
Date:   Tue,  1 Dec 2020 23:45:47 +0200
Message-Id: <20201201214547.9721-1-toiwoton@gmail.com>
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
guess for attackers.

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

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Andy Lutomirski <luto@kernel.org>
CC: Jann Horn <jannh@google.com>
CC: Kees Cook <keescook@chromium.org>
CC: Linux API <linux-api@vger.kernel.org>
CC: Matthew Wilcox <willy@infradead.org>
CC: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 ++
 mm/vmalloc.c                                  | 25 +++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..a0242e31d2d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4017,6 +4017,8 @@
 
 	ramdisk_start=	[RAM] RAM disk image start address
 
+	randomize_vmalloc= [KNL] Randomize vmalloc() allocations.
+
 	random.trust_cpu={on,off}
 			[KNL] Enable or disable trusting the use of the
 			CPU's random number generator (if available) to
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a8b210..a5f7bb46ddf2 100644
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
 
@@ -1207,11 +1219,20 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
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
 	spin_unlock(&free_vmap_area_lock);
 
 	if (unlikely(addr == vend))
-- 
2.29.2

