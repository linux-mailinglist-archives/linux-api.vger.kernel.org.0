Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43B2E993F
	for <lists+linux-api@lfdr.de>; Mon,  4 Jan 2021 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbhADPyV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 Jan 2021 10:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbhADPyV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 Jan 2021 10:54:21 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A610EC061574;
        Mon,  4 Jan 2021 07:53:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h22so65486789lfu.2;
        Mon, 04 Jan 2021 07:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Be4Z6d2+r0DxgpfJy4ouj0TfQfDrIm/KNEc47v+KgKk=;
        b=My+6Su8uUYI/4rh1SUZY3GeoQQeLtO2IdIbFUvCn0bJ9/HQrBCswjaBULevt8BEMxK
         1863vdLh/+dSOdctPa9xFYaTc67iAWXReY7iIdE+BeJP+xq8XvleBXY7CD63/ZsuFfYV
         jO729ABvjilifivIGbI+5XLiTuHLBab5qbli1qhzQOglyhvjZmWlki1jsxlGzUMLdNH9
         8cd7+n+Jv/rQ18u+MIWu4mG+TM5H2VZktI3VsQ4+jSOzs1n4HwIr65JQ3PmI5iXViUtX
         syKrK/ZLGXJUJu7vAgcjP0qQvOomYr98A/X1o5nssmWyvDnHQIW3YfEWGmPcWngLgBd3
         6WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Be4Z6d2+r0DxgpfJy4ouj0TfQfDrIm/KNEc47v+KgKk=;
        b=PkkBEsjLMafZjxnzOEGkY9aNC9XjAsqjI5ccssWGoSgVrO2Fn6YAAwCi1J18hlNr5q
         V/MQzmMHhcCkVbWnm21i1kFWKjiPVa12EMFPB7/cNio7/OIlkQJ6tMmNZFjfMuISr/wX
         48s+osSIe8tCCCNgXSOD1PvcZe02aeXRV1Y1a6+lIm8eW37hzyBFyp82eHApxDL2Cw3o
         Obf/iMaYZba2xW9j1YKNzfZc0Okia7t0uxyR7VFHEyaEsaTuiDbgmdVVAMjA0AGvKzKT
         P93pFXfJt6EoRZ9d+AmveOkyuk069oew7dAigiFMNi40/m2KJCmUFhDbQV9J9YJzB9K+
         dFPg==
X-Gm-Message-State: AOAM533SBBfFiBdZdQ9e8UiXkNRMbAEEdbiDxyI91tcRuu0Y6suWMD0+
        1ik1VtRHELpbK1pQdyeF5lu6Y2cQHyiHJw==
X-Google-Smtp-Source: ABdhPJx61XH2pZHzgjn1WdP8PwV+vsq60xDM/7jRQmdxCcYW2ieMA+PTduMcegSHQtPn/2y7FWaQmw==
X-Received: by 2002:a2e:90d2:: with SMTP id o18mr34134103ljg.395.1609775618713;
        Mon, 04 Jan 2021 07:53:38 -0800 (PST)
Received: from localhost.localdomain (88-114-222-21.elisa-laajakaista.fi. [88.114.222.21])
        by smtp.gmail.com with ESMTPSA id y20sm8661703lji.86.2021.01.04.07.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 07:53:38 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH v9] mm: Optional full ASLR for mmap(), mremap(), vdso, stack and heap
Date:   Mon,  4 Jan 2021 17:53:16 +0200
Message-Id: <20210104155316.16259-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
enables full randomization of memory mappings. With 2, the base of the
VMA used for such mappings is random, but the mappings are created in
predictable places within the VMA and in sequential order. With 3, new
VMAs are created to fully randomize the mappings.

Mappings created with mmap(NULL, ...) are randomized and mremap(...,
MREMAP_MAYMOVE) will move the mappings even if not necessary. The
locations of heap (memory allocated with brk()), stack and vdso are
also randomized.

On 32 bit systems this may cause problems due to increased VM
fragmentation if the address space gets crowded, so this flag is
ignored for 32 bit compatibility personalities.

On all systems, it will reduce performance and increase memory and
cache usage due to less efficient use of page tables and inability to
merge adjacent VMAs with compatible attributes. On x86_64 with 5 level
page tables, in the worst case, additional page table entries of up to
4 pages are created for each mapping, so with small mappings there's
considerable penalty.

By lowering the lowest address for mapping the main executable from
2/3 of the address space to sysctl.vm.mmap_min_addr, it's possible to
use the full 35 bits available on x86_64 for ASLR. This is not usable
without sysctl.kernel.randomize_va_space = 3.

The method is to randomize the new address without considering
VMAs. If the address fails checks because of overlap with the stack
area (or in case of mremap(), overlap with the old mapping), the
operation is retried a few times before falling back to old method.

