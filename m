Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0802190E26
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 13:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCXMxY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 08:53:24 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14758 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCXMxY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 08:53:24 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200324125321epoutp03a3469aedd2e4c8b3b83eb0c0b48d2576~-PpSC84KF2888428884epoutp03N
        for <linux-api@vger.kernel.org>; Tue, 24 Mar 2020 12:53:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200324125321epoutp03a3469aedd2e4c8b3b83eb0c0b48d2576~-PpSC84KF2888428884epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585054401;
        bh=qlC45ErpNVwg7dYO6PWOERNYjTpPbPeGroZhG4LafpI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PXoe0VRtZoHeoMBZeIf7iLo1c+s+MaU1AqM90iyZHC2MbhHVcP8o31y9egdI5kzE0
         QPZF/waCSFqvpYhCn9wsOFMk0voq4ITdRQzgdnXiotyvvDyJmtkHz7KKI598keNKOF
         iASInO8IlYhUAd3bbEoyqR7gdUWcmGMMsTt+h7Do=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200324125320epcas1p14cfa62b0f9b1681fb6da54a92c677ea6~-PpReFjVd3181131811epcas1p1C;
        Tue, 24 Mar 2020 12:53:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48mrlM61KrzMqYlm; Tue, 24 Mar
        2020 12:53:19 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.12.04071.FB20A7E5; Tue, 24 Mar 2020 21:53:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200324125318epcas1p2f378c2492fab03b9bd143cdf5c77bfe8~-PpPcXYKA2602726027epcas1p24;
        Tue, 24 Mar 2020 12:53:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324125318epsmtrp1fd9695add65d8d37e0fb73fdedcae8fe~-PpPbZvQR1679716797epsmtrp1L;
        Tue, 24 Mar 2020 12:53:18 +0000 (GMT)
X-AuditID: b6c32a37-7afff70000000fe7-ca-5e7a02bfeb0c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.62.04024.EB20A7E5; Tue, 24 Mar 2020 21:53:18 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324125317epsmtip1dfa282c9d6f6ad018b2fc1b532a56a43~-PpOFKHMN2571325713epsmtip1P;
        Tue, 24 Mar 2020 12:53:17 +0000 (GMT)
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
Message-ID: <5E7A02BC.7020803@samsung.com>
Date:   Tue, 24 Mar 2020 21:53:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200324114645.GA2330984@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxjH8961d8Wt5iw6nzQTu0vQwQJcKYV3iywmY+Q2XcJmtiz+0e6k
        JyW7/livOOGf4dowx2RW5nRUIMTCcA0MbYEVFQ0wgz8WMVtkcRHndDEBB41gZcMM13KY8d/3
        eZ7P8z4/3vfVkLopSq+pdHpFj1OQWGqVqn8kKzfnPFFj4QJH8vDRfW/i5p4uCo/dXqCwL9RD
        4S+iTQh3zlxB+MyVBIG/O/s3gQ8vdJA4Or+fwr+cbqbwra4navxtIk7jk/4gje8EGgl8eWKO
        xsf2fYm2ruEHghM0Hwl/TvGR2Uaavzl+luIvfvNYxZ9v6aL5aPsnfPzcdYr/qe1Hmh+Yjar5
        uUhG2TM7pS12UbCJHoPoLHfZKp0Vxey2HdbXrOZCzphjfBkXsQan4BCL2ZLtZTmllVJyKNaw
        R5Cqkq4yQZbZvFe3eFxVXtFgd8neYlZ02yS3kXPnyoJDrnJW5Ja7HK8YOS7fnCQ/kOx/HZ2i
        3bdMe0PB63QtimfVozQNMAXwwz+d6nq0SqNjYgiOHB5EqYCOmUXQ/dCjBB4hqB8YVz3NuNQb
        WM4YRBAMhwjFmEYwON5Kpqh0phQW+8aolF7LvAiTF35TpSCSmSdgNPSQSAUo5iWItzWqU1rL
        ZMNnZ0bplFYxmXAudmPJv455H2ItD5DCrIFLTX8utZHGGGHh98gSQzIbwdd3jEwVAOYyDdGv
        PqWUXkvg0YODtKLTYWq0d1nrYfJgHa0k+BBMN0WRYvgRTEQakEKZoOHAteSxmmSJLOg5nae4
        X4CBxy1IqbwaZhIH1CkEGC3sr9MpyCbw30uoFf08/Lt4bxnhYWxxk7KtBAFD3T4qgAzBFbMF
        V8wT/L9wGyLD6DnRLTsqRNnoNq284whaeufZRTF08ur2YcRoEPustvZutUWnFvbI1Y5hBBqS
        XauNinstOq1NqK4RPS6rp0oS5WFkTq77EKlfV+5K/hqn12o055tMJlxQWFRoNrHrtV//Kll0
        TIXgFT8URbfoeZpHaNL0tYi4OxQz+L2vd0R6semtpv7KznCPHA1zh/q3tsfqbvpLdxzveDIm
        7Sr42X5icmTu46uF9d9nwIb53NZizjqt3+jO3BC4cC3/fu87b6weak7v7OYmbuz6434oPX68
        Lye7xlBy29Lev96w+72M1o/UM7a3fb6pd0caStPaM52nuM13SFYl2wVjNumRhf8ALX7jk/0D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnO4+pqo4gwfXZC2mN3pZzFm/hs3i
        /INfbBbNi9ezWXRvnslosfzdaUaL3ae/Mlms3PODyWLKr6XMFpu/d7BZXN41h83i3pr/rBbL
        vr5nt9jQMovd4tGESUwWp+5+ZreY3djH6CDosXPWXXaPTas62Tw2fZrE7nHn2h42jxMzfrN4
        7J+7ht1j85J6j/f7rrJ5nFlwhN1j56fNrB6fN8kFcEdx2aSk5mSWpRbp2yVwZbyZ/oq94J5x
        xeJZV9kbGN9rdjFyckgImEic3DKBtYuRi0NIYDejxOnJK1kgEjISb84/BbI5gGxhicOHi0HC
        QgKvGSUOLwwCsYUF3CT+bT3PBmKLCGhIvDx6iwVizlcmiccnTjCBOMwC35kkLvUdAqtiE9CW
        eL9gEiuIzSugJdG++zg7iM0ioCqxb8dNsLioQITE6nXXmCFqBCVOznwCdhCngKHEr/ubwGqY
        BdQl/sy7xAxhy0s0b53NPIFRcBaSlllIymYhKVvAyLyKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0
        L10vOT93EyM4RrU0dzBeXhJ/iFGAg1GJh1frYWWcEGtiWXFl7iFGCQ5mJRHezakVcUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwLnc+6P297pAIJ5u7
        6d+yrPVVW9dUhMwoerA2oEFPhs3w6DSuCdptaX8qDN6mts48EWloLeHfFPTTvl7ipcmpSdk1
        hkt/rjR8YurqzBzNNZNhxrLNqucCjFXe/SsV7Dkk5escbN1+8NFLw4zeczrcdjvWxTxnKHzB
        3/SrkSmD7VTBrBns9c+VWIozEg21mIuKEwGN5ZnMzQIAAA==
