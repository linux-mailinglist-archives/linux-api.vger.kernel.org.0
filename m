Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F403F1663DB
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 18:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTRGN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 12:06:13 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59432 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727915AbgBTRGM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 12:06:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TqSIWZ0_1582218362;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TqSIWZ0_1582218362)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Feb 2020 01:06:05 +0800
Subject: Re: [v3 PATCH] move_pages.2: Returning positive value is a new error
 case
To:     mtk.manpages@gmail.com
Cc:     Michal Hocko <mhocko@kernel.org>, david@redhat.com,
        akpm@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1580757507-120233-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200210093635.GC10636@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <92f30e24-7b77-b21a-ed3a-efc55bc500c6@linux.alibaba.com>
Date:   Thu, 20 Feb 2020 09:06:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200210093635.GC10636@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2/10/20 1:36 AM, Michal Hocko wrote:
> On Tue 04-02-20 03:18:27, Yang Shi wrote:
>> Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
>> the semantic of move_pages() has changed to return the number of
>> non-migrated pages if they were result of a non-fatal reasons (usually a
>> busy page).  This was an unintentional change that hasn't been noticed
>> except for LTP tests which checked for the documented behavior.
>>
>> There are two ways to go around this change.  We can even get back to the
>> original behavior and return -EAGAIN whenever migrate_pages is not able
>> to migrate pages due to non-fatal reasons.  Another option would be to
>> simply continue with the changed semantic and extend move_pages
>> documentation to clarify that -errno is returned on an invalid input or
>> when migration simply cannot succeed (e.g. -ENOMEM, -EBUSY) or the
>> number of pages that couldn't have been migrated due to ephemeral
>> reasons (e.g. page is pinned or locked for other reasons).
>>
>> We decided to keep the second option in kernel because this behavior is in
>> place for some time without anybody complaining and possibly new users
>> depending on it.  Also it allows to have a slightly easier error handling
>> as the caller knows that it is worth to retry when err > 0.
>>
>> Update man pages to reflect the new semantic.
>>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Hi Michael,

Would you please consider take this patch? The kernel change has been 
upstreamed.

Thanks,
Yang

> Acked-by: Michal Hocko <mhocko@suse.com>
>
>> ---
>> v3: * Fixed the comments from David Hildenbrand.
>>      * Fixed the inaccuracy about pre-initialized status array values.
>> v2: * Added notes about status array per Michal.
>>      * Added Michal's Acked-by.
>>
>>   man2/move_pages.2 | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/man2/move_pages.2 b/man2/move_pages.2
>> index 1bf1053..50c83a4 100644
>> --- a/man2/move_pages.2
>> +++ b/man2/move_pages.2
>> @@ -104,7 +104,9 @@ pages that need to be moved.
>>   is an array of integers that return the status of each page.
>>   The array contains valid values only if
>>   .BR move_pages ()
>> -did not return an error.
>> +did not return an error.  Pre-initialization of the array to the value
>> +which cannot represent a real numa node or valid error of status array
>> +could help to identify pages that have been migrated
>>   .PP
>>   .I flags
>>   specify what types of pages to move.
>> @@ -164,9 +166,13 @@ returns zero.
>>   .\" do the right thing?
>>   On error, it returns \-1, and sets
>>   .I errno
>> -to indicate the error.
>> +to indicate the error. If positive value is returned, it is the number of
>> +non-migrated pages.
>>   .SH ERRORS
>>   .TP
>> +.B Positive value
>> +The number of non-migrated pages if they were the result of non-fatal
>> +reasons (since version 4.17).
>>   .B E2BIG
>>   Too many pages to move.
>>   Since Linux 2.6.29,
>> -- 
>> 1.8.3.1

