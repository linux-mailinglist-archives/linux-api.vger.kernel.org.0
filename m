Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B453EFF3C
	for <lists+linux-api@lfdr.de>; Wed, 18 Aug 2021 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhHRIgI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 04:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239234AbhHRIgE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 04:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629275728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1Ko8+ILOMc+8O6rANr8DU6FjMVNXf3i4wLW1p6zNUU=;
        b=YW/4n+zLfMT6b0rbF5y0agsahDQZ6DqrH3zuR+GMaPkj5Cm5a/bj0sRtJ3E8rb0xow/1k/
        Vaot71c5T7xmAkp5xcOqq/vdA2JugooIvi47K6FhvlKf5xk9JPtEGKRjrHBEQ8b9uKKAad
        70pDAU2p7sOcfTrCPceTg7U2KsM3kiM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-vvYQvccDNSuP9TO_0ZZ5QA-1; Wed, 18 Aug 2021 04:35:27 -0400
X-MC-Unique: vvYQvccDNSuP9TO_0ZZ5QA-1
Received: by mail-wr1-f72.google.com with SMTP id l1-20020adff481000000b00156e670a09dso354555wro.1
        for <linux-api@vger.kernel.org>; Wed, 18 Aug 2021 01:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b1Ko8+ILOMc+8O6rANr8DU6FjMVNXf3i4wLW1p6zNUU=;
        b=gajbNGmc0IJvm1HPyAlDxoaIRO9BvORNTuofAXqEzIE9U5Mv8ap0MthE2XRRQ8b0k/
         0AqS62cenJ8P8t9IIe8LrpUeJf3DFmoeCcz6vXwgAr2e7otOOf8kWPY8wEuMmYh66Lg5
         94vMpu8Qy2zpg5YgD8Ei8IHfoLh2zioiMPd4wQM1pzjxUNcMVBVAtX+4cvlBYXcDsA0Y
         qc5fQQnACjEabCl5BckQFD5KoEoFRH1pdHKTH1nZnVHterFlaLqc1diKk7unpfh7F5/Y
         ZiG1NgZ9lj+g6RVOWYOCGQBwS2vZXoX7LFAtzDXYwW2rL8MbdN6rPC+OO6sfsioSQ8xU
         jrpg==
X-Gm-Message-State: AOAM533ikUHzN/Bv229GI7m1emiF7+jIya7LHO8HrAUnk6slSmvAlWu+
        jb7rL2SyvvcXEIsxjkmtKDa5zrCEzaIVfvTZ9uwu3J3X4YcAzfQgSNFNU3Q/Ztu88SDgLqQonsN
        qjQGLLCRpxHEYJZbEMQ2i
X-Received: by 2002:a05:6000:25a:: with SMTP id m26mr9123825wrz.262.1629275725927;
        Wed, 18 Aug 2021 01:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb/yN+nWIaEIebPNyA6KpcKsGT6xb17YaQThnz7zbqeBRx2VuHB3zWqtLfRlASOujKa1hfVQ==
X-Received: by 2002:a05:6000:25a:: with SMTP id m26mr9123809wrz.262.1629275725712;
        Wed, 18 Aug 2021 01:35:25 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id r4sm4279212wmq.34.2021.08.18.01.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:35:25 -0700 (PDT)
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@ionos.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>, linux-mm@kvack.org
References: <20210816081922.5155-1-david@redhat.com>
 <d70ef542-051a-521f-807d-fa469b28e897@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
Message-ID: <70792f9c-ace1-6876-378b-5388f7948a60@redhat.com>
Date:   Wed, 18 Aug 2021 10:35:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d70ef542-051a-521f-807d-fa469b28e897@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17.08.21 23:42, Michael Kerrisk (man-pages) wrote:
> Hello David,
> 
> Thank you for writing this! Could you please take
> a look at the comments below and revise?

Hi Michael,

thanks for your valuable input. Your feedback will certainly make this 
easier to understand for people that are not heavily involved in MM work :)

[...]

>>   man2/madvise.2 | 107 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 107 insertions(+)
>>
>> diff --git a/man2/madvise.2 b/man2/madvise.2
>> index f1f384c0c..f6cea9ad2 100644
>> --- a/man2/madvise.2
>> +++ b/man2/madvise.2
>> @@ -469,6 +469,72 @@ If a page is file-backed and dirty, it will be written back to the backing
>>   storage.
>>   The advice might be ignored for some pages in the range when it is not
>>   applicable.
>> +.TP
>> +.BR MADV_POPULATE_READ " (since Linux 5.14)"
>> +Populate (prefault) page tables readable for the whole range without actually
> 
> I have trouble to understand "Populate (prefault) page tables readable".
> Does it mean that it is just the page tables are being populated, and the
> PTEs are marked to indicate that the pages are readable? If yes, I
> think some rewording would help.

I actually tried phrasing it similar to our MAP_POPULATE documentation:
	("Populate  (prefault)  page tables for a mapping.")

We will prefault all pages, faulting them in.
> 
>> +reading memory.
> 
> I don't understand "without actually reading memory"? Do you mean,
> "without actually  faulting in the pages"; or something else?

"Populate (prefault) page tables readable, faulting in all pages in the 
range just as if manually reading one byte of each page; however, avoid 
the actual memory access that would have been performed after handling 
the fault."

Does that make it clearer? (avoiding eventually touching the page at all 
can be beneficial, especially when dealing with DAX memory where memory 
access might be expensive)

