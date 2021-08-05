Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528223E1AD4
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbhHERzr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 13:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhHERzq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 13:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628186131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TY2vPAYrdCbgz7dO6xO7134YAuWg1cL9bDHqg/h8rfY=;
        b=I5jph/acZWIFQBGnTZ7AcMO2avtxnb1+qYVkeMgKkPkM97uojnIi+feLGHVpL2nPcDbDyx
        URNn+aQWYgffFyVv+yOK1W7GN49BQYcHjKG3PXd3UW+PD9gg3W+yRA8d4ve6KfPsiY7JE3
        Dy7xl/HMeKQu3iwonANw4GGPNu3AO4w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-CmfzhojjPzeTejkD3Kc6CQ-1; Thu, 05 Aug 2021 13:55:30 -0400
X-MC-Unique: CmfzhojjPzeTejkD3Kc6CQ-1
Received: by mail-wr1-f72.google.com with SMTP id d7-20020adffd870000b02901544ea2018fso2207980wrr.10
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 10:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TY2vPAYrdCbgz7dO6xO7134YAuWg1cL9bDHqg/h8rfY=;
        b=YkZCFeWz6E86eDmpzPFtyYTy7SbghIRP3617rOhZZ8LQXHZBzQQ1SZ5YdjssSp/tXC
         Rtd2NKhoNVSMc0sckBAJDhvDesMm26Np3QiXcO/bgiDIOL6jGRDjOXLDbDmXXBKCe4R6
         3k9xNd6L4MakwNHF3lau+1ApJ60Ovjy7QKZr2t//g6nbDZWvSPprnKMVJCYtPfP4GYYb
         rVrB32ww5oSTfNbK7qf2GYYSRP1fB1W41xNmxrnzLe/X8wMkWt+Y1y+e7E95iH24B4mo
         n3d4lGHZ3I5kH6sTVkcJr9i3utgck/qTH8+oenOatF/X3KAXpnWKXzaj05jwooLH1D6Z
         qNdA==
X-Gm-Message-State: AOAM530P//g0z8VKn8l/TPNASxoE5Nah0vhUZTTgguWH/tEAni/JOu8B
        DB7/KeJG4ujmI1QPl51us3mJIdRZV3L4GzPz69/EkuII/rmUKhpLW9bn6QW4KjNgZHCZimZL5Ie
        BJR8R2uS7Wc6YqIWGbBlr
X-Received: by 2002:a1c:a543:: with SMTP id o64mr6117730wme.103.1628186128896;
        Thu, 05 Aug 2021 10:55:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym/WQV4l/ckfV4N8yXvNxdGaRbZVHNTFQGyYKvQ1ClNTG4b7G4ZUej4Xqj3dWztJ3MVSXyTA==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr6117708wme.103.1628186128694;
        Thu, 05 Aug 2021 10:55:28 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c630b.dip0.t-ipconnect.de. [91.12.99.11])
        by smtp.gmail.com with ESMTPSA id 104sm6800116wrc.4.2021.08.05.10.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:55:28 -0700 (PDT)
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
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
References: <20210805170859.2389276-1-surenb@google.com>
 <46998d10-d0ca-aeeb-8dcd-41b8130fb756@redhat.com>
 <CAJuCfpGvqgUWpdL_KNE1tnqH2OjqX64QjBYttoPRtGgXWfONRQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <96203d51-5948-d063-4a9c-2eb33e631502@redhat.com>
