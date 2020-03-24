Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B15190C98
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 12:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgCXLht (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 07:37:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38239 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCXLhs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 07:37:48 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200324113744epoutp017271e5373c99e920c690043018b7269b~-OnQ6e0de1562315623epoutp01M
        for <linux-api@vger.kernel.org>; Tue, 24 Mar 2020 11:37:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200324113744epoutp017271e5373c99e920c690043018b7269b~-OnQ6e0de1562315623epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585049864;
        bh=JgArrA3uQGXN7tH4LXkGzWxmGt7NEFtzC40fxAIIJQg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DSkBFf6jpZ3QmdTeckXSTxP3icJbuh9wu9nZP6gIXLHdpQ5jlDu5hrhE5/1oy/03j
         y+ZTqzoX2LYy0egQFrIwqFMQXDy9FRcyJX9kOmXR9m5GtiR5/df7cL7NC0WxjwIYD1
         eHhXr4XyN4LW10ALPXpcFfuXzqycCh+P0mmfi4RY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200324113743epcas1p116ddec95a2720d6e171137d6bb9bec7d~-OnP0Noov1286112861epcas1p18;
        Tue, 24 Mar 2020 11:37:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48mq452dFJzMqYkV; Tue, 24 Mar
        2020 11:37:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.77.04074.501F97E5; Tue, 24 Mar 2020 20:37:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200324113740epcas1p105dbc87fedfa534c2d6b6a8ad515fda0~-OnNQvG9S1286112861epcas1p15;
        Tue, 24 Mar 2020 11:37:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200324113740epsmtrp2625c4b6be22228e08fbc7d5e855cf9f0~-OnNP0IS40928509285epsmtrp27;
        Tue, 24 Mar 2020 11:37:40 +0000 (GMT)
X-AuditID: b6c32a39-58bff70000000fea-cc-5e79f1056a6d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.30.04024.401F97E5; Tue, 24 Mar 2020 20:37:40 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200324113739epsmtip24099d55508e3906a0166054ae6c581a8~-OnL6Llao0410204102epsmtip29;
        Tue, 24 Mar 2020 11:37:39 +0000 (GMT)
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
Message-ID: <5E79F102.9080405@samsung.com>
Date:   Tue, 24 Mar 2020 20:37:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200324101110.GA2218981@kroah.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmvi7rx8o4gzcd/BbTG70s5qxfw2Zx
        /sEvNovmxevZLLo3z2S0WP7uNKPF7tNfmSxW7vnBZDHl11Jmi83fO9gsLu+aw2Zxb81/Votl
        X9+zW2xomcVu8WjCJCaLU3c/s1vMbuxjdBD02DnrLrvHplWdbB6bPk1i97hzbQ+bx4kZv1k8
        9s9dw+6xeUm9x/t9V9k8ziw4wu6x89NmVo/Pm+QCuKNybDJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgYmQJVJuRkvOwTLLgvVXHmx0SWBsYTol2MHBwS
        AiYST47IdjFycQgJ7GCU2HJpFyuE84lRou/heRYI5xujxJPvH5i7GDnBOhqX32AFsYUE9jJK
        3HtqA1H0llHi0Lmj7CAJYQE3iX9bz7OB2CICGhIvj94Cm8Qs8J1J4vjiL0wgCTYBbYn3CyaB
        TeIV0JJYveI62AYWAVWJvW9vgNmiAhESO+Z+ZISoEZQ4OfMJC4jNKWAo8XPDH7BlzALyEs1b
        ZzODLJAQOMUu8W7pfiaIU10kOiafg7KFJV4d38IOYUtJfH63lw2ioZlR4u3MzYwQTgujxN1N
        vYwQVcYSvT0XmEHBxCygKbF+lz5EWFFi5++5jBCb+STefe1hhYQkr0RHmxBEiZpEy7OvrBC2
        jMTff8+gSjwkzv9Tg4TWemBArN7AOoFRYRaS32Yh+WcWwuIFjMyrGMVSC4pz01OLDQtMkWN4
        EyM4lWtZ7mA8ds7nEKMAB6MSD2/D48o4IdbEsuLK3EOMEhzMSiK8m1Mr4oR4UxIrq1KL8uOL
        SnNSiw8xmgKDeyKzlGhyPjDP5JXEG5oaGRsbW5iYmZuZGiuJ8069nhMnJJCeWJKanZpakFoE
        08fEwSnVwHiw7V369uefJjBsWLQs99nHmwv+yZryrXWwOVJgMf/t+n88KocN9ZvL1xy/8aAg
        X+6b7uY47r9Wtget/CN/31jwl/2ljuBLhre/+1SlvJtC1k6y8d35zE3kLmv9TfEppv1qfV2l
        0+5X6gbeZX5idiKoPHzaqy7uV+eOH+zcscf8kvqPI966D8KUWIozEg21mIuKEwFBKliZ+wMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvC7Lx8o4g6592hbTG70s5qxfw2Zx
        /sEvNovmxevZLLo3z2S0WP7uNKPF7tNfmSxW7vnBZDHl11Jmi83fO9gsLu+aw2Zxb81/Votl
        X9+zW2xomcVu8WjCJCaLU3c/s1vMbuxjdBD02DnrLrvHplWdbB6bPk1i97hzbQ+bx4kZv1k8
        9s9dw+6xeUm9x/t9V9k8ziw4wu6x89NmVo/Pm+QCuKO4bFJSczLLUov07RK4Ml72CRbcl6o4
        82MiSwPjCdEuRk4OCQETicblN1i7GLk4hAR2M0rc2bydBSIhI/Hm/FMgmwPIFpY4fLgYouY1
        o8SW7g4mkBphATeJf1vPs4HYIgIaEi+P3mKBKFrPJLGz9x2YwyzwnUniUt8hsCo2AW2J9wsm
        sYLYvAJaEqtXXGcGsVkEVCX2vr0BZosKREisXneNGaJGUOLkzCdgF3EKGEr83PCHHcRmFlCX
        +DPvEjOELS/RvHU28wRGwVlIWmYhKZuFpGwBI/MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS9
        5PzcTYzgGNXS3MF4eUn8IUYBDkYlHl6th5VxQqyJZcWVuYcYJTiYlUR4N6dWxAnxpiRWVqUW
        5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAOP1pjNGxW8UvvmlMeskt
        2P1n8busvvVP3t1XTDNo6InM/GWTbb/QyiL0g+PtW7m6rRzs+/wDJ9jt3lLAutoj8q/bweik
        xWVruta2Ht/+9Ycc766dM4873Zn685nwviNB/zgXRDasX2klti7Cae+snXzrDhfeOW5zVWC6
        xJVN9h/Loib2GIV2limxFGckGmoxFxUnAgC9Jb9gzQIAAA==
X-CMS-MailID: 20200324113740epcas1p105dbc87fedfa534c2d6b6a8ad515fda0
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
        <20200324101110.GA2218981@kroah.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2020년 03월 24일 19:11, Greg KH wrote:
> On Tue, Mar 24, 2020 at 06:11:17PM +0900, Jaewon Kim wrote:
>> On 2020년 03월 23일 18:53, Greg KH wrote:
>>>> +int register_meminfo_extra(atomic_long_t *val, int shift, const char *name)
>>>> +{
>>>> +	struct meminfo_extra *meminfo, *memtemp;
>>>> +	int len;
>>>> +	int error = 0;
>>>> +
>>>> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
>>>> +	if (!meminfo) {
>>>> +		error = -ENOMEM;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	meminfo->val = val;
>>>> +	meminfo->shift_for_page = shift;
>>>> +	strncpy(meminfo->name, name, NAME_SIZE);
>>>> +	len = strlen(meminfo->name);
>>>> +	meminfo->name[len] = ':';
>>>> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
>>>> +	while (++len < NAME_BUF_SIZE - 1)
>>>> +		meminfo->name_pad[len] = ' ';
>>>> +
>>>> +	spin_lock(&meminfo_lock);
>>>> +	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
>>>> +		if (memtemp->val == val) {
>>>> +			error = -EINVAL;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +	if (!error)
>>>> +		list_add_tail_rcu(&meminfo->list, &meminfo_head);
>>>> +	spin_unlock(&meminfo_lock);
>>> If you have a lock, why are you needing rcu?
>> I think _rcu should be removed out of list_for_each_entry_rcu.
>> But I'm confused about what you meant.
>> I used rcu_read_lock on __meminfo_extra,
>> and I think spin_lock is also needed for addition and deletion to handle multiple modifiers.
> If that's the case, then that's fine, it just didn't seem like that was
> needed.  Or I might have been reading your rcu logic incorrectly...
>
>>>> +	if (error)
>>>> +		kfree(meminfo);
>>>> +out:
>>>> +
>>>> +	return error;
>>>> +}
>>>> +EXPORT_SYMBOL(register_meminfo_extra);
>>> EXPORT_SYMBOL_GPL()?  I have to ask :)
>> I can use EXPORT_SYMBOL_GPL.
>>> thanks,
>>>
>>> greg k-h
>>>
>>>
>> Hello
>> Thank you for your comment.
>>
>> By the way there was not resolved discussion on v1 patch as I mentioned on cover page.
>> I'd like to hear your opinion on this /proc/meminfo_extra node.
> I think it is the propagation of an old and obsolete interface that you
> will have to support for the next 20+ years and yet not actually be
> useful :)
>
>> Do you think this is meaningful or cannot co-exist with other future
>> sysfs based API.
> What sysfs-based API?
Please refer to mail thread on v1 patch set - https://lkml.org/lkml/fancy/2020/3/10/2102
especially discussion with Leon Romanovsky on https://lkml.org/lkml/fancy/2020/3/16/140

>
> I still don't know _why_ you want this.  The ION stuff is not needed as
> that code is about to be deleted, so who else wants this?  What is the
> use-case for it that is so desperately needed that parsing
> yet-another-proc file is going to solve the problem?
In my Android device, there are graphic driver memory, zsmalloc memory except ION.
I don't know other cases in other platform.
Not desperately needed but I think we need one userspace knob to see overall hidden huge memory.

Additionally I'd like to see all those hidden memory in OutOfMemory log.
This is useful to get clue to find memory hogger.
i.e.) show_mem on oom
<6>[  420.856428]  Mem-Info:
<6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
<6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0

Thank you
Jaewon Kim
>
> thanks,
>
> greg k-h
>
>