Kernel compile time was increased by 3% with 35 bits randomization
instead of 28 and sysctl.kernel.randomize_va_space = 3 instead of 2.
In another test involving X11 session with a browser with several tabs
open, the memory reported in PageTables field in /proc/meminfo was
increased from 67MB to 137MB, or 104% increase.

In this example with sysctl.kernel.randomize_va_space = 2, main
executable, heap allocated with brk(), locale-archive, libc, dynamic
loader, some anonymous memory reserved with mmap(), stack and vdso
are located in three groups and inside each group the mappings are
close to each other:

$ echo 2 > /proc/sys/kernel/randomize_va_space
$ echo 28 > /proc/sys/vm/mmap_rnd_bits
$ cat /proc/self/maps (only first line for each object shown for brevity)
55c6af2a6000-55c6af2a8000 r--p 00000000 fe:0c 1868624                    /usr/bin/cat
55c6b0087000-55c6b00a8000 rw-p 00000000 00:00 0                          [heap]
7fba5d2f9000-7fba5d85b000 r--p 00000000 fe:0c 2474005                    /usr/lib/locale/locale-archive
7fba5d85b000-7fba5d880000 r--p 00000000 fe:0c 2402332                    /usr/lib/x86_64-linux-gnu/libc-2.31.so
7fba5da1c000-7fba5da22000 rw-p 00000000 00:00 0
7fba5da2c000-7fba5da4e000 rw-p 00000000 00:00 0
7fba5da4e000-7fba5da4f000 r--p 00000000 fe:0c 2400754                    /usr/lib/x86_64-linux-gnu/ld-2.31.so
7fba5da7a000-7fba5da7b000 rw-p 00000000 00:00 0
7ffd1bae5000-7ffd1bb06000 rw-p 00000000 00:00 0                          [stack]
7ffd1bb3b000-7ffd1bb3f000 r--p 00000000 00:00 0                          [vvar]
7ffd1bb3f000-7ffd1bb41000 r-xp 00000000 00:00 0                          [vdso]

The heap is also aligned to page boundary:
$ cat brk.S
        .globl _start
_start:
        movq $12, %rax
        movq $0, %rdi
        syscall

        movq $60, %rax
        syscall
$ strace ./brk
brk(NULL)                               = 0xd92000
exit(0)                                 = ?

With sysctl.kernel.randomize_va_space = 3, the segments are located at
unrelated addresses and the order is random:

$ echo 3 > /proc/sys/kernel/randomize_va_space
$ echo 35 > /proc/sys/vm/mmap_rnd_bits
$ cat /proc/self/maps (only first line for each object shown for brevity)
14872b64000-14872b65000 r--p 00000000 fe:0c 2400754                      /usr/lib/x86_64-linux-gnu/ld-2.31.so
f242fb53000-f242fb57000 r--p 00000000 00:00 0                            [vvar]
f242fb57000-f242fb59000 r-xp 00000000 00:00 0                            [vdso]
19c43add2000-19c43adf4000 rw-p 00000000 00:00 0
1eec5609e000-1eec560a0000 r--p 00000000 fe:0c 1868624                    /usr/bin/cat
2760e70ad000-2760e70ae000 rw-p 00000000 00:00 0
37c0c5728000-37c0c572a000 rw-p 00000000 00:00 0
3a6175611000-3a6175632000 rw-p 00000000 00:00 0                          [stack]
55159e8c4000-55159e8e9000 r--p 00000000 fe:0c 2402332                    /usr/lib/x86_64-linux-gnu/libc-2.31.so
76d786a2e000-76d786f90000 r--p 00000000 fe:0c 2474005                    /usr/lib/locale/locale-archive
7e8f9a574000-7e8f9a595000 rw-p 00000000 00:00 0                          [heap]

Also low address bits of heap are randomized as was already done for stack:
$ strace ./brk
brk(NULL)                               = 0x15b9727a3aa0
exit(0)                                 = ?

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
v6:
- randomize also heap
- use 35 bits for ASLR on x86_64
- RFC due to temporarily disabling mremap() randomization
v7: reimplement mremap() randomization
v8:
- randomize also lowest bits of heap
- use MAP_FIXED_NOREPLACE to find a random but unused area
v9: fix debugging and 32 bit apps (Steam)
---
 Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++---
 Documentation/admin-guide/sysctl/kernel.rst   | 23 +++++++++++++++++
 arch/x86/Kconfig                              |  2 +-
 arch/x86/entry/vdso/vma.c                     |  7 +++++-
 arch/x86/kernel/process.c                     |  5 +++-
 arch/x86/mm/mmap.c                            |  3 +++
 fs/binfmt_elf.c                               | 14 ++++++++++-
 include/linux/mm.h                            | 10 ++++++++
 init/Kconfig                                  |  2 +-
 mm/mmap.c                                     | 25 ++++++++++++++++++-
 mm/mremap.c                                   | 18 +++++++++++--
 mm/util.c                                     | 11 +++++++-
 12 files changed, 114 insertions(+), 12 deletions(-)

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
index d4b32cc32bb7..5de63c8eefc8 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1060,6 +1060,29 @@ that support this feature.
     Systems with ancient and/or broken binaries should be configured
     with ``CONFIG_COMPAT_BRK`` enabled, which excludes the heap from process
     address space randomization.
