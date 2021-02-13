Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7729631ABEA
	for <lists+linux-api@lfdr.de>; Sat, 13 Feb 2021 14:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBMNo0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Feb 2021 08:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBMNoZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 13 Feb 2021 08:44:25 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DBCC061574;
        Sat, 13 Feb 2021 05:43:44 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v5so3468972lft.13;
        Sat, 13 Feb 2021 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=315GZxS6s0cHjvHILhh4YGvEfbtxRCwik0S6rgbpBsE=;
        b=eSBj1HgA0v5g5GnHD9FEFpVAfbtOAFH/JusoBjQEIeswIQNQ8zgo3edogcEaprNb94
         ptF+8gKGTEkObI/Zfr/iYrEnYaW13f1fRbM0em74ckgmpizTqAedvPp56NyIIDqj3ne6
         Y7zBSJQ+QPep6OjtBe1bjp9IE8bnDHfKqsIVQjBE0A6rW2CRtOC0HEyJmwKJoiQEx1oX
         +Rg4FH6PF/MUAdw+rTTg4K8LEWoMmunoZ2ynp2WuzO3SCpNKd9ooUP1dwXcuJnNbLjnh
         aId2zkFyjbsK9J1mgaNXA5iPynrBqiRNxiogpys1aLZWzW4Ax1PaxfhCcGwK1DT0UIs1
         vU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=315GZxS6s0cHjvHILhh4YGvEfbtxRCwik0S6rgbpBsE=;
        b=CWlsl+6AmEnmszDWlpc6ibkopRk3mbIOdaYKbQRhksVAQ8oVNOj0T17lssfDdxyV7u
         LLp1JEH3lqNWuCc073/JG8/t2IrbdXzhmlXm+j0UIFV6UR85Mn7Zah8nkkrb5vyKeBOu
         FVcszWaAg0er/DDkxL05clnTcnC0CetUGLlKjcyNIAMU5z33RPkqXf+Ycqck+DcJTApl
         L3ZsaBzbY8Uy4w7g57hqIBfz0YOboYx7flBBHhdgaNKhDUKzLyAL0/m5t+HNQt9myjWB
         M+BuxzGW1FMMCaW5a8BXc9SP2uubWM5ObcLTELQuU0uGG1+4yfcEt1K7/RXXkxB6oZfn
         B1zA==
X-Gm-Message-State: AOAM533RECOiWRw4kgsR7ZoMgWVQ4966N1JrzedCPIIDY2H3bA5y/WW7
        Ym1Kr2sqOnZBwg1NIgF3A68=
X-Google-Smtp-Source: ABdhPJwXrwtRqpRYw3kMfcB78iWcbOxirEduSUnOyPSdBCDNlRGs4KkPMYd8gxIPCinVH9hmRzf1Pw==
X-Received: by 2002:ac2:4c17:: with SMTP id t23mr4151265lfq.34.1613223822783;
        Sat, 13 Feb 2021 05:43:42 -0800 (PST)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id x27sm251709ljm.30.2021.02.13.05.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 05:43:42 -0800 (PST)
Subject: Re: [PATCH v2] mm/vmalloc: randomize vmalloc() allocations
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20201212175635.4217-1-toiwoton@gmail.com>
 <795016db-93fa-72ea-f5dd-16b9c56a62e9@gmail.com>
 <20210213115521.GA1907@pc638.lan>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <8d60ba59-1d16-bb76-f3d3-f1b0c5a5b306@gmail.com>
Date:   Sat, 13 Feb 2021 15:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210213115521.GA1907@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 13.2.2021 13.55, Uladzislau Rezki wrote:
>> Hello,
>>
>> Is there a chance of getting this reviewed and maybe even merged, please?
>>
>> -Topi
>>
> I can review it and help with it. But before that i would like to
> clarify if such "randomization" is something that you can not leave?

