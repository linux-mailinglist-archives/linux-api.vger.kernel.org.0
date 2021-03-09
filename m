Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED73327F0
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 14:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCIN6b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 08:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhCIN6O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 08:58:14 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F6C06174A;
        Tue,  9 Mar 2021 05:58:14 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id h4so20768264ljl.0;
        Tue, 09 Mar 2021 05:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGGHjgXXTqasYN8P5EyEBv5tuRCYFLrDszBbtT8jMqk=;
        b=vJtky+ICZQR5Ik8d9Dt48lLhMJycNjiMao2MlTd21js+ghTKZiqbNxU5sfVlD2FvlY
         7FOmYI0sBuua9kJPEdfZAF2YoA3xKcNO042z8J6tNiePxuxuStis/py+yO5DEForYqhO
         VpdKPZlfV3RMh5VukZgCWzTV8zWDeGcoYDMokmpuAuxtgdcHDTKMc4Jq8W4IO6YAk7I+
         xIwZ0s9BQxbcnei/9M/PH7UOXLzkJo1QRqmoDe61gxVvhZbEKjzkqaUV56j8dOhhhLt1
         +VnLFRtfx9Ppcaj0Fh4KqB7crDePf4maTobJiemcdHIXXLxL3ozQOx4hpUkZvpds/KkO
         bCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGGHjgXXTqasYN8P5EyEBv5tuRCYFLrDszBbtT8jMqk=;
        b=KVWEIffMdlMZZinfVl+d/4v/Qjmgon0LJ8MbAGfuoFVOopKerpl7KEi8vvi950QQse
         h04fUCCujQzh0S0nwX0Qy1GRPNF/EkrQ32RSM4NDEoYabdtUTy5qByVM9QmMVE1OA182
         uAHYosDVLx9CC3QZ0+KnePTZlTm8kQBvGwY/bfiw4oH8PO9iVK298wkNa68gVSyOqAbf
         Gv7bgGFzfQizLunYohnWZ0LO0X173uJWF5+Ydy4XRMnqExZzQuQCEg2kgKnHGo3kOUP1
         dMQ/cnxyvjKhzVRHpvXmRZMplKATjbFiMpPWHyddSY81yvv21MeqcJSdomCQfJ3KPcHW
         bMYw==
X-Gm-Message-State: AOAM530TAjQaQYPMtHhwjH4afBURjnCTayhn0OJu4yHa4VxYjOfdLn6P
        J6a+45ZpYGIo4K2tsU2fKGQ9QHl/XQg=
X-Google-Smtp-Source: ABdhPJwOPzccUoO8WMlCBDqmdHvQFpwRWx+m/DQAnhmWT/JAaEayZrr3p4onZQrvncWp+crxjTU41Q==
X-Received: by 2002:a2e:8185:: with SMTP id e5mr3094256ljg.138.1615298292146;
        Tue, 09 Mar 2021 05:58:12 -0800 (PST)
