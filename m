Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C753A312F3C
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhBHKlN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Feb 2021 05:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232391AbhBHKjH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 05:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612780658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQkWudR5NaqUhP785ZyYy4UYb1aBaulu3BBFzJEhpos=;
        b=MjCL8JNdaKUO5dP0n3re4TrFl/exSAbBtSaeilXyBpjEY3Y89Ti0uTC+eKmeUbH1BJYjav
        irKavMIAL9XFXhJ3LV1CFzMoMFa/VuA7hPuGfog9zUPk2yEPJzNyjdNOQjywMdknt+Bad3
        GLvcHOx5j27os1xoDlEQKdjyMekTK9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-wUgzenNPNBuCRVrN4cVAXQ-1; Mon, 08 Feb 2021 05:37:34 -0500
X-MC-Unique: wUgzenNPNBuCRVrN4cVAXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6815019611AF;
        Mon,  8 Feb 2021 10:37:32 +0000 (UTC)
Received: from [10.36.113.240] (ovpn-113-240.ams2.redhat.com [10.36.113.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 972F51ABE1;
        Mon,  8 Feb 2021 10:37:24 +0000 (UTC)
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
 <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
 <20210208013056.GM308988@casper.infradead.org>
 <b4e2acc237e44ffe916135e96ad3ef20@hisilicon.com>
 <beb4dfb5-e9d2-a76c-f965-28cff5e4658b@redhat.com>
 <fdee54b5ab91453d93d2f775ca2532d2@hisilicon.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bbe18536-7048-d790-11bf-0b0742a59926@redhat.com>
Date:   Mon, 8 Feb 2021 11:37:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <fdee54b5ab91453d93d2f775ca2532d2@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 08.02.21 11:13, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of
>> David Hildenbrand
>> Sent: Monday, February 8, 2021 9:22 PM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Matthew Wilcox
>> <willy@infradead.org>
>> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
>> iommu@lists.linux-foundation.org; linux-mm@kvack.org;
>> linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
>> Morton <akpm@linux-foundation.org>; Alexander Viro <viro@zeniv.linux.org.uk>;
>> gregkh@linuxfoundation.org; jgg@ziepe.ca; kevin.tian@intel.com;
>> jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
>> <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
>> <chensihang1@hisilicon.com>
>> Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
>> pin
>>
>> On 08.02.21 03:27, Song Bao Hua (Barry Song) wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf
>> Of
>>>> Matthew Wilcox
>>>> Sent: Monday, February 8, 2021 2:31 PM
>>>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
>>>> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
>>>> iommu@lists.linux-foundation.org; linux-mm@kvack.org;
>>>> linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
>>>> Morton <akpm@linux-foundation.org>; Alexander Viro
>> <viro@zeniv.linux.org.uk>;
>>>> gregkh@linuxfoundation.org; jgg@ziepe.ca; kevin.tian@intel.com;
>>>> jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
>>>> <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
>>>> <chensihang1@hisilicon.com>
>>>> Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
>>>> pin
>>>>
>>>> On Sun, Feb 07, 2021 at 10:24:28PM +0000, Song Bao Hua (Barry Song) wrote:
>>>>>>> In high-performance I/O cases, accelerators might want to perform
>>>>>>> I/O on a memory without IO page faults which can result in dramatically
>>>>>>> increased latency. Current memory related APIs could not achieve this
>>>>>>> requirement, e.g. mlock can only avoid memory to swap to backup device,
>>>>>>> page migration can still trigger IO page fault.
>>>>>>
>>>>>> Well ... we have two requirements.  The application wants to not take
>>>>>> page faults.  The system wants to move the application to a different
>>>>>> NUMA node in order to optimise overall performance.  Why should the
>>>>>> application's desires take precedence over the kernel's desires?  And why
>>>>>> should it be done this way rather than by the sysadmin using numactl to
>>>>>> lock the application to a particular node?
>>>>>
>>>>> NUMA balancer is just one of many reasons for page migration. Even one
>>>>> simple alloc_pages() can cause memory migration in just single NUMA
>>>>> node or UMA system.
>>>>>
>>>>> The other reasons for page migration include but are not limited to:
>>>>> * memory move due to CMA
>>>>> * memory move due to huge pages creation
>>>>>
>>>>> Hardly we can ask users to disable the COMPACTION, CMA and Huge Page
>>>>> in the whole system.
>>>>
>>>> You're dodging the question.  Should the CMA allocation fail because
>>>> another application is using SVA?
>>>>
>>>> I would say no.
>>>
>>> I would say no as well.
>>>
>>> While IOMMU is enabled, CMA almost has one user only: IOMMU driver
>>> as other drivers will depend on iommu to use non-contiguous memory
>>> though they are still calling dma_alloc_coherent().
>>>
>>> In iommu driver, dma_alloc_coherent is called during initialization
>>> and there is no new allocation afterwards. So it wouldn't cause
>>> runtime impact on SVA performance. Even there is new allocations,
>>> CMA will fall back to general alloc_pages() and iommu drivers are
>>> almost allocating small memory for command queues.
>>>
>>> So I would say general compound pages, huge pages, especially
>>> transparent huge pages, would be bigger concerns than CMA for
>>> internal page migration within one NUMA.
>>>
>>> Not like CMA, general alloc_pages() can get memory by moving
>>> pages other than those pinned.
>>>
>>> And there is no guarantee we can always bind the memory of
>>> SVA applications to single one NUMA, so NUMA balancing is
>>> still a concern.
>>>
>>> But I agree we need a way to make CMA success while the userspace
>>> pages are pinned. Since pin has been viral in many drivers, I
>>> assume there is a way to handle this. Otherwise, APIs like
>>> V4L2_MEMORY_USERPTR[1] will possibly make CMA fail as there
>>> is no guarantee that usersspace will allocate unmovable memory
>>> and there is no guarantee the fallback path- alloc_pages() can
>>> succeed while allocating big memory.
>>>
>>
>> Long term pinnings cannot go onto CMA-reserved memory, and there is
>> similar work to also fix ZONE_MOVABLE in that regard.
>>
>> https://lkml.kernel.org/r/20210125194751.1275316-1-pasha.tatashin@soleen.c
>> om
>>
>> One of the reasons I detest using long term pinning of pages where it
>> could be avoided. Take VFIO and RDMA as an example: these things
>> currently can't work without them.
>>
>> What I read here: "DMA performance will be affected severely". That does
>> not sound like a compelling argument to me for long term pinnings.
>> Please find another way to achieve the same goal without long term
>> pinnings controlled by user space - e.g., controlling when migration
>> actually happens.
>>
>> For example, CMA/alloc_contig_range()/memory unplug are corner cases
>> that happen rarely, you shouldn't have to worry about them messing with
>> your DMA performance.
> 
> I agree CMA/alloc_contig_range()/memory unplug would be corner cases,
> the major cases would be THP, NUMA balancing while we could totally
> disable them but it seems insensible to do that only because there is
> a process using SVA in the system.

Can't you use huge pages in your application that uses SVA and prevent 
THP/NUMA balancing from kicking in?

-- 
Thanks,

David / dhildenb

