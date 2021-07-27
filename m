Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEFE3D74F3
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 14:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhG0MVd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Jul 2021 08:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236453AbhG0MVc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Jul 2021 08:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627388491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN9VGkVetG/NwFHIx+rWl4d+U3ZCuABiM4oRqn8aEJM=;
        b=J20JhjZX5LvALQSZzPZgmxrJFn9+hHNgFOcJlzqvwGN29tlpwbzuiE3KMYZ7sQi9Nfi52S
        gWRnWstJaOnUthE5X5Yo71CYBwdCfcLa+xtyUHe0qnCKxsOh5H9R1BZtJUXm/4naBsRJ0a
        6UkUROnqV7p43lXcoKGPNQ1DoEu0Gng=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-97hTgZTDMfaUJvHmNQPIrQ-1; Tue, 27 Jul 2021 08:21:30 -0400
X-MC-Unique: 97hTgZTDMfaUJvHmNQPIrQ-1
Received: by mail-wm1-f71.google.com with SMTP id 25-20020a05600c0219b029024ebb12928cso1294000wmi.3
        for <linux-api@vger.kernel.org>; Tue, 27 Jul 2021 05:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LN9VGkVetG/NwFHIx+rWl4d+U3ZCuABiM4oRqn8aEJM=;
        b=i5LZUzCCrcKnCBNORERV8+Ne50r8kS6FApulIy8XYN2liBrEcEuJpVS1fukVSdbWU0
         ixgreD6Zx/Fv9OmDtBrE9JDUih3gsQyiZ9yiB10zCJpBf8ilFL/B2ifchYAw7INKal4J
         KULXKjTiD7LC5f3fKyeB2/STbW2zkh7yY1br1o/gtbytwzT4CqrMo+xfBu7hDf4RojUh
         PRECtyBzO9C5pDmUqb/nTellBl1WBpwt6TLkteyD69/vQEwEl0BGkvUgD0IwhkvTvIRI
         u1ZecmuO5eezW773+nX46KMEWnQNrYhLDWZvBSlMWpyE+sh2hykmdcFnxSb4NXaaO1Y7
         pvbw==
X-Gm-Message-State: AOAM5317Hx8AGW9AqkRYxjtnYjeTbSSmQ5wnM/ZWtSkzuvNF6hEZoaf7
        ggWqzS+0j981s35twyXyTqdi2MExrP9n1pOWdIV/QwGHoP/+TXkq+WyUvLmnbuCwoL+fNeeXq2N
        0IrL2GFsxEsQ4aYVVXqY7
X-Received: by 2002:a05:600c:19cb:: with SMTP id u11mr3860758wmq.1.1627388489337;
        Tue, 27 Jul 2021 05:21:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQnNIw4yzhbK/hXIiowJKU9c6Yhf3WFk7FQBEZQiomOdMaGA+TgOqmsNh4ypiuVnQyMVEu/g==
X-Received: by 2002:a05:600c:19cb:: with SMTP id u11mr3860731wmq.1.1627388489098;
        Tue, 27 Jul 2021 05:21:29 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c36.dip0.t-ipconnect.de. [79.242.60.54])
        by smtp.gmail.com with ESMTPSA id k9sm3199009wrc.6.2021.07.27.05.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 05:21:28 -0700 (PDT)
