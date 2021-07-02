Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E03BA2BF
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhGBPaE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 11:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhGBPaE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 2 Jul 2021 11:30:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 283F66141D;
        Fri,  2 Jul 2021 15:27:26 +0000 (UTC)
Date:   Fri, 2 Jul 2021 17:27:24 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
Message-ID: <20210702152724.7fv5tnik4qlap6do@wittgenstein>
References: <20210623192822.3072029-1-surenb@google.com>
 <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
 <YNzl6XNu2vxyCJu8@cmpxchg.org>
 <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
 <CAJuCfpG5Ua7C4usJGEqTm6_UUd6VyRd0BsPgT97LWOzjb4Ry+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpG5Ua7C4usJGEqTm6_UUd6VyRd0BsPgT97LWOzjb4Ry+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 01, 2021 at 03:59:48PM -0700, Suren Baghdasaryan wrote:
> On Wed, Jun 30, 2021 at 5:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Jun 30, 2021 at 2:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Jun 30, 2021 at 11:51:36AM -0700, Suren Baghdasaryan wrote:
> > > > On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
> > > > > Also, please consider removing all mention of the word "reap" from the
> > > > > user API.  For better or for worse, "reap" in UNIX refers to what
> > > > > happens when a dead task gets wait()ed.  I sincerely wish I could go
> > > > > back in time and gently encourage whomever invented that particular
> > > > > abomination to change their mind, but my time machine doesn't work.
> > > >
> > > > I see. Thanks for the note. How about process_mem_release() and
> > > > replacing reap with release everywhere?
> > >
> > > I don't quite understand the objection. This syscall works on tasks
> > > that are at the end of their life, right? Isn't something like
> > > process_mreap() establishing exactly the mental link we want here?
> > > Release is less descriptive for what this thing is to be used for.
> >
> > For better or for worse, "reap" means to make a zombie pid go away.
> > From the description, this new operation takes a dying process (not
> > necessarily a zombie yet) and aggressively frees its memory.  This is
> > a different optioneration.
> >
> > How about "free_dying_process_memory"?
> 
> process_mreap sounds definitely better and in line with names like
> process_madvise. So maybe we can use it?

That one was my favorite from the list I gave too but maybe we can
satisfy Andy too if we use one of:
- process_mfree()
- process_mrelease()
