Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288073B98CB
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 01:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhGAXCf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Jul 2021 19:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhGAXCe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Jul 2021 19:02:34 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C6C061762
        for <linux-api@vger.kernel.org>; Thu,  1 Jul 2021 16:00:02 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r135so13592690ybc.0
        for <linux-api@vger.kernel.org>; Thu, 01 Jul 2021 16:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKQAwFjuaAaCUshwMfZMCC25WSRc/6MI7bYOaT2lCu0=;
        b=FoF9JYuQr2PlAVV/PhJWgD36muB9/aW/s+nV24F+xMy0h2zSpj362f8TWPJDLDGa18
         QHu25LoAVyZ3n/D4n+D4/Yw3QqVLPAkMkedrYl3t6mUMyP6FffkPvJr/mgzJ6CKPeocY
         JUfsSwAkeJoevYgGMRK4v1MYvth6O2/Rlwkh/ziIDs7+zoMwbI6ROOaHte8KUCwQQd++
         HLbbCDyi2U/PtWgvf/r6u8Ta7WSkJVDfet8kOKMK6qsJ6K+zcoq6p93aP1XjH0MNOOHX
         Vj4luGFFW0KdDZB586uQS/Wf7MXqo+USQJHhoOL4+OQZgCerlNgrrN3YVIgCcojWU34p
         YTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKQAwFjuaAaCUshwMfZMCC25WSRc/6MI7bYOaT2lCu0=;
        b=RqxQ8bvKjQMVDw1kcFpWjSg4z8MCBLmgGFP+7Ag+drgJX7F3J9bEeV5NxEiEClrRR7
         32yWnB6O51xoMNnXgXEQBFgoCnuWvVBBSv2f4PYOpgZxpTmZRdhDZHmyYGHmW6wlvQlC
         IScRBGCrRb05zht4bo3pV0ZYYimjH/ag/irfccZtHgsfVgLla18VNZh3O40HCWji/TY7
         DVOxWQAMdU+MQz2gD9naEUBPEEhXODWhmjLJyCQmvIQhXW9yaI/GJt+kZWnfD1hR+ZIz
         vwLFieHmRu9qBb5L71Qh0yL4Ys2dq7gKtyxW0xi8y4kc+wbpA/ZeH82BVoQMa2B1q4rk
         7Wdw==
X-Gm-Message-State: AOAM532is7z7F/nws+l/1c0GVwezFr+ADJpkId0VYHwjiR5abB8itkOS
        puaXHR2W8D784DBdY2OK/ptBsaBqim435+o9uAbcSQ==
X-Google-Smtp-Source: ABdhPJz1GahShCzpqEDbjJXS/OG05BwiTLL16WKqm1uItCK8AEpt3nGqA1WXxQC4ONTDzI4RGDY9KSIsX7TYVHYAPS8=
X-Received: by 2002:a25:83ca:: with SMTP id v10mr2997364ybm.84.1625180400150;
 Thu, 01 Jul 2021 16:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
 <YNzl6XNu2vxyCJu8@cmpxchg.org> <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
In-Reply-To: <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Jul 2021 15:59:48 -0700
Message-ID: <CAJuCfpG5Ua7C4usJGEqTm6_UUd6VyRd0BsPgT97LWOzjb4Ry+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Wed, Jun 30, 2021 at 5:44 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Jun 30, 2021 at 2:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Jun 30, 2021 at 11:51:36AM -0700, Suren Baghdasaryan wrote:
> > > On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
> > > > Also, please consider removing all mention of the word "reap" from the
> > > > user API.  For better or for worse, "reap" in UNIX refers to what
> > > > happens when a dead task gets wait()ed.  I sincerely wish I could go
> > > > back in time and gently encourage whomever invented that particular
> > > > abomination to change their mind, but my time machine doesn't work.
> > >
> > > I see. Thanks for the note. How about process_mem_release() and
> > > replacing reap with release everywhere?
> >
> > I don't quite understand the objection. This syscall works on tasks
> > that are at the end of their life, right? Isn't something like
> > process_mreap() establishing exactly the mental link we want here?
> > Release is less descriptive for what this thing is to be used for.
>
> For better or for worse, "reap" means to make a zombie pid go away.
> From the description, this new operation takes a dying process (not
> necessarily a zombie yet) and aggressively frees its memory.  This is
> a different optioneration.
>
> How about "free_dying_process_memory"?

process_mreap sounds definitely better and in line with names like
process_madvise. So maybe we can use it?
