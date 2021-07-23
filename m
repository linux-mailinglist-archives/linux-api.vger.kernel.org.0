Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43B93D34EC
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhGWGSM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 02:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234053AbhGWGSL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 02:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627023525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElwTUrgx2uwYZtx6RXk2BFBNKStGzvaPr0AwpeE9zds=;
        b=Ar6XOjQndwGIAZJ8LffQEs39bnM1MD1rJDDVK8tyZNTlvxW/AsD67ofM5QAeOWG0SphHbt
        T09j+nfh+n0aFCnrm4RneULBS2g0TpXEY079QW+wEpIvW+xJaWvyA9wHiR/3HoaAlOCUWe
        PNKT/T259kGoveBC/axkfEwzL9p+OSA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-n4Ic-nMYNFeml2IwaCbLEA-1; Fri, 23 Jul 2021 02:58:43 -0400
X-MC-Unique: n4Ic-nMYNFeml2IwaCbLEA-1
Received: by mail-wr1-f71.google.com with SMTP id n1-20020a5d59810000b029013cd60e9baaso633211wri.7
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 23:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ElwTUrgx2uwYZtx6RXk2BFBNKStGzvaPr0AwpeE9zds=;
        b=PAp90OKzmVAh5k9Vfcte5/gJRknH0GAy1woujoyZ9JPHSHAEKIvMiVffn+k7phQNNI
         OP8Xd0k8Z55Rq9N7simj9iFpbUdrSDbwP5HbY6sWID0nC1a6mjfBrP69dYQ1FmqSqHZS
         7PaKvZl4wRk0e/lrZ9qCAXj+6Cz/yjLv++y6n+94FhpsouM1r3gTRQIP2nl4Yhu2K0Pk
         aXn/+LruDtEsGZzvira6FAyznoiMlq5iUk16IW0nT0bpkgWz/exjx+jFeKq6WG8dHIIo
         gaFF062S0JqnKoUticpcgnAswV/Rehg9B3PIueIIG2foH+ar5QNtKs1lj9G/DpYDzssi
         Qlbg==
X-Gm-Message-State: AOAM533062r4vvMggfGVetVB84EokOGgnQ+8/LMrvDax2rePHaKC057z
        aNZnv9DLRlryhrL91f88sDdHDKWxU87HJk85GSFpC1go3O0+3K+VO/vMM8zxxI6hlJcbvKrYluX
        /2kevafWCNIjPolXcPeCY
X-Received: by 2002:a5d:4cce:: with SMTP id c14mr3584284wrt.258.1627023522760;
        Thu, 22 Jul 2021 23:58:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrQGpf3ok0FD5zzDYTaQhQ8SpdhoX7AkzghoaJR37V7X600SqkQ0mX4yh/Ddrw/dZMWcySGA==
X-Received: by 2002:a5d:4cce:: with SMTP id c14mr3584258wrt.258.1627023522457;
        Thu, 22 Jul 2021 23:58:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id z13sm32834744wro.79.2021.07.22.23.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 23:58:41 -0700 (PDT)
To:     Evan Green <evgreen@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20210721143946.v3.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <dd405f78-ac37-18d4-23f1-7d43507edee6@redhat.com>
 <CAE=gft7eY0scobDwQGq-OuFk4Ec2APFQF-4K6UVkTN-TOGwETw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] mm: Enable suspend-only swap spaces
Message-ID: <3c46df04-abf4-4bcb-b9cf-430bb1d15b07@redhat.com>
Date:   Fri, 23 Jul 2021 08:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft7eY0scobDwQGq-OuFk4Ec2APFQF-4K6UVkTN-TOGwETw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 22.07.21 20:00, Evan Green wrote:
> On Thu, Jul 22, 2021 at 12:12 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 21.07.21 23:40, Evan Green wrote:
>>> Currently it's not possible to enable hibernation without also enabling
>>> generic swap for a given swap area. These two use cases are not the
>>> same. For example there may be users who want to enable hibernation,
>>> but whose drives don't have the write endurance for generic swap
>>> activities. Swap and hibernate also have different security/integrity
>>> requirements, prompting folks to possibly set up something like block-level
>>> integrity for swap and image-level integrity for hibernate. Keeping swap
>>> and hibernate separate in these cases becomes not just a matter of
>>> preference, but correctness.
>>>
>>> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
>>> generic swapping to it. This region can still be wired up for use in
>>> suspend-to-disk activities, but will never have regular pages swapped to
>>> it. This flag will be passed in by utilities like swapon(8), usage would
>>> probably look something like: swapon -o noswap /dev/sda2.
>>
>> Just a minor comment, I'd call it rather SWAP_FLAG_HIBERNATE_ONLY and
>> SWAP_FLAG_HIBERNATE_ONLY -- that calls the child by its name.
> 
> I went back and forth on this too. It seemed pretty close to toss-up
> to me. I went with NOSWAP ultimately because it seemed more closely
> tied to what the flag was actually doing, rather than building in my
> one expected use case into the name. In some world years from now
> where either hibernate has diverged, been deleted, or maybe some new
> usage has been invented for swap space, the NOSWAP name felt like it
> had a better chance of holding up. The argument is weak though, as
> these features are pretty well cast in stone, and the likelihood of
> any of those outcomes seems low. I can change it if you feel strongly,
> but would probably keep it as-is otherwise.

Just imagine technology Z popping up and using also the swap 
infrastructure. What would be the semantics of NOSWAP? With 
HIBERNATE_ONLY it's clear -- enable that device only for hibernation, 
nothing else.

But you raise a good point: if hibernation isn't even possible in a 
configuration (e.g., not configured into the kernel), we should simply 
reject that flag. So if hibernation would vanish at some point 
completely from the system, it would all be handled accordingly.

That would result in quite a consistent definition of 
SWAP_FLAG_HIBERNATE_ONLY IMHO.

Makes sense?

> 
>>
>> I think some other flags might not apply with that new flag set, right?
>> For example, does SWAP_FLAG_DISCARD_ONCE or SWP_AREA_DISCARD still have
>> any meaning with the new flag being set?
>>
>> We should most probably disallow enabling any flag that doesn't make any
>> sense in combination.
> 
> Good point, I can send a followup patch for that. From my reading

I'd actually enjoy if we'd have that logic in the introducing patch.

> SWAP_FLAG_DISCARD and SWAP_FLAG_DISCARD_ONCE are still valid, since
> the discard can be run at swapon() time. SWAP_FLAG_PREFER (specifying
> the priority) doesn't make sense, and SWAP_FLAG_DISCARD_PAGES never
> kicks in because it's called at the cluster level. Hm, that sort of
> seems like a bug that freed hibernate swap doesn't get discarded. I
> can disallow it now as unsupported, but might send a patch to fix it
> later.

Might be worth fixing, indeed.

> 
>>
>> Apart from that, I'd love to see a comment in here why the workaround
>> suggested by Michal isn't feasible -- essentially a summary of what we
>> discussed.
> 
> Ah sorry, I had tried to clarify that in the commit text, but didn't
> explicitly address the workaround. To summarize, the workaround keeps
> generic swap out of your hibernate region... until hibernate time. But
> once hibernate starts, a lot of swapping tends to happen when the
> hiber-image is allocated. At this point the hibernate region is
> eligible for general swap even with the workaround. The reasons I gave
> for wanting to exclusively steer swap and hibernate are SSD write
> wearing, different integrity solutions for swap vs hibernate, and our
> own security changes that no-op out the swapon/swapoff syscalls after
> init.
> 

That would be nice to have in the patch description :)

-- 
Thanks,

David / dhildenb

