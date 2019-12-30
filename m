Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6D12D39D
	for <lists+linux-api@lfdr.de>; Mon, 30 Dec 2019 19:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfL3SzK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 13:55:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36457 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3SzK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 13:55:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so18416989pgc.3;
        Mon, 30 Dec 2019 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JdJt+MkTze/hUL4TVQW3KhBaiLuTd3kBvUR3FwEU5Qw=;
        b=T6AA3Yq/E4xHEiE7UOJsSe1KBwiqHKjsKD3ArwTMGiohKMNoVDMofdNq01gXlwH34r
         T9XC5fOv6Nj+jsRWl/vRe/kOmd0Q0Hvlg7Iw6wUEh4xZsM1YHHt7FcJif9vPKTsV36jL
         lYERwYnk3pfk12AySePtOfArgV+PUQjhBeFvtd1DLNfclobWTW4UxjK5UTJmy/toxQuw
         oklCnQQ1j8Y9F/jrT/NEOS30MnrISV+pqYyzq6InronTrTowXdos+KxnZV9yKUWYJqOs
         7eyOd6OceiJWsNOJs0j9EgZGZUAIaXhqZLmhmJAWmaPwleHjiMqHFV1Q1Rmpf3SpBsVR
         kx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JdJt+MkTze/hUL4TVQW3KhBaiLuTd3kBvUR3FwEU5Qw=;
        b=aHXSi4LEWjWLln9sFvFIf4XD3F6EZg2bHhRtb63DTQEm72R87NVdeUo5ZYzfmmluDv
         wNRm1axUQ/p6R7CvocE+jHGTgtC377Lhxtt0QsA9+EeUYlJPih6v/sZTcSNcrLvxOoPx
         SVSl+Pmns0aLx66e2hXtKaPrDyEy4BOwJ+mmKONRXz1zG9p14wVl7dKHFAQO+RUamPGI
         uqOrCAwmX4aPuguqwEd32ZUpHOBfgkO1y0MZA5k0CGwu8YasZRdtfjyEUrw1qVpzJLfh
         BIX7LygcpdT0yqU7zh83EIIJlmLocdqv9hhxqkrONMevw4mzyNPnO3XJfs5ADga4mdQi
         pdZg==
X-Gm-Message-State: APjAAAU6m23dxYWZSkEX/e1bPOcIaODzq9sfCPBM4SgKcIX2UiSwjS7k
        xf5YaHr6SoiBlzQ4Tjhy+SU=
X-Google-Smtp-Source: APXvYqw/u/vrkEjBsO4sYGwrIEsbNFY8YSrXJiBBJg43B8OEOUKe0HXjYIYafjiDENaioXycrkGe+A==
X-Received: by 2002:a62:788a:: with SMTP id t132mr73222512pfc.134.1577732109926;
        Mon, 30 Dec 2019 10:55:09 -0800 (PST)
Received: from [192.168.178.94] ([121.98.29.40])
        by smtp.gmail.com with ESMTPSA id y7sm44922524pfb.139.2019.12.30.10.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 10:55:08 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] move_pages.2: remove ENOENT from the list of possible
 return values
To:     John Hubbard <jhubbard@nvidia.com>
References: <20191219051347.1278026-1-jhubbard@nvidia.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <56530a26-e5b4-1441-521b-8dc6580f90c7@gmail.com>
Date:   Mon, 30 Dec 2019 19:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219051347.1278026-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello John,

On 12/19/19 6:13 AM, John Hubbard wrote:
> Linux kernel commit e78bbfa82624 ("mm: stop returning -ENOENT from
> sys_move_pages() if nothing got migrated") had the effect of *never*
> returning -ENOENT, in any situation. So we need to update the man page
> to reflect that ENOENT is not a possible return value.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Christoph Lameter <cl@linux.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> This fix for the man page was ACK'd by Michal, here:
> 
> https://lore.kernel.org/r/20191218101711.GB21485@dhcp22.suse.cz

Thanks. Patch applied.

Cheers,

Michael

>  man2/move_pages.2 | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> index 2d96468fa..1bf1053f2 100644
> --- a/man2/move_pages.2
> +++ b/man2/move_pages.2
> @@ -191,12 +191,6 @@ was specified or an attempt was made to migrate pages of a kernel thread.
>  .B ENODEV
>  One of the target nodes is not online.
>  .TP
> -.B ENOENT
> -No pages were found that require moving.
> -All pages are either already
> -on the target node, not present, had an invalid address or could not be
> -moved because they were mapped by multiple processes.
> -.TP
>  .B EPERM
>  The caller specified
>  .B MPOL_MF_MOVE_ALL
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
