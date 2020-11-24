Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD68A2C2E5E
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 18:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbgKXRWB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 12:22:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33618 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731584AbgKXRWB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 12:22:01 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1khc0m-0001KZ-W8; Tue, 24 Nov 2020 17:21:53 +0000
Date:   Tue, 24 Nov 2020 18:21:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Mark Wielaard <mark@klomp.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        dev@opencontainers.org, Jonathan Corbet <corbet@lwn.net>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
Message-ID: <20201124172152.q5egylertvj3zp3w@wittgenstein>
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
 <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
 <878saq3ofx.fsf@oldenburg2.str.redhat.com>
 <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org>
 <20201124164546.GA14094@infradead.org>
 <CAG48ez2ZHPavVU3_2VnRADFQstOM1s+3GwfWsRaEjAA1jYcHDg@mail.gmail.com>
 <X70/uPNt2BA/vUSo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X70/uPNt2BA/vUSo@kroah.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 06:15:36PM +0100, Greg KH wrote:
> On Tue, Nov 24, 2020 at 06:06:38PM +0100, Jann Horn wrote:
> > +seccomp maintainers/reviewers
> > [thread context is at
> > https://lore.kernel.org/linux-api/87lfer2c0b.fsf@oldenburg2.str.redhat.com/
> > ]
> > 
> > On Tue, Nov 24, 2020 at 5:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > On Tue, Nov 24, 2020 at 03:08:05PM +0100, Mark Wielaard wrote:
> > > > For valgrind the issue is statx which we try to use before falling back
> > > > to stat64, fstatat or stat (depending on architecture, not all define
> > > > all of these). The problem with these fallbacks is that under some
> > > > containers (libseccomp versions) they might return EPERM instead of
> > > > ENOSYS. This causes really obscure errors that are really hard to
> > > > diagnose.
> > >
> > > So find a way to detect these completely broken container run times
> > > and refuse to run under them at all.  After all they've decided to
> > > deliberately break the syscall ABI.  (and yes, we gave the the rope
> > > to do that with seccomp :().
> > 
> > FWIW, if the consensus is that seccomp filters that return -EPERM by
> > default are categorically wrong, I think it should be fairly easy to
> > add a check to the seccomp core that detects whether the installed
> > filter returns EPERM for some fixed unused syscall number and, if so,
> > prints a warning to dmesg or something along those lines...
> 
> Why?  seccomp is saying "this syscall is not permitted", so -EPERM seems
> like the correct error to provide here.  It's not -ENOSYS as the syscall
> is present.
> 
> As everyone knows, there are other ways to have -EPERM be returned from
> a syscall if you don't have the correct permissions to do something.
> Why is seccomp being singled out here?  It's doing the correct thing.

The correct solution to this problem is simple: the standard and the
problematic container runtimes need to be fixed to return ENOSYS as I
said in my first mail. Imho, the kernel neither should need to log
anything or be opinionated about what error is correct or not. Imho,
this is a broken standard and that's where the story ends.

We've had that argument about ENOSYS being the correct errno in such
scenarios in userspace already and that's been ignored for _years_. Now,
as could be expected it's suddenly the kernel who's supposed to fix
this. That's totally wrong imho.

Christian
