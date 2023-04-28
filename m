Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE47B6F12D0
	for <lists+linux-api@lfdr.de>; Fri, 28 Apr 2023 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbjD1HtO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Apr 2023 03:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345892AbjD1Hst (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Apr 2023 03:48:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD3565B0
        for <linux-api@vger.kernel.org>; Fri, 28 Apr 2023 00:46:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a69f686345so73340715ad.2
        for <linux-api@vger.kernel.org>; Fri, 28 Apr 2023 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682667925; x=1685259925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xoe5HpGF9vZnqLd03J3yds9FnNAjqjJWeyLDyyNqms4=;
        b=gy5+wiMc32xSHzrr0S2/8xoO/E0Nq2p8Kd9U8o1eaNVb2oeiLMK99wCeuoEirqa12w
         J8sD50eYLyVgX3jMKuJe9EkXUCP4m33HE2q+QCZ4C7jXAg8PGT59JJsRthLKRTUandO9
         1fE8JTl5Xkrkys6V94qGl6dspIzpWi3cpqVx29YhfmkC/WHUuGUvFj2tKY8WVhyYZ5HE
         69FZ7jR75TGeLS0Sm/TZgeyJ/7Gus1EW3wIjjRNe7nLBuhFY/GSGBlZwxOlkVFxa4bSI
         MG24ZylaDijVesM/+ON79Lgz7N4sNz7uO1Ch2vjrv9hTJ89+VpZyE/r7TJHWPdhtOsnX
         V7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667925; x=1685259925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xoe5HpGF9vZnqLd03J3yds9FnNAjqjJWeyLDyyNqms4=;
        b=BgJ3O0fnTrvHVUyCtQd8TKTR2QmSMbKplTnxWPS9i4Ps/miUCJ6xiGdadQ1rRwzEmY
         3Qf7yYcpgpOk5F84ycbxKB2/3/7CEDBT0UUCu1fXnPezu+Rj9iYEn/C6Kyt+R2bYWxn0
         w0qZtpvFTZaiXW/FkRWqmW+vDxBdY2qnjc6YvvppALnihWG4TfooL/nyCs/jhUfYfIkK
         xaaIiu5OQ1HmfYqHqM05gE3km76syhHkpgzfrCFEWhthEYOva7fvtjWdQUFzAOrLU5Ml
         N7cgPXw6QSGbGqzfG56oXfmsIN5lyw/IHm3MOCoem56ZDFRfxi1c8xL6S5DVcqT6WeGr
         P5Pg==
X-Gm-Message-State: AC+VfDy9Dq1biRJ7wA9kHHkA2B/Bt193ACFltIz688SRNH2EwQoxqXw+
        5n9lgt52wTG7UPLsukOm72nMlD1nHaVluNjCRKSpDg==
X-Google-Smtp-Source: ACHHUZ6ZESvfhR8LIslq4fdn2ZOXMRlLNtFud+KKn77WEJxdYrYtyMuMDIFr0dPVM+ApZg6vGhOUIw==
X-Received: by 2002:a17:903:2348:b0:1a6:7ed0:147e with SMTP id c8-20020a170903234800b001a67ed0147emr5026755plh.33.1682667925031;
        Fri, 28 Apr 2023 00:45:25 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00194caf3e975sm12693998plx.208.2023.04.28.00.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 00:45:24 -0700 (PDT)
Message-ID: <9befca58-2425-5b4f-2dab-98b3ed4037ac@bytedance.com>
Date:   Fri, 28 Apr 2023 15:45:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Re: [PATCH v6 0/2] sched/numa: add per-process numa_balancing
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
 <9ba3577b-0098-86da-ff2e-636cb5a8ae1a@bytedance.com>
 <76534699-e270-b450-c18e-f7c35c325bcf@gmail.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <76534699-e270-b450-c18e-f7c35c325bcf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thank you.

I'll keep an eye on the progress.

On 2023/4/28 15:40, Bagas Sanjaya wrote:
> On 4/27/23 12:17, Gang Li wrote:
>> Hi,
>>
>> Looks like there are no objections or comments. Do you have any ideas?
>>
>> Can we merge this patch in the next merge window.
>>
> 
> We're at 6.4 merge window, so the maintainer focus is to send PR updates
> to Linus. And this series didn't get applied before this merge window.
> Wait until 6.4-rc1 is out and reroll.
> 
> Thanks.
> 
