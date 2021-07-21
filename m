Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9A3D138F
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhGUPc0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 11:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232502AbhGUPcZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 11:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626883981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+1x1mENMFxc8VLP/jpqaTH0FYhxbACKoXkinVL26Wc=;
        b=ZHyTF170NfcPOTX8NolJl1xAFPyUHgfQFTO4w96hQE2WINm8rkkQmcdANofR2fzBWyZS72
        5ulPu6B30q8ZgSqBnrB8nZlNHmWl12Usykobs/CDV2V5HDu8xpBFM3/o9Xp5ZaX3IjqMZU
        33Eu4DQCRQ2uUZd1jXmf+eOriXncIeM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-RgMUrauhMbif4ouQUNhm_Q-1; Wed, 21 Jul 2021 12:12:59 -0400
X-MC-Unique: RgMUrauhMbif4ouQUNhm_Q-1
Received: by mail-wm1-f69.google.com with SMTP id z127-20020a1c7e850000b02901e46e4d52c0so1213100wmc.6
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 09:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q+1x1mENMFxc8VLP/jpqaTH0FYhxbACKoXkinVL26Wc=;
        b=X967SnJ9fnEPCKjh16C9XvD3WmOnDt/1cC7s5a9yRtShvlKJKsaw04ee4OMQK4jiAp
         5lLJ2cqVPz6Sa2+gscnnhjNyWxfXnSO4908/EPZrybeiyAMdAAEdfgFWbErUiuAKYAwb
         WdRm3nKJTBIA2gmlEp6q4TrjIk1ZDpt46KzqxMpFSHx1uHq0hnInfr75LS8oqTo40iHj
         1N7KE86gAXEyhyN9z1QyM08bNdKTWy/ychWRIiUpEWYIToV565hjeCfvD4dWRSYLB0t8
         a0DYSGPDRdbUfdge+PL/pQ7sjYtLm0CbIp4HC0GOiTYGx3M/NIvP4Ga8feP/gMlK8ECp
         GOhQ==
X-Gm-Message-State: AOAM532DkewRIzPyMW6hGhdwsSFV7VxzlchX6s21fENYRn4qZ79tDmCn
        xfgGwFB0yfgPqVuB/V+ncXsaaTwAoKAoLInOINiwNl+3RIOe3XNlydjlG9uFjfNUjO+NuZmrdbL
        kLRLe81xe4nH37xw+BnPX
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr4782846wmi.67.1626883978717;
        Wed, 21 Jul 2021 09:12:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBad4MtATTGEezDpg/5UCIzeBsvG9+jv9Q5/Fp96JqgG0VxamWxXA/f1dTpJs61LbL4pViDg==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr4782827wmi.67.1626883978487;
        Wed, 21 Jul 2021 09:12:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c3.dip0.t-ipconnect.de. [91.12.101.195])
        by smtp.gmail.com with ESMTPSA id d8sm28546989wra.41.2021.07.21.09.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 09:12:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to
 be used in process_mrelease
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
References: <20210718214134.2619099-1-surenb@google.com>
 <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
 <20210720160707.2332738708948f7d865d67c1@linux-foundation.org>
 <ba763ed3-9ad1-9502-1ffc-3175446570d1@redhat.com>
 <CAJuCfpEB994Xj3FcmzyH1p3yOdLVf6EwZaGaRj7NJi_c9hbsRQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0ee6775b-589c-3243-1c01-aafad5eecb73@redhat.com>
Date:   Wed, 21 Jul 2021 18:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEB994Xj3FcmzyH1p3yOdLVf6EwZaGaRj7NJi_c9hbsRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 21.07.21 17:33, Suren Baghdasaryan wrote:
> On Wed, Jul 21, 2021 at 12:30 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 21.07.21 01:07, Andrew Morton wrote:
>>> On Tue, 20 Jul 2021 14:43:52 +0200 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 18.07.21 23:41, Suren Baghdasaryan wrote:
>>>>> process_mrelease needs to be added in the CONFIG_MMU-dependent block which
>>>>> comes before __task_will_free_mem and task_will_free_mem. Move these
>>>>> functions before this block so that new process_mrelease syscall can use
>>>>> them.
>>>>>
>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>>> ---
>>>>> changes in v2:
>>>>> - Fixed build error when CONFIG_MMU=n, reported by kernel test robot. This
>>>>> required moving task_will_free_mem implemented in the first patch
>>>>> - Renamed process_reap to process_mrelease, per majority of votes
>>>>> - Replaced "dying process" with "process which was sent a SIGKILL signal" in
>>>>> the manual page text, per Florian Weimer
>>>>> - Added ERRORS section in the manual page text
>>>>> - Resolved conflicts in syscall numbers caused by the new memfd_secret syscall
>>>>> - Separated boilerplate code wiring-up the new syscall into a separate patch
>>>>> to facilitate the review process
>>>>>
>>>>>     mm/oom_kill.c | 150 +++++++++++++++++++++++++-------------------------
>>>>>     1 file changed, 75 insertions(+), 75 deletions(-)
>>>>
>>>> TBH, I really dislike this move as it makes git blame a lot harder with
>>>> any real benefit.
>>>>
>>>> Can't you just use prototypes to avoid the move for now in patch #2?
>>>>
>>>> static bool task_will_free_mem(struct task_struct *task);
>>>
>>> This change makes the code better - it's silly to be adding forward
>>> declarations just because the functions are in the wrong place.
>>
>> I'd really love to learn what "better" here means and if it's rather
>> subjective. When it comes to navigating the code, we do have established
>> tools for that (ctags), and personally I couldn't care less where
>> exactly in a file the code is located.
>>
>> Sure, ending up with a forward-declaration for every function might not
>> be what we want ;)
>>
>>>
>>> If that messes up git-blame then let's come up with better tooling
>>> rather than suffering poorer kernel code because the tools aren't doing
>>> what we want of them.  Surely?
>>
>> I don't agree that what we get is "poorer kernel code" in this very
>> instance; I can understand that we avoid forward-declarations when
>> moving smallish functions. But moving two functions with 75 LOC is a bit
>> too much for my taste at least -- speaking as someone who cares about
>> easy backports and git-blame.
> 
> There is a third alternative here to have process_mrelease() at the
> end of the file with its own #ifdef CONFIG_MMU block, maybe even
> embedded in the function like this:
> 
>   int process_mrelease(int pidfd, unsigned int flags)
> {
> #ifdef CONFIG_MMU
>          ...
> #else
>          return ENOSYS;
> #endif
> }
> 
> This would not require moving other functions.
> Would that be better than the current approach or the forward declaration?

IMHO that could be an easy, possible alternative.

-- 
Thanks,

David / dhildenb

