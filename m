Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A772C7B59
	for <lists+linux-api@lfdr.de>; Sun, 29 Nov 2020 22:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgK2VRR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Nov 2020 16:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgK2VRR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Nov 2020 16:17:17 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C5C0613CF;
        Sun, 29 Nov 2020 13:16:36 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d8so16912668lfa.1;
        Sun, 29 Nov 2020 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aq0DciDB1RfuN5euQ6Fu3HrAhKMxuRi8OsTb8RdToog=;
        b=EgFznB1Svi6/Tjn6/fNQWwd67uEpOKh8kFA1bXumJmgvsSr+KoW5PAywFpewDK80j9
         9J4F2MhK0TOaY/2MCOFG8WBsg1XI11ZU2lVuvIUsd3ExJZekHsssMMaLUdw+ltQdVFwy
         1nw1/cPZpE5h6Q5swSut6iMDB9fZwxPpzes74noTXPhCuEmqhOnDt3V2zJuP9f148ZiC
         93JmfWJVtYHfbb3FK22NGrHRIdMO1QCCYUpNfmFwLS2i2yjPXVAvlif01MbN0DB+h+5R
         5Ex16QkVpiHVXC2knxgZuy1R0msoXmuKNTBcy0r6zEYgmibBGK2uBK6Y1QyXk8Ac4Vmz
         38Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aq0DciDB1RfuN5euQ6Fu3HrAhKMxuRi8OsTb8RdToog=;
        b=AN+w3ew26WivRLa0HM1ZQtb3T0qg6oMZnt0XdYdXWzCPCAoV1Tzm4y752ZfgTFb0a1
         4irA0kxB4H0hAfgJ31EMnga7/8FnXHoAGBbbXjNP3qHx+cwOnpmpvRib/llZ/3dJaAwM
         sK63Nzn/fKpQw06vYim6H2OI+MeIdAR6JmXmpyUTftiUrSOnnJH32wA6r/mYihxqH/b0
         L/UHEKa8wkw+e2S46A8QJypMxqw9LNm5szcz7bzRZZRxqbZaunq8JeAObA8FhbDsus2m
         cf8BXlbYYhGuiiL3nzLqO0cgEo9BpJR40dP/xxvLIdBljZE6KrKe73YQIe73pvbnrO9p
         Rz+A==
X-Gm-Message-State: AOAM531IJ14hdM9vDsoIRHKuQskIK2s303nBB5mZrCiLMESZEVS7s12l
        bzD9Id+1o9kEtuUDvKAEbCLgwl6d3EI=
X-Google-Smtp-Source: ABdhPJx0hq1Xf2/OoG0XwVBm2zOx8U/A/6X9F7C2+Y+SUY4XMkFQifBvOpzqE/SlKgpkTHf4G6GirA==
X-Received: by 2002:a05:6512:1107:: with SMTP id l7mr8377476lfg.328.1606684594558;
        Sun, 29 Nov 2020 13:16:34 -0800 (PST)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id w13sm2226129ljh.5.2020.11.29.13.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 13:16:33 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso and stack
Date:   Sun, 29 Nov 2020 23:15:17 +0200
Message-Id: <20201129211517.2208-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
enables full randomization of memory mappings created with mmap(NULL,
...). With 2, the base of the VMA used for such mappings is random,
but the mappings are created in predictable places within the VMA and
in sequential order. With 3, new VMAs are created to fully randomize
the mappings.

Also mremap(..., MREMAP_MAYMOVE) will move the mappings even if not
necessary and the location of stack and vdso are also randomized.

The method is to randomize the new address without considering
VMAs. If the address fails checks because of overlap with the stack
area (or in case of mremap(), overlap with the old mapping), the
operation is retried a few times before falling back to old method.

On 32 bit systems this may cause problems due to increased VM
fragmentation if the address space gets crowded.

