Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2D40B726
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 20:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhINSt7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 14:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhINSt6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 14:49:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865F4C061574
        for <linux-api@vger.kernel.org>; Tue, 14 Sep 2021 11:48:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id o11so413320ljp.8
        for <linux-api@vger.kernel.org>; Tue, 14 Sep 2021 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgl8tmNVpP53cUFKld1Rt71FzleinQ+qnlvEYDZitJw=;
        b=DCOpZidwA0rpIRjXO+o+QItCRB778ww1vOhhsZ1Sc03AZxzxl3siZADhctSGu9Isyp
         Vct8pMGe4BpjtbARjhj4XI0LGfhFpz7YuTXrqBAkrUXNIj/qb/XUMVdcbn2cS61p0oak
         ugZWNzntOh7bCMarRvhmI+owA+yEO0lvN3i0aC0slBPepI5Ox+BMbWHiEgNhniiQXrlR
         JegbaTPK4OvRAucDswQyXidzcNFjmhmNtiSDnkyQOpLkko3jpnUhkujSeNVO7HHcN72D
         N8e1xLGWzHf2nE6+Y6G3kz42sjz/jeJSH5AACOEM2hnv/hETq5zeqGGlPCwaSABbOBP6
         UdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgl8tmNVpP53cUFKld1Rt71FzleinQ+qnlvEYDZitJw=;
        b=Ct78tuv0iOH+TZs9eC7S2DvA7q6+GQg/6vvINctwDnKpa6B6+MMZbh2cbjw6TtaXHW
         Ab+HaSVL2SOkqmTfERYVuquJdWp5sUl/AGPluOV91EEKHxSdEFkqA4/f7mJ1RTr0II80
         AaDQ7gMIMKCurN4CZfPJKVSew9RGtdrYbKKhFhwtqLGBVWBs8EJRgubgN/YMBM7BUl3D
         XSXc8eKkles/sYZWTFybHWQJxGmlukJGXjeUDLP4u0JJpwCjdIOvCfvLtYyk+cpIkHQA
         V4D+9xh/I3gqgySt9UwRYRFkn0A8JFoSiSAKgNx9VKWq14aMMGONDW/bEcz0u+pdLRaP
         01xA==
X-Gm-Message-State: AOAM531uHR2yIlwTRXQ5PYjH4oeAcKj5VDDIwGF0yQh6ilFblLGKpie0
        7P3fRzCgSuLWyiUNIvIkEESwVdoTP0bHFii6Wl9bhA==
X-Google-Smtp-Source: ABdhPJzOeKRQ0bjI+2VVj2I8hJUcksi5JTS5V9qKCoohUYlJtpmSDZBaVU6Yla/J7LqeyarQ8+6F1+kQ5PwxFXeTvkM=
X-Received: by 2002:a2e:b44f:: with SMTP id o15mr17074256ljm.430.1631645318759;
 Tue, 14 Sep 2021 11:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <YUBYJLCYpy3yJO5F@hirez.programming.kicks-ass.net> <CAPNVh5chP3Zz+ww8WLb9bUYNikW-1PyOV=3==BM-92BgogaB3w@mail.gmail.com>
 <YUDkR8YtekMkuaBH@hirez.programming.kicks-ass.net> <CAPNVh5eodc7_oSd9bb83eBucT5Vxy4cExkVSxw3pZ4McFAtjmw@mail.gmail.com>
In-Reply-To: <CAPNVh5eodc7_oSd9bb83eBucT5Vxy4cExkVSxw3pZ4McFAtjmw@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 14 Sep 2021 11:48:27 -0700
Message-ID: <CAPNVh5f+=CmP_hhtVdMTh3kjsFDFNEWdeCBZ8TOhvAXWKe-N+A@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
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

On Tue, Sep 14, 2021 at 11:29 AM Peter Oskolkov <posk@google.com> wrote:
>
> On Tue, Sep 14, 2021 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Sep 14, 2021 at 09:29:00AM -0700, Peter Oskolkov wrote:
> > > In the version of the patchset that I'm preparing to send I've decided
> > > to punt on the issue and just ask the userspace to deal with locking
> > > the memory as it sees fit: mlock() is available and as far as I can
> >
> > Sadly mlock() does not imply no faults. Someone had a too literal
> > reading of the POSIX-RT spec (of which mlock is part) and figured that
> > all that was required was to keep the page in memory, not avoid faults.
> >
> > Linux has had this bahviour for ages, PREEMPT_RT has tried to change
> > this, but so far to no avail. At some point sys_mpin() was proposed to
> > meet the original POSIX-RT intent, but afaict that never actually
> > happened.
> >
> > In short, mlock() does not avoid minor faults, or even migration faults,
> > which can take a fair while to resolve.
>
> Ok, I'll go with transiently pinning pages in
> __syscall_enter_from_user_work(), as you suggested. Seems easy enough
> to do.

Actually, I think pinning these pages when the worker exits to the
userspace (i.e. is scheduled on a CPU) and releasing them when the
worker is descheduled (blocks) would be better - this way we will be
able to wake the server not only on blocking syscalls but also on
pagefaults (on other pages) as well.

Do you think this approach is acceptable?

>
> Thanks for the suggestion!
