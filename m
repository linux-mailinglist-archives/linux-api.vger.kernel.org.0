Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116DC44315D
	for <lists+linux-api@lfdr.de>; Tue,  2 Nov 2021 16:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhKBPRc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Nov 2021 11:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbhKBPRa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Nov 2021 11:17:30 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8EFC0613F5
        for <linux-api@vger.kernel.org>; Tue,  2 Nov 2021 08:14:55 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id s186so29780088yba.12
        for <linux-api@vger.kernel.org>; Tue, 02 Nov 2021 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4vo3xOow7zioCDniOqo/cUmPTsQ9k5oLRBoc2H5RmM=;
        b=LjddqU8TuEc2mSGQVv8Shw6Rr8F04MBGWv+W9yGEUEesBAdukLgf4ydPLMDaao9Wdw
         9WLQvTXkckHoyRv6v9GtcQoSUqzNA61qJKqXNqcM6Dnek77lhQqK/epy8W9dn2XJTY0D
         5Hu193h2Bd0tO0VjKZX99CKIYedxlVnhR4JCkYCE/HxlIFSA2W+wXQ+pVuYUCi2eI8Dz
         Wfc8Fj+9itDanLTLbQ94LQqSz2tUOXmnTPsWjOsTR54diV0sM/fHxQ2UILjdC/hLJtJL
         Mg/UJHcPBF/D9ZufOMQ2XQlFAzttQ/jqQSJ9gzipUDab72pOLdanRYCcxzwlhw7og6jV
         awxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4vo3xOow7zioCDniOqo/cUmPTsQ9k5oLRBoc2H5RmM=;
        b=iBkpNspf6ccD1ssB60aHIBsvf/+1PI7YBfsOPv/2UFWQkRnVV9RMvy7D1fru8cBUuP
         5OCDF9AKUAF5OBYIyCfiLcT/PsJ15N8OiB/LcrlwvfNKr38xoHhQYKQcPoxTGdFZDlDJ
         r+G3fQ9BwW/7n3QMLzLjGn4aVj3SMfQCHj1HjmNLNdLfecUn8NVRyayAanRCXbqJ0lcY
         wPnJuzssmaKLSDNW6BIjNLzKLXMmLE1pcvFRJLjoANZ13ax55JvR39T34Z9hFk0DvCqm
         15M28/YgqHv3nol7418h6+52X1A7fic4JbiMYCMh3LU7wJ98L/3C+/05pWOXSvajsdkf
         im7Q==
X-Gm-Message-State: AOAM531WpswTgnuGYpDs4CwaSOXUqvjfZpfvk9H+qJkvPi27hbRmDwQ7
        RDX8ochPmfNQJi2b0Vt1w8+aPFvEOFC8UF1nM2iDMg==
X-Google-Smtp-Source: ABdhPJzVNIQAwK+DaQmN14pKDqKRyuYzpi/QTvph4WYwByoDr2ZVNR43H0trqcjKVtUtTg2UFfwMO19+eG3dj3An+7g=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr33607068ybv.487.1635866094771;
 Tue, 02 Nov 2021 08:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz> <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz> <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz>
In-Reply-To: <YYDvm9c/7cGtBvw6@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 Nov 2021 08:14:43 -0700
Message-ID: <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 12:58 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 01-11-21 08:44:58, Suren Baghdasaryan wrote:
> [...]
> > I'm with you on this one, that's why I wanted to measure the price we
> > would pay. Below are the test results:
> >
> > Test: https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/
> > Compiled: gcc -O2 -static test.c -o test
> > Test machine: 128 core / 256 thread 2x AMD EPYC 7B12 64-Core Processor
> > (family 17h)
> >
> > baseline (Linus master, f31531e55495ca3746fb895ffdf73586be8259fa)
> > p50 (median)   87412
> > p95                  168210
> > p99                  190058
> > average           97843.8
> > stdev               29.85%
> >
> > unconditional mmap_write_lock in exit_mmap (last column is the change
> > from the baseline)
> > p50 (median)   88312     +1.03%
> > p95                  170797   +1.54%
> > p99                  191813   +0.92%
> > average           97659.5  -0.19%
> > stdev               32.41%
> >
> > unconditional mmap_write_lock in exit_mmap + Matthew's patch (last
> > column is the change from the baseline)
> > p50 (median)   88807      +1.60%
> > p95                  167783     -0.25%
> > p99                  187853     -1.16%
> > average           97491.4    -0.36%
> > stdev               30.61%
> >
> > stdev is quite high in all cases, so the test is very noisy.
> > The impact seems quite low IMHO. WDYT?
>
> Results being very noisy is what I recall as well. Thanks!

I believe, despite the noise, the percentiles show that overall we do
not noticeably regress the exit path by taking mmap_lock
unconditionally.
If there are no objections, I would like to post a patchset which
implements unconditional locking in exit_mmap() and process_madvise()
calling __oom_reap_task_mm() under protection of read mmap_lock.
Thanks!

> --
> Michal Hocko
> SUSE Labs
