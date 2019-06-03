Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB20533A37
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2019 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfFCVvC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 17:51:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45860 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfFCVvC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Jun 2019 17:51:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so11347799pfm.12
        for <linux-api@vger.kernel.org>; Mon, 03 Jun 2019 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2G97OZEj3bcz7g9+L/c8Sqb4z92z7H9KjokgHfuHZXE=;
        b=TcpGUrg+mYmbrp0vjnO/bJFOPqdnvtpXA4/9hZZN1jJshYuuV/o733SpdjwhHgcKMG
         44iUP24R3eMi6NSL7ALSlKujvWUqxaK/ZvGDOOP1cKnv0Ls0OJdUmirc2V3EZop91zDw
         dMcqmJ9K6fUs0xhgdvefs5EcIMQbYUaow3esNwxlPGJa4Cb1385K8IQ0aAobeYAStcsZ
         1xG3Sh96eSZK+3PYMbJi8pXFUf5YpeQfUVJJcx6ybXj29/SoqCG9xXBigtUoK/1cHESC
         t96pNurULpvmR1Qfx9TsTwt1/KCcWotUx8KStYtsRdCD3Bs8eHLJg+3NAPE/mPKO246T
         Z5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2G97OZEj3bcz7g9+L/c8Sqb4z92z7H9KjokgHfuHZXE=;
        b=HKjaVC9oNRkEm/a97Z1F9UubcmZmHsb11ltFeQcFE527AawsmnhxJo8OeAaO/o2lt/
         ee4t48QEOyzZZVIHX3oFQIf8pzqnoTciyDzbxqPne0WQSN19tL5Ejb67leMsDIYgBLem
         5IUIuo4vzQc0ckltO1h6enfxDqzE6VguK3GLk9wrYhEwMZOAc8lTkQFLxzGqUbKQX+jr
         cmEJlAPSeqmqyHNWYOL1MasBiu28JBS93VhwmxFdvVXdeTcwZqyFlZ8PA5iVVr4PVd9h
         qnJaBCtJ4wiwGMo2F/eTW8GIW7TirGC8PDmdxyhuxj5Us202hoLJAQadEa8kMd+m905q
         lEWg==
X-Gm-Message-State: APjAAAUCcmB2Hx81RDu+LSymwbCZnwc5boqyK8HJyNWnP5w/UEP4YyLZ
        LcgSi8C0YX/MqdErJZR9v44EKA==
X-Google-Smtp-Source: APXvYqx9hZ+MTHo4qC9c2fIu1p2/b6Nxs1A2APiURBsRrL9fhsGlvVDxYID2+Rw4OX+7FUsyYf4ZnQ==
X-Received: by 2002:aa7:804c:: with SMTP id y12mr33488675pfm.94.1559598661807;
        Mon, 03 Jun 2019 14:51:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id f10sm20776759pgo.14.2019.06.03.14.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:51:01 -0700 (PDT)
Date:   Mon, 3 Jun 2019 17:50:59 -0400
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
Message-ID: <20190603215059.GA16824@cmpxchg.org>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-2-minchan@kernel.org>
 <20190531084752.GI6896@dhcp22.suse.cz>
 <20190531133904.GC195463@google.com>
 <20190531140332.GT6896@dhcp22.suse.cz>
 <20190531143407.GB216592@google.com>
 <20190603071607.GB4531@dhcp22.suse.cz>
 <20190603172717.GA30363@cmpxchg.org>
 <20190603203230.GB22799@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603203230.GB22799@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 03, 2019 at 10:32:30PM +0200, Michal Hocko wrote:
