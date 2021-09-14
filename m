Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2140B6F6
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhINSbS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 14:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhINSbS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 14:31:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286BC061574
        for <linux-api@vger.kernel.org>; Tue, 14 Sep 2021 11:30:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s12so525664ljg.0
        for <linux-api@vger.kernel.org>; Tue, 14 Sep 2021 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFVYzJ8YTa+AGDh1qk1TwKj2W51f7K7hlovDVMVEqy4=;
        b=NhlGWuGaV0jYGjNbfdOafXTFiTSg+9TM+X1xSh6FvChIKfpetxiyJDG3dyef0TJKiW
         VSfZ5VINDVFMjKErAw96wZa5KIRdwcSoScZaWLldpalE5xpvALmfN8tDTQ3X0NtRj0wi
         3AHBmf7W9aOH+qfOvddVqr7xnUvazkaEPHoLbPIuG3zM8whFPoBwT1PJPefa9FvtYRQw
         RozofHJugThFbZCpg1QpDvIhOidMo804YW8NiGNB1v8WW8codCAlJYieVM7Bcp0ArNJy
         ckhoVkQjR0WcOuSilst/EpYecHBlHF/qkKSGVr6jsQ9WFNkBCEpQBlfUbtiP2Dlbq94i
         0PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFVYzJ8YTa+AGDh1qk1TwKj2W51f7K7hlovDVMVEqy4=;
        b=6GDxmA7TX9rXeFlb98EWV4Sd557qTIsU5xL6ZL/QG9lWkGaLIZWYeImnsgp3Ex/bsN
         jaekqSzIBDO1gquSeSFp93bgSjHKqd8R7WGZAHfXVGTVRvRBTVfRDpWUSPLANAlbS1xD
         yF2t+pNTtJVnt/hOfsGi4dn8TnabWRptrXcGI7F8nP3ZVhX/pBuXCLrmaIb5isdJ7Zkg
         31oP8ZpRYfr41hLNkvZRX0dBGKRPXSlS/8mh0F6wiLXNYvq/hWbq79UA5zIkig0rPiLw
         OXQIfKlzr16lB/MfaRtL64LQsNh3w/bNrATDXSE/yPDbNh1R0nYd37tURvfeI/XXIOrQ
         UVDQ==
X-Gm-Message-State: AOAM531SDC8JR/e41Pwogu8ugteugb5TV166zftjqwPbp7kVeJA0V8DN
        5WYibrcN6Fz4QNbYYWVkudiQh95cPyFFnhh4AjwmvQ==
X-Google-Smtp-Source: ABdhPJwnbfo7jIZV8IhqzpM2WpOdA52Awj/p8tihGDH20IIyaAP+6S+/fyMIIozk856YMAABXV/ZFbjj/GG8Qf+zLRo=
X-Received: by 2002:a2e:a726:: with SMTP id s38mr16630655lje.386.1631644198402;
 Tue, 14 Sep 2021 11:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <YUBYJLCYpy3yJO5F@hirez.programming.kicks-ass.net> <CAPNVh5chP3Zz+ww8WLb9bUYNikW-1PyOV=3==BM-92BgogaB3w@mail.gmail.com>
 <YUDkR8YtekMkuaBH@hirez.programming.kicks-ass.net>
In-Reply-To: <YUDkR8YtekMkuaBH@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 14 Sep 2021 11:29:46 -0700
Message-ID: <CAPNVh5eodc7_oSd9bb83eBucT5Vxy4cExkVSxw3pZ4McFAtjmw@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Sep 14, 2021 at 09:29:00AM -0700, Peter Oskolkov wrote:
> > In the version of the patchset that I'm preparing to send I've decided
> > to punt on the issue and just ask the userspace to deal with locking
> > the memory as it sees fit: mlock() is available and as far as I can
>
> Sadly mlock() does not imply no faults. Someone had a too literal
> reading of the POSIX-RT spec (of which mlock is part) and figured that
> all that was required was to keep the page in memory, not avoid faults.
>
> Linux has had this bahviour for ages, PREEMPT_RT has tried to change
> this, but so far to no avail. At some point sys_mpin() was proposed to
> meet the original POSIX-RT intent, but afaict that never actually
> happened.
>
> In short, mlock() does not avoid minor faults, or even migration faults,
> which can take a fair while to resolve.

Ok, I'll go with transiently pinning pages in
__syscall_enter_from_user_work(), as you suggested. Seems easy enough
to do.

Thanks for the suggestion!
