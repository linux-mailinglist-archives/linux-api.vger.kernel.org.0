Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171BC33F75
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 09:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfFDHCc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 03:02:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbfFDHCc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 4 Jun 2019 03:02:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58B31AE4E;
        Tue,  4 Jun 2019 07:02:30 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:02:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20190604070228.GD4669@dhcp22.suse.cz>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-2-minchan@kernel.org>
 <20190531084752.GI6896@dhcp22.suse.cz>
 <20190531133904.GC195463@google.com>
 <20190531140332.GT6896@dhcp22.suse.cz>
 <20190531143407.GB216592@google.com>
 <20190603071607.GB4531@dhcp22.suse.cz>
 <20190604042651.GC43390@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604042651.GC43390@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 04-06-19 13:26:51, Minchan Kim wrote:
> On Mon, Jun 03, 2019 at 09:16:07AM +0200, Michal Hocko wrote:
[...]
> > Right. But there is still the page cache reclaim. Is it expected that
> > an explicitly cold memory doesn't get reclaimed because we have a
> > sufficient amount of page cache (a very common case) and we never age
> > anonymous memory because of that?
> 
> If there are lots of used-once pages in file-LRU, I think there is no
> need to reclaim anonymous pages because it needs bigger overhead due to
> IO. It has been true for a long time in current VM policy.

You are making an assumption which is not universally true. If I _know_
that there is a considerable amount of idle anonymous memory then I
would really prefer if it goes to the swap rather than make a pressure
on caching. Inactive list is not guaranteed to contain only used-once
pages, right?

Anyway, as already mentioned, we can start with a simpler implementation
for now and explicitly note that pagecache biased reclaim is known to be
a problem potentially. I am pretty sure somebody will come sooner or
later and we can address the problem then with some good numbers to back
the additional complexity.

-- 
Michal Hocko
SUSE Labs
