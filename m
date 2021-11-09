Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF444B2FE
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 20:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbhKITEC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 14:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbhKITEB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 14:04:01 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10FBC061766
        for <linux-api@vger.kernel.org>; Tue,  9 Nov 2021 11:01:14 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id o12so87155ybk.1
        for <linux-api@vger.kernel.org>; Tue, 09 Nov 2021 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoZB95vVH0v2a9gf7XfzuFZQxHUcQQC8LetoqIfIJrc=;
        b=i6pbPLy0D0M4njCdg6snPJMmBT4Att1VQu/ppVxjExF9iSad/k/90KsN9L5mNymTSS
         NIMvoF3R3jeKUqiUipteXgZ9xfPVwrgJlc42b8brMzPdZdFM1+YQSRIKURb1UK/Df9uT
         RthW4wkCKi1AXXkdCWkGrlodZPyHo1jxSOXTNhNM7r5ZeYXATfhnPlHVsh05Q68lqHQ4
         LxUVkDTF4VkLUmIAzppyMvguzsik6K4pYJwM4lATc/1pJn7Q0JAS7qkTzsemCERLwUq0
         XvvDCalxov3CTjrK01krF26eRphk4Gfi83GC5VfxjJ2Nzc0GLavlPWMCP9TfwdmXNUNV
         Ipsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoZB95vVH0v2a9gf7XfzuFZQxHUcQQC8LetoqIfIJrc=;
        b=p0eUz+Zi66rCNVEmyg8EfW1XpeRgUCafSEdhucvKtbNKzzvMVnm9UjpxbzJDZ1Dn4M
         gDrVZkd7z+zK7LwK4qocVOe/y41clPgJsvn5nJhDkNJnzHXJ2LhdwKgnHXwEHDawpCJK
         arGvkksi79sq4aPGzGmCNpQgS1w6YiKhve3s3xp+Y0v//XoNn1YwOGUK6JtFnng8ddEL
         hfJyGmXPsbKqfVxNxbnDc1s3nyoCyIOIyoZQ2tnCh4DB8VPgA9Sozlijh4BWqHOA9q6n
         LFFuDv8NX2aDZcgcadQxPaYlKvgi/oU6BOzzfpDETSGwYkkv6xSmW2raiIDOY6NGXs0r
         fFnA==
X-Gm-Message-State: AOAM533c9wwGLMlDi6hUOczpw4c1Q7uFVsRuaLS4+uOSejANONHGC99e
        bd8rgEPlFzaTSTI/Em5cxjvchVhmxswFb7c/Irg7HA==
X-Google-Smtp-Source: ABdhPJwdc7hXS6J642vWkCDbrvXn+RiplHQk2rKWV5VvcmEBD7ypXiQI7Rbf7k86wgaSrzmhwiRPdB1ZI/CHd2MT1L0=
X-Received: by 2002:a25:d4d5:: with SMTP id m204mr11979039ybf.418.1636484473977;
 Tue, 09 Nov 2021 11:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz> <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz> <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz> <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
In-Reply-To: <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 9 Nov 2021 11:01:02 -0800
Message-ID: <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 2, 2021 at 8:14 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Nov 2, 2021 at 12:58 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 01-11-21 08:44:58, Suren Baghdasaryan wrote:
> > [...]
> > > I'm with you on this one, that's why I wanted to measure the price we
> > > would pay. Below are the test results:
> > >
> > > Test: https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/
> > > Compiled: gcc -O2 -static test.c -o test
> > > Test machine: 128 core / 256 thread 2x AMD EPYC 7B12 64-Core Processor
> > > (family 17h)
> > >
> > > baseline (Linus master, f31531e55495ca3746fb895ffdf73586be8259fa)
> > > p50 (median)   87412
> > > p95                  168210
> > > p99                  190058
> > > average           97843.8
> > > stdev               29.85%
> > >
> > > unconditional mmap_write_lock in exit_mmap (last column is the change
> > > from the baseline)
> > > p50 (median)   88312     +1.03%
> > > p95                  170797   +1.54%
> > > p99                  191813   +0.92%
> > > average           97659.5  -0.19%
> > > stdev               32.41%
> > >
> > > unconditional mmap_write_lock in exit_mmap + Matthew's patch (last
> > > column is the change from the baseline)
> > > p50 (median)   88807      +1.60%
> > > p95                  167783     -0.25%
> > > p99                  187853     -1.16%
> > > average           97491.4    -0.36%
> > > stdev               30.61%
> > >
> > > stdev is quite high in all cases, so the test is very noisy.
> > > The impact seems quite low IMHO. WDYT?
> >
> > Results being very noisy is what I recall as well. Thanks!
>
> I believe, despite the noise, the percentiles show that overall we do
> not noticeably regress the exit path by taking mmap_lock
> unconditionally.
> If there are no objections, I would like to post a patchset which
> implements unconditional locking in exit_mmap() and process_madvise()
> calling __oom_reap_task_mm() under protection of read mmap_lock.
> Thanks!

Discussing how the patch I want to post works for maple trees that
Matthew is working on, I've got a question:

IIUC, according to Michal's post here:
https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz,
unmap_vmas() can race with other mmap_lock read holders (including
oom_reap_task_mm()) with no issues.
Maple tree patchset requires rcu read lock or the mmap semaphore be
held (read or write side) when walking the tree, including inside
unmap_vmas(). When asked, he told me that he is not sure why it's
currently "safe" to walk the vma->vm_next list in unmap_vmas() while
another thread is reaping the mm.
Michal (or maybe someone else), could you please clarify why
unmap_vmas() can safely race with oom_reap_task_mm()? Or maybe my
understanding was wrong?
Thanks,
Suren.



>
> > --
> > Michal Hocko
> > SUSE Labs
