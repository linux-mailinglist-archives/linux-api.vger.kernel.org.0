Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9338B14DFE1
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2020 18:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgA3R1T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jan 2020 12:27:19 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:47826 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgA3R1T (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jan 2020 12:27:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TonDCBV_1580405233;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TonDCBV_1580405233)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Jan 2020 01:27:16 +0800
Subject: Re: [v2 PATCH] move_pages.2: Returning positive value is a new error
 case
To:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     mtk.manpages@gmail.com, akpm@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1580334531-80354-1-git-send-email-yang.shi@linux.alibaba.com>
 <f276d8ec-b1be-4f8e-792b-5c3ca2de4714@suse.cz>
 <20200130120253.GU24244@dhcp22.suse.cz>
 <cce2e784-8092-00f5-32bf-d23ab7a53476@suse.cz>
 <20200130134835.GW24244@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6f9642ee-5611-4eea-b904-c09cc02b0b17@linux.alibaba.com>
Date:   Thu, 30 Jan 2020 09:27:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200130134835.GW24244@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 1/30/20 5:48 AM, Michal Hocko wrote:
> On Thu 30-01-20 13:56:20, Vlastimil Babka wrote:
>> On 1/30/20 1:02 PM, Michal Hocko wrote:
>>> On Thu 30-01-20 10:06:28, Vlastimil Babka wrote:
>>>> On 1/29/20 10:48 PM, Yang Shi wrote:
>>>>> Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
>>>>> the semantic of move_pages() has changed to return the number of
>>>>> non-migrated pages if they were result of a non-fatal reasons (usually a
>>>>> busy page).  This was an unintentional change that hasn't been noticed
>>>>> except for LTP tests which checked for the documented behavior.
>>>>>
>>>>> There are two ways to go around this change.  We can even get back to the
>>>>> original behavior and return -EAGAIN whenever migrate_pages is not able
>>>> The manpage says EBUSY, not EAGAIN? And should its description be
>>>> updated too?
>>> The idea was that we _could_ return EAGAIN from the syscall if
>>> migrate_pages > 0.
>>>
>>>> I.e. that it's no longer returned since 4.17?
>>> I am pretty sure this will require a deeper consideration. Do we return
>>> EIO/EINVAL?
>> I thought the manpage says we return -EBUSY, but I misread it, this part
>> was not about errno, but the status array. So there's nothing to update
>> there, sorry about the noise.
>>
>> BTW, the suggestion to "Pre-initialization of the array to -1" means
>> effectively it's pre-initialized to -EPERM. That's fine now as -EPERM is
>> not one of the codes listed as possible to be returned via the array,
>> but perhaps it's not entirely future-proof?
> Hmm, I didn't realize EPERM is refering to 1. The wording however
> suggests also any other value that cannot represent a valid NUMA node.
> So maybe we should just drop the node about -1.

Or maybe we just say "any value which doesn't represent a valid NUMA 
node or valid error of status array"?


