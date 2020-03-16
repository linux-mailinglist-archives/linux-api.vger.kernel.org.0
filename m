Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA3186405
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2020 05:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgCPEHV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Mar 2020 00:07:21 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:54018 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgCPEHU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Mar 2020 00:07:20 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200316040718epoutp04675090573351c37e388fe9119a326718~8rTsZCWXj1296112961epoutp04P
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2020 04:07:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200316040718epoutp04675090573351c37e388fe9119a326718~8rTsZCWXj1296112961epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584331638;
        bh=d/RUH2DnI9bnLtOMlJoIQfdWKOD4LySjodtnFlva8jQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=avmg36esx9qcAnqupfRIid4DfMK5c++LCpOxslb0Mbc6UxsPeTGuJkP6fi7lcIGmr
         Jtze8pM26j62WMJCqr6WxMZV62fj19xlL7K7WesG8YtQNRmMzjGidxaWyrtMpaw07i
         OBiQ+04ewYhaJIWSCE0wUAR3QrkJh8hSfCX4jnlo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200316040717epcas1p37e0ea434b3d3a625758d6344cdf6262c~8rTsBP5n_2125321253epcas1p3T;
        Mon, 16 Mar 2020 04:07:17 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48gjS46QXnzMqYm3; Mon, 16 Mar
        2020 04:07:16 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.E5.04160.47BFE6E5; Mon, 16 Mar 2020 13:07:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200316040716epcas1p3a16c3c333b74923a596f66fae5f28621~8rTqpmFmP2836328363epcas1p3k;
        Mon, 16 Mar 2020 04:07:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200316040716epsmtrp1b021eecc8cca1bfb7a3507db2f928c21~8rTqm6sXH3093330933epsmtrp1d;
        Mon, 16 Mar 2020 04:07:16 +0000 (GMT)
X-AuditID: b6c32a38-297ff70000001040-28-5e6efb74fa80
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.A2.04158.47BFE6E5; Mon, 16 Mar 2020 13:07:16 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200316040714epsmtip2ed6746f17217020b1ce28bfd4334b2c2~8rTpJFgM52540325403epsmtip2o;
        Mon, 16 Mar 2020 04:07:14 +0000 (GMT)
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
To:     Leon Romanovsky <leon@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        Linux API <linux-api@vger.kernel.org>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E6EFB6C.7050105@samsung.com>
Date:   Mon, 16 Mar 2020 13:07:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200313174827.GA67638@unreal>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmnm7J77w4g48njCymN3pZzFm/hs2i
        e/NMRouVe34wWUz5tZTZYvP3DjaLy7vmsFncW/Of1WLZ1/fsFhtaZrFbPJowicni1N3P7Baz
        G/sYHXg9ds66y+6xaVUnm8emT5PYPe5c28PmcWLGbxaP9/uusnmcWXCE3WPnp82sHp83yQVw
        RuXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdraRQ
        lphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0MDAyBapM
        yMn4v2kBS8FymYp7bV8YGxgfiXUxcnJICJhIPOw4zgRiCwnsYJQ41gUU5wKyPzFKbO39xArh
        fGOUOLxzHhtMx7zGiewQib2MEg+PH2eGcN4ySnxY8oAVpEpYwFbi5f8DQAkODhEBd4m1X4xA
        wswCi5gkWmeGg9hsAtoS7xdMAivnFdCSmPq1lQXEZhFQlfg6fxk7iC0qECGxY+5HRogaQYmT
        M5+wgIzkFNCRWDiTFWKkvETz1tlgJ0gILGKX6Py4lRniUBeJ1cvWQNnCEq+Ob2GHsKUkXva3
        sUM0NDNKvJ25mRHCaWGUuLuplxGiyliit+cC2APMApoS63fpQ4QVJXb+nssIsZlP4t3XHlaQ
        EgkBXomONiGIEjWJlmdfWSFsGYm//55B2R4Suz9choboE0aJS3/PsU1gVJiF5LdZSB6ahbB5
        ASPzKkax1ILi3PTUYsMCE+QY3sQITshaFjsY95zzOcQowMGoxMMrkZYXJ8SaWFZcmXuIUYKD
        WUmEt6MmO06INyWxsiq1KD++qDQntfgQoykwuCcyS4km5wOzRV5JvKGpkbGxsYWJmbmZqbGS
        OO/U6zlxQgLpiSWp2ampBalFMH1MHJxSDYzqelOKD7jMZP2ao7u9fl7G0118Mea2pj3Pv3z8
        cUB+8j0Rdc0Qsfd+DYeXFUVrFjnFlnkkbeZ9ulDW8E5X3P+Lc5wk4qbn1p42rpt2cMmpAsea
        Y3vUv3xvtXC7/Tlp3bzDNpeMP/aH6/fOYExo1rQwfLdd2OvKovq7fL+52Mo+3l/sJVzkHKDE
        UpyRaKjFXFScCABb9mYV3gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvG7J77w4g7fHBSymN3pZzFm/hs2i
        e/NMRouVe34wWUz5tZTZYvP3DjaLy7vmsFncW/Of1WLZ1/fsFhtaZrFbPJowicni1N3P7Baz
        G/sYHXg9ds66y+6xaVUnm8emT5PYPe5c28PmcWLGbxaP9/uusnmcWXCE3WPnp82sHp83yQVw
        RnHZpKTmZJalFunbJXBl/N+0gKVguUzFvbYvjA2Mj8S6GDk5JARMJOY1TmTvYuTiEBLYzShx
        9d4FRoiEjMSb809Zuhg5gGxhicOHiyFqXjNKXHk4lx2kRljAVuLl/wPMIDUiAu4Sa78YQdQ8
        YZTY92ozE4jDLLCISeJm+3Q2kAY2AW2J9wsmsYLYvAJaElO/trKA2CwCqhJf5y8DGyoqECGx
        et01ZogaQYmTM5+AHcEpoCOxcCYriMksoC6xfp4QSAWzgLxE89bZzBMYBWchaZiFUDULSdUC
        RuZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBMaaltYPxxIn4Q4wCHIxKPLwSaXlx
        QqyJZcWVuYcYJTiYlUR4O2qy44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1O
        TS1ILYLJMnFwSjUw+mdbJ5gXPz09RX3aSUXJRSr91UzztFX3Vs/b7dnpcVBljtq0H0xx5pPs
        Eoo448J1P04LPe8Yx7F7jaGk48+ynQsNW98GKwZ1TPTymRD0clHjlaOy91wdl2Vs55FuMNGc
        emfHn5W6/rsZ775vufcx9Nb7nrvHhPXePrTYeue7pJ70cZN8N5lmJZbijERDLeai4kQAteUJ
        XK0CAAA=
