Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB1C64CF4
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2019 21:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGJTrW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Jul 2019 15:47:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbfGJTrW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 10 Jul 2019 15:47:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E607ACA0;
        Wed, 10 Jul 2019 19:47:21 +0000 (UTC)
Date:   Wed, 10 Jul 2019 21:47:19 +0200
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
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190710194719.GS29695@dhcp22.suse.cz>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-5-minchan@kernel.org>
 <20190709095518.GF26380@dhcp22.suse.cz>
 <20190710104809.GA186559@google.com>
 <20190710111622.GI29695@dhcp22.suse.cz>
 <20190710115356.GC186559@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710115356.GC186559@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 10-07-19 20:53:56, Minchan Kim wrote:
> On Wed, Jul 10, 2019 at 01:16:22PM +0200, Michal Hocko wrote:
> > On Wed 10-07-19 19:48:09, Minchan Kim wrote:
> > > On Tue, Jul 09, 2019 at 11:55:19AM +0200, Michal Hocko wrote:
> > [...]
> > > > I am still not convinced about the SWAP_CLUSTER_MAX batching and the
> > > > udnerlying OOM argument. Is one pmd worth of pages really an OOM risk?
> > > > Sure you can have many invocations in parallel and that would add on
> > > > but the same might happen with SWAP_CLUSTER_MAX. So I would just remove
> > > > the batching for now and think of it only if we really see this being a
> > > > problem for real. Unless you feel really strong about this, of course.
> > > 
> > > I don't have the number to support SWAP_CLUSTER_MAX batching for hinting
> > > operations. However, I wanted to be consistent with other LRU batching
> > > logic so that it could affect altogether if someone try to increase
> > > SWAP_CLUSTER_MAX which is more efficienty for batching operation, later.
> > > (AFAIK, someone tried it a few years ago but rollback soon, I couldn't
> > > rebemeber what was the reason at that time, anyway).
> > 
> > Then please drop this part. It makes the code more complex while any
> > benefit is not demonstrated.
> 
> The history says the benefit.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/?id=d37dd5dcb955dd8c2cdd4eaef1f15d1b7ecbc379

Limiting the number of isolated pages is fine. All I am saying is that
SWAP_CLUSTER_MAX is an arbitrary number same as 512 pages for one PMD as
a unit of work. Both can lead to the same effect if there are too many
parallel tasks doing the same thing.

I do not want you to change that in the reclaim path. All I am asking
for is to add a bathing without any actual data to back that because
that makes the code more complex without any gains.
-- 
Michal Hocko
SUSE Labs
