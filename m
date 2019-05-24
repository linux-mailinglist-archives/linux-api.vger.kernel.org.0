Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5B29642
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2019 12:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390410AbfEXKp5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 May 2019 06:45:57 -0400
Received: from relay.sw.ru ([185.231.240.75]:56562 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389448AbfEXKp4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 24 May 2019 06:45:56 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hU7hv-00060o-CJ; Fri, 24 May 2019 13:45:51 +0300
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
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <358bb95e-0dca-6a82-db39-83c0cf09a06c@virtuozzo.com>
Date:   Fri, 24 May 2019 13:45:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522152254.5cyxhjizuwuojlix@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 22.05.2019 18:22, Kirill A. Shutemov wrote:
> On Mon, May 20, 2019 at 05:00:01PM +0300, Kirill Tkhai wrote:
>> This patchset adds a new syscall, which makes possible
>> to clone a VMA from a process to current process.
>> The syscall supplements the functionality provided
>> by process_vm_writev() and process_vm_readv() syscalls,
>> and it may be useful in many situation.
> 
> Kirill, could you explain how the change affects rmap and how it is safe.
> 
> My concern is that the patchset allows to map the same page multiple times
> within one process or even map page allocated by child to the parrent.
> 
> It was not allowed before.
> 
> In the best case it makes reasoning about rmap substantially more difficult.
> 
> But I'm worry it will introduce hard-to-debug bugs, like described in
> https://lwn.net/Articles/383162/.

Andy suggested to unmap PTEs from source page table, and this make the single
page never be mapped in the same process twice. This is OK for my use case,
and here we will just do a small step "allow to inherit VMA by a child process",
which we didn't have before this. If someone still needs to continue the work
to allow the same page be mapped twice in a single process in the future, this
person will have a supported basis we do in this small step. I believe, someone
like debugger may want to have this to make a fast snapshot of a process private
memory (when the task is stopped for a small time to get its memory). But for
me remapping is enough at the moment.

What do you think about this?

[...]

Kirill
