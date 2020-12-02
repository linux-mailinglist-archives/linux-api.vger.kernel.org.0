Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52702CC5D7
	for <lists+linux-api@lfdr.de>; Wed,  2 Dec 2020 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgLBStx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 13:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLBStx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Dec 2020 13:49:53 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7CC0613CF;
        Wed,  2 Dec 2020 10:49:12 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id q13so6340333lfr.10;
        Wed, 02 Dec 2020 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z7Occ6QQRLgly37lQDgbSEZYUjmXZTvC7QjjqidC2eY=;
        b=Zv1lSt0kkO+xVLvVvkQa1gYezanG+UOAGhE07I0cRVGzkp2HbXxvZnsYTrUUV07Q1i
         wv0gDdYv6+cwcOaDg+McaTCWgI7WYoXApK7SpCapBJ2Deo40Sk7jV0mPcYRGCoiGSQ8y
         +GKiew1r+WyBVo45m7IoGpP2wQN/dcbwYEUi4Yr46eVtMD9IZXiRcIlfb/xPRmuUOPav
         Vmv2i0R8jWaEPcH8+Z72/bR/xQpnDPjbptxVic3Bv+va9E1Tua+J+LIbwPz2LRJ3GtMh
         3suy8EMZAyrlFG1Hu93uQgfpoYFPoy0cKBgmVwS0/fSzY3Vy16EHuNfkGCWwmyo8/nb/
         wCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7Occ6QQRLgly37lQDgbSEZYUjmXZTvC7QjjqidC2eY=;
        b=T0u5jGJBKsL9XlVDyixSAU7aQ4JKWQnXuzKOOzQFDwRGJmvxDyfGWA7O7s04SSMuTu
         V9JTD7KB1ALbYmfm4OTy5aEMfz+yfAmiA6QI19PC76rWQJmqJsAUzIbnZyRHFH9ggRXF
         B0Xh0EuSFeSfD4pg9ISMI+/Ej5SaKKpXf4+V6AntgVia0jG438JTC997CFdc/nsAVYO3
         xezxe8SpYL1EBOiRFOHLn7ggc12VudSYuFERXpIQarcoufHvESZSriOd9sK1FvU2ZCGB
         HvEwkcPu1xry0l8LPotQiOffKCFxAPyntf8DadOWjHlhvVR9GjvNjgw4bT8FRVNemWf3
         Ln0Q==
X-Gm-Message-State: AOAM530/UFrB10h+FvkCAt+s0/iudIiBufzqvayCQhJL/aJABKVr03a4
        KweDgP4vBr0Fyruhwd2glHc=
X-Google-Smtp-Source: ABdhPJx3iqF6eqZZWnJWAb5+eoUbWhwOHiqC1H0FiKBw/QkQTkFHBygeRDA1/3We9EJOZDxCIi2caw==
X-Received: by 2002:a19:83c9:: with SMTP id f192mr1906576lfd.302.1606934951433;
        Wed, 02 Dec 2020 10:49:11 -0800 (PST)
