Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE212D5D7
	for <lists+linux-api@lfdr.de>; Tue, 31 Dec 2019 03:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfLaCth (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 21:49:37 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45542 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbfLaCth (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 21:49:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TmNSLzV_1577760569;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TmNSLzV_1577760569)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Dec 2019 10:49:32 +0800
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
To:     John Hubbard <jhubbard@nvidia.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        cl@linux.com, mhocko@suse.com, cai@lca.pw,
        akpm@linux-foundation.org
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
 <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
 <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
 <092adc11-7039-9343-7067-0e0199c9dc13@gmail.com>
 <51dd767a-221f-882d-c7f6-45bd0c217a67@nvidia.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <51a37061-8d95-eca1-a1d9-e6e8f4dc884d@linux.alibaba.com>
Date:   Mon, 30 Dec 2019 18:49:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <51dd767a-221f-882d-c7f6-45bd0c217a67@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 12/17/19 11:36 PM, John Hubbard wrote:
> On 12/13/19 5:55 PM, Michael Kerrisk (man-pages) wrote:
> ...
>>>> whoa, hold on. If I'm reading through the various error paths
>>>> correctly, then this
>>>> code is *never* going to return ENOENT for the whole function. It can
>>>> fill in that
>>>> value per-page, in the status array, but that's all. Did I get that
>>>> right?
>>>
>>> Nice catch. Yes, you are right.
>>>
>>>>
>>>> If so, we need to redo this part of the man page.
>>>
>>> Yes.
>>
>> So where are things at with this? Is an improved man-pages
>> patch on the way, or is some other action (on the API) planned?
>>
>
> I was waiting to see if Yang was going to respond...anyway, I think
> we're looking at approximately this sort of change:
>

Hi John,

I apologize for the delay, just came back from vacation. Thanks for 
taking care of the patch.

> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> index 2d96468fa..1bf1053f2 100644
> --- a/man2/move_pages.2
> +++ b/man2/move_pages.2
> @@ -191,12 +191,6 @@ was specified or an attempt was made to migrate 
> pages of a kernel thread.
>  .B ENODEV
>  One of the target nodes is not online.
>  .TP
> -.B ENOENT
> -No pages were found that require moving.
> -All pages are either already
> -on the target node, not present, had an invalid address or could not be
> -moved because they were mapped by multiple processes.
> -.TP
>  .B EPERM
>  The caller specified
>  .B MPOL_MF_MOVE_ALL
>
> ...But I'm not sure if we should change the implementation, instead, so
> that it *can* return ENOENT. That's the main question to resolve before
> creating any more patches, I think.
>
> In addition, Michal mentioned that the page states in the status array 
> also
> need updated documentation.
>
>
> thanks,

