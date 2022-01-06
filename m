Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8318486141
	for <lists+linux-api@lfdr.de>; Thu,  6 Jan 2022 09:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiAFIIo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Jan 2022 03:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiAFIIl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 6 Jan 2022 03:08:41 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6BBC061245
        for <linux-api@vger.kernel.org>; Thu,  6 Jan 2022 00:08:41 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t187so1866311pfb.11
        for <linux-api@vger.kernel.org>; Thu, 06 Jan 2022 00:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BgQn8eJjH64JPbz4yLqo05eN+vssmbVyS+BB98Rvfwk=;
        b=nEUnRUEAUbbNxDaoGbEcLd6j1UEhajs5aNy8yaI877EFRCdgpIaqWwjWHf1KchkmrT
         ORFp7BoIouFXs69HbjUyvbKprgr5yhFJZBXIH/jVB0arINh9Av96mJYN6ofd61iQ22TN
         3/MJvyTJ0MvKMP7h9iVF3DJ4ZCgEQpMOz0QnqrRmcol6534zHOZBSTqamqp4uyLpF7qG
         YInUlFno/2Aeufeu50mv1Ad3Z9sRtP/pTx6xsmLattLWxjYZ6NjAMZWJMiUucYlpnEqN
         Z83yzVt+qAUlNghopLf0MJuwAzPqj+KudSw2db7CrTY3XZ/24l5ShSW1WwwG0eiFeH0G
         LLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BgQn8eJjH64JPbz4yLqo05eN+vssmbVyS+BB98Rvfwk=;
        b=P9GY04kOguOPUr4Nq9j0y3SUZirr3pLRH1Yr2OjQiJM/OYX9EEaH5iVJIYvyYeWvGQ
         Y0dewOdtC8z+u3beGUIa5QQU7ypbiFAsZrwDv5vj8L98tc7GMKAjAHbYsBM+14Nf8nyq
         sNZyZiaU0iDUJn5TXZwOA9Y0xBTpq4E62QWGZi2J8M+V2B8JQjLIRsfvIX6I85oeT/ou
         FG+7423c7M42uLN3827c6fULUcotRg18IMazB1DducLXNcClhTJbjq9LqEneJKbX44eC
         U0vP/DPtT0J5VGIR5EHGHk9DFPc6bCSSgZ9lDnqFzoMdT+9uxMr+reEFCDPbuuuWPZW9
         bIBA==
X-Gm-Message-State: AOAM532FLxQP4LeRNTAHz+I+z7mdjnTWr9VbteKvBbLKTZc2uDK7TD7h
        a1Kg2ggq1t4rnQ0tDmK/El62Xg==
X-Google-Smtp-Source: ABdhPJzQkMM/MKNQVkT5Sz2qk9lHKabp/ZITvKam3lnONUYRDj+7fr0JQRHbWj1FisObXtGzSL69lA==
X-Received: by 2002:a63:81c1:: with SMTP id t184mr51078790pgd.481.1641456520298;
        Thu, 06 Jan 2022 00:08:40 -0800 (PST)
Received: from [10.254.5.219] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id j11sm1367504pfn.199.2022.01.06.00.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 00:08:39 -0800 (PST)
Message-ID: <cf52d7d3-e7f8-2b4e-a752-8be8d95b31fb@bytedance.com>
Date:   Thu, 6 Jan 2022 16:08:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3] sched/numa: add per-process numa_balancing
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com
References: <20211206024530.11336-1-ligang.bdlg@bytedance.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20211206024530.11336-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,
Any comments please?

;)

On 2021/12/6 10:45, Gang Li wrote:
> This patch add a new api PR_NUMA_BALANCING in prctl.
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
> Add numa_balancing under mm_struct. Then use it in task_tick_fair.
> 
> Set per-process numa balancing:
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global
> Get numa_balancing state:
> 	prctl(PR_NUMA_BALANCING, PR_GET_NUMAB, &ret);
> 	cat /proc/<pid>/status | grep NumaB_enabled
> 
> Cc: linux-api@vger.kernel.org
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
> 
> Changes in v3:
> - Fix compile error.
> 
> Changes in v2:
> - Now PR_NUMA_BALANCING support three states: enabled, disabled, default.
>    enabled and disabled will ignore global setting, and default will follow
>    global setting.
-- 
Thanks
Gang Li

