Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAEB1BB389
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 03:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgD1BoA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 21:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1BoA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 21:44:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A535C03C1A8
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 18:44:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so15214801edv.8
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 18:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dLKuml1l37VsUNUL7W3+8Plw3oZZU13zk85vygbzVU=;
        b=Bd+HoaOQxYuuh8Zf1OdODQuVSh84RUl4JQmlzGerUyQmf8yQo21wChRkbSt91VRbi7
         rW7nVLys2SsQX2Zyf0eFgqihojc0YmFDp8m/iu9CZyEhvrn1ELZTebPjm+Ei/dLS9xRA
         fQg/tEt3Rd0+Q259PEVjDGKRpewOS/+lcY8FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dLKuml1l37VsUNUL7W3+8Plw3oZZU13zk85vygbzVU=;
        b=gxg94O6v7GM7+DJmjJ7tI0KMYOZqG56PlAS/qc7J51ltPRSV8ijyn77th/7mUage5E
         q1meFTLWSAAt/CDiIQrbZIMK+v7fUFfCoZ7nuJXq2Eff/p9Gix60fLljlM/lZkzrhRuq
         p5venb9MMsOkYA+QFCGm9MsONaPPYPtmtal5Nhmp3wC11ZitKVLGITsGhZAD+C8LjXJ2
         liAroonlWnAMDSQJZU9aYpqM9KVcMe9zMo1YeGztOhs32NwfVlTVkegHEplZMjXSuLov
         5zSsSX1pwjk8i08hP38auVJ8QOHz8s1wtGVWSxB/q1J0jOnlK+ZV46PuZJuKpgh82BaW
         XMHQ==
X-Gm-Message-State: AGi0PuYUep5Z9ivre2sCVoJKpxxUDMoDjO6quaHa5WnacQFxsyQdmoAP
        MbCFrCWqZaLKxQs8YnKQ69ni3n2mAXo=
X-Google-Smtp-Source: APiQypJ/XLebd4HrD8EpPZ8R20+VwhD5MXmZfNFX8ELwb6EKEL1sCkME1B3xwMgrTtdfu0VTdJb0sQ==
X-Received: by 2002:a05:6402:356:: with SMTP id r22mr22095618edw.3.1588038234503;
        Mon, 27 Apr 2020 18:43:54 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id x25sm133477edr.61.2020.04.27.18.43.54
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 18:43:54 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id g16so15222135eds.1
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 18:43:54 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr17156490lfo.152.1588037812064;
 Mon, 27 Apr 2020 18:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein> <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org> <20200427185929.GA1768@laniakea>
 <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
 <20200427201303.tbiipopeapxofn6h@wittgenstein> <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
In-Reply-To: <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 18:36:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Message-ID: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 27, 2020 at 5:46 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> I agree. It would be a shame to add a new ptrace syscall and not take
> the opportunity to fix the multitude of problems with the existing API.
> But that's a Pandora's box which we shouldn't open unless we want to
> wait a long time to get an API everyone is okay with -- a pretty high
> price to just get pidfds support in ptrace.

We should really be very very careful with some "smarter ptrace".
We've had _so_ many security issues with ptrace that it's not even
funny.

And that's ignoring all the practical issues we've had.

I would definitely not want to have anything that looks like ptrace AT
ALL using pidfd. If we have a file descriptor to specify the target
process, then we should probably take advantage of that file
descriptor to actually make it more of a asynchronous interface that
doesn't cause the kinds of deadlocks that we've had with ptrace.

The synchronous nature of ptrace() means that not only do we have
those nasty deadlocks, it's also very very expensive to use. It also
has some other fundamental problems, like the whole "take over parent"
and the SIGCHLD behavior.

It also is hard to ptrace a ptracer. Which is annoying when you're
debugging gdb or strace or whatever.

So I think the thing to do is ask the gdb (and strace) people if they
have any _very_ particular painpoints that we could perhaps help with.

And then very carefully think things through and not repeat all the
mistakes ptrace did.

I'm not very optimistic.

              Linus
