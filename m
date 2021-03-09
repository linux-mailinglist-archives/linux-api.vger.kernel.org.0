Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA43327B6
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhCINt0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 08:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhCINtT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 08:49:19 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27D5C06174A;
        Tue,  9 Mar 2021 05:49:18 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u4so27195284lfs.0;
        Tue, 09 Mar 2021 05:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfuJzYJ5RVpv9LdnSPcGEKRiaxfbXjH0PE1QOGaNx9A=;
        b=f9HOLUZ5IXmrzUUkzOEtVCR2RO1i5kUcxONL0JAqhLnYMAuvhQ2+KTMsbUQdQpinpd
         twBrQmoRUNZI8Y0+Wa/vmT6zD2lRAf7e668CXE1+f48a+SP/T3Ei44on1dGs9COAq7bs
         zU8iqywwmpy8+DigGP+j2JjG0oA0boBMod1hqeNmSa5mJm1mfgh3oQl1IxOjQTEqDQyg
         4LB2Qe6PCSAv2TX6TfeYXSuz8bh770AtBD43R3IslfLbOEi+bSvXoT7tGvewZV0f7Vl3
         NqBb1xoFMnt2PJuiKZpzJVKtizzLOf8wPllFL336axX0ah9Cfdon3i6q+VQ3obOjhfzN
         8sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfuJzYJ5RVpv9LdnSPcGEKRiaxfbXjH0PE1QOGaNx9A=;
        b=eb1QXnNN/naEGMdbyMxOkGRH7yxSySkmGPh/GiMYOxm8ry+RJDWQ0OoI6/Wr/fhto6
         wchZX5HSQqTvfDR1wqN1FXKGYR5IQ2pU5tcs9FUkDXisc/cSo6IDuQPoAjnDTk1S3x3J
         6wUZX4kX/mGgDGFdnxfQVroPTVkQDyctZ4RWbzntblnFDu7ckeV4tCAAMPYl/zdks92K
         /z0zeMo0UTZ2vSNoo22pcxanS9UwD7Jw6Q0odNDXvR4gmp9Q2MBrGZaIzYWAGHFac77E
         AjhbDQuSxiWVuECn5qul98V/QhHiGNDlmoBHX1tQbfmieFH8rjtxQ/mca9bypMgldrFp
         OhbA==
X-Gm-Message-State: AOAM531UUqikcUqTOOU7ktljawVfMbOpfF1LL18tF5BO2TYtghPMQSKH
        ceY9a1eLgvYeanl/bl8fJiA=
X-Google-Smtp-Source: ABdhPJzFsXGjdjJ2b995ouka77K+EhMFaIqqqG8AeoJmTs6+tvOcZqQIASW3KuIQK7bTWPgVj7dxgg==
X-Received: by 2002:a05:6512:3185:: with SMTP id i5mr17055858lfe.653.1615297757243;
        Tue, 09 Mar 2021 05:49:17 -0800 (PST)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id r4sm1796129lfn.135.2021.03.09.05.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 05:49:16 -0800 (PST)
Subject: Re: [PATCH v3] mm/vmalloc: randomize vmalloc() allocations
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Vlad Rezki <urezki@gmail.com>
References: <20210215202634.5121-1-toiwoton@gmail.com>
 <202103081329.461F3D035@keescook>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <1cb30d0f-eee7-b778-9f75-216d25fb299f@gmail.com>
