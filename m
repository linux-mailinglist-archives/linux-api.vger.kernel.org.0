Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E4733E0E
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 06:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFDE1A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 00:27:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43772 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfFDE1A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 00:27:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so9545965pgv.10;
        Mon, 03 Jun 2019 21:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ghW7vZxtD9TEM+qgoDG0MODtbI6VDLCCfPNHey69jA=;
        b=GGLOY4Lh3Uc5kASC5eWRsdjBzWNIdVe64631KWVwKmllcALTogaSgWf1MfDyArRuto
         SY0qwlS9eNnEro/DclKyuFoVITC030558nEHdOsh8EPAvnas61psi+E06QK9wsQdwscy
         9jrOP9iCsqxqKVvMAZb9jxOaw/PqtjOubFI50yvxBoTtP0wa75b0Gqqv13b7hT5UsbUZ
         +Vi0h1EFkIcPi4aIDl4Fb2SLlJRRe1VImbiK5lnjdJ/kmQMwFDPBztoan5MFomGDORfT
         OtDoC9ekgw8rFKXJQQEyFzvKYwwZZitO6Ov83a0yn8GzO3F5hVHoEvfJ3YoM0p1wxef0
         mfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ghW7vZxtD9TEM+qgoDG0MODtbI6VDLCCfPNHey69jA=;
        b=YkyPZISQTO2AvuUaKHoDukszSkrtO2rie7VgouX+ZBWvPY+jtzf+VNSYk8uII4CNEX
         FXFfxcmZmmXts4FJWF1KeMgoWRe1IfxgPGLaTmKlJBsvXNxBZMSt6Ixd38HkwubYtc4D
         Kh15Y3pu82lqA31LsSwN2vMp+pa7Z8LaHkBs3+VWMwX6b0pbY2PJcdzQZDNSMaPXeEmj
         kLuCvvHDNV4FYiPdDs+8n8jh80XRFtJETAI/66tYK0VmBsmJBjbn9avtm+SDUWFghLXz
         E5aX/0NWZVhlnhmSqPHV2sp/v6/1MaYiXHETgP/PQeH52wxb3lKZWLxjf4Mat56V7cDO
         Dbdg==
X-Gm-Message-State: APjAAAX96P945bYmMKidiJe5X4jkeJJDFCeYTL0soZNbqabX+tCJGvzj
        7ykYtM2ruXZQ4jsNSnb4vYo=
X-Google-Smtp-Source: APXvYqxAEyGDKuJIqda0JeMfwT8/ZDr6kjeGAWrJ14wxIzxTTOjbDVn6f7FM0zC8JcZTmxqn6bLclA==
X-Received: by 2002:a63:e10d:: with SMTP id z13mr11914157pgh.116.1559622419276;
        Mon, 03 Jun 2019 21:26:59 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id m11sm13287492pjv.21.2019.06.03.21.26.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 21:26:58 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:26:51 +0900
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
Message-ID: <20190604042651.GC43390@google.com>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
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

I will go with removing the part so that defer to decision to the VM reclaim
based on the review.

>  
> [...]
> 
> > > Please document this, if this is really a desirable semantic because
> > > then you have the same set of problems as we've had with the early
> > > MADV_FREE implementation mentioned above.
> > 
> > IIRC, the problem of MADV_FREE was that we couldn't discard freeable
> > pages because VM never scan anonymous LRU with swapless system.
> > However, it's not the our case because we should reclaim them, not
> > discarding.
> 
> Right. But there is still the page cache reclaim. Is it expected that
> an explicitly cold memory doesn't get reclaimed because we have a
> sufficient amount of page cache (a very common case) and we never age
> anonymous memory because of that?

If there are lots of used-once pages in file-LRU, I think there is no
need to reclaim anonymous pages because it needs bigger overhead due to
IO. It has been true for a long time in current VM policy.

Reclaim preference model based on hints is as following based on cost:

MADV_DONTNEED >> MADV_PAGEOUT > used-once pages > MADV_FREE >= MADV_COLD

It is desirable for the new hints to be placed in the reclaiming preference
order such that a) they don't overlap functionally with existing hints and
b) we have a balanced ordering of disruptive and non-disruptive hints.
