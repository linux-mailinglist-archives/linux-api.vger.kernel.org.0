Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A273D3D2E
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 18:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhGWP2b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhGWP2a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 11:28:30 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CE5C061757
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 09:09:03 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s19so3095354ybc.6
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VI9kjwn56WWv5KeEalz1sUOG8bqHQgJMneVLRITpE8=;
        b=HnSX6z/1YI5rXl+MYn2P5T5hZOevSHHeW+jNbG8MGohEZ1Wuzi7t/jwv7XCJH6AZ1I
         FD7INh7OuYKWpoYPUR/p11IO2kSJrFj2OYH76szUajxedJqjkOqACB3OK0tmGwbMHKJz
         fc8yyxJCdPtwHy+ViMLE/PlORPVrJlXYvpXUC3rSvO/NW4TBGljDlWullE05QB+tILjC
         ZgrUB62VLO4dUlmpKWCFz5aIQkr/5tBgZk57sMzG/vtDDafyDTkd0h9cQRMRjo+bdKha
         oabft7VQE1z/eUZMwE3MAcvEQDBLVoIqdYF+/WJJgqDLHCAOXeYAohYVKZLIZWMvc6th
         VsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VI9kjwn56WWv5KeEalz1sUOG8bqHQgJMneVLRITpE8=;
        b=KXTklITgMtCIC48EN1b23hOknT+JF/aJIp6y9xAOVzPquN1xxeXhasY+dtG1eKrB2l
         HOaR/P1HQcKhLDArYfsg+1ObdAUJ85OR1VACiCfLNSvNkljGw0f3ys27qUE9rZrYn6EH
         fJ+9kx603jgK/wnjdhc2qUYYSuNTG0WcaHY+itsMHqMiFO8leVODz31DYdVBtUK5VgAq
         q3ArwHViOhNKSe/9SbZCsmKZVjz/oprjw4Kxxu0WLSURCbkzEvMriv2E/y0hK7Hh+pWm
         rK+N873LRJ/yXbOkVjneiu4pdj7+mTaryDJttMZgQHYGSGni7mycGUaRfZnQRS0VIbUq
         ID2g==
X-Gm-Message-State: AOAM531bh41Lptoq0GFu9YI6TK6AlE8IrfjVIoGRjtq279D0vCEIBrDk
        mMiL9cmoIEXq/WGmDEOV8VRa9ijY2Hc2qQiUtOsCgg==
X-Google-Smtp-Source: ABdhPJxn9uo3Wjfj7r9vGXqp6Gdk3SsItVIldrE0qi/gRxSuu+MaBGMIKTB9xh6E3rjPRojpVOS308evtSnl0wGLsS4=
X-Received: by 2002:a25:5f11:: with SMTP id t17mr1954300ybb.84.1627056541923;
 Fri, 23 Jul 2021 09:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz> <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
In-Reply-To: <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 23 Jul 2021 09:08:50 -0700
Message-ID: <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 23, 2021 at 6:46 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Jul 23, 2021 at 1:53 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> > > However
> > > retrying means issuing another syscall, so additional overhead...
> > > I guess such "best effort" approach would be unusual for a syscall, so
> > > maybe we can keep it as it is now and if such "do not block" mode is needed
> > > we can use flags to implement it later?
> >
> > Yeah, an explicit opt-in via flags would be an option if that turns out
> > to be really necessary.
> >
>
> I am fine with keeping it as it is but we do need the non-blocking
> option (via flags) to enable userspace to act more aggressively.

I think you want to check memory conditions shortly after issuing
kill/reap requests irrespective of mmap_sem contention. The reason is
that even when memory release is not blocked, allocations from other
processes might consume memory faster than we release it. For example,
in Android we issue kill and start waiting on pidfd for its death
notification. As soon as the process is dead we reassess the situation
and possibly kill again. If the process is not dead within a
configurable timeout we check conditions again and might issue more
kill requests (IOW our wait for the process to die has a timeout). If
process_mrelease() is blocked on mmap_sem, we might timeout like this.
I imagine that a non-blocking option for process_mrelease() would not
really change this logic.
Adding such an option is trivial but I would like to make sure it's
indeed useful. Maybe after the syscall is in place you can experiment
with it and see if such an option would really change the way you use
it?
