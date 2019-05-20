Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE2243BE
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 00:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfETWy1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 18:54:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34593 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETWy1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 May 2019 18:54:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so7967634pfa.1;
        Mon, 20 May 2019 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5ZEwZoUPrePvOB8P3uaFYHEBF9h6x1bF10qxviP/xE=;
        b=aDa3BR5hrVujffR2CccTn2i03Z06u8RLaJv5oWvHxj5xbVNGiYsJk/vt7209S8uAol
         cSUwKywUIzkbz99ygGpCwDVlyAhlP6Qqv16/LS7gCBDlBqt07w13Lm6/MhAubCUgw7do
         9mS7NAcuScAF4itUbYLknC0Rx5EIrxuTy8Un0xtEN35JX6X4Ul9oGrEZvRiI6PizjfsO
         8TUxwDnLaJ0suX9Y3ukM8LQoqob/YnSrmTYafRjigxMs8VqXRDeuhNsTaiq/zSWYqRe+
         O3paGwlyrZnmuqoURl77Gg2gHg6KjGkOKu3t7IebRgpgTp9yfW65T+GgqdpR0uC3WLXF
         UYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5ZEwZoUPrePvOB8P3uaFYHEBF9h6x1bF10qxviP/xE=;
        b=A0krYqGZ1OG0FG2gU9WkI7IjYkgi/iFkLxDWcXNSWuh1nAXoEp2XjXneOnz08EOR8R
         GpElIc7+Y41yXEQ1OH4XhiD29H46YrTR8OKen5aXSwsFRe7hLirQ9b1NLdWhGlcGVYgE
         vPF/RKWtoGjTfsoYd1PJY0bbBOd63uVACdyci2TOzBbh7ZnDgvtqibsZYqQaVBzbP15T
         wdzQWTpBLDpY63vIALLVy9VzY6mUuW0a/8daSTXSc9YuamyewYRiAF6pCAcqK4hsFTyI
         5hSeCGSi1o1Kof9xL1g++P03fo2yc0CJYAIyV7kkStuMgWHVbdxVw4BNyjasyO3E8ssb
         XIsA==
X-Gm-Message-State: APjAAAXcZeRdJ8JUv1mUbIaBJGfgelUhXVfFgEnwf8Yf48wJcShn7NnS
        IofUGBErSK08Kzuo6tsjT+0=
X-Google-Smtp-Source: APXvYqzzK62nVCC5F6/m31S+JkD0c1anhEeHQjGso6nctGro5sKQZujkk4vsGaYEeFlhkah4BFhh2Q==
X-Received: by 2002:a65:52c8:: with SMTP id z8mr9234274pgp.10.1558392866292;
        Mon, 20 May 2019 15:54:26 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f29sm47171591pfq.11.2019.05.20.15.54.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 15:54:24 -0700 (PDT)
Date:   Tue, 21 May 2019 07:54:19 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 1/7] mm: introduce MADV_COOL
Message-ID: <20190520225419.GA10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-2-minchan@kernel.org>
 <20190520081621.GV6836@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520081621.GV6836@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 20, 2019 at 10:16:21AM +0200, Michal Hocko wrote:
> [CC linux-api]

Thanks, Michal. I forgot to add it.

> 
> On Mon 20-05-19 12:52:48, Minchan Kim wrote:
> > When a process expects no accesses to a certain memory range
> > it could hint kernel that the pages can be reclaimed
> > when memory pressure happens but data should be preserved
> > for future use.  This could reduce workingset eviction so it
> > ends up increasing performance.
> > 
> > This patch introduces the new MADV_COOL hint to madvise(2)
> > syscall. MADV_COOL can be used by a process to mark a memory range
> > as not expected to be used in the near future. The hint can help
> > kernel in deciding which pages to evict early during memory
> > pressure.
> 
> I do not want to start naming fight but MADV_COOL sounds a bit
> misleading. Everybody thinks his pages are cool ;). Probably MADV_COLD
> or MADV_DONTNEED_PRESERVE.

Thanks for the suggestion. Since I got several suggestions, Let's discuss
them all at once in cover-letter.

> 
> > Internally, it works via deactivating memory from active list to
> > inactive's head so when the memory pressure happens, they will be
> > reclaimed earlier than other active pages unless there is no
> > access until the time.
> 
> Could you elaborate about the decision to move to the head rather than
> tail? What should happen to inactive pages? Should we move them to the
> tail? Your implementation seems to ignore those completely. Why?

Normally, inactive LRU could have used-once pages without any mapping
to user's address space. Such pages would be better candicate to
reclaim when the memory pressure happens. With deactivating only
active LRU pages of the process to the head of inactive LRU, we will
keep them in RAM longer than used-once pages and could have more chance
to be activated once the process is resumed.

> 
> What should happen for shared pages? In other words do we want to allow
> less privileged process to control evicting of shared pages with a more
> privileged one? E.g. think of all sorts of side channel attacks. Maybe
> we want to do the same thing as for mincore where write access is
> required.

It doesn't work with shared pages(ie, page_mapcount > 1). I will add it
in the description.

> -- 
> Michal Hocko
> SUSE Labs
