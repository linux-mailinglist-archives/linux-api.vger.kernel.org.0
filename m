Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C52D3D4FD4
	for <lists+linux-api@lfdr.de>; Sun, 25 Jul 2021 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhGYTe6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 25 Jul 2021 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhGYTe5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 25 Jul 2021 15:34:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E1C061757;
        Sun, 25 Jul 2021 13:15:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b7so8514858wri.8;
        Sun, 25 Jul 2021 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/BNEul6Wi0Aotg0RFtiwPfulYe7lefwQCeOZkh4PSE0=;
        b=oRqvXYzJzh+GnEhWJ/MCkXi/KZ7eWYKjRkWcopXGRWzIbsK3OK0MFL9nsjssG/hggh
         GfHlp092bfSTmWKJpVccZKxPxcyeCL1wNpdImG0BRtnKtMeAs9VI7GEPgHDcQv5Bz8ty
         O0toxyblzbMlJ7SgInWLCRp3BkTf39lBXcXqgH3g+Lrpb32g/RaKTCjSjrZdQQtLEK6I
         SFqHRjWcAs9WftgYy5lMntD8GMUuZu4exPzvLMkVqMwoFTN4RfUppqChr9JAEcm39GPD
         W40fIWuF6HtsfqGpZn/HUZZurEU4Ee39Aq+pm+n37tYyr8C/HenpAaoZn18HljGheMMz
         kGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/BNEul6Wi0Aotg0RFtiwPfulYe7lefwQCeOZkh4PSE0=;
        b=fB9YknOR3IyaCaaDtboWcIJ3yn8zsNEJ0ljC7AO66uMw5yrem9q3d4eNgC3fwFGCrT
         MrZpcDtAoKzqaCPCPJJfDOMQ91ObPlIePvf7xSGMtNnzUe0NlxbhiInFr1Abs9UNluTV
         GcdeEExtZ5v+n83e8KLrbJYChCkezhYpKMbligzIuSZMQ9wQGqyv2CXe0gQDuyDv5Xog
         a1r9qDsQS0dEy6i7nQiaXgUGBsyjcLI5XnHbcit73zwzZW+cRzuCzcu+nzES1zNWHgGa
         +V5LsrFiV6E80zAh9+HVry+LikQCaeb7fp41wMPy0lTn1D60Mq2ZFMQiyHG8JQbdV7tN
         Nmdg==
X-Gm-Message-State: AOAM533h4b1xS1/1TRSfP6L4Rxt6Ly9JxNebuFUdC5kcAtBaemcbSopD
        1Sz6Xb0Lp11s7mTFGQ8SHsw=
X-Google-Smtp-Source: ABdhPJzKDfR4Fh52ptEExnWIEX7Z68KI4VTyXTJP5lNDswtbqdkCo9FHNIHJK9WTv/Kicz/E1Q6yzw==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr16067165wrq.170.1627244124840;
        Sun, 25 Jul 2021 13:15:24 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id a8sm39912002wrt.61.2021.07.25.13.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 13:15:24 -0700 (PDT)
Subject: Re: [PATCH v1] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210712083917.16361-1-david@redhat.com>
 <CAM9Jb+g7a5kY4DHzDzJTfs-mVEm_CFRcCeY2zdjo6sZWxkjnLA@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <51ec094e-e402-d8a4-d65f-24b8d7929707@gmail.com>
Date:   Sun, 25 Jul 2021 22:15:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+g7a5kY4DHzDzJTfs-mVEm_CFRcCeY2zdjo6sZWxkjnLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi David, Pankaj,

On 7/12/21 11:58 AM, Pankaj Gupta wrote:
>> MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
>> upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
>> MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.
>>
>> Let's document the behavior and error conditions of these new madvise()
>> options.

Please see a couple of comments below.

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
 > Acked-by: Pankaj Gupta <pankaj.gupta@ionos.com>

Thanks for the acked by!

Cheers,

Alex

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

s/$/"/

>> +Populate (prefault) page tables readable for the whole range without actually

See the following extract from man-pages(7):

$ man 7 man-pages | sed -n '/Use semantic newlines/,/^$/p';
    Use semantic newlines
        In the source of a manual page,  new  sentences  should  be
        started  on new lines, and long sentences should split into
        lines at clause breaks (commas, semicolons, colons, and  so
        on).   This  convention,  sometimes known as "semantic new‐
        lines", makes it easier to see the effect of patches, which
        often  operate at the level of individual sentences or sen‐
        tence clauses.

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

s/$/"/

>> +Populate (prefault) page tables writable for the whole range without actually
>> +writing. Depending on the underlying mapping, preallocate memory or read the
> 
> Is this read or write?
> just reading and trying to understand :)
> 
>> +underlying file; files with holes will preallocate blocks.
>> +Do not generate
>> +.B SIGBUS
>> +when populating fails, return an error instead.
>> +.IP
>> +If
>> +.B MADV_POPULATE_WRITE
>> +succeeds, all page tables have been populated (prefaulted) writable once.
>> +If
>> +.B MADV_POPULATE_WRITE
>> +fails, some page tables might have been populated.
>> +.IP
>> +.B MADV_POPULATE_WRITE
>> +cannot be applied to mappings without write permissions
>> +and special mappings marked with the kernel-internal
>> +.B VM_PFNMAP
>> +and
>> +.BR VM_IO .
>> +.IP
>> +Note that
>> +.BR MADV_POPULATE_WRITE ,
>> +the process can be killed at any moment when the system runs out of memory.
>>   .SH RETURN VALUE
>>   On success,
>>   .BR madvise ()
>> @@ -533,6 +586,17 @@ or
>>   .BR VM_PFNMAP
>>   ranges.
>>   .TP
>> +.B EINVAL
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +but the specified address range includes ranges with insufficient permissions,
>> +.B VM_IO
>> +or
>> +.BR VM_PFNMAP.
>> +.TP
>>   .B EIO
>>   (for
>>   .BR MADV_WILLNEED )
>> @@ -548,6 +612,14 @@ Not enough memory: paging in failed.
>>   Addresses in the specified range are not currently
>>   mapped, or are outside the address space of the process.
>>   .TP
>> +.B ENOMEM
>> +.I advice
>> +is
>> +.B MADV_POPULATE_READ
>> +or
>> +.BR MADV_POPULATE_WRITE ,
>> +but populating (prefaulting) page tables failed.
>> +.TP
>>   .B EPERM
>>   .I advice
>>   is
>> @@ -555,6 +627,14 @@ is
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
>> +and a HW poisoned page is encountered.
>>   .SH VERSIONS
>>   Since Linux 3.18,
>>   .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb
>> --
>> 2.31.1
>>
>>


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
