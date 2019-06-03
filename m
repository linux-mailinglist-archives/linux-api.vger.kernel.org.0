Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1133BAB
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 01:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFCXCO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 19:02:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44249 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfFCXCO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Jun 2019 19:02:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so7530277pll.11;
        Mon, 03 Jun 2019 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yGWgisOzgWfpAsWuWpBW9wv4B2VfU1HINjYPzcFySSo=;
        b=EgfyT96fk6vvQY5SFnesmZ6DIVFRx6yrNM5JKL31Zn5a0Pf0fQvmbHoY6+R3MGiEyp
         ocfeJcp7zAGOLX1qUteCkyVf9QkbVMfr5nY6fretb37D7LwJdW+FGtS7acGvamYPx7sn
         rwrRij92Ohr62F+vVRuJciAP5KP4eMBXEcKrPWawZlnldrd++mIsnoqXjQlbeUKK11xg
         RHM/QfwH4vYaI3wgmQpkWB/YxQMYFxRHjqj0Lv0XlR4Y56YQK3+Xwc0cvyksjCbAF2Dn
         RNbCrW/QSU5ONniWnxCAQx41j0YMGSeRi2PE4w/ELrpddUdmOZgzNAuyvXwUnbXB+BsX
         mMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yGWgisOzgWfpAsWuWpBW9wv4B2VfU1HINjYPzcFySSo=;
        b=KP+mqV3aQ/6dnVIJFXXuR0iS+bTCHv0rX36G4g8BqwuTNmWhAcz46F7JatKYzkmC5T
         iFJIYfrL4pbcKzypWlwmRSZ2Sqa+Vl4R8e6/ifWMzmCp8k8ciI3uI5VjGRqf70/1yywB
         2W7piB1HHchMrHeGpKBAD+DJsS7n37WFJ3Leq0qh3B+uPnRjuMwnFhlalyzStdtDOoGS
         aPE86yMrc0F2X4aQT8yE0zuCO9vsZOf1QGF0BfgaGED0ihUobUy1TZmV6ZCGZt7z3Xm5
         2lmCO7AS+Opl1ybGy6X6LTMi+5k2sgchkyzcQS9v1SKdjb97FxX99htEyUx2PU0eeCiI
         5xHA==
X-Gm-Message-State: APjAAAV5ZVspgTTF6GyDf4X1R5PLSvRzuNVcNOlBA6CXcWpsVa0ijzg6
        HESqxHVYZQpyff+b4waj2owu5eB0
X-Google-Smtp-Source: APXvYqxCkkmPXZHimkozMNVYP9gcbva1AMdrrcMfJLPuejBMXVOEhl4/p8tBtCCcCov7W2EolbjhXA==
X-Received: by 2002:a17:902:2983:: with SMTP id h3mr33061358plb.267.1559602933011;
        Mon, 03 Jun 2019 16:02:13 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id d19sm13502849pjs.22.2019.06.03.16.02.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 16:02:11 -0700 (PDT)
Date:   Tue, 4 Jun 2019 08:02:05 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20190603230205.GA43390@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-2-minchan@kernel.org>
 <20190531084752.GI6896@dhcp22.suse.cz>
 <20190531133904.GC195463@google.com>
 <20190531140332.GT6896@dhcp22.suse.cz>
 <20190531143407.GB216592@google.com>
 <20190603071607.GB4531@dhcp22.suse.cz>
 <20190603172717.GA30363@cmpxchg.org>
 <20190603203230.GB22799@dhcp22.suse.cz>
 <20190603215059.GA16824@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603215059.GA16824@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Johannes,

