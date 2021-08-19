Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469C23F2003
	for <lists+linux-api@lfdr.de>; Thu, 19 Aug 2021 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhHSSi5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Aug 2021 14:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhHSSi4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Aug 2021 14:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629398299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtbOiorio7fFl+PE8qnsYo+g02ez/oL57Nqm27L5x2A=;
        b=KJvgcogQcGQIIGAP/N2XC8irbnW9oF951x+QoNkxM1tEpOQ6ugBQaH2rVXnS3GVnCOBlf8
        MAlOLDdXayCfx5In1HBgkNQjXHsrwVCfeBLn36O8nGhxy59YFtf+GmyVS6pTgUBbkAU3kM
        4c8Dj9s5QOpmcmbw6xwcMrqhJ6PM+t8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-rzWqBMHzPoe_p9D-uykTPw-1; Thu, 19 Aug 2021 14:38:15 -0400
X-MC-Unique: rzWqBMHzPoe_p9D-uykTPw-1
Received: by mail-wr1-f72.google.com with SMTP id k15-20020a5d628f0000b029015501bab520so1992952wru.16
        for <linux-api@vger.kernel.org>; Thu, 19 Aug 2021 11:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mtbOiorio7fFl+PE8qnsYo+g02ez/oL57Nqm27L5x2A=;
        b=LlqJOaW93YSh8So7EtfTYIpnqjzILDSrTG4+jZ6i57EMDVH8sN1anx07qRIrOA8jc9
         q3ZlF+az0NPZoP+IUhLJ8rOZdFkKgMPxXVQfuGshwVDORqLQx2+Qa/qWzuLJXNz+E214
         SIOzJSUAWFwk1duCSuwqEbel6BwXDnqLNVY2UwpRTjnGikwwGvg+c/FZ+Hkf8k0cParV
         4mLhkeEr5oDLFmv9jF9n5ulgeKGbLA2k1kIs2iLKZc1apxadu8XTtqv/mYSNadiP5ovY
         io32Vk21KCooGMp7XseJ4J9o1F5MouIEAR3sJGFbf7j73Y9IBAMk4PMtQ9z6KheYj43J
         ZhLA==
X-Gm-Message-State: AOAM531VwiL+OZZOpNjzEmyfg2s7f7CdetgFsrFpDQMTFseXFg+98HOw
        7zBy9NAKJmgISWzHgVBK9/CFSoVt3hXQ47SQ0xAjRC333nQg3qZA+6C8YUhUPCceqBfX76aBJLW
        4UjMncOlKHKaYSCIdjMng
X-Received: by 2002:a1c:26c5:: with SMTP id m188mr91599wmm.19.1629398293787;
        Thu, 19 Aug 2021 11:38:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhiL4DY3GndFGf/b2//2e4NpH2tZ8005hNZ4k5duF98UqYuOwTat2FIGJxcrV60izFAN4w5w==
X-Received: by 2002:a1c:26c5:: with SMTP id m188mr91579wmm.19.1629398293536;
        Thu, 19 Aug 2021 11:38:13 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id c8sm3593777wrx.53.2021.08.19.11.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 11:38:13 -0700 (PDT)
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
 <70792f9c-ace1-6876-378b-5388f7948a60@redhat.com>
 <abec69cb-6db9-79ab-869e-907da573bfbc@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
Message-ID: <ae29a12b-bd15-a927-3c31-5b720b542799@redhat.com>
Date:   Thu, 19 Aug 2021 20:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <abec69cb-6db9-79ab-869e-907da573bfbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

>>> I don't understand "without actually reading memory"? Do you mean,
>>> "without actually  faulting in the pages"; or something else?
>>
>> "Populate (prefault) page tables readable, faulting in all pages in the
>> range just as if manually reading one byte of each page; however, avoid
>> the actual memory access that would have been performed after handling
>> the fault."
>>
>> Does that make it clearer? (avoiding eventually touching the page at all
>> can be beneficial, especially when dealing with DAX memory where memory
>> access might be expensive)
> 
> That text is much better. But, what's still not clear to me then is the
> dfference between mmap(2) MAP_POPULATE, and MADV_POPULATE_READ and
> MADV_POPULATE_WRITE. What is the differnece, and in what situations
> would one prefer one or the other approach? I think it would be helpful
> if the manual page said something about these details.

Well, MAP_POPULATE

1. Can only be used on new mappings, not on existing mappings and 
especially not on parts of (sparse) memory mappings.

2. Hides actual population errors, simply returning "success"

3. Cannot specify the actual faultin behavior (readable vs. writable). 
Private mappings are always faulted in writable, shared mappings writable.

MADV_POPULATE_WRITE is the way to go to preallocate memory, especially 
hugetlbfs. MADV_POPULATE_READ can be used to just populate the shared 
zero page, or to fault-in file-backed memory without marking everything 
dirty such that it won't have to be written back to disk.

for MADV_POPULATE_READ

"In contrast to MAP_POPULATE, MADV_POPULATE_READ does not hide errors, 
can be applied to (parts of) existing mappings and will always populate 
(prefault) page tables readable. One example use case is prefaulting a 
file mapping, reading all file content from disk; however, pages won't 
be dirtied and consequently won't have to be written back to disk when 
evicting the pages from memory."

Suggestions welcome :)

for MADV_POPULATE_WRITE

"In contrast to MAP_POPULATE, MADV_POPULATE_WRITE does not hide errors, 
can be applied to (parts of) existing mappings and will always populate 
(prefault) page tables writable. One example use case is preallocating 
memory, breaking any CoW (Copy on Write)."

Again, suggestions welcome :)

[...]

>> Much better. Note that there might be more types of mappings that won't
>> work (e.g., initially also secretmem IIRC).
> 
> Ahh nice. Since there's about to be a memfd_secret() manual page,
> I suggest adding also "or secret memory regions created using
> memfd_secret(2)".

Can do, thanks!

[...]

>>
>> Sure, we can add that. But note that MADV_HWPOISON is just one of many
>> ways to HWpoison a page.
> 
> Then maybe something like:
> 
> "(HW poisoned pages can, for example, be created using the
> MADV_HWPOISON flag described elsewhere in this page.)"

Makes sense, I'll reuse the same description at the other place in this 
file where I mention HW poisoned pages.


-- 
Thanks,

David / dhildenb

