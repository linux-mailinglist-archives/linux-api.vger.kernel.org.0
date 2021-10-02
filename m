Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3041FD84
	for <lists+linux-api@lfdr.de>; Sat,  2 Oct 2021 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhJBRwF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 2 Oct 2021 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhJBRwF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 2 Oct 2021 13:52:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CDC0613EC;
        Sat,  2 Oct 2021 10:50:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t8so21129694wri.1;
        Sat, 02 Oct 2021 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2jp3PD3TWJltHW7N2psGrVeTnjVF/lo5/Ceegyd14Cg=;
        b=jSQkqnOD0aOEkfzKF1sorxRDER5LyobJkTBdYciuA2yJn1neYQa2yRvFCL/LrEnuTV
         V1Msk6ZYFoWPWacrBpp6DVnTsXeKi+x6kAt/PEYy4GtAHepChlwlo9zqGfh0PNE5QQSi
         z/avcKHxXVVT1k6YViMJb+3LJWj9DRr2pWrUNnOwoDDatasPaqLcB3SOZPuEVnMo0yi4
         smnLsfsDnJeU74ydouII2CBekzlf9g8PBEdj0r3WMZOrezsot/shbhVw5HoRiB2I6nWT
         W6vkAb02hkFUT9fSboR+sp1I1vZsCLmZkWI0XClkiuYUUPokWjyicKmvGsN/+UEAYiub
         Sb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jp3PD3TWJltHW7N2psGrVeTnjVF/lo5/Ceegyd14Cg=;
        b=jGQKdtaZeQ1l6eZdTASwlSeKNbE/XCXLxUSyuwj0LhOHa4A5cwaDqxADOkhFWJpT3r
         BOvk4fqUjEo8qhs7GXYLCn51eFduGVC7qTEUyVO0kFo36u6gvUa2ux+NwORe6R4fOYex
         8RSbHYK6S9qHq9m5s/eTBdekm//BVC//G5FHgJwWOmQFSWXq/UGQtzJxdjYmfHwerr/F
         E95Zh3sS7YJxOuInTDic4v6/NL3iiG0m03tFn8u/7lcKrJbp/4u5/lIyVdQWGPVKl7op
         rjQxof5JjaWf296/OarC2H6ZKLVoIfxDTEkH0dRC6/kfu7gM0tjDQPuigugu10WV9ax9
         qriw==
X-Gm-Message-State: AOAM5338isNmN5T8MGnCBCMoTt1QG8MUXgQhr1rm9UZ6RmlukmQusXaU
        /7wp+zPiRpVwuwfBY/IwWiQ=
X-Google-Smtp-Source: ABdhPJw9cN/ebImyYYNw9xaaX4Kpr0s/Zd1EvBH6dCc731v/UOGSERtIAL5L1TPzNDG2c/0BnMOL7Q==
X-Received: by 2002:adf:8919:: with SMTP id s25mr4475713wrs.185.1633197017664;
        Sat, 02 Oct 2021 10:50:17 -0700 (PDT)
Received: from [10.8.0.30] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id o8sm2292686wme.38.2021.10.02.10.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 10:50:17 -0700 (PDT)
Subject: Re: [PATCH v3] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
To:     David Hildenbrand <david@redhat.com>, linux-man@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@ionos.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>, linux-mm@kvack.org
References: <20210823120645.8223-1-david@redhat.com>
 <50357269-d227-5fda-a450-c47b035b9586@redhat.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <0e9e04f4-e14e-e2b7-7672-75e919778b0a@gmail.com>
Date:   Sat, 2 Oct 2021 19:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <50357269-d227-5fda-a450-c47b035b9586@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi David,

