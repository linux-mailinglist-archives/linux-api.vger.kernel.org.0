Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D0539CE9C
	for <lists+linux-api@lfdr.de>; Sun,  6 Jun 2021 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFFKrl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Jun 2021 06:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFKrk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Jun 2021 06:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622976350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HilGFSprc7YIEedvPuaQGfj7Ylt2W0rsufgmNzneQE=;
        b=MiQWWFKJruWhVr5kzI30l7PiiwmOkkPhmCs0yL/lAkYLx1AN9p+nRIPaDuz+1jqb/YUnrp
        /Wzw76mT/OHG4CJirk6fXUBLEmSs9qkOIKA29ST882n1cD971ned688dNEnEmRCRw09gJi
        HzrTi3VNzaek0ORGR1t2QW1DgCGkf18=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-3GwoKBLyPdWHsURLBtnnJw-1; Sun, 06 Jun 2021 06:45:49 -0400
X-MC-Unique: 3GwoKBLyPdWHsURLBtnnJw-1
Received: by mail-wr1-f72.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so6650470wrc.16
        for <linux-api@vger.kernel.org>; Sun, 06 Jun 2021 03:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/HilGFSprc7YIEedvPuaQGfj7Ylt2W0rsufgmNzneQE=;
        b=EVoOVpMdQEiGDfTumQdMoPRRPfZZ3NMfsOVCsXYOggWpK05Fw7DitZQYvRdVtpE3OK
         wuQtBfZH0OQhaiVkYNnp+dfrOisBRunvJupTzcu4ZlEYMd7dEZdkOltuooBmad1FCOwb
         /mDlQqPuo0SOK0likunlrMLvnAqJpVKRqSqOLO8smgQCtaua9e3eMsGcf1hvHH0M1POo
         vVjGudMiWYA6+qLdISGIVGa9PGLORzP53gZB6vliRQuRzjWxxXcc+AF3ujlFrOG90Jo9
         6RsOCgqAmm4U9/GU9eZklXNZzQq7tBe4ZClgRl6tcVb1g7WZpxbJrP/9vA9BjEOq2Nwa
         xnhw==
X-Gm-Message-State: AOAM533O33gIOhcX7czUs9RjSrMOhpBSYXBNavXRKsV+RAvyBTFACQUU
        L+qR8jhmQZ5UDWvI95M5a+GCwPKanbwYUrnQP98vtoe+E2Dns9mvS860R/wHU1+DJ5NyKHP07vb
        cN8siz0hlfBkiH8iDxktK3MwZifT6l6Zj0SqHXkCi0U7cTgh6OUk2cY7lMnIZ0xrutKl0
X-Received: by 2002:a1c:7508:: with SMTP id o8mr11795345wmc.70.1622976347837;
        Sun, 06 Jun 2021 03:45:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT0ZOIVt4u7phjM8iGhd6Z6zCDQDV96nEVWCXs8D6/rSL4dr76fRMRcXDoMNIbSkIRNIyMTQ==
X-Received: by 2002:a1c:7508:: with SMTP id o8mr11795321wmc.70.1622976347617;
        Sun, 06 Jun 2021 03:45:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65e5.dip0.t-ipconnect.de. [91.12.101.229])
        by smtp.gmail.com with ESMTPSA id g205sm7110144wme.6.2021.06.06.03.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 03:45:47 -0700 (PDT)
Subject: Re: [RFC PATCH V2] zram:calculate available memory when zram is used
To:     Greg KH <gregkh@linuxfoundation.org>, yongw.pur@gmail.com
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, linux-api@vger.kernel.org
References: <1622910240-4621-1-git-send-email-yongw.pur@gmail.com>
 <YLuvQwkZkl9UCoJw@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <aa43a75c-4699-0540-f918-5b2788b49162@redhat.com>
Date:   Sun, 6 Jun 2021 12:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YLuvQwkZkl9UCoJw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 05.06.21 19:07, Greg KH wrote:
> On Sat, Jun 05, 2021 at 09:24:00AM -0700, yongw.pur@gmail.com wrote:
>> From: wangyong <yongw.pur@gmail.com>
>>
>> When zram is used, available+Swap free memory is obviously
>> bigger than we actually can use, because zram can compress
>> memory by compression algorithm and zram compressed data
>> will occupy memory too.
>>
>> So, we can count the compression ratio of zram in the kernel.
>> The space will be saved by zram and other swap device are
>> calculated as follows:
>> zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
>> We can evaluate the available memory of the whole system as:
>> MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfree]
>>
>> Add an entry to the /proc/meminfo file, returns swap will save space.
>> Which name is more appropriate is still under consideration.
>> There are several alternative names: SwapAvailable, SwapSaved,
>> SwapCompressible
>>
>> Signed-off-by: wangyong <yongw.pur@gmail.com>
>> ---
>>   drivers/block/zram/zcomp.h    |  1 +
>>   drivers/block/zram/zram_drv.c | 19 +++++++++
>>   drivers/block/zram/zram_drv.h |  1 +
>>   fs/proc/meminfo.c             |  1 +
>>   include/linux/swap.h          | 10 +++++
>>   mm/swapfile.c                 | 95 +++++++++++++++++++++++++++++++++++++++++++
>>   mm/vmscan.c                   |  1 +
>>   7 files changed, 128 insertions(+)
> 
> You are adding a new sysfs file with no new Documentation/ABI entry.

Indeed. And in the best case, the change would be accompanied with a man 
page update patch for the "proc" man page.

> Also are you sure you are allowed to add a new proc file entry without
> breaking existing tools?

I think adding new entries is not a problem. Parsers have to deal with 
new entries popping up. For example, we introduced "ShadowCallStack:" in 
2020 via 628d06a48f57 ("scs: Add page accounting for shadow call stack 
allocations").


-- 
Thanks,

David / dhildenb

