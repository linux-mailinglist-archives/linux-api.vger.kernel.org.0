Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2C2B2A51
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 02:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKNBJv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 20:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKNBJv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Nov 2020 20:09:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD7CC0613D1
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 17:09:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so4971887wrt.0
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 17:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6uJPHVHZjnBVdYWG8pwd50i/TCRQ3PDiM6P81LC9MM=;
        b=b+5IzEVN7OejNiE+T/N86sZGs8yRU5yd0TTcbfR8EjeaFJuUrNJORujGZE+btEBN51
         LvI7gFJtqeQ+kiDR76okbOA4a0IrezJxY+sUFgOTXZCU3ccVJGuw3FM3JUkm6FvxqEXs
         BO9jvTrp4OOvXi5icvmcWbfr9Lx1TgGb/Cve1HvT2MFGnFDg5nIS0Afd1M6SahTPyg2w
         DgChod3vM3xBd/lhUWXP5KeWoCggDIJxIf4WurxOaQ1gSaPkaC0BYDQLqL2dpuC5Vvdi
         Pu33gRB6maWbKqiHg1dKp3vkjKQGWRb+mtDdBJpPHR0sdwPIT5rPltZO6YhZt3IkQSiR
         TIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6uJPHVHZjnBVdYWG8pwd50i/TCRQ3PDiM6P81LC9MM=;
        b=huEjyNz62eGFWZdqJ3EzhoONxfTkA6VU+0gKE9LKSFzS0Ncxso5yxJ2KqeZ+GZpbwD
         ENlcC590O2Fol55BTALaoHq+rqCuHk/+LRghELgpwVhG+Eu/eKL31a9smU1rHrJkQM7r
         SdURRyK5KnG9IPOMRw23zNvKaiBVAhm17D6KQ2pRT/X2Iwj14SZIZ5iifZ0LNRHdUtVr
         6t/ohSbqrikq05GSnWVyHAWZxPi89urQUAIKvssqG607f/k8bIhfUiVoxd9is+kyxOKD
         U5Ebfh3NrUsjQgBGkLaDSWj2JFrDgq3ik4TIau96HPzfPpPVAqASiChhpIMwRZgWl/3b
         Awog==
X-Gm-Message-State: AOAM530lGaSJgNJK4Y/SC641yizGx0w/47JrD1ryq7C1X2XzUGd5x1C/
        QG60qtbC39Ymb2cqpCLlwgwbsJh6F5HcMBFo4GpfgA==
X-Google-Smtp-Source: ABdhPJyDit7AsJHRIbjweR6pAqFyWC08iFm6LoUnZQFrvW1I7c0TBuVVH7MLkeKW1h4KCvmp8DYfa57x34fuVXOFbt8=
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr6801270wrs.106.1605316188293;
 Fri, 13 Nov 2020 17:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20201113173448.1863419-1-surenb@google.com> <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com> <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
In-Reply-To: <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 13 Nov 2020 17:09:37 -0800
Message-ID: <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 13, 2020 at 5:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Nov 2020 16:06:25 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > On Fri, Nov 13, 2020 at 3:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 13 Nov 2020 09:34:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > When a process is being killed it might be in an uninterruptible sleep
> > > > which leads to an unpredictable delay in its memory reclaim. In low memory
> > > > situations, when it's important to free up memory quickly, such delay is
> > > > problematic. Kernel solves this problem with oom-reaper thread which
> > > > performs memory reclaim even when the victim process is not runnable.
> > > > Userspace currently lacks such mechanisms and the need and potential
> > > > solutions were discussed before (see links below).
> > > > This patch provides a mechanism to perform memory reclaim in the context
> > > > of the process that sends SIGKILL signal. New SYNC_REAP_MM flag for
> > > > pidfd_send_signal syscall can be used only when sending SIGKILL signal
> > > > and will lead to the caller synchronously reclaiming the memory that
> > > > belongs to the victim and can be easily reclaimed.
> > >
> > > hm.
> > >
> > > Seems to me that the ability to reap another process's memory is a
> > > generally useful one, and that it should not be tied to delivering a
> > > signal in this fashion.
> > >
> > > And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
> > > few changes and tweaks, but can't that be used to solve this problem?
> >
> > Thank you for the feedback, Andrew. process_madvise(MADV_DONTNEED) was
> > one of the options recently discussed in
> > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > . The thread describes some of the issues with that approach but if we
> > limit it to processes with pending SIGKILL only then I think that
> > would be doable.
>
> Why would it be necessary to read /proc/pid/maps?  I'd have thought
> that a starting effort would be
>
>         madvise((void *)0, (void *)-1, MADV_PAGEOUT)
>
> (after translation into process_madvise() speak).  Which is equivalent
> to the proposed process_madvise(MADV_DONTNEED_MM)?

Yep, this is very similar to option #3 in
https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
and I actually have a tested prototype for that. If that's the
preferred method then I can post it quite quickly.

>
> There may be things which trip this up, such as mlocked regions or
> whatever, but we could add another madvise `advice' mode to handle
> this?
