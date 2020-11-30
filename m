Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC972C8F24
	for <lists+linux-api@lfdr.de>; Mon, 30 Nov 2020 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgK3U1y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 15:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgK3U1y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Nov 2020 15:27:54 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AD2C0613CF;
        Mon, 30 Nov 2020 12:27:13 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id r18so20060328ljc.2;
        Mon, 30 Nov 2020 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lDZ5X6WZg4oXWrzpU1s7ivHNltSMZSLkihBqR57bbc4=;
        b=ChID5aWK1J8Dr7qE6xzUGdBM2InzVzSWqMA5JNKDFsUFIEnwoRuUaP4ze3j89ILfrp
         MWDJteoca5YbtnRrDTMoW1VwB0tqZ5eNltnVszNopSJEBcxQGbJ5IpbFy8ymUA8Tv2Zx
         uSeLaWYeaBV8DZNoqcjhPwXAYJtOFRARO2DBK6mNBTeSqrK2VBXjZVo5wc1HMZ4GEVee
         9a5hoEUuBpHsHjFX9lI+DQCy3WCm6qDXESz2AZeivrkiVKYLdBo/cxJjbLkxLYo1ua3C
         lqzce/dJtZz0e9Dod1rK0rIa+GJ21D9LCCQBT8+48NEPDPFqf0DcD6JqKpUerOMPa6Hi
         Yr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lDZ5X6WZg4oXWrzpU1s7ivHNltSMZSLkihBqR57bbc4=;
        b=f/bWQ81LTtBEcb6ddyctbMc0Sv6n+WpPg1HQ85U1ewiy3qO9fB3oQOHR1hFRfmdVcm
         xR/H36bZZPko15INEUKSY8J78YFZV6a4DfYI2CmX2YqHvzrVranjDy+PzWkANE0Q15vM
         Jj5tEHuuANitVnS2Uc8JCI4IpovcS30BwUHYsbzUxWEbIzQ0+PCf0ma19I5lHL1UFa2y
         FEA3dr2uNVLxNURQB8MfqPRVe/oHn8japrcNu0o/eAksylaIQBZh2KqkzJipbzoIGXJJ
         IOsfTxX/Za8cEkQYqFd8hTP2/WVNgaloCRZ0FwPcVrbeBv5fPj1XcO2GqhNDkLO/f6mb
         3Rjg==
X-Gm-Message-State: AOAM530dZon0MiIiSnhubA7IMnHfwVS1ld9XpIKxcdPeb1mOu2GAvECx
        8Irgq2dDSJRaGURq3ga5Q0LNtIRlDsYbqg==
X-Google-Smtp-Source: ABdhPJyWdXJqwzvdEWtGKon4yAMFKqjdI9fNYK6LaEzoi1ZobKV0sATs6JyIp0V1Mg9jL8K5bIbldg==
X-Received: by 2002:a2e:8e6c:: with SMTP id t12mr11034447ljk.441.1606768031766;
        Mon, 30 Nov 2020 12:27:11 -0800 (PST)
Received: from [192.168.1.39] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id b145sm2565287lfg.225.2020.11.30.12.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 12:27:10 -0800 (PST)
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso and
 stack
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20201129211517.2208-1-toiwoton@gmail.com>
 <CALCETrXcai-gyfnS7uFSRwdR2roBRY78JZ5_1sa0Ux77xzNhvA@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <4f0b9735-cf55-30cf-f78c-4affc5f8ca3c@gmail.com>
