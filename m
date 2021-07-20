Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFB3CF54B
	for <lists+linux-api@lfdr.de>; Tue, 20 Jul 2021 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGTGr6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Jul 2021 02:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhGTGr5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Jul 2021 02:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626766115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRtDACrxYPJ8ZPr9xqT886xL4OQGjMMieEXBqQ/h2Xw=;
        b=Pp4PAGvzKKFIdyXSIQfBEWZ/U5PFuXHuf1EcNt5SvyPKWnz13cvAgTog1OK2kdvaqeB1F0
        2Wi2KB/YNPLdI+5T/ZiCpiXwgofoDNE+1lPqjNNOyEkd8IdfXpIdY78K7qHX5UjIVicTBk
        9AcoJY1wj/s5E88eF0k9UsTb8v7n7sQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-iJNHJV2GN0ay2NAw8hOHPQ-1; Tue, 20 Jul 2021 03:28:34 -0400
X-MC-Unique: iJNHJV2GN0ay2NAw8hOHPQ-1
Received: by mail-wm1-f70.google.com with SMTP id l6-20020a05600c1d06b0290225338d8f53so884997wms.8
        for <linux-api@vger.kernel.org>; Tue, 20 Jul 2021 00:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kRtDACrxYPJ8ZPr9xqT886xL4OQGjMMieEXBqQ/h2Xw=;
        b=OpZv4TDCcQxA6+4qURiRFu9Tj2Akd7Er7PRXNWSpgo5EyH0Ls2+ugZ1CJBWvpnf89V
         X3eJEvNPQZm/U+fRN/R5emxcJnU+YLYUnsrKEY8CxqfoYXCEg6dCqbsWfj/odNt0ONOE
         INzZAK+CcH3Gv2B+PQt4ehRL+R5atJXDItb/q7tXv9azm6xFgrh8LPIlMzC/rJlnvmgp
         /vK82PPD6kRKL8Xl22jO5ER/NzLHqlLQA9ngcA+NxVP1sGVPHXTvOs11dvWiHP+fCqYL
         WQQOg7QuXEj+V/MNHwzYxWb7PYCz6VAEllZ2+d0NjvIRZCGxWpNJNv34Xp4uBnZFilG+
         b5ug==
X-Gm-Message-State: AOAM531ARldF+bP1LvPYrYdY7hASOoaaDWNY70qyT5G8YaPLyuZIVDT+
        seiLybj0fly6NsIojtESPh1q6bOiwPCqX9hbm6jVwINhL1cXfSXaaXY0qeqbb3d+Mb6qAb9YMKI
        lecCMc9Q2OQ0YTZGH3Jaw
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr36758957wme.16.1626766113268;
        Tue, 20 Jul 2021 00:28:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzMxJ6tkE66HwBF8toIqiHp2xtf7yK65y8S1dwets2ANEWlErBZCm5ceoCHkuw+2exOcaa8w==
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr36758942wme.16.1626766113065;
        Tue, 20 Jul 2021 00:28:33 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id o29sm17750919wms.13.2021.07.20.00.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 00:28:32 -0700 (PDT)
To:     Peter Collingbourne <pcc@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20210619092002.1791322-1-pcc@google.com>
 <30e92457-d540-159c-4c4e-0b8f0d2a1838@redhat.com>
 <CAMn1gO529Ua1LJBM=vdwT8Cz+CXSvJcuGhuqotSuiUyjTBDfAQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4] mm: introduce reference pages
Message-ID: <0345cd7b-0196-1c67-6b6c-a5638a66171b@redhat.com>
Date:   Tue, 20 Jul 2021 09:28:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMn1gO529Ua1LJBM=vdwT8Cz+CXSvJcuGhuqotSuiUyjTBDfAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


>>> --- a/include/linux/gfp.h
>>> +++ b/include/linux/gfp.h
>>> @@ -55,8 +55,9 @@ struct vm_area_struct;
>>>    #define ___GFP_ACCOUNT              0x400000u
>>>    #define ___GFP_ZEROTAGS             0x800000u
>>>    #define ___GFP_SKIP_KASAN_POISON    0x1000000u
>>> +#define ___GFP_NOZERO                0x2000000u
>>
>> Oh god, please no. We've discussed this a couple of times already:
>> whatever leaves the page allcoator shall be zeroed. No exceptions, not
>> even for other allocators (like hugetlb).
>>
>> Introducing something like that to the whole system, including random
>> drivers, destroys the whole purpose of the security feature. Please
>> don't burry something so controversial in your patch.
> 
> Got it -- I was unaware that this was controversial.
> 
> Avoiding the double initialization does help a bit in benchmarks, at
> least for the fully faulted case. The alternative approach that I was
> thinking of was to somehow plumb the required pattern into the page
> allocator (which would maintain the invariant that the pages are
> initialized, but not necessarily with zeroes), but this would require
> touching several layers of the allocator.  I suppose that this doesn't
> need to be done immediately though -- we can deal with the double
> initialization for now and avoid it somehow in a followup.

As it's a clear optimization, it should definitely be separated from 
this "introduction" patch.

I agree that the logic for optimizing initialization of a page in this 
case should best reside in page_alloc.c, for example providing a helper 
for optimizing the initialization in there. We already pass alloc_flags 
internally, maybe we can then reuse that to minimize changes.

-- 
Thanks,

David / dhildenb

