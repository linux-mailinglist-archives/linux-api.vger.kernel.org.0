Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A1B484803
	for <lists+linux-api@lfdr.de>; Tue,  4 Jan 2022 19:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiADSpU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jan 2022 13:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiADSpT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jan 2022 13:45:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1DC061784
        for <linux-api@vger.kernel.org>; Tue,  4 Jan 2022 10:45:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j21so151930998edt.9
        for <linux-api@vger.kernel.org>; Tue, 04 Jan 2022 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kI7lvNJiYPzLyL1Je0qvpRBcO19V08nghbpJc6sg03Q=;
        b=O0l9LFOhe0v3r9xfQXVq7v4rwX3xK7UVbh17OAJbou3mDbSswePNdZq99CXPQ5vIbQ
         oDK6mHyvhN+fMCZYW134EsLULbvrAGYOKLuxUb7c4HjdN6JyBCmbvSofoCrh26sjcQVP
         Sv3wocV4KjjJ9qTWC0/NqJ1QLM6rKPr9OZG4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kI7lvNJiYPzLyL1Je0qvpRBcO19V08nghbpJc6sg03Q=;
        b=Z4TTmrQLG0gua9Y1p+oAMKihD7kPu9it8R65M3Zw2cGN2ydwcwRaDuYs+whtw98Y8w
         v22cm/U1VsRhysCjrHZMZEvKOh4IDm6vHTSNwf9EBez7OMIKYRR1WTmj+HXE0iRwMrjp
         mPXVvJrYnh3NUMbTKV1nebqGjN1zNewlEgvHF7QBOF6US7btUuS8OjjG4iSwocEpO4J0
         D+R4VX4yPIM4tLplth2KEVN7AC3XRyX0C+tcQ7o6g7T9YZOMI8o4ohqsAYlQttcRMUfK
         a1jB2WWivH79n0g0n6kHWUvNdik/ZuGX5rWRETDRwb2tMyQlZUipAnCF5vC5PY7AJInW
         K1xw==
X-Gm-Message-State: AOAM531jD5xM2lCqbLrJ7KHiWxzfj095lv426i9ldiArT1wB5iJvAYNq
        U7lGyp9Z42pXKPwUow7GFabQmhC1mRJFCvnW
X-Google-Smtp-Source: ABdhPJyw061BzZSWvmOSruf9pRnwvzHFiGjqIEENTWMJjO9vIvNEAAnsazMFTB8FYAb8jxO5FyXW3Q==
X-Received: by 2002:a05:6402:22ad:: with SMTP id cx13mr21477978edb.87.1641321917826;
        Tue, 04 Jan 2022 10:45:17 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id kx19sm9485269ejc.112.2022.01.04.10.45.16
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:45:16 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so201450wmj.5
        for <linux-api@vger.kernel.org>; Tue, 04 Jan 2022 10:45:16 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr13487467wmj.144.1641321915993;
 Tue, 04 Jan 2022 10:45:15 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org> <20211213225350.27481-1-ebiederm@xmission.com>
In-Reply-To: <20211213225350.27481-1-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jan 2022 10:44:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
Message-ID: <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Dec 13, 2021 at 2:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
>         if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
> -               if (!(signal->flags & SIGNAL_GROUP_EXIT))
> -                       return sig == SIGKILL;
> +               struct core_state *core_state = signal->core_state;
> +               if (core_state) {

This change is very confusing.

Also, why does it do that 'signal->core_state->dumper.task', when we
already know that it's the same as 'signal->group_exit_task'?

The only thing that sets 'signal->core_state' also sets
'signal->group_exit_task', and the call chain has set both to the same
task.

So the code is odd and makes little sense.

But what's even more odd is how it

 (a) sends the SIGKILL to somebody else

 (b) does *NOT* send SIGKILL to itself

Now, (a) is explained in the commit message. The intent is to signal
the core dumper.

But (b) looks like a fundamental change in semantics. The target of
the SIGKILL is still running, might be in some loop in the kernel that
wants to be interrupted by a fatal signal, and you expressly disabled
the code that would send that fatal signal.

If I send SIGKILL to thread A, then that SIGKILL had *better* be
delivered. To thread A, which may be in a "mutex_lock_killable()" or
whatever else.

The fact that thread B may be in the process of trying to dump core
doesn't change that at all, as far as I can see.

So I think this patch is fundamentally buggy and wrong. Or at least
needs much more explanation of why you'd not send SIGKILL to the
target thread.

               Linus
