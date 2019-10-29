Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD01E8ABC
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 15:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbfJ2O02 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 10:26:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41747 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfJ2O02 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 10:26:28 -0400
Received: from [91.217.168.176] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iPSS0-0003ey-E8; Tue, 29 Oct 2019 14:26:24 +0000
Date:   Tue, 29 Oct 2019 15:26:23 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>, Florian Weimer <fweimer@redhat.com>
Cc:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
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
Message-ID: <20191029142622.jxmssu4s4ndui7bw@wittgenstein>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <CAG48ez3q=BeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0neheT17TA@mail.gmail.com>
 <20191028172143.4vnnjpdljfnexaq5@wittgenstein>
 <CAG48ez20hn8vToY+=C62nA-rbUfxh=JD6N-f7XVS3_GZOoPjxw@mail.gmail.com>
 <20191029112706.p5dd5yzpcgouo6n5@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191029112706.p5dd5yzpcgouo6n5@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 12:27:07PM +0100, Christian Brauner wrote:
> On Mon, Oct 28, 2019 at 08:09:13PM +0100, Jann Horn wrote:
> > On Mon, Oct 28, 2019 at 6:21 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > On Mon, Oct 28, 2019 at 04:12:09PM +0100, Jann Horn wrote:
> > > > On Fri, Oct 25, 2019 at 6:59 PM Michael Kerrisk (man-pages)
> > > > <mtk.manpages@gmail.com> wrote:
> > > > > I've made a first shot at adding documentation for clone3(). You can
> > > > > see the diff here:
> > > > > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=faa0e55ae9e490d71c826546bbdef954a1800969
> > [...]
> > > > You might want to note somewhere that its flags can't be
> > > > seccomp-filtered because they're stored in memory, making it
> > > > inappropriate to use in heavily sandboxed processes.
> > >
> > > Hm, I don't think that belongs on the clone manpage. Granted that
> > > process creation is an important syscall but so are a bunch of others
> > > that aren't filterable because of pointer arguments.
> > > We can probably mention on the seccomp manpage that seccomp can't filter
> > > on pointer arguments and then provide a list of examples. If you setup a
> > > seccomp filter and don't know that you can't filter syscalls with
> > > pointer args that seems pretty bad to begin with.
> > 
> > Fair enough.
> > 
> > [...]
> > > One thing I never liked about clone() was that userspace had to know
> > > about stack direction. And there is a lot of ugly code in userspace that
> > > has nasty clone() wrappers like:
> > [...]
> > > where stack + stack_size is addition on a void pointer which usually
> > > clang and gcc are not very happy about.
> > > I wanted to bring this up on the mailing list soon: If possible, I don't
> > > want userspace to need to know about stack direction and just have stack
> > > point to the beginning and then have the kernel do the + stack_size
> > > after the copy_clone_args_from_user() if the arch needs it. For example,
> > > by having a dumb helder similar to copy_thread_tls()/coyp_thread() that
> > > either does the + stack_size or not. Right now, clone3() is supported on
> > > parisc and afaict, the stack grows upwards for it. I'm not sure if there
> > > are obvious reasons why that won't work or it would be a bad idea...
> > 
> > That would mean adding a new clone flag that redefines how those
> > parameters work and describing the current behavior in the manpage as
> > the behavior without the flag (which doesn't exist on 5.3), right?
> 
> I would break API and if someone reports breakage we'll revert and go
> the more complicated route you outlined (see [1]).

@Jann, I think the following patch might even be enough?...

@Florian, do you have an opinion about always passing the stack from the
lowest address with clone3()?

From 72b2a5711fd37e34e87df1b29b2e1885bb28cf75 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 29 Oct 2019 13:55:39 +0100
Subject: [PATCH] fork: stack direction

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/fork.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index bcdf53125210..22dc72071a6d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2584,6 +2584,13 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
 	return true;
 }
 
+static inline void clone3_prepare_stack(struct kernel_clone_args *kargs)
+{
+#if !defined(CONFIG_STACK_GROWSUP) && !defined(CONFIG_IA64)
+	kargs->stack += kargs->stack_size;
+#endif
+}
+
 /**
  * clone3 - create a new process with specific properties
  * @uargs: argument structure
@@ -2605,6 +2612,8 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
 	if (err)
 		return err;
 
+	clone3_prepare_stack(&kargs);
+
 	if (!clone3_args_valid(&kargs))
 		return -EINVAL;
 
-- 
2.23.0
