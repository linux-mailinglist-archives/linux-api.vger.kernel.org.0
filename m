Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86C27E727
	for <lists+linux-api@lfdr.de>; Wed, 30 Sep 2020 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgI3Kvr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Sep 2020 06:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbgI3Kvq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Sep 2020 06:51:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607ADC061755;
        Wed, 30 Sep 2020 03:51:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so1186190wmh.4;
        Wed, 30 Sep 2020 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dQxyi9NUn2aVc445EPYlbyra07UxZtysSydx/NMNIvU=;
        b=FDIiMDNN7g/etKD56qUitXx59Rv5vpZ3ItGDEoEXNmpB3pT8qN7in6OPvs32J7g3oq
         ACAOVu+DYBR4Ph8Rg5678gEm5tKKwgPPxEr5yUUvXoTVTwE9Ajy82lvDAZCgM7bBOrkf
         MSAyjzVK84mp6G1xgM3d/Yh0wPnlcPkIeD3YEjAqLf9aV4oWjHZP5/QQJ4HuVNLIi5Eo
         7A0d3PO17Xegawva3m/KONtT9iSbXjzAa5YKXfrkdja7FztPGFzdMr60aj1pfb7jUS9i
         B/jQXolKFf5K35dEqS5eRaAKMpMGtzsDt95mNm4ICyxABl+zwBarH8N1VHiatcEJyCoJ
         XIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dQxyi9NUn2aVc445EPYlbyra07UxZtysSydx/NMNIvU=;
        b=cBwmA5kotKC9bnvWas20Ian3WiL1U1OtqSItYL43a8pCYu3jxtdtDqvKjMceuZxQI7
         0pX7w3+p4e7BVrxn7g6gik6yVhur7xGMNXZ86rRrrjDYce93kLPlFgDDbv0bSWSWWLEa
         tcplv3/d+Pb9rUuYvPYOjepclUXuv6h56oTVXGKKtWyZcJ9zg/LO2Ikz+yEWEG1fuLxc
         iKdos9VccBoSQmcYHedlFtiGvvN65WeWisf4dunq7otXDrT8o2dgwiKs5BrLG88mTqyn
         72O09gC2MDyS5wEI3+Olb5VSUnBEgPaBhHtyVN3ez7wJRpVMTgSAAwQSzY08cKjezWAi
         FBdg==
X-Gm-Message-State: AOAM532pUgmT0qAvCCM/wvp76WgbnJZhDBUL4jMXFLalIzq3a1f7ANBG
        ecbCvmzzldK0CpYWsxR8pVkO5E6BX3g=
X-Google-Smtp-Source: ABdhPJy3LmnkdhOtP4774bpFxkagkz3Zv72J2jp661xKpSgb6ctz4ZdwpYDEE+A9rjSvL79eSUHoww==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr2335277wmj.101.1601463104832;
        Wed, 30 Sep 2020 03:51:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id 76sm2272084wma.42.2020.09.30.03.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 03:51:44 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] openat2.2: fix minor reference typo
To:     Aleksa Sarai <cyphar@cyphar.com>
References: <CAKgNAkiMNssJ2kCtGXd9ZUMFrG6uVtECBXMLGf2EZeS5-rkPKA@mail.gmail.com>
 <20200929223509.11783-1-cyphar@cyphar.com>
 <20200929223509.11783-2-cyphar@cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <2e779575-9d6e-7b54-e665-2cc607aaba74@gmail.com>
Date:   Wed, 30 Sep 2020 12:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929223509.11783-2-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/30/20 12:35 AM, Aleksa Sarai wrote:
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks, Aleksa. Patch applied.

Cheers,

Michael

> ---
>  man2/openat2.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man2/openat2.2 b/man2/openat2.2
> index 29b716d97ac4..53056ee6d292 100644
> --- a/man2/openat2.2
> +++ b/man2/openat2.2
> @@ -493,7 +493,7 @@ acting as an implicit version number.
>  (Because new extension fields will always
>  be appended, the structure size will always increase.)
>  This extensibility design is very similar to other system calls such as
> -.BR perf_setattr (2),
> +.BR sched_setattr (2),
>  .BR perf_event_open (2),
>  and
>  .BR clone3 (2).
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
