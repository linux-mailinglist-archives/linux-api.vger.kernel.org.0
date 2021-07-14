Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFAF3C7F99
	for <lists+linux-api@lfdr.de>; Wed, 14 Jul 2021 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhGNHyK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jul 2021 03:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238287AbhGNHyJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Jul 2021 03:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626249077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIAamLRB+l2EUOb7y0yMXzaGCmbBtLAf0vymHfStw1I=;
        b=TUYQtGzSvHAI0LrH/8bhwoAKLF7W7Eksfu6rmS+0QGkkT/iMOpzHvozC/QyGVuPdmhQ3OB
        jS4fbtL9CMZ6O4B37q1oJ/gzimaMwSWssFwwHOHKhnt1qsvGGB7SSK9NqKPrQKXsjga15S
        0yXpWGPUc3qJYG/rP23nf//i9PG9q1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-0rPu2-pkP0izpZAW2BEl1A-1; Wed, 14 Jul 2021 03:51:16 -0400
X-MC-Unique: 0rPu2-pkP0izpZAW2BEl1A-1
Received: by mail-wm1-f70.google.com with SMTP id p6-20020a05600c3586b029020b46124c2eso1661881wmq.1
        for <linux-api@vger.kernel.org>; Wed, 14 Jul 2021 00:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uIAamLRB+l2EUOb7y0yMXzaGCmbBtLAf0vymHfStw1I=;
        b=bJc/G35oDh/t7Lw6SYtod/Wi//V3bJ1IeoLPFDLY7tdmUA9TlD+qJHB8byAn5vzqIy
         k6d+MSp45dEDdLmZ09xIGRI4NOZORwk7CR0dZA/1VrDY9C8w9FsltXtulFVu//iwSjyL
         BLCJa5rn7xBOAnlsQgYGO2dCH2dh+rFHwfEdwXRxi4FsJidxAKF+Bv/jYH60Xv2O3eaf
         hBB0rT0virB9B9qjXwVEv+tJ9Yzi4iaJ2C9DiluEbnmnoyqzltSwss99fL+MQm4yetcD
         D/COBgI5tE8lvQRcgZQSNM0hrabjmgnFbfyYn71uCH55S/BYOdn2uSVy+nOsdmucZPTE
         vNUg==
X-Gm-Message-State: AOAM531LTIjzzVF5xzHR2DbYxYrUu3alKrbY/A+t5Tw7txX2/8H0I2M8
        MNEZu+lzpQ8V+rw5TmOqjqs3oMGCNzkla3RJaG9jHxQG762PHClH0IaOyxcMf/6MkFrYuZY1swE
        cwW1b1FO4QlxUiiC8l2KgCMLSCIA/FVST1uMT40DYCMzvb9NeThAYrMo+MgaMhwfesujz
X-Received: by 2002:adf:fbce:: with SMTP id d14mr11323582wrs.236.1626249075597;
        Wed, 14 Jul 2021 00:51:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGhZcK0OQbvhqYsVxTMC9Y+/0J9nJNJEEX3Vn4NXbRA/BUl43hnjxQYA6Zs6sMdkR9NApeEA==
X-Received: by 2002:adf:fbce:: with SMTP id d14mr11323536wrs.236.1626249075294;
        Wed, 14 Jul 2021 00:51:15 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60d5.dip0.t-ipconnect.de. [91.12.96.213])
        by smtp.gmail.com with ESMTPSA id f7sm4365345wml.35.2021.07.14.00.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 00:51:14 -0700 (PDT)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
 <YO55ZIrgkLXI4BbS@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
Message-ID: <b84dfb7b-9ae7-8cd7-ce65-0b1952e30e8e@redhat.com>
Date:   Wed, 14 Jul 2021 09:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO55ZIrgkLXI4BbS@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 14.07.21 07:43, Michal Hocko wrote:
> On Mon 12-07-21 09:41:26, David Hildenbrand wrote:
>> On 12.07.21 09:03, Michal Hocko wrote:
>>> [Cc linux-api]
>>>
>>> On Fri 09-07-21 10:50:48, Evan Green wrote:
>>>> Currently it's not possible to enable hibernation without also enabling
>>>> generic swap for a given swap area. These two use cases are not the
>>>> same. For example there may be users who want to enable hibernation,
>>>> but whose drives don't have the write endurance for generic swap
>>>> activities.
>>>>
>>>> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
>>>> generic swapping to it. This region can still be wired up for use in
>>>> suspend-to-disk activities, but will never have regular pages swapped to
>>>> it.
>>>
>>> Could you expand some more on why a strict exclusion is really
>>> necessary? I do understand that one might not want to have swap storage
>>> available all the time but considering that swapon is really a light
>>> operation so something like the following should be a reasonable
>>> workaround, no?
>>> 	swapon storage/file
>>> 	s2disk
>>> 	swapoff storage
>>
>> I'm certainly not a hibernation expert, but I'd guess this can also be
>> triggered by HW events, so from the kernel and not only from user space
>> where your workaround would apply.
> 
> Is there anything preventing such a HW event doing the equivalent of the
> above?
> 

Let's take a look at hibernate() callers:

drivers/mfd/tps65010.c: calls hibernate() from IRQ contex, based on HW
                         event
kernel/power/autosleep.c: calls hibernate() when it thinks it might be
  			  a good time to go to sleep
kernel/power/main.c: calls hibernate() triggered by userspace
kernel/reboot.c: calls hibernate() triggered by userspace

So on two paths, hibernate() is not under user space control and the 
sequence you propose does not apply. The kernel itself has no idea which 
swap space to activate before hibernating, that's a user space decision. 
And without this patch, user space cannot communicate that decision to 
the kernel without eventually also swapping.

However, I assume in most cases (e.g., ACPI events, power button 
pressed, ...) we always notify user space, which in return decides which 
action to take. Doing it under kernel control is more of a corner case I 
guess, so I do wonder if we really care about these setups.

Anyhow, the proposal here does not sound completely crazy to me, 
although it's unfortunate how we decided to mangle hibernation and 
swapping into the same mechanism originally; a different interface to 
active "hibernation only backends" would be cleaner than doing a "swapon 
..." without swapping. However, that will require much more work and I 
am not sure if it's worth it ...

-- 
Thanks,

David / dhildenb

