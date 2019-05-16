Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1220C8D
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfEPQGv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 12:06:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37733 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfEPQGv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 12:06:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id r10so3954203otd.4
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4VKFuY3dBhk8M0E31KTPJJ8MMHDVcscAUiCzod5h4g=;
        b=H6xNrQHksO0mY+GD8TjSIB/dl7gXte6ptfd1KwGU7WS9fv6i/tgp5PRwV1QwuOcLn8
         EQgegFWR1awHjfSGP4+gjgXMyl3Gl62XXSb7Mm7Nf1RXzKuaEetJoPJs6GSuS0KBL9vl
         Wub95qd5nDDIuDpLobcQrJAeLZp5nVs+LMne3mcxV43wLSgIfXzXurgIQYOiBUs8VKq4
         KUB/9oEuCvZV97lXvc2ABvfckVlCEpI9+rGFlz3y2hfmc98QPPAyHhjTuVHOdOUM3Bkm
         UOJay+FnLHdEk6rocRtjzEXrvs47hR0q26+/2U1SS5+d0iEBJ8VXwWGOZJ51SarUWMvq
         4fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4VKFuY3dBhk8M0E31KTPJJ8MMHDVcscAUiCzod5h4g=;
        b=HK4u25HrDhsS/l1v1FgeFeduCX4j8bKxc1pwEogbJOdTHs34ZDElHyr5r33UmNZ7Sb
         qdF+nwckfsLylZqCSDhDXCcVnJrmcD0t2jT3677hNj9jOAhATdnkXI2GIciPBJ+obPBZ
         osFmRseRj7TnPAVkUOVIvfBvFQah7kOP3M9EuQ/7NNkEcalX3K4JThVCE7WlXK10HbtI
         eYq4M7s57aJxxjmzBraXgkGvkWTyt3uHnN+zoIOe0/Ht69qz75QDq+HGHPo0BVGyc3M2
         vAz5Do8LIMICmWf/oKB0WLjcLEC+RUE3TfeOqZAF9Tp38kL+95DadbLl6GwwgAdUO3XY
         LIjg==
X-Gm-Message-State: APjAAAWRSwPnFRxjnpUyt+k+4K3tmLLte/aq2E4VNYubASwVBE+4N653
        8Gffe4lJhVy/dBDz03JkjfI4oQcfkImfEn+ENpfgUQ==
X-Google-Smtp-Source: APXvYqzler3soQWaPkgJTqHADqwjhXm5FObYmA+iecGHRrkmAWqb4Fk8pHSH7Qj3lDCx4Ml5SA54wKgEPHxudDIXDq4=
X-Received: by 2002:a9d:7347:: with SMTP id l7mr6353382otk.183.1558022810319;
 Thu, 16 May 2019 09:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190516094234.9116-1-oleksandr@redhat.com> <20190516094234.9116-5-oleksandr@redhat.com>
 <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com> <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain>
In-Reply-To: <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 May 2019 18:06:24 +0200
Message-ID: <CAG48ez0teQk+rVnRmr=xcM8PJ_8UZC3hSi7PABx-qunz+5=DGg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 16, 2019 at 4:20 PM Oleksandr Natalenko
<oleksandr@redhat.com> wrote:
> On Thu, May 16, 2019 at 12:00:24PM +0200, Jann Horn wrote:
> > On Thu, May 16, 2019 at 11:43 AM Oleksandr Natalenko
> > <oleksandr@redhat.com> wrote:
> > > Use previously introduced remote madvise knob to mark task's
> > > anonymous memory as mergeable.
> > >
> > > To force merging task's VMAs, "merge" hint is used:
> > >
> > >    # echo merge > /proc/<pid>/madvise
> > >
> > > Force unmerging is done similarly:
> > >
> > >    # echo unmerge > /proc/<pid>/madvise
> > >
> > > To achieve this, previously introduced ksm_madvise_*() helpers
> > > are used.
> >
> > Why does this not require PTRACE_MODE_ATTACH_FSCREDS to the target
> > process? Enabling KSM on another process is hazardous because it
> > significantly increases the attack surface for side channels.
> >
> > (Note that if you change this to require PTRACE_MODE_ATTACH_FSCREDS,
> > you'll want to use mm_access() in the ->open handler and drop the mm
> > in ->release. mm_access() from a ->write handler is not permitted.)
>
> Sounds reasonable. So, something similar to what mem_open() & friends do
> now:
>
> static int madvise_open(...)
> ...
>         struct task_struct *task = get_proc_task(inode);
> ...
>         if (task) {
>                 mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
>                 put_task_struct(task);
>                 if (!IS_ERR_OR_NULL(mm)) {
>                         mmgrab(mm);
>                         mmput(mm);
> ...
>
> Then:
>
> static ssize_t madvise_write(...)
> ...
>         if (!mmget_not_zero(mm))
>                 goto out;
>
>         down_write(&mm->mmap_sem);
>         if (!mmget_still_valid(mm))
>                 goto skip_mm;
> ...
> skip_mm:
>         up_write(&mm->mmap_sem);
>
>         mmput(mm);
> out:
>         return ...;
>
> And, finally:
>
> static int madvise_release(...)
> ...
>                 mmdrop(mm);
> ...
>
> Right?

Yeah, that looks reasonable.
