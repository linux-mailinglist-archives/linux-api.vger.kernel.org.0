Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A6161DA4
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2020 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgBQXDi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Feb 2020 18:03:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56717 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgBQXDi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Feb 2020 18:03:38 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j3pQK-0001Ar-JZ; Mon, 17 Feb 2020 23:03:32 +0000
Date:   Tue, 18 Feb 2020 00:03:31 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        x86@kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: Time Namespaces: CLONE_NEWTIME and clone3()?
Message-ID: <20200217230331.he6p5bs766zp6smx@wittgenstein>
References: <20191112012724.250792-1-dima@arista.com>
 <20191112012724.250792-4-dima@arista.com>
 <CAHO5Pa2_7BzZPCXjFj4f=YoX28M4q2Au=h6GrzN-EjRffMo1iw@mail.gmail.com>
 <20200217145908.7epzz5nescccwvzv@wittgenstein>
 <CAKgNAkjfdWFwNdFzdBY81_8WZJNtbtztfjO9T2YNQDV4ThNiNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgNAkjfdWFwNdFzdBY81_8WZJNtbtztfjO9T2YNQDV4ThNiNw@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 17, 2020 at 10:47:53PM +0100, Michael Kerrisk (man-pages) wrote:
> Hello Christian,
> 
> On Mon, 17 Feb 2020 at 16:15, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Mon, Feb 17, 2020 at 03:20:55PM +0100, Michael Kerrisk wrote:
> > > Hello Dmitry, Andrei,
> > >
> > > Is the CLONE_NEWTIME flag intended to be usable with clone3()? The
> > > mail quoted below implies (in my reading) that this should be possible
> > > once clone3() is available, which it is by now. (See also [1].)
> > >
> > > If the answer is yes, CLONE_NEWTIME  should be usable with clone3(),
> > > then I have a bug report and a question.
> > >
> > > I successfully used CLONE_NEWTIME with unshare(). But if I try to use
> > > CLONE_NEWSIGNAL with clone3(), it errors out with EINVAL, because of
> >
> > s/CLONE_NEWSIGNAL/CLONE_NEWTIME/
> >
> > > the following check in clone3_args_valid():
> > >
> > >         /*
> > >          * - make the CLONE_DETACHED bit reuseable for clone3
> > >          * - make the CSIGNAL bits reuseable for clone3
> > >          */
> > >         if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
> > >                 return false;
> > >
> > > The problem is that CLONE_NEWTIME matches one of the bits in the
> > > CSIGNAL mask. If the intention is to allow CLONE_NEWTIME with
> > > clone3(), then either the bit needs to be redefined, or the error
> > > checking in clone3_args_valid() needs to be reworked.
> >
> > If this is intended to be useable with clone3() the check should be
> > adapted to allow for CLONE_NEWTIME. (I asked about this a while ago I
> > think.)
> > But below rather sounds like it should simply be an unshare() flag. The
> > code seems to set frozen_offsets to true right after copy_namespaces()
> > in timens_on_fork(new_ns, tsk) and so the offsets can't be changed
> > anymore unless I'm reading this wrong.
> > Alternatives seem to either make timens_offsets writable once after fork
> > and before exec, I guess - though that's probably not going to work
> > with the vdso judging from timens_on_fork().
> >
> > The other alternative is that Andrei and Dmitry send me a patch to
> > enable CLONE_NEWTIME with clone3() by exposing struct timens_offsets (or
> > a version of it) in the uapi and extend struct clone_args to include a
> > pointer to a struct timens_offset that is _only_ set when CLONE_NEWTIME
> > is set.
> > Though the unshare() way sounds way less invasive simpler.
> 
> Actually, I think the alternative you propose just here is better. I
> imagine there are times when one will want to create multiple
> namespaces with a single call to clone3(), including a time namespace.
> I think this should be allowed by the API. And, otherwise, clone3()
> becomes something of a second-class citizen for creating namespaces.
> (I don't really get the "less invasive" argument. Implementing this is
> just a piece of kernel to code to make user-space's life a bit simpler
> and more consistent.)

I don't particularly mind either way. If there's actual users that need
to set it at clone3() time then we can extend it. So I'd like to hear
what Adrian, Dmitry, and Thomas think since they are well-versed how
this will be used in the wild. I'm weary of exposing a whole new uapi
struct and extending clone3() without any real use-case but I'm happy to
if there is!

Christian
