Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8750A44D3EE
	for <lists+linux-api@lfdr.de>; Thu, 11 Nov 2021 10:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhKKJX2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Nov 2021 04:23:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39030 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhKKJX1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Nov 2021 04:23:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 553FD21B35;
        Thu, 11 Nov 2021 09:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636622437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VKcDr2fKCQCckd3lBGavIW/Vf9CpVRyHsHkDbRYBxl4=;
        b=KPkrH2PbhZsBvSh275iz8ij3LnsQNcUkX8VhPI9+7SbFZKgx6+tXzz6Zv1yL7Qj80WxH0M
        +vuuVBq75iQHbByg/cH50cnIwEBFMEaWmCIBiaXhbpt7IUFlYUZR8N1cRqdHf5YJt0en0s
        mrodPCnwLfpm4N6p1p1ACTlkJsY7B+k=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 03AABA3BF2;
        Thu, 11 Nov 2021 09:20:36 +0000 (UTC)
Date:   Thu, 11 Nov 2021 10:20:36 +0100
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
Message-ID: <YYzgZARxi8csprIx@dhcp22.suse.cz>
References: <YYDvm9c/7cGtBvw6@dhcp22.suse.cz>
 <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz>
 <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
 <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz>
 <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
 <YYrVmi2xdo1Gr2Bb@dhcp22.suse.cz>
 <CAJuCfpGrYa2Ws4GrVp_nRqVEw8j_cGXk+gprLYUx7NWUOC-uRQ@mail.gmail.com>
 <CAJuCfpHJnVG7PMhKW-Snz38az-Bv=QCFXa7DxD=KgEMbHJOi6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHJnVG7PMhKW-Snz38az-Bv=QCFXa7DxD=KgEMbHJOi6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 10-11-21 17:49:37, Suren Baghdasaryan wrote:
> On Tue, Nov 9, 2021 at 1:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, Nov 9, 2021 at 12:10 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > Yes, those can run concurrently. One thing I completely forgot about is
> > > 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> > > which is about interaction with the munlock.
> 
> Agrh! This interaction with the munlock you mentioned requires us to
> take mmap_write_lock before munlock_vma_pages_all and that prevents
> __oom_reap_task_mm from running concurrently with unmap_vmas. The
> reapers would not be as effective as they are now after such a change
> :(

__oom_reap_task_mm will not run concurrently with unmap_vmas even
with the current code. The mmap_sem barrier right before munlock code
prevents that.

-- 
Michal Hocko
SUSE Labs
