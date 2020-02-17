Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97FE16146D
	for <lists+linux-api@lfdr.de>; Mon, 17 Feb 2020 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBQOVJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Feb 2020 09:21:09 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:47103 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgBQOVI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Feb 2020 09:21:08 -0500
Received: by mail-il1-f195.google.com with SMTP id t17so14326166ilm.13;
        Mon, 17 Feb 2020 06:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VT2Jj/C190jePhBxlOZ3FaL93oF/zp7UeucYw43AKRQ=;
        b=nsjVDVK08vbZDMuGDpJkAj1+vZCTTg889MayY/g9UIYXZHZfHP6EEQxQ3GGgV3Ns8R
         T54PiltKBH0pkJdtkv3O3+tVXTC2mIYZTDif2ciPLSSzeIoSy/FTrpIvGruIOx1lqLg5
         xEyIa/VPMZVQ/hzPUVYNrKODCYxFph60LuoWYW7Pr+pEiVo6aS3WP467u3NNSBjBHXc0
         gbQwKSqBNfEtvB0cyLaSpXC/cvIjw3X+hpYtJ9AJwKM6fcl0HyhWcdovR6VA5QjIrBft
         +30FuPKF1G7ZLOaT3ST1l8yEzfRZj0QqJzkjlHgho8go8dQ91Oax7euuHNIQVExUJWjj
         shcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VT2Jj/C190jePhBxlOZ3FaL93oF/zp7UeucYw43AKRQ=;
        b=oUWNWf304CUCParYsCGZgRqNoHeoiJYvNqXYOzk+DIl5304McXEjOP0ot8yUPv/5ke
         BTTxoEz5AQamZWh/MqU0L7C+VNsp53rj/Zg5620FvALQBhxTCV5JnpbJtQW6BiMYGnt2
         jk8LpC4xsPATP+qEG9vtA4MDemkuv9sesBKam1TlBLt6pncJ/zxyJdP1jy8louskNp7+
         RXELn5HlTSuTCQ4zCV20ywc5Op+OA9DFJcRWzDJ70rfhh31rH0wX+Ly8M0Tc7VIyxVFW
         Y6aJ6DtnAkTFIDTeAsa77h5o0B3LYNaJIfwNDi0kOjRFldzt3kcYoj5HuKr7cj0fpb69
         rCfQ==
X-Gm-Message-State: APjAAAXi9BNj2TLmdnwFVRXHwahNOXRaisdNd8NiwtGgnEKzX2DxbDB8
        4fEXrWWXs6ocqnJo5x84CyGq+gLOhB5ijRQMFBY=
X-Google-Smtp-Source: APXvYqy+iWCFDAUkWGm7vkLzEo1qp0qC12tLGXfxN2V9KEoeSeXJjv2PMVsNRvCVApb9rOiSLoJ5REcUC/N2Nk9m7X0=
X-Received: by 2002:a92:5cc9:: with SMTP id d70mr14430427ilg.210.1581949267676;
 Mon, 17 Feb 2020 06:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20191112012724.250792-1-dima@arista.com> <20191112012724.250792-4-dima@arista.com>
In-Reply-To: <20191112012724.250792-4-dima@arista.com>
From:   Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Mon, 17 Feb 2020 15:20:55 +0100
Message-ID: <CAHO5Pa2_7BzZPCXjFj4f=YoX28M4q2Au=h6GrzN-EjRffMo1iw@mail.gmail.com>
Subject: Time Namespaces: CLONE_NEWTIME and clone3()?
To:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        x86@kernel.org, Andrei Vagin <avagin@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Dmitry, Andrei,

Is the CLONE_NEWTIME flag intended to be usable with clone3()? The
mail quoted below implies (in my reading) that this should be possible
once clone3() is available, which it is by now. (See also [1].)

If the answer is yes, CLONE_NEWTIME  should be usable with clone3(),
then I have a bug report and a question.

