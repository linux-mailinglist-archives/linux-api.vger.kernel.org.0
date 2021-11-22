Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E1459639
	for <lists+linux-api@lfdr.de>; Mon, 22 Nov 2021 21:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhKVUrW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Nov 2021 15:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhKVUrV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Nov 2021 15:47:21 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E1C06173E
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 12:44:14 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e144so25064109iof.3
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 12:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q/cvqnigMuuasyTrT0KugloRW/WUnqaCW0PrJCLnVCg=;
        b=qKhi7NydH3bKPHQK819eJ/TidrRfYD0oXPb3qq1uSQBQza5+IghM8hITGlyNEYFdwf
         hPEedboOxQt82x+1VBQm6D0RUKAF4j2pWg9j/QetFJCxphRacr9LppOCwYVL0TNpLb/Y
         33tSufmPOfloFpV7xC8IgCjmkj9+MjFKOYbf7WGz5omynQJ1KPdAizOwDJcSUP76Jw0U
         8/tT3OjljgQolO3SfoH7cFl9Bm63oOy/9ghTYsrbqapYmf9GXpB/lJoe6GbXF4ckhOg1
         ILC4WU57gOzKXhrb2A2lURvGaQiPvjcAEJNN+/1gOYMRnKCxRwJ8HvxEVDBE/Ib0D1E8
         1Pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q/cvqnigMuuasyTrT0KugloRW/WUnqaCW0PrJCLnVCg=;
        b=dYK1Ia5EmzCbJ2gcQgY7muNmvRfqaDfKVFM2occIXcetTK44cRhDbaJ6B9h9eFOWc+
         iLIewdINLLv3avnoJZmShID5zxGvwGyRLC8qyAGjCS2qG4Aofv1WIIny1aFDk/FLPcNr
         VDLPZSQ8sq37TSZG+kp9TwjS7y2aoBiUEdPZ02qtsPa7nRqaYtbHrimsAGlXTC5LgcwJ
         rWwUGUJe8VUHv5RYeW0eQ49yIfT0Ai0TM47u+URvqPwk9o4X77DpO7Nczfc+KnTPYiC4
         Qh7lSGoeZVJdhiEO0pEiLL0sUuS6EWrgFdkDIFWZCxolPtYxkVqnnXIbJvDTaM/ps+If
         a3Xw==
X-Gm-Message-State: AOAM531pJ4uhXA/BDOesU94wjjVnsdANcj2HROiSzv2LMZ6s7+enbmKi
        u9tnHSjw6gPBxrgTibk44uxjPA==
X-Google-Smtp-Source: ABdhPJwkZWbVkTTiFWI+g422byaFoSdWqtql9J9rLx3pzCORzzZXOHxqokwfNAgqaBm/lOMto8HetA==
X-Received: by 2002:a05:6638:3012:: with SMTP id r18mr52123432jak.91.1637613852459;
        Mon, 22 Nov 2021 12:44:12 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a12sm3531723iow.6.2021.11.22.12.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 12:44:12 -0800 (PST)
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
To:     David Hildenbrand <david@redhat.com>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <20211028080813.15966-1-sir@cmpwn.com>
 <CAFBCWQ+=2T4U7iNQz_vsBsGVQ72s+QiECndy_3AMFV98bMOLow@mail.gmail.com>
 <CFII8LNSW5XH.3OTIVFYX8P65Y@taiga>
 <593aea3b-e4a4-65ce-0eda-cb3885ff81cd@gnuweeb.org>
 <20211115203530.62ff33fdae14927b48ef6e5f@linux-foundation.org>
 <CFQZSHV700KV.18Y62SACP8KOO@taiga>
 <20211116114727.601021d0763be1f1efe2a6f9@linux-foundation.org>
 <CFRGQ58D9IFX.PEH1JI9FGHV4@taiga>
 <20211116133750.0f625f73a1e4843daf13b8f7@linux-foundation.org>
 <b84bc345-d4ea-96de-0076-12ff245c5e29@redhat.com>
 <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
 <333cb52b-5b02-648e-af7a-090e23261801@redhat.com>
 <ca96bb88-295c-ccad-ed2f-abc585cb4904@kernel.dk>
 <5f998bb7-7b5d-9253-2337-b1d9ea59c796@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3adc55d3-f383-efa9-7319-740fc6ab5d7a@kernel.dk>