Received: from [192.168.1.39] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id q16sm747757ljj.32.2020.12.02.10.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:49:10 -0800 (PST)
Subject: Re: [PATCH] mm/vmalloc: randomize vmalloc() allocations
To:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20201201214547.9721-1-toiwoton@gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <9d34fb0a-7aba-1e84-6426-006ea7c3d9f5@gmail.com>
Date:   Wed, 2 Dec 2020 20:49:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201214547.9721-1-toiwoton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1.12.2020 23.45, Topi Miettinen wrote:
> Memory mappings inside kernel allocated with vmalloc() are in
> predictable order and packed tightly toward the low addresses. With
> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
> used randomly to make the allocations less predictable and harder to
> guess for attackers.
> 
> Without randomize_vmalloc=1:
> $ cat /proc/vmallocinfo
> 0xffffc90000000000-0xffffc90000002000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe1000 ioremap
> 0xffffc90000002000-0xffffc90000005000   12288 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe0000 ioremap
> 0xffffc90000005000-0xffffc90000007000    8192 hpet_enable+0x36/0x4a9 phys=0x00000000fed00000 ioremap
> 0xffffc90000007000-0xffffc90000009000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> 0xffffc90000009000-0xffffc9000000b000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> 0xffffc9000000b000-0xffffc9000000d000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> 0xffffc9000000d000-0xffffc9000000f000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> 0xffffc90000011000-0xffffc90000015000   16384 n_tty_open+0x16/0xe0 pages=3 vmalloc
> 0xffffc900003de000-0xffffc900003e0000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x00000000fed00000 ioremap
> 0xffffc900003e0000-0xffffc900003e2000    8192 memremap+0x1a1/0x280 phys=0x00000000000f5000 ioremap
> 0xffffc900003e2000-0xffffc900003f3000   69632 pcpu_create_chunk+0x80/0x2c0 pages=16 vmalloc
> 0xffffc900003f3000-0xffffc90000405000   73728 pcpu_create_chunk+0xb7/0x2c0 pages=17 vmalloc
> 0xffffc90000405000-0xffffc9000040a000   20480 pcpu_create_chunk+0xed/0x2c0 pages=4 vmalloc
> 0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x1a40 vmalloc
> 
> With randomize_vmalloc=1, the allocations are randomized:
> $ cat /proc/vmallocinfo
> 0xffffca3a36442000-0xffffca3a36447000   20480 pcpu_create_chunk+0xed/0x2c0 pages=4 vmalloc
> 0xffffca63034d6000-0xffffca63034d9000   12288 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe0000 ioremap
> 0xffffcce23d32e000-0xffffcce23d330000    8192 memremap+0x1a1/0x280 phys=0x00000000000f5000 ioremap
> 0xffffcfb9f0e22000-0xffffcfb9f0e24000    8192 hpet_enable+0x36/0x4a9 phys=0x00000000fed00000 ioremap
> 0xffffd1df23e9e000-0xffffd1df23eb0000   73728 pcpu_create_chunk+0xb7/0x2c0 pages=17 vmalloc
> 0xffffd690c2990000-0xffffd690c2992000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe1000 ioremap
> 0xffffd8460c718000-0xffffd8460c71c000   16384 n_tty_open+0x16/0xe0 pages=3 vmalloc
> 0xffffd89aba709000-0xffffd89aba70b000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> 0xffffe0ca3f2ed000-0xffffe0ca3f2ef000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x00000000fed00000 ioremap
> 0xffffe3ba44802000-0xffffe3ba44804000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> 0xffffe4524b2a2000-0xffffe4524b2a4000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> 0xffffe61372b2e000-0xffffe61372b30000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> 0xffffe704d2f7c000-0xffffe704d2f8d000   69632 pcpu_create_chunk+0x80/0x2c0 pages=16 vmalloc
> 0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x1a40 vmalloc
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Jann Horn <jannh@google.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Linux API <linux-api@vger.kernel.org>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  2 ++
>   mm/vmalloc.c                                  | 25 +++++++++++++++++--
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 44fde25bb221..a0242e31d2d8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4017,6 +4017,8 @@
>   
>   	ramdisk_start=	[RAM] RAM disk image start address
>   
> +	randomize_vmalloc= [KNL] Randomize vmalloc() allocations.
> +
>   	random.trust_cpu={on,off}
>   			[KNL] Enable or disable trusting the use of the
>   			CPU's random number generator (if available) to
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6ae491a8b210..a5f7bb46ddf2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -34,6 +34,7 @@
>   #include <linux/bitops.h>
>   #include <linux/rbtree_augmented.h>
>   #include <linux/overflow.h>
> +#include <linux/random.h>
>   
>   #include <linux/uaccess.h>
>   #include <asm/tlbflush.h>
> @@ -1079,6 +1080,17 @@ adjust_va_to_fit_type(struct vmap_area *va,
>   	return 0;
>   }
>   
> +static int randomize_vmalloc = 0;
> +
> +static int __init set_randomize_vmalloc(char *str)
> +{
> +	if (!str)
> +		return 0;
> +	randomize_vmalloc = simple_strtoul(str, &str, 0);
> +	return 1;
> +}
> +__setup("randomize_vmalloc=", set_randomize_vmalloc);
> +
>   /*
>    * Returns a start address of the newly allocated area, if success.
>    * Otherwise a vend is returned that indicates failure.
> @@ -1152,7 +1164,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>   				int node, gfp_t gfp_mask)
>   {
>   	struct vmap_area *va, *pva;
> -	unsigned long addr;
> +	unsigned long addr, voffset;
>   	int purged = 0;
>   	int ret;
>   
> @@ -1207,11 +1219,20 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>   	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
>   		kmem_cache_free(vmap_area_cachep, pva);
>   
> +	/* Randomize allocation */
> +	if (randomize_vmalloc) {
> +		voffset = get_random_long() & (roundup_pow_of_two(vend - vstart) - 1);
> +		voffset = PAGE_ALIGN(voffset);
> +		if (voffset + size > vend - vstart)
> +			voffset = vend - vstart - size;
> +	} else
> +		voffset = 0;
> +
>   	/*
>   	 * If an allocation fails, the "vend" address is
>   	 * returned. Therefore trigger the overflow path.
>   	 */
> -	addr = __alloc_vmap_area(size, align, vstart, vend);
> +	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);

