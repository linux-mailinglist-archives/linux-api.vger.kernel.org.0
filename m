Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83E025D539
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 11:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgIDJgg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 05:36:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33927 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDJgf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 05:36:35 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kE890-0006Sg-0v; Fri, 04 Sep 2020 09:36:30 +0000
Date:   Fri, 4 Sep 2020 11:36:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
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
Message-ID: <20200904093627.vj6t6q5spicfyonh@wittgenstein>
References: <20200901000633.1920247-1-minchan@kernel.org>
 <20200901000633.1920247-4-minchan@kernel.org>
 <87blippc7p.fsf@mid.deneb.enyo.de>
 <20200903172618.GB1959033@google.com>
 <87pn72lq65.fsf@mid.deneb.enyo.de>
 <20200903175949.GC1959033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903175949.GC1959033@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 03, 2020 at 10:59:49AM -0700, Minchan Kim wrote:
> On Thu, Sep 03, 2020 at 07:34:58PM +0200, Florian Weimer wrote:
> > * Minchan Kim:
> > 
> > > On Tue, Sep 01, 2020 at 08:46:02PM +0200, Florian Weimer wrote:
> > >> * Minchan Kim:
> > >> 
> > >> >       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
> > >> >                 unsigned long vlen, int advice, unsigned int flags);
> > >> 
> > >> size_t for vlen provides a clearer hint regarding the type of special
> > >> treatment needed for ILP32 here (zero extension, not changing the type
> > >> to long long).
> > >> 
> > >
> > > All existing system calls using iove in Linux uses unsigned long so
> > > I want to be consistent with them unless process_madvise need something
> > > speicial.
> > 
> > Userspace uses int, following POSIX (where applicable).  There is no
> > consistency to be had here.
> 
> Okay, I changed it with size_t.

Maybe some context helps. We had the discussion about syscall
conventions during LPC both in the KernelSummit and in the glibc
toolchain session and one of wishlist conventions from libc was to
always use size_t and not unsigned long for sizes.
I know this has been a little frustrating having to change types and so
on for the syscall quite a bit but I'm going to start drafting an
updated version of our howto for adding syscalls now so things like this
are more transparent going forward. I just hadn't gotten around to it
right after Plumbers.

Christian
