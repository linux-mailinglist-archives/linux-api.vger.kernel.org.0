Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9D317B0
	for <lists+linux-api@lfdr.de>; Sat,  1 Jun 2019 01:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfEaXOs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 19:14:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43211 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfEaXOs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 19:14:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so7057989pfa.10;
        Fri, 31 May 2019 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sqg+k083UjuBaC9GIrtmvRgUBVLo9R/vwLVNgUStm7o=;
        b=TIt5gc6sWWBRszHh4EYFe1xGzN/GdjxvaWM8K2lb6Xim/4FxDuLYAD1Ln2BwGq45N+
         //hSJoE0haJkdEoYT574H8cfE9MQgXFzRw9sOmwzIyx/aypjCsv4NovefY7K4x0WskEI
         IVectjaxNeGeZFgbtOeR9p5BUkF0lD48nEbVmxysSoLNH++JgwHrLIIZUaAC+hoCL9rz
         n1qDpabUzsB7ye5w7gl61SKBt5e5S2OL0wW9YBBdj8rdOiA82r+94WHIIEKuKl0Y2sDz
         QaC76D/Cz/zHvImRoMHQofTytuSRimSdWNmb8t32cHGYtCcoWqLEK3GnHTXJbc6FyvpX
         Ywog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sqg+k083UjuBaC9GIrtmvRgUBVLo9R/vwLVNgUStm7o=;
        b=QeUNKpuZpD8nUnONGI5Ch972FjvUb21DmETWNBV9gixPeLWCmHtVYJYiamRsPkDwj9
         3cmhpgnLtDNXStTfyrTGI4Nq7Jpgdcr1Mu7zFYgdpWmo2R5yTVevtFdGqgQP3uZVJ1cv
         gEYBUdUYskR1RiV014UbksyIWFOUdPynLriUd1oIpS4NKpeFDDUJPl0rwdqKlkb91Ly7
         or/wgXAMYSz0Xbga5GuCUVqBGDYirLDqUwzXhAs/wy4gDuSV85C3fJgpv+MIQpM7Kjji
         DBb4Qk0cRc4+LgzGmOJj6mmIAh7HV5Yk9UlZVLyMridCTuAizBIte7G1ASuGFNLLsFiq
         NaPQ==
X-Gm-Message-State: APjAAAU8TNITciiLNd4yDiH41u+ka0sPU+4IdS2oTmyvDPda7egEuhJV
        4wUVjlS076V/uKuc9lixl7A=
X-Google-Smtp-Source: APXvYqxX11lcuUNZhgtux5VQO7zQRp/yiNhP/Uuovf9qi9asywvg1BHUnB4cqyA87l6NJmsdUFW+ew==
X-Received: by 2002:a63:c203:: with SMTP id b3mr11763122pgd.398.1559344487353;
        Fri, 31 May 2019 16:14:47 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id j7sm1044314pgp.88.2019.05.31.16.14.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 16:14:46 -0700 (PDT)
Date:   Sat, 1 Jun 2019 08:14:38 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [RFCv2 3/6] mm: introduce MADV_PAGEOUT
Message-ID: <20190531231438.GA248371@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-4-minchan@kernel.org>
 <20190531165927.GA20067@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531165927.GA20067@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Johannes,

On Fri, May 31, 2019 at 12:59:27PM -0400, Johannes Weiner wrote:
> Hi Michan,
> 
> this looks pretty straight-forward to me, only one kink:
> 
> On Fri, May 31, 2019 at 03:43:10PM +0900, Minchan Kim wrote:
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2126,6 +2126,83 @@ static void shrink_active_list(unsigned long nr_to_scan,
> >  			nr_deactivate, nr_rotated, sc->priority, file);
> >  }
> >  
> > +unsigned long reclaim_pages(struct list_head *page_list)
> > +{
> > +	int nid = -1;
> > +	unsigned long nr_isolated[2] = {0, };
> > +	unsigned long nr_reclaimed = 0;
> > +	LIST_HEAD(node_page_list);
> > +	struct reclaim_stat dummy_stat;
> > +	struct scan_control sc = {
> > +		.gfp_mask = GFP_KERNEL,
> > +		.priority = DEF_PRIORITY,
> > +		.may_writepage = 1,
> > +		.may_unmap = 1,
> > +		.may_swap = 1,
> > +	};
> > +
> > +	while (!list_empty(page_list)) {
> > +		struct page *page;
> > +
> > +		page = lru_to_page(page_list);
> > +		if (nid == -1) {
> > +			nid = page_to_nid(page);
> > +			INIT_LIST_HEAD(&node_page_list);
> > +			nr_isolated[0] = nr_isolated[1] = 0;
> > +		}
> > +
> > +		if (nid == page_to_nid(page)) {
> > +			list_move(&page->lru, &node_page_list);
> > +			nr_isolated[!!page_is_file_cache(page)] +=
> > +						hpage_nr_pages(page);
> > +			continue;
> > +		}
> > +
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> > +					nr_isolated[0]);
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> > +					nr_isolated[1]);
> > +		nr_reclaimed += shrink_page_list(&node_page_list,
> > +				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
> > +				&dummy_stat, true);
> > +		while (!list_empty(&node_page_list)) {
> > +			struct page *page = lru_to_page(&node_page_list);
> > +
> > +			list_del(&page->lru);
> > +			putback_lru_page(page);
> > +		}
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> > +					-nr_isolated[0]);
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> > +					-nr_isolated[1]);
> > +		nid = -1;
> > +	}
> > +
> > +	if (!list_empty(&node_page_list)) {
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> > +					nr_isolated[0]);
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> > +					nr_isolated[1]);
> > +		nr_reclaimed += shrink_page_list(&node_page_list,
> > +				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
> > +				&dummy_stat, true);
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> > +					-nr_isolated[0]);
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> > +					-nr_isolated[1]);
> > +
> > +		while (!list_empty(&node_page_list)) {
> > +			struct page *page = lru_to_page(&node_page_list);
> > +
> > +			list_del(&page->lru);
> > +			putback_lru_page(page);
> > +		}
> > +
> > +	}
> 
> The NR_ISOLATED accounting, nid parsing etc. is really awkward and
> makes it hard to see what the function actually does.
> 
> Can you please make those ISOLATED counters part of the isolation API?
> Your patch really shows this is an overdue cleanup.

Yeah, that was very painful.

> 
> These are fast local percpu counters, we don't need the sprawling
> batching we do all over vmscan.c, migrate.c, khugepaged.c,
> compaction.c etc. Isolation can increase the counter page by page, and
> reclaim or putback can likewise decrease them one by one.
> 
> It looks like mlock is the only user of the isolation api that does
> not participate in the NR_ISOLATED_* counters protocol, but I don't
> see why it wouldn't, or why doing so would hurt.
> 
> There are also seem to be quite a few callsites that use the atomic
> versions of the counter API when they're clearly under the irqsafe
> lru_lock. That would be fixed automatically by this work as well.

I agree all points so will prepare clean up patch.
