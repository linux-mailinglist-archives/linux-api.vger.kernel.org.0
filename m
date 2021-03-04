Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3382132D135
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 11:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhCDKxT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Mar 2021 05:53:19 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:53731 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239055AbhCDKxJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Mar 2021 05:53:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UQPRg.5_1614855144;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UQPRg.5_1614855144)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Mar 2021 18:52:25 +0800
Subject: Re: [RFC] Hugepage collapse in process context
To:     David Rientjes <rientjes@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Chris Kennelly <ckennelly@google.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
 <YCzSDPbBsksCX5zP@dhcp22.suse.cz>
 <0b51a213-650e-7801-b6ed-9545466c15db@suse.cz>
 <600ee57f-d839-d402-fb0f-e9f350114dce@redhat.com>
 <5127b9c-a147-8ef5-c942-ae8c755413d0@google.com>
 <25d9347b-9359-efab-e1e3-f98bd0012af9@linux.alibaba.com>
 <544df052-f9f3-f068-f69e-343cc69d994b@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b289ea7b-a4f8-824e-d4b2-1b69079f5f5f@linux.alibaba.com>
Date:   Thu, 4 Mar 2021 18:52:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <544df052-f9f3-f068-f69e-343cc69d994b@google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



ÔÚ 2021/3/2 ÉÏÎç4:56, David Rientjes Ð´µÀ:
> On Wed, 24 Feb 2021, Alex Shi wrote:
> 
>>> Agreed, and happy to see that there's a general consensus for the 
>>> direction.  Benefit of a new madvise mode is that it can be used for 
>>> madvise() as well if you are interested in only a single range of your own 
>>> memory and then it doesn't need to reconcile with any of the already 
>>> overloaded semantics of MADV_HUGEPAGE.
>>
>> It's a good idea to let process deal with its own THP policy.
>> but current applications will miss the benefit w/o changes, and change is
>> expensive for end users. So except this work, may a per memcg collapse benefit
>> apps and free for them, we often deploy apps in cgroups on server now.
>>
> 
> Hi Alex,
> 
> I'm not sure that I understand: this MADV_COLLAPSE would be possible for 
> process_madvise() as well and by passing a vectored set of ranges so a 
> process can do this on behalf of other processes (it's the only way that 
> we could theoretically move khugepaged to userspace, although that's not 
> an explicit end goal).
> 

Forgive my stupidity, I still can't figure out how process_madvise caller
fill the iovec of other's on a common system. 

> 
> How would you see this working with memcg involved?  I had thought this 
> was entirely orthogonal to any cgroup.
> 

You'r right, it's out of cgroup and better. per cgroup khugepaged could be
a alternative way. but it require a cgroup and not specific on target process.

Thanks
Alex
 
