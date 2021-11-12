Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7201C44E38A
	for <lists+linux-api@lfdr.de>; Fri, 12 Nov 2021 09:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhKLJA7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Nov 2021 04:00:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58914 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhKLJA6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Nov 2021 04:00:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9011721B19;
        Fri, 12 Nov 2021 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636707486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkR05k/DFv96yXZ/lJqoljojL8CyJn6KLqBUIDP3Z+w=;
        b=a/xykZk+UMhhumwe44SfoAxX9MWc8wbnfDMF0R08z5/IQS52lnWPpK7SL4TDXXMo06fBtM
        NL1A653z0Tfn9EwjsKxwdqgMcF4/mLlNnsb5KJDRFfcKexusg610SfPsqoEs5B+lO5pfhn
        99WTvZx3A9jR+QMYhgw9a2HhJVFWcn8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 41233A3B81;
        Fri, 12 Nov 2021 08:58:06 +0000 (UTC)
Date:   Fri, 12 Nov 2021 09:58:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and
 exit_mmap
Message-ID: <YY4snVzZZZYhbigV@dhcp22.suse.cz>
References: <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz>
 <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
 <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz>
 <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
 <YYrVmi2xdo1Gr2Bb@dhcp22.suse.cz>
 <CAJuCfpGrYa2Ws4GrVp_nRqVEw8j_cGXk+gprLYUx7NWUOC-uRQ@mail.gmail.com>
 <CAJuCfpHJnVG7PMhKW-Snz38az-Bv=QCFXa7DxD=KgEMbHJOi6A@mail.gmail.com>
 <YYzgZARxi8csprIx@dhcp22.suse.cz>
 <CAJuCfpEK+yruF8D9rzS44N3n6OLASL7nK2dfNj9daWpk-BguwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEK+yruF8D9rzS44N3n6OLASL7nK2dfNj9daWpk-BguwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 11-11-21 07:02:42, Suren Baghdasaryan wrote:
> On Thu, Nov 11, 2021 at 1:20 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 10-11-21 17:49:37, Suren Baghdasaryan wrote:
> > > On Tue, Nov 9, 2021 at 1:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Tue, Nov 9, 2021 at 12:10 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > > Yes, those can run concurrently. One thing I completely forgot about is
> > > > > 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> > > > > which is about interaction with the munlock.
> > >
> > > Agrh! This interaction with the munlock you mentioned requires us to
> > > take mmap_write_lock before munlock_vma_pages_all and that prevents
> > > __oom_reap_task_mm from running concurrently with unmap_vmas. The
> > > reapers would not be as effective as they are now after such a change
> > > :(
> >
> > __oom_reap_task_mm will not run concurrently with unmap_vmas even
> > with the current code. The mmap_sem barrier right before munlock code
> > prevents that.
> 
> You are right, it will run concurrently with another
> __oom_reap_task_mm in the exit_mmap. But I thought we wanted to get
> rid of that call to __oom_reap_task_mm in exit_mmap or did I
> misunderstand?

I do not remember this to be objective or the motivation. IIRC we wanted
to make the locking more robust which would help your process_mrelease
use case. This one currently suffers from a much heavier cost if it
turns out to be the last holder of the reference count on the address
space.
-- 
Michal Hocko
SUSE Labs
