Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5ED4C452
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2019 02:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfFTAHC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 20:07:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32793 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFTAHC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 20:07:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so565160pfq.0;
        Wed, 19 Jun 2019 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tLscf1pWbMquOzqm/J0PSG0c2NdqnQuLxzCnDb2eYKE=;
        b=LGGsheo7k/szhAcyit449LNmwFUNGBlCPBve+8d9w8NQmjKy8LZb3bEIyYp8zTx7GY
         y8bNrlvbOQsTKus6jOOFD8m0repNnpEsS1QMi9eCzx4ynWPJfXfvfHMGzGBK/zfWpnoE
         kkLp3/8Hb0HdwgWFrOj+eirfIt1ExGnWwjZBR8/lBHse87ltyZmSxs2letpM3wIWst/Y
         r3HRxg2CmuJCobJ2IXjwaS5HDKyYjnXktaiJ7hmFqAbRLDNj4/Um1EOV+/47d0H6KVoN
         jDWHMmc5uhQJhd2L6E1JCwJIgDFBWCKBwWEP3K2KI+7N3xQi12TaGiZOgnX346Z80Nvk
         lDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLscf1pWbMquOzqm/J0PSG0c2NdqnQuLxzCnDb2eYKE=;
        b=tIL8Kewfg8bP/KyYC5SKdR9uksDTa24k5F9BFH63uAczwC9eMGBdZZMkRcrPDG+rcM
         vxgLUKcljOfW7qyFTaUbpthLEo0lP04Fr8dy9/vQUXCvrIrVhECKNtMeKKhePrnC+2OF
         4srLC7ajZbiUt8xnc506enyBWP5clBwCj9y6Y6hFaKt9rTR1CoD5gJJq974u+xFBjdkc
         C/Lz5SAyYxcfTkiJtmQ+ZtAH9q2Z9k4DmWu9v1CS7GTjrM2LJppwNZ/UpK5ADFp1DRlU
         1+PQtN4Agk6wz8Ajtb9icgDZwOjo5YYBDh1mc7ezBqHvUkCKshJN2G1y4h6Efv2c2gVz
         Cgig==
X-Gm-Message-State: APjAAAWjxUI4XVYcB6tl19LaORitUb9uH50llvZHItrnkM3x0ERpOKbk
        wvirHCuqE1C3yijRNohOEXU=
X-Google-Smtp-Source: APXvYqz3yRevnnWG6vliI4MqUARyAvpZ1qqe+X6lRv1JTMqjQ+2wW1mbJbQSVZQhA+DtqpVDpXqeOw==
X-Received: by 2002:a17:90b:d82:: with SMTP id bg2mr14244364pjb.87.1560989221216;
        Wed, 19 Jun 2019 17:07:01 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id r4sm2574657pjd.28.2019.06.19.17.06.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 17:06:59 -0700 (PDT)
Date:   Thu, 20 Jun 2019 09:06:51 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 1/5] mm: introduce MADV_COLD
Message-ID: <20190620000650.GB52978@google.com>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-2-minchan@kernel.org>
 <20190619125611.GO2968@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619125611.GO2968@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 19, 2019 at 02:56:12PM +0200, Michal Hocko wrote:
> On Mon 10-06-19 20:12:48, Minchan Kim wrote:
> > When a process expects no accesses to a certain memory range, it could
> > give a hint to kernel that the pages can be reclaimed when memory pressure
> > happens but data should be preserved for future use.  This could reduce
> > workingset eviction so it ends up increasing performance.
> > 
> > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > MADV_COLD can be used by a process to mark a memory range as not expected
> > to be used in the near future. The hint can help kernel in deciding which
> > pages to evict early during memory pressure.
> > 
> > It works for every LRU pages like MADV_[DONTNEED|FREE]. IOW, It moves
> > 
> > 	active file page -> inactive file LRU
> > 	active anon page -> inacdtive anon LRU
> > 
> > Unlike MADV_FREE, it doesn't move active anonymous pages to inactive
> > file LRU's head because MADV_COLD is a little bit different symantic.
> > MADV_FREE means it's okay to discard when the memory pressure because
> > the content of the page is *garbage* so freeing such pages is almost zero
> > overhead since we don't need to swap out and access afterward causes just
> > minor fault. Thus, it would make sense to put those freeable pages in
> > inactive file LRU to compete other used-once pages. It makes sense for
> > implmentaion point of view, too because it's not swapbacked memory any
> > longer until it would be re-dirtied. Even, it could give a bonus to make
> > them be reclaimed on swapless system. However, MADV_COLD doesn't mean
> > garbage so reclaiming them requires swap-out/in in the end so it's bigger
> > cost. Since we have designed VM LRU aging based on cost-model, anonymous
> > cold pages would be better to position inactive anon's LRU list, not file
> > LRU. Furthermore, it would help to avoid unnecessary scanning if system
> > doesn't have a swap device. Let's start simpler way without adding
> > complexity at this moment.
> 
> I would only add that it is a caveat that workloads with a lot of page
> cache are likely to ignore MADV_COLD on anonymous memory because we
> rarely age anonymous LRU lists.

Okay, I will add some more.

> 
> [...]
> > +static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> > +				unsigned long end, struct mm_walk *walk)
> > +{
> 
> This is duplicating a large part of madvise_free_pte_range with some
> subtle differences which are not explained anywhere (e.g. why does
> madvise_free_huge_pmd need try_lock on a page while not here? etc.).

madvise_free_huge_pmd handle dirty bit but this is not.

> 
> Why cannot we reuse a large part of that code and differ essentially on
> the reclaim target check and action? Have you considered to consolidate
> the code to share as much as possible? Maybe that is easier said than
> done because the devil is always in details...

Yub, it was not pretty when I tried. Please see last patch in this
patchset.
