Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538306F005F
	for <lists+linux-api@lfdr.de>; Thu, 27 Apr 2023 07:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbjD0FS2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Apr 2023 01:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0FS1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Apr 2023 01:18:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D51FCE
        for <linux-api@vger.kernel.org>; Wed, 26 Apr 2023 22:18:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so10101297b3a.2
        for <linux-api@vger.kernel.org>; Wed, 26 Apr 2023 22:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682572680; x=1685164680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMaPzJXWrSlkjaxg9I3D2+BQ3FkGijEWz0HmGH4ctBg=;
        b=K8Ar7FjGTpx9OUTYuvFL8WOi2JYgRtANCY+k0zhV++uZlFYfg1dv2kzq6tPqv4V++e
         ohR6AHy7h2lfsx104z40E8MmhPD7vAtzVo93Id0EeA2ndo4QgWycBGroBI6FCC0nR5WZ
         1H3nrbYRRwa9yww+/GwXkMDJeYxz0zLPsGiFlH+Pqh1Q5ajqQ/Ll7yDnAbhKJ/agGr2d
         7vau+aJ7N4K1IJz7io/UzmQfMEkl1uRsHnVh8dGIZdvaRpxloPhDyij3sklcPpblRAA8
         hMK9F6dnjYNup9A9M0Eo6OFqxlOl7BmvqxzEnWkWIOPPKDV+tld31O1Om7XBqgD3naLd
         KgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682572680; x=1685164680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMaPzJXWrSlkjaxg9I3D2+BQ3FkGijEWz0HmGH4ctBg=;
        b=Qch19uPh/DnK/Exyz4Poi5wS/ULedNfwElWVZXAvFV23cWHe0pbxMq0QrjU5u9OpMV
         28iDSye8c/ajtAIW9INhLCyhkSgYYhLxmHvCHuxc0y3ICmxiI96PErFuCcGJbguXIbsE
         ybTyXIEGx/dmbswkJrkYMbwt30PvN5e6WnogAk6VUG75UHw9LlRpTQLV9P465w+giXFV
         hA9JTa9pCwNJCxmYYX9N1s0uLbbPG4OwuKP7ikZb0+dfFgPq66K3wV+rpLOvnqNuwjm7
         WGfZF5fREpnSOmYxjavj9Yaap2is85zBRooDMPCzUPSXptzWqxmUAhBtGtbiQ1aq2Dsk
         SxUg==
X-Gm-Message-State: AC+VfDyZRNm7B0TjdKUpdxPVlfvmu69Xz9z07657bWgiPIvmj8eSYcsm
        hSYM1zsTreRa7Vj6bSdkFwiaXg==
X-Google-Smtp-Source: ACHHUZ6dMpsvHqTKYBR1bclPnIJa3Hb0cd8DQ0u1EuX8+QOryRHNOKFNSfUKpJmSLfW2IWk6sObczw==
X-Received: by 2002:a05:6a21:3945:b0:ee:d553:5cee with SMTP id ac5-20020a056a21394500b000eed5535ceemr407699pzc.16.1682572680001;
        Wed, 26 Apr 2023 22:18:00 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id w68-20020a636247000000b00520f4ecd71esm10529815pgb.93.2023.04.26.22.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 22:17:59 -0700 (PDT)
Message-ID: <9ba3577b-0098-86da-ff2e-636cb5a8ae1a@bytedance.com>
Date:   Thu, 27 Apr 2023 13:17:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v6 0/2] sched/numa: add per-process numa_balancing
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

Looks like there are no objections or comments. Do you have any ideas?

Can we merge this patch in the next merge window.

Thanks!

On 2023/4/12 22:06, Gang Li wrote:
> # Introduce
> Add PR_NUMA_BALANCING in prctl.
> 
> A large number of page faults will cause performance loss when numa
> balancing is performing. Thus those processes which care about worst-case
> performance need numa balancing disabled. Others, on the contrary, allow a
> temporary performance loss in exchange for higher average performance, so
> enable numa balancing is better for them.
> 
> Numa balancing can only be controlled globally by
> /proc/sys/kernel/numa_balancing. Due to the above case, we want to
> disable/enable numa_balancing per-process instead.
> 
