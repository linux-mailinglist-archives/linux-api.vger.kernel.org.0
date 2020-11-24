Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805422C2FF0
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 19:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390858AbgKXS1X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 13:27:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:33228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbgKXS1V (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 24 Nov 2020 13:27:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 392D8AC2D;
        Tue, 24 Nov 2020 18:27:20 +0000 (UTC)
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
To:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20201026160518.9212-1-toiwoton@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1b07c7ec-b95e-7db2-6404-eb8210162fbc@suse.cz>
Date:   Tue, 24 Nov 2020 19:27:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201026160518.9212-1-toiwoton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Please CC linux-api on future versions.

On 10/26/20 5:05 PM, Topi Miettinen wrote:
> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> enables full randomization of memory mappings created with mmap(NULL,
> ...). With 2, the base of the VMA used for such mappings is random,
> but the mappings are created in predictable places within the VMA and
> in sequential order. With 3, new VMAs are created to fully randomize
> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> even if not necessary.
> 
> The method is to randomize the new address without considering
> VMAs. If the address fails checks because of overlap with the stack
> area (or in case of mremap(), overlap with the old mapping), the
> operation is retried a few times before falling back to old method.
> 
> On 32 bit systems this may cause problems due to increased VM
> fragmentation if the address space gets crowded.
> 
> On all systems, it will reduce performance and increase memory
> usage due to less efficient use of page tables and inability to
> merge adjacent VMAs with compatible attributes.
> 
> In this example with value of 2, dynamic loader, libc, anonymous
> memory reserved with mmap() and locale-archive are located close to
> each other:
> 
> $ cat /proc/self/maps (only first line for each object shown for brevity)
> 58c1175b1000-58c1175b3000 r--p 00000000 fe:0c 1868624                    /usr/bin/cat
> 79752ec17000-79752f179000 r--p 00000000 fe:0c 2473999                    /usr/lib/locale/locale-archive
> 79752f179000-79752f279000 rw-p 00000000 00:00 0
> 79752f279000-79752f29e000 r--p 00000000 fe:0c 2402415                    /usr/lib/x86_64-linux-gnu/libc-2.31.so
> 79752f43a000-79752f440000 rw-p 00000000 00:00 0
> 79752f46f000-79752f470000 r--p 00000000 fe:0c 2400484                    /usr/lib/x86_64-linux-gnu/ld-2.31.so
> 79752f49b000-79752f49c000 rw-p 00000000 00:00 0
> 7ffdcad9e000-7ffdcadbf000 rw-p 00000000 00:00 0                          [stack]
> 7ffdcadd2000-7ffdcadd6000 r--p 00000000 00:00 0                          [vvar]
> 7ffdcadd6000-7ffdcadd8000 r-xp 00000000 00:00 0                          [vdso]
> 
> With 3, they are located at unrelated addresses:
> $ echo 3 > /proc/sys/kernel/randomize_va_space
> $ cat /proc/self/maps (only first line for each object shown for brevity)
> 1206a8fa000-1206a8fb000 r--p 00000000 fe:0c 2400484                      /usr/lib/x86_64-linux-gnu/ld-2.31.so
> 1206a926000-1206a927000 rw-p 00000000 00:00 0
> 19174173000-19174175000 rw-p 00000000 00:00 0
> ac82f419000-ac82f519000 rw-p 00000000 00:00 0
> afa66a42000-afa66fa4000 r--p 00000000 fe:0c 2473999                      /usr/lib/locale/locale-archive
> d8656ba9000-d8656bce000 r--p 00000000 fe:0c 2402415                      /usr/lib/x86_64-linux-gnu/libc-2.31.so
> d8656d6a000-d8656d6e000 rw-p 00000000 00:00 0
> 5df90b712000-5df90b714000 r--p 00000000 fe:0c 1868624                    /usr/bin/cat
> 7ffe1be4c000-7ffe1be6d000 rw-p 00000000 00:00 0                          [stack]
> 7ffe1bf07000-7ffe1bf0b000 r--p 00000000 00:00 0                          [vvar]
> 7ffe1bf0b000-7ffe1bf0d000 r-xp 00000000 00:00 0                          [vdso]
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Jann Horn <jannh@google.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
> v2: also randomize mremap(..., MREMAP_MAYMOVE)
> v3: avoid stack area and retry in case of bad random address (Jann
> Horn), improve description in kernel.rst (Matthew Wilcox)
> v4: use /proc/$pid/maps in the example (Mike Rapaport), CCs (Andrew
> Morton), only check randomize_va_space == 3
> ---
>   Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++--
>   Documentation/admin-guide/sysctl/kernel.rst   | 15 ++++++++++
>   init/Kconfig                                  |  2 +-
>   mm/internal.h                                 |  8 +++++
>   mm/mmap.c                                     | 30 +++++++++++++------
>   mm/mremap.c                                   | 27 +++++++++++++++++
>   6 files changed, 75 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index e05e581af5cf..9ea250522077 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -254,7 +254,7 @@ Spectre variant 2
>      left by the previous process will also be cleared.
>   
>      User programs should use address space randomization to make attacks
> -   more difficult (Set /proc/sys/kernel/randomize_va_space = 1 or 2).
> +   more difficult (Set /proc/sys/kernel/randomize_va_space = 1, 2 or 3).
>   
>   3. A virtualized guest attacking the host
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> @@ -499,8 +499,8 @@ Spectre variant 2
>      more overhead and run slower.
>   
>      User programs should use address space randomization
> -   (/proc/sys/kernel/randomize_va_space = 1 or 2) to make attacks more
> -   difficult.
> +   (/proc/sys/kernel/randomize_va_space = 1, 2 or 3) to make attacks
> +   more difficult.
>   
>   3. VM mitigation
>   ^^^^^^^^^^^^^^^^
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index d4b32cc32bb7..bc3bb74d544d 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1060,6 +1060,21 @@ that support this feature.
>       Systems with ancient and/or broken binaries should be configured
>       with ``CONFIG_COMPAT_BRK`` enabled, which excludes the heap from process
>       address space randomization.
> +
> +3   Additionally enable full randomization of memory mappings created
> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
> +    mappings is random, but the mappings are created in predictable
> +    places within the VMA and in sequential order. With 3, new VMAs
> +    are created to fully randomize the mappings. Also mremap(...,
> +    MREMAP_MAYMOVE) will move the mappings even if not necessary.
> +
> +    On 32 bit systems this may cause problems due to increased VM
> +    fragmentation if the address space gets crowded.
> +
> +    On all systems, it will reduce performance and increase memory
> +    usage due to less efficient use of page tables and inability to
> +    merge adjacent VMAs with compatible attributes.
> +
>   ==  ===========================================================================
>   
>   
> diff --git a/init/Kconfig b/init/Kconfig
> index c9446911cf41..6146e2cd3b77 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1863,7 +1863,7 @@ config COMPAT_BRK
>   	  also breaks ancient binaries (including anything libc5 based).
>   	  This option changes the bootup default to heap randomization
>   	  disabled, and can be overridden at runtime by setting
> -	  /proc/sys/kernel/randomize_va_space to 2.
> +	  /proc/sys/kernel/randomize_va_space to 2 or 3.
>   
>   	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
>   
> diff --git a/mm/internal.h b/mm/internal.h
> index c43ccdddb0f6..b964c8dbb242 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -618,4 +618,12 @@ struct migration_target_control {
>   	gfp_t gfp_mask;
>   };
>   
> +#ifndef arch_get_mmap_end
> +#define arch_get_mmap_end(addr)	(TASK_SIZE)
> +#endif
> +
> +#ifndef arch_get_mmap_base
> +#define arch_get_mmap_base(addr, base) (base)
> +#endif
> +
>   #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d91ecb00d38c..3677491e999b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -47,6 +47,7 @@
>   #include <linux/pkeys.h>
>   #include <linux/oom.h>
>   #include <linux/sched/mm.h>
> +#include <linux/elf-randomize.h>
>   
>   #include <linux/uaccess.h>
>   #include <asm/cacheflush.h>
> @@ -73,6 +74,8 @@ const int mmap_rnd_compat_bits_max = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX;
>   int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
>   #endif
>   
> +#define MAX_RANDOM_MMAP_RETRIES			5
> +
>   static bool ignore_rlimit_data;
>   core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
>   
> @@ -206,7 +209,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>   #ifdef CONFIG_COMPAT_BRK
>   	/*
>   	 * CONFIG_COMPAT_BRK can still be overridden by setting
> -	 * randomize_va_space to 2, which will still cause mm->start_brk
> +	 * randomize_va_space to >= 2, which will still cause mm->start_brk
>   	 * to be arbitrarily shifted
>   	 */
>   	if (current->brk_randomized)
> @@ -1445,6 +1448,23 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>   	if (mm->map_count > sysctl_max_map_count)
>   		return -ENOMEM;
>   
> +	/* Pick a random address even outside current VMAs? */
> +	if (!addr && randomize_va_space == 3) {
> +		int i = MAX_RANDOM_MMAP_RETRIES;
> +		unsigned long max_addr = arch_get_mmap_base(addr, mm->mmap_base);
> +
> +		do {
> +			/* Try a few times to find a free area */
> +			addr = arch_mmap_rnd();
> +			if (addr >= max_addr)
> +				continue;
> +			addr = get_unmapped_area(file, addr, len, pgoff, flags);
> +		} while (--i >= 0 && !IS_ERR_VALUE(addr));
> +
> +		if (IS_ERR_VALUE(addr))
> +			addr = 0;
> +	}
> +
>   	/* Obtain the address to map to. we verify (or select) it and ensure
>   	 * that it represents a valid section of the address space.
>   	 */
> @@ -2142,14 +2162,6 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
>   	return addr;
>   }
>   
> -#ifndef arch_get_mmap_end
> -#define arch_get_mmap_end(addr)	(TASK_SIZE)
> -#endif
> -
> -#ifndef arch_get_mmap_base
> -#define arch_get_mmap_base(addr, base) (base)
> -#endif
> -
>   /* Get an address range which is currently unmapped.
>    * For shmat() with addr=0.
>    *
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 138abbae4f75..c5b2ed2bfd2d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -24,12 +24,15 @@
>   #include <linux/uaccess.h>
>   #include <linux/mm-arch-hooks.h>
>   #include <linux/userfaultfd_k.h>
> +#include <linux/elf-randomize.h>
>   
>   #include <asm/cacheflush.h>
>   #include <asm/tlbflush.h>
>   
>   #include "internal.h"
>   
> +#define MAX_RANDOM_MREMAP_RETRIES		5
> +
>   static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
>   {
>   	pgd_t *pgd;
> @@ -720,6 +723,30 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>   		goto out;
>   	}
>   
> +	if ((flags & MREMAP_MAYMOVE) && randomize_va_space == 3) {
> +		/*
> +		 * Caller is happy with a different address, so let's
> +		 * move even if not necessary!
> +		 */
> +		int i = MAX_RANDOM_MREMAP_RETRIES;
> +		unsigned long max_addr = arch_get_mmap_base(addr, mm->mmap_base);
> +
> +		do {
> +			/* Try a few times to find a free area */
> +			new_addr = arch_mmap_rnd();
> +			if (new_addr >= max_addr)
> +				continue;
> +			ret = mremap_to(addr, old_len, new_addr, new_len,
> +					&locked, flags, &uf, &uf_unmap_early,
> +					&uf_unmap);
> +			if (!IS_ERR_VALUE(ret))
> +				goto out;
> +		} while (--i >= 0);
> +
> +		/* Give up and try the old address */
> +		new_addr = addr;
> +	}
> +
>   	/*
>   	 * Always allow a shrinking remap: that just unmaps
>   	 * the unnecessary pages..
> 
> base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> 

