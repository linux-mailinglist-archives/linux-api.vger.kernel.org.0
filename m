Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F9414D0F7
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 20:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgA2TFW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 14:05:22 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38583 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727515AbgA2TFV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 14:05:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TojqI9z_1580324714;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TojqI9z_1580324714)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Jan 2020 03:05:17 +0800
Subject: Re: [PATCH] move_pages.2: Returning positive value is a new error
 case
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mtk.manpages@gmail.com, akpm@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1580322632-93332-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200129185842.GP24244@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <0db6a002-d067-8acd-65ee-8c87a32ff769@linux.alibaba.com>
Date:   Wed, 29 Jan 2020 11:05:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200129185842.GP24244@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 1/29/20 10:58 AM, Michal Hocko wrote:
> On Thu 30-01-20 02:30:32, Yang Shi wrote:
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
> Thanks a lot! Looks good to me. I would just add a note that it is
> generally recommended to pre-initialize status array by -1 to have a
> reliable way to check which pages have been migrated. The man page says
> "The array contains valid values only if move_pages() did not return an
> error."
>
> I would just add. "Pre initialization of the array to -1 or similar
> value which cannot represent a real numa node could help to identify
> pages that have been migrated".

Sure. Adding this note right after the explanation of positive value 
error seems fine?

>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
>> ---
>>   man2/move_pages.2 | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/man2/move_pages.2 b/man2/move_pages.2
>> index 1bf1053..c6cf3f8 100644
>> --- a/man2/move_pages.2
>> +++ b/man2/move_pages.2
>> @@ -164,9 +164,13 @@ returns zero.
>>   .\" do the right thing?
>>   On error, it returns \-1, and sets
>>   .I errno
>> -to indicate the error.
>> +to indicate the error. Or positive value to report the number of
>> +non-migrated pages.
>>   .SH ERRORS
>>   .TP
>> +.B Positive value
>> +The number of non-migrated pages if they were result of a non-fatal
>> +reasons since version 4.17.
>>   .B E2BIG
>>   Too many pages to move.
>>   Since Linux 2.6.29,
>> -- 
>> 1.8.3.1

