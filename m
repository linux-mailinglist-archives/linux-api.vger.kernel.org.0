Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0443F704
	for <lists+linux-api@lfdr.de>; Fri, 29 Oct 2021 08:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhJ2GPF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 Oct 2021 02:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhJ2GPE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 Oct 2021 02:15:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651A7C061714
        for <linux-api@vger.kernel.org>; Thu, 28 Oct 2021 23:12:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so9835924pje.0
        for <linux-api@vger.kernel.org>; Thu, 28 Oct 2021 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GmBAManK6+5n92cYCAjM0Y2324rUvA8onYfURui5swg=;
        b=FzRfo54vrj1x+VLw9hZRhsWcpjKLGH17K667QXoIO36SpX9iUX4FFkZJEEPXUpJGsV
         EtmWWVbnaZKVDy8mKtra/0rlwBqNkvmRWqC00/6xN4ZoC9Fmg2VPISK13AgHJGdZEVLD
         dp2KqjrXbrOmMPeP1SXzkQSSIjmjMtjiIQmXJ9O/tSdqZKGjRhMplffWWzbbkfLc1aDZ
         MdoBLJKytMXXpcG2Q10pe40fSIxz/RXnZZXA6zESGj3MoScrAUky4Qbt7DDQoV+wZYEG
         pBdAf8H4oQ2xhC2jqtcYR9YAfqfZeYZQEhwgn0plZ7GRCU3BPi2QryAOfRpj9Nwrnyi2
         TthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GmBAManK6+5n92cYCAjM0Y2324rUvA8onYfURui5swg=;
        b=Vtp//hkJCzDf3FLG/Y6XYgDsouJMFtaHYVVQFzSwf33lTxy+E14apyizIxZX9pcaZl
         lzdEM8XHwf8nKy+RAWi3nA+VJNU1l4hODL99SdSwXzWbUgF3YwwgiIDIFzR8TfLoHOua
         8tXiFhKarWCby01tnnkBc2lOJiBnqy8iinJ2oJC9ZKoeESFtzCNCPToiXgIeZPeXtxsF
         dZAkW4m3ugQF25526jzEk+SfU8ji9QaxdFCRBhZxLRQtDJXeuFk83/7WJDV/SUyRPdK2
         Bsn5BB+6op0R8qMZzrwSF5RekcaRb12BLYieJmLjbtDq8VumsRPoFP+Um7QjFzh7SuX1
         xiNA==
X-Gm-Message-State: AOAM533msPlfFGsPSbd0i/ftvbPMKuNTkRL5Zg4p4bEkJes/xbczKiiI
        QuBTUHdArdenNApD2Tj15Dj6/g==
X-Google-Smtp-Source: ABdhPJztBy0zM++I5AqHWJadlwUlf5T5u9UumL7kPyW5tAyH1YoVZN1zbsrrfFHD91xN+LsQ2NyLjQ==
X-Received: by 2002:a17:902:f546:b0:141:b70e:1dd with SMTP id h6-20020a170902f54600b00141b70e01ddmr181519plf.30.1635487955947;
        Thu, 28 Oct 2021 23:12:35 -0700 (PDT)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id h6sm4796507pfi.174.2021.10.28.23.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 23:12:35 -0700 (PDT)
Subject: Re: Re: [PATCH v1] sched/numa: add per-process numa_balancing
To:     Mel Gorman <mgorman@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
 <20211028153028.GP3891@suse.de>
From:   Gang Li <ligang.bdlg@bytedance.com>
Message-ID: <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
Date:   Fri, 29 Oct 2021 14:12:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211028153028.GP3891@suse.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/28/21 11:30 PM, Mel Gorman wrote:
> 
> That aside though, the configuration space could be better. It's possible
> to selectively disable NUMA balance but not selectively enable because
> prctl is disabled if global NUMA balancing is disabled. That could be
> somewhat achieved by having a default value for mm->numa_balancing based on
> whether the global numa balancing is disabled via command line or sysctl
> and enabling the static branch if prctl is used with an informational
> message. This is not the only potential solution but as it stands,
> there are odd semantic corner cases. For example, explicit enabling
> of NUMA balancing by prctl gets silently revoked if numa balancing is
> disabled via sysctl and prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,
> 1) means nothing.
>
static void task_tick_fair(struct rq *rq, struct task_struct *curr, int 
queued)
{
	...
	if (static_branch_unlikely(&sched_numa_balancing))
		task_tick_numa(rq, curr);
	...
}

static void task_tick_numa(struct rq *rq, struct task_struct *curr)
{
	...
	if (!READ_ONCE(curr->mm->numa_balancing))
		return;
	...
}

When global numa_balancing is disabled, mm->numa_balancing is useless. 
So I think prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,0/1) should 
return error instead of modify mm->numa_balancing.

Is it reasonable that prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,0/1)
can still change the value of mm->numa_balancing when global 
numa_balancing is disabled?

