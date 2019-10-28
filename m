Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7442DE7783
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 18:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfJ1RVt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 13:21:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40877 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfJ1RVs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Oct 2019 13:21:48 -0400
Received: from [91.217.168.176] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iP8i8-0004dS-SK; Mon, 28 Oct 2019 17:21:44 +0000
Date:   Mon, 28 Oct 2019 18:21:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: For review: documentation of clone3() system call
Message-ID: <20191028172143.4vnnjpdljfnexaq5@wittgenstein>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <CAG48ez3q=BeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0neheT17TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3q=BeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0neheT17TA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 04:12:09PM +0100, Jann Horn wrote:
> On Fri, Oct 25, 2019 at 6:59 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> > I've made a first shot at adding documentation for clone3(). You can
> > see the diff here:
> > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=faa0e55ae9e490d71c826546bbdef954a1800969
> [...]
> >    clone3()
> >        The  clone3() system call provides a superset of the functionality
> >        of the older clone() interface.  It also provides a number of  API
> >        improvements,  including: space for additional flags bits; cleaner
> >        separation in the use of various arguments;  and  the  ability  to
> >        specify the size of the child's stack area.
> 
> You might want to note somewhere that its flags can't be
> seccomp-filtered because they're stored in memory, making it
> inappropriate to use in heavily sandboxed processes.

Hm, I don't think that belongs on the clone manpage. Granted that
process creation is an important syscall but so are a bunch of others
that aren't filterable because of pointer arguments.
We can probably mention on the seccomp manpage that seccomp can't filter
on pointer arguments and then provide a list of examples. If you setup a
seccomp filter and don't know that you can't filter syscalls with
pointer args that seems pretty bad to begin with.

> 
> >            struct clone_args {
> >                u64 flags;        /* Flags bit mask */
> >                u64 pidfd;        /* Where to store PID file descriptor
> >                                     (int *) */
> >                u64 child_tid;    /* Where to store child TID,
> >                                     in child's memory (int *) */
> >                u64 parent_tid;   /* Where to store child TID,
> >                                     in parent's memory (int *) */
> >                u64 exit_signal;  /* Signal to deliver to parent on
> >                                     child termination */
> >                u64 stack;        /* Pointer to lowest byte of stack */
> >                u64 stack_size;   /* Size of stack */
> >                u64 tls;          /* Location of new TLS */
> >            };
> >
> >        The size argument that is supplied to clone3() should be  initial‐
> >        ized  to  the  size of this structure.  (The existence of the size
> >        argument permits future extensions to the clone_args structure.)
> >
> >        The stack for the child process is  specified  via  cl_args.stack,
> >        which   points   to  the  lowest  byte  of  the  stack  area,  and
> 
> Here and in the comment in the struct above, you say that .stack
> "points to the lowest byte of the stack area", but isn't that
> architecture-dependent? For most architectures, I think it should
> instead be "is the initial stack pointer", with the exception of IA64
> (and maybe others, I'm not sure). For example, on X86, when launching
> a thread with an initially empty stack, it points directly *after* the
> end of the stack area.

re arch and stack_size: You mentioned ia64 below (I snipped this part.)
but it's not the only one. With legacy clone it's _passed_ for any
architecture that has CONFIG_CLONE_BACKWARDS3. That includes at least
microblaze and ia64 I think. But only ia64 makes _actual use_ of this in
copy_thread() by doing user_stack_base + user_stack_size - 16. I think ia64
only needs stack_size because of the split page-table layout where two
stacks grow in different directions; so the stack doesn't grow
dynamically. Afair, stack_size is mainly used when PF_KTHREAD is true
but that can't be set from userspace anyway, so _shrug_.

One thing I never liked about clone() was that userspace had to know
about stack direction. And there is a lot of ugly code in userspace that
has nasty clone() wrappers like:

pid_t wrap_clone(int (*fn)(void *), void *arg, int flags, int *pidfd)
{
	pid_t ret;
	void *stack;

	stack = malloc(__STACK_SIZE);
	if (!stack) {
		SYSERROR("Failed to allocate clone stack");
		return -ENOMEM;
	}

#ifdef __ia64__
	ret = __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, pidfd);
#else
	ret = clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, pidfd);
#endif
	return ret;
}

where stack + stack_size is addition on a void pointer which usually
clang and gcc are not very happy about.
I wanted to bring this up on the mailing list soon: If possible, I don't
want userspace to need to know about stack direction and just have stack
point to the beginning and then have the kernel do the + stack_size
after the copy_clone_args_from_user() if the arch needs it. For example,
by having a dumb helder similar to copy_thread_tls()/coyp_thread() that
either does the + stack_size or not. Right now, clone3() is supported on
parisc and afaict, the stack grows upwards for it. I'm not sure if there
are obvious reasons why that won't work or it would be a bad idea...

Christian
