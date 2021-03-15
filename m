Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477A633AE2B
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCOJFO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCOJEs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 05:04:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A4C061574;
        Mon, 15 Mar 2021 02:04:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u4so55659077lfs.0;
        Mon, 15 Mar 2021 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hdTDoj4I+eG+8WhrTx3pZg6k1G4E7ZJpFywqqp3QHYs=;
        b=JHIvgYCHTX7xUn7uBpNmQzqyJrhjf0UJXYV8J5EX2VuFYldw+9fEe7fxN4fM+I+R/y
         hJbSPXwbAr+ezp3LfwRPws8GQ9lqpLarwlhEH3q72S7cU2dYpcG69vIJVKMFZUwRiCO9
         ifEnTfRVuh0JLeZ7szbzRPMGM6Hjt1EUQlCS0VLoyeiHa2uhq6ioQlVdsPTF5/4lp+nX
         ayhN30bDjt9bYuRPWawfXcfaR1uqk+bDVR9Wy+N2Z+0pwsuFaQ2Ke5DdTTqxP6Okq0RH
         dLJQV8mLn25djImpaPC0zDWSy5yTwmB2kyEBYliCokb+e5+AVTnTUHhVd6AjikxUBwq4
         UAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdTDoj4I+eG+8WhrTx3pZg6k1G4E7ZJpFywqqp3QHYs=;
        b=s7z0m6ONZh0fF2Jp72cuX0luIraA8WCBGsdsWXr0Gc2MJzhoTKMUu/1kKCRSFvCa7t
         psqzD7O8lLw1jmAQkts/42rNB2NCfRFh7FewwzPutlnJlA2UzCH+RBAukRzhDT0WgSID
         ciCSZx9Owty9HQplLGYPnra/BY7CR0d4NF1LoCPXTnXXCm5cFe1Poy0GmNayyDJGTxmV
         c04sZDicQGsuVOZ+KO5zTC/7+5ywtpwjM+6dEyZlbfZoecF3q+2FMLl9XmVBJ/dUyqyS
         fZJYetUJMKlnsR4jUKe22nD7MLIOxhg0ZAqcYjZag6ubs61ev73p+074wZwmOGQgPrXx
         zxjg==
X-Gm-Message-State: AOAM532Td+txaAzshfJkJ3CANTHkn716S3ZoD2a5B0NLwzPqmCvjjlMD
        UzQZRdi+wfb91eLjUCKRzb5U7qFc890=
X-Google-Smtp-Source: ABdhPJyqZFc++NS2k5XXvzKlBSPRn3g4guoZ7vtr9WrxkfB7pnCQ453vdi7KjSIKbmIe2lon81R3Ig==
X-Received: by 2002:a05:6512:2019:: with SMTP id a25mr7148194lfb.166.1615799086257;
        Mon, 15 Mar 2021 02:04:46 -0700 (PDT)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id t142sm2610117lff.255.2021.03.15.02.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:04:45 -0700 (PDT)
Subject: Re: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <f2d6965b-1801-ce91-0c7c-2cdc92493393@gmail.com>
Date:   Mon, 15 Mar 2021 11:04:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314172312.GA2085@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 14.3.2021 19.23, Uladzislau Rezki wrote:
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
>> ---
>> v2: retry allocation from other end of vmalloc space in case of
>> failure (Matthew Wilcox), improve commit message and documentation
>> v3: randomize also percpu allocations (pcpu_get_vm_areas())
>> v4: use static branches (Kees Cook) and make the parameter boolean.
>> ---
>>   .../admin-guide/kernel-parameters.txt         | 24 ++++++++++
>>   mm/vmalloc.c                                  | 44 +++++++++++++++++--
>>   2 files changed, 65 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a10b545c2070..726aec542079 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4024,6 +4024,30 @@
>>   
>>   	ramdisk_start=	[RAM] RAM disk image start address
>>   
>> +	randomize_vmalloc= [KNL] Boolean option to randomize vmalloc()
>> +			allocations. When enabled, the entire
>> +			vmalloc() area is used randomly to make the
>> +			allocations less predictable and harder to
>> +			guess for attackers. Also module and BPF code
>> +			locations get randomized (within their
>> +			dedicated and rather small area though) and if
>> +			CONFIG_VMAP_STACK is enabled, also kernel
>> +			thread stack locations.
>> +
>> +			On 32 bit systems this may cause problems due
>> +			to increased VM fragmentation if the address
>> +			space gets crowded.
>>
> What kind of problems? Could you please more cpecific? I guess fail
> ratio will be increased.

