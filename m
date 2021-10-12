Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5142AA2A
	for <lists+linux-api@lfdr.de>; Tue, 12 Oct 2021 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJLRAt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Oct 2021 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJLRAs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Oct 2021 13:00:48 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D008BC061745
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 09:58:46 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id i15so51324uap.0
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwN146AUSaOTW6vverLgeQ1SjqmSoxyKuytXCZPH2HI=;
        b=WEfGp4kcrc24fKYaMmGLQAH39Us7Qkouwgv4+3jU1CNigdxw7HpJW8F8355yHtIhKy
         0rXJhxJegbSd96EwStj2PGJ6T2xabIwn06PAvT8Xah0KyR46kSraN8N55cxikuNwM/8g
         jtU8r8ft8mA7qqNEALSHkFZbr9oI+3/DBqmqJ6AV1FYCm77+LMy5JaVmdUMd+HQm7PZw
         tgvFo9q/kE+jXCweeiPmHBBBJddyHBVp1w/YaJzGlKi6I8qsJI9aspCI5lGR8dKasJVr
         HHMI3FRc1V59i3CvVBRPjiw2VNxSFVQ+aU969GZ9kPgp+qY4IKZQ5RcySU6BvFcAXoHd
         tfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwN146AUSaOTW6vverLgeQ1SjqmSoxyKuytXCZPH2HI=;
        b=cS74RWFftGwOjDCD7qbK5Q7lX35gj8uAmRSIXzZ2NXGJ2sx+m/9oDLXIdidoDemeNv
         YrA2Gm8Buj8q8HxR9JpaHcn1tQN9023MugxrUeEoX1LylInXMP7DzYZ4ODw04v7hyeUc
         /ogeQparzpfvsPCtC5yx4rN9zJwU5Plc85ph4CEZK+XGuSlaA9zTziDqxCL8wL+BcGUc
         t0sSoYXIb6QIZ/t0WRkJ/7y2rOZSUkQCg/HJXaAUko0C5V1A5tBJdUZZWbUCd25DpyLR
         lDD+PD9vWD0KmCBF3iYsAyHgq15lJ361V29rYLoIJgLRVV45RU/fgBZdT8VfktIGdawO
         TCww==
X-Gm-Message-State: AOAM533jKg2T2PSrJ/x4OSyRS8Lji8IHuxDWeuRyfe9krMpJ1Tt5ceeC
        mt3yaqgLRKHyNCwp+AjagYhO0sC086qRIo4FpfdIHw==
X-Google-Smtp-Source: ABdhPJxcBwHriDcJ7ZDs2Y4NKWqE6CUB3TpUzaDRfrP0/5ER7f7GXZEh1KUBr5bmm02/fPidg9pkSnc33DT9QQ3HaXw=
X-Received: by 2002:ab0:16d4:: with SMTP id g20mr23121662uaf.114.1634057925895;
 Tue, 12 Oct 2021 09:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210917180323.278250-1-posk@google.com> <20210917180323.278250-6-posk@google.com>
 <12eb2300-4a78-9e93-30a3-8e2ddba4693f@uwaterloo.ca> <CAFTs51W6ZHrGaoXEbXNCkVKLxe7_S2raYcXMBzypC7VUDMrU-w@mail.gmail.com>
 <e162fdea-5323-89d2-49d0-3fe56ba2ec3a@uwaterloo.ca>
In-Reply-To: <e162fdea-5323-89d2-49d0-3fe56ba2ec3a@uwaterloo.ca>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 12 Oct 2021 09:58:35 -0700
Message-ID: <CAFTs51X0kQLngHYXD-BxBmm6oRyMk1vy9nzaPu4V46PifO99LQ@mail.gmail.com>
Subject: Re: [PATCH 5/5 v0.6] sched/umcg: add Documentation/userspace-api/umcg.txt
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 12, 2021 at 9:25 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:

[...]

> Just to be clear, sys_umcg_wait supports an operation that, when called
> from
> a worker, puts the worker to sleep without triggering block detection
> or context-switching back to the server?

Potentially, yes - when a worker wants to yield (e.g. as part of a
custom UMCG-aware mutex/condvar code), and calls into the userspace
scheduler, it may be faster to skip the server wakeup (e.g. reassign
the server to another sleeping worker and wake this worker). This is
not a supported operation right now, but I see how it could be used to
optimize some things in the future.

Do you have any concerns here?

>
>
>
>  >> With that said, I'm a little confused by the usage of "yields" in that
>  >> example. I would expect workers yielding to behave like kernel threads
>  >> calling sched_yield(), i.e., context switch to the server but also be
>  >> immediately added to the idle_workers_ptr.
>  >
>  > I'm not a fan of arguing about how to name things. If the maintainers
>  > ask me to rename wait/wake to park/unpark, I'll do that.
>
> I understand the sentiment, and I'm perfectly happy with the use of
> wait/wake.
> I was exclusively referring to this one use of "yield" in the
> documentation.

I don't see a big difference here, sorry. We are  mixing levels of
abstraction here again, I think. For example, the higher level
userspace scheduling code will have more nuanced treatment of IDLE
workers; but down at the kernel they are all the same: IDLE worker is
a worker that the userspace can "schedule" by marking it RUNNING,
regardless of whether the worker is "parked", or "woke from a blocking
op", or whatever other semantically different state the worker can be.
For the kernel, they are all the same, idle, not runnable, waiting for
the userspace to explicitly "schedule" them.

Similarly, I don't see a need to semantically distinguish "yield" from
"park" at the kernel level of things; this distinction seems to be a
higher-level abstraction that can be properly expressed in the
userspace, and does not need to be explicitly addressed in the kernel
(to make the code faster and simpler, for example).
