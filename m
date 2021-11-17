Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2332E454AE9
	for <lists+linux-api@lfdr.de>; Wed, 17 Nov 2021 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhKQQ1o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Nov 2021 11:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbhKQQ1o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Nov 2021 11:27:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF0C061766
        for <linux-api@vger.kernel.org>; Wed, 17 Nov 2021 08:24:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y13so13457034edd.13
        for <linux-api@vger.kernel.org>; Wed, 17 Nov 2021 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6L7OzfiQyE8rpmiPr/U7sB3ARsNEEIc6tTD5oicXGL0=;
        b=hjd3Pimoe+P7d5tptv4JTo8OA3iG9q7DU2Doq7WpwF7l0aoAGcK+/89tB/gcnNdI92
         FaGnxL+8gGSC5pnNtHTd0OZ0EfguhnPojMU/C4VvWZTSIGasqzq29eFx7LJC8IbFChFz
         B/DMMLHBZn6w/jp/A49LC/WWQT73kArPDeGJlHwVXU8Uq6Eo9zYCOLfBCn/r0Ly3diA8
         7pqDcyi08x3k75HXd12ShA81zNh8H8Qw7fS3CQKdQbY7W1FsdTPatJx/hb8xATI7JdJY
         Y68O8gFOGY9yYHFpP0XqWbGP1wIPjs7fBA4kw+ufzhtb93NJ4CeH8/zsk9tIv0q1l5Nd
         xLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6L7OzfiQyE8rpmiPr/U7sB3ARsNEEIc6tTD5oicXGL0=;
        b=KI6IUtjeo2xXk0lZok9G1oWWXK3iK8l05vN1e4r+wmOKoyBDS/DujndYK/iOgWsnQU
         6NMLnYKFRvni2G0xduzB0Xh/Q6irNBNrW4g/hJkylkGFwyeKFVMTD8E8nfw3a2EgQ4TI
         kZN67Tc1Q2YsbiCBCokpHbPRfi47ZmhggKEjKnlwFZ2GSRxD/gHLs/UcaU+bt8N+dhwy
         /kIbguoa2qo3xBroP3JAC7hbL1uPM4W5ZDBv5Z5l06USTzTqP28Be7E3knGlo74Jukbt
         CFAulQrIupBxAoIF22+a2GWeALgXwxbzxxovsp9SzrArLYneEMRiD0seK2i/CHGWlgP7
         j5Uw==
X-Gm-Message-State: AOAM532nMLK9SXQhoI6PwDP9A7UNNLKih+MbLFIQsQ6SLdjoyiZrvn5E
        tH6I/dE6SO/6Jwebs21MJ9nbPp3CBKssd3zithXwaw==
X-Google-Smtp-Source: ABdhPJxN4dep9XHoIjRro5Ir3uqB0g0J9nm8BMDTkfWlumxT02fFkgvvytQPmhRKRbMfIjnY1liQge88sHUi9qllTmk=
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr23197212ejc.490.1637166283657;
 Wed, 17 Nov 2021 08:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20211101034147.6203-1-khuey@kylehuey.com> <877ddqabvs.fsf@disp2133>
 <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
 <87fsse8maf.fsf@disp2133> <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
 <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com> <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 08:24:28 -0800
Message-ID: <CAP045AqSKv8hAz79ntbj6ZoGiO-v7M0UBuQF2hwJdXqqL7oxWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] signal: requeuing undeliverable signals
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@mariadb.com>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 15, 2021 at 9:31 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> Kyle Huey recently reported[1] that rr gets confused if SIGKILL prevents
> ptrace_signal from delivering a signal, as the kernel setups up a signal
> frame for a signal that rr did not have a chance to observe with ptrace.
>
> In looking into it I found a couple of bugs and a quality of
> implementation issue.
>
> - The test for signal_group_exit should be inside the for loop in get_signal.
> - Signals should be requeued on the same queue they were dequeued from.
> - When a fatal signal is pending ptrace_signal should not return another
>   signal for delivery.
>
> Kyle Huey has verified[2] an earlier version of this change.
>
> I have reworked things one more time to completely fix the issues
> raised, and to keep the code maintainable long term.
>
> I have smoke tested this code and combined with a careful review I
> expect this code to work fine.  Kyle if you can double check that
> my last round of changes still works for rr I would appreciate it.

This still fixes the race we reported.

Tested-by: Kyle Huey <khuey@kylehuey.com>

- Kyle

> Eric W. Biederman (3):
>       signal: In get_signal test for signal_group_exit every time through the loop
>       signal: Requeue signals in the appropriate queue
>       signal: Requeue ptrace signals
>
>  fs/signalfd.c                |  5 +++--
>  include/linux/sched/signal.h |  7 ++++---
>  kernel/signal.c              | 44 ++++++++++++++++++++++++++------------------
>  3 files changed, 33 insertions(+), 23 deletions(-)
>
> [1] https://lkml.kernel.org/r/20211101034147.6203-1-khuey@kylehuey.com
> [2] https://lkml.kernel.org/r/CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com
>
> Eric