> On Mon 03-06-19 13:27:17, Johannes Weiner wrote:
> > On Mon, Jun 03, 2019 at 09:16:07AM +0200, Michal Hocko wrote:
> > > On Fri 31-05-19 23:34:07, Minchan Kim wrote:
> > > > On Fri, May 31, 2019 at 04:03:32PM +0200, Michal Hocko wrote:
> > > > > On Fri 31-05-19 22:39:04, Minchan Kim wrote:
> > > > > > On Fri, May 31, 2019 at 10:47:52AM +0200, Michal Hocko wrote:
> > > > > > > On Fri 31-05-19 15:43:08, Minchan Kim wrote:
> > > > > > > > When a process expects no accesses to a certain memory range, it could
> > > > > > > > give a hint to kernel that the pages can be reclaimed when memory pressure
> > > > > > > > happens but data should be preserved for future use.  This could reduce
> > > > > > > > workingset eviction so it ends up increasing performance.
> > > > > > > > 
> > > > > > > > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > > > > > > > MADV_COLD can be used by a process to mark a memory range as not expected
> > > > > > > > to be used in the near future. The hint can help kernel in deciding which
> > > > > > > > pages to evict early during memory pressure.
> > > > > > > > 
> > > > > > > > Internally, it works via deactivating pages from active list to inactive's
> > > > > > > > head if the page is private because inactive list could be full of
> > > > > > > > used-once pages which are first candidate for the reclaiming and that's a
> > > > > > > > reason why MADV_FREE move pages to head of inactive LRU list. Therefore,
> > > > > > > > if the memory pressure happens, they will be reclaimed earlier than other
> > > > > > > > active pages unless there is no access until the time.
> > > > > > > 
> > > > > > > [I am intentionally not looking at the implementation because below
> > > > > > > points should be clear from the changelog - sorry about nagging ;)]
> > > > > > > 
> > > > > > > What kind of pages can be deactivated? Anonymous/File backed.
> > > > > > > Private/shared? If shared, are there any restrictions?
> > > > > > 
> > > > > > Both file and private pages could be deactived from each active LRU
> > > > > > to each inactive LRU if the page has one map_count. In other words,
> > > > > > 
> > > > > >     if (page_mapcount(page) <= 1)
> > > > > >         deactivate_page(page);
> > > > > 
> > > > > Why do we restrict to pages that are single mapped?
> > > > 
> > > > Because page table in one of process shared the page would have access bit
> > > > so finally we couldn't reclaim the page. The more process it is shared,
> > > > the more fail to reclaim.
> > > 
> > > So what? In other words why should it be restricted solely based on the
> > > map count. I can see a reason to restrict based on the access
> > > permissions because we do not want to simplify all sorts of side channel
> > > attacks but memory reclaim is capable of reclaiming shared pages and so
> > > far I haven't heard any sound argument why madvise should skip those.
> > > Again if there are any reasons, then document them in the changelog.
> > 
> > I think it makes sense. It could be explained, but it also follows
> > established madvise semantics, and I'm not sure it's necessarily
> > Minchan's job to re-iterate those.
> > 
> > Sharing isn't exactly transparent to userspace. The kernel does COW,
> > ksm etc. When you madvise, you can really only speak for your own
> > reference to that memory - "*I* am not using this."
> > 
> > This is in line with other madvise calls: MADV_DONTNEED clears the
> > local page table entries and drops the corresponding references, so
> > shared pages won't get freed. MADV_FREE clears the pte dirty bit and
> > also has explicit mapcount checks before clearing PG_dirty, so again
> > shared pages don't get freed.
> 
> Right, being consistent with other madvise syscalls is certainly a way
> to go. And I am not pushing one way or another, I just want this to be
> documented with a reasoning behind. Consistency is certainly an argument
> to use.
> 
> On the other hand these non-destructive madvise operations are quite
> different and the shared policy might differ as a result as well. We are
> aging objects rather than destroying them after all. Being able to age
> a pagecache with a sufficient privileges sounds like a useful usecase to
> me. In other words you are able to cause the same effect indirectly
> without the madvise operation so it kinda makes sense to allow it in a
> more sophisticated way.

Right, I don't think it's about permission - as you say, you can do
this indirectly. Page reclaim is all about relative page order, so if
we thwarted you from demoting some pages, you could instead promote
other pages to cause a similar end result.

I think it's about intent. You're advising the kernel that *you're*
not using this memory and would like to have it cleared out based on
that knowledge. You could do the same by simply allocating the new
pages and have the kernel sort it out. However, if the kernel sorts it
out, it *will* look at other users of the page, and it might decide
that other pages are actually colder when considering all users.

When you ignore shared state, on the other hand, the pages you advise
out could refault right after. And then, not only did you not free up
the memory, but you also caused IO that may interfere with bringing in
the new data for which you tried to create room in the first place.

So I don't think it ever makes sense to override it.

But it might be better to drop the explicit mapcount check and instead
make the local pte young and call shrink_page_list() without the
TTU_IGNORE_ACCESS, ignore_references flags - leave it to reclaim code
to handle references and shared pages exactly the same way it would if
those pages came fresh off the LRU tail, excluding only the reference
from the mapping that we're madvising.