This happens to interest me and I don't mind the performance loss since 
I think there's also an improvement in security. I suppose (perhaps 
wrongly) that others may also be interested in such features. For 
example, also `nosmt` can take away a big part of CPU processing 
capability. Does this answer your question, I'm not sure what you mean 
with leaving? I hope you would not want me to go away and leave?

> For example on 32bit system vmalloc space is limited, such randomization
> can slow down it, also it will lead to failing of allocations much more,
> thus it will require repeating with different offset.

I would not use `randomize_vmalloc=1` on a 32 bit systems, because in 
addition to slow down, the address space could become so fragmented that 
large allocations may not fit anymore. Perhaps the documentation should 
warn about this more clearly. I haven't tried this on a 32 bit system 
though and there the VM layout is very different.

__alloc_vm_area() scans the vmalloc space starting from a random address 
up to end of the area. If this fails, the scan is restarted from the 
bottom of the area up to this random address. Thus the entire area is 
scanned.

> Second. There is a space or region for modules. Using various offsets
> can waste of that memory, thus can lead to failing of module loading.

The allocations for modules (or BPF code) are also randomized within 
their dedicated space. I don't think other allocations should affect 
module space. Within this module space, fragmentation may also be 
possible because there's only 1,5GB available. The largest allocation on 
my system seems to be 11M at the moment, others are 1M or below and most 
are 8k. The possibility of an allocation failing probably depends on the 
fill ratio. In practice haven't seen problems with this.

It would be possible to have finer control, for example 
`randomize_vmalloc=3` (1 = general vmalloc, 2 = modules, bitwise ORed) 
or `randomize_vmalloc=general,modules`.

I experimented by trying to change how the modules are compiled 
(-mcmodel=medium or -mcmodel=large) so that they could be located in the 
normal vmalloc space, but instead I found a bug in the compiler 
(-mfentry produces incorrect code for -mcmodel=large, now fixed).

> On the other side there is a per-cpu allocator. Interfering with it
> also will increase a rate of failing.

I didn't notice the per-cpu allocator before. I'm probably missing 
something, but it seems to be used for a different purpose (for 
allocating the vmap_area structure objects instead of the address space 
range), so where do you see interference?

Thanks for the review!

-Topi

