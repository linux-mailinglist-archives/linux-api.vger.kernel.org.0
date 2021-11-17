Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6745419C
	for <lists+linux-api@lfdr.de>; Wed, 17 Nov 2021 08:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhKQHKu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Nov 2021 02:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhKQHKt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Nov 2021 02:10:49 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B5CC061764
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 23:07:51 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y8so1358995plg.1
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 23:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0RTActGPQJ7iyylnJJI1wdIWdNpQg+u7RephLKSx8LI=;
        b=h9BVaQHObXkE2bcFXbzTJ0itMCtGzAAa20URewGZwmDmTAF3yi3JQrqAdNUpIrJxor
         kdB2eXEUheSHPIuDw/Hc5bv46I9RV08Yi8mDiWJ3JgaBIuhBJndT9Zhc4zOqTgiMxsws
         o6Gbsku0twIC+h2dabRKBUXj0dZAfr/61ESTh+24cOcqy3kxQRkIoG42S8SCr21dR1so
         fqi0Dr7atEYhe+fQGVrtO/mANucIfToyzLM+ioR7i5ScXVb8ehQ8fqDBEc5vnk0Pvgde
         TEW6hYpHMcdTjFoA3tyc9jhQN9Dj1lC23uXpb4v4J07msiJ/ARQ9X/2pcwlIn0Ai7yyI
         gXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0RTActGPQJ7iyylnJJI1wdIWdNpQg+u7RephLKSx8LI=;
        b=C4qWuPWlxIfHQQa99+TpuRMIOC9aoo/35J9rUhgyiE4OKQUyrCtom+E7xA54AJeUYH
         JwdgqM/sR0yVqkihG3mnBSFAF+VjZciMSLvrHRNSYQHh0a0NdB/55mVsZrxvHwA5mmU8
         NbmMcEq7PfqTv59TGTjdbKhA5461s8kVJk3VwjkbBaWouQaKK+8gJMvoBOKA/XNDP4Zm
         YpT3tK3SRqPDE+c1v+yH8o6JfBLbLJf0uYvSootYIrW32C36gPUcTwPdKRvtnQCVYe5i
         mkOY+4Nn5MNP7fsrVOYBoSqxRl4Pfd/K+Yh/3R77BGiGSH/eZa/doLs2BT0ouJpsYXJ1
         u3Fg==
X-Gm-Message-State: AOAM531XKxoaGBHV9ZBjA244Xas/aiNMJdMVugNE3q0p8LDMbkmEOlnc
        f9zdM1MuMCdhg5nVlfYcrWm+DA==
X-Google-Smtp-Source: ABdhPJzaYVCokrrfphh0VDzALSxLd38f7pIuk/ssVXU5PM9ZwKEyxY0JddoORMamMOyOcB+n3zEg3w==
X-Received: by 2002:a17:902:7890:b0:143:c4f7:59e6 with SMTP id q16-20020a170902789000b00143c4f759e6mr28736023pll.87.1637132871129;
        Tue, 16 Nov 2021 23:07:51 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id s2sm22171552pfk.198.2021.11.16.23.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 23:07:50 -0800 (PST)
Message-ID: <08e95d68-7ba9-44d0-da85-41dc244b4c99@bytedance.com>
Date:   Wed, 17 Nov 2021 15:07:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: Re: Re: Re: Re: Re: [PATCH v1] sched/numa: add per-process
 numa_balancing
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
 <20211028153028.GP3891@suse.de>
 <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
 <20211029083751.GR3891@suse.de>
 <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
 <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
 <20211109121222.GX3891@suse.de>
 <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
 <20211109162647.GY3891@suse.de>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20211109162647.GY3891@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/10/21 12:26 AM, Mel Gorman wrote:
> 
> Of those two, I agree with the second one, it would be tricky to implement
> but the first one is less clear. This is based on an assumption. If prctl
> exists to enable/disable NUMA baalancing, it's possible that someone
> else would want to control NUMA balancing on a cgroup basis instead of
> globally which would run into the same type of concerns -- different
> semantics depending on the global tunable.
> 

Hi!

You talk about the "semantics" of NUMA balancing between global, cgroup 
and process. While I read the kernel doc "NUMA Memory Policy", it occur 
to me that we may have a "NUMA Balancing Policy".

Since you are the reviewer of CONFIG_NUMA_BALANCING. I would like to 
discuss the need for introducing "NUMA Balancing Policy" with you. Is 
this worth doing?

