Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6D295EC
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2019 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390274AbfEXKgY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 May 2019 06:36:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:56218 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389448AbfEXKgY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 24 May 2019 06:36:24 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hU7YU-0005xE-Bo; Fri, 24 May 2019 13:36:06 +0300
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
To:     Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        alexander.h.duyck@linux.intel.com, Weiny Ira <ira.weiny@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        arunks@codeaurora.org, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        daniel.m.jordan@oracle.com, Jann Horn <jannh@google.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com>
 <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com>
 <CALCETrUMDTGRtLFocw6vnN___7rkb6r82ULehs0=yQO5PZL8MA@mail.gmail.com>
 <67d1321e-ffd6-24a3-407f-cd26c82e46b8@virtuozzo.com>
 <CALCETrWzuH3=Uh91UeGwpCj28kjQ82Lj2OTuXm7_3d871PyZSA@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <58ad677d-677f-5e16-ecf9-565fcc3b7145@virtuozzo.com>
Date:   Fri, 24 May 2019 13:36:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWzuH3=Uh91UeGwpCj28kjQ82Lj2OTuXm7_3d871PyZSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 23.05.2019 19:19, Andy Lutomirski wrote:
> On Tue, May 21, 2019 at 10:44 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 21.05.2019 19:43, Andy Lutomirski wrote:
>>> On Tue, May 21, 2019 at 8:52 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>
>>>> On 21.05.2019 17:43, Andy Lutomirski wrote:
> 
>>> Do you mean that the code you sent rejects this case?  If so, please
>>> document it.  In any case, I looked at the code, and it seems to be
>>> trying to handle MAP_SHARED and MAP_ANONYMOUS.  I don't see where it
>>> would reject copying a vDSO.
>>
>> I prohibit all the VMAs, which contain on of flags: VM_HUGETLB|VM_DONTEXPAND|VM_PFNMAP|VM_IO.
>> I'll check carefully, whether it's enough for vDSO.
> 
> I think you could make the new syscall a lot more comprehensible bg
> restricting it to just MAP_ANONYMOUS, by making it unmap the source,
> or possibly both.  If the new syscall unmaps the source (in order so
> that the source is gone before the newly mapped pages become
> accessible), then you avoid issues in which you need to define
> sensible semantics for what happens if both copies are accessed
> simultaneously.

In case of we unmap source, this does not introduce a new principal
behavior with the same page mapped twice in a single process like
Kirill pointed. This sounds as a good idea and this covers my
application area.

The only new principal thing is a child process will be able to inherit
a parent's VMA, which is not possible now. But it looks like we never
depend on processes relationship in the mapping code, and process
reparenting already gives many combinations, so the new change should
not affect much on this.

Kirill
