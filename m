Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793C43D543B
	for <lists+linux-api@lfdr.de>; Mon, 26 Jul 2021 09:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhGZGqp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Jul 2021 02:46:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhGZGqo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Jul 2021 02:46:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 72BF41FE4E;
        Mon, 26 Jul 2021 07:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627284426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2WTPXg9jtkTLUwn6ZQVnV0CQ21c+QYV38LrXPD0qpI=;
        b=lii6HwSE+gqVJUuP8L81Pvjvup1X1wiBTKtKcYvsAJ0kU4nr6+5sZCYDcZp/q7b4mBM8Qg
        N9qK+8nhZ4Pcp6eI52hVAt4cVdMJgqLi3viwKpZ6zOjrIqwh1eFKYj3ikLzOl7E/TEFAN8
        fX9cMb/nDTmGJAi3k0aqk9NqsrvQLvI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B9204A3B96;
        Mon, 26 Jul 2021 07:27:05 +0000 (UTC)
Date:   Mon, 26 Jul 2021 09:27:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
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
Message-ID: <YP5jyLeYsN3JtdX8@dhcp22.suse.cz>
References: <20210723011436.60960-1-surenb@google.com>
 <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz>
 <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz>
 <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
 <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
 <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 23-07-21 10:00:26, Shakeel Butt wrote:
> On Fri, Jul 23, 2021 at 9:09 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Jul 23, 2021 at 6:46 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Fri, Jul 23, 2021 at 1:53 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > [...]
> > > > > However
> > > > > retrying means issuing another syscall, so additional overhead...
> > > > > I guess such "best effort" approach would be unusual for a syscall, so
> > > > > maybe we can keep it as it is now and if such "do not block" mode is needed
> > > > > we can use flags to implement it later?
> > > >
> > > > Yeah, an explicit opt-in via flags would be an option if that turns out
> > > > to be really necessary.
> > > >
> > >
> > > I am fine with keeping it as it is but we do need the non-blocking
> > > option (via flags) to enable userspace to act more aggressively.
> >
> > I think you want to check memory conditions shortly after issuing
> > kill/reap requests irrespective of mmap_sem contention. The reason is
> > that even when memory release is not blocked, allocations from other
> > processes might consume memory faster than we release it. For example,
> > in Android we issue kill and start waiting on pidfd for its death
> > notification. As soon as the process is dead we reassess the situation
> > and possibly kill again. If the process is not dead within a
> > configurable timeout we check conditions again and might issue more
> > kill requests (IOW our wait for the process to die has a timeout). If
> > process_mrelease() is blocked on mmap_sem, we might timeout like this.
> > I imagine that a non-blocking option for process_mrelease() would not
> > really change this logic.
> 
> On a containerized system, killing a job requires killing multiple
> processes and then process_mrelease() them. Now there is cgroup.kill
> to kill all the processes in a cgroup tree but we would still need to
> process_mrelease() all the processes in that tree.

Is process_mrelease on all of them really necessary? I thought that the
primary reason for the call is to guarantee a forward progress in cases
where the userspace OOM victim cannot die on SIGKILL. That should be
more an exception than a normal case, no?

> There is a chance
> that we get stuck in reaping the early process. Making
> process_mrelease() non-blocking will enable the userspace to go to
> other processes in the list.

I do agree that allowing (guanrateed) non-blocking behavior is nice but
it is also a rather strong promise. There is some memory that cannot be
released by the oom reaper currently because there are locks involved
(e.g. mlocked memory or memory areas backed by blocking notifiers).
I can imagine some users of this api would rather block and make sure to
release the memory rather than skip over it. So if anything this has to
be an opt in with a big fat warning that the behavior of the kernel wrt
to releasable memory can vary due to all sorts of implementation
details.

> An alternative would be to have a cgroup specific interface for
> reaping similar to cgroup.kill.

Could you elaborate?

-- 
Michal Hocko
SUSE Labs