Date:   Mon, 22 Nov 2021 13:44:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f998bb7-7b5d-9253-2337-b1d9ea59c796@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/22/21 1:08 PM, David Hildenbrand wrote:
> On 22.11.21 20:53, Jens Axboe wrote:
>> On 11/22/21 11:26 AM, David Hildenbrand wrote:
>>> On 22.11.21 18:55, Andrew Dona-Couch wrote:
>>>> Forgive me for jumping in to an already overburdened thread.  But can
>>>> someone pushing back on this clearly explain the issue with applying
>>>> this patch?
>>>
>>> It will allow unprivileged users to easily and even "accidentally"
>>> allocate more unmovable memory than it should in some environments. Such
>>> limits exist for a reason. And there are ways for admins/distros to
>>> tweak these limits if they know what they are doing.
>>
>> But that's entirely the point, the cases where this change is needed are
>> already screwed by a distro and the user is the administrator. This is
>> _exactly_ the case where things should just work out of the box. If
>> you're managing farms of servers, yeah you have competent administration
>> and you can be expected to tweak settings to get the best experience and
>> performance, but the kernel should provide a sane default. 64K isn't a
>> sane default.
> 
> 0.1% of RAM isn't either.

No default is perfect, byt 0.1% will solve 99% of the problem. And most
likely solve 100% of the problems for the important case, which is where
you want things to Just Work on your distro without doing any
administration.  If you're aiming for perfection, it doesn't exist.

>>> This is not a step into the right direction. This is all just trying to
>>> hide the fact that we're exposing FOLL_LONGTERM usage to random
>>> unprivileged users.
>>>
>>> Maybe we could instead try getting rid of FOLL_LONGTERM usage and the
>>> memlock limit in io_uring altogether, for example, by using mmu
>>> notifiers. But I'm no expert on the io_uring code.
>>
>> You can't use mmu notifiers without impacting the fast path. This isn't
>> just about io_uring, there are other users of memlock right now (like
>> bpf) which just makes it even worse.
> 
> 1) Do we have a performance evaluation? Did someone try and come up with
> a conclusion how bad it would be?

I honestly don't remember the details, I took a look at it about a year
ago due to some unrelated reasons. These days it just pertains to
registered buffers, so it's less of an issue than back then when it
dealt with the rings as well. Hence might be feasible, I'm certainly not
against anyone looking into it. Easy enough to review and test for
performance concerns.

> 2) Could be provide a mmu variant to ordinary users that's just good
> enough but maybe not as fast as what we have today? And limit
> FOLL_LONGTERM to special, privileged users?

If it's not as fast, then it's most likely not good enough though...

> 3) Just because there are other memlock users is not an excuse. For
> example, VFIO/VDPA have to use it for a reason, because there is no way
> not do use FOLL_LONGTERM.

It's not an excuse, the statement merely means that the problem is
_worse_ as there are other memlock users.

>>
>> We should just make this 0.1% of RAM (min(0.1% ram, 64KB)) or something
>> like what was suggested, if that will help move things forward. IMHO the
>> 32MB machine is mostly a theoretical case, but whatever .
> 
> 1) I'm deeply concerned about large ZONE_MOVABLE and MIGRATE_CMA ranges
> where FOLL_LONGTERM cannot be used, as that memory is not available.
> 
> 2) With 0.1% RAM it's sufficient to start 1000 processes to break any
> system completely and deeply mess up the MM. Oh my.

We're talking per-user limits here. But if you want to talk hyperbole,
then 64K multiplied by some other random number will also allow
everything to be pinned, potentially.

-- 
Jens Axboe

