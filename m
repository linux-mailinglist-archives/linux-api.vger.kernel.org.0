Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042183D09C1
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 09:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhGUGxN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 02:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235456AbhGUGuo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 02:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626852655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DL9UmkXz/nN7BSNL6vHyfX+JXbE4a1PMCoecBw8MQEw=;
        b=Am+vpyU+W5DFr8D0OD9d66iSfNEO/N1z0xQobrKKIdjlkosjs+AGhFoQoJN7cg3J6FJ0x3
        psclqa+QKzyworayNSlMjyy4cktIPB1nXE33PstVYyrA5SYoqPr/jJ29+HPUGanwMefoiW
        7nooBvptRijGj/+zXahbpfc3DciGp2g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-mvZhFLdyO2SbxuP70Y_Jmg-1; Wed, 21 Jul 2021 03:30:53 -0400
X-MC-Unique: mvZhFLdyO2SbxuP70Y_Jmg-1
Received: by mail-wm1-f72.google.com with SMTP id o21-20020a05600c4fd5b029023448cbd285so234324wmq.2
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 00:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DL9UmkXz/nN7BSNL6vHyfX+JXbE4a1PMCoecBw8MQEw=;
        b=ZKzgv5jeGP5oFtEnHCYoNalgPUWNGZGXkX8J6IiNhnu2JqgrV5BRbp186hoToNuvn5
         jufHtQjqSvc0/DF6gonvJlptf5/GbvcE5F6uP7xroHK/KWrsEd/ChDgdmMwd5z9zM9Y/
         YFLWr9zJCrau4B+bCj6V05Uq2MCU9mQcXU61jvJgwAhvE6uYE+rLoVEo7I7RrKkahlV2
         lTCs6FRstCjhBuMPpOIU+p52fv1+FRC4rfaoWPnhPCP6FDF4qUP9i/iRj2YGVa2OAABC
         gG0fcqolsf4J57mcKUNKCW4k81+ndDi5xBAswAJDHJ+MJGl9umrMPjPsFuCMOllzLifY
         ekWQ==
X-Gm-Message-State: AOAM532E79gJjOlCS4ET0s7Jiq60z1fK3+Ind7zYg5CuZRJiaPcTaBHk
        XYwG9O9pCSZaPu128PoMD2f4RF4AQUgGM39lM+1C99htxLWAw/JqKn1qm3zcpL7UrgQEgcSmi9Z
        jqtTNigfBJu0PoqrGa5o1
X-Received: by 2002:adf:ea4c:: with SMTP id j12mr40198982wrn.138.1626852652640;
        Wed, 21 Jul 2021 00:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIQHk1P6w/MimNoqSTmY26cwLVNrhQ2aBrvQpPOB2x8VzbdDweeFLuPzs8IPbCNyR1oJy1uQ==
X-Received: by 2002:adf:ea4c:: with SMTP id j12mr40198959wrn.138.1626852652444;
        Wed, 21 Jul 2021 00:30:52 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c3.dip0.t-ipconnect.de. [91.12.101.195])
        by smtp.gmail.com with ESMTPSA id o14sm4391093wmq.31.2021.07.21.00.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 00:30:51 -0700 (PDT)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, mhocko@kernel.org,
        mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, riel@surriel.com,
        minchan@kernel.org, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20210718214134.2619099-1-surenb@google.com>
 <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
 <20210720160707.2332738708948f7d865d67c1@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to
 be used in process_mrelease
Message-ID: <ba763ed3-9ad1-9502-1ffc-3175446570d1@redhat.com>
Date:   Wed, 21 Jul 2021 09:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720160707.2332738708948f7d865d67c1@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 21.07.21 01:07, Andrew Morton wrote:
> On Tue, 20 Jul 2021 14:43:52 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 18.07.21 23:41, Suren Baghdasaryan wrote:
>>> process_mrelease needs to be added in the CONFIG_MMU-dependent block which
>>> comes before __task_will_free_mem and task_will_free_mem. Move these
>>> functions before this block so that new process_mrelease syscall can use
>>> them.
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>> changes in v2:
>>> - Fixed build error when CONFIG_MMU=n, reported by kernel test robot. This
>>> required moving task_will_free_mem implemented in the first patch
>>> - Renamed process_reap to process_mrelease, per majority of votes
>>> - Replaced "dying process" with "process which was sent a SIGKILL signal" in
>>> the manual page text, per Florian Weimer
>>> - Added ERRORS section in the manual page text
>>> - Resolved conflicts in syscall numbers caused by the new memfd_secret syscall
>>> - Separated boilerplate code wiring-up the new syscall into a separate patch
>>> to facilitate the review process
>>>
>>>    mm/oom_kill.c | 150 +++++++++++++++++++++++++-------------------------
>>>    1 file changed, 75 insertions(+), 75 deletions(-)
>>
>> TBH, I really dislike this move as it makes git blame a lot harder with
>> any real benefit.
>>
>> Can't you just use prototypes to avoid the move for now in patch #2?
>>
>> static bool task_will_free_mem(struct task_struct *task);
> 
> This change makes the code better - it's silly to be adding forward
> declarations just because the functions are in the wrong place.

I'd really love to learn what "better" here means and if it's rather 
subjective. When it comes to navigating the code, we do have established 
tools for that (ctags), and personally I couldn't care less where 
exactly in a file the code is located.

Sure, ending up with a forward-declaration for every function might not 
be what we want ;)

> 
> If that messes up git-blame then let's come up with better tooling
> rather than suffering poorer kernel code because the tools aren't doing
> what we want of them.  Surely?

I don't agree that what we get is "poorer kernel code" in this very 
instance; I can understand that we avoid forward-declarations when 
moving smallish functions. But moving two functions with 75 LOC is a bit 
too much for my taste at least -- speaking as someone who cares about 
easy backports and git-blame.

Anyhow, just my 2 cents.

-- 
Thanks,

David / dhildenb

