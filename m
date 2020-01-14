Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939DD13A311
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2020 09:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgANIkA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jan 2020 03:40:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:53820 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgANIkA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 14 Jan 2020 03:40:00 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1irHjU-0005aa-Ob; Tue, 14 Jan 2020 11:39:29 +0300
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
To:     Daniel Colascione <dancol@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
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
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3eec2097-75a3-1e1d-06d9-44ee5eaf1312@virtuozzo.com>
Date:   Tue, 14 Jan 2020 11:39:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuevwbQvrFWqy5GOm4RXuGszKLBvRs9i-KbAi3nPcHhwvSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 13.01.2020 22:18, Daniel Colascione wrote:
> On Mon, Jan 13, 2020, 12:47 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>> +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
>>> +             size_t, len_in, int, behavior, unsigned long, flags)
>>
>> I don't like the interface. The fact we have pidfd does not mean,
>> we have to use it for new syscalls always. A user may want to set
>> madvise for specific pid from console and pass pid as argument.
>> pidfd would be an overkill in this case.
>> We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
>> allow this?
> 
> All new APIs should use pidfds: they're better than numeric PIDs

Yes

> in every way.

No

> If a program wants to allow users to specify processes by
> numeric PID, it can parse that numeric PID, open the corresponding
> pidfd, and then use that pidfd with whatever system call it wants.
> It's not necessary to support numeric PIDs at the system call level to
> allow a console program to identify a process by numeric PID.

No. It is overkill. Ordinary pid interfaces also should be available.
There are a lot of cases, when they are more comfortable. Say, a calling
of process_madvise() from tracer, when a tracee is stopped. In this moment
the tracer knows everything about tracee state, and pidfd brackets
pidfd_open() and close() around actual action look just stupid, and this
is cpu time wasting.

Another example is a parent task, which manages parameters of its children.
It knows everything about them, whether they are alive or not. Pidfd interface
will just utilize additional cpu time here.

So, no. Both interfaces should be available.
