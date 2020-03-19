Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0418BAB5
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCSPNX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 11:13:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33445 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbgCSPNW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 11:13:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id c20so1959270lfb.0
        for <linux-api@vger.kernel.org>; Thu, 19 Mar 2020 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uotPJyrFZ0V5dJBIBxpoXcAAW/RZupCPGuZpTwdN+s=;
        b=IObK/vTbu2r1EwtJUxcOkt/weNgwAIs+CHTDvFgznXHZYVnCuvygzfOBa4JLbHT97b
         W9XtSA7rUSeyqs4nYmn9mTKNKjGB079S+l2sxY3DvKZFnHs93Sb1SYARR39KY1nD5L26
         /tKgb1jIfCLitehDbmJwfWQipefcZm7L02maSR1IKYDj3oB3T83NhKnIgOSh9+KEIgNl
         TKDSLoErLO8Nl1dNdDkofdlbfXby0LIXIuFEbQ7kA4LH+4gbAwq0FBa7ki43wI29SXcr
         z5XGe0X6erHAQQGBtOyfxylFoG3kI/gx/XwBTVRsH+cX4Pz5xNURnZMmaTjSAEji452K
         LLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uotPJyrFZ0V5dJBIBxpoXcAAW/RZupCPGuZpTwdN+s=;
        b=GT7+g9yZtTpqg5Ckvehq+zsFJf8F+1RhbyI4hpO+87UCMLrCw+c9Nn34daj5MiVvJ8
         se0WtBJCTGnZKfeSF+OkKn75J4KmvVb31UUY88G2j8pSlP44rs14Mok/ESN3d9uJlrty
         sHzCH/UUhjgF19tuceVIebch0eZ6+xOt/ULgF0MEV4FdVvE992z85gWQVdjQinhS9daK
         PISRt3wcVwVKBG39aG81Lny3S+lARIGAROxCkdT/f9P98IrH5vTnZPdhhPbveDmldrWY
         Up4p9Lhg+dvnpfZuQxgx0yqv7q+yC8TcyAL+lcPXnSlpxreuJwoLDRkT1G2dI8GL0LvQ
         ENPQ==
X-Gm-Message-State: ANhLgQ2eqXXRYmLz2zjD+3l17pxU4w5UsfJbJvAux+G7NNdW5+N9NtYb
        R2xXB+2csTiHSH5jfykGBLTdqyZXuUWSy40q0X9dRg==
X-Google-Smtp-Source: ADFU+vu1xSj2mSTjDUg4SXO/2v8/tid2EhIWeZkU86OKVTq9D1e8crqiiKiOF6X8KpVKbvzB2tB2QO5h9YFRavOMQH4=
X-Received: by 2002:ac2:4552:: with SMTP id j18mr2475295lfm.89.1584630800987;
 Thu, 19 Mar 2020 08:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org> <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Mar 2020 16:13:09 +0100
Message-ID: <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     Peter Maydell <peter.maydell@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 17, 2020 at 12:58 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 17 Mar 2020 at 11:31, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > It was brought to my attention that this bug from 2018 was
> > still unresolved: 32 bit emulators like QEMU were given
> > 64 bit hashes when running 32 bit emulation on 64 bit systems.
> >
> > The personality(2) system call supports to let processes
> > indicate that they are 32 bit Linux to the kernel. This
> > was suggested by Teo in the original thread, so I just wired
> > it up and it solves the problem.
>
> Thanks for having a look at this. I'm not sure this is what
> QEMU needs, though. When QEMU runs, it is not a 32-bit
> process, it's a 64-bit process. Some of the syscalls
> it makes are on behalf of the guest and would need 32-bit
> semantics (including this one of wanting 32-bit hash sizes
> in directory reads). But some syscalls it makes for itself
> (either directly, or via libraries it's linked against
> including glibc and glib) -- those would still want the
> usual 64-bit semantics, I would have thought.

The "personality" thing is a largely unused facility that
a process can use to say it has this generic behaviour.
In this case we say we have the PER_LINUX32 personality
so it will make the process evoke 32bit behaviours inside
the kernel when dealing with this process.

Which I (loosely) appreciate that we want to achieve.

> > Programs that need the 32 bit hash only need to issue the
> > personality(PER_LINUX32) call and things start working.
>
> What in particular does this personality setting affect?
> My copy of the personality(2) manpage just says:
>
>        PER_LINUX32 (since Linux 2.2)
>               [To be documented.]
>
> which isn't very informative.

It's not a POSIX thing (not part of the Single Unix Specification)
so as with most Linux things it has some fuzzy semantics
defined by the community...

I usually just go to the source.

If you grep the kernel what turns up is a bunch of
architecture-specific behaviors on arm64, ia64, mips, parisc,
powerpc, s390, sparc. They are very minor.

On x86_64 the semantic effect is
none so this would work for any kind of 32bit userspace
on x86_64. It would be the first time this flag has any
effect at all on x86_64, but arguably a useful one.

I would not be surprised if running say i586 on x86_64
has the same problem, just that noone has reported
it yet. But what do I know. If they have the same problem
they can use the same solution. Hm QEMU supports
emulating i586 or even i386 ... maybe you could test?
Or tell me how to test? We might be solving a bigger
issue here.

Yours,
Linus Walleij
