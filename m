Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D561DF3479
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 17:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfKGQQc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 11:16:32 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46009 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKGQQc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 11:16:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id k2so2411613oij.12
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 08:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dy3Zw18GEppEcc1iAhwMaVLBwUsp6JGihw3ZTsB5tVQ=;
        b=WJ3yi5/uIXA2QkqLuZX0OFzSgyye7GA9Ap4IWKi+a83z3JYrTNhjtbV8urRr5kJyQC
         E/UMsNfsKvdJpYrLotOTBlXnGUXBXOyzOeiG2gF5j/aU52IzE18lo8yyudGY3vk5ECdO
         1biD663zclUCsdJEX+KF+Tc5A9XYz0yNo2nyo2y+wxW0g+a2DtLs/py/wKic9WPUvqk5
         HmzP4ZPuclCM90AoPf8hsQhJRqxSE7FcQdmj4C+iyx+g3SlCQKy3w6cxfbrFp4nOT/17
         krdyE3k88xpi69EX/h717ywzEG8PHVUA38NBghKklr0dEW18XBF5L0P3OMfGT/gUfp1t
         /uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dy3Zw18GEppEcc1iAhwMaVLBwUsp6JGihw3ZTsB5tVQ=;
        b=GZLc0MJMtS6cAmLnEZ4WFoxJSzuM/DybirCnqZAzrTSWDrOYCYsd4rSWXQwrtwnA15
         3dPloyhzd0WYay3zWUURvbbLCEJsL45pU1cNTOH0WPfuW/Maws54NgfsTb3rUBdy2Zpi
         7sWXNJfk9VgvcnIFkO4CZGbx9NYpAGVA6be14vDsW5VtDezTRGyYwqpCmHRR5t1yLv/Y
         35aZ8AbWtPSZAfsOmhaylIkOt5oV1TIYYAOIgwSIkmrpaRTobpJ/y1gNFxi4MKaTGKp2
         NQx4ixIxgbD7DeKb/czkosrhDeSwkFhoTI9+Q3l6ay4ZlJc88ykDNKc15dUelpByGL9y
         EHhg==
X-Gm-Message-State: APjAAAUrLd6Zfp3XVGTwDbClIzQBG2rmWzflQxI2fupZkZuhlcM5U92R
        j0wWpqVFCVwfKNA9AxAEt/F1vJOWgsoB7I9H8F5neg==
X-Google-Smtp-Source: APXvYqw2kmr/12+ak6WtssvgaCtbI0qRG4WNsBE8aNzHSc2M/yIfjbvn1xC161xrOwAVOePFkObTgq/OP+/s9HHRbK8=
X-Received: by 2002:aca:57d7:: with SMTP id l206mr4246587oib.32.1573143390886;
 Thu, 07 Nov 2019 08:16:30 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <20191105162424.GH30717@redhat.com> <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
 <20191107083902.GB3247@linux.ibm.com> <CAKOZuevhEXpMr49KmkBLEyMGsDz8WujKvOGCty8+p7cwVbmoXA@mail.gmail.com>
 <20191107153801.GF17896@redhat.com>
In-Reply-To: <20191107153801.GF17896@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 7 Nov 2019 08:15:53 -0800
Message-ID: <CAKOZueuKttjyRBgMkaBknzn+fzufZA+gJcd5wnKgiwmO37yN1g@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 7, 2019 at 7:38 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
> On Thu, Nov 07, 2019 at 12:54:59AM -0800, Daniel Colascione wrote:
> > On Thu, Nov 7, 2019 at 12:39 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > On Tue, Nov 05, 2019 at 08:41:18AM -0800, Daniel Colascione wrote:
> > > > On Tue, Nov 5, 2019 at 8:24 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
> > > > > The long term plan is to introduce UFFD_FEATURE_EVENT_FORK2 feature
> > > > > flag that uses the ioctl to receive the child uffd, it'll consume more
> > > > > CPU, but it wouldn't require the PTRACE privilege anymore.
> > > >
> > > > Why not just have callers retrieve FDs using recvmsg? This way, you
> > > > retrieve the message packet and the file descriptor at the same time
> > > > and you don't need any appreciable extra CPU use.
> > >
> > > I don't follow you here. Can you elaborate on how recvmsg would be used in
> > > this case?
> >
> > Imagine an AF_UNIX SOCK_DGRAM socket. You call recvmsg(). You get a
> > blob of regular data along with some ancillary data. The ancillary
> > data may include some file descriptors or it may not. Isn't the UFFD
> > message model the same thing? You'd call recvmsg() on a UFFD and get
> > back a uffd_msg data structure. If that uffd_msg came with file
> > descriptors, these descriptors would be in ancillary data. If you
> > didn't reserve enough space for the message or enough space for its
> > ancillary data, the recvmsg() call would fail cleanly with MSG_TRUNC
> > or MSG_CTRUNC.
>
> Having to check for truncation is just a slowdown doesn't sound a
> feature here but just a complication and unnecessary branches. You can
> already read as much as you want in multiples of the uffd size.