I successfully used CLONE_NEWTIME with unshare(). But if I try to use
CLONE_NEWSIGNAL with clone3(), it errors out with EINVAL, because of
the following check in clone3_args_valid():

        /*
         * - make the CLONE_DETACHED bit reuseable for clone3
         * - make the CSIGNAL bits reuseable for clone3
         */
        if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
                return false;

The problem is that CLONE_NEWTIME matches one of the bits in the
CSIGNAL mask. If the intention is to allow CLONE_NEWTIME with
clone3(), then either the bit needs to be redefined, or the error
checking in clone3_args_valid() needs to be reworked.

And my question: if it is intended that CLONE_NEWTIME  should be
usable with clone3(), how should that work? What I mean is,
clone3(CLONE_NEWTIME) creates a child process in a new time namespace,
but, as I understand it, the /proc/PID/timens_offsets must be defined
before the first process is created in or joins (setns()) the new
namespace. What am I missing?

Thanks,

Michael

[1] The message for commit 769071ac9f20b6a447410c7eaa55d1a5233ef40c,
implies rather more strongly that clone3() should be able to use
CLONE_NEWCTIME, but perhaps that is a result of Thomas's fix-up:

[[
    All available clone flags have been used, so CLONE_NEWTIME uses the highest
    bit of CSIGNAL. It means that it can be used only with the unshare() and
    the clone3() system calls.

    [ tglx: Adjusted paragraph about clone3() to reality and massaged the
            changelog a bit. ]
]]

On Tue, Nov 12, 2019 at 2:31 AM Dmitry Safonov <dima@arista.com> wrote:
>
> From: Andrei Vagin <avagin@openvz.org>
>
> Time Namespace isolates clock values.
>
> The kernel provides access to several clocks CLOCK_REALTIME,
> CLOCK_MONOTONIC, CLOCK_BOOTTIME, etc.
>
> CLOCK_REALTIME
>       System-wide clock that measures real (i.e., wall-clock) time.
>
> CLOCK_MONOTONIC
>       Clock that cannot be set and represents monotonic time since
>       some unspecified starting point.
>
> CLOCK_BOOTTIME
>       Identical to CLOCK_MONOTONIC, except it also includes any time
>       that the system is suspended.
>
> For many users, the time namespace means the ability to changes date and
> time in a container (CLOCK_REALTIME).
>
> But in a context of the checkpoint/restore functionality, monotonic and
> bootime clocks become interesting. Both clocks are monotonic with
> unspecified staring points. These clocks are widely used to measure time
> slices and set timers. After restoring or migrating processes, we have to
> guarantee that they never go backward. In an ideal case, the behavior of
> these clocks should be the same as for a case when a whole system is
> suspended. All this means that we need to be able to set CLOCK_MONOTONIC
> and CLOCK_BOOTTIME clocks, what can be done by adding per-namespace
> offsets for clocks.
>
> A time namespace is similar to a pid namespace in a way how it is
> created: unshare(CLONE_NEWTIME) system call creates a new time namespace,
> but doesn't set it to the current process. Then all children of
> the process will be born in the new time namespace, or a process can
> use the setns() system call to join a namespace.
>
> This scheme allows setting clock offsets for a namespace, before any
> processes appear in it.
>
> All available clone flags have been used, so CLONE_NEWTIME uses the
> highest bit of CSIGNAL. It means that we can use it with the unshare()
> system call only. Rith now, this works for us, because time namespace
> offsets can be set only when a new time namespace is not populated. In a
> future, we will have the clone3() system call [1] which will allow to use
> the CSIGNAL mask for clone flags.
>
> [1]: httmps://lkml.kernel.org/r/20190604160944.4058-1-christian@brauner.io
>
> Link: https://criu.org/Time_namespace
> Link: https://lists.openvz.org/pipermail/criu/2018-June/041504.html
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> Co-developed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>


-- 
Michael Kerrisk Linux man-pages maintainer;
http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface", http://blog.man7.org/
