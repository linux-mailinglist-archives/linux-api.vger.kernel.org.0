Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7A3BB804
	for <lists+linux-api@lfdr.de>; Mon,  5 Jul 2021 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhGEHoh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 5 Jul 2021 03:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229978AbhGEHog (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Jul 2021 03:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625470919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VoHUzGSOequcyOo3F6H8BsyFbZ2tce0N3gMOC9Uf/8=;
        b=Go3glGjZhuNiN09Ho07IsHlUOjbcgY2WL/RG0cK8jP3669/svJ/2yz5TC+OBSSYpbqk5lh
        1554+dxnGICWPV84C9kC2+rq3gqVSUIz0NP9G1dsgw5XhIJBGa0b2TEwqZp2IiZek77Ged
        Sr8G/1LAr6jRo0OzBkRhUkJdZZDi13g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-t6Cw35uXPoGy-pUKr08M7A-1; Mon, 05 Jul 2021 03:41:58 -0400
X-MC-Unique: t6Cw35uXPoGy-pUKr08M7A-1
Received: by mail-wm1-f72.google.com with SMTP id k8-20020a05600c1c88b02901b7134fb829so2815094wms.5
        for <linux-api@vger.kernel.org>; Mon, 05 Jul 2021 00:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4VoHUzGSOequcyOo3F6H8BsyFbZ2tce0N3gMOC9Uf/8=;
        b=RKFjG+sQcP4h4E8zarppBd2EO2u1icLbrA6KFHZ9UsplrnDvSKZ5BVjLJebUJckq1F
         O8UK93fdDwmrcIXdIef35sYLkvk5vO1/3VJ1N19oeMbODWK8DzyiwAE5/zhhMZ81BBJb
         BL6wqclftgWjv++/sZE5gBl+vFDZ8QlBxUYUxNNrr01cNGpRchxdMwRelZ6+VpPZ4TPY
         xlmukYZDrLsNPNvpeQ/7pHxAx04siQ4vQDSuCppjYwbyFqYWvxpYZaO2N5VJEVC90iBV
         xAYXqhnM/jxNb4FskIjk7v8M+0wWMhig8H4R/ke+PUaL/NRrZglP+t0Uv61R7HWa6RJv
         kq4g==
X-Gm-Message-State: AOAM532AXkgdv4UtOf9lpetbn98pNSoQjoH8o2mZAp8CzkK2S1TZIJPG
        RV2+k27ykgyn8/rOUkrBhf0Ba+SV4m32HHaB3s4YN9fEwvgFnTzmkY44fH2R+i3qIa5kcA0iuyn
        oBj7/TYWvOaa/PsYjwlQj
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr13958761wry.299.1625470917225;
        Mon, 05 Jul 2021 00:41:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcx+WC36pR7wWTgO82M+tfm+vTSe542c1Nbeh+g9RtlXwZwnIn83qNzboNxZSL/BOnfACf5w==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr13958737wry.299.1625470917079;
        Mon, 05 Jul 2021 00:41:57 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id m5sm214888wmq.2.2021.07.05.00.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 00:41:56 -0700 (PDT)
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20210623192822.3072029-1-surenb@google.com>
 <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
 <YNzl6XNu2vxyCJu8@cmpxchg.org>
 <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
 <CAJuCfpG5Ua7C4usJGEqTm6_UUd6VyRd0BsPgT97LWOzjb4Ry+g@mail.gmail.com>
 <20210702152724.7fv5tnik4qlap6do@wittgenstein>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <af8e76f1-6625-25d1-98d2-a3c8a9bf2fd6@redhat.com>
Date:   Mon, 5 Jul 2021 09:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702152724.7fv5tnik4qlap6do@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 02.07.21 17:27, Christian Brauner wrote:
> On Thu, Jul 01, 2021 at 03:59:48PM -0700, Suren Baghdasaryan wrote:
>> On Wed, Jun 30, 2021 at 5:44 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>
>>> On Wed, Jun 30, 2021 at 2:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>
>>>> On Wed, Jun 30, 2021 at 11:51:36AM -0700, Suren Baghdasaryan wrote:
>>>>> On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>>>> Also, please consider removing all mention of the word "reap" from the
>>>>>> user API.  For better or for worse, "reap" in UNIX refers to what
>>>>>> happens when a dead task gets wait()ed.  I sincerely wish I could go
>>>>>> back in time and gently encourage whomever invented that particular
>>>>>> abomination to change their mind, but my time machine doesn't work.
>>>>>
>>>>> I see. Thanks for the note. How about process_mem_release() and
>>>>> replacing reap with release everywhere?
>>>>
>>>> I don't quite understand the objection. This syscall works on tasks
>>>> that are at the end of their life, right? Isn't something like
>>>> process_mreap() establishing exactly the mental link we want here?
>>>> Release is less descriptive for what this thing is to be used for.
>>>
>>> For better or for worse, "reap" means to make a zombie pid go away.
>>>  From the description, this new operation takes a dying process (not
>>> necessarily a zombie yet) and aggressively frees its memory.  This is
>>> a different optioneration.
>>>
>>> How about "free_dying_process_memory"?
>>
>> process_mreap sounds definitely better and in line with names like
>> process_madvise. So maybe we can use it?
> 
> That one was my favorite from the list I gave too but maybe we can
> satisfy Andy too if we use one of:
> - process_mfree()
> - process_mrelease()
> 

FWIW, I tend to like process_mrelease(), due to the implied "release" 
("free the memory if there are no other references") semantics. Further, 
a new syscall feels cleaner than some magic sysfs/procfs toggle. Just my 
2 cents.

-- 
Thanks,

David / dhildenb