Date:   Tue, 9 Mar 2021 15:49:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202103081329.461F3D035@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8.3.2021 23.38, Kees Cook wrote:
> On Mon, Feb 15, 2021 at 10:26:34PM +0200, Topi Miettinen wrote:
>> Memory mappings inside kernel allocated with vmalloc() are in
>> predictable order and packed tightly toward the low addresses, except
>> for per-cpu areas which start from top of the vmalloc area. With
>> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
>> used randomly to make the allocations less predictable and harder to
>> guess for attackers. Also module and BPF code locations get randomized
>> (within their dedicated and rather small area though) and if
>> CONFIG_VMAP_STACK is enabled, also kernel thread stack locations.
>>
>> On 32 bit systems this may cause problems due to increased VM
>> fragmentation if the address space gets crowded.
>>
>> On all systems, it will reduce performance and increase memory and
>> cache usage due to less efficient use of page tables and inability to
>> merge adjacent VMAs with compatible attributes. On x86_64 with 5 level
>> page tables, in the worst case, additional page table entries of up to
>> 4 pages are created for each mapping, so with small mappings there's
>> considerable penalty.
>>
>> Without randomize_vmalloc=1:
>> $ grep -v kernel_clone /proc/vmallocinfo
>> 0xffffc90000000000-0xffffc90000009000   36864 irq_init_percpu_irqstack+0x176/0x1c0 vmap
>> 0xffffc90000009000-0xffffc9000000b000    8192 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x000000001ffe1000 ioremap
>> 0xffffc9000000c000-0xffffc9000000f000   12288 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x000000001ffe0000 ioremap
>> 0xffffc9000000f000-0xffffc90000011000    8192 hpet_enable+0x31/0x4a4 phys=0x00000000fed00000 ioremap
>> 0xffffc90000011000-0xffffc90000013000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>> 0xffffc90000013000-0xffffc90000015000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>> 0xffffc90000015000-0xffffc90000017000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>> 0xffffc90000021000-0xffffc90000023000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>> 0xffffc90000023000-0xffffc90000025000    8192 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x00000000fed00000 ioremap
>> 0xffffc90000025000-0xffffc90000027000    8192 memremap+0x19c/0x280 phys=0x00000000000f5000 ioremap
>> 0xffffc90000031000-0xffffc90000036000   20480 pcpu_create_chunk+0xe8/0x260 pages=4 vmalloc
>> 0xffffc90000043000-0xffffc90000047000   16384 n_tty_open+0x11/0xe0 pages=3 vmalloc
>> 0xffffc90000211000-0xffffc90000232000  135168 crypto_scomp_init_tfm+0xc6/0xf0 pages=32 vmalloc
>> 0xffffc90000232000-0xffffc90000253000  135168 crypto_scomp_init_tfm+0x67/0xf0 pages=32 vmalloc
>> 0xffffc900005a9000-0xffffc900005ba000   69632 pcpu_create_chunk+0x7b/0x260 pages=16 vmalloc
>> 0xffffc900005ba000-0xffffc900005cc000   73728 pcpu_create_chunk+0xb2/0x260 pages=17 vmalloc
>> 0xffffe8ffffc00000-0xffffe8ffffe00000 2097152 pcpu_get_vm_areas+0x0/0x2290 vmalloc
>>
>> With randomize_vmalloc=1, the allocations are randomized:
>> $ grep -v kernel_clone /proc/vmallocinfo
>> 0xffffc9759d443000-0xffffc9759d445000    8192 hpet_enable+0x31/0x4a4 phys=0x00000000fed00000 ioremap
>> 0xffffccf1e9f66000-0xffffccf1e9f68000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>> 0xffffcd2fc02a4000-0xffffcd2fc02a6000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>> 0xffffcdaefb898000-0xffffcdaefb89b000   12288 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x000000001ffe0000 ioremap
>> 0xffffcef8074c3000-0xffffcef8074cc000   36864 irq_init_percpu_irqstack+0x176/0x1c0 vmap
>> 0xffffcf725ca2e000-0xffffcf725ca4f000  135168 crypto_scomp_init_tfm+0xc6/0xf0 pages=32 vmalloc
>> 0xffffd0efb25e1000-0xffffd0efb25f2000   69632 pcpu_create_chunk+0x7b/0x260 pages=16 vmalloc
>> 0xffffd27054678000-0xffffd2705467c000   16384 n_tty_open+0x11/0xe0 pages=3 vmalloc
>> 0xffffd2adf716e000-0xffffd2adf7180000   73728 pcpu_create_chunk+0xb2/0x260 pages=17 vmalloc
>> 0xffffd4ba5fb6b000-0xffffd4ba5fb6d000    8192 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x000000001ffe1000 ioremap
>> 0xffffded126192000-0xffffded126194000    8192 memremap+0x19c/0x280 phys=0x00000000000f5000 ioremap
>> 0xffffe01a4dbcd000-0xffffe01a4dbcf000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>> 0xffffe4b649952000-0xffffe4b649954000    8192 acpi_os_map_iomem+0x2ac/0x2d0 phys=0x00000000fed00000 ioremap
>> 0xffffe71ed592a000-0xffffe71ed592c000    8192 gen_pool_add_owner+0x49/0x130 pages=1 vmalloc
>> 0xffffe7dc5824f000-0xffffe7dc58270000  135168 crypto_scomp_init_tfm+0x67/0xf0 pages=32 vmalloc
>> 0xffffe8f4f9800000-0xffffe8f4f9a00000 2097152 pcpu_get_vm_areas+0x0/0x2290 vmalloc
>> 0xffffe8f4f9a19000-0xffffe8f4f9a1e000   20480 pcpu_create_chunk+0xe8/0x260 pages=4 vmalloc
>>
>> With CONFIG_VMAP_STACK, also kernel thread stacks are placed in
>> vmalloc area and therefore they also get randomized (only one example
>> line from /proc/vmallocinfo shown for brevity):
>>
>> unrandomized:
>> 0xffffc90000018000-0xffffc90000021000   36864 kernel_clone+0xf9/0x560 pages=8 vmalloc
>>
>> randomized:
>> 0xffffcb57611a8000-0xffffcb57611b1000   36864 kernel_clone+0xf9/0x560 pages=8 vmalloc
>>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: Andy Lutomirski <luto@kernel.org>
>> CC: Jann Horn <jannh@google.com>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Linux API <linux-api@vger.kernel.org>
>> CC: Matthew Wilcox <willy@infradead.org>
>> CC: Mike Rapoport <rppt@kernel.org>
>> CC: Vlad Rezki <urezki@gmail.com>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> 
> Thanks for working on this! I'd like to see this in the kernel, even if
> it's only for the more paranoia crowd. Have you done any workload
> measurements to see how much of a hit this has in the real world?