Date:   Mon, 30 Nov 2020 22:27:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXcai-gyfnS7uFSRwdR2roBRY78JZ5_1sa0Ux77xzNhvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 30.11.2020 19.57, Andy Lutomirski wrote:
> On Sun, Nov 29, 2020 at 1:20 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
>> enables full randomization of memory mappings created with mmap(NULL,
>> ...). With 2, the base of the VMA used for such mappings is random,
>> but the mappings are created in predictable places within the VMA and
>> in sequential order. With 3, new VMAs are created to fully randomize
>> the mappings.
>>
>> Also mremap(..., MREMAP_MAYMOVE) will move the mappings even if not
>> necessary and the location of stack and vdso are also randomized.
>>
>> The method is to randomize the new address without considering
>> VMAs. If the address fails checks because of overlap with the stack
>> area (or in case of mremap(), overlap with the old mapping), the
>> operation is retried a few times before falling back to old method.
>>
>> On 32 bit systems this may cause problems due to increased VM
>> fragmentation if the address space gets crowded.
>>
>> On all systems, it will reduce performance and increase memory usage
>> due to less efficient use of page tables and inability to merge
>> adjacent VMAs with compatible attributes. In the worst case,
>> additional page table entries of up to 4 pages are created for each
>> mapping, so with small mappings there's considerable penalty.
>>
>> In this example with sysctl.kernel.randomize_va_space = 2, dynamic
>> loader, libc, anonymous memory reserved with mmap() and locale-archive
>> are located close to each other:
>>
>> $ cat /proc/self/maps (only first line for each object shown for brevity)
>> 5acea452d000-5acea452f000 r--p 00000000 fe:0c 1868624                    /usr/bin/cat
>> 74f438f90000-74f4394f2000 r--p 00000000 fe:0c 2473999                    /usr/lib/locale/locale-archive
>> 74f4394f2000-74f4395f2000 rw-p 00000000 00:00 0
>> 74f4395f2000-74f439617000 r--p 00000000 fe:0c 2402332                    /usr/lib/x86_64-linux-gnu/libc-2.31.so
>> 74f4397b3000-74f4397b9000 rw-p 00000000 00:00 0
>> 74f4397e5000-74f4397e6000 r--p 00000000 fe:0c 2400754                    /usr/lib/x86_64-linux-gnu/ld-2.31.so
>> 74f439811000-74f439812000 rw-p 00000000 00:00 0
>> 7fffdca0d000-7fffdca2e000 rw-p 00000000 00:00 0                          [stack]
>> 7fffdcb49000-7fffdcb4d000 r--p 00000000 00:00 0                          [vvar]
>> 7fffdcb4d000-7fffdcb4f000 r-xp 00000000 00:00 0                          [vdso]
>>
>> With sysctl.kernel.randomize_va_space = 3, they are located at
>> unrelated addresses and the order is random:
>>
>> $ echo 3 > /proc/sys/kernel/randomize_va_space
>> $ cat /proc/self/maps (only first line for each object shown for brevity)
>> 3850520000-3850620000 rw-p 00000000 00:00 0
>> 28cfb4c8000-28cfb4cc000 r--p 00000000 00:00 0                            [vvar]
>> 28cfb4cc000-28cfb4ce000 r-xp 00000000 00:00 0                            [vdso]
>> 9e74c385000-9e74c387000 rw-p 00000000 00:00 0
>> a42e0233000-a42e0234000 r--p 00000000 fe:0c 2400754                      /usr/lib/x86_64-linux-gnu/ld-2.31.so
>> a42e025f000-a42e0260000 rw-p 00000000 00:00 0
>> bea40427000-bea4044c000 r--p 00000000 fe:0c 2402332                      /usr/lib/x86_64-linux-gnu/libc-2.31.so
>> bea405e8000-bea405ec000 rw-p 00000000 00:00 0
>> f6d446fa000-f6d44c5c000 r--p 00000000 fe:0c 2473999                      /usr/lib/locale/locale-archive
>> fcfbf684000-fcfbf6a5000 rw-p 00000000 00:00 0                            [stack]
>> 619aba62d000-619aba62f000 r--p 00000000 fe:0c 1868624                    /usr/bin/cat
>>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: Jann Horn <jannh@google.com>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Matthew Wilcox <willy@infradead.org>
>> CC: Mike Rapoport <rppt@kernel.org>
>> CC: Linux API <linux-api@vger.kernel.org>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>> ---
>> v2: also randomize mremap(..., MREMAP_MAYMOVE)
>> v3: avoid stack area and retry in case of bad random address (Jann
>> Horn), improve description in kernel.rst (Matthew Wilcox)
>> v4:
>> - use /proc/$pid/maps in the example (Mike Rapaport)
>> - CCs (Andrew Morton)
>> - only check randomize_va_space == 3
>> v5: randomize also vdso and stack
>> ---
>>   Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++--
>>   Documentation/admin-guide/sysctl/kernel.rst   | 20 +++++++++++++
>>   arch/x86/entry/vdso/vma.c                     | 26 +++++++++++++++-
>>   include/linux/mm.h                            |  8 +++++
>>   init/Kconfig                                  |  2 +-
>>   mm/mmap.c                                     | 30 +++++++++++++------
>>   mm/mremap.c                                   | 27 +++++++++++++++++
>>   mm/util.c                                     |  6 ++++
>>   8 files changed, 111 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
>> index e05e581af5cf..9ea250522077 100644
>> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
>> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
>> @@ -254,7 +254,7 @@ Spectre variant 2
>>      left by the previous process will also be cleared.
>>
>>      User programs should use address space randomization to make attacks
>> -   more difficult (Set /proc/sys/kernel/randomize_va_space = 1 or 2).
>> +   more difficult (Set /proc/sys/kernel/randomize_va_space = 1, 2 or 3).
>>
>>   3. A virtualized guest attacking the host
>>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> @@ -499,8 +499,8 @@ Spectre variant 2
>>      more overhead and run slower.
>>
>>      User programs should use address space randomization
>> -   (/proc/sys/kernel/randomize_va_space = 1 or 2) to make attacks more
>> -   difficult.
>> +   (/proc/sys/kernel/randomize_va_space = 1, 2 or 3) to make attacks
>> +   more difficult.
>>
>>   3. VM mitigation
>>   ^^^^^^^^^^^^^^^^
>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>> index d4b32cc32bb7..806e3b29d2b5 100644
>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>> @@ -1060,6 +1060,26 @@ that support this feature.
>>       Systems with ancient and/or broken binaries should be configured
>>       with ``CONFIG_COMPAT_BRK`` enabled, which excludes the heap from process
>>       address space randomization.
>> +
>> +3   Additionally enable full randomization of memory mappings created
>> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
>> +    mappings is random, but the mappings are created in predictable
>> +    places within the VMA and in sequential order. With 3, new VMAs
>> +    are created to fully randomize the mappings.
>> +
>> +    Also mremap(..., MREMAP_MAYMOVE) will move the mappings even if
>> +    not necessary and the location of stack and vdso are also
>> +    randomized.
>> +
>> +    On 32 bit systems this may cause problems due to increased VM
>> +    fragmentation if the address space gets crowded.
>> +
>> +    On all systems, it will reduce performance and increase memory
>> +    usage due to less efficient use of page tables and inability to
>> +    merge adjacent VMAs with compatible attributes. In the worst case,
>> +    additional page table entries of up to 4 pages are created for
>> +    each mapping, so with small mappings there's considerable penalty.
>> +
>>   ==  ===========================================================================
>>
>>
>> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
>> index 9185cb1d13b9..03ea884822e3 100644
>> --- a/arch/x86/entry/vdso/vma.c
>> +++ b/arch/x86/entry/vdso/vma.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/init.h>
>>   #include <linux/random.h>
>>   #include <linux/elf.h>
>> +#include <linux/elf-randomize.h>
>>   #include <linux/cpu.h>
>>   #include <linux/ptrace.h>
>>   #include <linux/time_namespace.h>
>> @@ -32,6 +33,8 @@
>>          const size_t name ## _offset = offset;
>>   #include <asm/vvar.h>
>>
>> +#define MAX_RANDOM_VDSO_RETRIES                        5
>> +
>>   struct vdso_data *arch_get_vdso_data(void *vvar_page)
>>   {
>>          return (struct vdso_data *)(vvar_page + _vdso_data_offset);
>> @@ -361,7 +364,28 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
>>
>>   static int map_vdso_randomized(const struct vdso_image *image)
>>   {
>> -       unsigned long addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
>> +       unsigned long addr;
>> +
>> +       if (randomize_va_space == 3) {
>> +               /*
>> +                * Randomize vdso address.
>> +                */
>> +               int i = MAX_RANDOM_VDSO_RETRIES;
>> +
>> +               do {
>> +                       int ret;
>> +
>> +                       /* Try a few times to find a free area */
>> +                       addr = arch_mmap_rnd();
>> +
>> +                       ret = map_vdso(image, addr);
>> +                       if (!IS_ERR_VALUE(ret))
>> +                               return ret;
>> +               } while (--i >= 0);
>> +
>> +               /* Give up and try the less random way */
>> +       }
>> +       addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
> 
> This is IMO rather ugly.  You're picking random numbers and throwing
> them at map_vdso(), which throws them at get_unmapped_area(), which
> will validate them.  And you duplicate the same ugly loop later on.

I agree it's not very pretty, but I'd expect that the first number would 
already have high probability of getting accepted and the probability of 
all five attempts failing should be very low. For example, on a system 
with 16GB of RAM, maximum VM of 32GB (35 bits) and 47 bits of available 
VM space (since kernel takes one bit), the chances of failure should be 
1 - 1 / 2^(47 - 35) or only one out of 4096 first attempts should be 
expected to fail. Chances of all five failing should be 1 / 2^60.

> How about instead pushing this logic into get_unmapped_area()?

The real work seems to be done in unmapped_area() and similar 
unmapped_area_topdown(), which traverse a RB tree when checking the 
address. Maybe a more clever algorithm could walk the tree using a 
random starting address, and when on a branch the address is found 
invalid (again, not very likely), instead of restarting from top, the 
search could mutate some bits of the address and continue randomly 
either sideways or backing up. I'm not sure how randomness properties 
would be affected by this and how to guarantee that the random walk will 
always stop eventually. This is not a problem with the proposed simple 
approach.

-Topi

> --Andy
> 
