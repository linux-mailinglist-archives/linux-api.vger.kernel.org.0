Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97F0193AB7
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 09:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgCZIVg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 04:21:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40970 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCZIVf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 04:21:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200326082133epoutp01a26c51683fc51999afed31d4b67986bb~-zOi57pYg1457214572epoutp01E
        for <linux-api@vger.kernel.org>; Thu, 26 Mar 2020 08:21:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200326082133epoutp01a26c51683fc51999afed31d4b67986bb~-zOi57pYg1457214572epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585210893;
        bh=oe8Z69HtB3Zqt/8deYHawk8D9xP6EWwaTBe3VcUF+10=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fBw/6nI23F1ykfRoRvZLnZ9X1Fu7VvXIj0ISymPEV/UL3u4T1IfREXczuUU++suSq
         rPyLc3/xzQEt5uJ23xAdvymfwXuHsb/+Rs3zrfpSQDXf6JcKxFAWg8WKZTS4GKRMUn
         5dKGOENDvD73iwsI9ni9+3FIsUA+b8UrzpBUjNAw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326082133epcas1p29ebf5e171201f28115c057e40df70173~-zOiazuUY0893608936epcas1p2e;
        Thu, 26 Mar 2020 08:21:33 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48nycq13LPzMqYkx; Thu, 26 Mar
        2020 08:21:31 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.C2.04074.B066C7E5; Thu, 26 Mar 2020 17:21:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326082130epcas1p1106747310b04a175932ebe89dd7c86d6~-zOgDHgAS0481304813epcas1p1g;
        Thu, 26 Mar 2020 08:21:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326082130epsmtrp1efe8764af22b957da6bcc4ccef0d9165~-zOgBtYlv1726217262epsmtrp1b;
        Thu, 26 Mar 2020 08:21:30 +0000 (GMT)
X-AuditID: b6c32a39-58bff70000000fea-ab-5e7c660bb297
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.B2.04024.A066C7E5; Thu, 26 Mar 2020 17:21:30 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326082128epsmtip13272af46ba79849f06ef4517e9691fca~-zOecDbX70940109401epsmtip1O;
        Thu, 26 Mar 2020 08:21:28 +0000 (GMT)
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
Message-ID: <5E7C6608.5080500@samsung.com>
Date:   Thu, 26 Mar 2020 17:21:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200324131916.GA2500287@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRmVeSWpSXmKPExsWy7bCmvi53Wk2cwfNHzBbTG70s5qxfw2Zx
        /sEvNovmxevZLLo3z2S0WP7uNKPF7tNfmSxW7vnBZDHl11Jmi83fO9gsLu+aw2Zxb81/Votl
        X9+zW2xomcVu8WjCJCaLU3c/s1vMbuxjdBD02DnrLrvHplWdbB6bPk1i97hzbQ+bx4kZv1k8
        9s9dw+6xeUm9x/t9V9k8ziw4wu6x89NmVo/Pm+QCuKNybDJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgYmQJVJuRkPJjYzVrwzaZiwpP1rA2Mewy7GDk5
        JARMJGZ0TmXtYuTiEBLYwSjxZuJpRgjnE6PEzCNN7BDON0aJLVMWsMC0tL+ZA1W1l1Hi55NT
        zBDOW0aJbbP2M4NUCQu4Sfzbep4NxBYR0JB4efQWC0gRs8B3Jonji78wgSTYBLQl3i+YxApi
        8wpoSRxfdAisgUVAVWLqxulgg0QFIiR2zP3ICFEjKHFy5hOwMzgFDCVub1oEVs8sIC/RvHU2
        2BUSAsfYJd7sP8oGcauLxN8ryxghbGGJV8e3sEPYUhIv+9vYIRqaGSXeztzMCOG0MErc3dQL
        1WEs0dtzAWgsB9AKTYn1u/QhwooSO3/PZYTYzCfx7msPK0iJhACvREebEESJmkTLs6+sELaM
        xN9/z6BKPCTO/1MDCQsJ7GaW2Ds1dAKjwiwkr81C8s4shL0LGJlXMYqlFhTnpqcWGxaYIsfx
        JkZwOtey3MF47JzPIUYBDkYlHt4NltVxQqyJZcWVuYcYJTiYlUR4n0bWxAnxpiRWVqUW5ccX
        leakFh9iNAWG9kRmKdHkfGCuySuJNzQ1MjY2tjAxMzczNVYS5516PSdOSCA9sSQ1OzW1ILUI
        po+Jg1OqgXF/8cnFX40Wlv/5F7sv8enlTWrfit78LLX7L7A8y6lmV6jWpfS5uxKUU3cvOfWs
        uuTirn/vuKd6bDZy/cWnFy3d/Ft3/Y7i1O/zDvom6VQf9ZSwDJmTvHl3QckHltWP629rOS1K
        NRQpvX6Qy1pEU0/z278v2aeqXgg/XXw6V5uxh4v56PvoLQeUWIozEg21mIuKEwFC16aj/QMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnC5XWk2cwd8pyhbTG70s5qxfw2Zx
        /sEvNovmxevZLLo3z2S0WP7uNKPF7tNfmSxW7vnBZDHl11Jmi83fO9gsLu+aw2Zxb81/Votl
        X9+zW2xomcVu8WjCJCaLU3c/s1vMbuxjdBD02DnrLrvHplWdbB6bPk1i97hzbQ+bx4kZv1k8
        9s9dw+6xeUm9x/t9V9k8ziw4wu6x89NmVo/Pm+QCuKO4bFJSczLLUov07RK4Mh5M7GYt+GZT
        MeHJetYGxj2GXYycHBICJhLtb+YwdjFycQgJ7GaUmLKohw0iISPx5vxTli5GDiBbWOLw4WKI
        mteMEr8n3gWrERZwk/i39TyYLSKgIfHy6C0WEBtoELPEwjMcIA3MAt+ZJC71HQIrYhPQlni/
        YBIriM0roCVxfBFEnEVAVWLqxunMILaoQITE6nXXmCFqBCVOznwCNpRTwFDi9qZFYPXMAuoS
        f+ZdYoaw5SWat85mnsAoOAtJyywkZbOQlC1gZF7FKJlaUJybnltsWGCYl1quV5yYW1yal66X
        nJ+7iREco1qaOxgvL4k/xCjAwajEw7vBsjpOiDWxrLgy9xCjBAezkgjv08iaOCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYHaZn1H/Q0952vDls4t+L
        cpsUWy32dVZaCBzh+/ZeJsDuLfslHfP553U1/C3/u3aedyxZr50es+Ta3Rd8mgGLmH41v+yL
        +FC0aJ7OwturvkT8OPLmwykJA/6W1xYZ1q93eXJ4n7YJfP0nkM/O6cifSwfun1h2W8J6e1q6
        5kcrAe936cdZy15WK7EUZyQaajEXFScCAOnZ5WvNAgAA