On Mon, Jun 03, 2019 at 05:50:59PM -0400, Johannes Weiner wrote:
> On Mon, Jun 03, 2019 at 10:32:30PM +0200, Michal Hocko wrote:
> > On Mon 03-06-19 13:27:17, Johannes Weiner wrote:
> > > On Mon, Jun 03, 2019 at 09:16:07AM +0200, Michal Hocko wrote:
> > > > On Fri 31-05-19 23:34:07, Minchan Kim wrote:
> > > > > On Fri, May 31, 2019 at 04:03:32PM +0200, Michal Hocko wrote:
> > > > > > On Fri 31-05-19 22:39:04, Minchan Kim wrote:
> > > > > > > On Fri, May 31, 2019 at 10:47:52AM +0200, Michal Hocko wrote:
> > > > > > > > On Fri 31-05-19 15:43:08, Minchan Kim wrote:
> > > > > > > > > When a process expects no accesses to a certain memory range, it could
> > > > > > > > > give a hint to kernel that the pages can be reclaimed when memory pressure
> > > > > > > > > happens but data should be preserved for future use.  This could reduce
> > > > > > > > > workingset eviction so it ends up increasing performance.
> > > > > > > > > 
> > > > > > > > > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > > > > > > > > MADV_COLD can be used by a process to mark a memory range as not expected
> > > > > > > > > to be used in the near future. The hint can help kernel in deciding which
> > > > > > > > > pages to evict early during memory pressure.
> > > > > > > > > 
> > > > > > > > > Internally, it works via deactivating pages from active list to inactive's
> > > > > > > > > head if the page is private because inactive list could be full of
> > > > > > > > > used-once pages which are first candidate for the reclaiming and that's a
> > > > > > > > > reason why MADV_FREE move pages to head of inactive LRU list. Therefore,
> > > > > > > > > if the memory pressure happens, they will be reclaimed earlier than other
> > > > > > > > > active pages unless there is no access until the time.
> > > > > > > > 
> > > > > > > > [I am intentionally not looking at the implementation because below
> > > > > > > > points should be clear from the changelog - sorry about nagging ;)]
> > > > > > > > 
> > > > > > > > What kind of pages can be deactivated? Anonymous/File backed.
> > > > > > > > Private/shared? If shared, are there any restrictions?
> > > > > > > 
> > > > > > > Both file and private pages could be deactived from each active LRU
> > > > > > > to each inactive LRU if the page has one map_count. In other words,
> > > > > > > 
> > > > > > >     if (page_mapcount(page) <= 1)
> > > > > > >         deactivate_page(page);
> > > > > > 
> > > > > > Why do we restrict to pages that are single mapped?
> > > > > 
> > > > > Because page table in one of process shared the page would have access bit
> > > > > so finally we couldn't reclaim the page. The more process it is shared,
> > > > > the more fail to reclaim.
> > > > 
> > > > So what? In other words why should it be restricted solely based on the
> > > > map count. I can see a reason to restrict based on the access
> > > > permissions because we do not want to simplify all sorts of side channel
> > > > attacks but memory reclaim is capable of reclaiming shared pages and so
> > > > far I haven't heard any sound argument why madvise should skip those.
> > > > Again if there are any reasons, then document them in the changelog.
> > > 
> > > I think it makes sense. It could be explained, but it also follows
> > > established madvise semantics, and I'm not sure it's necessarily
> > > Minchan's job to re-iterate those.
> > > 
> > > Sharing isn't exactly transparent to userspace. The kernel does COW,
> > > ksm etc. When you madvise, you can really only speak for your own
> > > reference to that memory - "*I* am not using this."
> > > 
> > > This is in line with other madvise calls: MADV_DONTNEED clears the
> > > local page table entries and drops the corresponding references, so
> > > shared pages won't get freed. MADV_FREE clears the pte dirty bit and
> > > also has explicit mapcount checks before clearing PG_dirty, so again
> > > shared pages don't get freed.
> > 
> > Right, being consistent with other madvise syscalls is certainly a way
> > to go. And I am not pushing one way or another, I just want this to be
> > documented with a reasoning behind. Consistency is certainly an argument
> > to use.
> > 
> > On the other hand these non-destructive madvise operations are quite
> > different and the shared policy might differ as a result as well. We are
> > aging objects rather than destroying them after all. Being able to age
> > a pagecache with a sufficient privileges sounds like a useful usecase to
> > me. In other words you are able to cause the same effect indirectly
> > without the madvise operation so it kinda makes sense to allow it in a
> > more sophisticated way.
> 
> Right, I don't think it's about permission - as you say, you can do
> this indirectly. Page reclaim is all about relative page order, so if
> we thwarted you from demoting some pages, you could instead promote
> other pages to cause a similar end result.
> 
> I think it's about intent. You're advising the kernel that *you're*
> not using this memory and would like to have it cleared out based on
> that knowledge. You could do the same by simply allocating the new
> pages and have the kernel sort it out. However, if the kernel sorts it
> out, it *will* look at other users of the page, and it might decide
> that other pages are actually colder when considering all users.
> 
> When you ignore shared state, on the other hand, the pages you advise
> out could refault right after. And then, not only did you not free up
> the memory, but you also caused IO that may interfere with bringing in
> the new data for which you tried to create room in the first place.
> 
> So I don't think it ever makes sense to override it.
> 
> But it might be better to drop the explicit mapcount check and instead
> make the local pte young and call shrink_page_list() without the
                     ^
                     old?

> TTU_IGNORE_ACCESS, ignore_references flags - leave it to reclaim code
> to handle references and shared pages exactly the same way it would if
> those pages came fresh off the LRU tail, excluding only the reference
> from the mapping that we're madvising.

You are confused from the name change. Here, MADV_COLD is deactivating
, not pageing out. Therefore, shrink_page_list doesn't matter.
And madvise_cold_pte_range already makes the local pte *old*(I guess
your saying was typo).
I guess that's exactly what Michal wanted: just removing page_mapcount
check and defers to decision on normal page reclaim policy:
If I didn't miss your intention, it seems you and Michal are on same page.
(Please correct me if you want to say something other)
I could drop the page_mapcount check at next revision.

Thanks for the review!