+
+3   Additionally enable full randomization of memory mappings. With 2,
+    the base of the VMA used for such mappings may be random, but the
+    mappings are created in predictable places within the VMA and in
+    sequential order. With 3, new VMAs are created to fully randomize
+    the mappings.
+
+    Mappings created with mmap(NULL, ...) are randomized and
+    mremap(..., MREMAP_MAYMOVE) will move the mappings even if not
+    necessary. The locations of heap (memory allocated with brk()),
+    stack and vdso are also randomized.
+
+    On 32 bit systems this may cause problems due to increased VM
+    fragmentation if the address space gets crowded, so this flag is
+    ignored for 32 bit compatibility personalities.
+
+    On all systems, it will reduce performance and increase memory and
+    cache usage due to less efficient use of page tables and inability
+    to merge adjacent VMAs with compatible attributes. On x86_64 with
+    5 level page tables, in the worst case, additional page table
+    entries of up to 4 pages are created for each mapping, so with
+    small mappings there's considerable penalty.
+
 ==  ===========================================================================
 
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fbf26e0f7a6a..d95a8f1e101c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -266,7 +266,7 @@ config ARCH_MMAP_RND_BITS_MIN
 	default 8
 
 config ARCH_MMAP_RND_BITS_MAX
-	default 32 if 64BIT
+	default 35 if 64BIT
 	default 16
 
 config ARCH_MMAP_RND_COMPAT_BITS_MIN
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9185cb1d13b9..5a30e53cdc1d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -361,7 +361,12 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 
 static int map_vdso_randomized(const struct vdso_image *image)
 {
-	unsigned long addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
+	unsigned long addr;
+
+	if (can_randomize_full())
+		addr = 0; /* let get_unmapped_area() pick the address */
+	else
+		addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
 
 	return map_vdso(image, addr);
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 145a7ac0c19a..bdfd457adfa8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -905,7 +905,10 @@ unsigned long arch_align_stack(unsigned long sp)
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
-	return randomize_page(mm->brk, 0x02000000);
+	if (can_randomize_full())
+		return arch_mmap_rnd();
+	else
+		return randomize_page(mm->brk, 0x02000000);
 }
 
 /*
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index c90c20904a60..31b0e4e1a4c1 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -21,6 +21,7 @@
 #include <linux/elf-randomize.h>
 #include <asm/elf.h>
 #include <asm/io.h>
+#include <linux/security.h>
 
 #include "physaddr.h"
 
@@ -122,6 +123,8 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 	*legacy_base = mmap_legacy_base(random_factor, task_size);
 	if (mmap_is_legacy())
 		*base = *legacy_base;
+	else if (can_randomize_full())
+		*base = mmap_min_addr;
 	else
 		*base = mmap_base(random_factor, task_size, rlim_stack);
 }
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fa50e8936f5f..8d681e06cfcd 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1108,7 +1108,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * without MAP_FIXED).
 			 */
 			if (interpreter) {
-				load_bias = ELF_ET_DYN_BASE;
+				if (can_randomize_full())
+					/* more space for randomization */
+					load_bias = mmap_min_addr;
+				else
+					load_bias = ELF_ET_DYN_BASE;
+
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
 				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
@@ -1277,6 +1282,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 
 		mm->brk = mm->start_brk = arch_randomize_brk(mm);
+		if (can_randomize_full()) {
+			unsigned long random_offset = get_random_int() & ~PAGE_MASK & ~0xf;
+			mm->brk += random_offset;
+			retval = vm_brk_flags(mm->start_brk, random_offset, 0);
+			if (retval)
+				goto out;
+		}
 #ifdef compat_brk_randomized
 		current->brk_randomized = 1;
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..2e8c088f83e3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/sizes.h>
 #include <linux/sched.h>
 #include <linux/pgtable.h>
+#include <linux/compat.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2985,8 +2986,17 @@ void drop_slab_node(int nid);
 
 #ifndef CONFIG_MMU
 #define randomize_va_space 0
+static inline bool can_randomize_full(void) { return false; }
 #else
 extern int randomize_va_space;
+static inline bool can_randomize_full(void)
+{
+	/* Don't randomize 32 bit applications */
+	return !(current->personality & (ADDR_NO_RANDOMIZE | ADDR_COMPAT_LAYOUT
+					 | ADDR_LIMIT_32BIT | ADDR_LIMIT_3GB))
+		&& !(IS_ENABLED(CONFIG_64BIT) && in_32bit_syscall())
+		&& randomize_va_space == 3;
+}
 #endif
 
 const char * arch_vma_name(struct vm_area_struct *vma);
diff --git a/init/Kconfig b/init/Kconfig
index 0872a5a2e759..3b8982262b06 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1873,7 +1873,7 @@ config COMPAT_BRK
 	  also breaks ancient binaries (including anything libc5 based).
 	  This option changes the bootup default to heap randomization
 	  disabled, and can be overridden at runtime by setting
-	  /proc/sys/kernel/randomize_va_space to 2.
+	  /proc/sys/kernel/randomize_va_space to 2 or 3.
 
 	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 5c8b4485860d..a55f32981946 100644
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
@@ -2281,10 +2284,30 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		get_area = shmem_get_unmapped_area;
 	}
 
