Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F3271B45
	for <lists+linux-api@lfdr.de>; Mon, 21 Sep 2020 09:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIUHON (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Sep 2020 03:14:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgIUHON (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 21 Sep 2020 03:14:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600672451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=svbwHwBodOTvgdlvY5XDzm7sMwGYP2RjQJZ+9FLSCds=;
        b=jJJ5gd9pBpyUA1mZ1gMOozlsHeBnD1yxFRFP7ZwGRXbukVMmG5I7CT+TXuG/dmHFW7G28w
        HyNkLcslbrFGD1EKuR/7Cb2o48JQQPDTUvmrNJkTNJqdLK+NZsRU5UelYVPv1pjxwdubEu
        LXO7uAo7LNgnjuW5ygH/OywJvAOxyZc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D96A5ABB2;
        Mon, 21 Sep 2020 07:14:46 +0000 (UTC)
Date:   Mon, 21 Sep 2020 09:14:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v9 3/3] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
Message-ID: <20200921071410.GB12990@dhcp22.suse.cz>
References: <20200901000633.1920247-1-minchan@kernel.org>
 <20200901000633.1920247-4-minchan@kernel.org>
 <20200921065633.GA8070@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921065633.GA8070@infradead.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 21-09-20 07:56:33, Christoph Hellwig wrote:
> On Mon, Aug 31, 2020 at 05:06:33PM -0700, Minchan Kim wrote:
> > There is usecase that System Management Software(SMS) want to give a
> > memory hint like MADV_[COLD|PAGEEOUT] to other processes and in the
> > case of Android, it is the ActivityManagerService.
> > 
> > The information required to make the reclaim decision is not known to
> > the app.  Instead, it is known to the centralized userspace
> > daemon(ActivityManagerService), and that daemon must be able to
> > initiate reclaim on its own without any app involvement.
> > 
> > To solve the issue, this patch introduces a new syscall process_madvise(2).
> > It uses pidfd of an external process to give the hint. It also supports
> > vector address range because Android app has thousands of vmas due to
> > zygote so it's totally waste of CPU and power if we should call the
> > syscall one by one for each vma.(With testing 2000-vma syscall vs
> > 1-vector syscall, it showed 15% performance improvement.  I think it
> > would be bigger in real practice because the testing ran very cache
> > friendly environment).
> 
> I'm really not sure this syscall is a good idea.  If you want central
> control you should implement an IPC mechanisms that allows your
> supervisor daemon to tell the application to perform the madvice
> instead of forcing the behavior on it.

Even though I am not entirely happy about the interface [1]. As it seems
I am in minority in my concern I backed off and decided to not block this
work because I do not see the problem with the functionality itself. And
I find it very useful for userspace driven memory management people are
asking for a long time.

This functionality shouldn't be much different from the standard memory
reclaim. It has some limitations (e.g. it can only handle mapped memory)
but allows to pro-actively swap out or reclaim disk based memory based
on a specific knowlege of the workload. Kernel is not able to do the
same.

[1] http://lkml.kernel.org/r/20200117115225.GV19428@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
