Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2252533E1D
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFDEvz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 00:51:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36309 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDEvz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 00:51:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so2190530pgb.3;
        Mon, 03 Jun 2019 21:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HIshHbJGz5AuZX+SokNLkAl+hD0L1jiePIWoq2eJXjE=;
        b=CHp9I4t8D8E6Sf8L73xeqo6RDiNmk13G3jhqACbPNpNvCuGV1v7FaOayAR3r1y9VxR
         SmG9Lgp87OWWgEGXuCd0/ce/8dRaCCuU7rc1wWsI9fNhtrGkC2Bd6V7XAiZLwS/jFcIV
         XPKjcwgxRjmkXPMpyusWkE0uO+SNn9TjS/L7DhEKglcgLznHuZMeQc2guYxS/u/ZdvB6
         Dt9582g8LRbhaZNVRVJSo8AcYBqo/KkpPSdWWIhrQDat0rYlMDMxxj42bshxLmasOKM/
         nz+7P8RMDg+CLbA5qVI8CjmSeB+zq9D8IORFMp7IUaroSbi76uCi+jFnHVWyOTGSPxeP
         xBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HIshHbJGz5AuZX+SokNLkAl+hD0L1jiePIWoq2eJXjE=;
        b=mpeTL3YbUAi77a8FxCE0dQ//PJbmj4BASsZNJBOO3fVi79TXLxSgTm7nirirnSchaK
         V0kw7M8VCuktCbbuQKb8Ixv+EcmSi5DrW8ralGiOwvxlJ4vLEaIRz5K17iZ/3agqcjdv
         +yGUdZ24T7sA7K85hOemFs0oRD3M6KK83kqOU5n1W/fVkyez/jUopVi9a3IE/nXxgR9X
         ewEY0n4BdyJXp0KAxa6L9H9t3jvFE6hmJoiKXhqvfHHfEyiK4ZeWh7SzZsjivf3wnOOa
         M9LC45IoPlV3zd1tPBsZouEQpNfWCwt1ASdB/RcToBAr9/hth4kw+DunZw+HUCnjfOOS
         SKnw==
X-Gm-Message-State: APjAAAXpcriu6UPfFFe12fkRCBPTtHCYOnlvlWuupPabwnGuzKoRceZP
        Z+1ycIIb6iQOP6GwPAcmxGI=
X-Google-Smtp-Source: APXvYqxR/48QdIGAIUfDAIFTi3ruydBg7FO5eCefdksVed2G9NtEyc9wCflexu9+e9paiCqFo0XGAQ==
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr34652130pjq.65.1559623914129;
        Mon, 03 Jun 2019 21:51:54 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f186sm18863795pfb.5.2019.06.03.21.51.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 21:51:52 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:51:46 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "jannh@google.com" <jannh@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "oleksandr@redhat.com" <oleksandr@redhat.com>
Subject: Re: [PATCH v1 3/4] mm: account nr_isolated_xxx in
 [isolate|putback]_lru_page
Message-ID: <20190604045146.GD43390@google.com>
References: <20190604042047.13492-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604042047.13492-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Hillf,

On Tue, Jun 04, 2019 at 12:20:47PM +0800, Hillf Danton wrote:
> 
> Hi Minchan
> 
> On Mon, 3 Jun 2019 13:37:27 +0800 Minchan Kim wrote:
> > @@ -1181,10 +1179,17 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
> >  		return -ENOMEM;
> > 
> >  	if (page_count(page) == 1) {
> > +		bool is_lru = !__PageMovable(page);
> > +
> >  		/* page was freed from under us. So we are done. */
> >  		ClearPageActive(page);
> >  		ClearPageUnevictable(page);
> > -		if (unlikely(__PageMovable(page))) {
> > +		if (likely(is_lru))
> > +			mod_node_page_state(page_pgdat(page),
> > +						NR_ISOLATED_ANON +
> > +						page_is_file_cache(page),
> > +						hpage_nr_pages(page));

That should be -hpage_nr_pages(page). It's a bug.

> > +		else {
> >  			lock_page(page);
> >  			if (!PageMovable(page))
> >  				__ClearPageIsolated(page);
> 
> As this page will go down the path only through the MIGRATEPAGE_SUCCESS branches,
> with no putback ahead, the current code is, I think, doing right things for this
> work to keep isolated stat balanced.

I guess that's the one you pointed out. Right?
Thanks for the review!

> 
> > @@ -1210,15 +1215,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
> >  		 * restored.
> >  		 */
> >  		list_del(&page->lru);
> > -
> > -		/*
> > -		 * Compaction can migrate also non-LRU pages which are
> > -		 * not accounted to NR_ISOLATED_*. They can be recognized
> > -		 * as __PageMovable
> > -		 */
> > -		if (likely(!__PageMovable(page)))
> > -			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> > -					page_is_file_cache(page), -hpage_nr_pages(page));
> >  	}
> > 
> 
> BR
> Hillf
> 
