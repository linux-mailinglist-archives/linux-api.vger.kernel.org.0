Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111002B7015
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 21:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKQUbu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 15:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKQUbt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 15:31:49 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E6C0613CF;
        Tue, 17 Nov 2020 12:31:49 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d17so9379174plr.5;
        Tue, 17 Nov 2020 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8cdKo8emujq1Wb525bn0DzNPJmgQ0Dh8TmozREDSzEI=;
        b=iiyQhRWWvT1CDUQz8aDVUwS7YgbLGIX+Ds6H0J0ePTsjb3nxU5f324yBiimcmq4zSV
         KyYn+KNlmRNS6fK15BnqW4YD0VA6NFQ++fabtrcl+Dc1FxTSJ/qNiqNthJrCBavj6ElL
         KmuQ8vDGh4kfOagFZk1cEunPlNtJU3vjsXfPwswK6kLHnlgAG8yWLV2wc8EN7xpdovZ+
         7busx8RPyGkMDIxrdMuUqoyVF16UtKcrZ5XvK1OwE/Yxind+H/iENSOU1t8ubdEWW0fM
         PZwzqgYFF+HTCcECotUkcH139tRa4G0IOfwe8Fy4I7AaZSahn4HfUNug7aaUHRWgUxIy
         e8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8cdKo8emujq1Wb525bn0DzNPJmgQ0Dh8TmozREDSzEI=;
        b=fi8zY8CsyakfnaKRLLXxia2uxWdw0Yh6Z16PF/5xJyQlZOd+mBNZdrb5bN14CXqxGY
         2VFvZ+YKqS6HDeBj/hFYTpII5nggLWzxv5NGv+1Es5mIJL7ENP+3gGniApPF5+Q8oD1b
         Khl7bDl1/mZPLnpLB2qSQbl3GsZlpRlvOJyUZemqMX4acrfLZGWMC06NV0+HzQU+xES8
         OFp7/QFsGA/Bj7pA7tizk10tK0mNKpMFnCJO8Ihsx6MZrwZEdr8injRrIqEJgUrgTG9u
         2Y0sbq0nFMuRlqqU1A1lzJ0w+HSVSsNmrcKk+SF3ZfiOUTiUQ/3YT4l2Ksj5kxH9/zHj
         mRzA==
X-Gm-Message-State: AOAM531QzzugU+7Y+ulGU3Tqt0lEQUjmX0bG15yeuVZV5yxfyLvTfnUe
        q2fAXkhaJbhNDicSZM18DyQ=
X-Google-Smtp-Source: ABdhPJzzxdmwJ+fUaWkJUKc72hmerP4FBFAD0+bIYQoND4GH/Iu7aeYUY9VGZJZ4iowN7aM7H/uEjg==
X-Received: by 2002:a17:90a:8402:: with SMTP id j2mr820597pjn.120.1605645109029;
        Tue, 17 Nov 2020 12:31:49 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id p7sm12446826pfn.83.2020.11.17.12.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 12:31:48 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 17 Nov 2020 12:31:45 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        sj38.park@gmail.com, David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v9 3/3] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
Message-ID: <20201117203145.GB3856507@google.com>
References: <20200901000633.1920247-1-minchan@kernel.org>
 <20200901000633.1920247-4-minchan@kernel.org>
 <20200921065633.GA8070@infradead.org>
 <20200921175539.GB387368@google.com>
 <a376191d-908d-7d3c-a810-8ef51cc45f49@gmail.com>
 <20201116155132.GA3805951@google.com>
 <CAHk-=whTctybeY7GSc+f--FVLKKUQicTq-jfEmdku+cO_VdiVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTctybeY7GSc+f--FVLKKUQicTq-jfEmdku+cO_VdiVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 17, 2020 at 12:06:48PM -0800, Linus Torvalds wrote:
> On Mon, Nov 16, 2020 at 7:51 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > Let me send a patch with your SoB if you don't mind.
> 
> Eric, can you ack this SoB and I'll apply it to me tree?
> 
> Or is it already queued up somewhere else?

Andrew, picked it up.
https://ozlabs.org/~akpm/mmots/broken-out/mm-madvise-fix-memory-leak-from-process_madvise.patch