Date:   Thu, 5 Aug 2021 19:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpGvqgUWpdL_KNE1tnqH2OjqX64QjBYttoPRtGgXWfONRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 05.08.21 19:49, Suren Baghdasaryan wrote:
> On Thu, Aug 5, 2021 at 10:29 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.08.21 19:08, Suren Baghdasaryan wrote:
>>> In modern systems it's not unusual to have a system component monitoring
>>> memory conditions of the system and tasked with keeping system memory
>>> pressure under control. One way to accomplish that is to kill
>>> non-essential processes to free up memory for more important ones.
>>> Examples of this are Facebook's OOM killer daemon called oomd and
>>> Android's low memory killer daemon called lmkd.
>>> For such system component it's important to be able to free memory
>>> quickly and efficiently. Unfortunately the time process takes to free
>>> up its memory after receiving a SIGKILL might vary based on the state
>>> of the process (uninterruptible sleep), size and OPP level of the core
>>> the process is running. A mechanism to free resources of the target
>>> process in a more predictable way would improve system's ability to
>>> control its memory pressure.
>>> Introduce process_mrelease system call that releases memory of a dying
>>> process from the context of the caller. This way the memory is freed in
>>> a more controllable way with CPU affinity and priority of the caller.
>>> The workload of freeing the memory will also be charged to the caller.
>>> The operation is allowed only on a dying process.
>>>
>>> After previous discussions [1, 2, 3] the decision was made [4] to introduce
>>> a dedicated system call to cover this use case.
>>>
>>> The API is as follows,
>>>
>>>             int process_mrelease(int pidfd, unsigned int flags);
>>>
>>>           DESCRIPTION
>>>             The process_mrelease() system call is used to free the memory of
>>>             an exiting process.
>>>
>>>             The pidfd selects the process referred to by the PID file
>>>             descriptor.
>>>             (See pidfd_open(2) for further information)
>>>
>>>             The flags argument is reserved for future use; currently, this
>>>             argument must be specified as 0.
>>>
>>>           RETURN VALUE
>>>             On success, process_mrelease() returns 0. On error, -1 is
>>>             returned and errno is set to indicate the error.
>>>
>>>           ERRORS
>>>             EBADF  pidfd is not a valid PID file descriptor.
>>>
>>>             EAGAIN Failed to release part of the address space.
>>>
>>>             EINTR  The call was interrupted by a signal; see signal(7).
>>>
>>>             EINVAL flags is not 0.
>>>
>>>             EINVAL The memory of the task cannot be released because the
>>>                    process is not exiting, the address space is shared
>>>                    with another live process or there is a core dump in
>>>                    progress.
>>>
>>>             ENOSYS This system call is not supported, for example, without
>>>                    MMU support built into Linux.
>>>
>>>             ESRCH  The target process does not exist (i.e., it has terminated
>>>                    and been waited on).
>>>
>>> [1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
>>> [2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
>>> [3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
>>> [4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>> changes in v7:
>>> - Fixed pidfd_open misspelling, per Andrew Morton
>>> - Fixed wrong task pinning after find_lock_task_mm() issue, per Michal Hocko
>>> - Moved MMF_OOM_SKIP check before task_will_free_mem(), per Michal Hocko
>>>
>>>    mm/oom_kill.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 73 insertions(+)
>>>
>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>> index c729a4c4a1ac..a4d917b43c73 100644
>>> --- a/mm/oom_kill.c
>>> +++ b/mm/oom_kill.c
>>> @@ -28,6 +28,7 @@
>>>    #include <linux/sched/task.h>
>>>    #include <linux/sched/debug.h>
>>>    #include <linux/swap.h>
>>> +#include <linux/syscalls.h>
>>>    #include <linux/timex.h>
>>>    #include <linux/jiffies.h>
>>>    #include <linux/cpuset.h>
>>> @@ -1141,3 +1142,75 @@ void pagefault_out_of_memory(void)
>>>        out_of_memory(&oc);
>>>        mutex_unlock(&oom_lock);
>>>    }
>>> +
>>> +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>>> +{
>>> +#ifdef CONFIG_MMU
>>> +     struct mm_struct *mm = NULL;
>>> +     struct task_struct *task;
>>> +     struct task_struct *p;
>>> +     unsigned int f_flags;
>>> +     struct pid *pid;
>>> +     long ret = 0;
>>> +
>>> +     if (flags)
>>> +             return -EINVAL;
>>> +
>>> +     pid = pidfd_get_pid(pidfd, &f_flags);
>>> +     if (IS_ERR(pid))
>>> +             return PTR_ERR(pid);
>>> +
>>> +     task = get_pid_task(pid, PIDTYPE_PID);
>>> +     if (!task) {
>>> +             ret = -ESRCH;
>>> +             goto put_pid;
>>> +     }
>>> +
>>> +     /*
>>> +      * If the task is dying and in the process of releasing its memory
>>> +      * then get its mm.
>>> +      */
>>> +     p = find_lock_task_mm(task);
>>> +     if (!p) {
>>> +             ret = -ESRCH;
>>> +             goto put_pid;
>>> +     }
>>> +     if (task != p) {
>>> +             get_task_struct(p);
>>
>>
>> Wouldn't we want to obtain the mm from p ? I thought that was the whole
>> exercise of going via find_lock_task_mm().
> 
> Yes, that's what we do after checking task_will_free_mem().
> task_will_free_mem() requires us to hold task_lock and
> find_lock_task_mm() achieves that ensuring that mm is still valid, but
> it might return a task other than the original one. That's why we do
> this dance with pinning the new task and unpinning the original one.
> The same dance is performed in __oom_kill_process(). I was
> contemplating adding a parameter to find_lock_task_mm() to request
> this unpin/pin be done within that function but then decided to keep
> it simple for now.
> Did I address your question or did I misunderstand it?

Excuse my tired eyes, I missed the "task = p;"

Feel free to carry my ack along, even if there are minor changes.


-- 
Thanks,

David / dhildenb