Does not work so well after all:

Dec 02 18:25:01 kernel: systemd-udevd: vmalloc: allocation failure: 
10526720 bytes, mode:0xcc0(GFP_KERNEL), 
nodemask=(null),cpuset=/,mems_allowed=0
Dec 02 18:25:01 kernel: CPU: 12 PID: 716 Comm: systemd-udevd Tainted: G 
            E     5.10.0-rc5+ #25
Dec 02 18:25:01 kernel: Hardware name: <redacted>
Dec 02 18:25:01 kernel: Call Trace:
Dec 02 18:25:01 kernel:  dump_stack+0x7d/0xa3
Dec 02 18:25:01 kernel:  warn_alloc.cold+0x83/0x126
Dec 02 18:25:01 kernel:  ? zone_watermark_ok_safe+0x140/0x140
Dec 02 18:25:01 kernel:  ? __kasan_slab_free+0x122/0x150
Dec 02 18:25:01 kernel:  ? slab_free_freelist_hook+0x66/0x110
Dec 02 18:25:01 kernel:  ? kfree+0xba/0x3e0
Dec 02 18:25:01 kernel:  __vmalloc_node_range+0xd7/0xf0
Dec 02 18:25:01 kernel:  ? load_module+0x29e0/0x3f40
Dec 02 18:25:01 kernel:  module_alloc+0x9f/0x110
Dec 02 18:25:01 kernel:  ? load_module+0x29e0/0x3f40
Dec 02 18:25:01 kernel:  load_module+0x29e0/0x3f40
Dec 02 18:25:01 kernel:  ? ima_post_read_file+0x140/0x150
Dec 02 18:25:01 kernel:  ? module_frob_arch_sections+0x20/0x20
Dec 02 18:25:01 kernel:  ? kernel_read_file+0x1d2/0x3e0
Dec 02 18:25:01 kernel:  ? __x64_sys_fsopen+0x1f0/0x1f0
Dec 02 18:25:01 kernel:  ? up_write+0x92/0x140
Dec 02 18:25:01 kernel:  ? downgrade_write+0x160/0x160
Dec 02 18:25:01 kernel:  ? kernel_read_file_from_fd+0x4b/0x90
Dec 02 18:25:01 kernel:  __do_sys_finit_module+0x110/0x1a0
Dec 02 18:25:01 kernel:  ? __x64_sys_init_module+0x50/0x50
Dec 02 18:25:01 kernel:  ? get_nth_filter.part.0+0x160/0x160
Dec 02 18:25:01 kernel:  ? randomize_stack_top+0x70/0x70
Dec 02 18:25:01 kernel:  ? __x64_sys_fstat+0x30/0x30
Dec 02 18:25:01 kernel:  ? __audit_syscall_entry+0x16a/0x1d0
Dec 02 18:25:01 kernel:  ? ktime_get_coarse_real_ts64+0x4a/0x70
Dec 02 18:25:01 kernel:  do_syscall_64+0x33/0x40
Dec 02 18:25:01 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec 02 18:25:01 kernel: RIP: 0033:0xdd0fd2fb989
Dec 02 18:25:01 kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 
44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 54 0c 00 f7 d8 64 
89 01 48
Dec 02 18:25:01 kernel: RSP: 002b:00000ceb4f03f028 EFLAGS: 00000246 
ORIG_RAX: 0000000000000139
Dec 02 18:25:01 kernel: RAX: ffffffffffffffda RBX: 00000ef04a12fa90 RCX: 
00000dd0fd2fb989
Dec 02 18:25:01 kernel: RDX: 0000000000000000 RSI: 000003b119220e4d RDI: 
0000000000000017
Dec 02 18:25:01 kernel: RBP: 0000000000020000 R08: 0000000000000000 R09: 
00000ef04a11b018
Dec 02 18:25:01 kernel: R10: 0000000000000017 R11: 0000000000000246 R12: 
000003b119220e4d
Dec 02 18:25:01 kernel: R13: 0000000000000000 R14: 00000ef04a124a10 R15: 
00000ef04a12fa90
Dec 02 18:25:01 kernel: Mem-Info:
Dec 02 18:25:01 kernel: active_anon:96 inactive_anon:17667 isolated_anon:0
                          active_file:15598 inactive_file:35563 
