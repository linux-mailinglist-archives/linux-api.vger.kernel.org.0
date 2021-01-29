Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5B3088B7
	for <lists+linux-api@lfdr.de>; Fri, 29 Jan 2021 12:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhA2L7H (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 Jan 2021 06:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232937AbhA2L5M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 Jan 2021 06:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611921117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUEN6UTfn53/wX/SEJGh22PWSC8cNFCZ2DPJVW+i4jI=;
        b=ZrFUrmaZe+5+2+HY2Ln4cEJ6W4M5NE7MXsxNX5CBmcGgiGwc7dbWwTm9M+YK6Mvg4PzsP8
        QJek2ukVaP8OT6FzTRU6f5SkZVMPDpCOEp7ncOeyda7SmlM3MLdPCb8ArtE5qmtegWs2vt
        kr2fxRwYAu+2xVabHLtaQCilWZojdDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-OKAhZr8FNw2cV8zOqtPwZg-1; Fri, 29 Jan 2021 06:51:55 -0500
X-MC-Unique: OKAhZr8FNw2cV8zOqtPwZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFB14814417;
        Fri, 29 Jan 2021 11:51:53 +0000 (UTC)
Received: from [10.36.113.219] (ovpn-113-219.ams2.redhat.com [10.36.113.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76A2E5D9C0;
        Fri, 29 Jan 2021 11:51:51 +0000 (UTC)
Subject: Re: [PATCH v3] mm/page_alloc: count CMA pages per zone and print them
 in /proc/zoneinfo
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
References: <20210127101813.6370-3-david@redhat.com>
 <20210129113451.22085-1-david@redhat.com> <20210129114624.GA25391@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8d7fc7f5-58b0-301a-1055-beb0df86b536@redhat.com>
Date:   Fri, 29 Jan 2021 12:51:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210129114624.GA25391@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 29.01.21 12:46, Oscar Salvador wrote:
> On Fri, Jan 29, 2021 at 12:34:51PM +0100, David Hildenbrand wrote:
>> Let's count the number of CMA pages per zone and print them in
>> /proc/zoneinfo.
>>
>> Having access to the total number of CMA pages per zone is helpful for
>> debugging purposes to know where exactly the CMA pages ended up, and to
>> figure out how many pages of a zone might behave differently, even after
>> some of these pages might already have been allocated.
>>
>> As one example, CMA pages part of a kernel zone cannot be used for
>> ordinary kernel allocations but instead behave more like ZONE_MOVABLE.
>>
>> For now, we are only able to get the global nr+free cma pages from
>> /proc/meminfo and the free cma pages per zone from /proc/zoneinfo.
>>
>> Example after this patch when booting a 6 GiB QEMU VM with
>> "hugetlb_cma=2G":
>>    # cat /proc/zoneinfo | grep cma
>>            cma      0
>>          nr_free_cma  0
>>            cma      0
>>          nr_free_cma  0
>>            cma      524288
>>          nr_free_cma  493016
>>            cma      0
>>            cma      0
>>    # cat /proc/meminfo | grep Cma
>>    CmaTotal:        2097152 kB
>>    CmaFree:         1972064 kB
>>
>> Note: We print even without CONFIG_CMA, just like "nr_free_cma"; this way,
>>        one can be sure when spotting "cma 0", that there are definetly no
>>        CMA pages located in a zone.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: linux-api@vger.kernel.org
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Looks good to me, I guess it is better to print it unconditionally
> so the layout does not change.
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks for the fast review!


-- 
Thanks,

David / dhildenb

