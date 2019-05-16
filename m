Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12342208BC
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfEPN5E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 09:57:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:54072 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfEPN5E (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 16 May 2019 09:57:04 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hRGsK-00075H-1m; Thu, 16 May 2019 16:56:48 +0300
Subject: Re: [PATCH RFC 0/5] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, keith.busch@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        pasha.tatashin@oracle.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        ira.weiny@intel.com, Andrey Konovalov <andreyknvl@google.com>,
        arunks@codeaurora.org, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>, hannes@cmpxchg.org,
        npiggin@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        daniel.m.jordan@oracle.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
 <CAG48ez3EOwLd8A6Ku53vKLdofmZAh1ZYfkK4rVgSgM8ZfcR4zg@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <89124a45-ddfd-9c96-1957-304f67d4b9bc@virtuozzo.com>
Date:   Thu, 16 May 2019 16:56:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3EOwLd8A6Ku53vKLdofmZAh1ZYfkK4rVgSgM8ZfcR4zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 16.05.2019 16:32, Jann Horn wrote:
> On Wed, May 15, 2019 at 5:11 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> This patchset adds a new syscall, which makes possible
>> to clone a mapping from a process to another process.
>> The syscall supplements the functionality provided
>> by process_vm_writev() and process_vm_readv() syscalls,
>> and it may be useful in many situation.
> [...]
>> The proposed syscall aims to introduce an interface, which
>> supplements currently existing process_vm_writev() and
>> process_vm_readv(), and allows to solve the problem with
>> anonymous memory transfer. The above example may be rewritten as:
>>
>>         void *buf;
>>
>>         buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
>>                    MAP_PRIVATE|MAP_ANONYMOUS, ...);
>>         recv(sock, buf, n * PAGE_SIZE, 0);
>>
>>         /* Sign of @pid is direction: "from @pid task to current" or vice versa. */
>>         process_vm_mmap(-pid, buf, n * PAGE_SIZE, remote_addr, PVMMAP_FIXED);
>>         munmap(buf, n * PAGE_SIZE);
> 
> In this specific example, an alternative would be to splice() from the
> socket into /proc/$pid/mem, or something like that, right?
> proc_mem_operations has no ->splice_read() at the moment, and it'd
> need that to be more efficient, but that could be built without
> creating new UAPI, right?

I have just never seen, a socket memory may be preempted into swap.
If so, there is a fundamental problem.
But, anyway, like you guessed below:
 
> But I guess maybe your workload is not that simple? What do you
> actually do with the received data between receiving it and shoving it
> over into the other process?

Data are usually sent encrypted and compressed by socket, so there is no
possibility to go this way. You may want to do everything with data,
before passing to another process.

Kirill
