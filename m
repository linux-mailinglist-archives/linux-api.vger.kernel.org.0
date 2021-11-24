Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C845CCB8
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 20:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242927AbhKXTM5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 14:12:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237867AbhKXTM4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 14:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637780986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=isQsxZ+UIWuySQG9MheyCegH/iYJKHmJZxPqthMror0=;
        b=XTGGPM2IjDIlRrmfjTZF30naq210eEAZiIo5HG6Zqg7Ol/de0YNuEPSbCr5R6E6LkKoA5j
        Zq0dyUyNsoc/PYwH9svysXkuoe/RGzfzuyy7BzWBmVBpjiwNGf+v++pYjbhZQ2Y/DRYJx+
        OTxgYPirwDAISk8BMwkfrREfAW5pNRg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-SPV0_p7vP6uqWEBw3vxBsA-1; Wed, 24 Nov 2021 14:09:45 -0500
X-MC-Unique: SPV0_p7vP6uqWEBw3vxBsA-1
Received: by mail-wm1-f72.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso1993974wms.0
        for <linux-api@vger.kernel.org>; Wed, 24 Nov 2021 11:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=isQsxZ+UIWuySQG9MheyCegH/iYJKHmJZxPqthMror0=;
        b=3/83sfIvoqLiD/KBTLDVXIjJ2deKl4kf1k7e0zr8wAJBbz0zVtBYfPPLtVMSI12tX/
         Xp9eG2zd4DuO/3k5tejtPXdst4ZwjTn9jn0GVKUx6feq3zj5qRiz1a82MT5SqvDumfon
         jcIlubrfrKClQaguh83cDuCJYRsLdwNYRtBG4XVZY2vCkzJhyahxoq1w8wPm9myXw4v2
         /z5x0syzziYhh2cAV5ueFDApC+p2r/DvDuyBtnBl/ut6KnKyJz4Nxn91UBI6e7dEnfyn
         QYUzhzAHEegtAYQZqg+HUekE5+ivL+4QoVTd/su/Ke+lS4hQgAszNm/j1wXZnAzyJtS1
         9ERg==
X-Gm-Message-State: AOAM531X86OIr6aAsuOi6737aZGmtDlSZmY51OQq+U3JMV4Qkmh7AdQJ
        h9O+66+VICzD0cFdIkEQkHW+3xznDihxTZLraN1nvdtEooOzLCfvlyVveCId6HV6fmJj/YXJkBF
        KQX/jG6AR508dciEhP1//
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr22328420wrt.48.1637780983923;
        Wed, 24 Nov 2021 11:09:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4cnG6zQAtfTxbiF3GkI02UpMt0XyyBIq1dEWEXIxz2pHNKNMEO5mJ1P1ByRxTDNJ/bVfvjw==
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr22328368wrt.48.1637780983653;
        Wed, 24 Nov 2021 11:09:43 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6380.dip0.t-ipconnect.de. [91.12.99.128])
        by smtp.gmail.com with ESMTPSA id bg12sm805901wmb.5.2021.11.24.11.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 11:09:42 -0800 (PST)
Message-ID: <cc9d3f3e-2fe1-0df0-06b2-c54e020161da@redhat.com>
Date:   Wed, 24 Nov 2021 20:09:42 +0100
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
References: <20211123235953.GF5112@ziepe.ca>
 <2adca04f-92e1-5f99-6094-5fac66a22a77@redhat.com>
 <20211124132353.GG5112@ziepe.ca>
 <cca0229e-e53e-bceb-e215-327b6401f256@redhat.com>
 <20211124132842.GH5112@ziepe.ca>
 <eab5aeba-e064-9f3e-fbc3-f73cd299de83@redhat.com>
 <20211124134812.GI5112@ziepe.ca>
 <2cdbebb9-4c57-7839-71ab-166cae168c74@redhat.com>
 <20211124153405.GJ5112@ziepe.ca>
 <63294e63-cf82-1f59-5ea8-e996662e6393@redhat.com>
 <20211124183544.GL5112@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