+	/* Pick a random address even outside current VMAs? */
+	if (!addr && can_randomize_full()) {
+		int i;
+		unsigned long new_addr;
+
+		/* Try a few times to find a free area */
+		for (i = 0; i < MAX_RANDOM_MMAP_RETRIES; i++) {
+			new_addr = arch_mmap_rnd();
+
+			new_addr = get_area(file, new_addr, len, pgoff,
+					    flags | MAP_FIXED_NOREPLACE);
+			if (!IS_ERR_VALUE(new_addr)) {
+				addr = new_addr;
+				goto found;
+			}
+		}
+		/* failed, retry with original addr */
+	}
+
 	addr = get_area(file, addr, len, pgoff, flags);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
+ found:
 	if (addr > TASK_SIZE - len)
 		return -ENOMEM;
 	if (offset_in_page(addr))
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..9cdb680318e8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -665,6 +665,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	unsigned long charged = 0;
 	bool locked = false;
 	bool downgraded = false;
+	bool randomize = false;
 	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
@@ -720,6 +721,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	randomize = (flags & MREMAP_MAYMOVE) && can_randomize_full();
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
@@ -730,7 +732,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		int retval;
 
 		retval = __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
+				     &uf_unmap, !randomize);
 		if (retval < 0 && old_len != new_len) {
 			ret = retval;
 			goto out;
@@ -738,6 +740,16 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		} else if (retval == 1)
 			downgraded = true;
 		ret = addr;
+
+		/*
+		 * Caller is happy with a new address, so let's move
+		 * even if not necessary
+		 */
+		if (randomize)
+			ret = mremap_to(addr, new_len, 0, new_len,
+					&locked, flags, &uf, &uf_unmap_early,
+					&uf_unmap);
+
 		goto out;
 	}
 
@@ -751,8 +763,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	}
 
 	/* old_len exactly to the end of the area..
+	 * But when randomizing, don't just expand the mapping if
+	 * caller is happy with a moved and resized mapping
 	 */
-	if (old_len == vma->vm_end - addr) {
+	if (old_len == vma->vm_end - addr && !randomize) {
 		/* can we just expand the current mapping? */
 		if (vma_expandable(vma, new_len - old_len)) {
 			int pages = (new_len - old_len) >> PAGE_SHIFT;
diff --git a/mm/util.c b/mm/util.c
index 4ddb6e186dd5..475d4eaa8ff1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -320,6 +320,9 @@ unsigned long randomize_stack_top(unsigned long stack_top)
 	unsigned long random_variable = 0;
 
 	if (current->flags & PF_RANDOMIZE) {
+		if (can_randomize_full())
+			return arch_mmap_rnd();
+
 		random_variable = get_random_long();
 		random_variable &= STACK_RND_MASK;
 		random_variable <<= PAGE_SHIFT;
@@ -338,6 +341,9 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
 		return randomize_page(mm->brk, SZ_32M);
 
+	if (can_randomize_full())
+		return arch_mmap_rnd();
+
 	return randomize_page(mm->brk, SZ_1G);
 }
 
@@ -412,7 +418,10 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
-	mm->mmap_base = TASK_UNMAPPED_BASE;
+	if (can_randomize_full())
+		mm->mmap_base = mmap_min_addr;
+	else
+		mm->mmap_base = TASK_UNMAPPED_BASE;
 	mm->get_unmapped_area = arch_get_unmapped_area;
 }
 #endif

base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
-- 
2.29.2