You're already paying for bounds checking. Receiving a message via a
datagram socket is basically the same thing as what UFFD's read is
doing anyway.

> > The nice thing about using recvmsg() for this purpose is that there's
> > tons of existing code for dealing with recvmsg()'s calling convention
> > and its ancillary data. You can, for example, use recvmsg out of the
> > box in a Python script. You could make an ioctl that also returned a
> > data blob plus some optional file descriptors, but if recvmsg already
> > does exactly that job and it's well-understood, why not just reuse the
> > recvmsg interface?
>
> uffd can't become an plain AF_UNIX because on the other end there's no
> other process but the kernel. Even if it could the fact it'd
> facilitate a pure python backend isn't relevant because handling page
> faults is a performance critical system activity, and rust can do the
> ioctl like it can do poll/epoll without mio/tokyo by just calling
> glibc. We can't write kernel code in python either for the same
> reason.

My point isn't "hey, you should write this in Python". (Although for
prototyping, why not?) My point is that where there's an existing
kernel interface for exactly the functionality you want, you should
use it instead of inventing some new thing, because when we use the
same interface for things have the same shape and purpose, we not only
get to reuse code, but also the knowledge in people's heads.

> > point is only that *from a userspace API* point of view, recvmsg()
> > seems ideal.
>
> Now thinking about this, the semantics of the ancillary data seems to
> be per socket family. So what does prevent you to create an AF_UNIX
> socket, send it to a SCM_RIGHTS receiving daemon unaware that it is
> getting an AF_UNIX socket. The daemon is calling recvmsg on the fd it
> receives from SCM_RIGHTS in order to receive ancillary data from
> another non-AF_UNIX family instead (it is irrelevant what the
> semantics of the ancillary data are but they're not AF_UNIX). So the
> daemon calls recvmsg and it will not understand that the fd in the
> ancillary data represents an installed "fd" in the fd space and in
> turn still gets the fd involuntary installed with the exact same side
> effects of what we're fixing in the uffd fork event read?

SCM_RIGHTS (AFAIK) is the only bit of ancillary data which indicates
that the kernel has created a file descriptor in the process doing the
recvmsg.

> I guess there shall be something somewhere that prevents recvmsg to
> run on anything but an AF_UNIX if msg_control isn't NULL and
> msg_controllen > 0? Otherwise even if we implemented the uffd fork
> event with recvmsg, we would be back to square one.

Why would we limit recvmsg to AF_UNIX? We can receive ancillary data
on other sockets, e.g., netlink. SCM_RIGHTS works only with AF_UNIX
right now, but this limitation isn't written in stone.

> As a corollary this could also imply we don't need the ptrace check
> after all if the same thing can happen already to SCM_RIGHTS receiving
> daemon expecting to receive ancillary data from AF_SOMETHING but
> getting an AF_UNIX instead through SCM_RIGHTS (just like the uffd
> example was expecting to call read() on a normal fd and instead it got
> an uffd).

Programs generally don't go calling recvmsg() on random FDs they get
from the outside world. They do call read() on those FDs, which is why
read() having unexpected side effects is terrible.

> I'm sure there's something stopping SCM_RIGHTS to have the same
> pitfalls of uffd event fork and that makes recvmsg safe unlike read()
> but then it's not immediately clear what it is.

If you call it with a non-empty ancillary data buffer, you know to
react to what you get. You're *opting into* the possibility of getting
file descriptors. Sure, it's theoretically possible that a program
calls recvmsg on random FDs it gets from unknown sources, sees
SCM_RIGHTS unexpectedly, and just the SCM_RIGHTS message and its FD
payload, but that's an outright bug, while calling read() on stdin is
no bug.

Anyway, IMHO, UFFD should be a netlink-like SOCK_DGRAM socket that
sends FDs with SCM_RIGHTS. This interface is already very efficient --
people have been optimizing the hell out of AF_UNIX for decades ---
and this interface provides exactly the right interface semantics for
what UFFD needs to do.