In-Reply-To: <20211124183544.GL5112@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 24.11.21 19:35, Jason Gunthorpe wrote:
> On Wed, Nov 24, 2021 at 05:43:58PM +0100, David Hildenbrand wrote:
>> On 24.11.21 16:34, Jason Gunthorpe wrote:
>>> On Wed, Nov 24, 2021 at 03:14:00PM +0100, David Hildenbrand wrote:
>>>
>>>> I'm not aware of any where you can fragment 50% of all pageblocks in the
>>>> system as an unprivileged user essentially consuming almost no memory
>>>> and essentially staying inside well-defined memlock limits. But sure if
>>>> there are "many" people will be able to come up with at least one
>>>> comparable thing. I'll be happy to learn.
>>>
>>> If the concern is that THP's can be DOS'd then any avenue that renders
>>> the system out of THPs is a DOS attack vector. Including all the
>>> normal workloads that people run and already complain that THPs get
>>> exhausted.
>>>
>>> A hostile userspace can only quicken this process.
>>
>> We can not only fragment THP but also easily smaller compound pages,
>> with less impact though (well, as long as people want more than 0.1% per
>> user ...).
> 
> My point is as long as userspace can drive this fragmentation, by any
> means, we can never have DOS proof higher order pages, so lets not
> worry so much about one of many ways to create fragmentation.
> 

That would be giving up on compound pages (hugetlbfs, THP, ...) on any
current Linux system that does not use ZONE_MOVABLE -- which is not
something I am not willing to buy into, just like our customers ;)

See my other mail, the upstream version of my reproducer essentially
shows what FOLL_LONGTERM is currently doing wrong with pageblocks. And
at least to me that's an interesting insight :)

I agree that the more extreme scenarios I can construct are a secondary
concern. But my upstream reproducer just highlights what can easily
happen in reality.

>>>> My position that FOLL_LONGTERM for unprivileged users is a strong no-go
>>>> stands as it is.
>>>
>>> As this basically excludes long standing pre-existing things like
>>> RDMA, XDP, io_uring, and more I don't think this can be the general
>>> answer for mm, sorry.
>>
>> Let's think about options to restrict FOLL_LONGTERM usage:
> 
> Which gives me the view that we should be talking about how to make
> high order pages completely DOS proof, not about FOLL_LONGTERM.

Sure, one step at a time ;)

> 
> To me that is exactly what ZONE_MOVABLE strives to achieve, and I
> think anyone who cares about QOS around THP must include ZONE_MOVABLE
> in their solution.

For 100% yes.

> 
> In all of this I am thinking back to the discussion about the 1GB THP
> proposal which was resoundly shot down on the grounds that 2MB THP
> *doesn't work* today due to the existing fragmentation problems.

The point that "2MB THP" doesn't work is just wrong. pageblocks do their
job very well, but we can end up in corner case situations where more
and more pageblocks are getting fragmented. And people are constantly
improving these corner cases (e.g. proactive compaction).

Usually you have to allocate *a lot* of memory and put the system under
extreme memory pressure, such that unmovable allocations spill into
movable pageblocks and the other way around.

The thing about my reproducer is that it does that without any memory
pressure, and that is the BIG difference to everything else we have in
that regard. You can have an idle 1TiB system running my reproducer and
it will fragment half of of all pageblocks in the system while mlocking
~ 1GiB. And that highlights the real issue IMHO.

The 1 GB THP project is still going on BTW.

> 
>> Another option would be not accounting FOLL_LONGTERM as RLIMIT_MEMLOCK,
>> but instead as something that explicitly matches the differing
>> semantics. 
> 
> Also a good idea, someone who cares about this should really put
> pinned pages into the cgroup machinery (with correct accounting!)
> 
>> At the same time, eventually work on proper alternatives with mmu
>> notifiers (and possibly without the any such limits) where possible
>> and required.
> 
> mmu_notifiers is also bad, it just offends a different group of MM
> concerns :)

Yeah, I know, locking nightmare.

> 
> Something like io_ring is registering a bulk amount of memory and then
> doing some potentially long operations against it.

The individual operations it performs are comparable to O_DIRECT I think
-- but no expert.

> 
> So to use a mmu_notifier scheme you'd have to block the mmu_notifier
> invalidate_range_start until all the operations touching the memory
> finish (and suspend new operations at the same time!).
> 
> Blocking the notifier like this locks up the migration/etc threads
> completely, and is destructive to the OOM reclaim.
> 
> At least with a pinned page those threads don't even try to touch it
> instead of getting stuck up.

Yes, if only we'd be pinning for a restricted amount of time ...

-- 
Thanks,

David / dhildenb

