Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47650278B3A
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgIYOth (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 10:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgIYOth (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 10:49:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601045375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=d5ct6KOSt/TbxCyW901RYIrLyX9ZminnN3Qq7MjEq2M=;
        b=PFe04kh8+6vmv/3ac9M7mWkdpAGB7XoYRaPoZiwzPawV8cnIgsEePcgksY5za5/Zd5gOEO
        DXhhjTzywGTpsAe3wrPb4dyCBY4P6PSWateaZh8fxDVcr2WeidvqexW0G25TlRv/n9Kwjz
        UkP2WYJ4yLb1/AOrSbpyvwUj0+gjU5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84--1Srb6P1NOWCSP8NzXNJGg-1; Fri, 25 Sep 2020 10:49:33 -0400
X-MC-Unique: -1Srb6P1NOWCSP8NzXNJGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA295802EA3;
        Fri, 25 Sep 2020 14:49:31 +0000 (UTC)
Received: from [10.36.112.211] (ovpn-112-211.ams2.redhat.com [10.36.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 870781002C29;
        Fri, 25 Sep 2020 14:49:29 +0000 (UTC)
Subject: Re: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device
 ?
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <21852ccb-bd06-9281-7c8e-485ec02f2883@redhat.com>
 <20200922155611.379373f7@thinkpad>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <a7d02345-2195-3092-a368-ca3209e2c93e@redhat.com>
Date:   Fri, 25 Sep 2020 16:49:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922155611.379373f7@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

>> There were once RFC patches to make use of it in ACPI, but it could be
>> solved using different interfaces [1].
>>
>>
>> While I'd love to rip it out completely, I think it would break old
>> lsmem/chmem completely - and I assume that's not acceptable. I was
>> wondering what would be considered safe to do now/in the future:
>>
>> 1. Make it always return 0 (just as if "sclp.rzm" would be set to 0 on
>> s390x). This will make old lsmem/chmem behave differently after
>> switching to a new kernel, like if sclp.rzm would not be set by HW -
>> AFAIU, it will assume all memory is in a single memory increment. Do we
>> care?
> 
> No, at least not until that kernel change would be backported to some
> old distribution level where we still use lsmem/chmem from s390-tools.
> Given that this is just some clean-up w/o any functional benefit, and
> hopefully w/o any negative impact, I think we can safely assume that no
> distributor will do that "just for fun".
> 
> Even if there would be good reasons for backports, then I guess we also
> have good reasons for backporting / switching to the util-linux version
> of lsmem / chmem for such distribution levels. Alternatively, adjust the
> s390-tools lsmem / chmem there.
> 
> But I would rather "rip it out completely" than just return 0. You'd
> need some lsmem / chmem changes anyway, at least in case this would
> ever be backported.

Thanks for your input Gerald.

So unless people would be running shiny new kernels on older
distributions it shouldn't be a problem (and I don't think we care too
much about something like that). I don't expect something like that to
get backported - there is absolutely no reason to do so IMHO.

> 
>> 2. Restrict it to s390x only. It always returned 0 on other
>> architectures, I was not able to find any user.
>>
>> I think 2 should be safe to do (never used on other archs). I do wonder
>> what the feelings are about 1.
> 
> Please don't add any s390-specific workarounds here, that does not
> really sound like a clean-up, rather the opposite.

People seem to have different opinions here. I'm happy as long as we can
get rid of it (either now, or in the future with a new model).

> 
> That being said, I do not really see the benefit of this change at
> all. As Michal mentioned, there really should be some more fundamental
> change. And from the rest of this thread, it also seems that phys_device
> usage might not be the biggest issue here.
> 

As I already expressed, I am more of a friend of small, incremental
changes than having a single big world switch where everything will be
shiny and perfect.

(Deprecating it now - in any way - stops any new users from appearing -
both, in the kernel and from user space - eventually making the big
world switch later a little easier because there is one thing less that
vanished)

-- 
Thanks,

David / dhildenb