Maybe it would be simplest to disable the option entirely for 32 bit 
architectures. I think if such a system has lots of RAM (maybe 4GB?), so 
that the kernel VM area (1GB?) can be fully utilized, it's possible that 
when the area is allocated randomly, the gaps between allocations can 
become unusable for further allocations. Perhaps the option could still 
work with a system on the low end (64MB?) because any allocations (for 
example page tables needed) consume real RAM so the fragmentation does 
not become the bottleneck.

> 
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
> Could you please put test results to the commit message? You can run
> "test_vmalloc.sh performance" on you system. It will give us some
> figures to understand the performance difference.

Thanks, I didn't notice this tool.

> 
>> +
>>   	random.trust_cpu={on,off}
>>   			[KNL] Enable or disable trusting the use of the
>>   			CPU's random number generator (if available) to
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index e6f352bf0498..b5ecf27dc98e 100644
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
>> @@ -1089,6 +1090,25 @@ adjust_va_to_fit_type(struct vmap_area *va,
>>   	return 0;
>>   }
>>   
>> +static DEFINE_STATIC_KEY_FALSE_RO(randomize_vmalloc);
>> +
>> +static int __init set_randomize_vmalloc(char *str)
>> +{
>> +	int ret;
>> +	bool bool_result;
>> +
>> +	ret = kstrtobool(str, &bool_result);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (bool_result)
>> +		static_branch_enable(&randomize_vmalloc);
>> +	else
>> +		static_branch_disable(&randomize_vmalloc);
>> +	return 1;
>> +}
>> +__setup("randomize_vmalloc=", set_randomize_vmalloc);
>> +
>>   /*
>>    * Returns a start address of the newly allocated area, if success.
>>    * Otherwise a vend is returned that indicates failure.
>> @@ -1162,7 +1182,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>>   				int node, gfp_t gfp_mask)
>>   {
>>   	struct vmap_area *va, *pva;
>> -	unsigned long addr;
>> +	unsigned long addr, voffset;
>>   	int purged = 0;
>>   	int ret;
>>   
>> @@ -1217,11 +1237,24 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>>   	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
>>   		kmem_cache_free(vmap_area_cachep, pva);
>>   
>> +	/* Randomize allocation */
>> +	if (static_branch_unlikely(&randomize_vmalloc)) {
>> +		voffset = get_random_long() & (roundup_pow_of_two(vend - vstart) - 1);
>> +		voffset = PAGE_ALIGN(voffset);
>> +		if (voffset + size > vend - vstart)
>> +			voffset = vend - vstart - size;
>> +	} else
>> +		voffset = 0;
>> +
> Could you please wrap that change into a separate function? For example
> randomize_voffset_with_range(start, end).

OK. I'm relying on compiler noticing that voffset is zero (in some 
cases) and  then it can skip the addition. Maybe the addition could be 
avoided entirely.

