Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47333B8B63
	for <lists+linux-api@lfdr.de>; Thu,  1 Jul 2021 02:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhGAArT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 20:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237629AbhGAArT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Jun 2021 20:47:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82D9761483
        for <linux-api@vger.kernel.org>; Thu,  1 Jul 2021 00:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625100289;
        bh=KzOU5etl1m1d6bSza+N7XM/HsZQCAVW9hItb7YjwLWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N2RgWghdU3Wjk0w7uX34y3R7WCDtq6wpIcfVtTGOZXgg6StM2NPvRnOVHTSNDlBxf
         rLUFaJmoWYpkTESon4nh0mWN4lstECAf+OSKCyl+G+4ApLdrrfJazkMQM+lPjq3beA
         xaRpKBvwpLwK3elynEhze4gxmm7tf1TQvVwWqAPX2emNoka+Mu40/V2chhbSCXfqr2
         46s0mLAHxuIBFCE9VojFiGnj0AudiNgly5D6P1UixxT0FudQCStax9hewXysweFeYk
         Hz+LC1sI9x3Sd36i8ckMri6r37To/8Lc576JaFjf7hpsXfqtTEHtCTF9xE4ivzy3Rr
         lmpyfJ4RBQiPQ==
Received: by mail-ej1-f43.google.com with SMTP id hr1so3981365ejc.1
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 17:44:49 -0700 (PDT)
X-Gm-Message-State: AOAM5327fwvyUzjSZawomAgqAneYlxcHIom98hunijHQs5cCWxjWNHJk
        85KG0kWzdHWCH5PoCEKXWWYrPvX+yeRAWUifXIMJtQ==
X-Google-Smtp-Source: ABdhPJzAb4C5+RtXDup6dhfGpilzWVw9K1ZS6+rN2ZPScS4npWvUVa7PsUSb5+URoJ6pBUECpl3Clp6njJO4GDxxVmc=
X-Received: by 2002:a17:907:1c98:: with SMTP id nb24mr17429770ejc.316.1625100287892;
 Wed, 30 Jun 2021 17:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com> <YNzl6XNu2vxyCJu8@cmpxchg.org>
In-Reply-To: <YNzl6XNu2vxyCJu8@cmpxchg.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 30 Jun 2021 17:44:36 -0700
X-Gmail-Original-Message-ID: <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
Message-ID: <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 30, 2021 at 2:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jun 30, 2021 at 11:51:36AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
> > > Also, please consider removing all mention of the word "reap" from the
> > > user API.  For better or for worse, "reap" in UNIX refers to what
> > > happens when a dead task gets wait()ed.  I sincerely wish I could go
> > > back in time and gently encourage whomever invented that particular
> > > abomination to change their mind, but my time machine doesn't work.
> >
> > I see. Thanks for the note. How about process_mem_release() and
> > replacing reap with release everywhere?
>
> I don't quite understand the objection. This syscall works on tasks
> that are at the end of their life, right? Isn't something like
> process_mreap() establishing exactly the mental link we want here?
> Release is less descriptive for what this thing is to be used for.

For better or for worse, "reap" means to make a zombie pid go away.
From the description, this new operation takes a dying process (not
necessarily a zombie yet) and aggressively frees its memory.  This is
a different optioneration.

How about "free_dying_process_memory"?
