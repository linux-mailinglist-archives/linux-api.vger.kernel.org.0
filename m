Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78F114F2E3
	for <lists+linux-api@lfdr.de>; Fri, 31 Jan 2020 20:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgAaTlA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 Jan 2020 14:41:00 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60681 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgAaTlA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 Jan 2020 14:41:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tor2FsR_1580499655;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tor2FsR_1580499655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 01 Feb 2020 03:40:57 +0800
Subject: Re: [PATCH] move_pages.2: Returning positive value is a new error
 case
To:     David Hildenbrand <david@redhat.com>, mhocko@suse.com,
        mtk.manpages@gmail.com, akpm@linux-foundation.org
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1580322632-93332-1-git-send-email-yang.shi@linux.alibaba.com>
 <9aac5bff-3a18-ec5f-5aa0-82c38d367590@redhat.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <f49736e1-316f-57d4-cd25-5f75b145e033@linux.alibaba.com>
Date:   Fri, 31 Jan 2020 11:40:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9aac5bff-3a18-ec5f-5aa0-82c38d367590@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 1/31/20 2:49 AM, David Hildenbrand wrote:
> On 29.01.20 19:30, Yang Shi wrote:
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
> "If a positive value is returned, it's the number of non-migrated pages".
>
>>   .SH ERRORS
>>   .TP
>> +.B Positive value
>> +The number of non-migrated pages if they were result of a non-fatal
>> +reasons since version 4.17.
> s/result/the result/ ?
>
> s/a reasons/reasons/ ?
>
> s/since version 4.17/(since 4.17)/ ?

Thanks. Will fix in new version.

>
>>   .B E2BIG
>>   Too many pages to move.
>>   Since Linux 2.6.29,
>>
>

