Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB63C18977B
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2020 09:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgCRI7E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Mar 2020 04:59:04 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27692 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCRI7E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Mar 2020 04:59:04 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200318085900epoutp0495871f4f7c640ae286db1f19e5cc0a41~9Wk9iRz6t1295312953epoutp04a
        for <linux-api@vger.kernel.org>; Wed, 18 Mar 2020 08:59:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200318085900epoutp0495871f4f7c640ae286db1f19e5cc0a41~9Wk9iRz6t1295312953epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584521940;
        bh=8hp0ir/q4A6JVzf2d3zvuRx34xSSf5M6YWyVyROQOYk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=e99U5fAA3CsZykXbBQ0zAUnLWTmTrBvFcK1zthDuQp8iUEldLmM7+Q6GyDmzTCKNr
         2N6MHkkf9KBs9XLxSfyFpKx03jmKflv2WNnoB0ZVexz4fqG4sRnd6prUIKq/AdQFKU
         dPKxJsfUcqsOMQ6M6VlvaBlhdOexZhRrnzPNVKC4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200318085900epcas1p49752c01f1811c2d185fd9c30270ec7a2~9Wk87rUeM1498014980epcas1p4k;
        Wed, 18 Mar 2020 08:59:00 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48j3ql1tzlzMqYlt; Wed, 18 Mar
        2020 08:58:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.C3.04160.3D2E17E5; Wed, 18 Mar 2020 17:58:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200318085858epcas1p444511493e8c9cc67e83ed82fc879ff36~9Wk7hRtNL0093600936epcas1p4t;
        Wed, 18 Mar 2020 08:58:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200318085858epsmtrp186bc86de093ebb1e7b47be6924a5d0e2~9Wk7fWXz90885308853epsmtrp1F;
        Wed, 18 Mar 2020 08:58:58 +0000 (GMT)
X-AuditID: b6c32a38-297ff70000001040-31-5e71e2d39929
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.E0.04158.2D2E17E5; Wed, 18 Mar 2020 17:58:58 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200318085857epsmtip12aa87c451df1609921004458ce2715df~9Wk6hrdFV0789707897epsmtip1m;
        Wed, 18 Mar 2020 08:58:57 +0000 (GMT)
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
To:     Leon Romanovsky <leon@kernel.org>,
        Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, adobriyan@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E71E2CB.4030704@samsung.com>
