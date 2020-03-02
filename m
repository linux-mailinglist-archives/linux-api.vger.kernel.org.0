Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78B7175FB8
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCBQc6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 11:32:58 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34436 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCBQc5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 11:32:57 -0500
Received: by mail-vk1-f196.google.com with SMTP id w67so3133985vkf.1
        for <linux-api@vger.kernel.org>; Mon, 02 Mar 2020 08:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6G1UATj4krZxsCknjrQEeeFai91FPwBe7XfsjRuVvR4=;
        b=gjBc7d6YnjDc2NB2v1tqHbdmYRA6US1Zc4Bwdfw5pIWhSmmK+Bim0XXVC967za6mwx
         ttu/8XEIGHY+D5pOwYhrSNHH/c4SoLvoncF5LehwoF40RSVQ9t9odVgxLiDlcLjFr8Qf
         uXYk5vh3osEyjqmPttQL18i1ib4MEU32Qt3I2R3oe2JnmiK3Jik/inzsusGzwGnwm8pV
         s1va7f8IYUZ7uLxzJUgWIyTWYsii4w3rsSFeFJeDn2VTka/qdtcbcgiRxqnQuUa+AYgx
         0sFVAYTtpPKHuI2iqRu7GbzoyP3paHDugM7UXOnTi6wNwOQFMIQx2OSWfFXbxa+LWAu3
         a1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6G1UATj4krZxsCknjrQEeeFai91FPwBe7XfsjRuVvR4=;
        b=Jr7oVzKlWmTxHMx8PG3NjEYWbJegcquYNwZkzQ7kw1j4TKnotELWm+4kZeLoatbNO6
         iCsGsG594+1dzIYwoPa5cc+N01Sp4WIGUTYps7op0vOvIUE/fzwT9AQZvh71g1hyr2Hc
         OReiORYZGdfevJiMivoMrPxF/as4JxB2YCHnPTEjxLBsy55v2S/o7FKEOo1rT9kMsiDB
         kEBIeEHyw6LzVo0iTcDIObkdoTFHl3LOFi4bjSMznrPniMMslUmcyXtkiVX8SL7vV7E6
         auRl5wYDnYTMxnJLnnv5o65MWnHBUJW8qQEC1jDwAkMaK5MJz946gTHpioTdSMsY1na6
         WJhw==
X-Gm-Message-State: ANhLgQ0RfmkTNFUQB8wvK3xsbvwqmxcdQozIE/aq7wq6LoaXR//FCDOi
        psPZ/WKERB8ZLdn5FVN/JxzIa59KVy09FNTiMl1uWw==
X-Google-Smtp-Source: ADFU+vudr5OddUJOm/nCflCRNBR8hUNIZhkJyQ8IXmQMh0kL9nYnxmTqjHWz5AHVu0pL2BiPYiLALTBK7m4MdHvpN+w=
X-Received: by 2002:ac5:c914:: with SMTP id t20mr334096vkl.37.1583166775011;
 Mon, 02 Mar 2020 08:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219014433.88424-7-minchan@kernel.org>
 <CAJuCfpE=7aqwegMb5i3EwWb=xcphXSNE33dCCUvt=WS0Sr-wfg@mail.gmail.com> <20200302073332.gn7lvhxmmv5pupyq@butterfly.localdomain>
In-Reply-To: <20200302073332.gn7lvhxmmv5pupyq@butterfly.localdomain>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 2 Mar 2020 08:32:44 -0800
Message-ID: <CAJuCfpE++EUbmhmr6+iutFk5Nd3teXy5Xr0y735LP25ciNKKcQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] mm/madvise: employ mmget_still_valid for write lock
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Tim Murray <timmurray@google.com>,
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

On Sun, Mar 1, 2020 at 11:33 PM Oleksandr Natalenko
<oleksandr@redhat.com> wrote:
>
> Hello.
>
> On Fri, Feb 28, 2020 at 03:19:55PM -0800, Suren Baghdasaryan wrote:
> > On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > From: Oleksandr Natalenko <oleksandr@redhat.com>
> > >
> > > Do the very same trick as we already do since 04f5866e41fb. KSM hints
> > > will require locking mmap_sem for write since they modify vm_flags, so
> > > for remote KSM hinting this additional check is needed.
> > >
> > > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  mm/madvise.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index f6d9b9e66243..c55a18fe71f9 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> > >         if (write) {
> > >                 if (down_write_killable(&mm->mmap_sem))
> > >                         return -EINTR;
> > > +               if (current->mm != mm && !mmget_still_valid(mm))
> >
> > mmget_still_valid() seems pretty light-weight, so why not just use
> > that without checking that the mm belongs to the current process
> > first?
>
> I'd keep the checks separate to a) do not functionally change current->mm
> == mm case; b) clearly separate the intention to call
> mmget_still_valid() only for remote access (using mmget_still_valid()
> for current->mm == mm does not make any sense here, IMO, since there's
> no possibility of expecting a core dump at this point); c) ease the job for
> reviewer once mmget_still_valid() is scheduled to be removed (I hope it
> eventually goes away indeed).
>

Makes sense. Thanks!

> >
> > > +                       goto skip_mm;
> > >         } else {
> > >                 down_read(&mm->mmap_sem);
> > >         }
> > > @@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> > >         }
> > >  out:
> > >         blk_finish_plug(&plug);
> > > +skip_mm:
> > >         if (write)
> > >                 up_write(&mm->mmap_sem);
> > >         else
> > > --
> > > 2.25.0.265.gbab2e86ba0-goog
> > >
> >
>
> --
>   Best regards,
>     Oleksandr Natalenko (post-factum)
>     Principal Software Maintenance Engineer
>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
