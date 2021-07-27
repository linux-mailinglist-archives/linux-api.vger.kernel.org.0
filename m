Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE23D74E9
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhG0MTK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Jul 2021 08:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236347AbhG0MTI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Jul 2021 08:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627388347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cyg4OzSfCVK2ArH8hMcR0QU6etJZdNnz5j7NaiTQwfM=;
        b=A1gqzgtgdu7+x37KOe4R+lmlTDVNXFYvhghjcMmRNIEKMbaGOVJUpwF4HvPh4/Ucc4ZJt1
        qpTZXzPKYfMM5Pexkcvdp1jjTr6bc2vnDX4nSFwFGQvlCCnN4RhcaNyxCOb09zGOkhL+D/
        /oPxxBwBpd0fgV0bFv924zRv/SGogXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-QhOI6nDHPjWvhWZjnArq8g-1; Tue, 27 Jul 2021 08:19:05 -0400
X-MC-Unique: QhOI6nDHPjWvhWZjnArq8g-1
Received: by mail-wm1-f70.google.com with SMTP id a25-20020a05600c2259b02902540009f03cso194496wmm.4
        for <linux-api@vger.kernel.org>; Tue, 27 Jul 2021 05:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cyg4OzSfCVK2ArH8hMcR0QU6etJZdNnz5j7NaiTQwfM=;
        b=njZpD9BfiXExbAXMf8Zl9VgeC42kuth9CI8o7NtTrarXxlCCPXwqeGwvGk7oMUuJ3w
         I7zICeVENvRaWzEk3SlTWvcqNmEeineqVCH08r2GmFysj3I/s9MT4NF+1NGTgOU5v/Yo
         w8BstS53pdp10KleKf1XCl+plxCUlngYMxPnyynpRIkR6P52zgZZltVk4bhBUvwH2SsJ
         +KlH3OgrT/LtKAp0U0snh4KD3iV++nuLgQ5w3vlw1fWvIT2reaOz3yZ8lZGCOkPNxfCS
         TWgDKtMA9p9IsYhZVYc9Z2FAQ59YR7LvP1blTLwMZURU6Zef2Tq0/Kh7tuKhLmQc9m7H
         ApVA==
X-Gm-Message-State: AOAM530CHVcII8V3RHYmbcS863w+o8ut4RU1U6qc/Gu+DAVws7B00ke0
        YvZ+nYeIAsNlDHDon67S+A42cJ2QgpWjN+1TtuB4vqduGyyqb0uxo9lv3NU61g6VVUQZT10uwx1
        d5WXqBG9Bkg5yUNRx41JRe8MqfqILp07whQE5LXZLvEsyNp7xCpGlyd8sNSRhPAdMPudW
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr24255766wrs.394.1627388344546;
        Tue, 27 Jul 2021 05:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoTD6xViLCv6Sh6eedwOX3/SDyry/1WTpnxYqWWSunam9tACK6ql5CgDJUDnxSNGHSYP0KSA==
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr24255732wrs.394.1627388344358;
        Tue, 27 Jul 2021 05:19:04 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c36.dip0.t-ipconnect.de. [79.242.60.54])
        by smtp.gmail.com with ESMTPSA id y66sm2904831wmy.39.2021.07.27.05.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 05:19:03 -0700 (PDT)
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michal Hocko <mhocko@suse.com>, Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
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
 <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
 <YO55ZIrgkLXI4BbS@dhcp22.suse.cz>
 <b84dfb7b-9ae7-8cd7-ce65-0b1952e30e8e@redhat.com>
 <20210727120413.GB32265@duo.ucw.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d6f7b7a4-c27f-5ccb-c605-c16f6a7ea2e6@redhat.com>
Date:   Tue, 27 Jul 2021 14:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727120413.GB32265@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 27.07.21 14:04, Pavel Machek wrote:
> Hi!
> 
>> Let's take a look at hibernate() callers:
>>
>> drivers/mfd/tps65010.c: calls hibernate() from IRQ contex, based on HW
>>                          event
> 
> No it does not. Look again.
> 

Oh, dead code :)

>> kernel/power/autosleep.c: calls hibernate() when it thinks it might be
>>   			  a good time to go to sleep
> 
> Ok, you are right, it is there. But I don't believe anyone uses this
> configuration.

If it's dead code, we might want to look into deprecating and removing 
it. It was introduced around 2012:

https://lwn.net/Articles/479841/


-- 
Thanks,

David / dhildenb

