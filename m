Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDECE1652BB
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 23:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBSWwX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Feb 2020 17:52:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37104 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBSWwW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Feb 2020 17:52:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so19626134edr.4
        for <linux-api@vger.kernel.org>; Wed, 19 Feb 2020 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FX5hZLCPWe9TXE9QW2GtR6K9rNwkX1yJcBPCRG5Bqk=;
        b=PcUbOCPznDsTd1uUy3g6aidkM7d0tqqur5WbsmxlcTY+nlyZ1Af+UWhbMKlJkJytm4
         8fsXPlCWs1AKEaFZ7Ux2tSFs5WpV+2HksQY6tsT0vnFOnt4rvX5gOEfjpvsuAum+td0f
         lZaXfYTKV/qwMIZRQeWPKhSXS6amhShfMgQSTbbJZvp3cZTuWAOY9qwblEdAjIlbzWMs
         DI2tmAEtZWaYnP8KX0S/EwZwv9QIqwK4dSzYI+QOzBAI/fJsmMmnctj5mssKRHkRVgqe
         lWS0XkC5IUhK/70DTcyP9ebbkiZ7p7bQ6GlZkUDhqaw4E0qc+nhtxBAlfd+EchWkH4ps
         EjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FX5hZLCPWe9TXE9QW2GtR6K9rNwkX1yJcBPCRG5Bqk=;
        b=G7jvimabOgoFJvTinQ5YEb7flOj4mjDih7xD0N0RNDuIhplAFQklexZrYjifs0M3AT
         LnbE/5Ne4EjuIrqPUSKg7cl6vU9pDYvcsYlO39USFYWgDb2kR0HDhmnRDJxALxz+DqxG
         /LLWzWZdWUzuSSULgTc6KP+yp77NeDWdf4oltug8won+cF+Z4Z0pCh11uk6LQPIGPv41
         +qO6qj1nIYWuZ0aTKz99YUAxu0UFxoFEBiDOlUiW6y4fLhBdxZdilc/rqNwPyheOCkY/
         P0kCCozk94HX4JQ5djYBmzuMwFpgF8yjbptky42rolw8D0N/NJ80f6gTxvqjq84+83CY
         sjKg==
X-Gm-Message-State: APjAAAXl2Hyaiumf4DQxN73rxdEYSAmOTFtGWzKImeMhUeA56KUuxXWp
        BGG7/6sqrPfKvnnaTeYsVIhq2CCJfdC54Qq0158AcQ==
X-Google-Smtp-Source: APXvYqx0+8EApKqslGjXjpM5Azv3t3MhoqMEF0b2EBiqIdz/10EUJ8xYiTg6j4DRMnQSSSoQLlMY7NlD++332yBh21o=
X-Received: by 2002:a17:906:4e01:: with SMTP id z1mr26915118eju.46.1582152739691;
 Wed, 19 Feb 2020 14:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219120123.07dda51c29006a892059ccde@linux-foundation.org>
 <20200219223241.GA148976@google.com>
In-Reply-To: <20200219223241.GA148976@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 19 Feb 2020 14:51:53 -0800
Message-ID: <CADyq12wn-0ngnqf7WvAWBk+0jiju1_DXWs6LwiQoQ0dfAjzMRQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] introduce memory hinting API for external process
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

To expand on how ChromeOS benefits from this, we've advanced far
beyond the experimentation phase we've deployed an older version of
this idea that was procfs based on several ChromeOS kernels. These are
now rolled out to ChromeOS stable channel where we've been testing and
the results have been amazing. To elaborate on the setup, Chrome is a
multi process architecture where each tab is a separate process and
sometimes a single tab can even represent multiple processes. The
primary Chrome process has a lot of visibility into the amount of time
a user has been spending interacting with a tab (process) and using
this knowledge these hints provided to the kernel allow it to make
much better swap decisions and amortize the cost of swap over
different memory pressure levels meaning that we were better able to
reclaim memory which allow us to avoid having to discard tabs or even
worse oom.

I'd be happy to expand even more if anyone is interested.

Brian

On Wed, Feb 19, 2020 at 2:32 PM Minchan Kim <minchan@kernel.org> wrote:
>
> Hi Andrew,
>
> On Wed, Feb 19, 2020 at 12:01:23PM -0800, Andrew Morton wrote:
> > On Tue, 18 Feb 2020 17:44:26 -0800 Minchan Kim <minchan@kernel.org> wrote:
> >
> > > Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> > > application could give hints to kernel what memory range are preferred to be
> > > reclaimed. However, in some platform(e.g., Android), the information
> > > required to make the hinting decision is not known to the app.
> > > Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> > > and that daemon must be able to initiate reclaim on its own without any app
> > > involvement.
> > >
> >
> > This patchset doesn't seem to be getting a lot of interest from other
> > potential users?  It seems very specialized.  Are there or will there
> > ever be any users of this apart from one Android daemon?
>
>
> Quote from http://lkml.kernel.org/r/20190531064313.193437-1-minchan@kernel.org
>
> "
> Brian Geffon in ChromeOS team had an experiment with process_madvise(2)
> Quote form him:
> "What I found is that by using process_madvise after a tab has been back
> grounded for more than 45 seconds reduced the average tab switch times by
> 25%! This is a huge result and very obvious validation that process_madvise
> hints works well for the ChromeOS use case."
> "
>
> >
> > Also, it doesn't terribly hard for ActivityManagerService to tell
> > another process "now run madvise with these arguments".  Please explain
> > why this is not practical in ActivityManagerService and also within
> > other potential users of this syscall.
>
> I think that's the almost a same question why ptrace doesn't work so
> I summarizes the part in [2/7]:
>
> * makes target task runnable creates memory layout change window so
>  hiniting a wrong vma
>
> * target task(e.g., background task) could live in little core with
>   cpuset/group limited environment so we couldn't react quick enough,
>   which causes more killing.
>
>
> Thanks.