Received: from localhost.localdomain (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id e18sm1955462ljl.92.2021.03.09.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:58:11 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Vlad Rezki <urezki@gmail.com>
Subject: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
Date:   Tue,  9 Mar 2021 15:57:57 +0200
Message-Id: <20210309135757.5406-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Memory mappings inside kernel allocated with vmalloc() are in
predictable order and packed tightly toward the low addresses, except
for per-cpu areas which start from top of the vmalloc area. With
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
$ grep -v kernel_clone /proc/vmallocinfo
0xffffc90000000000-0xffffc90000009000   36864 irq_init_percpu_irqstack+0x176/0x1c0 vmap
0xffffc90000009000-0xffffc9000000b000    8192 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x000000001ffe1000 ioremap
0xffffc9000000c000-0xffffc9000000f000   12288 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x000000001ffe0000 ioremap
0xffffc9000000f000-0xffffc90000011000    8192 hpet_enable+0x31/0x4a4 phys=0x00000000fed00000 ioremap
0xffffc90000011000-0xffffc90000013000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffc90000013000-0xffffc90000015000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffc90000015000-0xffffc90000017000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffc90000021000-0xffffc90000023000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffc90000023000-0xffffc90000025000    8192 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x00000000fed00000 ioremap
0xffffc90000025000-0xffffc90000027000    8192 memremap+0x19c/0x280 phys=0x00000000000f5000 ioremap
0xffffc90000031000-0xffffc90000036000   20480 pcpu_create_chunk+0xe8/0x260 pages=4 vmalloc
0xffffc90000043000-0xffffc90000047000   16384 n_tty_open+0x11/0xe0 pages=3 vmalloc
0xffffc90000211000-0xffffc90000232000  135168 crypto_scomp_init_tfm+0xc6/0xf0 pages=32 vmalloc
0xffffc90000232000-0xffffc90000253000  135168 crypto_scomp_init_tfm+0x67/0xf0 pages=32 vmalloc
0xffffc900005a9000-0xffffc900005ba000   69632 pcpu_create_chunk+0x7b/0x260 pages=16 vmalloc
0xffffc900005ba000-0xffffc900005cc000   73728 pcpu_create_chunk+0xb2/0x260 pages=17 vmalloc
0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x2290 vmalloc

With randomize_vmalloc=1, the allocations are randomized:
$ grep -v kernel_clone /proc/vmallocinfo
0xffffc9759d443000-0xffffc9759d445000    8192 hpet_enable+0x31/0x4a4 phys=0x00000000fed00000 ioremap
0xffffccf1e9f66000-0xffffccf1e9f68000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffcd2fc02a4000-0xffffcd2fc02a6000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffcdaefb898000-0xffffcdaefb89b000   12288 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x000000001ffe0000 ioremap
0xffffcef8074c3000-0xffffcef8074cc000   36864 irq_init_percpu_irqstack+0x176/0x1c0 vmap
0xffffcf725ca2e000-0xffffcf725ca4f000  135168 crypto_scomp_init_tfm+0xc6/0xf0 pages=32 vmalloc
0xffffd0efb25e1000-0xffffd0efb25f2000   69632 pcpu_create_chunk+0x7b/0x260 pages=16 vmalloc
0xffffd27054678000-0xffffd2705467c000   16384 n_tty_open+0x11/0xe0 pages=3 vmalloc
0xffffd2adf716e000-0xffffd2adf7180000   73728 pcpu_create_chunk+0xb2/0x260 pages=17 vmalloc
0xffffd4ba5fb6b000-0xffffd4ba5fb6d000    8192 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x000000001ffe1000 ioremap
0xffffded126192000-0xffffded126194000    8192 memremap+0x19c/0x280 phys=0x00000000000f5000 ioremap
0xffffe01a4dbcd000-0xffffe01a4dbcf000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffe4b649952000-0xffffe4b649954000    8192 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x00000000fed00000 ioremap
0xffffe71ed592a000-0xffffe71ed592c000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
0xffffe7dc5824f000-0xffffe7dc58270000  135168 crypto_scomp_init_tfm+0x67/0xf0 pages=32 vmalloc
0xffffe8f4f9800000-0xffffe8f4f9a00000 2097152 pcpu_get_vm_areas+0x0/0x2290 vmalloc
0xffffe8f4f9a19000-0xffffe8f4f9a1e000   20480 pcpu_create_chunk+0xe8/0x260 pages=4 vmalloc

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
CC: Vlad Rezki <urezki@gmail.com>
Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v2: retry allocation from other end of vmalloc space in case of
failure (Matthew Wilcox), improve commit message and documentation
v3: randomize also percpu allocations (pcpu_get_vm_areas())
v4: use static branches (Kees Cook) and make the parameter boolean.
---
 .../admin-guide/kernel-parameters.txt         | 24 ++++++++++
 mm/vmalloc.c                                  | 44 +++++++++++++++++--
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545c2070..726aec542079 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4024,6 +4024,30 @@
 
 	ramdisk_start=	[RAM] RAM disk image start address
 
+	randomize_vmalloc= [KNL] Boolean option to randomize vmalloc()
+			allocations. When enabled, the entire
+			vmalloc() area is used randomly to make the
+			allocations less predictable and harder to
+			guess for attackers. Also module and BPF code
+			locations get randomized (within their
+			dedicated and rather small area though) and if
+			CONFIG_VMAP_STACK is enabled, also kernel
+			thread stack locations.
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
index e6f352bf0498..b5ecf27dc98e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -34,6 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
+#include <linux/random.h>
 
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>
@@ -1089,6 +1090,25 @@ adjust_va_to_fit_type(struct vmap_area *va,
 	return 0;
 }
 
+static DEFINE_STATIC_KEY_FALSE_RO(randomize_vmalloc);
+
+static int __init set_randomize_vmalloc(char *str)
+{
+	int ret;
+	bool bool_result;
+
+	ret = kstrtobool(str, &bool_result);
+	if (ret)
+		return ret;
+
+	if (bool_result)
+		static_branch_enable(&randomize_vmalloc);
+	else
+		static_branch_disable(&randomize_vmalloc);
+	return 1;
+}
+__setup("randomize_vmalloc=", set_randomize_vmalloc);
+
 /*
  * Returns a start address of the newly allocated area, if success.
  * Otherwise a vend is returned that indicates failure.
@@ -1162,7 +1182,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				int node, gfp_t gfp_mask)
 {
 	struct vmap_area *va, *pva;
-	unsigned long addr;
+	unsigned long addr, voffset;
 	int purged = 0;
 	int ret;
 
@@ -1217,11 +1237,24 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
 		kmem_cache_free(vmap_area_cachep, pva);
 
+	/* Randomize allocation */
+	if (static_branch_unlikely(&randomize_vmalloc)) {
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
@@ -3258,7 +3291,12 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	start = offsets[area];
 	end = start + sizes[area];
 
-	va = pvm_find_va_enclose_addr(vmalloc_end);
+	if (static_branch_unlikely(&randomize_vmalloc))
+		va = pvm_find_va_enclose_addr(vmalloc_start +
+					      (get_random_long() &
+					       (roundup_pow_of_two(vmalloc_end - vmalloc_start) - 1)));
+	else
+		va = pvm_find_va_enclose_addr(vmalloc_end);
 	base = pvm_determine_end_from_reverse(&va, align) - end;
 
 	while (true) {
-- 
2.30.1

