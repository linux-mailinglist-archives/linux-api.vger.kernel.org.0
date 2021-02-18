Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28F831EC5C
	for <lists+linux-api@lfdr.de>; Thu, 18 Feb 2021 17:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhBRQft (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Feb 2021 11:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232235AbhBRN5z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Feb 2021 08:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613656588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMl80mulEM7CQ/sWAw4ntJBldXaWIego0BbdzCYFKpA=;
        b=W+794DLl9PpP9tjh8ifQmVl5GlRmjR6OJcc15pYEMbwmZb67OxVMDKidinQdC3g27rTyWl
        C6Ne4Kc5tDSU1iRrRfoPz9XyBSz+7i9oixjtK6rwnYF7MVJIpWjUaf7O4RSx0Wk7fb348k
        P3x842ebyvOuTNpkI5acO8itVYTzAO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-UEHfHncfPauxdax8GZ6qlg-1; Thu, 18 Feb 2021 08:52:53 -0500
X-MC-Unique: UEHfHncfPauxdax8GZ6qlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27CD79128E;
        Thu, 18 Feb 2021 13:52:51 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D502D6F98F;
        Thu, 18 Feb 2021 13:52:36 +0000 (UTC)
Subject: Re: [RFC] Hugepage collapse in process context
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <600ee57f-d839-d402-fb0f-e9f350114dce@redhat.com>
Date:   Thu, 18 Feb 2021 14:52:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <0b51a213-650e-7801-b6ed-9545466c15db@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 18.02.21 14:43, Vlastimil Babka wrote:
> On 2/17/21 9:21 AM, Michal Hocko wrote:
>> [Cc linux-api]
>>
>> On Tue 16-02-21 20:24:16, David Rientjes wrote:
>>> Hi everybody,
>>>
>>> Khugepaged is slow by default, it scans at most 4096 pages every 10s.
>>> That's normally fine as a system-wide setting, but some applications would
>>> benefit from a more aggressive approach (as long as they are willing to
>>> pay for it).
>>>
>>> Instead of adding priorities for eligible ranges of memory to khugepaged,
>>> temporarily speeding khugepaged up for the whole system, or sharding its
>>> work for memory belonging to a certain process, one approach would be to
>>> allow userspace to induce hugepage collapse.
>>>
>>> The benefit to this approach would be that this is done in process context
>>> so its cpu is charged to the process that is inducing the collapse.
>>> Khugepaged is not involved.
>>
>> Yes, this makes a lot of sense to me.
>>
>>> Idea was to allow userspace to induce hugepage collapse through the new
>>> process_madvise() call.  This allows us to collapse hugepages on behalf of
>>> current or another process for a vectored set of ranges.
>>
>> Yes, madvise sounds like a good fit for the purpose.
> 
> Agreed on both points.
> 
>>> This could be done through a new process_madvise() mode *or* it could be a
>>> flag to MADV_HUGEPAGE since process_madvise() allows for a flag parameter
>>> to be passed.  For example, MADV_F_SYNC.
>>
>> Would this MADV_F_SYNC be applicable to other madvise modes? Most
>> existing madvise modes do not seem to make much sense. We can argue that
>> MADV_PAGEOUT would guarantee the range was indeed reclaimed but I am not
>> sure we want to provide such a strong semantic because it can limit
>> future reclaim optimizations.
>>
>> To me MADV_HUGEPAGE_COLLAPSE sounds like the easiest way forward.
> 
> I guess in the old madvise(2) we could create a new combo of MADV_HUGEPAGE |
> MADV_WILLNEED with this semantic? But you are probably more interested in
> process_madvise() anyway. There the new flag would make more sense. But there's
> also David H.'s proposal for MADV_POPULATE and there might be benefit in
> considering both at the same time? Should e.g. MADV_POPULATE with MADV_HUGEPAGE
> have the collapse semantics? But would MADV_POPULATE be added to
> process_madvise() as well? Just thinking out loud so we don't end up with more
> flags than necessary, it's already confusing enough as it is.
> 

Note that madvise() eats only a single value, not flags. Combinations as 
you describe are not possible.

Something MADV_HUGEPAGE_COLLAPSE make sense to me that does not need the 
mmap lock in write and does not modify the actual VMA, only a mapping.

-- 
Thanks,

David / dhildenb

