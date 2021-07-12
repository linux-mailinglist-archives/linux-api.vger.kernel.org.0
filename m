Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76E63C5A8B
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhGLKHA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 06:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238210AbhGLKGv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 06:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626084242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gVdXMnmbrFdhM3Ud9GG9Z0Ypa4CVzqPjHQh66H2MuM=;
        b=BLwy4pbPzO04db0bC7UxozAyc6dIhz1bCTkYY8e40/E2cx8+bxEJdD6tGM1HZv985f+7U6
        FdZbbdMmSYhg9SDTpzE7pBafX2o1QABpB570wmGZ4dPwTDdBK6eMFulv9UDrNP95cFRjb9
        ZTs39e63t8yqHMnrL2ElY9cP2YZjUS0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-PiJzVgroM5iGwwq85Q-54w-1; Mon, 12 Jul 2021 06:04:01 -0400
X-MC-Unique: PiJzVgroM5iGwwq85Q-54w-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so2793899wmj.8
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 03:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6gVdXMnmbrFdhM3Ud9GG9Z0Ypa4CVzqPjHQh66H2MuM=;
        b=paoKu9GrqooGATKsvg7hRPuYcRtS34kWp3ELUYLZWTeA5vgtFIDuDHB3SW+/NqpJRP
         xtPaHRHr640tyf3VKJZ+ZTwmJvnFyuFtnPETEekhNG5FnWQAcIsVAavaQ2CjJWPsDlYi
         KBQGC8vFlagj/w933Xe47uNFUFZV7HDlKnrQgxu1CZl4PgToYcnkEqCYbVmS6H+IKmaH
         RxnlAU5d9xu7mI0TIcabrn9Z1tSZjHx+X6g/CNDnO/etI7znYWoj8iEIQCbRrMRHDJTF
         PkqsxMns0tA389kHS6dwGRGMH3jxIe4mPcIFL/BC2U9nmZeRgBAYyDR7bjEtPg8l/R36
         R8rQ==
X-Gm-Message-State: AOAM530Ucjb5C/b2CYrzM6/t8CeA4aiaM4R4gmlTXFGobF0KUZ2G2cy8
        KRkrrMoGbuzuat8GaEZI5ragqdvjyljnPW/MpjhC/jjZu6R4IrB8JdwywmBssBEn8bd4MwYQ2ND
        MXuhfXlmVQnb+kF7THgx8
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr13758030wmq.61.1626084240053;
        Mon, 12 Jul 2021 03:04:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKEF6ted5NcVN/5/r4AT7QL5ZIwe94KuOdH10hCJY0gom2i8OUE8aoV5ElG977KnUEiYiouw==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr13757997wmq.61.1626084239863;
        Mon, 12 Jul 2021 03:03:59 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id m7sm17849348wms.0.2021.07.12.03.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 03:03:58 -0700 (PDT)
Subject: Re: [PATCH v1] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210712083917.16361-1-david@redhat.com>
 <CAM9Jb+g7a5kY4DHzDzJTfs-mVEm_CFRcCeY2zdjo6sZWxkjnLA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <406695f0-13c8-a052-92d4-44e884eb44af@redhat.com>
Date:   Mon, 12 Jul 2021 12:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+g7a5kY4DHzDzJTfs-mVEm_CFRcCeY2zdjo6sZWxkjnLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12.07.21 11:58, Pankaj Gupta wrote:
>> MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
>> upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
>> MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.
>>
>> Let's document the behavior and error conditions of these new madvise()
>> options.
>>
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
>>   man2/madvise.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>
>> diff --git a/man2/madvise.2 b/man2/madvise.2
>> index f1f384c0c..3ec8c53a7 100644
>> --- a/man2/madvise.2
>> +++ b/man2/madvise.2
>> @@ -469,6 +469,59 @@ If a page is file-backed and dirty, it will be written back to the backing
>>   storage.
>>   The advice might be ignored for some pages in the range when it is not
>>   applicable.
>> +.TP
>> +.BR MADV_POPULATE_READ " (since Linux 5.14)
>> +Populate (prefault) page tables readable for the whole range without actually
>> +reading. Depending on the underlying mapping, map the shared zeropage,
>> +preallocate memory or read the underlying file; files with holes might or
>> +might not preallocate blocks.
>> +Do not generate
>> +.B SIGBUS
>> +when populating fails, return an error instead.
>> +.IP
>> +If
>> +.B MADV_POPULATE_READ
>> +succeeds, all page tables have been populated (prefaulted) readable once.
>> +If
>> +.B MADV_POPULATE_READ
>> +fails, some page tables might have been populated.
>> +.IP
>> +.B MADV_POPULATE_READ
>> +cannot be applied to mappings without read permissions
>> +and special mappings marked with the kernel-internal
>> +.B VM_PFNMAP
>> +and
>> +.BR VM_IO .
>> +.IP
>> +Note that with
>> +.BR MADV_POPULATE_READ ,
>> +the process can be killed at any moment when the system runs out of memory.
>> +.TP
>> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)
>> +Populate (prefault) page tables writable for the whole range without actually
>> +writing. Depending on the underlying mapping, preallocate memory or read the
> 
> Is this read or write?
> just reading and trying to understand :)

It's reading. Assume you have a file with existing content mapped into a 
process. Once you touch a page (read/write/execute) that maps to blocks 
with existing content, you'll have to load these blocks from disk first.

Thanks! :)

-- 
Thanks,

David / dhildenb

