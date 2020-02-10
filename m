Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A991571D4
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 10:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJJgj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 04:36:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34143 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgBJJgi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 04:36:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so6721533wrr.1;
        Mon, 10 Feb 2020 01:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSMBBgHYZjC32JQ2hZUg1g8OrBnMTL0dXFRwmZKq0Uo=;
        b=Ya3l91ORMFVImxnlDGLWzCOl32yTNviXxrBwLvjwvk/VEOdalVqn0WY+rLtTFXUL1+
         1eNDB9kGQysir+uxgCG/cb0ACg9DRYnejCvYj8jvJoinCpb0uIJ1W6230dAfhTHWNmA4
         OK1CtipAXj3j7qvZoDH8SHAjTT1I4a6vRU68U+yB34qPlYSjEK1ymH1y5S3AFYZ4jvXE
         iy+2MBkfmjk5mYsZf3vdZx4zkZOWp6KKW/EFVf7rWCDSOakCoCOEURqEFKHWI4PkLn1S
         F8bYKMVyfnnaRvPx9ZZc/L6qmhcxi+pd32mNm66ItCratUV8gPJrxpnhFYwDT0t+6B0w
         NQWQ==
X-Gm-Message-State: APjAAAXS3Kc7x+l0z8VOSGJRv9BZ3gt0xJdo0Rqfrm1/h2bzhTWu189N
        YKj6+LCaSYZCYa+II0jaWkE=
X-Google-Smtp-Source: APXvYqzBpDvO5UNjtlf1RA9l7ko2o8/X6t/yRDDNfp3gd6fhIMrMsZSORLVs9mN0H4gOPEXruR4kag==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr883083wrq.331.1581327396641;
        Mon, 10 Feb 2020 01:36:36 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x10sm15044242wrv.60.2020.02.10.01.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 01:36:35 -0800 (PST)
Date:   Mon, 10 Feb 2020 10:36:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mtk.manpages@gmail.com, david@redhat.com,
        akpm@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] move_pages.2: Returning positive value is a new error
 case
Message-ID: <20200210093635.GC10636@dhcp22.suse.cz>
References: <1580757507-120233-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580757507-120233-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 04-02-20 03:18:27, Yang Shi wrote:
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
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

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
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
