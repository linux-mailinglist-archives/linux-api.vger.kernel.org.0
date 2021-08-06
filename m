Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBADC3E2862
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbhHFKPT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 06:15:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44146 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244773AbhHFKPT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 06:15:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E01A222369;
        Fri,  6 Aug 2021 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628244902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFGRy0TVO6Sv+kOUDL6gKJLzvhAhsmyj9YyaOQWydKs=;
        b=syvPzm/lthsXkM5NM4glpb2MPQNmaSopqfCTTaMkrKi5PbeuC8rIgUdn27XRNSTHYiK0+O
        85ZkxXSjmmCRROz5BZ4PpgyIGbd+6jgPfCWwvkCDFmSETl56dvEi6BbGb81OvhaYpQutMv
        q4fxt2MEFHLW3OZXZreuY1B2dKlEaX4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 47BE0A3B85;
        Fri,  6 Aug 2021 10:15:02 +0000 (UTC)
Date:   Fri, 6 Aug 2021 12:15:01 +0200
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
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
Message-ID: <YQ0LpeeDuRPqEyir@dhcp22.suse.cz>
References: <20210805170859.2389276-1-surenb@google.com>
 <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
 <CALvZod6k3Bm77xt4y=Mvf1Oi8XH25UJwLQaJaFNBFsBAcRuO_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6k3Bm77xt4y=Mvf1Oi8XH25UJwLQaJaFNBFsBAcRuO_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 06-08-21 02:23:17, Shakeel Butt wrote:
> On Thu, Aug 5, 2021 at 11:40 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> > I think you really want something like this:
> >
> >         if (flags)
> >                 return -EINVAL;
> >
> >         pid = pidfd_get_pid(fd, &f_flags);
> >         if (IS_ERR(pid))
> >                 return PTR_ERR(pid);
> >         task = get_pid_task(pid, PIDTYPE_PID);
> >         if (!task) {
> >                 ret = -ESRCH;
> >                 goto put_pid;
> >         }
> >
> >         /*
> >          * Make sure to chose a thread which still has a reference to mm
> >          * during the group exit
> >          */
> >         p = find_lock_task_mm(task);
> >         if (!p) {
> >                 ret = -ESRCH;
> >                 goto put_task;
> >         }
> >
> >         mm = task->mm;
> 
> mm = p->mm;

right. Thanks!

-- 
Michal Hocko
SUSE Labs
