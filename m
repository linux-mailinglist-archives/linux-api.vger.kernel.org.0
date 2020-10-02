Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4B328194E
	for <lists+linux-api@lfdr.de>; Fri,  2 Oct 2020 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbgJBRbq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Oct 2020 13:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJBRbq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Oct 2020 13:31:46 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C3C0613D0
        for <linux-api@vger.kernel.org>; Fri,  2 Oct 2020 10:31:46 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m13so2102740otl.9
        for <linux-api@vger.kernel.org>; Fri, 02 Oct 2020 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUB+RLk3PpShfXBqDpZYZe36j+5/9E7JczJN7NQ9uno=;
        b=YjsyE36hS3ag8aak5brR0ERZIBQK/xagWisuHtNr5mrtPspdbyxWqxgv6WobzeGsU3
         AN3KuXZMRhgHAtH70eUnMpJf8GNtBOdZnIyDz3MRRG1x8RCukJ3i07Sj7f52I9Oygyil
         x3rRP66aChwnRvohcRykHqp1zRxx6M9OMEFHUvYUptScpGMhd/e36LWPWii/nQJcLg6n
         7bIIVzlSGk8Q//9vDoyO4NrkMiiF2dN4afHAvH5KdkKtNAsmG+0ooxG9L1BjMXPEXV75
         vpfV9GrLSdEoMKNEH4ILodCA0i7WYtljNw5hZ+brKZ2QQCtEWXmDJuZSWNeCdFyfUCFw
         NXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUB+RLk3PpShfXBqDpZYZe36j+5/9E7JczJN7NQ9uno=;
        b=Kc0OeJLEFwQJ9mr8/QKofawQMo/0zh8Feo+UYSylf75Af1XWuaVe1f6+500SlOwCGT
         sWo95EBa9yIJu/jC4dzPYUoYZc4Z8GwC6leYYINfLWCSn8b0108CjMEsYxVulHwj1THs
         s2BsnmkXqu5evea1dGyfB9XJhd+1o7SKBXHt98Kj2MxzoesKVgIhQKGUaPCw95lj5S5N
         ji2H9xS4EXOqQXn4BiOSph1mLV9oCMt4T9ymifwy4VVkCWhgZJ0XW2HZ1jObE31xJyKB
         lqJQvnnyVVp4cIOp2+dMIANKf+UcvidFke+0wI7uxkPvfvzXlleKH5iB2XyU/FmHwuFv
         PqqQ==
X-Gm-Message-State: AOAM533v3K4lXT5zikhkIa198n+l4D/66BQVcsy1YGK5L3QvStT27K6o
        wtlGCXjNFSBEyj+VFp/666jTbwOfcu+MQbdhOXQN0w==
X-Google-Smtp-Source: ABdhPJyzeZQmZr4PjAotLl+ipebUwWEeSYJELG7O8J2R7HvezAxYHoPLjn6Xryi6L+RcPkCJNiYj3WIDsPlaYAcOjiU=
X-Received: by 2002:a9d:4b99:: with SMTP id k25mr2608245otf.281.1601659905629;
 Fri, 02 Oct 2020 10:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtF44bTzjswt26tOwfEQxrWvcSOROmEtH0HKfGn24QbRQ@mail.gmail.com>
 <20200924143317.getruzwu423g3o3e@wittgenstein> <20200924162126.mbthwz32w7rba7oe@wittgenstein>
In-Reply-To: <20200924162126.mbthwz32w7rba7oe@wittgenstein>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Oct 2020 23:01:34 +0530
Message-ID: <CA+G9fYsEwvzW1yLsPtiETGzcEnMSsEdU-0r_OJ+S6h9Bbsntqg@mail.gmail.com>
Subject: Re: selftests: pidfd: pidfd_wait hangs on linux next kernel on all devices
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-api@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 24 Sep 2020 at 21:51, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Sep 24, 2020 at 04:33:17PM +0200, Christian Brauner wrote:
> > On Wed, Sep 23, 2020 at 07:52:05PM +0530, Naresh Kamboju wrote:
> > > selftests: pidfd: pidfd_wait hangs on linux next kernel on x86_64,
> > > i386 and arm64 Juno-r2
> > > These devices are using NFS mounted rootfs.
> > > I have tested pidfd testcases independently and all test PASS.
> > >
> > > The Hang or exit from test run noticed when run by run_kselftest.sh
> > >
> > > pidfd_wait.c:208:wait_nonblock:Expected sys_waitid(P_PIDFD, pidfd,
> > > &info, WSTOPPED, NULL) (-1) == 0 (0)
> > > wait_nonblock: Test terminated by assertion
> > >
> > > metadata:
> > >   git branch: master
> > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >   git commit: e64997027d5f171148687e58b78c8b3c869a6158
> > >   git describe: next-20200922
> > >   make_kernelversion: 5.9.0-rc6
> > >   kernel-config:
> > > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/865/config
> > >
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > Thanks for reproting this. I'm taking a look now!
>
> Ok, this is a simple race in the selftests, that I overlooked and which
> is more likely to hit when there's a lot of processes running on the
> system. Basically the child process hasn't SIGSTOPed itself yet but the
> parent is already calling waitid() on a O_NONBLOCK pidfd. Since it
> doesn't find a WSTOPPED process it returns -EAGAIN correctly.
>
> The fix for this is to move the line where we're removing the O_NONBLOCK
> property from the fd before the waitid() WSTOPPED call so we hang until
> the child becomes stopped.
>
> So I believe the fix is:

I have tested this patch and the pidfd_wait test did not hang this time.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

test log link
https://lkft.validation.linaro.org/scheduler/job/1813223

>
> diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
> index 4063d6f31fa4..be2943f072f6 100644
> --- a/tools/testing/selftests/pidfd/pidfd_wait.c
> +++ b/tools/testing/selftests/pidfd/pidfd_wait.c
> @@ -205,6 +205,8 @@ TEST(wait_nonblock)
>         ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED | WNOHANG, NULL);
>         ASSERT_EQ(ret, 0);
>
> +       ASSERT_EQ(fcntl(pidfd, F_SETFL, (flags & ~O_NONBLOCK)), 0);
> +
>         ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
>         ASSERT_EQ(info.si_signo, SIGCHLD);
>         ASSERT_EQ(info.si_code, CLD_STOPPED);
> @@ -212,8 +214,6 @@ TEST(wait_nonblock)
>
>         ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
>
> -       ASSERT_EQ(fcntl(pidfd, F_SETFL, (flags & ~O_NONBLOCK)), 0);
> -
>         ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL), 0);
>         ASSERT_EQ(info.si_signo, SIGCHLD);
>         ASSERT_EQ(info.si_code, CLD_EXITED);
>

- Naresh

> Christian