Date:   Wed, 18 Mar 2020 17:58:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200317143715.GI3351@unreal>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmnu7lR4VxBvNO8FhMb/SymLN+DZtF
        9+aZjBYr9/xgspjyaymzxebvHWwWl3fNYbO4t+Y/q8Wyr+/ZLTa0zGK3eDRhEpPFqbuf2S1m
        N/YxOvB67Jx1l91j06pONo9Nnyaxe9y5tofN48SM3ywe7/ddZfM4s+AIu8fOT5tZPT5vkgvg
        jMqxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6W0mh
        LDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2VoYGBkClSZ
        kJPx8rhhwQqDijVtM1gaGBvUuxg5OSQETCTmrvvK3MXIxSEksINR4nfDXFYI5xOjxOQv85kg
        nG+MEu8adrB3MXKAtdydZAAR38so8eRJBwuE85ZR4vTsNiaQucICthIv/x9gBrFFBLwk9s47
        zAZSxCxwi0ni0pI/7CAJNgFtifcLJrGC2LwCWhLXXn4Ea2ARUJWYcaQTzBYViJDYMfcjI0SN
        oMTJmU9YQGxOoN491+6AxZkF5CWat84Ge0JCYDq7RO/knYwQ37lI7H/wgQnCFpZ4dXwLO4Qt
        JfGyv40doqGZUeLtzM2MEE4Lo8TdTb1Q3cYSvT0XmEGeZhbQlFi/Sx8irCix8/dcqM18Eu++
        9rBCwoVXoqNNCKJETaLl2VdWCFtG4u+/Z1C2h8TuD5fBbCGBHmaJ+7vtJzAqzELy2ywk/8xC
        WLyAkXkVo1hqQXFuemqxYYEJchRvYgSnZC2LHYx7zvkcYhTgYFTi4eXYUBAnxJpYVlyZe4hR
        goNZSYR3cWF+nBBvSmJlVWpRfnxRaU5q8SFGU2BwT2SWEk3OB+aLvJJ4Q1MjY2NjCxMzczNT
        YyVx3qnXc+KEBNITS1KzU1MLUotg+pg4OKUaGHdyRxo7sc/fvWI3m0TU37apjoy/Nl7zirDb
        P/uuWYrmkWxJe8ni+acs7+wR37koaN39/49urHSs9psVEiV5rS6gzanO20Px0t8/E6Karb/4
        SNuamTy799VUbUnKXuHSrZlGMU5pTw+/WDp11jYL7tJ+BQUPS8nfW0+UHLnwYHfyG9dbc4Ky
        9JRYijMSDbWYi4oTAVRsv/zfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnO6lR4VxBnvfqVtMb/SymLN+DZtF
        9+aZjBYr9/xgspjyaymzxebvHWwWl3fNYbO4t+Y/q8Wyr+/ZLTa0zGK3eDRhEpPFqbuf2S1m
        N/YxOvB67Jx1l91j06pONo9Nnyaxe9y5tofN48SM3ywe7/ddZfM4s+AIu8fOT5tZPT5vkgvg
        jOKySUnNySxLLdK3S+DKeHncsGCFQcWathksDYwN6l2MHBwSAiYSdycZdDFycQgJ7GaUONHV
        zt7FyAkUl5F4c/4pC0SNsMThw8UQNa8ZJd7smMcIUiMsYCvx8v8BZhBbRMBLYu+8w2wQRT3M
        Em/PTwRzmAXuMEksv/cZbCqbgLbE+wWTWEFsXgEtiWsvP4J1swioSsw40glmiwpESKxed40Z
        okZQ4uTMJywgNidQ755rd8A2MwuoS/yZd4kZwpaXaN46m3kCo+AsJC2zkJTNQlK2gJF5FaNk
        akFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcJxpae1gPHEi/hCjAAejEg9vwqaCOCHWxLLi
        ytxDjBIczEoivIsL8+OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2C
        yTJxcEo1MCrl3UnbEfty9/vHetdmLV4t1mxRo97qEMLWfTJki7zllO/iM/0UI6SXXtOXOtTZ
        dvXKW++NOjccWVqdlt513Gey1GOlYnO+PhOnVZBSduYE3Qs3Yz5X3T+brio9z/BM5uXCu6vF
        7vrLf6vtuVy7N/8a77ReibQ4N8dVr2qtNJf2/f52MaMhV4mlOCPRUIu5qDgRABY3izGvAgAA
X-CMS-MailID: 20200318085858epcas1p444511493e8c9cc67e83ed82fc879ff36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200311034454epcas1p2ef0c0081971dd82282583559398e58b2
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
        <20200311034441.23243-1-jaewon31.kim@samsung.com>
        <af4ace34-0db2-dd17-351f-eaa806f0a6ac@suse.cz>
        <20200313174827.GA67638@unreal> <5E6EFB6C.7050105@samsung.com>
        <20200316083154.GF8510@unreal>
        <CAJrd-UvttDDSL=q1RXC6Z+jvZAGsN2iM8C8xOSrpJFdLb0e-3g@mail.gmail.com>
        <20200317143715.GI3351@unreal>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2020년 03월 17일 23:37, Leon Romanovsky wrote:
> On Tue, Mar 17, 2020 at 12:04:46PM +0900, Jaewon Kim wrote:
>> 2020년 3월 16일 (월) 오후 5:32, Leon Romanovsky <leon@kernel.org>님이 작성:
>>> On Mon, Mar 16, 2020 at 01:07:08PM +0900, Jaewon Kim wrote:
>>>>
>>>> On 2020년 03월 14일 02:48, Leon Romanovsky wrote:
>>>>> On Fri, Mar 13, 2020 at 04:19:36PM +0100, Vlastimil Babka wrote:
>>>>>> +CC linux-api, please include in future versions as well
>>>>>>
>>>>>> On 3/11/20 4:44 AM, Jaewon Kim wrote:
>>>>>>> /proc/meminfo or show_free_areas does not show full system wide memory
>>>>>>> usage status. There seems to be huge hidden memory especially on
>>>>>>> embedded Android system. Because it usually have some HW IP which do not
>>>>>>> have internal memory and use common DRAM memory.
>>>>>>>
>>>>>>> In Android system, most of those hidden memory seems to be vmalloc pages
>>>>>>> , ion system heap memory, graphics memory, and memory for DRAM based
>>>>>>> compressed swap storage. They may be shown in other node but it seems to
>>>>>>> useful if /proc/meminfo shows all those extra memory information. And
>>>>>>> show_mem also need to print the info in oom situation.
>>>>>>>
>>>>>>> Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
>>>>>>> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
>>>>>>> memory using zsmalloc can be seen through vmstat by commit 91537fee0013
>>>>>>> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
>>>>>>>
>>>>>>> Memory usage of specific driver can be various so that showing the usage
>>>>>>> through upstream meminfo.c is not easy. To print the extra memory usage
>>>>>>> of a driver, introduce following APIs. Each driver needs to count as
>>>>>>> atomic_long_t.
>>>>>>>
>>>>>>> int register_extra_meminfo(atomic_long_t *val, int shift,
>>>>>>>                      const char *name);
>>>>>>> int unregister_extra_meminfo(atomic_long_t *val);
>>>>>>>
>>>>>>> Currently register ION system heap allocator and zsmalloc pages.
>>>>>>> Additionally tested on local graphics driver.
>>>>>>>
>>>>>>> i.e) cat /proc/meminfo | tail -3
>>>>>>> IonSystemHeap:    242620 kB
>>>>>>> ZsPages:          203860 kB
>>>>>>> GraphicDriver:    196576 kB
>>>>>>>
>>>>>>> i.e.) show_mem on oom
>>>>>>> <6>[  420.856428]  Mem-Info:
>>>>>>> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
>>>>>>> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
>>>>>> I like the idea and the dynamic nature of this, so that drivers not present
>>>>>> wouldn't add lots of useless zeroes to the output.
>>>>>> It also makes simpler the decisions of "what is important enough to need its own
>>>>>> meminfo entry".
>>>>>>
>>>>>> The suggestion for hunting per-driver /sys files would only work if there was a
>>>>>> common name to such files so once can find(1) them easily.
>>>>>> It also doesn't work for the oom/failed alloc warning output.
>>>>> Of course there is a need to have a stable name for such an output, this
>>>>> is why driver/core should be responsible for that and not drivers authors.
>>>>>
>>>>> The use case which I had in mind slightly different than to look after OOM.
>>>>>
>>>>> I'm interested to optimize our drivers in their memory footprint to
>>>>> allow better scale in SR-IOV mode where one device creates many separate
>>>>> copies of itself. Those copies easily can take gigabytes of RAM due to
>>>>> the need to optimize for high-performance networking. Sometimes the
>>>>> amount of memory and not HW is actually limits the scale factor.
>>>>>
>>>>> So I would imagine this feature being used as an aid for the driver
>>>>> developers and not for the runtime decisions.
>>>>>
>>>>> My 2-cents.
>>>>>
>>>>> Thanks
>>>>>
>>>>>
>>>> Thank you for your comment.
>>>> My idea, I think, may be able to help each driver developer to see their memory usage.
>>>> But I'd like to see overall memory usage through the one node.
>>> It is more than enough :).
>>>
>>>> Let me know if you have more comment.
>>>> I am planning to move my logic to be shown on a new node, /proc/meminfo_extra at v2.
>>> Can you please help me to understand how that file will look like once
>>> many drivers will start to use this interface? Will I see multiple
>>> lines?
>>>
>>> Something like:
>>> driver1 ....
>>> driver2 ....
>>> driver3 ....
>>> ...
>>> driver1000 ....
>>>
>>> How can we extend it to support subsystems core code?
>> I do not have a plan to support subsystem core.
> Fair enough.
>
>> I just want the /proc/meminfo_extra to show size of alloc_pages APIs
>> rather than slub size. It is to show hidden huge memory.
>> I think most of drivers do not need to register its size to
>> /proc/meminfo_extra because
>> drivers usually use slub APIs and rather than alloc_pages APIs.
>> /proc/slabinfo helps for slub size in detail.
> The problem with this statement that the drivers that consuming memory
> are the ones who are interested in this interface. I can be not accurate
> here, but I think that all RDMA and major NICs will want to get this
> information.
>
> On my machine, it is something like 6 devices.
>
>> As a candidate of /proc/meminfo_extra, I hope only few drivers using
>> huge memory like over 100 MB got from alloc_pages APIs.
>>
>> As you say, if there is a static node on /sys for each driver, it may
>> be used for all the drivers.
>> I think sysfs class way may be better to show categorized sum size.
>> But /proc/meminfo_extra can be another way to show those hidden huge memory.
>> I mean your idea and my idea is not exclusive.
> It is just better to have one interface.
Sorry about that one interface.

If we need to create a-meminfo_extra-like node on /sysfs, then
I think further discussion with more people is needed.
If there is no logical problem on creating /proc/meminfo_extra,
I'd like to prepare v2 patch and get more comment on that v2
patch. Please help again for further discussion.

Thank you
>
>> Thank you
>>> Thanks
>>>
>>>> Thank you
>>>> Jaewon Kim
>