isolated_file:0
                          unevictable:0 dirty:0 writeback:0
                          slab_reclaimable:8064 slab_unreclaimable:159447
                          mapped:10434 shmem:229 pagetables:5844 bounce:0
                          free:3176890 free_pcp:2892 free_cma:0
Dec 02 18:25:01 kernel: Node 0 active_anon:384kB inactive_anon:70668kB 
active_file:62392kB inactive_file:142252kB unevictable:0kB 
isolated(anon):0kB isolated(file):0kB mapped:41736kB dirty:0kB 
writeback:0kB shmem:916kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 
0kB wri>
Dec 02 18:25:01 kernel: DMA free:13860kB min:76kB low:92kB high:108kB 
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:15996kB managed:15908kB mlocked:0kB pagetables:0kB bounce:0kB 
free_pc>
Dec 02 18:25:01 kernel: lowmem_reserve[]: 0 2650 13377 13377 13377
Dec 02 18:25:01 kernel: DMA32 free:2790432kB min:13372kB low:16712kB 
high:20052kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:2796348kB managed:2796008kB mlocked:0kB pagetables:0kB bo>
Dec 02 18:25:01 kernel: lowmem_reserve[]: 0 0 10726 10726 10726
Dec 02 18:25:01 kernel: Normal free:9903268kB min:54128kB low:67660kB 
high:81192kB reserved_highatomic:0KB active_anon:384kB 
inactive_anon:70668kB active_file:62392kB inactive_file:142252kB 
unevictable:0kB writepending:0kB present:13356288kB managed:10991672kB 
mlocked:0kB>
Dec 02 18:25:01 kernel: lowmem_reserve[]: 0 0 0 0 0
Dec 02 18:25:01 kernel: DMA: 3*4kB (U) 1*8kB (U) 1*16kB (U) 0*32kB 
2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 2*2048kB (UM) 
2*4096kB (M) = 13860kB
Dec 02 18:25:01 kernel: DMA32: 12*4kB (UM) 10*8kB (UM) 8*16kB (M) 9*32kB 
(M) 8*64kB (UM) 6*128kB (UM) 7*256kB (UM) 9*512kB (UM) 5*1024kB (UM) 
6*2048kB (M) 675*4096kB (M) = 2790432kB
Dec 02 18:25:01 kernel: Normal: 82*4kB (UE) 1*8kB (E) 3*16kB (UME) 
16*32kB (UM) 1*64kB (U) 1*128kB (U) 1*256kB (M) 6*512kB (UM) 8*1024kB 
(UME) 1*2048kB (E) 2414*4096kB (M) = 9902400kB

I suppose the random address happened to be too near 'vend' and no 
suitable block was found. Perhaps the search in __alloc_vmap_area() 
should then continue at 'vstart' instead (so __alloc_vmap_area() would 
be passed all three of vstart, voffset, vend instead of just 
vstart+voffset, vend).

This also seems to randomize module addresses. I was going to check that 
next, so nice surprise!

-Topi

>   	spin_unlock(&free_vmap_area_lock);
>   
>   	if (unlikely(addr == vend))
> 