On all systems, it will reduce performance and increase memory usage
due to less efficient use of page tables and inability to merge
adjacent VMAs with compatible attributes. In the worst case,
additional page table entries of up to 4 pages are created for each
mapping, so with small mappings there's considerable penalty.

In this example with sysctl.kernel.randomize_va_space = 2, dynamic
loader, libc, anonymous memory reserved with mmap() and locale-archive
are located close to each other:

$ cat /proc/self/maps (only first line for each object shown for brevity)
5acea452d000-5acea452f000 r--p 00000000 fe:0c 1868624                    /usr/bin/cat
74f438f90000-74f4394f2000 r--p 00000000 fe:0c 2473999                    /usr/lib/locale/locale-archive
74f4394f2000-74f4395f2000 rw-p 00000000 00:00 0
74f4395f2000-74f439617000 r--p 00000000 fe:0c 2402332                    /usr/lib/x86_64-linux-gnu/libc-2.31.so
74f4397b3000-74f4397b9000 rw-p 00000000 00:00 0
74f4397e5000-74f4397e6000 r--p 00000000 fe:0c 2400754                    /usr/lib/x86_64-linux-gnu/ld-2.31.so
74f439811000-74f439812000 rw-p 00000000 00:00 0
7fffdca0d000-7fffdca2e000 rw-p 00000000 00:00 0                          [stack]
7fffdcb49000-7fffdcb4d000 r--p 00000000 00:00 0                          [vvar]
7fffdcb4d000-7fffdcb4f000 r-xp 00000000 00:00 0                          [vdso]

With sysctl.kernel.randomize_va_space = 3, they are located at
unrelated addresses and the order is random:

$ echo 3 > /proc/sys/kernel/randomize_va_space
$ cat /proc/self/maps (only first line for each object shown for brevity)
3850520000-3850620000 rw-p 00000000 00:00 0
28cfb4c8000-28cfb4cc000 r--p 00000000 00:00 0                            [vvar]
28cfb4cc000-28cfb4ce000 r-xp 00000000 00:00 0                            [vdso]
9e74c385000-9e74c387000 rw-p 00000000 00:00 0
a42e0233000-a42e0234000 r--p 00000000 fe:0c 2400754                      /usr/lib/x86_64-linux-gnu/ld-2.31.so
a42e025f000-a42e0260000 rw-p 00000000 00:00 0
bea40427000-bea4044c000 r--p 00000000 fe:0c 2402332                      /usr/lib/x86_64-linux-gnu/libc-2.31.so
bea405e8000-bea405ec000 rw-p 00000000 00:00 0
f6d446fa000-f6d44c5c000 r--p 00000000 fe:0c 2473999                      /usr/lib/locale/locale-archive
fcfbf684000-fcfbf6a5000 rw-p 00000000 00:00 0                            [stack]
619aba62d000-619aba62f000 r--p 00000000 fe:0c 1868624                    /usr/bin/cat

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Jann Horn <jannh@google.com>
CC: Kees Cook <keescook@chromium.org>
CC: Matthew Wilcox <willy@infradead.org>
CC: Mike Rapoport <rppt@kernel.org>
CC: Linux API <linux-api@vger.kernel.org>
Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v2: also randomize mremap(..., MREMAP_MAYMOVE)
v3: avoid stack area and retry in case of bad random address (Jann
Horn), improve description in kernel.rst (Matthew Wilcox)
v4:
- use /proc/$pid/maps in the example (Mike Rapaport)
- CCs (Andrew Morton)
- only check randomize_va_space == 3
v5: randomize also vdso and stack
---
 Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++--
 Documentation/admin-guide/sysctl/kernel.rst   | 20 +++++++++++++
 arch/x86/entry/vdso/vma.c                     | 26 +++++++++++++++-
 include/linux/mm.h                            |  8 +++++
 init/Kconfig                                  |  2 +-
 mm/mmap.c                                     | 30 +++++++++++++------
 mm/mremap.c                                   | 27 +++++++++++++++++
 mm/util.c                                     |  6 ++++
 8 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index e05e581af5cf..9ea250522077 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -254,7 +254,7 @@ Spectre variant 2
    left by the previous process will also be cleared.
 
    User programs should use address space randomization to make attacks