I compiled the kernel a few times on an idle machine and with 
randomize_vmalloc=1 the real times were 0.3% slower. Not sure if this is 
a good measure for kernel performance. The randomization should increase 
use of page tables and they should also compete for CPU caches.

>> ---
>> v2: retry allocation from other end of vmalloc space in case of
>> failure (Matthew Wilcox), improve commit message and documentation
>> v3: randomize also percpu allocations (pcpu_get_vm_areas())
>> ---
>>   .../admin-guide/kernel-parameters.txt         | 23 ++++++++++++
>>   mm/vmalloc.c                                  | 36 +++++++++++++++++--
>>   2 files changed, 56 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index c722ec19cd00..38d6b5728ccc 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4024,6 +4024,29 @@
>>   
>>   	ramdisk_start=	[RAM] RAM disk image start address
>>   
>> +	randomize_vmalloc= [KNL] Randomize vmalloc() allocations. With 1,
>> +			the entire vmalloc() area is used randomly to
>> +			make the allocations less predictable and
>> +			harder to guess for attackers. Also module and
>> +			BPF code locations get randomized (within
>> +			their dedicated and rather small area though)
>> +			and if CONFIG_VMAP_STACK is enabled, also
>> +			kernel thread stack locations.
>> +
>> +			On 32 bit systems this may cause problems due
>> +			to increased VM fragmentation if the address
>> +			space gets crowded.
>> +
>> +			On all systems, it will reduce performance and
>> +			increase memory and cache usage due to less
>> +			efficient use of page tables and inability to
>> +			merge adjacent VMAs with compatible
>> +			attributes. On x86_64 with 5 level page
>> +			tables, in the worst case, additional page
>> +			table entries of up to 4 pages are created for
>> +			each mapping, so with small mappings there's
>> +			considerable penalty.
>> +
>>   	random.trust_cpu={on,off}
>>   			[KNL] Enable or disable trusting the use of the
>>   			CPU's random number generator (if available) to
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 4d88fe5a277a..1e8e0ee1925f 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/bitops.h>
>>   #include <linux/rbtree_augmented.h>
>>   #include <linux/overflow.h>
>> +#include <linux/random.h>
>>   
>>   #include <linux/uaccess.h>
>>   #include <asm/tlbflush.h>
>> @@ -1089,6 +1090,17 @@ adjust_va_to_fit_type(struct vmap_area *va,
>>   	return 0;
>>   }
>>   
>> +static int randomize_vmalloc = 0;
> 
> This should be __ro_after_init, and even better, it should be a static
> branch so there's no performance hit at all for the "disabled" case.
> I recommend:
> 
> static DEFINE_STATIC_KEY_FALSE_RO(randomize_vmalloc);
> 
> static int __init set_randomize_vmalloc(char *str)
> {
>         int ret;
>         bool bool_result;
> 
>         ret = kstrtobool(buf, &bool_result);
>         if (ret)
>                 return ret;
> 
>         if (bool_result)
>                 static_branch_enable(&randomize_kstack_offset);
>         else
>                 static_branch_disable(&randomize_kstack_offset);
>         return 1;
> }
> __setup("randomize_vmalloc=", set_randomize_vmalloc);
> 
> 
>> +
>>   /*
>>    * Returns a start address of the newly allocated area, if success.
>>    * Otherwise a vend is returned that indicates failure.
>> @@ -1162,7 +1174,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>>   				int node, gfp_t gfp_mask)
>>   {
>>   	struct vmap_area *va, *pva;
>> -	unsigned long addr;
>> +	unsigned long addr, voffset;
>>   	int purged = 0;
>>   	int ret;
>>   
>> @@ -1217,11 +1229,24 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>>   	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
>>   		kmem_cache_free(vmap_area_cachep, pva);
>>   
>> +	/* Randomize allocation */
>> +	if (randomize_vmalloc) {
> 
> if (static_branch_unlikely(randomize_vmalloc)) {
> ...


Thanks, I'll post an updated version with static_branch.

> 
>> +		voffset = get_random_long() & (roundup_pow_of_two(vend - vstart) - 1);
>> +		voffset = PAGE_ALIGN(voffset);
>> +		if (voffset + size > vend - vstart)
>> +			voffset = vend - vstart - size;
>> +	} else
>> +		voffset = 0;
>> +
>>   	/*
>>   	 * If an allocation fails, the "vend" address is
>>   	 * returned. Therefore trigger the overflow path.
>>   	 */
>> -	addr = __alloc_vmap_area(size, align, vstart, vend);
>> +	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
>> +
>> +	if (unlikely(addr == vend) && voffset)
>> +		/* Retry randomization from other end */
>> +		addr = __alloc_vmap_area(size, align, vstart, vstart + voffset + size);
>>   	spin_unlock(&free_vmap_area_lock);
>>   
>>   	if (unlikely(addr == vend))
>> @@ -3256,7 +3281,12 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>>   	start = offsets[area];
>>   	end = start + sizes[area];
>>   
>> -	va = pvm_find_va_enclose_addr(vmalloc_end);
>> +	if (randomize_vmalloc)
>> +		va = pvm_find_va_enclose_addr(vmalloc_start +
>> +					      (get_random_long() &
>> +					       (roundup_pow_of_two(vmalloc_end - vmalloc_start) - 1)));
>> +	else
>> +		va = pvm_find_va_enclose_addr(vmalloc_end);
>>   	base = pvm_determine_end_from_reverse(&va, align) - end;
>>   
>>   	while (true) {
>> -- 
>> 2.30.0
>>
> 
> But otherwise, yes please. It's a simple change that makes per-boot
> order of vmalloc allocations unpredictable. I'm for it! :)

Great and thanks for the review!

-Topi


