Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F63C2118
	for <lists+linux-api@lfdr.de>; Fri,  9 Jul 2021 10:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhGIJBr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Jul 2021 05:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhGIJBr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 9 Jul 2021 05:01:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D61A761375;
        Fri,  9 Jul 2021 08:58:59 +0000 (UTC)
Date:   Fri, 9 Jul 2021 10:58:57 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
Message-ID: <20210709085857.zf5ik3btet3yw4ab@wittgenstein>
References: <20210623192822.3072029-1-surenb@google.com>
 <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
 <YNzl6XNu2vxyCJu8@cmpxchg.org>
 <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
 <CAJuCfpG5Ua7C4usJGEqTm6_UUd6VyRd0BsPgT97LWOzjb4Ry+g@mail.gmail.com>
 <20210702152724.7fv5tnik4qlap6do@wittgenstein>
 <af8e76f1-6625-25d1-98d2-a3c8a9bf2fd6@redhat.com>
 <YOWcj0+P238W1y+t@dhcp22.suse.cz>
 <CAJuCfpH8QQyxivztkC2-_Kk1MqA0mJVs91XXpvVsL=NzNebshw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpH8QQyxivztkC2-_Kk1MqA0mJVs91XXpvVsL=NzNebshw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 07, 2021 at 02:14:23PM -0700, Suren Baghdasaryan wrote:
> On Wed, Jul 7, 2021 at 5:38 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 05-07-21 09:41:54, David Hildenbrand wrote:
> > > On 02.07.21 17:27, Christian Brauner wrote:
> > [...]
> > > > That one was my favorite from the list I gave too but maybe we can
> > > > satisfy Andy too if we use one of:
> > > > - process_mfree()
> > > > - process_mrelease()
> > > >
> > >
> > > FWIW, I tend to like process_mrelease(), due to the implied "release" ("free
> > > the memory if there are no other references") semantics.
> >
> > Agreed.
> 
> Ok, sounds like process_mrelease() would be an acceptable compromise.
> 
> >
> > > Further, a new
> > > syscall feels cleaner than some magic sysfs/procfs toggle. Just my 2 cents.
> >
> > Yeah, proc based interface is both tricky to use and kinda ugly now that
> > pidfd can solve all at in once.
> 
> Sounds good. Will keep it as is then.
> 
> > My original preference was a more generic kill syscall to allow flags
> > but a dedicated syscall doesn't look really bad either.
> 
> Yeah, I have tried that direction unsuccessfully before arriving at
> this one. Hopefully it represents the right compromise which can
> satisfy everyone's usecase.

I think a syscall is fine and it's not we're running out of numbers
(anymore). :)

Christian
