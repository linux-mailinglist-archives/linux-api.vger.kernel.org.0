Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9D3080D8
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 22:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhA1Vyx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 16:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhA1Vyr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Jan 2021 16:54:47 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FD1C061573
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 13:54:07 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z21so5208089pgj.4
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 13:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=X1vR6sPVHZZP/RCik6RDJlfYQaETQSuHl+h6yADrBnw=;
        b=b0Y9Kc1qXUXvSiRiywiKCjG36pUN3ouchYWcb/hFVZnDSaC7c1jfrHLvZIrOu9UzVa
         OE0zUnJK2niGAxf2iSxaww/y3xDpi5eR9Bot32O5SrOgcyJNzH9UUei20XhaUwRu4UuD
         k0WCc8URRjw9ANPN7eojDISeLjU6K2eRFKVRxwWkuYvIDaL1U4pMkTdWm2LRKmGQKrLx
         Nd4vgIHKdCLRxEXrHBIFvkuGmo/o+aPEztcdNN0X7k+L74LwWtN1+MuZtuZk/7UHgTic
         fF4SzAWn2OxvOhxDzJDC52mWfbJYbFAsfcrqLLYxZf9uFA48Q50w9xH+bGbFqURndgN2
         bUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=X1vR6sPVHZZP/RCik6RDJlfYQaETQSuHl+h6yADrBnw=;
        b=TiqHVULsULU874e5M+g+EDOGoijobQoYPQf+PjIXIrhBjwtUSs+igvlU1lQ4gzvMQC
         TBRf3ZGxxyws0B5Voqc5PpN9q6xaMNWjwjV3PQ3ewpKcuslU7L4u3aLbeUftq9zSNbO1
         XU6dcGsngiLfuNi3OOQcaco0bIGrFxYKOnJFeP9Zi3X6E2eS6XWWFjFX7dsxRwE39Xkv
         Yid/aoX1l9PIwExFJjNpI8oecBW/VdiH/iEw1ZTjQ8EqYVOAY5NviFoo/zghw1RRWHGj
         GGOgS5uaaWwDTa7g+WG3Qbh6cmeZkyy9zhErccLFReyNpKo6FFoU3CJfNABYajzYo7BU
         TWEg==
X-Gm-Message-State: AOAM531RwqMs5EdotCfzi0QZ5nJL/M9VNpzmvJvFnrB+s/hD0BySvQfk
        PjTtRv4gAGSwbp/Ul/3o87dafw==
X-Google-Smtp-Source: ABdhPJzBiyzBNyaKg7m5XC3keVye6UEAm20bIioNQ6zcvtLVmWkNeD2Tagw6ANgHPsm64NxMbCbJAQ==
X-Received: by 2002:a62:5344:0:b029:1c7:eeea:8bad with SMTP id h65-20020a6253440000b02901c7eeea8badmr1341831pfb.1.1611870846509;
        Thu, 28 Jan 2021 13:54:06 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id gg6sm9020424pjb.2.2021.01.28.13.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 13:54:05 -0800 (PST)
Date:   Thu, 28 Jan 2021 13:54:04 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     David Hildenbrand <david@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
In-Reply-To: <20210128164533.18566-1-david@redhat.com>
Message-ID: <6d9cff33-39c1-ef8e-a18e-c865b95240b6@google.com>
References: <20210127101813.6370-3-david@redhat.com> <20210128164533.18566-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 28 Jan 2021, David Hildenbrand wrote:

> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 7758486097f9..957680db41fa 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1650,6 +1650,11 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>  		   zone->spanned_pages,
>  		   zone->present_pages,
>  		   zone_managed_pages(zone));
> +#ifdef CONFIG_CMA
> +	seq_printf(m,
> +		   "\n        cma      %lu",
> +		   zone->cma_pages);
> +#endif
>  
>  	seq_printf(m,
>  		   "\n        protection: (%ld",

Hmm, not sure about this.  If cma is only printed for CONFIG_CMA, we can't 
distinguish between (1) a kernel without your patch without including some 
version checking and (2) a kernel without CONFIG_CMA enabled.  IOW, 
"cma 0" carries value: we know immediately that we do not have any CMA 
pages on this zone, period.

/proc/zoneinfo is also not known for its conciseness so I think printing 
"cma 0" even for !CONFIG_CMA is helpful :)

I think this #ifdef should be removed and it should call into a 
zone_cma_pages(struct zone *zone) which returns 0UL if disabled.
