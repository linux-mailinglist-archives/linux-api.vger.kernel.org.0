Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC313BC8A
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2020 10:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAOJjJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jan 2020 04:39:09 -0500
Received: from relay.sw.ru ([185.231.240.75]:43588 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbgAOJjJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Jan 2020 04:39:09 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1irf8N-0002JO-Tx; Wed, 15 Jan 2020 12:38:44 +0300
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
To:     Minchan Kim <minchan@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
References: <20200110213433.94739-1-minchan@kernel.org>
 <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
 <CAKOZuevwbQvrFWqy5GOm4RXuGszKLBvRs9i-KbAi3nPcHhwvSw@mail.gmail.com>
 <3eec2097-75a3-1e1d-06d9-44ee5eaf1312@virtuozzo.com>
 <20200114191239.GB178589@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com>
Date:   Wed, 15 Jan 2020 12:38:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114191239.GB178589@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 14.01.2020 22:12, Minchan Kim wrote:
> On Tue, Jan 14, 2020 at 11:39:28AM +0300, Kirill Tkhai wrote:
>> On 13.01.2020 22:18, Daniel Colascione wrote:
>>> On Mon, Jan 13, 2020, 12:47 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>> +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
>>>>> +             size_t, len_in, int, behavior, unsigned long, flags)
>>>>
>>>> I don't like the interface. The fact we have pidfd does not mean,
>>>> we have to use it for new syscalls always. A user may want to set
>>>> madvise for specific pid from console and pass pid as argument.
>>>> pidfd would be an overkill in this case.
>>>> We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
>>>> allow this?
>>>
>>> All new APIs should use pidfds: they're better than numeric PIDs
>>
>> Yes
>>
>>> in every way.
>>
>> No
>>
>>> If a program wants to allow users to specify processes by
>>> numeric PID, it can parse that numeric PID, open the corresponding
>>> pidfd, and then use that pidfd with whatever system call it wants.
>>> It's not necessary to support numeric PIDs at the system call level to
>>> allow a console program to identify a process by numeric PID.
>>
>> No. It is overkill. Ordinary pid interfaces also should be available.
>> There are a lot of cases, when they are more comfortable. Say, a calling
>> of process_madvise() from tracer, when a tracee is stopped. In this moment
>> the tracer knows everything about tracee state, and pidfd brackets
>> pidfd_open() and close() around actual action look just stupid, and this
>> is cpu time wasting.
>>
>> Another example is a parent task, which manages parameters of its children.
>> It knows everything about them, whether they are alive or not. Pidfd interface
>> will just utilize additional cpu time here.
>>
>> So, no. Both interfaces should be available.
> 
> Sounds like that you want to support both options for every upcoming API
> which deals with pid. I'm not sure how it's critical for process_madvise
> API this case. In general, we sacrifice some performance for the nicer one
> and later, once it's reported as hurdle for some workload, we could fix it
> via introducing new flag. What I don't like at this moment is to make
> syscall complicated with potential scenarios without real workload.

Yes, I suggest allowing both options for every new process api. This may be
performance-critical for some workloads. Say, CRIU may exercise a lot of
inter-process calls during container restore and additional system calls
will slow down online migration. And there should be many another examples.

At least you have to call the first argument in more generic way from the start.
Not "int pidfd", but something like "idtype_t id" instead. This allows to extend
it in the future.

Kirill
