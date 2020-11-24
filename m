Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328132C2F12
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 18:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403947AbgKXRoS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 12:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403801AbgKXRoS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 24 Nov 2020 12:44:18 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00ED0206C0;
        Tue, 24 Nov 2020 17:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606239857;
        bh=v+FR2vsqTxzK3OgbBpZnkhLlhZ4CTkbjlxr8puXVyvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ny+JkgHru82bk7v6yGs1akrkgaJrKXD4qCmUTKrpr8OFyjxO6Dk526RqbzcEnqu+l
         Krv6v9e/kqN623EmVjPbCFNYfwYJYgO8a9mm5nNOaN5mW6OPWfydPyxwEdZ8ErPgv2
         8435/qTnkugbUDnQ5DNjX6yjrxOt+SSY7HXk+qHU=
Date:   Tue, 24 Nov 2020 18:44:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Mark Wielaard <mark@klomp.org>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        dev@opencontainers.org, Jonathan Corbet <corbet@lwn.net>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
Message-ID: <X71Gbko70D/jedAP@kroah.com>
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
 <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
 <878saq3ofx.fsf@oldenburg2.str.redhat.com>
 <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org>
 <20201124164546.GA14094@infradead.org>
 <CAG48ez2ZHPavVU3_2VnRADFQstOM1s+3GwfWsRaEjAA1jYcHDg@mail.gmail.com>
 <X70/uPNt2BA/vUSo@kroah.com>
 <CAG48ez2NH2Esw_55JiwK1FAzr_qFFyGaPrE_A=iH=dNuVvY6GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2NH2Esw_55JiwK1FAzr_qFFyGaPrE_A=iH=dNuVvY6GQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 06:30:28PM +0100, Jann Horn wrote:
> On Tue, Nov 24, 2020 at 6:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Tue, Nov 24, 2020 at 06:06:38PM +0100, Jann Horn wrote:
> > > +seccomp maintainers/reviewers
> > > [thread context is at
> > > https://lore.kernel.org/linux-api/87lfer2c0b.fsf@oldenburg2.str.redhat.com/
> > > ]
> > >
> > > On Tue, Nov 24, 2020 at 5:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > > On Tue, Nov 24, 2020 at 03:08:05PM +0100, Mark Wielaard wrote:
> > > > > For valgrind the issue is statx which we try to use before falling back
> > > > > to stat64, fstatat or stat (depending on architecture, not all define
> > > > > all of these). The problem with these fallbacks is that under some
> > > > > containers (libseccomp versions) they might return EPERM instead of
> > > > > ENOSYS. This causes really obscure errors that are really hard to
> > > > > diagnose.
> > > >
> > > > So find a way to detect these completely broken container run times
> > > > and refuse to run under them at all.  After all they've decided to
> > > > deliberately break the syscall ABI.  (and yes, we gave the the rope
> > > > to do that with seccomp :().
> > >
> > > FWIW, if the consensus is that seccomp filters that return -EPERM by
> > > default are categorically wrong, I think it should be fairly easy to
> > > add a check to the seccomp core that detects whether the installed
> > > filter returns EPERM for some fixed unused syscall number and, if so,
> > > prints a warning to dmesg or something along those lines...
> >
> > Why?  seccomp is saying "this syscall is not permitted", so -EPERM seems
> > like the correct error to provide here.  It's not -ENOSYS as the syscall
> > is present.
> >
> > As everyone knows, there are other ways to have -EPERM be returned from
> > a syscall if you don't have the correct permissions to do something.
> > Why is seccomp being singled out here?  It's doing the correct thing.
> 
> AFAIU from what the others have said, it's being singled out because
> it means that for two semantically equivalent operations (e.g.
> openat() vs open()), one can fail while the other works because the
> filter doesn't know about one of the syscalls. Normally semantically
> equivalent syscalls are supposed to be subject to the same checks, and
> if one of them fails, trying the other one won't help.

They aren't being subject to the same checks, if the seccomp permissions
are different for both of them, they will get different answers.

Trying to use this to determine if the syscall is present or not is not
ok, and as Christian just said, needs to be fixed in userspace.  We
can't change the kernel ABI now, odds are someone else relies on the api
we have had in place and it can not be changed :)

thanks,

greg k-h
