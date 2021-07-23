Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB12D3D371F
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 10:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhGWINS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 04:13:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43696 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbhGWINS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 04:13:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 03E181FF64;
        Fri, 23 Jul 2021 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627030431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLSkPVb0qmdjS8aLyMRIbeEymJYhZrsklJC7sIwz+zk=;
        b=FTrHQ2b85dXEcFaDdqgXGkWUWLZf5DCjTR8B6ODPFpAy+R/2uREN3c18+Broig0Y9yWZrQ
        XqzkNywyBSZHM3ncLxRR+QrqjZEO1HFwSuPO9xWU5TYS5DIvDGBSFpgMlxpqClwAHOBTwg
        3lqto1PMPWXEBgWczPQ8yh6paQdcfjI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CEF52A3B9A;
        Fri, 23 Jul 2021 08:53:50 +0000 (UTC)
Date:   Fri, 23 Jul 2021 10:53:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
Message-ID: <YPqDnqULylkkzQG5@dhcp22.suse.cz>
References: <20210723011436.60960-1-surenb@google.com>
 <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz>
 <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 23-07-21 01:11:51, Suren Baghdasaryan wrote:
> On Thu, Jul 22, 2021, 11:20 PM Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Thu 22-07-21 21:47:56, Suren Baghdasaryan wrote:
> > > On Thu, Jul 22, 2021, 7:04 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > > On Thu, Jul 22, 2021 at 6:14 PM Suren Baghdasaryan <surenb@google.com>
> > > > wrote:
> > > > >
> > > > [...]
> > > > > +
> > > > > +       mmap_read_lock(mm);
> > > >
> > > > How about mmap_read_trylock(mm) and return -EAGAIN on failure?
> > > >
> > >
> > > That sounds like a good idea. Thanks! I'll add that in the next respin.
> >
> > Why is that a good idea? Can you do anything meaningful about the
> > failure other than immediately retry the syscall and hope for the best?
> >
> 
> I was thinking if this syscall implements "best effort without blocking"
> approach then for a more strict usage user can simply retry.

I do not think we really want to promise non blocking behavior at this
stage unless that is absolutely necessary. The current implementation
goes an extra mile to not block but I wouldn't carve it into stone via
userspace expectations.

> However
> retrying means issuing another syscall, so additional overhead...
> I guess such "best effort" approach would be unusual for a syscall, so
> maybe we can keep it as it is now and if such "do not block" mode is needed
> we can use flags to implement it later?

Yeah, an explicit opt-in via flags would be an option if that turns out
to be really necessary.
-- 
Michal Hocko
SUSE Labs
