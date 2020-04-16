Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE021ABF75
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633747AbgDPLgG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505994AbgDPLfz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Apr 2020 07:35:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1A8C061A0C;
        Thu, 16 Apr 2020 04:35:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so4354328wrm.13;
        Thu, 16 Apr 2020 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a4ieNNuZ6tLA+4dVx4dh3yTVKKcJr6C5Xg+XaxMx+Wg=;
        b=Xfj9q5psuqNGyruPOiyZQ5NsusUUXpygmybW5Hv5TZdygCMy8/o/ki8bANCMygOLGT
         iXgeNYCK8Cvy4d4GgZUoTOoLHNAsNjiI7Dq/rHmZOFdz2ln/q5YjfbeXNwG98/D5tSuI
         4Y9r4cgLtNoG7erSuacGmi2YfbrilgXp6mopSQGHDHoOD0NjsidIFrqUiMy5MslD/qhv
         k+5+fk5Lp5AhOYOqq/HXAwjxw7U6iy9z6JflCDB0rTp37D81rdyhO89YUSK2/kwnM1lk
         VdZJ55PJZm3pTX7rxtSPn2SKeUYjuDlcPWxF8ftDQIugFYgvRPUxcHYou+KHlS6I367c
         8kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4ieNNuZ6tLA+4dVx4dh3yTVKKcJr6C5Xg+XaxMx+Wg=;
        b=AxT4Xztsy+ir7zgpP2vLXQ1DrghLhkPv13zw7eiQxH1r6S4X/ccKwAXNbw4h4uch77
         8B5KvbTk+iwPUAm+t2Rzs4BxYs+/+VsyCkEAVrkczxf90kROLzZH1+IdTKYDxf+cVRS9
         N19w67upx7H6qiNIg6ihSi7/ts+HWyJxtBNrHROsNvHKnWxPWkJpNRKwfuiUwUMrH9gg
         gj77+G3wivR1E3WdEcmOrOq3xxKjqyQvzbkg5lKa2KQrFM1tsFj2NuZbfYuyJdDIhFbj
         25I7WqSQ3FVNDahCiDbyehZoHF/DAdvPSupKGZOJEtvktPUu2/eOD68kMTKy0/r8uVgx
         qTnQ==
X-Gm-Message-State: AGi0PuZBznUMkOZdE0j4i7jlrevU4yVFJodxCeyRClkHkjtv9SVFLQjp
        C7+LLgXdbLD5M30AwsooBMivdAfn
X-Google-Smtp-Source: APiQypIacuw32clGX4yFy7n896znzlZ0b59ACM2KJOOVsycKPEDJ92FJ+0tV1dNTDMjtldFw1Nkl4g==
X-Received: by 2002:adf:e791:: with SMTP id n17mr27110600wrm.217.1587036953145;
        Thu, 16 Apr 2020 04:35:53 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id t20sm3391884wmi.2.2020.04.16.04.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 04:35:52 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] move_pages.2: Returning positive value is a new error
 case
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@suse.com,
        david@redhat.com, akpm@linux-foundation.org
References: <1580757507-120233-1-git-send-email-yang.shi@linux.alibaba.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <033ce46c-74c6-7e9f-d89c-cd184a891e1c@gmail.com>
Date:   Thu, 16 Apr 2020 13:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1580757507-120233-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Yang Shi,

On 2/3/20 8:18 PM, Yang Shi wrote:
> Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
> the semantic of move_pages() has changed to return the number of
> non-migrated pages if they were result of a non-fatal reasons (usually a
> busy page).  This was an unintentional change that hasn't been noticed
> except for LTP tests which checked for the documented behavior.
> 
> There are two ways to go around this change.  We can even get back to the
> original behavior and return -EAGAIN whenever migrate_pages is not able
> to migrate pages due to non-fatal reasons.  Another option would be to
> simply continue with the changed semantic and extend move_pages
> documentation to clarify that -errno is returned on an invalid input or
> when migration simply cannot succeed (e.g. -ENOMEM, -EBUSY) or the
> number of pages that couldn't have been migrated due to ephemeral
> reasons (e.g. page is pinned or locked for other reasons).
> 
> We decided to keep the second option in kernel because this behavior is in
> place for some time without anybody complaining and possibly new users
> depending on it.  Also it allows to have a slightly easier error handling
> as the caller knows that it is worth to retry when err > 0.
> 
> Update man pages to reflect the new semantic.

Thanks for the patch. I've applied it.

@Michal: thanks for the Ack.

Cheers,

Michael

> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v3: * Fixed the comments from David Hildenbrand.
>     * Fixed the inaccuracy about pre-initialized status array values.
> v2: * Added notes about status array per Michal.
>     * Added Michal's Acked-by.
> 
>  man2/move_pages.2 | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> index 1bf1053..50c83a4 100644
> --- a/man2/move_pages.2
> +++ b/man2/move_pages.2
> @@ -104,7 +104,9 @@ pages that need to be moved.
>  is an array of integers that return the status of each page.
>  The array contains valid values only if
>  .BR move_pages ()
> -did not return an error.
> +did not return an error.  Pre-initialization of the array to the value
> +which cannot represent a real numa node or valid error of status array
> +could help to identify pages that have been migrated
>  .PP
>  .I flags
>  specify what types of pages to move.
> @@ -164,9 +166,13 @@ returns zero.
>  .\" do the right thing?
>  On error, it returns \-1, and sets
>  .I errno
> -to indicate the error.
> +to indicate the error. If positive value is returned, it is the number of
> +non-migrated pages.
>  .SH ERRORS
>  .TP
> +.B Positive value
> +The number of non-migrated pages if they were the result of non-fatal
> +reasons (since version 4.17).
>  .B E2BIG
>  Too many pages to move.
>  Since Linux 2.6.29,
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
