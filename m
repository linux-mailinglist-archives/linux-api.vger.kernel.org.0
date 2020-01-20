Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E456142853
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2020 11:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATKkQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jan 2020 05:40:16 -0500
Received: from relay.sw.ru ([185.231.240.75]:38280 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgATKkQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 Jan 2020 05:40:16 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itUTD-0008KJ-NK; Mon, 20 Jan 2020 13:39:47 +0300
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
To:     Michal Hocko <mhocko@kernel.org>, sspatil@google.com
Cc:     kirill@shutemov.name, minchan@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        oleksandr@redhat.com, surenb@google.com, timmurray@google.com,
        dancol@google.com, sonnyrao@google.com, bgeffon@google.com,
        hannes@cmpxchg.org, shakeelb@google.com, joaodias@google.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz> <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com> <20200117212653.7uftw3lk35oykkmb@box>
 <20200119161431.GA94410@google.com> <20200120075825.GH18451@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e516b6c0-1868-5f0a-d18c-f0e8de5a2326@virtuozzo.com>
Date:   Mon, 20 Jan 2020 13:39:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120075825.GH18451@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 20.01.2020 10:58, Michal Hocko wrote:
> On Sun 19-01-20 08:14:31, sspatil@google.com wrote:
>> On Sat, Jan 18, 2020 at 12:26:53AM +0300, Kirill A. Shutemov wrote:
>>> On Fri, Jan 17, 2020 at 09:32:39AM -0800, Minchan Kim wrote:
>>>> On Fri, Jan 17, 2020 at 06:58:37PM +0300, Kirill A. Shutemov wrote:
>>>>> On Fri, Jan 17, 2020 at 12:52:25PM +0100, Michal Hocko wrote:
>>>>>> On Thu 16-01-20 15:59:50, Minchan Kim wrote:
>>>>>>> There is usecase that System Management Software(SMS) want to give
>>>>>>> a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
>>>>>>> in the case of Android, it is the ActivityManagerService.
>>>>>>>
>>>>>>> It's similar in spirit to madvise(MADV_WONTNEED), but the information
>>>>>>> required to make the reclaim decision is not known to the app. Instead,
>>>>>>> it is known to the centralized userspace daemon(ActivityManagerService),
>>>>>>> and that daemon must be able to initiate reclaim on its own without
>>>>>>> any app involvement.
>>>>>>>
>>>>>>> To solve the issue, this patch introduces new syscall process_madvise(2).
>>>>>>> It uses pidfd of an external processs to give the hint.
>>>>>>>
>>>>>>>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
>>>>>>> 			unsigned long flag);
>>>>>>>
>>>>>>> Since it could affect other process's address range, only privileged
>>>>>>> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
>>>>>>> gives it the right to ptrace the process could use it successfully.
>>>>>>> The flag argument is reserved for future use if we need to extend the
>>>>>>> API.
>>>>>>>
>>>>>>> I think supporting all hints madvise has/will supported/support to
>>>>>>> process_madvise is rather risky. Because we are not sure all hints make
>>>>>>> sense from external process and implementation for the hint may rely on
>>>>>>> the caller being in the current context so it could be error-prone.
>>>>>>> Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
>>>>>>>
>>>>>>> If someone want to add other hints, we could hear hear the usecase and
>>>>>>> review it for each hint. It's more safe for maintainace rather than
>>>>>>> introducing a buggy syscall but hard to fix it later.
>>>>>>
>>>>>> I have brought this up when we discussed this in the past but there is
>>>>>> no reflection on that here so let me bring that up again. 
>>>>>>
>>>>>> I believe that the interface has an inherent problem that it is racy.
>>>>>> The external entity needs to know the address space layout of the target
>>>>>> process to do anyhing useful on it. The address space is however under
>>>>>> the full control of the target process though and the external entity
>>>>>> has no means to find out that the layout has changed. So
>>>>>> time-to-check-time-to-act is an inherent problem.
>>>>>>
>>>>>> This is a serious design flaw and it should be explained why it doesn't
>>>>>> matter or how to use the interface properly to prevent that problem.
>>>>>
>>>>> I agree, it looks flawed.
>>>>>
>>>>> Also I don't see what System Management Software can generically do on
>>>>> sub-process level. I mean how can it decide which part of address space is
>>>>> less important than other.
>>>>>
>>>>> I see how a manager can indicate that this process (or a group of
>>>>> processes) is less important than other, but on per-addres-range basis?
>>>>
>>>> For example, memory ranges shared by several processes or critical for the
>>>> latency, we could avoid those ranges to be cold/pageout to prevent
>>>> unncecessary CPU burning/paging.
>>>
>>> Hmm.. I still don't see why any external entity has a better (or any)
>>> knowledge about the matter. The process has to do this, no?
>>
>> FWIW, I totally agree with the time-to-check-time-to-react problem. However,
>> I'd like to clarify the ActivityManager/SystemServer case (I'll call it
>> SystemServer from now on)
>>
>> For Android, every application (including the special SystemServer) are forked
>> from Zygote. The reason ofcourse is to share as many libraries and classes between
>> the two as possible to benefit from the preloading during boot.
>>
>> After applications start, (almost) all of the APIs  end up calling into this
>> SystemServer process over IPC (binder) and back to the application.
>>
>> In a fully running system, the SystemServer monitors every single process
>> periodically to calculate their PSS / RSS and also decides which process is
>> "important" to the user for interactivity.
>>
>> So, because of how these processes start _and_ the fact that the SystemServer
>> is looping to monitor each process, it does tend to *know* which address
>> range of the application is not used / useful.
>>
>> Besides, we can never rely on applications to clean things up themselves.
>> We've had the "hey app1, the system is low on memory, please trim your
>> memory usage down" notifications for a long time[1]. They rely on
>> applications honoring the broadcasts and very few do.
>>
>> So, if we want to avoid the inevitable killing of the application and
>> restarting it, some way to be able to tell the OS about unimportant memory in
>> these applications will be useful.
> 
> This is a useful information that should be a part of the changelog. I
> do see how the current form of the API might fit into Android model
> without many problems. But we are not designing an API for a single
> usecase, right? In a highly cooperative environments you can use ptrace
> code injection as mentioned by Kirill. Or is there any fundamental
> problem about that?

There could be only problems with multi-threads applications, which
poll the state of another threads (and exit with error, when they
found that someone is traced). But this may be workarounded by freezer
cgroup making all the thread group is frozen. It should guarantee
consistent state of the whole process after attaching.

Kirill

