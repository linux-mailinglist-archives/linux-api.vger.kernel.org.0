Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE02F12D5E2
	for <lists+linux-api@lfdr.de>; Tue, 31 Dec 2019 04:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfLaDAw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 22:00:52 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40123 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfLaDAv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 22:00:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TmNRedc_1577761244;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TmNRedc_1577761244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Dec 2019 11:00:47 +0800
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
To:     Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        cl@linux.com, cai@lca.pw, akpm@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
 <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
 <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
 <092adc11-7039-9343-7067-0e0199c9dc13@gmail.com>
 <51dd767a-221f-882d-c7f6-45bd0c217a67@nvidia.com>
 <20191218101711.GB21485@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <0059a598-5726-2488-cd37-b4b7f9b3353e@linux.alibaba.com>
Date:   Mon, 30 Dec 2019 19:00:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191218101711.GB21485@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 12/18/19 2:17 AM, Michal Hocko wrote:
> On Tue 17-12-19 23:36:09, John Hubbard wrote:
> [...]
>> diff --git a/man2/move_pages.2 b/man2/move_pages.2
>> index 2d96468fa..1bf1053f2 100644
>> --- a/man2/move_pages.2
>> +++ b/man2/move_pages.2
>> @@ -191,12 +191,6 @@ was specified or an attempt was made to migrate pages of a kernel thread.
>>   .B ENODEV
>>   One of the target nodes is not online.
>>   .TP
>> -.B ENOENT
>> -No pages were found that require moving.
>> -All pages are either already
>> -on the target node, not present, had an invalid address or could not be
>> -moved because they were mapped by multiple processes.
>> -.TP
>>   .B EPERM
>>   The caller specified
>>   .B MPOL_MF_MOVE_ALL
>>
>> ...But I'm not sure if we should change the implementation, instead, so
>> that it *can* return ENOENT. That's the main question to resolve before
>> creating any more patches, I think.
> I would start by dropping any note about ENOENT first. I am not really
> sure there is a reasonable usecase for it but maybe somebody comes up
> with something and only then we should consider it.
>
> Feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> ideally with a kernel commit which removed the ENOENT.

A quick audit doesn't show kernel code or comment notes about ENOENT 
wrongly. The status could be set as ENOENT if the page is not present 
(follow_page() returns NULL), and man page does match what kernel does.


