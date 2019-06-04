Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD934337
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFDJc7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 05:32:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:42626 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfFDJc7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 4 Jun 2019 05:32:59 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hY5oE-0001dh-Oe; Tue, 04 Jun 2019 12:32:46 +0300
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <20190522152254.5cyxhjizuwuojlix@box>
 <4228b541-d31c-b76a-2570-1924df0d4724@virtuozzo.com>
 <5ae7e3c1-3875-ea1e-54b3-ac3c493a11f0@virtuozzo.com>
 <20190603174706.t4cby7f5ni4gvvom@box>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c250a53e-dd30-3f10-1c05-e86e4e10358a@virtuozzo.com>
Date:   Tue, 4 Jun 2019 12:32:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603174706.t4cby7f5ni4gvvom@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 03.06.2019 20:47, Kirill A. Shutemov wrote:> On Mon, Jun 03, 2019 at 05:56:32PM +0300, Kirill Tkhai wrote:
>> On 03.06.2019 17:38, Kirill Tkhai wrote:
>>> On 22.05.2019 18:22, Kirill A. Shutemov wrote:
>>>> On Mon, May 20, 2019 at 05:00:01PM +0300, Kirill Tkhai wrote:
>>>>> This patchset adds a new syscall, which makes possible
>>>>> to clone a VMA from a process to current process.
>>>>> The syscall supplements the functionality provided
>>>>> by process_vm_writev() and process_vm_readv() syscalls,
>>>>> and it may be useful in many situation.
>>>>
>>>> Kirill, could you explain how the change affects rmap and how it is safe.
>>>>
>>>> My concern is that the patchset allows to map the same page multiple times
>>>> within one process or even map page allocated by child to the parrent.
>>>
>>> Speaking honestly, we already support this model, since ZERO_PAGE() may
>>> be mapped multiply times in any number of mappings.
>>
>> Picking of huge_zero_page and mremapping its VMA to unaligned address also gives
>> the case, when the same huge page is mapped as huge page and as set of ordinary
>> pages in the same process.
>>
>> Summing up two above cases, is there really a fundamental problem with
>> the functionality the patch set introduces? It looks like we already have
>> these cases in stable kernel supported.
> 
> It *might* work. But it requires a lot of audit to prove that it actually
> *does* work.

Please, give the represent of the way the audit results should look like
for you. In case of I hadn't done some audit before patchset preparing,
I wouldn't have sent it. So, give an idea that you expect from this.

> For instance, are you sure it will not break KSM?

Yes, it does not break KSM. The main point is that in case of KSM we already
may have not just only a page mapped twice in a single process, but even
a page mapped twice in a single VMA. And this is just a particular case of
generic supported set. (Ordinary page still can't be mapped twice in a single
VMA, since pgoff differences won't allow to merge such two hunks together).

The generic rule of ksm is "everything may happen with a page in a real time,
and all of this will be reflected in stable and unstable trees and rmap_items
some time later". Pages of a duplicated VMA will be interpreted as KSM fork,
and the corresponding checks in unstable_tree_search_insert() and
stable_tree_search() provide this.

When both of source and destination VMAs are mergeable,
1)if page was added to stable tree before the duplication of related VMA,
  then during scanning destination VMA in cmp_and_merge_page() it will be
  detected as a duplicate, and we will just add related rmap_item
  to stable node chain;
2)if page was added to unstable tree before the duplication of related VMA,
  and it is remaining there, then the page will be detected as a duplicate
  in destination VMA, and the scan of page will be skipped till next turn;
3)if page was not added to any tree before the duplication, it may be added
  to one of the trees and it will be handled by one of two rules above.

When one of source or destination VMAs is not mergeable, while a page become
PageKsm() during scanning other of them, the unmergeable VMA becomes to refer
to PageKsm(), which does not have rmap_item. But it still possible to unmap
that page from unmergeable VMA, since rmap_walk_ksm() goes over all anon_vma
under rb_root. Just the same as what happens, when process forks, and its
child makes VMA unmergeable.

> What does it mean for memory accounting? memcg?

Once assigned memcg remains the same after VMA duplication. Mapped page range
advances counters in vm_stat_account(). Since we keep fork() semantics,
the same thing occurs as after fork()+mremap().

> My point is that you breaking long standing invariant in Linux MM and it
> has to be properly justified.

I'm not against that. Please, say, which form of the justification you expect.
I assume you do not mean retelling of every string of existing code, because
this way the words will take 10 times more, than the code, and just not human
possible.

Please, give the specific request what you expect, and how this should look like.

> I would expect to see some strange deadlocks or permanent trylock failure
> as result of such change.

Do you hint some specific area? Do you expect I run some specific test cases?
Do you want we add some debugging engine on top of page locking to detect such
the trylock failures?

Thanks,
Kirill
