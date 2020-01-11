Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B87137C35
	for <lists+linux-api@lfdr.de>; Sat, 11 Jan 2020 08:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgAKHnJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 11 Jan 2020 02:43:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33720 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgAKHnI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 11 Jan 2020 02:43:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so3888581wrq.0;
        Fri, 10 Jan 2020 23:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=7phXSgAkhV7ekY+XxbbLPgZzgDKYvBOEXbRLHHpKIRM=;
        b=RiwLzAiADjNU/CdyggCMb4mC3tAkhOf/tdXXpjZGd0923CM74Nwwwg4xxLJQrX7c69
         DtVyroORkLm4kZI6fWasSzTvLxPTjryytOT7sOfsmMMANDvIHs06tPEd8km9VCIUumuw
         88L4s8w7oj5wqKMX7X0dUzmwpgJWfbKc1V8+sdFGKJUfX0lTaLoV8cH809OCNznwxPSm
         z6f6eBeVAwMG9FJNoSa4N2jNY9TfpM04GTn7jsetbGzdD89Z9SPOljf3wFWN5yh3xlqp
         P+kbJB/o2kU/OHaSzhPWwAfixETFkGRfgkOyzZ61zC6LhoDAq5jwo6dSMyjkTuhNd1nX
         hU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=7phXSgAkhV7ekY+XxbbLPgZzgDKYvBOEXbRLHHpKIRM=;
        b=GjI3q/qsJWgUUlyUN+x9jp/iGjShMlSygMGeT5W//oNW5S3u+Dvg7wmTFRXqSRFSV+
         OqL52+OHuOnsPg9Rt5vZEDHkzbwsly0pYTNvAtY2pFZb+BlQrT4CL0hBpH7enf0mhcbP
         twdPRlpy0uGy3lNBJ2DLEw1dUwHmbwuqs0A5MIngy2pb7p7XyqNOEsJ3EjACLcuR0KnE
         5kRQjW8DM0d30rmeHFbXakCaJfM+2a0Vp82id0WpJs/NphzNkPSby0ATFfSKAcCD7RCJ
         ijHro7pbTEQpMBOWZXeP4SrGnkPPdi6DVCO1ETQNFNF8oKb5XMupEAyoEhfH4gBtrqQd
         8MUg==
X-Gm-Message-State: APjAAAXps345GZ3X6d7LLyyAQA9CfIcCnhHSXZZ9GDqIq32US6B+Zxma
        HG2Lz9yEoJQln1zG7SeGR99kte3+
X-Google-Smtp-Source: APXvYqyRmODzfldBA8D/NN893xpmrLQXVhwM3VmayHW+WSWW0/eolokZQbHHru134cl6zX8cgpAI7w==
X-Received: by 2002:adf:e641:: with SMTP id b1mr7581841wrn.34.1578728587074;
        Fri, 10 Jan 2020 23:43:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:d1f3:c74b:f29c:a970])
        by smtp.gmail.com with ESMTPSA id r68sm5236515wmr.43.2020.01.10.23.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 23:43:06 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH 4/4] mm/madvise: allow KSM hints for remote API
Date:   Sat, 11 Jan 2020 08:42:59 +0100
Message-Id: <20200111074259.25577-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110213433.94739-5-minchan@kernel.org> (raw)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 10 Jan 2020 13:34:33 -0800 Minchan Kim <minchan@kernel.org> wrote:

> From: Oleksandr Natalenko <oleksandr@redhat.com>
> 
> It all began with the fact that KSM works only on memory that is marked
> by madvise(). And the only way to get around that is to either:
> 
>   * use LD_PRELOAD; or
>   * patch the kernel with something like UKSM or PKSM.
> 
> (i skip ptrace can of worms here intentionally)
> 
> To overcome this restriction, lets employ a new remote madvise API. This
> can be used by some small userspace helper daemon that will do auto-KSM
> job for us.
> 
> I think of two major consumers of remote KSM hints:
> 
>   * hosts, that run containers, especially similar ones and especially in
>     a trusted environment, sharing the same runtime like Node.js;
> 
>   * heavy applications, that can be run in multiple instances, not
>     limited to opensource ones like Firefox, but also those that cannot be
>     modified since they are binary-only and, maybe, statically linked.
> 
> Speaking of statistics, more numbers can be found in the very first
> submission, that is related to this one [1]. For my current setup with
> two Firefox instances I get 100 to 200 MiB saved for the second instance
> depending on the amount of tabs.
> 
> 1 FF instance with 15 tabs:
> 
>    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
>    410
> 
> 2 FF instances, second one has 12 tabs (all the tabs are different):
> 
>    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
>    592
> 
> At the very moment I do not have specific numbers for containerised
> workload, but those should be comparable in case the containers share
> similar/same runtime.
> 
> [1] https://lore.kernel.org/patchwork/patch/1012142/
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: SeongJae Park <sjpark@amazon.de>

> ---
>  mm/madvise.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index eb42b2b7f49b..3aa9aec6bfd9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1000,6 +1000,8 @@ process_madvise_behavior_valid(int behavior)
>  	switch (behavior) {
>  	case MADV_COLD:
>  	case MADV_PAGEOUT:
> +	case MADV_MERGEABLE:
> +	case MADV_UNMERGEABLE:
>  		return true;
>  	default:
>  		return false;
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
