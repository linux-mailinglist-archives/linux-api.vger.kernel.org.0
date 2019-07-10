Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACA56455A
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2019 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfGJKsT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Jul 2019 06:48:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44058 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfGJKsT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Jul 2019 06:48:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so1021831plr.11;
        Wed, 10 Jul 2019 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SVbHqdqp8YOEjHzGDlrAyL6DJKyDMTvzdc6bOUeWR1I=;
        b=DD7J5KViJCMsZS754qIX6Y4jUrX0fWg/3IHZql0k5fRn26Pk0TShCitXRx7OTTseDY
         6v3lMMHATfhEJ3tiNCmpVNgPQ9kaPGY7EJsmhtkxPsqM64T02mvWG4PsHdCOQYJbz9ux
         eawlllSZ9RTrEvcD586DFY7lQs3yNlPtKpDmNyqNYspV05+EF1r2SnXxWA5KYG4s8oHd
         MUiWMcdjZYD3DoBxH2u4MxdefIL/a2JpZmK6Q3i57t/yGIXAIfs/0/MhnxTtvzV8ZGuA
         ndWAIgY4RLJO9XTIrPapP37/aV5PqRocILYKPeBhv2l5fEbxLR7CuF/KjYxb4Vy9+aAT
         nmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SVbHqdqp8YOEjHzGDlrAyL6DJKyDMTvzdc6bOUeWR1I=;
        b=WXdQHRAJhFpLH/fkCqA/h03TuJbbaZSKpBAvhYCyrsggyo3jLmRcRs5QC0fF2ZmLe7
         xgKp+h3T6azL6AaISM24LD/j2RLLzb7uw6KzKrpiHA/WotPf8mZLCwDHggYDdo3qZCD+
         tdXhdwKztIa1o7fgR3iwNh1ihYjCbBdBTfvWDogUMR1m/BzpCmUTh+OsYnwdMyLPc+/f
         Pm5oEYzbhbHgbJKhf5te2omGBY7VLgCcTyYdDeFNhLxxruWlnzPF2C3i/cDaZsWWnctW
         +jas2Ud6IGxCxzoc2QTihWFB0sP7IFuea9ATnvDFnBBUMtcBW2nwHeOGczaKBcrsjza/
         XI+A==
X-Gm-Message-State: APjAAAV1jzX7aaUb9YfVi7INj/yI3Y/sbjP+vpwer23Jh91HHQaNkvd1
        60OX0Rhw5i19Vrs/nfBudoE=
X-Google-Smtp-Source: APXvYqyUjXTFy7JIc4o6O8Fp/ORN4uEPxjM/KP3u/BWYZDGiSMFzR6sgSRyiktvoDcFkwIiWFQwugg==
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr35095869plv.209.1562755698240;
        Wed, 10 Jul 2019 03:48:18 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id p1sm2002534pff.74.2019.07.10.03.48.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 03:48:16 -0700 (PDT)
Date:   Wed, 10 Jul 2019 19:48:09 +0900
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
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190710104809.GA186559@google.com>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-5-minchan@kernel.org>
 <20190709095518.GF26380@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709095518.GF26380@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 09, 2019 at 11:55:19AM +0200, Michal Hocko wrote:
> On Thu 27-06-19 20:54:04, Minchan Kim wrote:
> > When a process expects no accesses to a certain memory range
> > for a long time, it could hint kernel that the pages can be
> > reclaimed instantly but data should be preserved for future use.
> > This could reduce workingset eviction so it ends up increasing
> > performance.
> > 
> > This patch introduces the new MADV_PAGEOUT hint to madvise(2)
> > syscall. MADV_PAGEOUT can be used by a process to mark a memory
> > range as not expected to be used for a long time so that kernel
> > reclaims *any LRU* pages instantly. The hint can help kernel in
> > deciding which pages to evict proactively.
> > 
> > - man-page material
> > 
> > MADV_PAGEOUT (since Linux x.x)
> > 
> > Do not expect access in the near future so pages in the specified
> > regions could be reclaimed instantly regardless of memory pressure.
> > Thus, access in the range after successful operation could cause
> > major page fault but never lose the up-to-date contents unlike
> > MADV_DONTNEED.
> 
> > It works for only private anonymous mappings and
> > non-anonymous mappings that belong to files that the calling process
> > could successfully open for writing; otherwise, it could be used for
> > sidechannel attack.
> 
> I would rephrase this way:
> "
> Pages belonging to a shared mapping are only processed if a write access
> is allowed for the calling process.
> "
> 
> I wouldn't really mention side channel attacks for a man page. You can
> mention can_do_mincore check and the side channel prevention in the
> changelog that is not aimed for the man page.

Agree. I will rephrase with one you suggested.
Thanks for the suggestion.

> 
> > MADV_PAGEOUT cannot be applied to locked pages, Huge TLB pages, or
> > VM_PFNMAP pages.
> > 
> > * v2
> >  * add comment about SWAP_CLUSTER_MAX - mhocko
> >  * add permission check to prevent sidechannel attack - mhocko
> >  * add man page stuff - dave
> > 
> > * v1
> >  * change pte to old and rely on the other's reference - hannes
> >  * remove page_mapcount to check shared page - mhocko
> > 
> > * RFC v2
> >  * make reclaim_pages simple via factoring out isolate logic - hannes
> > 
> > * RFCv1
> >  * rename from MADV_COLD to MADV_PAGEOUT - hannes
> >  * bail out if process is being killed - Hillf
> >  * fix reclaim_pages bugs - Hillf
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> 
> 
> I am still not convinced about the SWAP_CLUSTER_MAX batching and the
> udnerlying OOM argument. Is one pmd worth of pages really an OOM risk?
> Sure you can have many invocations in parallel and that would add on
> but the same might happen with SWAP_CLUSTER_MAX. So I would just remove
> the batching for now and think of it only if we really see this being a
> problem for real. Unless you feel really strong about this, of course.

I don't have the number to support SWAP_CLUSTER_MAX batching for hinting
operations. However, I wanted to be consistent with other LRU batching
logic so that it could affect altogether if someone try to increase
SWAP_CLUSTER_MAX which is more efficienty for batching operation, later.
(AFAIK, someone tried it a few years ago but rollback soon, I couldn't
rebemeber what was the reason at that time, anyway).

> 
> Anyway the patch looks ok to me otherwise.
> 
> Acked-by: Michal Hocko <mhocko@suse.co>

Thanks!