> 
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
>> @@ -3258,7 +3291,12 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>>   	start = offsets[area];
>>   	end = start + sizes[area];
>>   
>> -	va = pvm_find_va_enclose_addr(vmalloc_end);
>> +	if (static_branch_unlikely(&randomize_vmalloc))
>> +		va = pvm_find_va_enclose_addr(vmalloc_start +
>> +					      (get_random_long() &
>> +					       (roundup_pow_of_two(vmalloc_end - vmalloc_start) - 1)));
>> +	else
>> +		va = pvm_find_va_enclose_addr(vmalloc_end);
>>   	base = pvm_determine_end_from_reverse(&va, align) - end;
> As for per-cpu embedded alloator. Even though currently it is part of
> the vmalloc space, it is not a vmalloc() allocation. Please do not change
> its code. It does alloations by "chunks" where an internal structure
> represent special memory layout that is used for actual allocations.

What's the problem with that? It seems to me that nothing relies on 
specific addresses of the chunks, so it should be possible to randomize 
these too. Also the alignment is honored.

> 
> 
> Also, using vmaloc test driver i can trigger a kernel BUG:
> 
> <snip>
> [   24.627577] kernel BUG at mm/vmalloc.c:1272!
> [   24.628645] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   24.628684] CPU: 30 PID: 929 Comm: vmalloc_test/0 Tainted: G            E     5.11.0-next-20210225-next #484
> [   24.628724] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   24.628757] RIP: 0010:alloc_vmap_area.isra.53+0x593/0xf10
> [   24.628784] Code: 41 5d 41 5e 41 5f c3 0f 0b 0f 0b 48 c7 44 24 10 f0 ff ff ff eb c9 48 8d 5a f0 e9 9c fc ff ff 48 c7 44 24 10 f4 ff ff ff eb b5 <0f> 0b 4c 8d 4b 10 48 39 d0 74 12 48 8b 44 24 18 31 ff 48 89 03 48
> [   24.628853] RSP: 0018:ffffc4296cf67d38 EFLAGS: 00010206
> [   24.628876] RAX: ffffd6db9e61a000 RBX: ffff8ae9c9309440 RCX: 0000000000000001
> [   24.628905] RDX: 0000000080000001 RSI: ffff8ae9c0046be8 RDI: 00000000ffffffff
> [   24.628933] RBP: 0000000000002000 R08: ffff8ae9c13699e8 R09: ffffb98000000000
> [   24.628961] R10: ffffd6db9e61a000 R11: 000000003aa1c801 R12: ffff8ae9c9f0d280
> [   24.628989] R13: 0000008000001fff R14: ffffff8000000000 R15: 0000007fffffffff
> [   24.629019] FS:  0000000000000000(0000) GS:ffff8af8bf580000(0000) knlGS:0000000000000000
> [   24.629051] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.629074] CR2: 000055916370aa80 CR3: 00000006bf40a000 CR4: 00000000000006e0
> [   24.629103] Call Trace:
> [   24.629128]  ? map_kernel_range_noflush+0x27a/0x360
> [   24.629150]  ? kmem_cache_alloc_trace+0x340/0x460
> [   24.629172]  __get_vm_area_node.isra.54+0xa7/0x150
> [   24.629195]  ? fix_size_alloc_test+0x50/0x50 [test_vmalloc]
> [   24.629221]  __vmalloc_node_range+0x64/0x230
> [   24.629241]  ? test_func+0xdb/0x1f0 [test_vmalloc]
> [   24.629263]  ? fix_size_alloc_test+0x50/0x50 [test_vmalloc]
> [   24.629288]  __vmalloc_node+0x3b/0x40
> [   24.629305]  ? test_func+0xdb/0x1f0 [test_vmalloc]
> [   24.629326]  align_shift_alloc_test+0x39/0x50 [test_vmalloc]
> [   24.629350]  test_func+0xdb/0x1f0 [test_vmalloc]
> [   24.629372]  ? fix_align_alloc_test+0x50/0x50 [test_vmalloc]
> [   24.629396]  kthread+0x13d/0x160
> [   24.629413]  ? kthread_park+0x80/0x80
> [   24.629431]  ret_from_fork+0x22/0x30
> <snip>
> 
> --
> Vlad Rezki
> 

Hopefully I can also reproduce this with test driver. Thanks for testing!

-Topi

