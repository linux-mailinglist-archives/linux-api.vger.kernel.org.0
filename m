Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6819F442902
	for <lists+linux-api@lfdr.de>; Tue,  2 Nov 2021 08:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBIA4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Nov 2021 04:00:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53092 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBIAz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Nov 2021 04:00:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7CF2B21956;
        Tue,  2 Nov 2021 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635839900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Q5NQ8/JaSAadnmMaZCcDJCUm9UQGbRtMuNPV5QIcjg=;
        b=L4qSVqPdh2DwLCV3D9HiXPxpJbPkp9C52tQvxiTnn2cTWzlzOGs76zHugFR6XWOihhlaBe
        VeEdpbo6wnfgbgCdivb0WiXi50X3JYGa/bwFSGoK2HByPUjrMy5a+FyVCETcnyRia53KR6
        tXiGVTD93/L46fOvvLI9jEktDyU371s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B66BA3B8B;
        Tue,  2 Nov 2021 07:58:19 +0000 (UTC)
Date:   Tue, 2 Nov 2021 08:58:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and
 exit_mmap
Message-ID: <YYDvm9c/7cGtBvw6@dhcp22.suse.cz>
References: <20211022014658.263508-1-surenb@google.com>
 <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz>
 <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz>
 <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 01-11-21 08:44:58, Suren Baghdasaryan wrote:
[...]
> I'm with you on this one, that's why I wanted to measure the price we
> would pay. Below are the test results:
> 
> Test: https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/
> Compiled: gcc -O2 -static test.c -o test
> Test machine: 128 core / 256 thread 2x AMD EPYC 7B12 64-Core Processor
> (family 17h)
> 
> baseline (Linus master, f31531e55495ca3746fb895ffdf73586be8259fa)
> p50 (median)   87412
> p95                  168210
> p99                  190058
> average           97843.8
> stdev               29.85%
> 
> unconditional mmap_write_lock in exit_mmap (last column is the change
> from the baseline)
> p50 (median)   88312     +1.03%
> p95                  170797   +1.54%
> p99                  191813   +0.92%
> average           97659.5  -0.19%
> stdev               32.41%
> 
> unconditional mmap_write_lock in exit_mmap + Matthew's patch (last
> column is the change from the baseline)
> p50 (median)   88807      +1.60%
> p95                  167783     -0.25%
> p99                  187853     -1.16%
> average           97491.4    -0.36%
> stdev               30.61%
> 
> stdev is quite high in all cases, so the test is very noisy.
> The impact seems quite low IMHO. WDYT?

Results being very noisy is what I recall as well. Thanks!
-- 
Michal Hocko
SUSE Labs
