Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3032815C979
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 18:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBMRgN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 12:36:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45133 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbgBMRgN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 12:36:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so6345631otp.12
        for <linux-api@vger.kernel.org>; Thu, 13 Feb 2020 09:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEivpLB78jDIGDKRfEzNcTFhE0fuF0dHr5+DJjzTDvQ=;
        b=hqvgPTODp0r9ZX81HJz42991BVt3mpmv44OM79mWtV44KP74ucAEIpm+udOy1J+KN7
         SImS29eaDNEmYQ4VCYrjXZGnRCFyT3JvhcJrK61ubahLwjKlXXMNnqy9Ocje4WrGxcg3
         cX9u5eUKdwmldbXInH2F5esORBmKPeNcra+utRJvXWyrZbDptWuERYW5pCDPapLZCED/
         0q+aAjDYxO9Uq1BcgFBjsUZoIyR+lNp9JJV2I87/qha0cuxeDpNmCwyS5sSZ2xyiKZ2C
         QHYJoqlG1lt+qU7dya77fybUEWk3MRxmG+O2ag5suEKlM3Y+WktbQdcPHz0gTa0HrE/M
         Ajqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEivpLB78jDIGDKRfEzNcTFhE0fuF0dHr5+DJjzTDvQ=;
        b=UaBNYUM1rFTQ6ByMmZu+fBOdy1zj3GwGzZyN9M5Th8qBzzQiTm6oikQoLYEnE2CCg4
         r50k2tjO5mxp/tIk+LxxZKzr2ox5QvolIt+rlVyuC3Sc1oz7AdPGZFi2stn+xOmTRcdj
         xazRJIjDUqn6JOAxvHZkwC7k/Py3uSk6ViqsmhXbP88cPj9T77/OEwD7I6U5ePe5iavu
         pnRGwf3ZZWdzPhHYLbOxvmU1k8YK/UsV/IyEbjjnKPkffmBs0IjwJOnBU7bRg9woeroF
         uI42ophjW/AI9vs7nIE4KYCA5diURSPF6TqM4ttSGmnT3snst4kXoTobJiLdrfSU9jUf
         0y/Q==
X-Gm-Message-State: APjAAAWmyx8UR6MGltuztNVgpwMvZlEo5ABztFrxJPitF2++jqXN2ofT
        1+fFBq2zSW4zA4bgYEq72cSQi2m1nplTj9LnLBP6bQ==
X-Google-Smtp-Source: APXvYqxvFnUCJJ59Q5SzlbVPlqcEwHO3v3xIxSTXq0G9Z9Gy3CSZMqJL5VyJgpcIBjg20XYRw3PM5D0LMO7AgEirGwQ=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr13926414oti.32.1581615371985;
 Thu, 13 Feb 2020 09:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20200212233946.246210-1-minchan@kernel.org> <20200212233946.246210-2-minchan@kernel.org>
 <3f0218093e2d19fa0f24ceff635cbb9ec5ba69ec.camel@linux.intel.com> <20200213170224.GA27817@google.com>
In-Reply-To: <20200213170224.GA27817@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 13 Feb 2020 18:35:45 +0100
Message-ID: <CAG48ez0EkkKyH9OniR6nWTDejsR-Mqz_c+ywwWT3_X_7-WfTfw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] mm: pass task to do_madvise
To:     Minchan Kim <minchan@kernel.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 13, 2020 at 6:02 PM Minchan Kim <minchan@kernel.org> wrote:
> On Wed, Feb 12, 2020 at 04:21:59PM -0800, Alexander Duyck wrote:
> > On Wed, 2020-02-12 at 15:39 -0800, Minchan Kim wrote:
> > > In upcoming patches, do_madvise will be called from external process
> > > context so it shouldn't asssume "current" is always hinted process's
> > > task_struct. Thus, let's get the mm_struct from vma->vm_mm, not
> > > current because vma is always hinted process's one. And let's pass
> > > *current* as new task argument of do_madvise so it shouldn't change
> > > existing behavior.
[...]
> > > @@ -763,8 +763,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > >     if (!userfaultfd_remove(vma, start, end)) {
> > >             *prev = NULL; /* mmap_sem has been dropped, prev is stale */
> > >
> > > -           down_read(&current->mm->mmap_sem);
> > > -           vma = find_vma(current->mm, start);
> > > +           down_read(&mm->mmap_sem);
> > > +           vma = find_vma(mm, start);
> > >             if (!vma)
> > >                     return -ENOMEM;
> > >             if (start < vma->vm_start) {
> >
> > This piece of code has me wondering if it is valid to be using vma->mm at
> > the start of the function. I assume we are probably safe since we read the
> > mm value before the semaphore was released in userfaultfd_remove. It might
> > make more sense to just pass the task to the function and use task->mm-
> > >mmap_sem instead.
>
> As Jann pointed out, we couldn't use task->mm once we verified it via
> access_mm. However, I believe vma->vm_mm is safe(Ccing Jann for double
> check).

Looks safe to me, too.
