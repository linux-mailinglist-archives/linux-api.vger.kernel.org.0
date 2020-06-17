Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49E1FD81E
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2020 00:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFQWDG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Jun 2020 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgFQWDD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Jun 2020 18:03:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DFBC06174E
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 15:03:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so1566506pls.2
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kqcGCha/RkSYtgLEEH/pj3ontPR0wERiXeW1+vfpoSk=;
        b=hxvCNKKpOBh5EWbAEWTfILZT1LVkUjqhOSwh+k4CD7PiFhYlD8cPmHeeaUODZbCvTO
         fzBeqH+CDB1yFWwULOCwZblxoXsce9TtZhr3sDUUw9Z8sotxZu7w3CN9wtyfIJPkBVBf
         0WygPww4jLYPMEYUVyboxubvlhCVOAdtezpzFH/DbO/Yn8LogmhkqtaFxNAsvyGvFj+e
         1cCxONkOpcG5789UFBnpZRjy7tjP1gptvWvu4weUU4rFw5ImewN6u6FuKE1QVLAzZm1z
         4MfcJ3YcOI+sKnIMYGetbJcL9Nd0o2RIzLCQEX55abDxsMhxq6tubYRzDO+hjpRvicv4
         lSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kqcGCha/RkSYtgLEEH/pj3ontPR0wERiXeW1+vfpoSk=;
        b=SUP+I6tYD8yiWaAXIX6PjZGJKmIb1l0vJvFfdJaTiUAmIEglFS3c4WpQ6x4adkJbky
         fJJpK5D7OaLQDe27WbiBVSkmt+YoesGy3xdLP4rnlZyp4QOSGS1aYtjgDyNJRbmcw/i5
         sHrQ6L0pXLSH+PVWNqNKaUIkcDPYvlPDdh9rmzXW3ytXLKrwfvVNIQoeMA8JBRngR/4v
         XG5wBduWSxgIaIrL8Kxi2DF+gzT6doHKwNKgcJKzrOy9cJ6bgtfLigckLgEDLVSJAuad
         bf2QHc/axYp9qtAjtufgTFZMS+N9NwhuGVO6if9MhT7amT6KUqVV1lH1Y9tgLioxfIKS
         Jamw==
X-Gm-Message-State: AOAM533Uj57iUie5vpq5uPDoNPDhoR5Y8tuHbDSd7wgahvaAsY1bPw9K
        +MWpI8+WK0C0OhMi5O+qa4X8nq/DZq2+og==
X-Google-Smtp-Source: ABdhPJwVfKhrTfOk577kqNSuLA7cVaLo/HOLePD8p7+peaJ4nZKPanbWSN5FlKuXAjYWJqAfX3lFrw==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr1077178pju.65.1592431382409;
        Wed, 17 Jun 2020 15:03:02 -0700 (PDT)
Received: from ?IPv6:2601:646:9302:1050:44b6:a386:5b78:5708? ([2601:646:9302:1050:44b6:a386:5b78:5708])
        by smtp.gmail.com with ESMTPSA id t76sm744480pfc.220.2020.06.17.15.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 15:03:01 -0700 (PDT)
Subject: Re: [PATCH v8] mm: Proactive compaction
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <nigupta@nvidia.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20200616204527.19185-1-nigupta@nvidia.com>
 <20200617135312.4f395479454c55a8d021b023@linux-foundation.org>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Message-ID: <10f8a7c1-dc1f-532b-7ef7-d37b04334fbe@nitingupta.dev>
Date:   Wed, 17 Jun 2020 15:02:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617135312.4f395479454c55a8d021b023@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 6/17/20 1:53 PM, Andrew Morton wrote:
> On Tue, 16 Jun 2020 13:45:27 -0700 Nitin Gupta <nigupta@nvidia.com> wrote:
> 
>> For some applications, we need to allocate almost all memory as
>> hugepages. However, on a running system, higher-order allocations can
>> fail if the memory is fragmented. Linux kernel currently does on-demand
>> compaction as we request more hugepages, but this style of compaction
>> incurs very high latency. Experiments with one-time full memory
>> compaction (followed by hugepage allocations) show that kernel is able
>> to restore a highly fragmented memory state to a fairly compacted memory
>> state within <1 sec for a 32G system. Such data suggests that a more
>> proactive compaction can help us allocate a large fraction of memory as
>> hugepages keeping allocation latencies low.
>>
>> ...
>>
> 
> All looks straightforward to me and easy to disable if it goes wrong.
> 
> All the hard-coded magic numbers are a worry, but such is life.
> 
> One teeny complaint:
> 
>>
>> ...
>>
>> @@ -2650,12 +2801,34 @@ static int kcompactd(void *p)
>>   		unsigned long pflags;
>>   
>>   		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
>> -		wait_event_freezable(pgdat->kcompactd_wait,
>> -				kcompactd_work_requested(pgdat));
>> +		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
>> +			kcompactd_work_requested(pgdat),
>> +			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
>> +
>> +			psi_memstall_enter(&pflags);
>> +			kcompactd_do_work(pgdat);
>> +			psi_memstall_leave(&pflags);
>> +			continue;
>> +		}
>>   
>> -		psi_memstall_enter(&pflags);
>> -		kcompactd_do_work(pgdat);
>> -		psi_memstall_leave(&pflags);
>> +		/* kcompactd wait timeout */
>> +		if (should_proactive_compact_node(pgdat)) {
>> +			unsigned int prev_score, score;
> 
> Everywhere else, scores have type `int'.  Here they are unsigned.  How come?
> 
> Would it be better to make these unsigned throughout?  I don't think a
> score can ever be negative?
> 

The score is always in [0, 100], so yes, it should be unsigned.
I will send another patch which fixes this.

Thanks,
Nitin

