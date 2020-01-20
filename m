Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9469A14282E
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2020 11:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgATKYu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jan 2020 05:24:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:37836 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgATKYu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 Jan 2020 05:24:50 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itUEW-0008Gw-6R; Mon, 20 Jan 2020 13:24:36 +0300
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
To:     Michal Hocko <mhocko@kernel.org>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f57fb198-4070-d3b4-b6bd-43b29ff40a2c@virtuozzo.com>
Date:   Mon, 20 Jan 2020 13:24:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117115225.GV19428@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17.01.2020 14:52, Michal Hocko wrote:
> On Thu 16-01-20 15:59:50, Minchan Kim wrote:
>> There is usecase that System Management Software(SMS) want to give
>> a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
>> in the case of Android, it is the ActivityManagerService.
>>
>> It's similar in spirit to madvise(MADV_WONTNEED), but the information
>> required to make the reclaim decision is not known to the app. Instead,
>> it is known to the centralized userspace daemon(ActivityManagerService),
>> and that daemon must be able to initiate reclaim on its own without
>> any app involvement.
>>
>> To solve the issue, this patch introduces new syscall process_madvise(2).
>> It uses pidfd of an external processs to give the hint.
>>
>>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
>> 			unsigned long flag);
>>
>> Since it could affect other process's address range, only privileged
>> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
>> gives it the right to ptrace the process could use it successfully.
>> The flag argument is reserved for future use if we need to extend the
>> API.
>>
>> I think supporting all hints madvise has/will supported/support to
>> process_madvise is rather risky. Because we are not sure all hints make
>> sense from external process and implementation for the hint may rely on
>> the caller being in the current context so it could be error-prone.
>> Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
>>
>> If someone want to add other hints, we could hear hear the usecase and
>> review it for each hint. It's more safe for maintainace rather than
>> introducing a buggy syscall but hard to fix it later.
> 
> I have brought this up when we discussed this in the past but there is
> no reflection on that here so let me bring that up again. 
> 
> I believe that the interface has an inherent problem that it is racy.
> The external entity needs to know the address space layout of the target
> process to do anyhing useful on it. The address space is however under
> the full control of the target process though and the external entity
> has no means to find out that the layout has changed. So
> time-to-check-time-to-act is an inherent problem.
> 
> This is a serious design flaw and it should be explained why it doesn't
> matter or how to use the interface properly to prevent that problem.

Really, any address space manipulation, where more than one process is
involved, is racy. Even two threads on common memory need a synchronization
to manage mappings in a sane way. Managing memory from two processes
is the same in principle, and the only difference is that another level
of synchronization is required.

I'm not fan and user for this feature (at least for now, nobody knows
what will be in the future), but design flaw argument does not look
fully valid.

Regards,
Kirill
