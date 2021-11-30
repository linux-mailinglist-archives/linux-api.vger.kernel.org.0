Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE4463AA0
	for <lists+linux-api@lfdr.de>; Tue, 30 Nov 2021 16:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbhK3P4a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Nov 2021 10:56:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243240AbhK3P4B (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Nov 2021 10:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638287559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jH9EXfZHYnVVr/gc0bkKyv6b3sFlfwoXqOh2jbmFu5w=;
        b=fxevny+oozzIi/iZAcyeadKxwRCIlfdW/780GVYLy5hYwUWYpVtEzW3Xoi4gFuykQZOY3d
        bxOJy/dbK7qp2htoJjEg57sLqWBWrMazBd8Sy+HoMrf0+q2s58mOersoLxzfKiW1xVW0Jx
        +l7HO2Yd3ZbFazR2VoqIweLM5kT59Tk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-EVh_SZNjNbiZ5p2TVAYaWw-1; Tue, 30 Nov 2021 10:52:37 -0500
X-MC-Unique: EVh_SZNjNbiZ5p2TVAYaWw-1
Received: by mail-wm1-f71.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so13120119wmq.9
        for <linux-api@vger.kernel.org>; Tue, 30 Nov 2021 07:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=jH9EXfZHYnVVr/gc0bkKyv6b3sFlfwoXqOh2jbmFu5w=;
        b=Tjr4WKebsdJFcrVPNtuzw7hD7GwiUkPjbV+b+4jCXfb79/MycR7YcJoefn7KmBYwYB
         nGjSNrDnasVNUcAG/HCUe9biWsVYY3yQDwns+R++qeS3NVeGBvKO6L2KHpkXW7Bw4e7+
         SqA5/yaLw/AzUFQSv/70cHsPNCYG6bcLsrQaGvjdfox6n05YA98vZI4ZW1ksW9RZywKL
         cR8b/KMcCAUtDCYdquGOm+z+9fYhDQoSYgLD0kQ3ZHOjYg9zCQocCUvmSykDAfQVoNns
         ECUGEipOMkbQM0SdPls2Wj+siDkoAhyIZa2Ww1xf0BpLyosPAaVcrFz61w3NPUWJDIgo
         DvSw==
X-Gm-Message-State: AOAM530I4FBiRHwZwgoEVSEtee3x7iOhqJxGT/8rV7o2pYl8pftgUJNt
        udQmG5MtN16aFiTs0rAgCt0ovDFs0KbDpqkTFBIdrAJdlZv46oM8DAHwqGl+LKwdo7giduFq7vT
        iOLXJ/evtfFx+8fmrp/xY
X-Received: by 2002:a5d:4ed1:: with SMTP id s17mr43275364wrv.310.1638287556323;
        Tue, 30 Nov 2021 07:52:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCk0Kh25FxWu333V+ypoDmQYiIbGoNO0Q+dLf07zWjEGO0dC+mlmyLLG91wlwVMItlU6Av5Q==
X-Received: by 2002:a5d:4ed1:: with SMTP id s17mr43275336wrv.310.1638287556029;
        Tue, 30 Nov 2021 07:52:36 -0800 (PST)
Received: from [192.168.3.132] (p5b0c68ec.dip0.t-ipconnect.de. [91.12.104.236])
        by smtp.gmail.com with ESMTPSA id t8sm3227398wmq.32.2021.11.30.07.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 07:52:35 -0800 (PST)
Message-ID: <8f82eacb-c6ad-807c-7e13-cd369e91a43d@redhat.com>
Date:   Tue, 30 Nov 2021 16:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <20211124132353.GG5112@ziepe.ca>
 <cca0229e-e53e-bceb-e215-327b6401f256@redhat.com>
 <20211124132842.GH5112@ziepe.ca>
 <eab5aeba-e064-9f3e-fbc3-f73cd299de83@redhat.com>
 <20211124134812.GI5112@ziepe.ca>
 <2cdbebb9-4c57-7839-71ab-166cae168c74@redhat.com>
 <20211124153405.GJ5112@ziepe.ca>
 <63294e63-cf82-1f59-5ea8-e996662e6393@redhat.com>
 <20211124183544.GL5112@ziepe.ca>
 <cc9d3f3e-2fe1-0df0-06b2-c54e020161da@redhat.com>
 <20211124231133.GM5112@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
In-Reply-To: <20211124231133.GM5112@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

(sorry, was busy working on other stuff)

>> That would be giving up on compound pages (hugetlbfs, THP, ...) on any
>> current Linux system that does not use ZONE_MOVABLE -- which is not
>> something I am not willing to buy into, just like our customers ;)
> 
> So we have ZONE_MOVABLE but users won't use it?

