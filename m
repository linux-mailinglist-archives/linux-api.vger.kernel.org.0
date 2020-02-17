Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2175161CF0
	for <lists+linux-api@lfdr.de>; Mon, 17 Feb 2020 22:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgBQVsG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Feb 2020 16:48:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39990 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgBQVsG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Feb 2020 16:48:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id p3so22337064edx.7;
        Mon, 17 Feb 2020 13:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=zfMS77r2/yOT69zQZB5nUanXr9vmDwcibatswF77RLM=;
        b=H+p1UwY0pkxpP9j7tLcvoTxufeba8MCcndAMKeLxuH8IdIhOzeXQD8tOmiF/2a301y
         XAaXMFIBn/5LcPF5yJy/vmIXjQC2xtRIhXMm0E1n0jsVnKlLJIeVKDx6RXW13r4Q7H06
         04bk9OYBeyEfXLOdoJGu3RLO6u0FMKYUmCXgPGy6aKMG7EdtuaHAIad+XVdBQg8xV+pp
         Q6kWvUmeX/MJZ0w6oka1GRbXw4LHE85qsrg9xJoc3Dx12eUdR5T65mlUyvuQqq1zlsVz
         4c1eF5f3tgfF1yZTjyJ9wW3Nmkvy32hEr4avE7NQQa6ZN6iYoniXXs+AtE6wY/6hzsUQ
         kWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=zfMS77r2/yOT69zQZB5nUanXr9vmDwcibatswF77RLM=;
        b=O1MSnS8CEILWujWies2U9UMN33s8xq547ar5cuk4CLEIUEX55sUhKSENcx4vdJ/nBu
         n5VRCw/yTYru4dbUzJmDcSfXPwPV5M01fEVgfnRgiXerK618JQUnb6I7cePMp1pBCTSE
         mCUvWcOIji0q2bbmWGPPgnHfYpmyA50ziDCPZ2xDVMGQwz9Q/T9WwxMD+rTqnR1G3CQY
         coEOUFqwyBkGCocNoGiDOwZjJOw3/G/EDVDccs80lYhFJARqD4V1cDlvU8Ilr2b+ZcPN
         LS/R1/AQ6AGyxd1YAxfFn6rg5jDdhmXlrcFYp3QBadHh3YmyD2NFav/Vy7OKKYXL2frI
         718Q==
X-Gm-Message-State: APjAAAXL4aZsOaUvXj5IhldGddJv5qSVYAkEyhG+Rodqix1MjBmBP+0a
        MG27MZEUqydDppqy5cR70l584Ubf4GBnkiFTUlk=
X-Google-Smtp-Source: APXvYqwdswv+8mGQteeErSB7yFQjychp2XnULWOThIztPi9Y3g89o2LbrvtqVap9ZG9uYBcsUUGdgo7T4c9hhkrtsfQ=
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr16348125ejc.243.1581976083916;
 Mon, 17 Feb 2020 13:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20191112012724.250792-1-dima@arista.com> <20191112012724.250792-4-dima@arista.com>
 <CAHO5Pa2_7BzZPCXjFj4f=YoX28M4q2Au=h6GrzN-EjRffMo1iw@mail.gmail.com> <20200217145908.7epzz5nescccwvzv@wittgenstein>
In-Reply-To: <20200217145908.7epzz5nescccwvzv@wittgenstein>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 17 Feb 2020 22:47:53 +0100
Message-ID: <CAKgNAkjfdWFwNdFzdBY81_8WZJNtbtztfjO9T2YNQDV4ThNiNw@mail.gmail.com>
Subject: Re: Time Namespaces: CLONE_NEWTIME and clone3()?
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        x86@kernel.org, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

On Mon, 17 Feb 2020 at 16:15, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Feb 17, 2020 at 03:20:55PM +0100, Michael Kerrisk wrote:
> > Hello Dmitry, Andrei,
> >
> > Is the CLONE_NEWTIME flag intended to be usable with clone3()? The
> > mail quoted below implies (in my reading) that this should be possible
> > once clone3() is available, which it is by now. (See also [1].)
> >
> > If the answer is yes, CLONE_NEWTIME  should be usable with clone3(),
> > then I have a bug report and a question.
> >
> > I successfully used CLONE_NEWTIME with unshare(). But if I try to use
> > CLONE_NEWSIGNAL with clone3(), it errors out with EINVAL, because of
>
> s/CLONE_NEWSIGNAL/CLONE_NEWTIME/
>
> > the following check in clone3_args_valid():
> >
> >         /*
> >          * - make the CLONE_DETACHED bit reuseable for clone3
> >          * - make the CSIGNAL bits reuseable for clone3
> >          */
> >         if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
> >                 return false;
> >
> > The problem is that CLONE_NEWTIME matches one of the bits in the
> > CSIGNAL mask. If the intention is to allow CLONE_NEWTIME with
> > clone3(), then either the bit needs to be redefined, or the error
> > checking in clone3_args_valid() needs to be reworked.
>
> If this is intended to be useable with clone3() the check should be
> adapted to allow for CLONE_NEWTIME. (I asked about this a while ago I
> think.)
> But below rather sounds like it should simply be an unshare() flag. The
> code seems to set frozen_offsets to true right after copy_namespaces()
> in timens_on_fork(new_ns, tsk) and so the offsets can't be changed
> anymore unless I'm reading this wrong.
> Alternatives seem to either make timens_offsets writable once after fork
> and before exec, I guess - though that's probably not going to work
> with the vdso judging from timens_on_fork().
>
> The other alternative is that Andrei and Dmitry send me a patch to
> enable CLONE_NEWTIME with clone3() by exposing struct timens_offsets (or
> a version of it) in the uapi and extend struct clone_args to include a
> pointer to a struct timens_offset that is _only_ set when CLONE_NEWTIME
> is set.
> Though the unshare() way sounds way less invasive simpler.

Actually, I think the alternative you propose just here is better. I
imagine there are times when one will want to create multiple
namespaces with a single call to clone3(), including a time namespace.
I think this should be allowed by the API. And, otherwise, clone3()
becomes something of a second-class citizen for creating namespaces.
(I don't really get the "less invasive" argument. Implementing this is
just a piece of kernel to code to make user-space's life a bit simpler
and more consistent.)

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
