Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE2F6A71
	for <lists+linux-api@lfdr.de>; Sun, 10 Nov 2019 18:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfKJRDA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 10 Nov 2019 12:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfKJRDA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 10 Nov 2019 12:03:00 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 587F4215EA
        for <linux-api@vger.kernel.org>; Sun, 10 Nov 2019 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573405378;
        bh=pSeXm6yKPXM8KICy539nNqlx3ZoB9BmuMvt3DzyzaJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pNmP89t6/3UltSEaHmzEQcrSsB8eq0QVowXgCBrc3HTK67lAI9Ph5+ymiuklkhBpS
         OIJi/bNCyvWlF2k1fqGYjLZidYsNDT0jzTKP2sxTKR2nn3TCQQDdfgL8m7BmHo+0XP
         53CgO/Rnm+lCwF8CnomAZYLoJJ1K9jEHVwHEJrrI=
Received: by mail-wr1-f54.google.com with SMTP id t1so12133127wrv.4
        for <linux-api@vger.kernel.org>; Sun, 10 Nov 2019 09:02:58 -0800 (PST)
X-Gm-Message-State: APjAAAWZlXSHhMNYlvu4H0+EgjazWJswcxstk36nSyt4e8+rkdkbuYK1
        RV4oPyqJQbk39kwYVNjy+wSxNkfOlfrwNJMHa1VIMA==
X-Google-Smtp-Source: APXvYqyYzUPhiqfXwzcPJTU6zTkbgbymZq2AhGrblxV8kTPlAwr0NyntKs90KtD5lBqiESCXkhnTuV2LAbz8I2ffWxg=
X-Received: by 2002:a5d:490b:: with SMTP id x11mr14759004wrq.111.1573405376752;
 Sun, 10 Nov 2019 09:02:56 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <20191105162424.GH30717@redhat.com> <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
 <20191107083902.GB3247@linux.ibm.com> <CAKOZuevhEXpMr49KmkBLEyMGsDz8WujKvOGCty8+p7cwVbmoXA@mail.gmail.com>
 <20191107153801.GF17896@redhat.com> <CAKOZueuKttjyRBgMkaBknzn+fzufZA+gJcd5wnKgiwmO37yN1g@mail.gmail.com>
 <20191107182259.GK17896@redhat.com>
In-Reply-To: <20191107182259.GK17896@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 10 Nov 2019 09:02:45 -0800
X-Gmail-Original-Message-ID: <CALCETrWxkzp5mzoqq28cbZLmwYh-k_er-8ocVoLPXXUk66Yprg@mail.gmail.com>
Message-ID: <CALCETrWxkzp5mzoqq28cbZLmwYh-k_er-8ocVoLPXXUk66Yprg@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
>
> Ultimately if we strip away the skbs for performance reasons, there
> wouldn't be much code to share, so if the only benefit would be to
> call recvmsg which would still be as insecure as read for the "worse"
> case than suid, so I don't see the point.

Not sure what you mean.

>
> And should then eventfd also become a netlink then? I mean uffd was
> supposed to work like eventfd except it requires specialized events.

No. None of this even means that these objects should be sockets per
se.  The point is that anyone who calls recvmsg() and passes a control
buf *must* handle SCM_RIGHTS because even very old Unixes can
materialize file descriptors.  The only exception is if the program
knows a priori that the fd refers to a socket that can't use
SCM_RIGHTS.

In other words, failing to handle file descriptors returned by
recvmsg() is an application bug.  Failing to handle file descriptors
returned by read() is not an application bug -- it's a kernel bug.

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
>

You've misunderstood what you're quoting me as saying.  I'm saying
that the issue is worse if you pass the userfaultfd via SCM_RIGHTS to
an unsuspecting program.  It is perfectly valid to receive a file
descriptor via SCM_RIGHTS and then call read(), at least so long as
you are okay with potentially blocking.

If you receive a fd to a socket using SCM_RIGHTS and then you fail to
check cmsg_type as above, then you have a bug regardless of
userfaultfd.

--Andy
