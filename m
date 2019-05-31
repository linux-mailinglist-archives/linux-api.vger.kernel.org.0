Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2230EFB
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaNjP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 09:39:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfEaNjP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 09:39:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so4069398pgp.11;
        Fri, 31 May 2019 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p2xs/JXfPoxuMW8YWnH2CaGd+XoTegPAh3+JTTCbB5s=;
        b=IDKwcaOHGadMB1TmLSObOSA0W/aGdtHDC0stKAbwq4TtKsZB6mhzcklZYmOzKQnzhq
         hxywSfajmRY5mDRpAvWBh1M3KgJKwf/zl9jOd1WGYj6UXQ2fSX3E1nhZkkIegcSHln1Z
         dOs3dg8Pt1GBE3ik7m7RbCDl9neE8lReHVYFYme1QyB0wwO829iUToFVHsE9Dm4FXoHq
         gzk7kwcDaPtxSBv+Lo75tbXdD+lu0qJyhYndZkyHayIjT+3oQ3oUFEBtO971zCVy2KXw
         du35CsPT0zBzdgBTKHgTqnxMc3iatZyQXdovcqC1wmgrge9T/uteTBvSpZeWOVZdU+7Z
         upLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p2xs/JXfPoxuMW8YWnH2CaGd+XoTegPAh3+JTTCbB5s=;
        b=A9syRLRh6/b0QHoPs1pd/fKZqNHlIQI3iLJeSz8OQA24f98qhgZ8kJNVq5ZzfpYNxz
         N3ClOS5B39H4/JIxzHKSMdL2b4tLYEokpfM8Ezx0Gd420cy0SoQaRfso3znaAVB3alfB
         V3ZI6LYkKMy4+m7YixWBe3Nge4/nwM1xeIHO2QISEt+BzDWdVUwxlPc3INEXMOnrAj/o
         g+3Uxmq8iG/Hb3RKYFhZn6eVVRTEfEQ2Y+lYQMU+saqa1mZzY12shz4tW1Azw2ygLPFZ
         VTt9ctRLAhAVGbX2bNRRIP3oHJYrq61Cho50ipoo6OPGoPxutzBSFl7E5eTl9y1Pg3Iq
         faAg==
X-Gm-Message-State: APjAAAXge+bHX1AbQNe1whYTcE0zviCbQfn2D5YrXSlZTt5EVRDPQj8r
        MGRvaZxa9/YCRxHTQSv/k6M=
X-Google-Smtp-Source: APXvYqwpn6INIam9Hj1iduhR8iI5bXQQTo7X1hltxvTWMZbD5dIKnXsGM8MX89DjI7uadV0NebmWCw==
X-Received: by 2002:a63:4714:: with SMTP id u20mr9412205pga.347.1559309954195;
        Fri, 31 May 2019 06:39:14 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id 128sm7105292pff.16.2019.05.31.06.39.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 06:39:12 -0700 (PDT)
Date:   Fri, 31 May 2019 22:39:04 +0900
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
        hdanton@sina.com
Subject: Re: [RFCv2 1/6] mm: introduce MADV_COLD
Message-ID: <20190531133904.GC195463@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-2-minchan@kernel.org>
 <20190531084752.GI6896@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531084752.GI6896@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 31, 2019 at 10:47:52AM +0200, Michal Hocko wrote:
> On Fri 31-05-19 15:43:08, Minchan Kim wrote:
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
> > Internally, it works via deactivating pages from active list to inactive's
> > head if the page is private because inactive list could be full of
> > used-once pages which are first candidate for the reclaiming and that's a
> > reason why MADV_FREE move pages to head of inactive LRU list. Therefore,
> > if the memory pressure happens, they will be reclaimed earlier than other
> > active pages unless there is no access until the time.
> 
> [I am intentionally not looking at the implementation because below
> points should be clear from the changelog - sorry about nagging ;)]
> 
> What kind of pages can be deactivated? Anonymous/File backed.
> Private/shared? If shared, are there any restrictions?

Both file and private pages could be deactived from each active LRU
to each inactive LRU if the page has one map_count. In other words,

    if (page_mapcount(page) <= 1)
        deactivate_page(page);

> 
> Are there any restrictions on mappings? E.g. what would be an effect of
> this operation on hugetlbfs mapping?

VM_LOCKED|VM_HUGETLB|VM_PFNMAP vma will be skipped like MADV_FREE|DONTNEED

> 
> Also you are talking about inactive LRU but what kind of LRU is that? Is
> it the anonymous LRU? If yes, don't we have the same problem as with the

active file page -> inactive file LRU
active anon page -> inacdtive anon LRU

> early MADV_FREE implementation when enough page cache causes that
> deactivated anonymous memory doesn't get reclaimed anytime soon. Or
> worse never when there is no swap available?

I think MADV_COLD is a little bit different symantic with MAVD_FREE.
MADV_FREE means it's okay to discard when the memory pressure because
the content of the page is *garbage*. Furthemore, freeing such pages is
almost zero overhead since we don't need to swap out and access
afterward causes minor fault. Thus, it would make sense to put those
freeable pages in inactive file LRU to compete other used-once pages.

However, MADV_COLD doesn't means it's a garbage and freeing requires
swap out/swap in afterward. So, it would be better to move inactive
anon's LRU list, not file LRU. Furthermore, it would avoid unnecessary
scanning of those cold anonymous if system doesn't have a swap device.

