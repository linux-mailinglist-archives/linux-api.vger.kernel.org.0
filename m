Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA54127E722
	for <lists+linux-api@lfdr.de>; Wed, 30 Sep 2020 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgI3Kvo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Sep 2020 06:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgI3Kvm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Sep 2020 06:51:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D2C061755;
        Wed, 30 Sep 2020 03:51:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so1233105wmm.2;
        Wed, 30 Sep 2020 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqVFGVAAqOr/HituRPYESwmmeBRtShKDZVb7RzcsHgM=;
        b=PnLizlAZqxd7JLwu0gBMh8sJ8+1BjPvCYISntumb0JpdbklsEjCWT4vH+lF2jfbvWT
         vP0s9tKY3pWAGIjhK/q3R/pOdG2KbhSGWJmMO8Wp7g2zScgv/VTJQ1IWgMn7pGISny2T
         xhQm0q0mIxaeoB/4ZJzzO0BGoq7s3e6sZ2bgYrK5/pDZuC5pHVgpIp4aTQyP0Ip38hIA
         qYflLSwqhEE5d+eCOC0PFcqmRBKUcOBRWxDDzfW1ANHnDoldELMDoF3fYfQaD4p8VHea
         7tR7BoYItxdnKvvRAmAxR+lCv4ZW4CRktY5uoiCPQ8M4btcdVKR+tLDdkbond+8Ahq7d
         yA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqVFGVAAqOr/HituRPYESwmmeBRtShKDZVb7RzcsHgM=;
        b=R0vwzH1avMif84IzqAH2tQJBE5vdeFoaxcKGz/uAEGV2UWDxhfsYJ6rWfT7KY0bI1M
         Ub0R4N51uKbLcRvPU5j1Q4/sprIiIdAyUQQoAHHK2yQbvrtU17xdEjeAitvZfX39xVus
         KcHvqn0cdzrxrF2QclXoWQBsmMfJ9dsYktNHU90NHip+Te9/8ax28MMeLx6Nk4y25omi
         MZQD2b2mGoYj9/1vqhuNeP59dQ9wzsc9d0MSEUR4MW4e10G2QZODwtxicub+TP5xCCFc
         xWYqAcy8ah0g9Ywtb6/JCp7Q50Jc6AX3weFbRcJBsUbd9JXNsuySpYXBLO4Ai4fQYEUH
         6omA==
X-Gm-Message-State: AOAM532jhWHbYaV7B9/nhwCWqzXkhxhH0VzrtNhNmVHGx05q02cfYj+w
        pz+GKFCzDyw4NKEk3YB9kjXEYfPwrWU=
X-Google-Smtp-Source: ABdhPJxZhQXWEbA6ZBgJdGmmv8YywOCofNMZCNHSeINw/d/qufRVIq54IH8E3V4eZtMEGw6bM2L7qw==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr2283465wmc.76.1601463100174;
        Wed, 30 Sep 2020 03:51:40 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id c4sm2215754wrp.85.2020.09.30.03.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 03:51:39 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_getattr.2: update to include changed size
 semantics
To:     Aleksa Sarai <cyphar@cyphar.com>
References: <CAKgNAkiMNssJ2kCtGXd9ZUMFrG6uVtECBXMLGf2EZeS5-rkPKA@mail.gmail.com>
 <20200929223509.11783-1-cyphar@cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <2ad3f3e3-5664-7874-bab5-3831ccf9e65b@gmail.com>
Date:   Wed, 30 Sep 2020 12:51:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929223509.11783-1-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/30/20 12:35 AM, Aleksa Sarai wrote:
> Due to a userspace breakage, commit 1251201c0d34 ("sched/core: Fix
> uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and
> code") changed the semantics of sched_getattr(2) when the userspace
> struct is smaller than the kernel struct. Now, any trailing non-zero
> data in the kernel structure is ignored when copying to userspace. We
> also document the original error code correctly (it was EFBIG not
> E2BIG) in the BUGS section.

Thanks, Aleksa. Patch applied.

Cheers,

Michael


> Ref: 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
>                     robustify sched_read_attr() ABI logic and code")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man2/sched_setattr.2 | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/man2/sched_setattr.2 b/man2/sched_setattr.2
> index 2592a761a086..da0972a6a86d 100644
> --- a/man2/sched_setattr.2
> +++ b/man2/sched_setattr.2
> @@ -286,10 +286,8 @@ structure,
>  the additional bytes in the user-space structure are not touched.
>  If the caller-provided structure is smaller than the kernel
>  .I sched_attr
> -structure and the kernel needs to return values outside the provided space,
> -.BR sched_getattr ()
> -fails with the error
> -.BR E2BIG .
> +structure, the kernel will silently not return any values which would be stored
> +outside the provided space.
>  As with
>  .BR sched_setattr (),
>  these semantics allow for future extensibility of the interface.
> @@ -416,6 +414,16 @@ failed with the error
>  instead of
>  .BR E2BIG
>  for the case described in ERRORS.
> +.PP
> +In Linux versions up to 5.3,
> +.BR sched_getattr ()
> +failed with the error
> +.BR EFBIG
> +if the in-kernel
> +.IR sched_attr
> +structure was larger than the
> +.IR size
> +passed by user space.
>  .\" In Linux versions up to up 3.15,
>  .\" FIXME . patch from Peter Zijlstra pending
>  .\" .BR sched_setattr ()
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