X-CMS-MailID: 20200326082130epcas1p1106747310b04a175932ebe89dd7c86d6
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
        <20200324114645.GA2330984@kroah.com> <5E7A02BC.7020803@samsung.com>
        <20200324131916.GA2500287@kroah.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2020년 03월 24일 22:19, Greg KH wrote:
> On Tue, Mar 24, 2020 at 09:53:16PM +0900, Jaewon Kim wrote:
>>
>> On 2020년 03월 24일 20:46, Greg KH wrote:
>>> On Tue, Mar 24, 2020 at 08:37:38PM +0900, Jaewon Kim wrote:
>>>> On 2020년 03월 24일 19:11, Greg KH wrote:
>>>>> On Tue, Mar 24, 2020 at 06:11:17PM +0900, Jaewon Kim wrote:
>>>>>> On 2020년 03월 23일 18:53, Greg KH wrote:
>>>>>>>> +int register_meminfo_extra(atomic_long_t *val, int shift, const char *name)
>>>>>>>> +{
>>>>>>>> +	struct meminfo_extra *meminfo, *memtemp;
>>>>>>>> +	int len;
>>>>>>>> +	int error = 0;
>>>>>>>> +
>>>>>>>> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
>>>>>>>> +	if (!meminfo) {
>>>>>>>> +		error = -ENOMEM;
>>>>>>>> +		goto out;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	meminfo->val = val;
>>>>>>>> +	meminfo->shift_for_page = shift;
>>>>>>>> +	strncpy(meminfo->name, name, NAME_SIZE);
>>>>>>>> +	len = strlen(meminfo->name);
>>>>>>>> +	meminfo->name[len] = ':';
>>>>>>>> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
>>>>>>>> +	while (++len < NAME_BUF_SIZE - 1)
>>>>>>>> +		meminfo->name_pad[len] = ' ';
>>>>>>>> +
>>>>>>>> +	spin_lock(&meminfo_lock);
>>>>>>>> +	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
>>>>>>>> +		if (memtemp->val == val) {
>>>>>>>> +			error = -EINVAL;
>>>>>>>> +			break;
>>>>>>>> +		}
>>>>>>>> +	}
>>>>>>>> +	if (!error)
>>>>>>>> +		list_add_tail_rcu(&meminfo->list, &meminfo_head);
>>>>>>>> +	spin_unlock(&meminfo_lock);
>>>>>>> If you have a lock, why are you needing rcu?
>>>>>> I think _rcu should be removed out of list_for_each_entry_rcu.
>>>>>> But I'm confused about what you meant.
>>>>>> I used rcu_read_lock on __meminfo_extra,
>>>>>> and I think spin_lock is also needed for addition and deletion to handle multiple modifiers.
>>>>> If that's the case, then that's fine, it just didn't seem like that was
>>>>> needed.  Or I might have been reading your rcu logic incorrectly...
>>>>>
>>>>>>>> +	if (error)
>>>>>>>> +		kfree(meminfo);
>>>>>>>> +out:
>>>>>>>> +
>>>>>>>> +	return error;
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(register_meminfo_extra);
>>>>>>> EXPORT_SYMBOL_GPL()?  I have to ask :)
>>>>>> I can use EXPORT_SYMBOL_GPL.
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>>>
>>>>>>>
>>>>>> Hello
>>>>>> Thank you for your comment.
>>>>>>
>>>>>> By the way there was not resolved discussion on v1 patch as I mentioned on cover page.
>>>>>> I'd like to hear your opinion on this /proc/meminfo_extra node.
>>>>> I think it is the propagation of an old and obsolete interface that you
>>>>> will have to support for the next 20+ years and yet not actually be
>>>>> useful :)
>>>>>
>>>>>> Do you think this is meaningful or cannot co-exist with other future
>>>>>> sysfs based API.
>>>>> What sysfs-based API?
>>>> Please refer to mail thread on v1 patch set - https://protect2.fireeye.com/url?k=16e3accc-4b2f6548-16e22783-0cc47aa8f5ba-935fe828ac2f6656&u=https://lkml.org/lkml/fancy/2020/3/10/2102
>>>> especially discussion with Leon Romanovsky on https://protect2.fireeye.com/url?k=74208ed9-29ec475d-74210596-0cc47aa8f5ba-0bd4ef48931fec95&u=https://lkml.org/lkml/fancy/2020/3/16/140
>>> I really do not understand what you are referring to here, sorry.   I do
>>> not see any sysfs-based code in that thread.
>> Sorry. I also did not see actual code.
>> Hello Leon Romanovsky, could you elaborate your plan regarding sysfs stuff?
>>> And try to use lore.kernel.org, lkml.org doesn't always work and we have
>>> no control over that :(
>>>
>>>>> I still don't know _why_ you want this.  The ION stuff is not needed as
>>>>> that code is about to be deleted, so who else wants this?  What is the
>>>>> use-case for it that is so desperately needed that parsing
>>>>> yet-another-proc file is going to solve the problem?
>>>> In my Android device, there are graphic driver memory, zsmalloc memory except ION.
>>> Ok, so what does Android have to do with this?
>> Some driver in Android platform may use my API to show its memory usage.
> I do not understand what this means.
>
>>>> I don't know other cases in other platform.
>>>> Not desperately needed but I think we need one userspace knob to see overall hidden huge memory.
>>> Why?  Who wants that?  What would userspace do with that?  And what
>>> exactly do you want to show?
>>>
>>> Is this just a debugging thing?  Then use debugfs for that, not proc.
>>> Isn't that what the DRM developers are starting to do?
>>>
>>>> Additionally I'd like to see all those hidden memory in OutOfMemory log.
>>> How is anything hidden, can't you see it in the slab information?
>>>
>> Let me explain more.
>>
>> 0. slab
>> As I said in cover page, this is not for memory allocated by slab.
> Great, then have the subsystem that allocates such memory, be the thing
> that exports the information.  Drivers "on their own" do not grab any
> memory without asking for it from other parts of the kernel.
>
> Modify those "other parts", this isn't a driver-specific thing at all.
>
> So, what "other parts" are involved here?
>
>> I'd like to know where huge memory has gone.
>> Those are directly allocated by alloc_pages instead of slab.
>> /proc/slabinfo does not show this information.
> Why isn't alloc_pages information exported anywhere?  Work on that.
>
>> 1. /proc/meminfo_extra
>> /proc/meminfo_extra could be debugging thing to see memory status at a certain time.
> If it is debugging, then use debugfs.
>
>> But it, I think, is also basic information rather than just for debugging.
> Who would use that information for anything except debugging?
>
>> It is similar with /proc/meminfo which is in procfs instead of debugfs.
> meminfo is older than debugfs and sysfs, can't change that today.
>
>> 2. oom log
>> oom log in show_mem is more than just debugging.
> Why?  Who sees this?
>
>> As existing oom log shows much memory information, I think we need the hidden memory info.
>> Without these information, we do NOT know oom reason because other traditional stats are not enough.
> Why not?  Kernel users of memory shouldn't be triggering OOM events.
>
>
>>>> This is useful to get clue to find memory hogger.
>>>> i.e.) show_mem on oom
>>>> <6>[  420.856428]  Mem-Info:
>>>> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
>>>> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
>>> So what does this show you?  That someone is takign a ton of ION memory
>>> for some unknown use?  What can you do with that?  What would you do
>>> with that?
>> We may not know exact memory owner. But we can narrow down.
>> Anyway I think this is meaningful instead of no clue.
> Again, work on the subsystems that actually allocate the memory, not
> drivers.  And if you want to mess with drivers, do it in a
> device-specific way, not a driver-specific way.
>
>>> And memory is almost never assigned to a "driver", it is assigned to a
>>> "device" that uses it.  Drivers can handle multiple devices at the same
>>> time, so why would you break this down by drivers?  Are you assuming
>>> that a driver only talks to one piece of hardware?
>> Yes a driver may support several devices. I don't know if it same on an embedded device.
> Why wouldn't it be?  Is this new interface somehow only acceptable for
> systems with one-device-per-driver?  If so, that's not going to work at
> all.
>
>> Anyway I think the idea works even for several devices, although the driver should
>> distinguish memory usage for each device and should register each memory stat.
> And how would that happen?
>
> thanks,
>
> greg k-h
>
>
Thank you for you guys' comment
Let me consider more
