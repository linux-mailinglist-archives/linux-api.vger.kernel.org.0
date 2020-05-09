Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B11CC166
	for <lists+linux-api@lfdr.de>; Sat,  9 May 2020 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgEIMsZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 9 May 2020 08:48:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgEIMsZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 9 May 2020 08:48:25 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jXOtv-0003Jb-3t; Sat, 09 May 2020 12:48:19 +0000
Date:   Sat, 9 May 2020 14:48:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH v7 5/7] mm: support both pid and pidfd for process_madvise
Message-ID: <20200509124817.xmrvsrq3mla6b76k@wittgenstein>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-6-minchan@kernel.org>
 <14089609-5fb1-b082-716f-c2e129d27c48@suse.cz>
 <20200311004251.GB87930@google.com>
 <20200508183653.GB125527@google.com>
 <20200508160415.65ff359a9e312c613336587b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508160415.65ff359a9e312c613336587b@linux-foundation.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 08, 2020 at 04:04:15PM -0700, Andrew Morton wrote:
> On Fri, 8 May 2020 11:36:53 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > 
> > ...
> >
> > Per Vlastimil's request, I changed "which and advise" with "idtype and
> > advice" in function prototype of description.
> > Could you replace the part in the description? Code is never changed.
> > 
> 
> Done, but...
> 
> >
> > ...
> >
> > There is a demand[1] to support pid as well pidfd for process_madvise to
> > reduce unnecessary syscall to get pidfd if the user has control of the
> > target process(ie, they could guarantee the process is not gone or pid is
> > not reused).
> > 
> > This patch aims for supporting both options like waitid(2).  So, the
> > syscall is currently,
> > 
> >         int process_madvise(idtype_t idtype, id_t id, void *addr,
> >                 size_t length, int advice, unsigned long flags);
> > 
> > @which is actually idtype_t for userspace libray and currently, it
> > supports P_PID and P_PIDFD.
> 
> What does "@which is actually idtype_t for userspace libray" mean?  Can
> you clarify and expand?

If I may clarify, the only case where we've supported both pidfd and pid
in the same system call is waitid() to avoid adding a dedicated system
call for waiting and because waitid() already had this (imho insane)
argument type switching. The idtype_t thing comes from waitid() and is
located int sys/wait.h and is defined as

"The type idtype_t is defined as an enumeration type whose possible
values include at least the following:

P_ALL
P_PID
P_PGID
"

int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
If idtype is P_PID, waitid() shall wait for the child with a process ID equal to (pid_t)id.
If idtype is P_PGID, waitid() shall wait for any child with a process group ID equal to (pid_t)id.
If idtype is P_ALL, waitid() shall wait for any children and id is ignored.

I'm personally not a fan of this idtype_t thing and think this should
just have been 
> >         int pidfd_madvise(int pidfd, void *addr,
> >                 size_t length, int advice, unsigned long flags);
and call it a day.

Also, if I may ask, why is the flag argument "unsigned long"?
That's pretty unorthodox. The expectation is that flag arguments are
not word-size dependent and should usually use "unsigned int". All new
system calls follow this pattern too.

The current syscall layout will mean that on 64 bit systems you have 64
flag bits and on 32 bit you have 32 flag bits, I think. That has just
recently led to some problems with the clone() syscall (fixed in [1]
which I'm sending Monday) which has the same weird word-size-dependent
flag argument layout. If a system does sign-extension and a userspace
api or glibc uses e.g. an int for the flag argument in the system call
wrapper - which is fairly common - you can get sign extended and then
you end up with garbage in the upper 32 bits of your system call.

> 
> Also, does this userspace library exist?  If so, where is it?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fixes&id=3f2c788a13143620c5471ac96ac4f033fc9ac3f3

Christian
