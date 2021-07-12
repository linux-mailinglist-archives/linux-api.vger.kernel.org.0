Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C373C5278
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbhGLHqj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 03:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349593AbhGLHoV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 03:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626075692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UxiIsS2bDCDwcOogs+eEqta/QcjF32ApVFvqJdxX48=;
        b=FFzJDn+carNeMFaGR3S2/TPNazbk3GVW6dg+AHeUQKfvslhkppMligFnUlEp6L+TqzDGVX
        C0dqcnt7VyTnQdV5fBMRHXwnu+KsxWv3p2btI5FHWsdFZuorjZePWV5Rf7eqy0fM7AkGQ3
        QuOfRI6e+pss1S8m1XjkUwbLD0iQqYo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-8vgpE4N4PV2gTPAdLVWAvQ-1; Mon, 12 Jul 2021 03:41:30 -0400
X-MC-Unique: 8vgpE4N4PV2gTPAdLVWAvQ-1
Received: by mail-wr1-f69.google.com with SMTP id k3-20020a5d52430000b0290138092aea94so6785611wrc.20
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 00:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9UxiIsS2bDCDwcOogs+eEqta/QcjF32ApVFvqJdxX48=;
        b=YhbY+5FmNf4u2YhivbFcv/6858pjx8FCQ/yODQw2f1sq1TwwSdOBy0p3IlMSan/CuE
         L+EKyxXWSEbRZ38udnLdmmhaLR0V+YxpSjaoIUT21Ceo7f5s9NHWGIvvn3Xh4S1iQz0C
         jqyNI2X0vKvHbDm7Y3KxHCfq3pqtMT5OK823X4gIjbOoCHXEUXEnTdpmBiAwh1XmpwSZ
         iDjAKKGalu/UhQql72+Kb+8fxMyD9GVZwW26okJiWVk8rpT6/J0DXGCCOxyPAP3RCrnz
         tE+HUDfz9ZnCMu0agqoev+RHHsWh2s8e5pXa1OJlRSn6eXc2GFWonHVxTx3IA3bW5FZq
         8LVg==
X-Gm-Message-State: AOAM532DiAgAHBIJ8JrIil9ItBlAouhjvf0t9DA1l+ehcU2eus32UTr/
        oZ86BoXA66LmkakWrd4MhoVK0VH0ZA1D7gZG97Nk9/9tcxRl8xkJH07aB+jIb9W5XEANO2/9ISo
        toQ53noAYZSqtDCKMIMTs7yi/p257F/g5CnIBMl+hFhDBZDrIA7Yr+ZM+X06yHJNhBc5f
X-Received: by 2002:adf:f085:: with SMTP id n5mr38427762wro.148.1626075689052;
        Mon, 12 Jul 2021 00:41:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuph2xUEhOYsAOR+5Ndv4BRqy6A3z+3Uiy1VN8XUXUPlWOD/N6tuZKznFC2+4OHoqeGdmqWw==
X-Received: by 2002:adf:f085:: with SMTP id n5mr38427734wro.148.1626075688834;
        Mon, 12 Jul 2021 00:41:28 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id b6sm2679799wmj.34.2021.07.12.00.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 00:41:27 -0700 (PDT)
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
To:     Michal Hocko <mhocko@suse.com>, Evan Green <evgreen@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
Date:   Mon, 12 Jul 2021 09:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12.07.21 09:03, Michal Hocko wrote:
> [Cc linux-api]
> 
> On Fri 09-07-21 10:50:48, Evan Green wrote:
>> Currently it's not possible to enable hibernation without also enabling
>> generic swap for a given swap area. These two use cases are not the
>> same. For example there may be users who want to enable hibernation,
>> but whose drives don't have the write endurance for generic swap
>> activities.
>>
>> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
>> generic swapping to it. This region can still be wired up for use in
>> suspend-to-disk activities, but will never have regular pages swapped to
>> it.
> 
> Could you expand some more on why a strict exclusion is really
> necessary? I do understand that one might not want to have swap storage
> available all the time but considering that swapon is really a light
> operation so something like the following should be a reasonable
> workaround, no?
> 	swapon storage/file
> 	s2disk
> 	swapoff storage

I'm certainly not a hibernation expert, but I'd guess this can also be 
triggered by HW events, so from the kernel and not only from user space 
where your workaround would apply.

-- 
Thanks,

David / dhildenb

