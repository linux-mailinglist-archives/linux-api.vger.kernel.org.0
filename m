Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5CF3794
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 19:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfKGSvI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 13:51:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36442 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfKGSvH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 13:51:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id m6so2425476lfl.3
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkjehHi85xXIeAmqIsUNqDZH/jMBWhdTR0KFAEgoRF8=;
        b=imXRr7GkNBwE8ssccen69v7UhBqSwcwGow4PL5eAl5Sy1Trg5deD9ZqHW5uxKlPXC1
         uG/d+bxygT/JQ9w+Y5zg1sql1eG626hOr0sakmOa65SQ5aX0CgesEw4UkCFKIaSts5n2
         SNaz5EtU2ZimdRB9GsKU4CSZq+3JLRfpLiRCBVyimidejxy2kx3Y7tPyb7lSol8dPrZU
         ld//gWqzftCmma1zPviuPalW3bRZ7YwvpSYsJfqD/jVZYWB99pmo4CibY2Lqw+pYxH9z
         2wZfQr8bbFfDFeGcTtZda30u7mG1zAJp4s7qt3sZKLo+G9BF3YNezXUKnyjoDhs3sQk3
         MCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkjehHi85xXIeAmqIsUNqDZH/jMBWhdTR0KFAEgoRF8=;
        b=iMJ+OngaFdW3eQpWASFEHsZ9EerZSjZZ4XsaSQXYXCZtMkanvFoSWmFlE1arNYb8P4
         Zdv40a/POGpPXOx6i/7r3ORdhbVTl9zujDsgmQQ2TMaeUJfIbDKEyZk+faKjIzbIIGI9
         3BScDzq6Ahbt5wvHjBFd4fRmKQDqKH5yudPaZ267kA/64RQZgx0RxzHMxI4O4Mf7Xnqh
         avMx9jW1pMNYUP7h+/kTQf/OIXOnWa8Siv8h6kTyAwNzoyF7pNVGkrEcmKXbFE/SWg47
         XYFXmETvxCbdKLAR5nLEokK/9LSNWkTREf3h71Prn7iB1+7kDNGodk/8tNY9krkk1CQq
         2wyA==
X-Gm-Message-State: APjAAAWN/eIy3gUqfwWrJxuxul6/Uo5fCO4XpCB4Ez6/VbufVa1jnLB+
        XtgDre5Kpb+zrplnYPaX+jjUivISPiZPwN6ufmuy0A==
X-Google-Smtp-Source: APXvYqyZmBlZ7Vly31efZ2QfWsCmfS3gd13tsQl1GGTIQ6M6H9fjnHhExntc9rdQWbhY0UeooAYZmOYtDfZsPGG75uM=
X-Received: by 2002:ac2:5453:: with SMTP id d19mr3539669lfn.181.1573152662534;
 Thu, 07 Nov 2019 10:51:02 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <20191105162424.GH30717@redhat.com> <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
 <20191107083902.GB3247@linux.ibm.com> <CAKOZuevhEXpMr49KmkBLEyMGsDz8WujKvOGCty8+p7cwVbmoXA@mail.gmail.com>
 <20191107153801.GF17896@redhat.com> <CAKOZueuKttjyRBgMkaBknzn+fzufZA+gJcd5wnKgiwmO37yN1g@mail.gmail.com>
 <20191107182259.GK17896@redhat.com>
In-Reply-To: <20191107182259.GK17896@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 7 Nov 2019 10:50:26 -0800
Message-ID: <CAKOZueubtyuTZC5zPTL3qDpVS5RFYFMqx727Bj4fjMHDSY5rMg@mail.gmail.com>
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

On Thu, Nov 7, 2019 at 10:23 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Thu, Nov 07, 2019 at 08:15:53AM -0800, Daniel Colascione wrote:
> > You're already paying for bounds checking. Receiving a message via a
> > datagram socket is basically the same thing as what UFFD's read is
> > doing anyway.
>
> Except it's synchronous and there are no dynamic allocations required
> in uffd, while af_netlink and af_unix both all deal with queue of
> events in skbs dynamically allocated.

