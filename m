Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A46E2538
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 23:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392129AbfJWVZu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 17:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407500AbfJWVZu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 Oct 2019 17:25:50 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBB2222BE
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571865949;
        bh=YaJ5EMettNl2MRhvjPY7Zn9r4Nj39GyLbVZCpxRItLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1V9uM3+PyveNNb8Jwxgm5uovWimS6VRLFaIBFVUjKmtPMB6n0DHkEGMqnkVDoprzm
         EUbOAXwqhZzveNbA/trpSKy3kiAfi7dRBAJcZVwIxROZnPo/BkcSRO1P9DbsRAgsYz
         qb9+fM1ZjoJc1yKItbXBngxbx2ms6V72bhlRSZTU=
Received: by mail-wm1-f45.google.com with SMTP id 6so568443wmf.0
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 14:25:48 -0700 (PDT)
X-Gm-Message-State: APjAAAVEdYYOlGHElnhjJtj7qVFT9tBDHpP3CNbn5PGonGcMnOxp4OgW
        8c5w+g7OM7bc8wvyXoBvYWWiOK2uRRzkhkx/CiLKrQ==
X-Google-Smtp-Source: APXvYqzDhz05GfKuPVJ0lFj8rX0SmLt2uNDoHXCnXcwvIrQD/5AUdG1f6wN5ePJMnqV5Eko2QiOL3rkFj9652KYjMRs=
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr1591999wmk.173.1571865947075;
 Wed, 23 Oct 2019 14:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
 <20191023190959.GA9902@redhat.com> <CALCETrWY+5ynDct7eU_nDUqx=okQvjm=Y5wJvA4ahBja=CQXGw@mail.gmail.com>
 <20191023211645.GC9902@redhat.com>
In-Reply-To: <20191023211645.GC9902@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Oct 2019 14:25:35 -0700
X-Gmail-Original-Message-ID: <CALCETrVS_Ym9wpvTP-ys-OBKCgg7QQjPdhJZe5YXJ6e8JQkNQQ@mail.gmail.com>
Message-ID: <CALCETrVS_Ym9wpvTP-ys-OBKCgg7QQjPdhJZe5YXJ6e8JQkNQQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 23, 2019 at 2:16 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Wed, Oct 23, 2019 at 12:21:18PM -0700, Andy Lutomirski wrote:
> > There are two things going on here.
> >
> > 1. Daniel wants to add LSM labels to userfaultfd objects.  This seems
> > reasonable to me.  The question, as I understand it, is: who is the
> > subject that creates a uffd referring to a forked child?  I'm sure
> > this is solvable in any number of straightforward ways, but I think
> > it's less important than:
>
> The new uffd created during fork would definitely need to be accounted
> on the criu monitor, nor to the parent nor the child, so it'd need to
> be accounted to the process/context that has the fd in its file
> descriptors array. But since this is less important let's ignore this
> for a second.
>
> > 2. The existing ABI is busted independently of #1.  Suppose you call
> > userfaultfd to get a userfaultfd and enable UFFD_FEATURE_EVENT_FORK.
> > Then you do:
> >
> > $ sudo <&[userfaultfd number]
> >
> > Sudo will read it and get a new fd unexpectedly added to its fd table.
> > It's worse if SCM_RIGHTS is involved.
>
> So the problem is just that a new fd is created. So for this to turn
> out to a practical issue, it requires finding a reckless suid that
> won't even bother checking the return value of the open/socket
> syscalls or some equivalent fd number related side effect. All right
> that makes more sense now and of course I agree it needs fixing.

Or it requires a long-lived daemon that receives fds over SCM_RIGHTS
and reads from them.

>
> > So I think we either need to declare that UFFD_FEATURE_EVENT_FORK is
> > only usable by global root or we need to remove it and maybe re-add it
> > in some other form.
>
> If I had a time machine, I'd rather prefer to do the below:
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index fe6d804a38dc..574062051678 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1958,7 +1958,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>                 return -ENOMEM;
>
>         refcount_set(&ctx->refcount, 1);
> -       ctx->flags = flags;
> +       ctx->flags = flags | UFFD_CLOEXEC;

That doesn't solve the problem.  With your time machine, you should
instead use ioctl() or recvmsg().

>
> 4) enforce the global root permission check when creating the uffd only if
>    UFFD_FEATURE_EVENT_FORK is set.

This could work, but we should also add a better way to do
UFFD_FEATURE_EVENT_FORK and get CRIU to start using it.  If CRIU is
the only user, we can probably drop the old ABI after a couple of
releases, since as far as I know, CRIU users need to upgrade their
CRIU more or less in sync with the kernel so that new kernel features
get checkpointed and restored.
