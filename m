Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC1317547C
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 08:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgCBHdi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 02:33:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726204AbgCBHdh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 02:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583134417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/0vJrA0gSRXpSGqk2auYaBWDuiqdzsus4s2o4cmNQw=;
        b=L+r/x1wzVGYM0bP9IzIxYq2DGHGllG+ZX8uEVHrQVYABkc8li3LVBkQEgN/HQEoBTlhaG3
        AfWwpxo6UW2nxGwxz6z6tud06bUc7iTCplo4MAsihxPxN1rx6yUVQYEqR/YTT/o+tlG+6z
        VDz0fOfBK8RuNpCHPOhsDnY3KsC/bMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-gPGBABM0Ntaj54180Vkzxw-1; Mon, 02 Mar 2020 02:33:35 -0500
X-MC-Unique: gPGBABM0Ntaj54180Vkzxw-1
Received: by mail-wr1-f72.google.com with SMTP id m13so5414546wrw.3
        for <linux-api@vger.kernel.org>; Sun, 01 Mar 2020 23:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/0vJrA0gSRXpSGqk2auYaBWDuiqdzsus4s2o4cmNQw=;
        b=rxTzlOvLGJidh1Czlr5Kw1kNNqnaG62mAajqK9IDMh4Lv/Z/dnq1/mhuAek6pMfU4n
         RvelXkIJCTacrbgcWx0ir5DDP3CF4A2fuo5IHcSAYqI2kfPRkP0zaXU0C7uhPU9I5zp8
         RkDcfiZSa75wqnNgdW5SgPdWj+a2WM1oumKjFUZXQKWDZJf43dmyvCJIyE85iHRbQdES
         Xh4iLrqPYLV2A7OmASe0XqLIjov2hBwTJJnikBS71MZOs8fLZKcPIWbvFurZW2jqQBfs
         iVXdE/dky1hvhcXQbllPU9mQxHCjFcp/B9XrbW26K0A3JnB1npxG5iab1fYep8riWBxa
         ZLxw==
X-Gm-Message-State: APjAAAV3EJxg3TUjRJiqWY5SPDow8Sd2nepo8G0TBUEUuqKTlrfIfy3Q
        +jUGCHCyptU1wl3u9WEEiQCK63Lr/EfaS6/RJM1N+874xRa5c9rTG5aZ27x/EfR6yifBLPhIIvf
        PWiCm+KlbZf1Dyag/6MhB
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr13624762wrq.333.1583134414204;
        Sun, 01 Mar 2020 23:33:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/RlDZ/wAqfk74aj3rp7qtdfZnYqBJ07tcCbHIfQ3JwdzeVvOLfYGeLgpyzPQWX+NFfQSKtw==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr13624728wrq.333.1583134413960;
        Sun, 01 Mar 2020 23:33:33 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c4sm14145502wml.7.2020.03.01.23.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:33:33 -0800 (PST)
Date:   Mon, 2 Mar 2020 08:33:32 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [PATCH v6 6/7] mm/madvise: employ mmget_still_valid for write
 lock
Message-ID: <20200302073332.gn7lvhxmmv5pupyq@butterfly.localdomain>
References: <20200219014433.88424-1-minchan@kernel.org>
 <20200219014433.88424-7-minchan@kernel.org>
 <CAJuCfpE=7aqwegMb5i3EwWb=xcphXSNE33dCCUvt=WS0Sr-wfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE=7aqwegMb5i3EwWb=xcphXSNE33dCCUvt=WS0Sr-wfg@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello.

On Fri, Feb 28, 2020 at 03:19:55PM -0800, Suren Baghdasaryan wrote:
> On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > From: Oleksandr Natalenko <oleksandr@redhat.com>
> >
> > Do the very same trick as we already do since 04f5866e41fb. KSM hints
> > will require locking mmap_sem for write since they modify vm_flags, so
> > for remote KSM hinting this additional check is needed.
> >
> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/madvise.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index f6d9b9e66243..c55a18fe71f9 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >         if (write) {
> >                 if (down_write_killable(&mm->mmap_sem))
> >                         return -EINTR;
> > +               if (current->mm != mm && !mmget_still_valid(mm))
> 
> mmget_still_valid() seems pretty light-weight, so why not just use
> that without checking that the mm belongs to the current process
> first?

I'd keep the checks separate to a) do not functionally change current->mm
== mm case; b) clearly separate the intention to call
mmget_still_valid() only for remote access (using mmget_still_valid()
for current->mm == mm does not make any sense here, IMO, since there's
no possibility of expecting a core dump at this point); c) ease the job for
reviewer once mmget_still_valid() is scheduled to be removed (I hope it
eventually goes away indeed).

> 
> > +                       goto skip_mm;
> >         } else {
> >                 down_read(&mm->mmap_sem);
> >         }
> > @@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >         }
> >  out:
> >         blk_finish_plug(&plug);
> > +skip_mm:
> >         if (write)
> >                 up_write(&mm->mmap_sem);
> >         else
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

