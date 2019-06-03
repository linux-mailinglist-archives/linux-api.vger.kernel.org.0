Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC83533690
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2019 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfFCR1V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 13:27:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36038 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfFCR1U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Jun 2019 13:27:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so1273102pgb.3
        for <linux-api@vger.kernel.org>; Mon, 03 Jun 2019 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=giaaUlfYCB4p9IcMpuBt2FywCr2iJGrguh6BYXiq67g=;
        b=PQ5b4O2XlL6OPmwtnnq6KaLa51qn9sjNwVfi0PlxHiJGJ+i7VnVu+20+W1qNQomvSl
         O3Bv5aHsJ+ipuVoMtxh+kzpSWlW4Fk3QMjP1zhFNcetUhou0CknU1EGHuroPrIz5z14C
         qXzhT/f5tH7ZDs5fLUiEx4n4L8NnZWU7fN3LdyUmT8Mxq9mRnmUApBPrT2zWXQJ0feWI
         4w3/MUVcT9pZIZJFcwZJF1GD0/TY6J7eT+huIUuMCYafpele/5qrcMQKXrkYlANL17q9
         CUPSL9cFDkj7VHokflPz+CnEZ0hF9rhqwkjU7vUo1G4IBQ9beS8fsUpGZc8+5T2/sgSJ
         Qd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=giaaUlfYCB4p9IcMpuBt2FywCr2iJGrguh6BYXiq67g=;
        b=kHR/+zkQXgSVJLjHZZS8FGcp/suN+nBd7G8Ymgsf34n860PZdl+LS/nIHKQt6+gERd
         +U1cvvj/VCrM7pgRacrI7xzQ8aTVuEt/JY7kCDpSxla5J2fP/CH6BAo8UYRv58JhXM4a
         Bh6xiASTV3Ko76p8g4NkK+pTaf+m7kIL9x4/hnxW9OGxE63FlGIBSQzQ5dY6V7OmLMcE
         TeWQDAeJzAAvQX9EPEARmmW2sKxsqBznqcc81iwrmjeotXYY0p0YPvhbmK98to2E9Vh3
         hbQoX0voFxco/oRI2sp0+TDagEFUQ1OWD4FrkZIs6ySdcYIbX69OC++CSYsnRL6RNSEy
         2NNQ==
X-Gm-Message-State: APjAAAX1WN7L1YncFtyXSmFv251aSK9EedCNg1wwj2HUMuJHD3sgNxkH
        MDIVVZJ9Z0zHSGtvCu8OkRl2lg==
X-Google-Smtp-Source: APXvYqzgq4qEKaWZh0wCQxHsqzHbOHu4nbzb40a+iOcqwVisgDkpzRyOJZZvootYCQo7snWqgQqhRA==
X-Received: by 2002:a17:90a:8a10:: with SMTP id w16mr31345882pjn.133.1559582839582;
        Mon, 03 Jun 2019 10:27:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id s1sm12158354pgp.94.2019.06.03.10.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:27:18 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:27:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
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
Message-ID: <20190603172717.GA30363@cmpxchg.org>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-2-minchan@kernel.org>
 <20190531084752.GI6896@dhcp22.suse.cz>
 <20190531133904.GC195463@google.com>
 <20190531140332.GT6896@dhcp22.suse.cz>
 <20190531143407.GB216592@google.com>
 <20190603071607.GB4531@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603071607.GB4531@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 03, 2019 at 09:16:07AM +0200, Michal Hocko wrote:
> On Fri 31-05-19 23:34:07, Minchan Kim wrote:
> > On Fri, May 31, 2019 at 04:03:32PM +0200, Michal Hocko wrote:
> > > On Fri 31-05-19 22:39:04, Minchan Kim wrote:
> > > > On Fri, May 31, 2019 at 10:47:52AM +0200, Michal Hocko wrote:
> > > > > On Fri 31-05-19 15:43:08, Minchan Kim wrote:
> > > > > > When a process expects no accesses to a certain memory range, it could
> > > > > > give a hint to kernel that the pages can be reclaimed when memory pressure
> > > > > > happens but data should be preserved for future use.  This could reduce
> > > > > > workingset eviction so it ends up increasing performance.
> > > > > > 
> > > > > > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > > > > > MADV_COLD can be used by a process to mark a memory range as not expected
> > > > > > to be used in the near future. The hint can help kernel in deciding which
> > > > > > pages to evict early during memory pressure.
> > > > > > 
> > > > > > Internally, it works via deactivating pages from active list to inactive's
> > > > > > head if the page is private because inactive list could be full of
> > > > > > used-once pages which are first candidate for the reclaiming and that's a
> > > > > > reason why MADV_FREE move pages to head of inactive LRU list. Therefore,
> > > > > > if the memory pressure happens, they will be reclaimed earlier than other
> > > > > > active pages unless there is no access until the time.
> > > > > 
> > > > > [I am intentionally not looking at the implementation because below
> > > > > points should be clear from the changelog - sorry about nagging ;)]
> > > > > 
> > > > > What kind of pages can be deactivated? Anonymous/File backed.
> > > > > Private/shared? If shared, are there any restrictions?
> > > > 
> > > > Both file and private pages could be deactived from each active LRU
> > > > to each inactive LRU if the page has one map_count. In other words,
> > > > 
> > > >     if (page_mapcount(page) <= 1)
> > > >         deactivate_page(page);
> > > 
> > > Why do we restrict to pages that are single mapped?
> > 
> > Because page table in one of process shared the page would have access bit
> > so finally we couldn't reclaim the page. The more process it is shared,
> > the more fail to reclaim.
> 
> So what? In other words why should it be restricted solely based on the
> map count. I can see a reason to restrict based on the access
> permissions because we do not want to simplify all sorts of side channel
> attacks but memory reclaim is capable of reclaiming shared pages and so
> far I haven't heard any sound argument why madvise should skip those.
> Again if there are any reasons, then document them in the changelog.

I think it makes sense. It could be explained, but it also follows
established madvise semantics, and I'm not sure it's necessarily
Minchan's job to re-iterate those.

Sharing isn't exactly transparent to userspace. The kernel does COW,
ksm etc. When you madvise, you can really only speak for your own
reference to that memory - "*I* am not using this."

This is in line with other madvise calls: MADV_DONTNEED clears the
local page table entries and drops the corresponding references, so
shared pages won't get freed. MADV_FREE clears the pte dirty bit and
also has explicit mapcount checks before clearing PG_dirty, so again
shared pages don't get freed.
