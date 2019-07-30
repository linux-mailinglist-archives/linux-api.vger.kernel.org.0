Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F567A92C
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfG3NGu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Jul 2019 09:06:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44334 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG3NGt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Jul 2019 09:06:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so27687508lfm.11
        for <linux-api@vger.kernel.org>; Tue, 30 Jul 2019 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+w66kByWBg6FjYrxXcGd5uPmMwPtO1bhVxzbFathPzI=;
        b=rlvbtrIt21GU4iIJZ5r9dzLKvzu4zMCj4l8RKBDeA0o2mYiR3UKN0mPszMjSSAhX6X
         3OVtDWT+La05tWgdt87ZEAWGPkMfChkvs3/3jpFIqx88JiCdQhRyg5Hp1suRYIE7B9ff
         MncOgoeiv7F+vEZfGTVRnoNhuPuHjjFqr7im4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+w66kByWBg6FjYrxXcGd5uPmMwPtO1bhVxzbFathPzI=;
        b=fT4DdTHMUrACeG+o7V84lJzFKXxpOS2Ec06USOue3Wlg174Ntbi1dgC+fo+UbFkwy9
         OWrxQknWhbJ0MeBwnCpqzkWjVhByq8Pn/5Ff+FglhXKI3s4KQwPaDJqXYxGq8pJl9FTk
         IJ398jz8tVyB8XGhPFw5S0JW7k13VTT1eih9mUJ+SVG//iUoXE9LMx1qu4mxxQ/QmPmC
         JJPe1V8PXVzT7hlSI1vo271uXwjTZ0Fi7Rrl/Dn9QjR5idhKLyG/wq06Fq0x250J7yOP
         oCcjPKCh0+tS9KYbWG6XjLFRMem8tpU8aeiE+fllKCJwNpVDfT0aw5jofQhE0Gwhf0zG
         fG+w==
X-Gm-Message-State: APjAAAXWkN4KVtLtLAstW87Nqm3CVwPspLUjmB1WRXQdXr0gVZAubeOu
        ZK9PyxWlJM8CrVekph1NzaXluzuGPJeXBvMknjU=
X-Google-Smtp-Source: APXvYqxs+4zVTdk9wyREtf+ZtRrQRM3zR7YozzpsYYyXpsDMuwIYF8bDwOGtZvkDbZ5vHhbJCEniuM4mVcKBeMp71V4=
X-Received: by 2002:ac2:53a7:: with SMTP id j7mr23078118lfh.112.1564492007737;
 Tue, 30 Jul 2019 06:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190726152319.134152-1-joel@joelfernandes.org>
In-Reply-To: <20190726152319.134152-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 30 Jul 2019 09:06:36 -0400
Message-ID: <CAEXW_YQN+htU-LpYQ_jxepVdRhO0byw1pWFrsbU2XsH=8FDKLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/page_idle: Add per-pid idle page tracking using
 virtual indexing
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Hansen <chansen3@cisco.com>,
        Daniel Colascione <dancol@google.com>,
        Florian Mayer <fmayer@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Namhyung Kim <namhyung@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 26, 2019 at 11:23 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The page_idle tracking feature currently requires looking up the pagemap
> for a process followed by interacting with /sys/kernel/mm/page_idle.
> Looking up PFN from pagemap in Android devices is not supported by
> unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.
>
> This patch adds support to directly interact with page_idle tracking at
> the PID level by introducing a /proc/<pid>/page_idle file.  It follows
> the exact same semantics as the global /sys/kernel/mm/page_idle, but now
> looking up PFN through pagemap is not needed since the interface uses
> virtual frame numbers, and at the same time also does not require
> SYS_ADMIN.
>
> In Android, we are using this for the heap profiler (heapprofd) which
> profiles and pin points code paths which allocates and leaves memory
> idle for long periods of time. This method solves the security issue
> with userspace learning the PFN, and while at it is also shown to yield
> better results than the pagemap lookup, the theory being that the window
> where the address space can change is reduced by eliminating the
> intermediate pagemap look up stage. In virtual address indexing, the
> process's mmap_sem is held for the duration of the access.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
> v2->v3:
> Fixed a bug where I was doing a kfree that is not needed due to not
> needing to do GFP_ATOMIC allocations.
>
> v1->v2:
> Mark swap ptes as idle (Minchan)
> Avoid need for GFP_ATOMIC (Andrew)
> Get rid of idle_page_list lock by moving list to stack

I believe all suggestions have been addressed.  Do these look good now?

thanks,

 - Joel



> Internal review -> v1:
> Fixes from Suren.
> Corrections to change log, docs (Florian, Sandeep)
>
>  fs/proc/base.c            |   3 +
>  fs/proc/internal.h        |   1 +
>  fs/proc/task_mmu.c        |  57 +++++++
>  include/linux/page_idle.h |   4 +
>  mm/page_idle.c            | 340 +++++++++++++++++++++++++++++++++-----
>  5 files changed, 360 insertions(+), 45 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 77eb628ecc7f..a58dd74606e9 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3021,6 +3021,9 @@ static const struct pid_entry tgid_base_stuff[] = {
>         REG("smaps",      S_IRUGO, proc_pid_smaps_operations),
>         REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