It's mostly used in the memory hot(un)plug context and we'll see growing
usage there in the near future (mostly due to dax/kmem, virtio-mem).

One has to be very careful how to size ZONE_MOVABLE, though, and it's
incompatible with various use cases (even huge pages on some
architectures are not movable and cannot be placed on ZONE_MOVABLE ...).
That's why we barely see it getting used automatically outside of memory
hot(un)plug context or when explicitly setup by the admin for a well
fine-tuned system.

> 
> Then why is the solution to push the same kinds of restrictions as
> ZONE_MOVABLE on to ZONE_NORMAL?

On any zone except ZONE_DEVICE to be precise. Defragmentation is one of
the main reasons we have pageblocks after all -- besides CMA and page
isolation. If we don't care about de-fragmentation we could just squash
MIGRATE_MOVABLE, MIGRATE_UNMOVABLE, MIGRATE_RECLAIMABLE into a single
type. But after all that's the only thing that provides us with THP in
most setups out there.

Note that some people (IIRC Mel) even proposed to remove ZONE_MOVABLE
and instead have "sticky" MIGRATE_MOVABLE pageblocks, meaning
MIGRATE_MOVABLE pageblocks that cannot be converted to a different type
or stolen from -- which would mimic the same thing as the pageblocks we
essentially have in ZONE_MOVABLE.

>  
>> See my other mail, the upstream version of my reproducer essentially
>> shows what FOLL_LONGTERM is currently doing wrong with pageblocks. And
>> at least to me that's an interesting insight :)
> 
> Hmm. To your reproducer it would be nice if we could cgroup control
> the # of page blocks a cgroup has pinned. Focusing on # pages pinned
> is clearly the wrong metric, I suggested the whole compound earlier,
> but your point about the entire page block being ruined makes sense
> too.

# pages pinned is part of the story, but yes, "pinned something inside a
pageblocks" is a better metric.

I would think that this might be complicated to track, though ...
especially once we have multiple cgroups pinning inside a single
pageblock. Hm ...

> 
> It means pinned pages will have be migrated to already ruined page
> blocks the cgroup owns, which is a more controlled version of the
> FOLL_LONGTERM migration you have been thinking about.

MIGRATE_UNMOVABLE pageblocks are already ruined. But we'd need some way
to manage/charge pageblocks per cgroup I guess? that sounds very
interesting.

> 
> This would effectively limit the fragmentation a hostile process group
> can create. If we further treated unmovable cgroup charged kernel
> allocations as 'pinned' and routed them to the pinned page blocks it
> start to look really interesting. Kill the cgroup, get all your THPs
> back? Fragmentation cannot extend past the cgroup?

So essentially any accounted unmovable kernel allocation (e.g., page
tables, secretmem, ... ) would try to be placed on a MIGRATE_UNMOVABLE
pageblock "charged" to the respective cgroup?

> 
> ie there are lots of batch workloads that could be interesting there -
> wrap the batch in a cgroup, run it, then kill everything and since the
> cgroup gives some lifetime clustering to the allocator you get a lot
> less fragmentation when the batch is finished, so the next batch gets
> more THPs, etc.
> 
> There is also sort of an interesting optimization opportunity - many
> FOLL_LONGTERM users would be happy to spend more time pinning to get
> nice contiguous memory ranges. Might help convince people that the
> extra pin time for migrations is worthwhile.

Indeed. And fortunately, huge page users (heavily used in vfio context
and for VMs) wouldn't be affected because they only pin huge pages and
there is nothing to migrate then (well, excluding MIGRATE_CMA and
ZONE_MOVABLE what we have already, of course).

> 
>>> Something like io_ring is registering a bulk amount of memory and then
>>> doing some potentially long operations against it.
>>
>> The individual operations it performs are comparable to O_DIRECT I think
> 
> Yes, and O_DIRECT can take 10s's of seconds in troubled cases with IO
> timeouts and things.
> 

I might be wrong about O_DIRECT semantics, though. Staring at
fs/io_uring.c I don't really have a clue how they are getting used. I
assume they are getting used for DMA directly.


-- 
Thanks,

David / dhildenb

