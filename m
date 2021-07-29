Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1911B3DA0DF
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhG2KMU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhG2KMT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Jul 2021 06:12:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F5C061757;
        Thu, 29 Jul 2021 03:12:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso5428617wms.1;
        Thu, 29 Jul 2021 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N0ldVI5kdS6IBOEhDtb6u9xF2WeKeTbCnDMtPh9mu70=;
        b=digWUxw4l8jX+ruZgRTm5PBM2s8w3BsQ3pocvFNfw0NiuwqsjDLWIbmmaEueEXxtFI
         t0k2Szm5nmkGNnKs6zE45wCxz5jI/F7s0fGH2dos1n5UZBkEaKpuJbCWqPCqnvXvOpgs
         DT4m2w8W8vgcdf1ySjG2lTQGTCxv0XlvajXx1qZ1GXUiXVPEjK9ygxRMobau2GJ75j5L
         tbQg62pwaIIY6M4z48ZLrp4NA/OqQqvg8N9sDdEh39KlHxQOPjem+ArnMJIKzhXu7zcJ
         Wbozc6Q2wF0mMptwant7Al/CCkA+GmUUO/0jEtbfM6LIch0TEbhRjhbsLg+QBs/pWAoS
         YtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N0ldVI5kdS6IBOEhDtb6u9xF2WeKeTbCnDMtPh9mu70=;
        b=UfRoPzM3IKL6p0GtARwX+wuT0QonQZXnWFgsaZumigVYIMdgdG0YFggkjziBKu2E7Z
         WvVpoz03Z5l2XjGhpq1+xYY6O990n3s5OKDkibLnFYvhMxAUgsOywmCkQxEGAQpCxhN9
         bhD4kL+f7NHSKuigUa/Zf6ThBU0AijEelFJ/h1vBhC/wxMiwfaLH8jzAS76RFqts3KlS
         6ZahR92KmLavGKBHKsTWiMhPPvn3bbFFC/m9e4HRzjjfZcdFOySZR5tMV79K8EwmRjoJ
         ZRcVDMWmgOdwAutyMNvSWqZJwl+j6ixLnQ2c3iMyzMrbKKrFgZugbukgTRFtesjIR8+0
         kKNw==
X-Gm-Message-State: AOAM530tzOMRNAnefsiHfyM2ImMWkrK0X1HonmqHWBt1zzjF/fbEdLA6
        ifPbJ1z6DeDRyhgT7RPdasc=
X-Google-Smtp-Source: ABdhPJxBTzNTLJ1EDw1GN3uq1v4t4P7kiQlTetTG6y7wZY7YqwDM53qNsL4tNHWSFbOK602/nD/c6g==
X-Received: by 2002:a1c:2904:: with SMTP id p4mr3864131wmp.178.1627553534565;
        Thu, 29 Jul 2021 03:12:14 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id y6sm2606097wma.48.2021.07.29.03.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 03:12:14 -0700 (PDT)
Subject: Re: [PATCH v2] man2: new page describing memfd_secret() system call
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210729082900.1581359-1-rppt@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <3572b371-80ab-eac1-e2c5-26b07748f767@gmail.com>
Date:   Thu, 29 Jul 2021 12:12:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729082900.1581359-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Mike,

On 7/29/21 10:29 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> v2: address Alex's comments:
> * update synopsis to match new style for syscalls without a wrapper
> * drop note about absence of glibc wrapper
> * update formatting

Please check a small typo introduced in v2 below.

Thanks!

Alex

> 
> v1: https://lore.kernel.org/linux-api/20210727124140.1487079-1-rppt@kernel.org
> 
>   man2/memfd_secret.2 | 147 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 147 insertions(+)
>   create mode 100644 man2/memfd_secret.2
> 
> diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
> new file mode 100644
> index 000000000..5a70cb5d2
> --- /dev/null
> +++ b/man2/memfd_secret.2
> @@ -0,0 +1,147 @@
> +.\" Copyright (c) 2021, IBM Corporation.
> +.\" Written by Mike Rapoport <rppt@linux.ibm.com>
> +.\"
> +.\" Based on memfd_create(2) man page
> +.\" Copyright (C) 2014 Michael Kerrisk <mtk.manpages@gmail.com>
> +.\" and Copyright (C) 2014 David Herrmann <dh.herrmann@gmail.com>
> +.\"
> +.\" %%%LICENSE_START(GPLv2+)
> +.\"
> +.\" This program is free software; you can redistribute it and/or modify
> +.\" it under the terms of the GNU General Public License as published by
> +.\" the Free Software Foundation; either version 2 of the License, or
> +.\" (at your option) any later version.
> +.\"
> +.\" This program is distributed in the hope that it will be useful,
> +.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
> +.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +.\" GNU General Public License for more details.
> +.\"
> +.\" You should have received a copy of the GNU General Public
> +.\" License along with this manual; if not, see
> +.\" <http://www.gnu.org/licenses/>.
> +.\" %%%LICENSE_END
> +.\"
> +.TH MEMFD_SECRET 2 2020-08-02 Linux "Linux Programmer's Manual"
> +.SH NAME
> +memfd_secret \- create an anonymous file to access secret memory regions
> +.SH SYNOPSIS
> +.nf
> +.PP
> +.BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
> +.B #include <unistd.h>
> +.PP
> +.BI "int syscall(SYS_memfd_secret, int " cmd ", unsigned int " flags \
> +", int " cpu_id );

Check the parameter list :)



-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
