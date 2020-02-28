Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752901742EB
	for <lists+linux-api@lfdr.de>; Sat, 29 Feb 2020 00:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgB1XUI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Feb 2020 18:20:08 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37715 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XUI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Feb 2020 18:20:08 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so1620675uah.4
        for <linux-api@vger.kernel.org>; Fri, 28 Feb 2020 15:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VU34bwckjyg5xsCO6OcehkGprELR+hgQrM6MHlc+k24=;
        b=p712VrGqlJPpzao7YD3m5WX0LwQXtasWycAZR6Qv7IV0othNqCEH71tVJM2dopv6af
         sSO8BQuwI9/or54uFHbjxF2CZdx+mBayfoBqjtGedEVeI+as7B6KM8lW8g0A2yYN3KPf
         Bt5nJiuIcPY6xqYfFiU1su+u2LEuGh6MVdzDcI9oEmRy3zU0uimpQkB2C6GNcZp1ThKW
         ftlwSgDHO7rZaaPNKsUOMofgpJYnyN2NrPVF2PrRfd/HdlhYG0NSDq+3O5nSutE6lrIM
         0nrGXHCVT0QfVmQkePA2n2I4pNWldsh6VIbF1ZbvzPNJCW5aIIzLigynVqrzxFeuH8Qc
         G/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VU34bwckjyg5xsCO6OcehkGprELR+hgQrM6MHlc+k24=;
        b=LzFsY0LCuaHPNRyXoQJP63vTCpNHZqYWgsr6Me66sXO4sTZOLzijqnGF75sTDAA81T
         JeCSby5007hiXZTxVsWB7P7x4iHqGOSfV9UO3WKvwsRXhLFKreO9Pwx4zLONOJgdKWeM
         liz/k5hfU7iWlqyLhb+EolKCopzM3pSkWeTMxsdNMiMSYKyZiaG0tiwHYRr7LSFjS5z6
         MhOhmi3FmTCeLu/B58V6ytulrqltbaCYLOkzWsp+/pXnSRLTP2qcWbJy7DtsKEx4UaZP
         AR6cfnhreZ0bQEmN9Dg2KwOd2p7Www+x303i3jgxce7qQvSPOFcNhIrSnDspX8O9HzOg
         9+cg==
X-Gm-Message-State: ANhLgQ1G4Tr6mgLxWoGtiM80/AZGl+2jYOionoh2CPBUpURT0ZvgnT4o
        HxnTs+HTV38MI4WDKy0VWtbQRMNFbm0P5bsA4V2yPw==
X-Google-Smtp-Source: ADFU+vu77RknxSN0Qez7GxUaCFdomtgxWWwgBofJYgMiqzYUzWYSNhzh9gQeVE9ot63IVGGE/yy38i9GzlZhRohTM4M=
X-Received: by 2002:ab0:32cf:: with SMTP id f15mr3393489uao.42.1582932006884;
 Fri, 28 Feb 2020 15:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219014433.88424-7-minchan@kernel.org>
In-Reply-To: <20200219014433.88424-7-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Feb 2020 15:19:55 -0800
Message-ID: <CAJuCfpE=7aqwegMb5i3EwWb=xcphXSNE33dCCUvt=WS0Sr-wfg@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] mm/madvise: employ mmget_still_valid for write lock
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
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

On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
>
> From: Oleksandr Natalenko <oleksandr@redhat.com>
>
> Do the very same trick as we already do since 04f5866e41fb. KSM hints
> will require locking mmap_sem for write since they modify vm_flags, so
> for remote KSM hinting this additional check is needed.
>
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/madvise.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f6d9b9e66243..c55a18fe71f9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>         if (write) {
>                 if (down_write_killable(&mm->mmap_sem))
>                         return -EINTR;
> +               if (current->mm != mm && !mmget_still_valid(mm))

mmget_still_valid() seems pretty light-weight, so why not just use
that without checking that the mm belongs to the current process
first?

> +                       goto skip_mm;
>         } else {
>                 down_read(&mm->mmap_sem);
>         }
> @@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>         }
>  out:
>         blk_finish_plug(&plug);
> +skip_mm:
>         if (write)
>                 up_write(&mm->mmap_sem);
>         else
> --
> 2.25.0.265.gbab2e86ba0-goog
>
