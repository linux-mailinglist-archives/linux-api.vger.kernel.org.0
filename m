Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EFD31AB1B
	for <lists+linux-api@lfdr.de>; Sat, 13 Feb 2021 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBML4J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Feb 2021 06:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBML4G (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 13 Feb 2021 06:56:06 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425F1C061574;
        Sat, 13 Feb 2021 03:55:26 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e18so2112625lja.12;
        Sat, 13 Feb 2021 03:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=entBnJn19nsWIMP3ljcDmh7+ovRnakmm9Ih4/n9D9Fg=;
        b=rwr5U4dSzJyQco0CXaOfcsjOgQ5YULXqTyVo9IMK4TZMlrAtVN89Gq3+ILolGxGaGs
         FwnqVTLlfDt668Uizfq9yf9tWRjSfX45LpKGbJW9+v5qjDnpzz/c8iuoYOxAMVxHp4E5
         AJLZyGZ1BXHyRfKUM0raXp1lV9yg3cS3cqBakm0dNauWZHbpDUriMoByDqJd+iAHWmr4
         2nHVy98ykLZVH2aFvy1Oez4XvLbPVWvNwDlMeZfRS6qmxzqeBDBqk2TJKkRcrhYtLSjG
         Xk7MF0wyMlPJfYfUHtUpB4yAGgac7G71whQnZhTpo7TRS6VGjnKfrYoc5k4rGV2b+/4q
         fRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=entBnJn19nsWIMP3ljcDmh7+ovRnakmm9Ih4/n9D9Fg=;
        b=kvFAoHxTN9l/ql4JbHDJbicFkdTkpMMOw/b+wvPtblyIMT/MiHNazCX5thnpMbDUxy
         izrU1wHyHRI14YSs60AGAPyUiFOq3eUBeognBH3kVKqowc9pt2ZFM7GV8FpgI2EWukUx
         KJvg/CTGQzKjgTo4/VgkZ2x9RW01QnNvrsklGKnYsAQQCUStsAcobr7zAnKKdKfKHdcY
         SAjKgAGcFuzIbBu0ywssiFv1Sx5NxhRmNRW4Xe1N2mWguFhBh7x7FAwKk7G+F8xKUF73
         2WBZo7BSMRW3nQ6lTPSQ0kzoAwoWS+0A5LTGH3UTNHwK8adm4ygCtWp1LzYg6V6BscjQ
         e6/g==
X-Gm-Message-State: AOAM533C2S34R9vj4EQx9SXsy/WsUXBAxYK47WQzfYWczIKhtjwKboIp
        fWNHeFwScoshZN7YmSXft/Y=
X-Google-Smtp-Source: ABdhPJyQYCGpTsBOswvP0HwawUz1smrtuCh+otNQioeLcxg9UlJTX5Eo8bizeGrZSjsWQ87Y2IYwDg==
X-Received: by 2002:a2e:a58c:: with SMTP id m12mr4285130ljp.444.1613217324402;
        Sat, 13 Feb 2021 03:55:24 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m16sm1859198lfu.220.2021.02.13.03.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:55:23 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sat, 13 Feb 2021 12:55:21 +0100
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2] mm/vmalloc: randomize vmalloc() allocations
Message-ID: <20210213115521.GA1907@pc638.lan>
References: <20201212175635.4217-1-toiwoton@gmail.com>
 <795016db-93fa-72ea-f5dd-16b9c56a62e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795016db-93fa-72ea-f5dd-16b9c56a62e9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> Hello,
> 
> Is there a chance of getting this reviewed and maybe even merged, please?
> 
> -Topi
> 
I can review it and help with it. But before that i would like to
clarify if such "randomization" is something that you can not leave?

For example on 32bit system vmalloc space is limited, such randomization
can slow down it, also it will lead to failing of allocations much more,
thus it will require repeating with different offset.

Second. There is a space or region for modules. Using various offsets
can waste of that memory, thus can lead to failing of module loading.

On the other side there is a per-cpu allocator. Interfering with it
also will increase a rate of failing.

--
Vlad Rezki