-   more difficult (Set /proc/sys/kernel/randomize_va_space = 1 or 2).
+   more difficult (Set /proc/sys/kernel/randomize_va_space = 1, 2 or 3).
 
 3. A virtualized guest attacking the host
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -499,8 +499,8 @@ Spectre variant 2
    more overhead and run slower.
 
    User programs should use address space randomization
-   (/proc/sys/kernel/randomize_va_space = 1 or 2) to make attacks more
-   difficult.
+   (/proc/sys/kernel/randomize_va_space = 1, 2 or 3) to make attacks
+   more difficult.
 
 3. VM mitigation
 ^^^^^^^^^^^^^^^^
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d4b32cc32bb7..806e3b29d2b5 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1060,6 +1060,26 @@ that support this feature.
     Systems with ancient and/or broken binaries should be configured
     with ``CONFIG_COMPAT_BRK`` enabled, which excludes the heap from process
     address space randomization.
+
+3   Additionally enable full randomization of memory mappings created
+    with mmap(NULL, ...). With 2, the base of the VMA used for such
+    mappings is random, but the mappings are created in predictable
+    places within the VMA and in sequential order. With 3, new VMAs
+    are created to fully randomize the mappings.
+
+    Also mremap(..., MREMAP_MAYMOVE) will move the mappings even if
+    not necessary and the location of stack and vdso are also
+    randomized.
+
+    On 32 bit systems this may cause problems due to increased VM
+    fragmentation if the address space gets crowded.
+
+    On all systems, it will reduce performance and increase memory
+    usage due to less efficient use of page tables and inability to
+    merge adjacent VMAs with compatible attributes. In the worst case,
+    additional page table entries of up to 4 pages are created for
+    each mapping, so with small mappings there's considerable penalty.
+
 ==  ===========================================================================
 
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9185cb1d13b9..03ea884822e3 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/random.h>
 #include <linux/elf.h>
+#include <linux/elf-randomize.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
 #include <linux/time_namespace.h>
@@ -32,6 +33,8 @@
 	const size_t name ## _offset = offset;
 #include <asm/vvar.h>
 
