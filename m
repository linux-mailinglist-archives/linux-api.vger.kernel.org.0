Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887E5E8C5F
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 17:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbfJ2QFc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 12:05:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45836 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfJ2QFb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 12:05:31 -0400
Received: from [91.217.168.176] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iPTzr-0008CT-3h; Tue, 29 Oct 2019 16:05:27 +0000
Date:   Tue, 29 Oct 2019 17:05:26 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: For review: documentation of clone3() system call
Message-ID: <20191029160525.2zn6vnnyai5ahdj3@wittgenstein>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <CAG48ez3q=BeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0neheT17TA@mail.gmail.com>
 <20191028172143.4vnnjpdljfnexaq5@wittgenstein>
 <CAG48ez20hn8vToY+=C62nA-rbUfxh=JD6N-f7XVS3_GZOoPjxw@mail.gmail.com>
 <20191029112706.p5dd5yzpcgouo6n5@wittgenstein>
 <20191029142622.jxmssu4s4ndui7bw@wittgenstein>
 <CAG48ez1pH9fGacQF6m7=R39bDMRqNR_ML7d2v-e=-kVLJhBuPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1pH9fGacQF6m7=R39bDMRqNR_ML7d2v-e=-kVLJhBuPA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 04:20:37PM +0100, Jann Horn wrote:
> On Tue, Oct 29, 2019 at 3:26 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Tue, Oct 29, 2019 at 12:27:07PM +0100, Christian Brauner wrote:
> > > On Mon, Oct 28, 2019 at 08:09:13PM +0100, Jann Horn wrote:
> > > > On Mon, Oct 28, 2019 at 6:21 PM Christian Brauner
> > > > <christian.brauner@ubuntu.com> wrote:
> > > > > where stack + stack_size is addition on a void pointer which usually
> > > > > clang and gcc are not very happy about.
> > > > > I wanted to bring this up on the mailing list soon: If possible, I don't
> > > > > want userspace to need to know about stack direction and just have stack
> > > > > point to the beginning and then have the kernel do the + stack_size
> > > > > after the copy_clone_args_from_user() if the arch needs it. For example,
> > > > > by having a dumb helder similar to copy_thread_tls()/coyp_thread() that
> > > > > either does the + stack_size or not. Right now, clone3() is supported on
> > > > > parisc and afaict, the stack grows upwards for it. I'm not sure if there
> > > > > are obvious reasons why that won't work or it would be a bad idea...
> > > >
> > > > That would mean adding a new clone flag that redefines how those
> > > > parameters work and describing the current behavior in the manpage as
> > > > the behavior without the flag (which doesn't exist on 5.3), right?
> > >
> > > I would break API and if someone reports breakage we'll revert and go
> > > the more complicated route you outlined (see [1]).
> >
> > @Jann, I think the following patch might even be enough?...
> [...]
> > +static inline void clone3_prepare_stack(struct kernel_clone_args *kargs)
> > +{
> > +#if !defined(CONFIG_STACK_GROWSUP) && !defined(CONFIG_IA64)
> > +       kargs->stack += kargs->stack_size;
> > +#endif
> > +}
> 
> I guess it might work as long as nobody is actually using clone3 yet
> and you can get this patch into the 5.3 stable tree and any distro
> kernels on 5.3 before people do start using clone3?

Yes, that would be my preferred approach. As I said doing it this way is
pretty common. A recent example where we did this is the file_max
sysctl.

Christian
