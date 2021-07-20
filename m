Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6FA3CF9C9
	for <lists+linux-api@lfdr.de>; Tue, 20 Jul 2021 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhGTMDT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Jul 2021 08:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229631AbhGTMDT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Jul 2021 08:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626785036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mlh8/IK5dN0L12USluWCom7PdCFpvByjpknGOWTGI3o=;
        b=CydMWymWpONdRmZngj+vNhV7uqCdMLIePrkItBMq7KFPrJCktyaKlSgM2Pi8nIQikJAuw2
        COtYlQxy6pHNfDuS+Yrw9i/O/aeFMSqWJiA0prTODP4qizqJcfAYuKlm62HlKiVPr/5z30
        wL5PEtASzf/3jbGW5cpIoCRnOKO9iio=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332--g5glnAGOrqKL5po8sBgaA-1; Tue, 20 Jul 2021 08:43:55 -0400
X-MC-Unique: -g5glnAGOrqKL5po8sBgaA-1
Received: by mail-wr1-f71.google.com with SMTP id 5-20020a0560001565b029013fe432d176so10255702wrz.23
        for <linux-api@vger.kernel.org>; Tue, 20 Jul 2021 05:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Mlh8/IK5dN0L12USluWCom7PdCFpvByjpknGOWTGI3o=;
        b=eOPDsdDahtTfq7ZQpgBoT2ZNYFNLr1hUJClQnEQuPlTr9rh611ow53+c1YilNPPWt0
         UnCpMBVfV25QliA5zq1PSDSeC/083w+GKfwsUt2d2c73PgyX6zP9y+/F+UP4BP6reH7P
         9xNV1CMMfNBCT0q6TPw8az+G/Xw4zLbAMQSe2PZB5uWcOoxpHXiY2IL53UzarmV4/zqR
         hq0oD5yj3lZxkd4n+/CVNTHlGpWUpR9pr2YG9yWBwxQncohneqN9BZDy4oaYSGGm0ubS
         bIen4fuVr8zkML/xBoFbh1wjU4JuLHrPUNJvvDS/8XgLx/xZ84esvk0EA9XRHMVF02Kl
         KEyA==
X-Gm-Message-State: AOAM532cr5BiRlUqlNsQVTVJea8XOpQuap0fMBtyM+FyX5wDV3TSlG7k
        M4EifHC97lPTPNUHLMykUfZC3qB9DKwjeE7oAY2yfhcLYKfnQ51BAj1oXr4PrN8H/L1R9S1mBfa
        QjlrXFCm9ub7mG0WxG7nV
X-Received: by 2002:adf:fe0d:: with SMTP id n13mr35178430wrr.73.1626785034428;
        Tue, 20 Jul 2021 05:43:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6XwfO0fQdP6c0wgLWHhcaNPUfqxWbaQGxVdEQ4qzR+9F2QOopKHond5XZSIPHgCH02hHk1Q==
X-Received: by 2002:adf:fe0d:: with SMTP id n13mr35178414wrr.73.1626785034301;
        Tue, 20 Jul 2021 05:43:54 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id n23sm19827869wmc.38.2021.07.20.05.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 05:43:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to
 be used in process_mrelease
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210718214134.2619099-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
Date:   Tue, 20 Jul 2021 14:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210718214134.2619099-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 18.07.21 23:41, Suren Baghdasaryan wrote:
> process_mrelease needs to be added in the CONFIG_MMU-dependent block which
> comes before __task_will_free_mem and task_will_free_mem. Move these
> functions before this block so that new process_mrelease syscall can use
> them.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> changes in v2:
> - Fixed build error when CONFIG_MMU=n, reported by kernel test robot. This
> required moving task_will_free_mem implemented in the first patch
> - Renamed process_reap to process_mrelease, per majority of votes
> - Replaced "dying process" with "process which was sent a SIGKILL signal" in
> the manual page text, per Florian Weimer
> - Added ERRORS section in the manual page text
> - Resolved conflicts in syscall numbers caused by the new memfd_secret syscall
> - Separated boilerplate code wiring-up the new syscall into a separate patch
> to facilitate the review process
> 
>   mm/oom_kill.c | 150 +++++++++++++++++++++++++-------------------------
>   1 file changed, 75 insertions(+), 75 deletions(-)

TBH, I really dislike this move as it makes git blame a lot harder with 
any real benefit.

Can't you just use prototypes to avoid the move for now in patch #2?

static bool task_will_free_mem(struct task_struct *task);


-- 
Thanks,

David / dhildenb

