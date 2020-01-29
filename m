Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA81514D0C3
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 19:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgA2S6q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 13:58:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46487 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbgA2S6q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 13:58:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so677917wrl.13;
        Wed, 29 Jan 2020 10:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GsWVLKic92GtxCUorsUXtFluyqDSQVQyet+6x8x0QOA=;
        b=klfGcMiLp65ec/40x265vTnh1ucD5Ig+UzH+sDJo7T4Si+zq/Vujccf0JO+cOiKIMk
         PH6g8G+JXmu3a91+PMecsNvEx+s7lvEw3M3kL+O5UMThwk5DR8PRc0P9Xeg86VN+0IW4
         c+0ttsZKJJeqeGXlbqnaWtSLCDFQTv9YselqX469wCuRRAmi8VNYUmexOoxSGsjbxA6H
         3yXVJcjhaWn5DhsigYEMVENvrJ+BHBG7YgAnh7K7OYOqX8zzqfpg9sTRhQeYYd9ZEnfj
         MPJD/xAnKMviCABpChUAMOl0Ig+65egsG75Wmz4ZyXqdn9vrCLpWpAwD9VVE2JfriJfO
         7SgA==
X-Gm-Message-State: APjAAAWAJKHpreXN6WseB4PHV/EQKOrw5KtldfXZlbQeFSemCl4PGuMh
        gk19IbuVNFnYI4Whl4KDWXX0zSiG
X-Google-Smtp-Source: APXvYqzo5VG3GcA1V9l4HggoKbcu/wKCAaRVFi+3RNALt3YLKU4l8ohhyy9Lnsy20EWBElBuogjX2Q==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr265708wrq.314.1580324324634;
        Wed, 29 Jan 2020 10:58:44 -0800 (PST)
Received: from localhost (ip-37-188-238-177.eurotel.cz. [37.188.238.177])
        by smtp.gmail.com with ESMTPSA id d12sm3977076wrp.62.2020.01.29.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 10:58:43 -0800 (PST)
Date:   Wed, 29 Jan 2020 19:58:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mtk.manpages@gmail.com, akpm@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move_pages.2: Returning positive value is a new error
 case
Message-ID: <20200129185842.GP24244@dhcp22.suse.cz>
References: <1580322632-93332-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580322632-93332-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 30-01-20 02:30:32, Yang Shi wrote:
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

Thanks a lot! Looks good to me. I would just add a note that it is
generally recommended to pre-initialize status array by -1 to have a
reliable way to check which pages have been migrated. The man page says
"The array contains valid values only if move_pages() did not return an
error."

I would just add. "Pre initialization of the array to -1 or similar
value which cannot represent a real numa node could help to identify
pages that have been migrated".

> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  man2/move_pages.2 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> index 1bf1053..c6cf3f8 100644
> --- a/man2/move_pages.2
> +++ b/man2/move_pages.2
> @@ -164,9 +164,13 @@ returns zero.
>  .\" do the right thing?
>  On error, it returns \-1, and sets
>  .I errno
> -to indicate the error.
> +to indicate the error. Or positive value to report the number of
> +non-migrated pages.
>  .SH ERRORS
>  .TP
> +.B Positive value
> +The number of non-migrated pages if they were result of a non-fatal
> +reasons since version 4.17.
>  .B E2BIG
>  Too many pages to move.
>  Since Linux 2.6.29,
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