On 9/28/21 6:34 PM, David Hildenbrand wrote:
> On 23.08.21 14:06, David Hildenbrand wrote:
>> MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
>> upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
>> MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.
>>
>> Further, commit eb2faa513c24 ("mm/madvise: report SIGBUS as -EFAULT for
>> MADV_POPULATE_(READ|WRITE)"), part of v5.14-rc6, made sure that SIGBUS is
>> converted to -EFAULT instead of -EINVAL.
>>
>> Let's document the behavior and error conditions of these new madvise()
>> options.
>>
>> Acked-by: Pankaj Gupta <pankaj.gupta@ionos.com>
>> Cc: Alejandro Colomar <alx.manpages@gmail.com>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Linux API <linux-api@vger.kernel.org>
>> Cc: linux-mm@kvack.org
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---

Patch applied.

Thanks,

Alex

>>
>> v2 -> v3:
>> - Refine what "populating readable/writable" means
>> - Compare each version with MAP_POPULATE and give an example use case
>> - Reword SIGBUS handling
>> - Reword comment regarding special mappings and also add memfd_secret(2)
>> - Reference MADV_HWPOISON when talking about HW poisoned pages
>> - Minor cosmetic fixes
>>
>> v1 -> v2:
>> - Use semantic newlines in all cases
>> - Add two missing "
>> - Document -EFAULT handling
>> - Rephrase some parts to make it more generic: VM_PFNMAP and VM_IO are 
>> only
>>    examples for special mappings
>>
>> ---
>>   man2/madvise.2 | 156 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 156 insertions(+)
>>
>> diff --git a/man2/madvise.2 b/man2/madvise.2
>> index f1f384c0c..37f6dd6fa 100644
>> --- a/man2/madvise.2
>> +++ b/man2/madvise.2
>> @@ -469,6 +469,106 @@ If a page is file-backed and dirty, it will be 
>> written back to the backing
>>   storage.
>>   The advice might be ignored for some pages in the range when it is not
>>   applicable.
>> +.TP
>> +.BR MADV_POPULATE_READ " (since Linux 5.14)"
>> +"Populate (prefault) page tables readable,
>> +faulting in all pages in the range just as if manually reading from 
>> each page;
>> +however,
>> +avoid the actual memory access that would have been performed after 
>> handling
>> +the fault.
>> +.IP
>> +In contrast to
>> +.BR MAP_POPULATE ,
>> +.B MADV_POPULATE_READ
>> +does not hide errors,
>> +can be applied to (parts of) existing mappings and will always populate
>> +(prefault) page tables readable.
>> +One example use case is prefaulting a file mapping,
>> +reading all file content from disk;
>> +however,
>> +pages won't be dirtied and consequently won't have to be written back 
>> to disk
>> +when evicting the pages from memory.
>> +.IP
>> +Depending on the underlying mapping,
>> +map the shared zeropage,
>> +preallocate memory or read the underlying file;
>> +files with holes might or might not preallocate blocks.
>> +If populating fails,
>> +a
>> +.B SIGBUS
>> +signal is not generated; instead, an error is returned.
>> +.IP
>> +If
>> +.B MADV_POPULATE_READ
>> +succeeds,
>> +all page tables have been populated (prefaulted) readable once.
>> +If
>> +.B MADV_POPULATE_READ
>> +fails,
>> +some page tables might have been populated.
>> +.IP
>> +.B MADV_POPULATE_READ
>> +cannot be applied to mappings without read permissions
>> +and special mappings,
>> +for example,
>> +mappings marked with kernel-internal flags such as
>> +.B VM_PFNMAP
>> +or
>> +.BR VM_IO ,
>> +or secret memory regions created using
>> +.BR memfd_secret(2) .
>> +.IP
>> +Note that with
>> +.BR MADV_POPULATE_READ ,
>> +the process can be killed at any moment when the system runs out of 
>> memory.
>> +.TP
>> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)"
>> +Populate (prefault) page tables writable,
>> +faulting in all pages in the range just as if manually writing to each
>> +each page;
>> +however,
>> +avoid the actual memory access that would have been performed after 
>> handling
>> +the fault.
>> +.IP
>> +In contrast to
>> +.BR MAP_POPULATE ,
>> +MADV_POPULATE_WRITE does not hide errors,
>> +can be applied to (parts of) existing mappings and will always populate
>> +(prefault) page tables writable.
>> +One example use case is preallocating memory,
>> +breaking any CoW (Copy on Write).
>> +.IP
>> +Depending on the underlying mapping,
>> +preallocate memory or read the underlying file;
>> +files with holes will preallocate blocks.
>> +If populating fails,
>> +a
>> +.B SIGBUS
>> +signal is not generated; instead, an error is returned.
>> +.IP
>> +If
>> +.B MADV_POPULATE_WRITE
>> +succeeds,
>> +all page tables have been populated (prefaulted) writable once.
>> +If
>> +.B MADV_POPULATE_WRITE
>> +fails,
>> +some page tables might have been populated.
>> +.IP
>> +.B MADV_POPULATE_WRITE
>> +cannot be applied to mappings without write permissions
>> +and special mappings,
>> +for example,
>> +mappings marked with kernel-internal flags such as
>> +.B VM_PFNMAP
>> +or
>> +.BR VM_IO ,
>> +or secret memory regions created using
>> +.BR memfd_secret(2) .
>> +.IP
>> +Note that with
>> +.BR MADV_POPULATE_WRITE ,
>> +the process can be killed at any moment when the system runs out of 
>> memory.
>>   .SH RETURN VALUE
>>   On success,
>>   .BR madvise ()
>> @@ -490,6 +590,22 @@ A kernel resource was temporarily unavailable.
>>   .B EBADF
>>   The map exists, but the area maps something that isn't a file.
>>   .TP
>> +.B EFAULT
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +and populating (prefaulting) page tables failed because a
>> +.B SIGBUS
>> +would have been generated on actual memory access and the reason is 
>> not a
>> +HW poisoned page
>> +(HW poisoned pages can,
>> +for example,
>> +be created using the
>> +.B MADV_HWPOISON
>> +flag described elsewhere in this page).
>> +.TP
>>   .B EINVAL
>>   .I addr
>>   is not page-aligned or
>> @@ -533,6 +649,22 @@ or
>>   .BR VM_PFNMAP
>>   ranges.
>>   .TP
>> +.B EINVAL
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +but the specified address range includes ranges with insufficient 
>> permissions
>> +or special mappings,
>> +for example,
>> +mappings marked with kernel-internal flags such a
>> +.B VM_IO
>> +or
>> +.BR VM_PFNMAP ,
>> +or secret memory regions created using
>> +.BR memfd_secret(2) .
>> +.TP
>>   .B EIO
>>   (for
>>   .BR MADV_WILLNEED )
>> @@ -548,6 +680,15 @@ Not enough memory: paging in failed.
>>   Addresses in the specified range are not currently
>>   mapped, or are outside the address space of the process.
>>   .TP
>> +.B ENOMEM
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +and populating (prefaulting) page tables failed because there was not 
>> enough
>> +memory.
>> +.TP
>>   .B EPERM
>>   .I advice
>>   is
>> @@ -555,6 +696,20 @@ is
>>   but the caller does not have the
>>   .B CAP_SYS_ADMIN
>>   capability.
>> +.TP
>> +.B EHWPOISON
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +and populating (prefaulting) page tables failed because a HW poisoned 
>> page
>> +(HW poisoned pages can,
>> +for example,
>> +be created using the
>> +.B MADV_HWPOISON
>> +flag described elsewhere in this page)
>> +was encountered.
>>   .SH VERSIONS
>>   Since Linux 3.18,
>>   .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb
>> @@ -602,6 +757,7 @@ from the system call, as it should).
>>   .\" function first appeared in 4.4BSD.
>>   .SH SEE ALSO
>>   .BR getrlimit (2),
>> +.BR memfd_secret(2),
>>   .BR mincore (2),
>>   .BR mmap (2),
>>   .BR mprotect (2),
>>
> 
> Gentle ping.
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