X-CMS-MailID: 20200324125318epcas1p2f378c2492fab03b9bd143cdf5c77bfe8
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
        <20200323095344.GB425358@kroah.com> <5E79CEB5.8070308@samsung.com>
        <20200324101110.GA2218981@kroah.com> <5E79F102.9080405@samsung.com>
        <20200324114645.GA2330984@kroah.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2020년 03월 24일 20:46, Greg KH wrote:
> On Tue, Mar 24, 2020 at 08:37:38PM +0900, Jaewon Kim wrote:
>>
>> On 2020년 03월 24일 19:11, Greg KH wrote:
>>> On Tue, Mar 24, 2020 at 06:11:17PM +0900, Jaewon Kim wrote:
>>>> On 2020년 03월 23일 18:53, Greg KH wrote:
>>>>>> +int register_meminfo_extra(atomic_long_t *val, int shift, const char *name)
>>>>>> +{
>>>>>> +	struct meminfo_extra *meminfo, *memtemp;
>>>>>> +	int len;
>>>>>> +	int error = 0;
>>>>>> +
>>>>>> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
>>>>>> +	if (!meminfo) {
>>>>>> +		error = -ENOMEM;
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>> +	meminfo->val = val;
>>>>>> +	meminfo->shift_for_page = shift;
>>>>>> +	strncpy(meminfo->name, name, NAME_SIZE);
>>>>>> +	len = strlen(meminfo->name);
>>>>>> +	meminfo->name[len] = ':';
>>>>>> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
>>>>>> +	while (++len < NAME_BUF_SIZE - 1)
>>>>>> +		meminfo->name_pad[len] = ' ';
>>>>>> +
>>>>>> +	spin_lock(&meminfo_lock);
>>>>>> +	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
>>>>>> +		if (memtemp->val == val) {
>>>>>> +			error = -EINVAL;
>>>>>> +			break;
>>>>>> +		}
>>>>>> +	}
>>>>>> +	if (!error)
>>>>>> +		list_add_tail_rcu(&meminfo->list, &meminfo_head);
>>>>>> +	spin_unlock(&meminfo_lock);
>>>>> If you have a lock, why are you needing rcu?
>>>> I think _rcu should be removed out of list_for_each_entry_rcu.
>>>> But I'm confused about what you meant.
>>>> I used rcu_read_lock on __meminfo_extra,
>>>> and I think spin_lock is also needed for addition and deletion to handle multiple modifiers.
>>> If that's the case, then that's fine, it just didn't seem like that was
>>> needed.  Or I might have been reading your rcu logic incorrectly...
>>>
>>>>>> +	if (error)
>>>>>> +		kfree(meminfo);
>>>>>> +out:
>>>>>> +
>>>>>> +	return error;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(register_meminfo_extra);
>>>>> EXPORT_SYMBOL_GPL()?  I have to ask :)
>>>> I can use EXPORT_SYMBOL_GPL.
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>>
>>>>>
>>>> Hello
>>>> Thank you for your comment.
>>>>
>>>> By the way there was not resolved discussion on v1 patch as I mentioned on cover page.
>>>> I'd like to hear your opinion on this /proc/meminfo_extra node.
>>> I think it is the propagation of an old and obsolete interface that you
>>> will have to support for the next 20+ years and yet not actually be
>>> useful :)
>>>
>>>> Do you think this is meaningful or cannot co-exist with other future
>>>> sysfs based API.
>>> What sysfs-based API?
>> Please refer to mail thread on v1 patch set - https://protect2.fireeye.com/url?k=16e3accc-4b2f6548-16e22783-0cc47aa8f5ba-935fe828ac2f6656&u=https://lkml.org/lkml/fancy/2020/3/10/2102
>> especially discussion with Leon Romanovsky on https://protect2.fireeye.com/url?k=74208ed9-29ec475d-74210596-0cc47aa8f5ba-0bd4ef48931fec95&u=https://lkml.org/lkml/fancy/2020/3/16/140
> I really do not understand what you are referring to here, sorry.   I do
> not see any sysfs-based code in that thread.
Sorry. I also did not see actual code.
Hello Leon Romanovsky, could you elaborate your plan regarding sysfs stuff?
>
> And try to use lore.kernel.org, lkml.org doesn't always work and we have
> no control over that :(
>
>>> I still don't know _why_ you want this.  The ION stuff is not needed as
>>> that code is about to be deleted, so who else wants this?  What is the
>>> use-case for it that is so desperately needed that parsing
>>> yet-another-proc file is going to solve the problem?
>> In my Android device, there are graphic driver memory, zsmalloc memory except ION.
> Ok, so what does Android have to do with this?
Some driver in Android platform may use my API to show its memory usage.
>
>> I don't know other cases in other platform.
>> Not desperately needed but I think we need one userspace knob to see overall hidden huge memory.
> Why?  Who wants that?  What would userspace do with that?  And what
> exactly do you want to show?
>
> Is this just a debugging thing?  Then use debugfs for that, not proc.
> Isn't that what the DRM developers are starting to do?
>
>> Additionally I'd like to see all those hidden memory in OutOfMemory log.
> How is anything hidden, can't you see it in the slab information?
>
Let me explain more.

0. slab
As I said in cover page, this is not for memory allocated by slab.
I'd like to know where huge memory has gone.
Those are directly allocated by alloc_pages instead of slab.
/proc/slabinfo does not show this information.

1. /proc/meminfo_extra
/proc/meminfo_extra could be debugging thing to see memory status at a certain time.
But it, I think, is also basic information rather than just for debugging.
It is similar with /proc/meminfo which is in procfs instead of debugfs.

2. oom log
oom log in show_mem is more than just debugging.
As existing oom log shows much memory information, I think we need the hidden memory info.
Without these information, we do NOT know oom reason because other traditional stats are not enough.
>> This is useful to get clue to find memory hogger.
>> i.e.) show_mem on oom
>> <6>[  420.856428]  Mem-Info:
>> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
>> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
> So what does this show you?  That someone is takign a ton of ION memory
> for some unknown use?  What can you do with that?  What would you do
> with that?
We may not know exact memory owner. But we can narrow down.
Anyway I think this is meaningful instead of no clue.
>
> And memory is almost never assigned to a "driver", it is assigned to a
> "device" that uses it.  Drivers can handle multiple devices at the same
> time, so why would you break this down by drivers?  Are you assuming
> that a driver only talks to one piece of hardware?
Yes a driver may support several devices. I don't know if it same on an embedded device.
Anyway I think the idea works even for several devices, although the driver should
distinguish memory usage for each device and should register each memory stat.
>
> I think you need a much better use case for all of this other than
> "wouldn't it be nice to see some numbers", as that isn't going to help
> anyone out in the end.
Sorry. As of now, I do not know other better use case, but I still think
memory information should cover most of memory usage.
Huge memory consumed by driver or other core logic should be shown in OoM.
>
> thanks,
>
> greg k-h
>
>