> 
> --
> Vlad Rezki
> 
>>> Memory mappings inside kernel allocated with vmalloc() are in
>>> predictable order and packed tightly toward the low addresses. With
>>> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
>>> used randomly to make the allocations less predictable and harder to
>>> guess for attackers. Also module and BPF code locations get randomized
>>> (within their dedicated and rather small area though) and if
>>> CONFIG_VMAP_STACK is enabled, also kernel thread stack locations.
>>>
>>> On 32 bit systems this may cause problems due to increased VM
>>> fragmentation if the address space gets crowded.
>>>
>>> On all systems, it will reduce performance and increase memory and
>>> cache usage due to less efficient use of page tables and inability to
>>> merge adjacent VMAs with compatible attributes. On x86_64 with 5 level
>>> page tables, in the worst case, additional page table entries of up to
>>> 4 pages are created for each mapping, so with small mappings there's
>>> considerable penalty.
>>>
>>> Without randomize_vmalloc=1:
>>> $ cat /proc/vmallocinfo
>>> 0xffffc90000000000-0xffffc90000002000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe1000 ioremap
>>> 0xffffc90000002000-0xffffc90000005000   12288 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe0000 ioremap
>>> 0xffffc90000005000-0xffffc90000007000    8192 hpet_enable+0x36/0x4a9 phys=0x00000000fed00000 ioremap
>>> 0xffffc90000007000-0xffffc90000009000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>>> 0xffffc90000009000-0xffffc9000000b000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>>> 0xffffc9000000b000-0xffffc9000000d000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>>> 0xffffc9000000d000-0xffffc9000000f000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>>> 0xffffc90000011000-0xffffc90000015000   16384 n_tty_open+0x16/0xe0 pages=3 vmalloc
>>> 0xffffc900003de000-0xffffc900003e0000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x00000000fed00000 ioremap
>>> 0xffffc900003e0000-0xffffc900003e2000    8192 memremap+0x1a1/0x280 phys=0x00000000000f5000 ioremap
>>> 0xffffc900003e2000-0xffffc900003f3000   69632 pcpu_create_chunk+0x80/0x2c0 pages=16 vmalloc
>>> 0xffffc900003f3000-0xffffc90000405000   73728 pcpu_create_chunk+0xb7/0x2c0 pages=17 vmalloc
>>> 0xffffc90000405000-0xffffc9000040a000   20480 pcpu_create_chunk+0xed/0x2c0 pages=4 vmalloc
>>> 0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x1a40 vmalloc
>>>
>>> With randomize_vmalloc=1, the allocations are randomized:
>>> $ cat /proc/vmallocinfo
>>> 0xffffca3a36442000-0xffffca3a36447000   20480 pcpu_create_chunk+0xed/0x2c0 pages=4 vmalloc
>>> 0xffffca63034d6000-0xffffca63034d9000   12288 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe0000 ioremap
>>> 0xffffcce23d32e000-0xffffcce23d330000    8192 memremap+0x1a1/0x280 phys=0x00000000000f5000 ioremap
>>> 0xffffcfb9f0e22000-0xffffcfb9f0e24000    8192 hpet_enable+0x36/0x4a9 phys=0x00000000fed00000 ioremap
>>> 0xffffd1df23e9e000-0xffffd1df23eb0000   73728 pcpu_create_chunk+0xb7/0x2c0 pages=17 vmalloc
>>> 0xffffd690c2990000-0xffffd690c2992000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x000000003ffe1000 ioremap
>>> 0xffffd8460c718000-0xffffd8460c71c000   16384 n_tty_open+0x16/0xe0 pages=3 vmalloc
>>> 0xffffd89aba709000-0xffffd89aba70b000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>>> 0xffffe0ca3f2ed000-0xffffe0ca3f2ef000    8192 acpi_os_map_iomem+0x29e/0x2c0 phys=0x00000000fed00000 ioremap
>>> 0xffffe3ba44802000-0xffffe3ba44804000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>>> 0xffffe4524b2a2000-0xffffe4524b2a4000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>>> 0xffffe61372b2e000-0xffffe61372b30000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>>> 0xffffe704d2f7c000-0xffffe704d2f8d000   69632 pcpu_create_chunk+0x80/0x2c0 pages=16 vmalloc
>>> 0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x1a40 vmalloc
>>>
>>> With CONFIG_VMAP_STACK, also kernel thread stacks are placed in
>>> vmalloc area and therefore they also get randomized (only one example
>>> line from /proc/vmallocinfo shown for brevity):
>>>
>>> unrandomized:
>>> 0xffffc90000018000-0xffffc90000021000   36864 kernel_clone+0xf9/0x560 pages=8 vmalloc
>>>
>>> randomized:
>>> 0xffffcb57611a8000-0xffffcb57611b1000   36864 kernel_clone+0xf9/0x560 pages=8 vmalloc
>>>
>>> CC: Andrew Morton <akpm@linux-foundation.org>
>>> CC: Andy Lutomirski <luto@kernel.org>
>>> CC: Jann Horn <jannh@google.com>
>>> CC: Kees Cook <keescook@chromium.org>
>>> CC: Linux API <linux-api@vger.kernel.org>
>>> CC: Matthew Wilcox <willy@infradead.org>
>>> CC: Mike Rapoport <rppt@kernel.org>
>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>> ---
>>> v2: retry allocation from other end of vmalloc space in case of
>>> failure (Matthew Wilcox), improve commit message and documentation
>>> ---
>>>    .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++++
>>>    mm/vmalloc.c                                  | 29 +++++++++++++++++--
>>>    2 files changed, 50 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 44fde25bb221..9386b1b40a27 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -4017,6 +4017,29 @@
>>>    	ramdisk_start=	[RAM] RAM disk image start address
>>> +	randomize_vmalloc= [KNL] Randomize vmalloc() allocations. With 1,
>>> +			the entire vmalloc() area is used randomly to
>>> +			make the allocations less predictable and
>>> +			harder to guess for attackers. Also module and
>>> +			BPF code locations get randomized (within
>>> +			their dedicated and rather small area though)
>>> +			and if CONFIG_VMAP_STACK is enabled, also
>>> +			kernel thread stack locations.
>>> +
>>> +			On 32 bit systems this may cause problems due
>>> +			to increased VM fragmentation if the address
>>> +			space gets crowded.
>>> +
>>> +			On all systems, it will reduce performance and
>>> +			increase memory and cache usage due to less
>>> +			efficient use of page tables and inability to
>>> +			merge adjacent VMAs with compatible
>>> +			attributes. On x86_64 with 5 level page
>>> +			tables, in the worst case, additional page
>>> +			table entries of up to 4 pages are created for
>>> +			each mapping, so with small mappings there's
>>> +			considerable penalty.
>>> +
>>>    	random.trust_cpu={on,off}
>>>    			[KNL] Enable or disable trusting the use of the
>>>    			CPU's random number generator (if available) to
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index 6ae491a8b210..d78528af6316 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -34,6 +34,7 @@
>>>    #include <linux/bitops.h>
>>>    #include <linux/rbtree_augmented.h>
>>>    #include <linux/overflow.h>
>>> +#include <linux/random.h>
>>>    #include <linux/uaccess.h>
>>>    #include <asm/tlbflush.h>
>>> @@ -1079,6 +1080,17 @@ adjust_va_to_fit_type(struct vmap_area *va,
>>>    	return 0;
>>>    }
>>> +static int randomize_vmalloc = 0;
>>> +
>>> +static int __init set_randomize_vmalloc(char *str)
>>> +{
>>> +	if (!str)
>>> +		return 0;
>>> +	randomize_vmalloc = simple_strtoul(str, &str, 0);
>>> +	return 1;
>>> +}
>>> +__setup("randomize_vmalloc=", set_randomize_vmalloc);
>>> +
>>>    /*
>>>     * Returns a start address of the newly allocated area, if success.
>>>     * Otherwise a vend is returned that indicates failure.
>>> @@ -1152,7 +1164,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>>>    				int node, gfp_t gfp_mask)
>>>    {
>>>    	struct vmap_area *va, *pva;
>>> -	unsigned long addr;
>>> +	unsigned long addr, voffset;
>>>    	int purged = 0;
>>>    	int ret;
>>> @@ -1207,11 +1219,24 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>>>    	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
>>>    		kmem_cache_free(vmap_area_cachep, pva);
>>> +	/* Randomize allocation */
>>> +	if (randomize_vmalloc) {
>>> +		voffset = get_random_long() & (roundup_pow_of_two(vend - vstart) - 1);
>>> +		voffset = PAGE_ALIGN(voffset);
>>> +		if (voffset + size > vend - vstart)
>>> +			voffset = vend - vstart - size;
>>> +	} else
>>> +		voffset = 0;
>>> +
>>>    	/*
>>>    	 * If an allocation fails, the "vend" address is
>>>    	 * returned. Therefore trigger the overflow path.
>>>    	 */
>>> -	addr = __alloc_vmap_area(size, align, vstart, vend);
>>> +	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
>>> +
>>> +	if (unlikely(addr == vend) && voffset)
>>> +		/* Retry randomization from other end */
>>> +		addr = __alloc_vmap_area(size, align, vstart, vstart + voffset + size);
>>>    	spin_unlock(&free_vmap_area_lock);
>>>    	if (unlikely(addr == vend))
>>>
>>> base-commit: 7f376f1917d7461e05b648983e8d2aea9d0712b2
>>>
>>

