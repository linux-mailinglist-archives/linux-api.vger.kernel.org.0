Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF9AF0F0
	for <lists+linux-api@lfdr.de>; Tue, 10 Sep 2019 20:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfIJSPm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Sep 2019 14:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730558AbfIJSPl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 10 Sep 2019 14:15:41 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE34021019
        for <linux-api@vger.kernel.org>; Tue, 10 Sep 2019 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568139340;
        bh=TbdlhZkrweZdHKGE1NQH7yEXlVoEq3NfZbuSOSqhbCM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rN2F8zsxzmxz2KarfrEIXKiBBT2f8WDBd9D/EXnyYsK2Es56VlNHQESD9HBpZtbne
         OlMlW1p4H/l6woQmeyJqdrkBWSC0SVLThH/EhiSRUEgoknaPRjl1vImIb2luEzey6G
         7XzBl4rucaM3RKi9zWkI3l5Qt/JE6MteSIPYFafs=
Received: by mail-wr1-f43.google.com with SMTP id i1so21069405wro.4
        for <linux-api@vger.kernel.org>; Tue, 10 Sep 2019 11:15:39 -0700 (PDT)
X-Gm-Message-State: APjAAAV56odWbNecvkMnWMvi1yM8H8c7L7HL6l/NfKWqJrAMKbRpLtf0
        0QLadbmT85DbnHCUJn6BVFpNznZMySO4XvEr8N1TJQ==
X-Google-Smtp-Source: APXvYqzPkgsVik2Cs3pixh3Amc4mMGJ8Rvy3kWMY1onuSjAveSUtJLMLPX4xZ/zag8RZ9EM6aBowi2WKnJYo3cuatds=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr498827wrn.47.1568139338433;
 Tue, 10 Sep 2019 11:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190905005313.126823-1-dancol@google.com> <CALCETrU2Wycgdfo8vLZQUnx1J9ro=6ddSkP37BhsfBkKL1mbMA@mail.gmail.com>
 <CAKOZuevMiomDQwzrHVb4qU6nhKOiENWsEmFhVKrBvjVNa0ff+w@mail.gmail.com>
In-Reply-To: <CAKOZuevMiomDQwzrHVb4qU6nhKOiENWsEmFhVKrBvjVNa0ff+w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 10 Sep 2019 11:15:27 -0700
X-Gmail-Original-Message-ID: <CALCETrWyDx+YiNpJn91TO2s6SMt3v+94L9aDY2nsW+KdG7pOWA@mail.gmail.com>
Message-ID: <CALCETrWyDx+YiNpJn91TO2s6SMt3v+94L9aDY2nsW+KdG7pOWA@mail.gmail.com>
Subject: Re: [RFC] Add critical process prctl
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 10, 2019 at 10:43 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Tue, Sep 10, 2019 at 9:57 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Sep 4, 2019 at 5:53 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > A task with CAP_SYS_ADMIN can mark itself PR_SET_TASK_CRITICAL,
> > > meaning that if the task ever exits, the kernel panics. This facility
> > > is intended for use by low-level core system processes that cannot
> > > gracefully restart without a reboot. This prctl allows these processes
> > > to ensure that the system restarts when they die regardless of whether
> > > the rest of userspace is operational.
> >
> > The kind of panic produced by init crashing is awful -- logs don't get
> > written, etc.
>
> True today --- but that's a separate problem, and one that can be
> solved in a few ways, e.g., pre-registering log buffers to be
> incorporated into any kexec kernel memory dumps. If a system aiming
> for reliability can't diagnose panics, that's a problem with or
> without my patch.

It's been a problem for years and years and no one has convincingly
fixed it.  But the particular type of failure you're handling is
unlike most panics: no locks are held, nothing is corrupt, and the
kernel is generally functional.

>
> > I'm wondering if you would be better off with a new
> > watchdog-like device that, when closed, kills the system in a
> > configurable way (e.g. after a certain amount of time, while still
> > logging something and having a decent chance of getting the logs
> > written out.)  This could plausibly even be an extension to the
> > existing /dev/watchdog API.
>
> There are lots of approaches that work today: a few people have
> suggested just having init watch processes, perhaps with pidfds. What
> I worry about is increasing the length (both in terms of time and
> complexity) of the critical path between something going wrong in a
> critical process and the system getting back into a known-good state.
> A panic at the earliest moment we know that a marked-critical process
> has become doomed seems like the most reliable approach, especially
> since alternatives can get backed up behind things like file
> descriptor closing and various forms of scheduling delay.

I think this all depends on exactly what types of failures you care
about.  If the kernel is dead (actually crashed, deadlocked, or merely
livelocked or otherwise failing to make progress) then you have no
particular guarantee that your critical task will make it to do_exit()
in the first place.  Otherwise, I see no real reason that you should
panic immediately in do_exit() rather than waiting the tiny amount of
time it would take for a watchdog driver to notice that the descriptor
was closed.

So, if I were designing this, I think I would want to use a watchdog.
Program it to die immediately if the descriptor is closed and also
program it to die if the descriptor isn't pinged periodically.  The
latter catches the case where the system is failing to make progress.
And "die" can mean "notify a logging daemon and give it five seconds
to do it's thing and declare it's done; panic or reboot after five
seconds if it doesn't declare that it's done."

--Andy
