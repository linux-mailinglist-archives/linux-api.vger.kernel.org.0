Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F993455365
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 04:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhKRD3n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Nov 2021 22:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbhKRD3j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Nov 2021 22:29:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46931C061767
        for <linux-api@vger.kernel.org>; Wed, 17 Nov 2021 19:26:40 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p17so4092326pgj.2
        for <linux-api@vger.kernel.org>; Wed, 17 Nov 2021 19:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YgqEwSaksHCsJ2Xk3ukFf6EiHTEDT7mkEiActroWWyQ=;
        b=hVnVE9+QsBt3sP6MbBEN8t8mleGbEOJlIYVQhZR1FgtC7MyBTk2zSA8S2cOOBFKzov
         4io7fzgCxIC0WZX1AZ+LIBlVrkBxXYWrU2KTr4gxNAfyL3LENPXn8rjrIY+MCCVsOuto
         gFIXUlq/E+JRoJ6y/PXDlnTwmia3VmsXdqGMht4ezVCPQFv7Fvphy87WhoNBbZYmH2GA
         4pOFjxsVHOhDYmQNcgwGdobwiGJDYbk5HVtZyAivkVI/QkixAw4KtIPUb26hJFhp2f0w
         7gaTmvaGY7hNGhc6/nHQYYTMHiOK8flxSyfCFv7h7jJOuAuUyM+Z3UpkPSi6Msg+tNPK
         LN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YgqEwSaksHCsJ2Xk3ukFf6EiHTEDT7mkEiActroWWyQ=;
        b=UMPm9igNHMdUxKvOSONfD8u/rRDNnHne74Orw0c2fvGjo8X/acRFpVMOlQHp9siHqy
         +TzXFTIEs4dDR8Q6M0dcRKd8rdo1VYB3TVu10KWt+3AIFSYpgB/04O8+cgLPxo9XdlGK
         REANORlVcR5nB/SIff/Si39HusK0OJnNm6KEuWOmToFMRWCs0D2cSgXWly7khsStJD5V
         +u6IX6+jpdV3ghiJ6Yu5SohF5lkOuXDTUG7k03awTK3RZVPGAt/mZAmrVRPeXmyzgKmK
         X8Asp9iJjjBMhOrJfn56CqlJVisceQBvHOAPX1VAEaxpAP8TYEoRNPAXd3FEe9ti745C
         BbdQ==
X-Gm-Message-State: AOAM530+Pj4eX5gIWm2naZgFrQt5tpOicNuZIKIHGvPet+qoMuuns6+H
        QVcD0FIoU/jr/q+3Kp+RZSPisw==
X-Google-Smtp-Source: ABdhPJxPC/wgO01gLT38/YulI8aGZPE5vGabnciA7zJcJTyPkzEDRPImeJCfQ5MSUJ/sxOB4b9nvJQ==
X-Received: by 2002:aa7:811a:0:b0:44c:b9ef:f618 with SMTP id b26-20020aa7811a000000b0044cb9eff618mr12061528pfi.9.1637205999727;
        Wed, 17 Nov 2021 19:26:39 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id x33sm1046264pfh.133.2021.11.17.19.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 19:26:39 -0800 (PST)
Message-ID: <f0193837-2f2c-b55f-cd79-b80d931e7931@bytedance.com>
Date:   Thu, 18 Nov 2021 11:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: Re: Re: Re: Re: Re: Re: Re: [PATCH v1] sched/numa: add
 per-process numa_balancing
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
References: <20211029083751.GR3891@suse.de>
 <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
 <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
 <20211109121222.GX3891@suse.de>
 <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
 <20211109162647.GY3891@suse.de>
 <08e95d68-7ba9-44d0-da85-41dc244b4c99@bytedance.com>
 <20211117082952.GA3301@suse.de>
 <816cb511-446d-11eb-ae4a-583c5a7102c4@bytedance.com>
 <20211117101008.GB3301@suse.de>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20211117101008.GB3301@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/17/21 6:10 PM, Mel Gorman wrote:
> On Wed, Nov 17, 2021 at 05:38:28PM +0800, Gang Li wrote:
>> If those APIs are ok with you, I will send v2 soon.
>>
>> 1. prctl(PR_NUMA_BALANCING, PR_SET_THP_DISABLE);
> 
> It would be (PR_SET_NUMAB_DISABLE, 1)
> 
>> 2. prctl(PR_NUMA_BALANCING, PR_SET_THP_ENABLE);
> 
> An enable prctl will have the same problems as
> prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING, 0/1) -- it should have
> meaning if the numa_balancing sysctl is disabled.
> 
>> 3. prctl(PR_NUMA_BALANCING, PR_GET_THP);
>>
> 
> PR_GET_NUMAB_DISABLE
> 

How about this:

1. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global
2. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
3. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
4. prctl(PR_NUMA_BALANCING, PR_GET_NUMAB);

PR_SET_NUMAB_DISABLE/ENABLE can always have meaning whether the
numa_balancing sysctl is disabled or not,

-- 
Thanks,
Gang Li

