Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28A2265B2C
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgIKIJT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 04:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgIKIJS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Sep 2020 04:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599811756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=USB7u5uICVKazcwoE63AzAP8Oi+FAHiJ1P8bdHw4fZA=;
        b=CL6JtqOVYrMrpbUJ5ZE/fua4rDB/jotDNhvi9yO1yYQj5Td8ydgvZup1s7x9TmdE9WBiPI
        tVBUhlsPRiA7c87ICWCbiPL9nN2lRSDRTYSzqH/clbHSN0pYAgIYiQEF5ArMREgZesce+g
        ZDxGdHfVJAEdflgJW6DAxsbv+jnchpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-cVvUGzlUOSW4ji0lbqrvcQ-1; Fri, 11 Sep 2020 04:09:12 -0400
X-MC-Unique: cVvUGzlUOSW4ji0lbqrvcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDBFB807354;
        Fri, 11 Sep 2020 08:09:10 +0000 (UTC)
Received: from [10.36.113.186] (ovpn-113-186.ams2.redhat.com [10.36.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5726D75129;
        Fri, 11 Sep 2020 08:09:08 +0000 (UTC)
Subject: Re: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device
 ?
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
 <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
 <20200911072035.GC7986@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <02cdbf90-b29f-a9ec-c83d-49f2548e3e91@redhat.com>
Date:   Fri, 11 Sep 2020 10:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911072035.GC7986@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11.09.20 09:20, Michal Hocko wrote:
> On Thu 10-09-20 22:31:09, David Hildenbrand wrote:
>>
>>
>>> Am 10.09.2020 um 22:01 schrieb Dave Hansen <dave.hansen@intel.com>:
>>>
>>> ﻿On 9/10/20 3:20 AM, David Hildenbrand wrote:
>>>> I was just exploring how /sys/devices/system/memory/memoryX/phys_device
>>>> is/was used. It's one of these interfaces that most probably never
>>>> should have been added but now we are stuck with it.
>>>
>>> While I'm all for cleanups, what specific problems is phys_device causing?
>>>
>>
>> Mostly stumbling over it, understanding that it is basically unused
>> with new userspace for good reason, questioning its existence.
>>
>> E.g., I am working on virtio-mem support for s390x. Displaying
>> misleading/wrong phys_device indications isn‘t particularly helpful
>> - especially once there are different ways to hotplug memory for an
>> architecture.
>>
>>> Are you hoping that we can just remove users of memoryX/* until there
>>> are no more left, and this is the easiest place to start?
>>
>> At least reducing it to a minimum with clear semantics. Even with
>> automatic onlining there are still reasons why we need to keep the
>> interface for now (e.g., reloading kexec to update the kdump headers
>> on memory hot(un)plug). But also standby memory handling on s399x
>> requires it (->manual onlining).
> 
> While I agree that the existing interface is far from ideal, I am not
> sure it makes much sense to invest energy into cleaning it up. We can
> have a pig with a lipstick but but this will not solve the underlying
> problem that we have I believe. The interface doesn't scale with the
> block count (especially on some platforms like ppc), it is too
> inflexible (single size of the block) and many others. I believe we need
> a completely new interface which would effectively deprecate the
> existing one. One could still chose to use the old interface but new
> usecases would use the new one ideally.

Even with a new interface (that does allow for variable-sized block
sizes), we will still end up with many memory block devices. It's not
the one thing that solves all our problems.

Consider two cases:

1. Hot(un)plugging huge DIMMs: many (not all!) use cases want to
online/offline the whole thing. HW can effectively only plug/unplug the
whole thing. It makes sense in some (most?) setups to represent one DIMM
as one memory block device.

2. Hot(un)plugging small memory increments. This is mostly the case in
virtualized environments - especially hyper-v balloon, xen balloon,
virtio-mem and (drumroll) ppc dlpar and s390x standby memory. On PPC,
you want at least all (16MB!) memory block devices that can get
unplugged again individually ("LMBs") as separate memory blocks. Same on
s390x on memory increment size (currently effectively the memory block
size).

In summary, larger memory block devices mostly only make sense with
DIMMs (and for boot memory in some cases). We will still end up with
many memory block devices in other configurations.

I do agree that a "disable sysfs" option is interesting - even with
memory hotplug (we mostly need a way to configure it and a way to notify
kexec-tools about memory hot(un)plug events). I am currently (once
again) looking into improving auto-onlining support in the kernel.

Having that said, I much rather want to see smaller improvements (that
can be fine-tuned individually - like allowing variable-sized memory
blocks) than doing a switch to "new shiny" and figuring out after a
while that we need "new shiny2".

I consider removing "phys_device" as one of these tunables. The question
would be how to make such sysfs changes easy to configure
("-phys_device", "+variable_sized_blocks" ...)

-- 
Thanks,

David / dhildenb

