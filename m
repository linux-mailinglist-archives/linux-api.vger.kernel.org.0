Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3D32C693
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355520AbhCDA3S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390132AbhCCWCA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Mar 2021 17:02:00 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C63C061756
        for <linux-api@vger.kernel.org>; Wed,  3 Mar 2021 13:52:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bm21so26419171ejb.4
        for <linux-api@vger.kernel.org>; Wed, 03 Mar 2021 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ule00/q7HX84OWwF406gDgGyERbFTpWlz3Kr8aowLtk=;
        b=MEIFZsawybl0SFyEKqDr8seajr1wemtkm8Y3LG8LE3nlk7lOWdFYYj347UxRb+H5HP
         TQvddfdQdF/8p1pdWrrTbHaKJPy8RilCcxGCFnOA+RLFr7EiRv+tKAkZ6FcaFpeigIxn
         4ZlaPzR+HTY86VXgvYqn7iYRTljh1YCi974jWgVqqxxOE0sgc5oDmfDtCH0F9x/calu7
         jFil5hjz+wrdnB3zsmesZ0RPduhH0NjVjyEPkk9C1NaS/627zyVGyNkJemsk7+lYv8Q1
         a+z7e1exscugU8JWBlg3XSHS65dbQoX+Lj/A2IgCHWrPR2/mK2brUlYIWucTLL+5Wgs0
         VuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ule00/q7HX84OWwF406gDgGyERbFTpWlz3Kr8aowLtk=;
        b=GUxPBJ+RMTNOrI/g9i3D3GJDKINEuG9iw1le0Oiu01mKM1j0UUtbNyOvoybP25xF3G
         udIUKwsxvUANCVxmZ6mqnENzM24KTuU4xH/qpGG0I9OcAiDW75lfkIa2KBlAiMz08/7/
         oCgFV81Ma4lD8gWQHHxY/Y+HgQcKsluylwGkPOmcU0BYEivrEK8w7rZP1SlalrLMBgx+
         ipMzdqLYezfh7dZX3Lp/sXQNq3elgP03+WhptwnifXsbmTAR8URpfQu3rdAq70JEByTV
         605QYGUdxf3RMMPynlEKY6Hf8yRFZk+oEeL5T9JUrA5BL23mC+RRwRFjTYHwwQ7WnpYQ
         H8Mw==
X-Gm-Message-State: AOAM530COkIVyYGvEVt3hhUkKiBYX/Hn5cRiseBr7aHpnz0++aXXksTf
        IIo9qnrGAdjV0MccF6gNZeoADnkJ+jIrkw==
X-Google-Smtp-Source: ABdhPJzmSHU96VSDyqk0V2Hlat3vjtWje8asxOLw35C6ZZjzW+/KG7QMnsJEHCTG4XD6P8cZ8EX4zg==
X-Received: by 2002:a17:906:d9d1:: with SMTP id qk17mr814216ejb.52.1614808359885;
        Wed, 03 Mar 2021 13:52:39 -0800 (PST)
Received: from ?IPv6:2001:a61:3a2d:1d01:99ab:4f20:ed7f:402b? ([2001:a61:3a2d:1d01:99ab:4f20:ed7f:402b])
        by smtp.gmail.com with ESMTPSA id jj16sm21507346ejc.19.2021.03.03.13.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 13:52:39 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: exclude uapi directories in API/ABI section
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAKgNAkiVWvzQOwRGOdSoh8JY-DpxcF6pWdLWNK4RHFdN-d6=+w@mail.gmail.com>
 <20210301100255.25229-1-vbabka@suse.cz>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <55ec3d9c-5c11-2c4c-2fb4-3cc985b7b0b6@gmail.com>
Date:   Wed, 3 Mar 2021 22:52:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210301100255.25229-1-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/1/21 11:02 AM, Vlastimil Babka wrote:
> Commit 7b4693e644cb ("MAINTAINERS: add uapi directories to API/ABI section")
> added include/uapi/ and arch/*/include/uapi/ so that patches modifying them
> CC linux-api. However that was already done in the past and resulted in too
> much noise and thus later removed, as explained in b14fd334ff3d ("MAINTAINERS:
> trim the file triggers for ABI/API")
> 
> To prevent another round of addition and removal in the future, change the
> entries to X: (explicit exclusion) for documentation purposes, although they
> are not subdirectories of broader included directories, as there is apparently
> no defined way to add plain comments in subsystem sections.
> 
> Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d92f85ca831d..591829cd1ba4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -261,8 +261,8 @@ ABI/API
>  L:	linux-api@vger.kernel.org
>  F:	include/linux/syscalls.h
>  F:	kernel/sys_ni.c
> -F:	include/uapi/
> -F:	arch/*/include/uapi/
> +X:	include/uapi/
> +X:	arch/*/include/uapi/
>  
>  ABIT UGURU 1,2 HARDWARE MONITOR DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
> 

Thanks, Vlastimil.

Acked-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