> > Memory mappings inside kernel allocated with vmalloc() are in
> > predictable order and packed tightly toward the low addresses. With
> > new kernel boot parameter 'randomize_vmalloc=1', the entire area is
> > used randomly to make the allocations less predictable and harder to
> > guess for attackers. Also module and BPF code locations get randomized
> > (within their dedicated and rather small area though) and if
> > CONFIG_VMAP_STACK is enabled, also kernel thread stack locations.
> > 
> > On 32 bit systems this may cause problems due to increased VM
> > fragmentation if the address space gets crowded.
> > 
> > On all systems, it will reduce performance and increase memory and
> > cache usage due to less efficient use of page tables and inability to
> > merge adjacent VMAs with compatible attributes. On x86_64 with 5 level
> > page tables, in the worst case, additional page table entries of up to
> > 4 pages are created for each mapping, so with small mappings there's
> > considerable penalty.
> > 
> > Without randomize_vmalloc=1:
> > $ cat /proc/vmallocinfo
> > 0xffffc90000000000-0xffffc90000002000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe1000 ioremap
> > 0xffffc90000002000-0xffffc90000005000   12288 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe0000 ioremap
> > 0xffffc90000005000-0xffffc90000007000    8192 hpet_enable+0x36/0x4a9 phys=0x00000000fed00000 ioremap
> > 0xffffc90000007000-0xffffc90000009000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> > 0xffffc90000009000-0xffffc9000000b000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> > 0xffffc9000000b000-0xffffc9000000d000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> > 0xffffc9000000d000-0xffffc9000000f000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> > 0xffffc90000011000-0xffffc90000015000   16384 n_tty_open+0x16/0xe0 pages=3 vmalloc
> > 0xffffc900003de000-0xffffc900003e0000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x00000000fed00000 ioremap
> > 0xffffc900003e0000-0xffffc900003e2000    8192 memremap+0x1a1/0x280 phys=0x00000000000f5000 ioremap
> > 0xffffc900003e2000-0xffffc900003f3000   69632 pcpu_create_chunk+0x80/0x2c0 pages=16 vmalloc
> > 0xffffc900003f3000-0xffffc90000405000   73728 pcpu_create_chunk+0xb7/0x2c0 pages=17 vmalloc
> > 0xffffc90000405000-0xffffc9000040a000   20480 pcpu_create_chunk+0xed/0x2c0 pages=4 vmalloc
> > 0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x1a40 vmalloc
> > 
> > With randomize_vmalloc=1, the allocations are randomized:
> > $ cat /proc/vmallocinfo
> > 0xffffca3a36442000-0xffffca3a36447000   20480 pcpu_create_chunk+0xed/0x2c0 pages=4 vmalloc
> > 0xffffca63034d6000-0xffffca63034d9000   12288 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe0000 ioremap
> > 0xffffcce23d32e000-0xffffcce23d330000    8192 memremap+0x1a1/0x280 phys=0x00000000000f5000 ioremap
> > 0xffffcfb9f0e22000-0xffffcfb9f0e24000    8192 hpet_enable+0x36/0x4a9 phys=0x00000000fed00000 ioremap
> > 0xffffd1df23e9e000-0xffffd1df23eb0000   73728 pcpu_create_chunk+0xb7/0x2c0 pages=17 vmalloc
> > 0xffffd690c2990000-0xffffd690c2992000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe1000 ioremap
> > 0xffffd8460c718000-0xffffd8460c71c000   16384 n_tty_open+0x16/0xe0 pages=3 vmalloc
> > 0xffffd89aba709000-0xffffd89aba70b000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> > 0xffffe0ca3f2ed000-0xffffe0ca3f2ef000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x00000000fed00000 ioremap
> > 0xffffe3ba44802000-0xffffe3ba44804000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> > 0xffffe4524b2a2000-0xffffe4524b2a4000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> > 0xffffe61372b2e000-0xffffe61372b30000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
> > 0xffffe704d2f7c000-0xffffe704d2f8d000   69632 pcpu_create_chunk+0x80/0x2c0 pages=16 vmalloc
> > 0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x1a40 vmalloc
> > 
> > With CONFIG_VMAP_STACK, also kernel thread stacks are placed in
> > vmalloc area and therefore they also get randomized (only one example
> > line from /proc/vmallocinfo shown for brevity):
> > 
> > unrandomized:
> > 0xffffc90000018000-0xffffc90000021000   36864 kernel_clone+0xf9/0x560 pages=8 vmalloc
> > 
> > randomized:
> > 0xffffcb57611a8000-0xffffcb57611b1000   36864 kernel_clone+0xf9/0x560 pages=8 vmalloc
> > 
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Andy Lutomirski <luto@kernel.org>
> > CC: Jann Horn <jannh@google.com>
> > CC: Kees Cook <keescook@chromium.org>
> > CC: Linux API <linux-api@vger.kernel.org>
> > CC: Matthew Wilcox <willy@infradead.org>
> > CC: Mike Rapoport <rppt@kernel.org>
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> > ---
> > v2: retry allocation from other end of vmalloc space in case of
> > failure (Matthew Wilcox), improve commit message and documentation
> > ---
> >   .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++++
> >   mm/vmalloc.c                                  | 29 +++++++++++++++++--
> >   2 files changed, 50 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 44fde25bb221..9386b1b40a27 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4017,6 +4017,29 @@
> >   	ramdisk_start=	[RAM] RAM disk image start address
> > +	randomize_vmalloc= [KNL] Randomize vmalloc() allocations. With 1,
> > +			the entire vmalloc() area is used randomly to
> > +			make the allocations less predictable and
> > +			harder to guess for attackers. Also module and
> > +			BPF code locations get randomized (within
> > +			their dedicated and rather small area though)
> > +			and if CONFIG_VMAP_STACK is enabled, also
> > +			kernel thread stack locations.
> > +
> > +			On 32 bit systems this may cause problems due
> > +			to increased VM fragmentation if the address
> > +			space gets crowded.
> > +
> > +			On all systems, it will reduce performance and
> > +			increase memory and cache usage due to less
> > +			efficient use of page tables and inability to
> > +			merge adjacent VMAs with compatible
> > +			attributes. On x86_64 with 5 level page
> > +			tables, in the worst case, additional page
> > +			table entries of up to 4 pages are created for
> > +			each mapping, so with small mappings there's
> > +			considerable penalty.
> > +
> >   	random.trust_cpu={on,off}
> >   			[KNL] Enable or disable trusting the use of the
> >   			CPU's random number generator (if available) to
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 6ae491a8b210..d78528af6316 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -34,6 +34,7 @@
> >   #include <linux/bitops.h>
> >   #include <linux/rbtree_augmented.h>
> >   #include <linux/overflow.h>
> > +#include <linux/random.h>
> >   #include <linux/uaccess.h>
> >   #include <asm/tlbflush.h>
> > @@ -1079,6 +1080,17 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >   	return 0;
> >   }
> > +static int randomize_vmalloc = 0;
> > +
> > +static int __init set_randomize_vmalloc(char *str)
> > +{
> > +	if (!str)
> > +		return 0;
> > +	randomize_vmalloc = simple_strtoul(str, &str, 0);
> > +	return 1;
> > +}
> > +__setup("randomize_vmalloc=", set_randomize_vmalloc);
> > +
> >   /*
> >    * Returns a start address of the newly allocated area, if success.
> >    * Otherwise a vend is returned that indicates failure.
> > @@ -1152,7 +1164,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >   				int node, gfp_t gfp_mask)
> >   {
> >   	struct vmap_area *va, *pva;
> > -	unsigned long addr;
> > +	unsigned long addr, voffset;
> >   	int purged = 0;
> >   	int ret;
> > @@ -1207,11 +1219,24 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >   	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
> >   		kmem_cache_free(vmap_area_cachep, pva);
> > +	/* Randomize allocation */
> > +	if (randomize_vmalloc) {
> > +		voffset = get_random_long() & (roundup_pow_of_two(vend - vstart) - 1);
> > +		voffset = PAGE_ALIGN(voffset);
> > +		if (voffset + size > vend - vstart)
> > +			voffset = vend - vstart - size;
> > +	} else
> > +		voffset = 0;
> > +
> >   	/*
> >   	 * If an allocation fails, the "vend" address is
> >   	 * returned. Therefore trigger the overflow path.
> >   	 */
> > -	addr = __alloc_vmap_area(size, align, vstart, vend);
> > +	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
> > +
> > +	if (unlikely(addr == vend) && voffset)
> > +		/* Retry randomization from other end */
> > +		addr = __alloc_vmap_area(size, align, vstart, vstart + voffset + size);
> >   	spin_unlock(&free_vmap_area_lock);
> >   	if (unlikely(addr == vend))
> > 
> > base-commit: 7f376f1917d7461e05b648983e8d2aea9d0712b2
> > 
> 
