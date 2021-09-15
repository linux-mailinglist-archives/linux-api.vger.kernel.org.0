Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AE040CB38
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 18:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhIOQwO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 12:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhIOQwO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Sep 2021 12:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 514AA61260
        for <linux-api@vger.kernel.org>; Wed, 15 Sep 2021 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631724655;
        bh=AiRKHUxW2UC5D7JE+/BfAF9miYwYIckZFB8tXEZpz3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k+oDjFt5gTfWrDzoUS2ed1thbqwwswMTHtIbMBnYsmYlU62X/Ba+wFoMc9CbmtFN5
         fSCvl1sd5Bum/A39Q5CUy+vcLFXB9ezlcLxudKXouCxFsIT4YG4wxArub9z90B0fXG
         CdAqv+byn3s16AMvRbaP1SdRhTIWoaWhgs/I+qdGh7FOVHaVz2ExT6VmHKFZLXfBWi
         +udS/YTPFUQY1ISwRGp4hnSn2+/hozH/pHKqErbQJMSoXguJzkj6jp27zi01c/vbBf
         01wkOHnIWn8gKRXLgEAjUPK/Pjx4bXrq+nKVlS5PdtO9OLuNz4ochBHPFgu6BcIqff
         /wp8luXtoBShA==
Received: by mail-ed1-f44.google.com with SMTP id c21so6049195edj.0
        for <linux-api@vger.kernel.org>; Wed, 15 Sep 2021 09:50:55 -0700 (PDT)
X-Gm-Message-State: AOAM530zRTuQ2ROAbXN9OLL7vBOoUPIcLRYSSY0IzQMM+kt6VFaEAWsb
        wh+lsw2FjGU9/SGHJSXLlU8GLKvgv03tBcK0UMc+KA==
X-Google-Smtp-Source: ABdhPJz5oJ58WKmkfJP7RMNQimsHC0mIqFbx/s/7eewyakz0V5Lg66Firoc31Cet/Fza8chr6FPifVXDlUSmCCLjhRY=
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr984813ejr.435.1631724653730;
 Wed, 15 Sep 2021 09:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
 <d656e605-4f89-4ea2-8baf-f7786f0630d9@www.fastmail.com> <YUDlzxLjNsW+oYGC@hirez.programming.kicks-ass.net>
 <f6fdecfe-963d-4669-ae05-1d7192467a19@www.fastmail.com> <YUIUWs9pIfHh51lP@hirez.programming.kicks-ass.net>
In-Reply-To: <YUIUWs9pIfHh51lP@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 15 Sep 2021 09:50:41 -0700
X-Gmail-Original-Message-ID: <CALCETrUnnHN0dyx02ewuRu=_TZ+cD=HaEzNs34ADNbWps1tTBw@mail.gmail.com>
Message-ID: <CALCETrUnnHN0dyx02ewuRu=_TZ+cD=HaEzNs34ADNbWps1tTBw@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15, 2021 at 8:45 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Tue, Sep 14, 2021 at 11:40:01AM -0700, Andy Lutomirski wrote:
> >
> >
> > On Tue, Sep 14, 2021, at 11:11 AM, Peter Zijlstra wrote:
> > > On Tue, Sep 14, 2021 at 09:52:08AM -0700, Andy Lutomirski wrote:
> > > > With a custom mapping, you don=E2=80=99t need to pin pages at all, =
I think.
> > > > As long as you can reconstruct the contents of the shared page and
> > > > you=E2=80=99re willing to do some slightly careful synchronization,=
 you can
> > > > detect that the page is missing when you try to update it and skip =
the
> > > > update. The vm_ops->fault handler can repopulate the page the next
> > > > time it=E2=80=99s accessed.
> > >
> > > The point is that the moment we know we need to do this user-poke, is
> > > schedule(), which could be called while holding mmap_sem (it being a
> > > preemptable lock). Which means we cannot go and do faults.
> >
> > That=E2=80=99s fine. The page would be in one or two states: present an=
d
> > writable by kernel or completely gone. If its present, the scheduler
> > writes it. If it=E2=80=99s gone, the scheduler skips the write and the =
next
> > fault fills it in.
>
> That's non-deterministic, and as such not suitable.

What's the precise problem?  The code would be roughly:

if (try_pin_the_page) {
  write it;
  unpin;
} else {
  do nothing -- .fault will fill in the correct contents.
}

The time this takes is nondeterministic, but it's bounded and short.

>
> > > > All that being said, I feel like I=E2=80=99m missing something. The=
 point of
> > > > this is to send what the old M:N folks called =E2=80=9Cscheduler ac=
tivations=E2=80=9D,
> > > > right?  Wouldn=E2=80=99t it be more efficient to explicitly wake so=
mething
> > > > blockable/pollable and write the message into a more efficient data
> > > > structure?  Polling one page per task from userspace seems like it
> > > > will have inherently high latency due to the polling interval and w=
ill
> > > > also have very poor locality.  Or am I missing something?
> > >
> > > The idea was to link the user structures together in a (single) linke=
d
> > > list. The server structure gets a list of all the blocked tasks. This
> > > avoids having to a full N iteration (like Java, they're talking stupi=
d
> > > number of N).
> > >
> > > Polling should not happen, once we run out of runnable tasks, the ser=
ver
> > > task gets ran again and it can instantly pick up all the blocked
> > > notifications.
> > >
> >
> > How does the server task know when to read the linked list?  And
> > what=E2=80=99s wrong with a ring buffer or a syscall?
>
> Same problem, ring-buffer has the case where it's full and events get
> dropped, at which point you've completely lost state. If it is at all
> possible to recover from that, doing so is non-deterministic.
>
> I really want this stuff to work for realtime workloads too.

A ring buffer would have a bounded size -- one word (of whatever size)
per user thread.
