Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BDD1908B1
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 10:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCXJLa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 05:11:30 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22091 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgCXJL3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 05:11:29 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200324091127epoutp04814eceb504c8aef9cc0df52bf4689712~-MnioC9wA2248322483epoutp04L
        for <linux-api@vger.kernel.org>; Tue, 24 Mar 2020 09:11:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200324091127epoutp04814eceb504c8aef9cc0df52bf4689712~-MnioC9wA2248322483epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585041087;
        bh=OTYMYYI8jGaIHO8LtsuVm3vXVt7kXP3LgI5H0A5a8Mc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RO99FjyJV0y9bQBFfjDeI13v10NYRqs7l7LkBeo+iiMBJHs0B7sioNKo7bNrIYAb8
         qNMg2wTz1W0ytnGgpwCcpa6WJDjN8+BV53lBnM+7o9SYJP7zmRZuSqShdg94LgtDxc
         zG+NXOlID0JmN3WaXKe1LQGBvP8iUXmV+pDSyK3M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200324091127epcas1p4dcb3fc7c0d8abaec70261beea1f2f831~-MniKux-R2789027890epcas1p4l;
        Tue, 24 Mar 2020 09:11:27 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48mlqL1LhmzMqYkm; Tue, 24 Mar
        2020 09:11:26 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.D1.04074.EBEC97E5; Tue, 24 Mar 2020 18:11:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200324091125epcas1p43356a6bb4bf77d743551fed71e35cbc4~-MngqnBHy2789027890epcas1p4k;
        Tue, 24 Mar 2020 09:11:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200324091125epsmtrp2992a6580c65a01b6a18d653848caecde~-MngpNXlf2923129231epsmtrp2c;
        Tue, 24 Mar 2020 09:11:25 +0000 (GMT)
X-AuditID: b6c32a39-573ff70000000fea-c6-5e79cebef20f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.86.04024.DBEC97E5; Tue, 24 Mar 2020 18:11:25 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324091123epsmtip1e79651d15bbe092e7a442b916ede3129~-Mne7lSLB3263532635epsmtip1J;
        Tue, 24 Mar 2020 09:11:23 +0000 (GMT)
Subject: Re: [RFC PATCH v2 1/3] meminfo_extra: introduce meminfo extra
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     leon@kernel.org, vbabka@suse.cz, adobriyan@gmail.com,
        akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E79CEB5.8070308@samsung.com>
