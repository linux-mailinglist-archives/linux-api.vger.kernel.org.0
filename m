Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2FBF671E5
	for <lists+linux-api@lfdr.de>; Fri, 12 Jul 2019 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGLPBa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Jul 2019 11:01:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbfGLPBa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 12 Jul 2019 11:01:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC43AAE84;
        Fri, 12 Jul 2019 15:01:28 +0000 (UTC)
Date:   Fri, 12 Jul 2019 17:01:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 4/4] mm: introduce MADV_PAGEOUT
Message-ID: <20190712150127.GV29483@dhcp22.suse.cz>
References: <20190711012528.176050-1-minchan@kernel.org>
 <20190711012528.176050-5-minchan@kernel.org>
 <20190711184223.GD20341@cmpxchg.org>
 <20190712051828.GA128252@google.com>
 <20190712135809.GB31107@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712135809.GB31107@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 12-07-19 09:58:09, Johannes Weiner wrote:
[...]
> > @@ -423,6 +445,12 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> >  
> >  		VM_BUG_ON_PAGE(PageTransCompound(page), page);
> >  
> > +		if (pageout) {
> > +			if (isolate_lru_page(page))
> > +				continue;
> > +			list_add(&page->lru, &page_list);
> > +		}
> > +
> >  		if (pte_young(ptent)) {
> >  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> >  							tlb->fullmm);
> 
> One thought on the ordering here.
> 
> When LRU isolation fails, it would still make sense to clear the young
> bit: we cannot reclaim the page as we wanted to, but the user still
> provided a clear hint that the page is cold and she won't be touching
> it for a while. MADV_PAGEOUT is basically MADV_COLD + try_to_reclaim.
> So IMO isolation should go to the end next to deactivate_page().

Make sense to me

-- 
Michal Hocko
SUSE Labs
