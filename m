Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155F8405D21
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 21:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhIITIX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Sep 2021 15:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhIITIW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Sep 2021 15:08:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8FC061574
        for <linux-api@vger.kernel.org>; Thu,  9 Sep 2021 12:07:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so5702046lfu.5
        for <linux-api@vger.kernel.org>; Thu, 09 Sep 2021 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSxoVhZKPV5vIsKI5h5zhtRaljW5GeLiCgX94saAGpI=;
        b=EEh5iHf2AyVU6pWc66FkqwfxhZN7OOFswNYtUyq59yF6TfwdRjY4MK7LyilbyCD5Kl
         U646gNYO+qY671TJrJ6dHx/ihOFsPxkznJOjZjg0pOotVadZKBMI8dVwRv9RmpTRceat
         amLbx3XKy+m2mJxxB/0iM1lrah+eABVQnmzMypJNatGwdutNXOGKQ3GF0PrgF6XCz9tq
         t1LrrAHj/Xjq8NTDoHuP4CoeAjy3BME1ounPNfNPCNLQaYp6EMWdvtvJexFvqfQfn3U0
         SjaIjrCCSoLoXao5PTqu04cq15nIgXUJ4ZA+QqVjpr0sw1iMUgjyzVGBFZ2fJR1z+gwn
         vW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSxoVhZKPV5vIsKI5h5zhtRaljW5GeLiCgX94saAGpI=;
        b=6mIFtv4YTJ8iB61sA7k7frAfZcoqXJBXwx3SFR6wZxwObMyXJnYW2Lp3fwxhQRAvUh
         tJJlTdnm5PvHtTkpbFiMqGUXrNk3A4gNeucRbW7AJ1gkkwIL85MVJKD5Xr0JgXTSTHPQ
         figdNIazYJ4ex8LtcNHOEHkfhl2M/HApCk8/HuKMJcP6yCS6wWUfy7/y0rs3XSO5cGrt
         syGnJjbJF49A53N4QZWpoAZPLNxJeUgUIBdtX0W4Gwgvcdr1uC0IsAyNUtD3k1e/LIuI
         HMrPPqJ/38/ZlB1E8BmkrsELqA2ZDP6B6yWYuxI3Z+PUcciT+RJeg5ebuEOJGwOJISd3
         otRw==
X-Gm-Message-State: AOAM5309rBDDdCR0s76VUiCyGaZHCdQSEeSNwVBwXyw4nEMU5cdzeXsC
        bGuLdtyLcptj6nZfxAT6HHqr/vRrSA72j71Cw4ZSZg==
X-Google-Smtp-Source: ABdhPJy2eONx0WT8070nfccqU1JcIS3PAoNTdU2UKrLXibQTXqjbC0CXN7aDdXXfYJ1HioicFgkMvUYez+jYILK18aY=
X-Received: by 2002:ac2:4e98:: with SMTP id o24mr988992lfr.295.1631214431050;
 Thu, 09 Sep 2021 12:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
In-Reply-To: <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 9 Sep 2021 12:06:58 -0700
Message-ID: <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Jann Horn <jannh@google.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 8, 2021 at 4:39 PM Jann Horn <jannh@google.com> wrote:

Thanks a lot for the reviews, Jann!

I understand how to address most of your comments. However, one issue
I'm not sure what to do about:

[...]

> If this function is not allowed to sleep, as the comment says...

[...]

> ... then I'm pretty sure you can't call fix_pagefault() here, which
> acquires the mmap semaphore (which may involve sleeping) and then goes
> through the pagefault handling path (which can also sleep for various
> reasons, like allocating memory for pagetables, loading pages from
> disk / NFS / FUSE, and so on).

<quote from peterz@ from
https://lore.kernel.org/lkml/20210609125435.GA68187@worktop.programming.kicks-ass.net/>:
  So a PF_UMCG_WORKER would be added to sched_submit_work()'s PF_*_WORKER
  path to capture these tasks blocking. The umcg_sleeping() hook added
  there would:

    put_user(BLOCKED, umcg_task->umcg_status);
    ...
</quote>

Which is basically what I am doing here: in sched_submit_work() I need
to read/write to userspace; and we cannot sleep in
sched_submit_work(), I believe.

If you are right that it is impossible to deal with pagefaults from
within non-sleepable contexts, I see two options:

Option 1: as you suggest, pin pages holding struct umcg_task in sys_umcg_ctl;

or

Option 2: add more umcg-related kernel state to task_struct so that
reading/writing to userspace is not necessary in sched_submit_work().

The first option sounds much better from the code simplicity point of
view, but I'm not sure if it is a viable approach, i.e. I'm afraid
we'll get a hard NACK here, as a non-privileged process will be able
to force the kernel to pin a page per task/thread. We may get around
it by first pinning a limited number of pages, then having the
userspace allocate structs umcg_task on those pages, so that a pinned
page would cover more than a single task/thread. And have a sysctl
that limits the number of pinned pages per MM.

Peter Z., could you, please, comment here? Do you think pinning pages
to hold structs umcg_task is acceptable?

[...]