Subject: Re: [PATCH v4] mm: Enable suspend-only swap spaces
From:   David Hildenbrand <david@redhat.com>
To:     Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        linux-api@vger.kernel.org, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <d6668437-5c3b-2dff-bb95-4e3132d13711@redhat.com>
Organization: Red Hat
Message-ID: <6ff28cfe-1107-347b-0327-ad36e256141b@redhat.com>
Date:   Tue, 27 Jul 2021 14:21:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d6668437-5c3b-2dff-bb95-4e3132d13711@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 27.07.21 11:48, David Hildenbrand wrote:
> On 27.07.21 02:12, Evan Green wrote:
>> Add a new SWAP_FLAG_HIBERNATE_ONLY that adds a swap region but refuses
>> to allow generic swapping to it. This region can still be wired up for
>> use in suspend-to-disk activities, but will never have regular pages
>> swapped to it. This flag will be passed in by utilities like swapon(8),
>> usage would probably look something like: swapon -o hibernate /dev/sda2.
>>
>> Currently it's not possible to enable hibernation without also enabling
>> generic swap for a given area. One semi-workaround for this is to delay
>> the call to swapon() until just before attempting to hibernate, and then
>> call swapoff() just after hibernate completes. This is somewhat kludgy,
>> and also doesn't really work to keep swap out of the hibernate region.
>> When hibernate begins, it starts by allocating a large chunk of memory
>> for itself. This often ends up forcing a lot of data out into swap. By
>> this time the hibernate region is eligible for generic swap, so swap
>> ends up leaking into the hibernate region even with the workaround.
>>
>> There are a few reasons why usermode might want to be able to
>> exclusively steer swap and hibernate. One reason relates to SSD wearing.
>> Hibernate's endurance and speed requirements are different from swap.
>> It may for instance be advantageous to keep hibernate in primary
>> storage, but put swap in an SLC namespace. These namespaces are faster
>> and have better endurance, but cost 3-4x in terms of capacity.
>> Exclusively steering hibernate and swap enables system designers to
>> accurately partition their storage without either wearing out their
>> primary storage, or overprovisioning their fast swap area.
>>
>> Another reason to allow exclusive steering has to do with security.
>> The requirements for designing systems with resilience against
>> offline attacks are different between swap and hibernate. Swap
>> effectively requires a dictionary of hashes, as pages can be added and
>> removed arbitrarily, whereas hibernate only needs a single hash for the
>> entire image. If you've set up block-level integrity for swap and
>> image-level integrity for hibernate, then allowing swap blocks to
>> possibly leak out to the hibernate region is problematic, since it
>> creates swap pages not protected by any integrity.
>>
>> Swap regions with SWAP_FLAG_HIBERNATE_ONLY set will not appear in
>> /proc/meminfo under SwapTotal and SwapFree, since they are not usable as
>> general swap. These regions do still appear in /proc/swaps.
> 
> Right, and they also don't account towards the memory overcommit
> calculations.
> 
> Thanks for extending the patch description!
> 
> [...]
> 
>> +	if (swap_flags & SWAP_FLAG_HIBERNATE_ONLY) {
>> +		if (IS_ENABLED(CONFIG_HIBERNATION)) {
>> +			if (swap_flags & ~SWAP_HIBERNATE_ONLY_VALID_FLAGS)
>> +				return -EINVAL;
>> +
>> +		} else {
>> +			return -EINVAL;
>> +		}
>> +	}
> 
> We could do short
> 
> if ((swap_flags & SWAP_FLAG_HIBERNATE_ONLY) &&
>        (!IS_ENABLED(CONFIG_HIBERNATION) ||
>         (swap_flags & ~SWAP_HIBERNATE_ONLY_VALID_FLAGS)))
> 	return -EINVAL;
> 
> or
> 
> if (swap_flags & SWAP_FLAG_HIBERNATE_ONLY))
> 	if (!IS_ENABLED(CONFIG_HIBERNATION) ||
>               (swap_flags & ~SWAP_HIBERNATE_ONLY_VALID_FLAGS))
> 		return -EINVAL;
> 
>> +
>>    	if (!capable(CAP_SYS_ADMIN))
>>    		return -EPERM;
>>    
>> @@ -3335,16 +3366,20 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>    	if (swap_flags & SWAP_FLAG_PREFER)
>>    		prio =
>>    		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
>> +
>> +	if (swap_flags & SWAP_FLAG_HIBERNATE_ONLY)
>> +		p->flags |= SWP_HIBERNATE_ONLY;
>>    	enable_swap_info(p, prio, swap_map, cluster_info, frontswap_map);
>>    
>> -	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
>> +	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s%s\n",
>>    		p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
>>    		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
>>    		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
>>    		(p->flags & SWP_DISCARDABLE) ? "D" : "",
>>    		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
>>    		(p->flags & SWP_PAGE_DISCARD) ? "c" : "",
>> -		(frontswap_map) ? "FS" : "");
>> +		(frontswap_map) ? "FS" : "",
>> +		(p->flags & SWP_HIBERNATE_ONLY) ? "H" : "");
>>    
>>    	mutex_unlock(&swapon_mutex);
>>    	atomic_inc(&proc_poll_event);
>>
> 
> Looks like the cleanest alternative to me, as long as we don't want to
> invent new interfaces.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Pavel just mentioned uswsusp, and I wonder if it would be a possible 
alternative to this patch.

-- 
Thanks,

David / dhildenb

