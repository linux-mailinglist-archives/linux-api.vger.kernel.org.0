Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229E51E0FCA
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbgEYNss (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 09:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403812AbgEYNss (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 09:48:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD47BC061A0E;
        Mon, 25 May 2020 06:48:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e10so15075037edq.0;
        Mon, 25 May 2020 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bsodKESnkmQbm8kGTghucJvkkflT43E//YuHmUQP0so=;
        b=d/6LFraWFpzIt829OMp0qdlzxb7qLJHmOJRzUMTl3b/8CdfQfBWRjScPXe7GyrkfTE
         Nunp+Zn4tynqzhIXVPPhTMRSgHoPQnBLcVMprv4YMUO2JWTdsrclpT6fpR1PwPJtzqGw
         qdtUufCF6e4zgnMJLhRljOwxFhIqfqrwPdp4l3AZ2zB0v0nT8aAR+dLLvo93C0bqLUSb
         tvwuDf8rfdWRZG5TiQfw00TH74sUs9Zd/JrpH+zd9Njdk93xrtyz3zGtB4zCCaG0hUmc
         e0zl5NKofg604H8vtu+KjRTGnOZMtDnWwf0yi8+wMRyErUXYFYHRVYWEZ7nipii81XmP
         t8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bsodKESnkmQbm8kGTghucJvkkflT43E//YuHmUQP0so=;
        b=TFWguu+d3j0Dg65qfRlmp0zO1TDkYUvYcz760+zyJMLTsLXOIZdCMCyoBTfP0DYrcO
         AS+aNa2/9qxesV1cH4BygMZuOeBOyTgR9hErxXtPOF2EEQfysTXcJnjbOFIhfy/0QKdo
         hkyAGi5KvoAUgvJal1HrnO7j0dAskxBy9UuC4zwdr9qn0WnEybvYLXdddp7nqwubE09e
         1I+94MliCGpCXvgC3NZ9XHuAY53XrnI8L+/90u07TVMn+Q+H+NOhhKlRjNAFZE4ubZcQ
         ouTugx28cAKA0aCfIVJqMnGHqwn5lUST5sQFsLJpD9mzCReLv7tHpI8CBkJKiE1+3L0y
         6fnA==
X-Gm-Message-State: AOAM532Gt0HOwAau44SkcbCrV+RfNr9udet/+yM98512C3sDoFgXUWcD
        Wy3d5TMXCL/uSeowHMeHISg=
X-Google-Smtp-Source: ABdhPJx9V0tDTBXxtgMvZVVyvBBUY2f9hm7WzhyWwqW4Az/lkfW8GWuqv9f74twyWzmM7sGudiwqXg==
X-Received: by 2002:a50:9b19:: with SMTP id o25mr15843499edi.141.1590414526514;
        Mon, 25 May 2020 06:48:46 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id by21sm15244875ejb.93.2020.05.25.06.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 06:48:45 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, nilal@redhat.com,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Colm_MacC=c3=a1rtaigh?= <colm@allcosts.net>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] proc.5: add "wf" to VmFlags in /proc/[pid]/smaps
To:     Ian Rogers <irogers@google.com>, Rik van Riel <riel@redhat.com>
References: <20200521222551.259804-1-irogers@google.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <72cb0b2e-4487-c3f3-4406-572f146be91a@gmail.com>
Date:   Mon, 25 May 2020 15:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521222551.259804-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Ian,

On 5/22/20 12:25 AM, Ian Rogers wrote:
> This patch documents a flag added in the following kernel commit:
> 
> commit d2cd9ede6e193dd7d88b6d27399e96229a551b19
> Author: Rik van Riel <riel@redhat.com>
> Date:   Wed Sep 6 16:25:15 2017 -0700
> 
>     mm,fork: introduce MADV_WIPEONFORK
> 
> This was already documented in man2/madvise.2 in the commit:
> 
> commit c0c4f6c29c494c466f3a2a6273c5b55b76a72927
> Author: Rik van Riel <riel@redhat.com>
> Date:   Tue Sep 19 20:32:00 2017 +0200
> 
>     madvise.2: Document MADV_WIPEONFORK and MADV_KEEPONFORK

Thanks. Patch applied.

Cheers,

Michael

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  man5/proc.5 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/man5/proc.5 b/man5/proc.5
> index 46d603f28..3e5b91af0 100644
> --- a/man5/proc.5
> +++ b/man5/proc.5
> @@ -2020,6 +2020,7 @@ encoded using the following two-letter codes:
>      ht  - area uses huge tlb pages
>      nl  - non-linear mapping
>      ar  - architecture specific flag
> +    wf  - wipe on fork
>      dd  - do not include area into core dump
>      sd  - soft-dirty flag
>      mm  - mixed map area
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
