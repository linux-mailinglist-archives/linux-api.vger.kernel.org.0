Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198CC83E8C
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2019 02:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfHGA6K (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Aug 2019 20:58:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbfHGA6J (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 6 Aug 2019 20:58:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 91ABC144364FA1DEF3CB;
        Wed,  7 Aug 2019 08:58:07 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 08:58:03 +0800
Subject: Re: [PATCH] mm/mempolicy.c: Remove unnecessary nodemask check in
 kernel_migrate_pages()
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
References: <20190806023634.55356-1-wangkefeng.wang@huawei.com>
 <80f8da83-f425-1aab-f47e-8da41ec6dcbf@suse.cz>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <34880869-49a1-86c6-9345-2a01da7fbb9b@huawei.com>
Date:   Wed, 7 Aug 2019 08:58:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <80f8da83-f425-1aab-f47e-8da41ec6dcbf@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2019/8/6 16:36, Vlastimil Babka wrote:
> On 8/6/19 4:36 AM, Kefeng Wang wrote:
[...]
>>
>> [QUESTION]
>>
>> SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned long, maxnode,
>>                 const unsigned long __user *, old_nodes,
>>                 const unsigned long __user *, new_nodes)
>> {
>>         return kernel_migrate_pages(pid, maxnode, old_nodes, new_nodes);
>> }
>>
>> The migrate_pages() takes pid argument, witch is the ID of the process
>> whose pages are to be moved. should the cpuset_mems_allowed(current) be
>> cpuset_mems_allowed(task)?
> 
> The check for cpuset_mems_allowed(task) is just above the code you change, so
> the new nodes have to be subset of the target task's cpuset.
> But they also have to be allowed by the calling task's cpuset. In manpage of
> migrate_pages(2), this is hinted by the NOTES "Use get_mempolicy(2) with the
> MPOL_F_MEMS_ALLOWED flag to obtain the set of nodes that are allowed by the
> calling process's cpuset..."
> 
> But perhaps the manpage should be better clarified:
> 
> - the EINVAL case includes "Or, none of the node IDs specified by new_nodes are
> on-line and allowed by the process's current cpuset context, or none of the
> specified nodes contain memory." - this should probably say "calling process" to
> disambiguate
> - the EPERM case should mention that new_nodes have to be subset of the target
> process' cpuset context. The caller should also have CAP_SYS_NICE and
> ptrace_may_access()

Get it, thanks for your detail explanation.

> 