> 
>> +Depending on the underlying mapping,
>> +map the shared zeropage,
>> +preallocate memory or read the underlying file;
>> +files with holes might or might not preallocate blocks.
>> +Do not generate
>> +.B SIGBUS
>> +when populating fails,
>> +return an error instead.
> 
> Better:
> 
> [[
> If populating fails, a
> .B SIGBUS
> signal is not generated; instead, an error i returned.
> ]]
> 

Sure, thanks.

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
>> +marked with the kernel-internal
> 
> s/marked/mappings marked/
> 
>> +.B VM_PFNMAP
>> +and
> 
> Just checking: should it be "and" or "or" here"?
> 
> Looking at the EINVAL error below, I guess "or", and a better
> wording would be:
> 
> [[
> ...for example, mappings marked with kernel-internal flags such as
> .B VMPPFNMAP
> or
> .BR BR_V_IO.
> ]]

Much better. Note that there might be more types of mappings that won't 
work (e.g., initially also secretmem IIRC).

> 
>> +.BR VM_IO .
>> +.IP
>> +Note that with
>> +.BR MADV_POPULATE_READ ,
>> +the process can be killed at any moment when the system runs out of memory.
>> +.TP
>> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)"
>> +Populate (prefault) page tables writable for the whole range without actually
> 
> I have trouble to understand "Populate (prefault) page tables writable".
> Does it mean that it is just the page tables are being populated, and the
> PTEs are marked to indicate that the pages are writable? If yes, I
> think some rewording would help.
> 
>> +writing memory.
> 
> I don't understand "without actually writing memory"? Do you mean,
> "without actually  faulting in the pages"; or something else?
> 

Similar to the other wording:

"Populate (prefault) page tables writable, faulting in all pages in the 
range just as if manually writing one byte of each page; however, avoid 
the actual memory access that would have been performed after handling 
the fault."

>> +Depending on the underlying mapping,
>> +preallocate memory or read the underlying file;
>> +files with holes will preallocate blocks.
>> +Do not generate
>> +.B SIGBUS
>> +when populating fails,
>> +return an error instead.
> 
> Better:
> 
> [[
> If populating fails, a
> .B SIGBUS
> signal is not generated; instead, an error i returned.
> ]]
> 

Ack.

> +.IP
>> +If
>> +.B MADV_POPULATE_WRITE
>> +succeeds,
>> +all page tables have been populated (prefaulted) writable once.
>> +If
>> +.B MADV_POPULATE_WRITE
>> +fails, some page tables might have been populated.
>> +.IP
>> +.B MADV_POPULATE_WRITE
>> +cannot be applied to mappings without write permissions
>> +and special mappings,
>> +for example,
>> +marked with the kernel-internal
> 
> s/marked/mappings marked/
> 
>> +.B VM_PFNMAP
>> +and
> 
> Just checking: should it be "and" or "or" here"?
> 
> Looking at the EINVAL error below, I guess "or", and a better
> wording would be:
> 
> [[
> ...for example, mappings marked with kernel-internal flags such as
> .B VMPPFNMAP
> or
> .BR BR_V_IO.
> ]]
> 

Ack.

>> +.BR VM_IO .
>> +.IP
>> +Note that with
>> +.BR MADV_POPULATE_WRITE ,
>> +the process can be killed at any moment when the system runs out of memory.
>>   .SH RETURN VALUE
>>   On success,
>>   .BR madvise ()
>> @@ -490,6 +556,17 @@ A kernel resource was temporarily unavailable.
>>   .B EBADF
>>   The map exists, but the area maps something that isn't a file.
>>   .TP
>> +.B EFAULT
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +and populating (prefaulting) page tables failed because a
>> +.B SIGBUS
>> +would have been generated on actual memory access and the reason is not a
>> +HW poisoned page.
> 
> Maybe:
> s/.$/(see the description of MADV_HWPOISON in this page)./
> ?
> 

Sure, we can add that. But note that MADV_HWPOISON is just one of many 
ways to HWpoison a page.

>> +.TP
>>   .B EINVAL
>>   .I addr
>>   is not page-aligned or
>> @@ -533,6 +610,18 @@ or
>>   .BR VM_PFNMAP
>>   ranges.
>>   .TP
>> +.B EINVAL
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +but the specified address range includes ranges with insufficient permissions
>> +or incompatible mappings such as
>> +.B VM_IO
>> +or
>> +.BR VM_PFNMAP.
> 
> s/.BR VM_PFNMAP./.BR VM_PFNMAP ./
> 

Agreed.

>> +.TP
>>   .B EIO
>>   (for
>>   .BR MADV_WILLNEED )
>> @@ -548,6 +637,15 @@ Not enough memory: paging in failed.
>>   Addresses in the specified range are not currently
>>   mapped, or are outside the address space of the process.
>>   .TP
>> +.B ENOMEM
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +and populating (prefaulting) page tables failed because there was not enough
>> +memory.
>> +.TP
>>   .B EPERM
>>   .I advice
>>   is
>> @@ -555,6 +653,15 @@ is
>>   but the caller does not have the
>>   .B CAP_SYS_ADMIN
>>   capability.
>> +.TP
>> +.B EHWPOISON
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +and populating (prefaulting) page tables failed because a HW poisoned page
>> +was encountered.
>>   .SH VERSIONS
>>   Since Linux 3.18,
>>   .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb
> 
> Thanks,
> 


Thanks a lot Michael!


-- 
Thanks,

David / dhildenb