+#define MAX_RANDOM_VDSO_RETRIES			5
+
 struct vdso_data *arch_get_vdso_data(void *vvar_page)
 {
 	return (struct vdso_data *)(vvar_page + _vdso_data_offset);
@@ -361,7 +364,28 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 
 static int map_vdso_randomized(const struct vdso_image *image)
 {
-	unsigned long addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
+	unsigned long addr;
+
+	if (randomize_va_space == 3) {
+		/*
+		 * Randomize vdso address.
+		 */
+		int i = MAX_RANDOM_VDSO_RETRIES;
+
+		do {
+			int ret;
+
+			/* Try a few times to find a free area */
+			addr = arch_mmap_rnd();
+
+			ret = map_vdso(image, addr);
+			if (!IS_ERR_VALUE(ret))
+				return ret;
+		} while (--i >= 0);
+
+		/* Give up and try the less random way */
+	}
+	addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
 
 	return map_vdso(image, addr);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..ac5464f66066 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -97,6 +97,14 @@ extern const int mmap_rnd_compat_bits_max;
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
+#ifndef arch_get_mmap_end
+#define arch_get_mmap_end(addr)	(TASK_SIZE)
+#endif
+
+#ifndef arch_get_mmap_base
+#define arch_get_mmap_base(addr, base) (base)
+#endif
+
 #include <asm/page.h>
 #include <asm/processor.h>
 
diff --git a/init/Kconfig b/init/Kconfig
index 02d13ae27abb..9a0db5bed032 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1863,7 +1863,7 @@ config COMPAT_BRK
 	  also breaks ancient binaries (including anything libc5 based).
 	  This option changes the bootup default to heap randomization
 	  disabled, and can be overridden at runtime by setting
-	  /proc/sys/kernel/randomize_va_space to 2.
+	  /proc/sys/kernel/randomize_va_space to 2 or 3.
 
 	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
 
diff --git a/mm/mmap.c b/mm/mmap.c
index d91ecb00d38c..3677491e999b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/elf-randomize.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -73,6 +74,8 @@ const int mmap_rnd_compat_bits_max = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX;
 int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 #endif
 
+#define MAX_RANDOM_MMAP_RETRIES			5
+
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
@@ -206,7 +209,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 #ifdef CONFIG_COMPAT_BRK
 	/*
 	 * CONFIG_COMPAT_BRK can still be overridden by setting
-	 * randomize_va_space to 2, which will still cause mm->start_brk
+	 * randomize_va_space to >= 2, which will still cause mm->start_brk
 	 * to be arbitrarily shifted
 	 */
 	if (current->brk_randomized)
@@ -1445,6 +1448,23 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
+	/* Pick a random address even outside current VMAs? */
+	if (!addr && randomize_va_space == 3) {
+		int i = MAX_RANDOM_MMAP_RETRIES;
+		unsigned long max_addr = arch_get_mmap_base(addr, mm->mmap_base);
+
+		do {
+			/* Try a few times to find a free area */
+			addr = arch_mmap_rnd();
+			if (addr >= max_addr)
+				continue;
+			addr = get_unmapped_area(file, addr, len, pgoff, flags);
+		} while (--i >= 0 && !IS_ERR_VALUE(addr));
+
+		if (IS_ERR_VALUE(addr))
+			addr = 0;
+	}
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
@@ -2142,14 +2162,6 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 	return addr;
 }
 
-#ifndef arch_get_mmap_end
-#define arch_get_mmap_end(addr)	(TASK_SIZE)
-#endif
-
-#ifndef arch_get_mmap_base
-#define arch_get_mmap_base(addr, base) (base)
-#endif
-
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
  *
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..c5b2ed2bfd2d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -24,12 +24,15 @@
 #include <linux/uaccess.h>
 #include <linux/mm-arch-hooks.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/elf-randomize.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
 #include "internal.h"
 
+#define MAX_RANDOM_MREMAP_RETRIES		5
+
 static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -720,6 +723,30 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	if ((flags & MREMAP_MAYMOVE) && randomize_va_space == 3) {
+		/*
+		 * Caller is happy with a different address, so let's
+		 * move even if not necessary!
+		 */
+		int i = MAX_RANDOM_MREMAP_RETRIES;
+		unsigned long max_addr = arch_get_mmap_base(addr, mm->mmap_base);
+
+		do {
+			/* Try a few times to find a free area */
+			new_addr = arch_mmap_rnd();
+			if (new_addr >= max_addr)
+				continue;
+			ret = mremap_to(addr, old_len, new_addr, new_len,
+					&locked, flags, &uf, &uf_unmap_early,
+					&uf_unmap);
+			if (!IS_ERR_VALUE(ret))
+				goto out;
+		} while (--i >= 0);
+
+		/* Give up and try the old address */
+		new_addr = addr;
+	}
+
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
diff --git a/mm/util.c b/mm/util.c
index 4ddb6e186dd5..f81a6de4f82a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -319,6 +319,12 @@ unsigned long randomize_stack_top(unsigned long stack_top)
 {
 	unsigned long random_variable = 0;
 
+	/*
+	 * Randomize stack address.
+	 */
+	if (randomize_va_space == 3)
+		return arch_mmap_rnd();
+
 	if (current->flags & PF_RANDOMIZE) {
 		random_variable = get_random_long();
 		random_variable &= STACK_RND_MASK;

base-commit: aae5ab854e38151e69f261dbf0e3b7e396403178
-- 
2.29.2

