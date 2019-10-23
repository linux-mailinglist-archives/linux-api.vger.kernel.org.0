Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4CE10BD
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 06:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfJWELT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 00:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfJWELS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 Oct 2019 00:11:18 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5439521A4A
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 04:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571803877;
        bh=Gibqdh2Co8u4JylpxSaH4/x76GwQHMi9FG9hIlKKtek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yeiVt0pL096iSqYCKZeiQ9dctzQYy574QUj8xgZboFtW5nXfqGi4XxllH/ec2+sxf
         pzqoE68RFnb2hXuFHcK4N1D9Vu6+gTeRBSBwSFOfft4GDWGdnKafzZeRdW8VEBywM7
         05RhG1a8ayx+mQx1nleRif40EJxWMb56m+XcZzcQ=
Received: by mail-wr1-f47.google.com with SMTP id a11so4263132wra.6
        for <linux-api@vger.kernel.org>; Tue, 22 Oct 2019 21:11:17 -0700 (PDT)
X-Gm-Message-State: APjAAAUz5uOIlVJXyATdD0IRvzL7fxyv5/zQ2zmE/NbglMuxOw6ojZjK
        oxeUHoo/8brnA2i+IehmXUSUHjxgPI+/wjJHZsu6dA==
X-Google-Smtp-Source: APXvYqxNmV1lwxPxGnlytrDZFlyMjNhOxN6X9ZkZQPM6PGzlRFh30f+cYzArtw27U3+B4cK0+W1rFr1aTAQYBBpw/fA=
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr6102479wrx.111.1571803875660;
 Tue, 22 Oct 2019 21:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com> <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
In-Reply-To: <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 22 Oct 2019 21:11:04 -0700
X-Gmail-Original-Message-ID: <CALCETrX=1XUwsuKc6dinj3ZTnrK85m_+UL=iaYKj4EZtf-xm5g@mail.gmail.com>
Message-ID: <CALCETrX=1XUwsuKc6dinj3ZTnrK85m_+UL=iaYKj4EZtf-xm5g@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Trying again.  It looks like I used the wrong address for Pavel.

On Sat, Oct 12, 2019 at 6:14 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> [adding more people because this is going to be an ABI break, sigh]
>
> On Sat, Oct 12, 2019 at 5:52 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Sat, Oct 12, 2019 at 4:10 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> > > >
> > > > The new secure flag makes userfaultfd use a new "secure" anonymous
> > > > file object instead of the default one, letting security modules
> > > > supervise userfaultfd use.
> > > >
> > > > Requiring that users pass a new flag lets us avoid changing the
> > > > semantics for existing callers.
> > >
> > > Is there any good reason not to make this be the default?
> > >
> > >
> > > The only downside I can see is that it would increase the memory usage
> > > of userfaultfd(), but that doesn't seem like such a big deal.  A
> > > lighter-weight alternative would be to have a single inode shared by
> > > all userfaultfd instances, which would require a somewhat different
> > > internal anon_inode API.
> >
> > I'd also prefer to just make SELinux use mandatory, but there's a
> > nasty interaction with UFFD_EVENT_FORK. Adding a new UFFD_SECURE mode
> > which blocks UFFD_EVENT_FORK sidesteps this problem. Maybe you know a
> > better way to deal with it.
>
> ...
>
> > But maybe we can go further: let's separate authentication and
> > authorization, as we do in other LSM hooks. Let's split my
> > inode_init_security_anon into two hooks, inode_init_security_anon and
> > inode_create_anon. We'd define the former to just initialize the file
> > object's security information --- in the SELinux case, figuring out
> > its class and SID --- and define the latter to answer the yes/no
> > question of whether a particular anonymous inode creation should be
> > allowed. Normally, anon_inode_getfile2() would just call both hooks.
> > We'd add another anon_inode_getfd flag, ANON_INODE_SKIP_AUTHORIZATION
> > or something, that would tell anon_inode_getfile2() to skip calling
> > the authorization hook, effectively making the creation always
> > succeed. We can then make the UFFD code pass
> > ANON_INODE_SKIP_AUTHORIZATION when it's creating a file object in the
> > fork child while creating UFFD_EVENT_FORK messages.
>
> That sounds like an improvement.  Or maybe just teach SELinux that
> this particular fd creation is actually making an anon_inode that is a
> child of an existing anon inode and that the context should be copied
> or whatever SELinux wants to do.  Like this, maybe:
>
> static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
>                                   struct userfaultfd_ctx *new,
>                                   struct uffd_msg *msg)
> {
>         int fd;
>
> Change this:
>
>         fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
>                               O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
>
> to something like:
>
>       fd = anon_inode_make_child_fd(..., ctx->inode, ...);
>
> where ctx->inode is the one context's inode.
>
> *** HOWEVER *** !!!
>
> Now that you've pointed this mechanism out, it is utterly and
> completely broken and should be removed from the kernel outright or at
> least severely restricted.  A .read implementation MUST NOT ACT ON THE
> CALLING TASK.  Ever.  Just imagine the effect of passing a userfaultfd
> as stdin to a setuid program.
>
> So I think the right solution might be to attempt to *remove*
> UFFD_EVENT_FORK.  Maybe the solution is to say that, unless the
> creator of a userfaultfd() has global CAP_SYS_ADMIN, then it cannot
> use UFFD_FEATURE_EVENT_FORK) and print a warning (once) when
> UFFD_FEATURE_EVENT_FORK is allowed.  And, after some suitable
> deprecation period, just remove it.  If it's genuinely useful, it
> needs an entirely new API based on ioctl() or a syscall.  Or even
> recvmsg() :)
>
> And UFFD_SECURE should just become automatic, since you don't have a
> problem any more. :-p
>
> --Andy