Do you have any evidence that skb allocation is a significant cost
compared to a page fault and schedule? Regardless: if you don't want
to use skbs, don't. My point is that recvmsg is the ideal interface
for UFFD and i'm agnostic on the implementation of this interface.

> And should then eventfd also become a netlink then? I mean uffd was
> supposed to work like eventfd except it requires specialized events.

You've raised eventfd as a model for UFFD on several occasions. I
don't think eventfd is a good reference point. An eventfd is a single
object with 64 bits of state. It can notify interested parties in
changes to that state. Eventfd does not provide a queue. UFFD,
however, *is* a queue. It provides an arbitrary number of state change
notifications to a reader. In this way, UFFD is much more like a
socket than it's like eventfd. That is, eventfd is about level-change
notifications, but UFFD is about sending messages.

> > Programs generally don't go calling recvmsg() on random FDs they get
> > from the outside world. They do call read() on those FDs, which is why
>
> That programs generally don't do something only means the attack is
> less probable.
>
> Programs generally aren't suid. Programs generally don't use
> SCM_RIGHTS. Programs generally don't ignore the retval of
> open/socket/uffd syscalls. Programs generally don't make assumptions
> on the fd ID after one of those syscalls that install fds.
>
> If all programs generally do the right thing (where the most important
> is to not make assumptions on the fd IDs and to check all syscall
> retvals), there was never an issue to begin with even in uffd API.

"The right thing" is a matter of contracts. If a program calls read()
and behaves as if read() has  only the effects read() is documented to
have, that means that from the kernel's point of view, the program is
doing the right thing. That you think certain practices are more
prudent than others is irrelevant here. UFFD is a violation of
read()'s *contract* and so if programs break after calling read(),
it's the *kernel*'s fault.

> > read() having unexpected side effects is terrible.
>
> If having unexpected side effects in read is "terrible" (i.e. I
> personally prefer to use terms like terrible when there's at least
> something that can be exploited in practice, not for theoretical
> issues) for an SCM_RIGHTS receiving daemon, I just don't see how the
> exact same unexpected (still theoretical) side effects in recvmsg with
> an unexpected nested cmsg->cmsg_type == SCM_RIGHTS message being
> returned, isn't terrible too.

If a program calls recvmsg on an FD of unknown provenance, it *must*
be prepared to receive file descriptors via SCM_RIGHTS. If it doesn't,
it's a bug. The contract the kernel makes with userspace for recvmsg()
includes the possibility of creating file descriptors. The contract
the kernel makes with userspace for read() does not ordinarily involve
creating file descriptors, so if the kernel does in fact do that, it's
the kernel's problem.

> > If you call it with a non-empty ancillary data buffer, you know to
> > react to what you get. You're *opting into* the possibility of getting
> > file descriptors. Sure, it's theoretically possible that a program
> > calls recvmsg on random FDs it gets from unknown sources, sees
> > SCM_RIGHTS unexpectedly, and just the SCM_RIGHTS message and its FD
> > payload, but that's an outright bug, while calling read() on stdin is
> > no bug.
>
> I'm not talking about stdin and suid. recvmsg might mitigate the
> concern for suid (not certain, depends on the suid, if it's generally
> doing what you expect most suid to be doing or not), I was talking
> about the SCM_RIGHTS receiving daemon instead, the "worse" more
> concerning case than the suid.
>
> I quote below Andy's relevant email:
>
> ======
> It's worse if SCM_RIGHTS is involved.
> ======
>
> Not all software will do this after calling recvmsg:
>
>     if (cmsg->cmsg_type == SCM_RIGHTS) {
>       /* oops we got attacked and an fd was involountarily installed
>          because we received another AF_UNIX from a malicious attacker
>          in control of the other end of the SCM_RIGHTS-receiving
>          AF_UNIX connection instead of our expected socket family
>          which doesn't even support SCM_RIGHTS so we would never have
>          noticed an fd was installed after recvmsg */
>     }

If a program omits this code after calling recvmsg on a file
descriptor of unknown provenance and the program breaks, it's the
program's fault. It's reasonable to epect that recvmsg might create
file descriptors if you call it on an unknown FD. It's unreasonable to
expect a program to consider the possibility of read() creating file
descriptors because read isn't documented to do that.

>
