Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3468614EB47
	for <lists+linux-api@lfdr.de>; Fri, 31 Jan 2020 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgAaKt3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 Jan 2020 05:49:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58277 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728330AbgAaKt3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 Jan 2020 05:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580467767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=6g836X9vOoU03aXRvzjflcski+9r2i7SCCt7FG9rHvk=;
        b=DlRQT2VktcLAWLnDw+reqsaV55Bk/FMOdqLuSKSEF+7RTS4Jvqo77AXvMjRgCvNTVtUPBU
        g2yuKsJ48thvI8KGbOg/5N7IAOHOvoTWIU7vTEIkzVbUezvyIt8Axm5jQGVwMjpPLSIFeI
        tdbvDgPJq1GZa3IIEKuuGhHO4H48oJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-pFB9EbfGNQKkRpV4AByLPA-1; Fri, 31 Jan 2020 05:49:23 -0500
X-MC-Unique: pFB9EbfGNQKkRpV4AByLPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7913413E5;
        Fri, 31 Jan 2020 10:49:22 +0000 (UTC)
Received: from [10.36.117.243] (ovpn-117-243.ams2.redhat.com [10.36.117.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5465883861;
        Fri, 31 Jan 2020 10:49:20 +0000 (UTC)
Subject: Re: [PATCH] move_pages.2: Returning positive value is a new error
 case
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@suse.com,
        mtk.manpages@gmail.com, akpm@linux-foundation.org
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1580322632-93332-1-git-send-email-yang.shi@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <9aac5bff-3a18-ec5f-5aa0-82c38d367590@redhat.com>
Date:   Fri, 31 Jan 2020 11:49:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1580322632-93332-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 29.01.20 19:30, Yang Shi wrote:
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

"If a positive value is returned, it's the number of non-migrated pages".

>  .SH ERRORS
>  .TP
> +.B Positive value
> +The number of non-migrated pages if they were result of a non-fatal
> +reasons since version 4.17.

s/result/the result/ ?

s/a reasons/reasons/ ?

s/since version 4.17/(since 4.17)/ ?

>  .B E2BIG
>  Too many pages to move.
>  Since Linux 2.6.29,
> 


-- 
Thanks,

David / dhildenb

