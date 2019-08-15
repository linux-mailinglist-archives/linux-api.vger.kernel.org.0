Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0578E439
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 06:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfHOExj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 00:53:39 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41281 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbfHOExj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 00:53:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TZWJOlV_1565844812;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TZWJOlV_1565844812)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Aug 2019 12:53:36 +0800
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190809083216.GM18351@dhcp22.suse.cz>
 <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
 <20190809180238.GS18351@dhcp22.suse.cz>
 <79c90f6b-fcac-02e1-015a-0eaa4eafdf7d@linux.alibaba.com>
 <564a0860-94f1-6301-5527-5c2272931d8b@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <96bd67c0-e53e-9802-a461-19ce47bba021@linux.alibaba.com>
Date:   Wed, 14 Aug 2019 21:53:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <564a0860-94f1-6301-5527-5c2272931d8b@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 8/14/19 5:49 AM, Vlastimil Babka wrote:
> On 8/9/19 8:26 PM, Yang Shi wrote:
>> Here the new counter is introduced for patch 2/2 to account deferred
>> split THPs into available memory since NR_ANON_THPS may contain
>> non-deferred split THPs.
>>
>> I could use an internal counter for deferred split THPs, but if it is
>> accounted by mod_node_page_state, why not just show it in /proc/meminfo?
> The answer to "Why not" is that it becomes part of userspace API (btw this
> patchset should have CC'd linux-api@ - please do for further iterations) and
> even if the implementation detail of deferred splitting might change in the
> future, we'll basically have to keep the counter (even with 0 value) in
> /proc/meminfo forever.
>
> Also, quite recently we have added the following counter:
>
> KReclaimable: Kernel allocations that the kernel will attempt to reclaim
>                under memory pressure. Includes SReclaimable (below), and other
>                direct allocations with a shrinker.
>
> Although THP allocations are not exactly "kernel allocations", once they are
> unmapped, they are in fact kernel-only, so IMHO it wouldn't be a big stretch to
> add the lazy THP pages there?

Thanks a lot for the suggestion. I agree it may be a good fit. Hope 
"kernel allocations" not cause confusion. But, we can explain in the 
documentation.

>
>> Or we fix NR_ANON_THPS and show deferred split THPs in /proc/meminfo?
>>

