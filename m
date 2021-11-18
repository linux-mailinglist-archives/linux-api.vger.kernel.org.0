Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178DA45549F
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 07:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbhKRGPg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 01:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbhKRGPf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 01:15:35 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0FAC061764
        for <linux-api@vger.kernel.org>; Wed, 17 Nov 2021 22:12:36 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e71so14804253ybh.10
        for <linux-api@vger.kernel.org>; Wed, 17 Nov 2021 22:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FMbFUhIaE8b09O7jCFykS7u57qfyGYZrtsHvIvVcwNE=;
        b=Q5HrNakXsTxWBTz6mIHyJX8ZZddhPe1lQKX7/PG+5d7EIrxBgKrb8LC8tew3q1/g0l
         Q3Z7tFZzj+m+HFZ+JD+dA6L2DirYIo6x79+eVxU5gU94To2OzNVt03/uCKVn0sjRPK1j
         cziFCP2UFLNC4jqnaPrBzO6BsgyJAzZbeuK7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FMbFUhIaE8b09O7jCFykS7u57qfyGYZrtsHvIvVcwNE=;
        b=byoqORr6WOi4mHAZe8pdxjPwYnELMLqA4nUQCIB2szNh/YKfJg7wlH8sJafafQLuWM
         6FeWlW+vxMW63WQC2z5GhHsfVPGxNCvtEwAaLahZCgUc7cI0ol7KX7/u2QNoh9YmTfTd
         g9YWR/DHVxDP2d/f6P603cBSuebsz64pG4Bn1guqFFnXWfd+Ru0Z4mWUa2R+A3VsOOxU
         eV8hkZIKpiAZbRS3c9nq71009cIHSY39wLJLbtKDXzmkEFHTFFMaS9dJQGjM1eNgAQGn
         kv0fLF+AN52RHR4JBwh0rPHP5Kw58AR7oDkgTOwLKI7aF64/t6pwzqkDov1skOqnHpko
         82dA==
X-Gm-Message-State: AOAM531nFZYwqcATslR4g/8SKHeWSwHQiKlknmV8bjZB5L/1gufz+ISr
        S93NQux6MFuELK4rl7A51YPS9qKyjDv3CrRL6xW87g==
X-Google-Smtp-Source: ABdhPJzk8WiNUKytpZh5RKgyMgQC0diigTTk+UuQt9SwnmenSZ4Z3dnORoafcAUoiCf0gqh/SwQqLp9fhDdQl7hum2A=
X-Received: by 2002:a25:d2c7:: with SMTP id j190mr22846384ybg.330.1637215955573;
 Wed, 17 Nov 2021 22:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20211101034147.6203-1-khuey@kylehuey.com> <877ddqabvs.fsf@disp2133>
 <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
 <87fsse8maf.fsf@disp2133> <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
 <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
 <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org> <CAP045AqSKv8hAz79ntbj6ZoGiO-v7M0UBuQF2hwJdXqqL7oxWA@mail.gmail.com>
 <87y25m9154.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87y25m9154.fsf@email.froward.int.ebiederm.org>
From:   =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@mariadb.com>
Date:   Thu, 18 Nov 2021 08:12:24 +0200
Message-ID: <CAJuX1hyqRzOkYhoVLwUORTOn2ncJxiru8JfM9cpZt8uXigff2g@mail.gmail.com>
Subject: Re: [PATCH 0/3] signal: requeuing undeliverable signals
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 17, 2021 at 6:51 PM Eric W. Biederman <ebiederm@xmission.com> w=
rote:
>
> Kyle Huey <me@kylehuey.com> writes:
>
> > On Mon, Nov 15, 2021 at 9:31 PM Eric W. Biederman <ebiederm@xmission.co=
m> wrote:
> >>
> >>
> >> Kyle Huey recently reported[1] that rr gets confused if SIGKILL preven=
ts
> >> ptrace_signal from delivering a signal, as the kernel setups up a sign=
al
> >> frame for a signal that rr did not have a chance to observe with ptrac=
e.
> >>
> >> In looking into it I found a couple of bugs and a quality of
> >> implementation issue.
> >>
> >> - The test for signal_group_exit should be inside the for loop in get_=
signal.
> >> - Signals should be requeued on the same queue they were dequeued from=
.
> >> - When a fatal signal is pending ptrace_signal should not return anoth=
er
> >>   signal for delivery.
> >>
> >> Kyle Huey has verified[2] an earlier version of this change.
> >>
> >> I have reworked things one more time to completely fix the issues
> >> raised, and to keep the code maintainable long term.
> >>
> >> I have smoke tested this code and combined with a careful review I
> >> expect this code to work fine.  Kyle if you can double check that
> >> my last round of changes still works for rr I would appreciate it.
> >
> > This still fixes the race we reported.
>
> >
> > Tested-by: Kyle Huey <khuey@kylehuey.com>
>
> Thank you very much for retesting.
>
> Eric

Thank you, Kyle and Eric, for reporting and fixing the root cause of this r=
ace.

Meanwhile, I followed Kyle's suggestion and will disable the crash
handlers in the tracee whenever it is being traced.

Marko
--=20
Marko M=C3=A4kel=C3=A4, Lead Developer InnoDB
MariaDB Corporation