Date:   Tue, 24 Mar 2020 18:11:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200323095344.GB425358@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmnu6+c5VxBne2s1pMb/SymLN+DZvF
        +Qe/2CyaF69ns+jePJPRYvm704wWu09/ZbJYuecHk8WUX0uZLTZ/72CzuLxrDpvFvTX/WS2W
        fX3PbrGhZRa7xaMJk5gsTt39zG4xu7GP0UHQY+esu+wem1Z1snls+jSJ3ePOtT1sHidm/Gbx
        2D93DbvH5iX1Hu/3XWXzOLPgCLvHzk+bWT0+b5IL4I7KsclITUxJLVJIzUvOT8nMS7dV8g6O
        d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBekpJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
        YquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCT0bFiPmPBG/mK9Yu2szYwHpfsYuTk
        kBAwkfjwfT8jiC0ksINRomNLcRcjF5D9iVHizJdvbBDON0aJSXcvM8J0LDjxGCqxl1Hi/K+V
        7BDOW0aJky032UCqhAXcJP5tPQ9miwhoSLw8eosFpIhZ4DuTxPHFX5hAEmwC2hLvF0xiBbF5
        BbQkFk7qA1vBIqAqMW3iExYQW1QgQmLH3I+MEDWCEidngsQ5ODgFDCQ6XtmChJkF5CWat85m
        BpkvIXCKXWLd4r+sEKe6SJxY/IcNwhaWeHV8CzuELSXx+d1eNoiGZkaJtzM3M0I4LYwSdzf1
        Qj1qLNHbc4EZZBuzgKbE+l36EGFFiZ2/5zJCbOaTePe1hxWkREKAV6KjTQiiRE2i5dlXqBtk
        JP7+ewZV4iFx/p8aJKxfMkqs+acxgVFhFpLPZiF5ZxbC3gWMzKsYxVILinPTU4sNC0yRY3gT
        IziVa1nuYDx2zucQowAHoxIP74ZpFXFCrIllxZW5hxglOJiVRHg3pwKFeFMSK6tSi/Lji0pz
        UosPMZoCA3sis5Rocj4wz+SVxBuaGhkbG1uYmJmbmRorifNOvZ4TJySQnliSmp2aWpBaBNPH
        xMEp1cAY7jHPYunHTO3MR0u4+/75Kl5mXsyd8cpw2w4V6z6HVrMJVyy3dB6wYXiYyDJjk5tc
        U5i1ckh4zeVM8Z19yw9Nn3z+k8u1XV+ns95xuZp3+DXHl4DN8fm7U+qawxde++3qsv9J14vl
        3DGbZV78e/iwQvVYVFLQysvZFzfMi92Su5331Fo+qWNNSizFGYmGWsxFxYkAkolgUfsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnO7ec5VxBv0nxS2mN3pZzFm/hs3i
        /INfbBbNi9ezWXRvnslosfzdaUaL3ae/Mlms3PODyWLKr6XMFpu/d7BZXN41h83i3pr/rBbL
        vr5nt9jQMovd4tGESUwWp+5+ZreY3djH6CDosXPWXXaPTas62Tw2fZrE7nHn2h42jxMzfrN4
        7J+7ht1j85J6j/f7rrJ5nFlwhN1j56fNrB6fN8kFcEdx2aSk5mSWpRbp2yVwZXSsmM9Y8Ea+
        Yv2i7awNjMcluxg5OSQETCQWnHjM1sXIxSEksJtR4k/DLFaIhIzEm/NPWboYOYBsYYnDh4sh
        al4zSmw/180MUiMs4Cbxb+t5NhBbREBD4uXRWywQRS8ZJSb+PgXmMAt8Z5K41HcIrIpNQFvi
        /YJJYBt4BbQkFk7qYwSxWQRUJaZNfMICYosKREisXneNGaJGUOLkzCdgV3AKGEh0vLIFMZkF
        1CXWzxMCqWAWkJdo3jqbeQKj4CwkDbMQqmYhqVrAyLyKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0
        L10vOT93EyM4PrU0dzBeXhJ/iFGAg1GJh5djZkWcEGtiWXFl7iFGCQ5mJRHezalAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhi7/hjbPHkgOmc2n8rx
        8L7rHJtnWc+e68UhILcy5u7rG+xXD3xxP91q/2eJLFNCwsWHRufspiqrLrqjd+x05/HquSFF
        TWsZH9aVuH9Y5bAv/4pYiJLfFQP/pvhmJff4Zb9mnZsTtXmxUdyjeescHkZasIVVuRQa9GaH
        biplaTm1pmPVSR/bebOVWIozEg21mIuKEwHTU5jhywIAAA==
X-CMS-MailID: 20200324091125epcas1p43356a6bb4bf77d743551fed71e35cbc4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
        <CGME20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477@epcas1p3.samsung.com>
        <20200323080503.6224-2-jaewon31.kim@samsung.com>
        <20200323095344.GB425358@kroah.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2020년 03월 23일 18:53, Greg KH wrote:
> On Mon, Mar 23, 2020 at 05:05:01PM +0900, Jaewon Kim wrote:
>> Provide APIs to drivers so that they can show its memory usage on
>> /proc/meminfo_extra.
>>
>> int register_meminfo_extra(atomic_long_t *val, int shift,
>> 			   const char *name);
>> int unregister_meminfo_extra(atomic_long_t *val);
> Nit, isn't it nicer to have the subsystem name first:
> 	meminfo_extra_register()
> 	meminfo_extra_unregister()
> ?
OK. Name can be changed.
>
>
>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> ---
>> v2: move to /proc/meminfo_extra as a new file, meminfo_extra.c
>>     use rcu to reduce lock overhead
>> v1: print info at /proc/meminfo
>> ---
>>  fs/proc/Makefile        |   1 +
>>  fs/proc/meminfo_extra.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mm.h      |   4 ++
>>  mm/page_alloc.c         |   1 +
>>  4 files changed, 129 insertions(+)
>>  create mode 100644 fs/proc/meminfo_extra.c
>>
>> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
>> index bd08616ed8ba..83d2f55591c6 100644
>> --- a/fs/proc/Makefile
>> +++ b/fs/proc/Makefile
>> @@ -19,6 +19,7 @@ proc-y	+= devices.o
>>  proc-y	+= interrupts.o
>>  proc-y	+= loadavg.o
>>  proc-y	+= meminfo.o
>> +proc-y	+= meminfo_extra.o
>>  proc-y	+= stat.o
>>  proc-y	+= uptime.o
>>  proc-y	+= util.o
>> diff --git a/fs/proc/meminfo_extra.c b/fs/proc/meminfo_extra.c
>> new file mode 100644
>> index 000000000000..bd3f0d2b7fb7
>> --- /dev/null
>> +++ b/fs/proc/meminfo_extra.c
>> @@ -0,0 +1,123 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/mm.h>
>> +#include <linux/proc_fs.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/slab.h>
>> +
>> +static void show_val_kb(struct seq_file *m, const char *s, unsigned long num)
>> +{
>> +	seq_put_decimal_ull_width(m, s, num << (PAGE_SHIFT - 10), 8);
>> +	seq_write(m, " kB\n", 4);
>> +}
>> +
>> +static LIST_HEAD(meminfo_head);
>> +static DEFINE_SPINLOCK(meminfo_lock);
>> +
>> +#define NAME_SIZE      15
>> +#define NAME_BUF_SIZE  (NAME_SIZE + 2) /* ':' and '\0' */
>> +
>> +struct meminfo_extra {
>> +	struct list_head list;
>> +	atomic_long_t *val;
>> +	int shift_for_page;
>> +	char name[NAME_BUF_SIZE];
>> +	char name_pad[NAME_BUF_SIZE];
>> +};
>> +
>> +int register_meminfo_extra(atomic_long_t *val, int shift, const char *name)
>> +{
>> +	struct meminfo_extra *meminfo, *memtemp;
>> +	int len;
>> +	int error = 0;
>> +
>> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
>> +	if (!meminfo) {
>> +		error = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	meminfo->val = val;
>> +	meminfo->shift_for_page = shift;
>> +	strncpy(meminfo->name, name, NAME_SIZE);
>> +	len = strlen(meminfo->name);
>> +	meminfo->name[len] = ':';
>> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
>> +	while (++len < NAME_BUF_SIZE - 1)
>> +		meminfo->name_pad[len] = ' ';
>> +
>> +	spin_lock(&meminfo_lock);
>> +	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
>> +		if (memtemp->val == val) {
>> +			error = -EINVAL;
>> +			break;
>> +		}
>> +	}
>> +	if (!error)
>> +		list_add_tail_rcu(&meminfo->list, &meminfo_head);
>> +	spin_unlock(&meminfo_lock);
> If you have a lock, why are you needing rcu?
I think _rcu should be removed out of list_for_each_entry_rcu.
But I'm confused about what you meant.
I used rcu_read_lock on __meminfo_extra,
and I think spin_lock is also needed for addition and deletion to handle multiple modifiers.
>
>
>
>> +	if (error)
>> +		kfree(meminfo);
>> +out:
>> +
>> +	return error;
>> +}
>> +EXPORT_SYMBOL(register_meminfo_extra);
> EXPORT_SYMBOL_GPL()?  I have to ask :)
I can use EXPORT_SYMBOL_GPL.
>
> thanks,
>
> greg k-h
>
>

Hello
Thank you for your comment.

By the way there was not resolved discussion on v1 patch as I mentioned on cover page.
I'd like to hear your opinion on this /proc/meminfo_extra node.
Do you think this is meaningful or cannot co-exist with other future sysfs based API.