X-CMS-MailID: 20200316040716epcas1p3a16c3c333b74923a596f66fae5f28621
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
        <20200313174827.GA67638@unreal>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2020년 03월 14일 02:48, Leon Romanovsky wrote:
> On Fri, Mar 13, 2020 at 04:19:36PM +0100, Vlastimil Babka wrote:
>> +CC linux-api, please include in future versions as well
>>
>> On 3/11/20 4:44 AM, Jaewon Kim wrote:
>>> /proc/meminfo or show_free_areas does not show full system wide memory
>>> usage status. There seems to be huge hidden memory especially on
>>> embedded Android system. Because it usually have some HW IP which do not
>>> have internal memory and use common DRAM memory.
>>>
>>> In Android system, most of those hidden memory seems to be vmalloc pages
>>> , ion system heap memory, graphics memory, and memory for DRAM based
>>> compressed swap storage. They may be shown in other node but it seems to
>>> useful if /proc/meminfo shows all those extra memory information. And
>>> show_mem also need to print the info in oom situation.
>>>
>>> Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
>>> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
>>> memory using zsmalloc can be seen through vmstat by commit 91537fee0013
>>> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
>>>
>>> Memory usage of specific driver can be various so that showing the usage
>>> through upstream meminfo.c is not easy. To print the extra memory usage
>>> of a driver, introduce following APIs. Each driver needs to count as
>>> atomic_long_t.
>>>
>>> int register_extra_meminfo(atomic_long_t *val, int shift,
>>> 			   const char *name);
>>> int unregister_extra_meminfo(atomic_long_t *val);
>>>
>>> Currently register ION system heap allocator and zsmalloc pages.
>>> Additionally tested on local graphics driver.
>>>
>>> i.e) cat /proc/meminfo | tail -3
>>> IonSystemHeap:    242620 kB
>>> ZsPages:          203860 kB
>>> GraphicDriver:    196576 kB
>>>
>>> i.e.) show_mem on oom
>>> <6>[  420.856428]  Mem-Info:
>>> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
>>> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
>> I like the idea and the dynamic nature of this, so that drivers not present
>> wouldn't add lots of useless zeroes to the output.
>> It also makes simpler the decisions of "what is important enough to need its own
>> meminfo entry".
>>
>> The suggestion for hunting per-driver /sys files would only work if there was a
>> common name to such files so once can find(1) them easily.
>> It also doesn't work for the oom/failed alloc warning output.
> Of course there is a need to have a stable name for such an output, this
> is why driver/core should be responsible for that and not drivers authors.
>
> The use case which I had in mind slightly different than to look after OOM.
>
> I'm interested to optimize our drivers in their memory footprint to
> allow better scale in SR-IOV mode where one device creates many separate
> copies of itself. Those copies easily can take gigabytes of RAM due to
> the need to optimize for high-performance networking. Sometimes the
> amount of memory and not HW is actually limits the scale factor.
>
> So I would imagine this feature being used as an aid for the driver
> developers and not for the runtime decisions.
>
> My 2-cents.
>
> Thanks
>
>
Thank you for your comment.
My idea, I think, may be able to help each driver developer to see their memory usage.
But I'd like to see overall memory usage through the one node.

Let me know if you have more comment.
I am planning to move my logic to be shown on a new node, /proc/meminfo_extra at v2.

Thank you
Jaewon Kim
