Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5D39BBD
	for <lists+linux-api@lfdr.de>; Sat,  8 Jun 2019 10:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFHIPd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 8 Jun 2019 04:15:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35204 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFHIPd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 8 Jun 2019 04:15:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so1999925edr.2
        for <linux-api@vger.kernel.org>; Sat, 08 Jun 2019 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JZgNM/YpcgfjFUOjsGsDvLYNhaHJtTRTNvPjlkn0v8=;
        b=QNtRXfULBLwqItwKbiYMbjXozVxTSWgeJzFcCSXAAA47Ra+a3IHcjnVEHf50sHaeYZ
         PXpqgYkko0XZpH2Qd2Bv1eN65OuOZmLyCu+mZZaeuVdUD354rGkirGa8UOeisa5Tadvt
         0JyqW0hNHZ4T+WTaZE63OSZIEh40YhNpL8X8D2zEjuyKA0ZxiUIvRTaW9Bct49jujoFJ
         HwcfrofswpYqBkxXga696DhxyR1ItRo1zD+snHnGji5nCiJcvkvKmjftWv2WYYGebLuh
         U384O5RZPGU29JiTG/uLLZjL5Noptkd8ACuB4LLuMWaB1ZrGGrWiD2Nr0Ewo7+XPu5oe
         qpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JZgNM/YpcgfjFUOjsGsDvLYNhaHJtTRTNvPjlkn0v8=;
        b=Lzu34Nj/E2piq+6Dw30XkeEm1n6ZGtQv5E6iRH7p20ay5ID/phOD5nvFY9Z99Cyk4o
         gcoc1Y7pncGndlYqJiEdc8UqhlW6enNj0sq+k9iyAUnG337cwBUc3UPpBfp9D3wES1/Y
         l+411izOaEh0Gwzz4MRk26giN5Y9HJaJewQispA64E3S3lu/Xr48jXUt76ZNS3INwooK
         Hm6Q67GOjvTnHLsuQ5lSKkZ84JCCft5F6vErHVE/Ixk0U1/Txaf/TUpupzWvKxpheujU
         XSa9uU8xRXDlaPf7ufhTz4loJvbpMVE/hWU2dyptvPawv/R7hUnYtuv8com4hSgwhBnU
         YS9w==
X-Gm-Message-State: APjAAAVSh0/df3pPRiG35vgki8d7nVZR0n8q+2elT2ZutCY3AKchr2tX
        ZTWtQse062am9GBiqH9jfXymsQ==
X-Google-Smtp-Source: APXvYqwjgIGE5J2Agd5IxpjM4S3PHGqMY33O0GlnoZgldV6QFG1eSlHxSm1UHMbIp4z5anvrEOZktA==
X-Received: by 2002:a05:6402:1612:: with SMTP id f18mr171061edv.231.1559981730457;
        Sat, 08 Jun 2019 01:15:30 -0700 (PDT)
Received: from brauner.io ([2a02:8109:9cc0:6dac:cd8f:f6e9:1b84:bbb1])
        by smtp.gmail.com with ESMTPSA id e45sm1141764edb.12.2019.06.08.01.15.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 01:15:29 -0700 (PDT)
Date:   Sat, 8 Jun 2019 10:15:28 +0200
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Cc:     jannh@google.com, "Serge E. Hallyn" <serge@hallyn.com>,
        keescook@chromium.org, fweimer@redhat.com, oleg@redhat.com,
        arnd@arndb.de, dhowells@redhat.com,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fork: add clone3
Message-ID: <20190608081527.nxeo3xk2xt5hhpyx@brauner.io>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190606214645.GA31599@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606214645.GA31599@mail.hallyn.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 06, 2019 at 04:46:45PM -0500, Serge Hallyn wrote:
> On Tue, Jun 04, 2019 at 06:09:43PM +0200, Christian Brauner wrote:
> > This adds the clone3 system call.
> > 
> > As mentioned several times already (cf. [7], [8]) here's the promised
> > patchset for clone3().
> > 
> > We recently merged the CLONE_PIDFD patchset (cf. [1]). It took the last
> > free flag from clone().
> > 
> > Independent of the CLONE_PIDFD patchset a time namespace has been discussed
> > at Linux Plumber Conference last year and has been sent out and reviewed
> > (cf. [5]). It is expected that it will go upstream in the not too distant
> > future. However, it relies on the addition of the CLONE_NEWTIME flag to
> > clone(). The only other good candidate - CLONE_DETACHED - is currently not
> > recyclable as we have identified at least two large or widely used
> > codebases that currently pass this flag (cf. [2], [3], and [4]). Given that
> > CLONE_PIDFD grabbed the last clone() flag the time namespace is effectively
> > blocked. clone3() has the advantage that it will unblock this patchset
> > again. In general, clone3() is extensible and allows for the implementation
> > of new features.
> > 
> > The idea is to keep clone3() very simple and close to the original clone(),
> > specifically, to keep on supporting old clone()-based workloads.
> > We know there have been various creative proposals how a new process
> > creation syscall or even api is supposed to look like. Some people even
> > going so far as to argue that the traditional fork()+exec() split should be
> > abandoned in favor of an in-kernel version of spawn(). Independent of
> > whether or not we personally think spawn() is a good idea this patchset has
> > and does not want to have anything to do with this.
> > One stance we take is that there's no real good alternative to
> > clone()+exec() and we need and want to support this model going forward;
> > independent of spawn().
> > The following requirements guided clone3():
> > - bump the number of available flags
> > - move arguments that are currently passed as separate arguments
> >   in clone() into a dedicated struct clone_args
> >   - choose a struct layout that is easy to handle on 32 and on 64 bit
> >   - choose a struct layout that is extensible
> >   - give new flags that currently need to abuse another flag's dedicated
> >     return argument in clone() their own dedicated return argument
> >     (e.g. CLONE_PIDFD)
> >   - use a separate kernel internal struct kernel_clone_args that is
> >     properly typed according to current kernel conventions in fork.c and is
> >     different from  the uapi struct clone_args
> > - port _do_fork() to use kernel_clone_args so that all process creation
> >   syscalls such as fork(), vfork(), clone(), and clone3() behave identical
> >   (Arnd suggested, that we can probably also port do_fork() itself in a
> >    separate patchset.)
> > - ease of transition for userspace from clone() to clone3()
> >   This very much means that we do *not* remove functionality that userspace
> >   currently relies on as the latter is a good way of creating a syscall
> >   that won't be adopted.
> > - do not try to be clever or complex: keep clone3() as dumb as possible
> > 
> > In accordance with Linus suggestions (cf. [11]), clone3() has the following
> > signature:
> > 
> > /* uapi */
> > struct clone_args {
> >         __aligned_u64 flags;
> >         __aligned_u64 pidfd;
> >         __aligned_u64 child_tid;
> >         __aligned_u64 parent_tid;
> >         __aligned_u64 exit_signal;
> >         __aligned_u64 stack;
> >         __aligned_u64 stack_size;
> >         __aligned_u64 tls;
> > };
> > 
> > /* kernel internal */
> > struct kernel_clone_args {
> >         u64 flags;
> >         int __user *pidfd;
> >         int __user *child_tid;
> >         int __user *parent_tid;
> >         int exit_signal;
> >         unsigned long stack;
> >         unsigned long stack_size;
> >         unsigned long tls;
> > };
> > 
> > long sys_clone3(struct clone_args __user *uargs, size_t size)
> > 
> > clone3() cleanly supports all of the supported flags from clone() and thus
> > all legacy workloads.
> > The advantage of sticking close to the old clone() is the low cost for
> > userspace to switch to this new api. Quite a lot of userspace apis (e.g.
> > pthreads) are based on the clone() syscall. With the new clone3() syscall
> > supporting all of the old workloads and opening up the ability to add new
> > features should make switching to it for userspace more appealing. In
> > essence, glibc can just write a simple wrapper to switch from clone() to
> > clone3().
> > 
> > There has been some interest in this patchset already. We have received a
> > patch from the CRIU corner for clone3() that would set the PID/TID of a
> > restored process without /proc/sys/kernel/ns_last_pid to eliminate a race.
> > 
> > /* User visible differences to legacy clone() */
> > - CLONE_DETACHED will cause EINVAL with clone3()
> > - CSIGNAL is deprecated
> >   It is superseeded by a dedicated "exit_signal" argument in struct
> >   clone_args freeing up space for additional flags.
> >   This is based on a suggestion from Andrei and Linus (cf. [9] and [10])
> > 
> > /* References */
> > [1]: b3e5838252665ee4cfa76b82bdf1198dca81e5be
> > [2]: https://dxr.mozilla.org/mozilla-central/source/security/sandbox/linux/SandboxFilter.cpp#343
> > [3]: https://git.musl-libc.org/cgit/musl/tree/src/thread/pthread_create.c#n233
> > [4]: https://sources.debian.org/src/blcr/0.8.5-2.3/cr_module/cr_dump_self.c/?hl=740#L740
> > [5]: https://lore.kernel.org/lkml/20190425161416.26600-1-dima@arista.com/
> > [6]: https://lore.kernel.org/lkml/20190425161416.26600-2-dima@arista.com/
> > [7]: https://lore.kernel.org/lkml/CAHrFyr5HxpGXA2YrKza-oB-GGwJCqwPfyhD-Y5wbktWZdt0sGQ@mail.gmail.com/
> > [8]: https://lore.kernel.org/lkml/20190524102756.qjsjxukuq2f4t6bo@brauner.io/
> > [9]: https://lore.kernel.org/lkml/20190529222414.GA6492@gmail.com/
> > [10]: https://lore.kernel.org/lkml/CAHk-=whQP-Ykxi=zSYaV9iXsHsENa+2fdj-zYKwyeyed63Lsfw@mail.gmail.com/
> > [11]: https://lore.kernel.org/lkml/CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com/
> > 
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

This also carries an Ack by Arnd and there don't seem to be technical
issues anymore.
So I'm going to move this over into my for-next branch targeting 5.3 to
see some testing.

Thanks!
Christian

> 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Adrian Reber <adrian@lisas.de>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Florian Weimer <fweimer@redhat.com>
> > Cc: linux-api@vger.kernel.org
> > ---
> > v1:
> > - Linus Torvalds <torvalds@linux-foundation.org>:
> >   - redesign based on Linus proposal
> >   - switch from arg-based to revision-based naming scheme: s/clone6/clone3/
> > - Arnd Bergmann <arnd@arndb.de>:
> >   - use a single copy_from_user() instead of multiple get_user() calls
> >     since the latter have a constant overhead on some architectures
> >   - a range of other tweaks and suggestions
> > v2:
> > - Linus Torvalds <torvalds@linux-foundation.org>,
> >   Andrei Vagin <avagin@gmail.com>:
> >   - replace CSIGNAL flag with dedicated exit_signal argument in struct
> >     clone_args
> > - Christian Brauner <christian@brauner.io>:
> >   - improve naming for some struct clone_args members
> > v3:
> > - Arnd Bergmann <arnd@arndb.de>:
> >   - replace memset with constructor for clarity and better object code
> >   - call flag verification function clone3_flags_valid() on
> >     kernel_clone_args instead of clone_args
> >   - remove __ARCH_WANT_SYS_CLONE ifdefine around sys_clone3()
> > - Christian Brauner <christian@brauner.io>:
> >   - replace clone3_flags_valid() with clone3_args_valid() and call in
> >     clone3() directly rather than in copy_clone_args_from_user()
> >     This cleanly separates copying the args from userspace from the
> >     verification whether those args are sane.
> > - David Howells <dhowells@redhat.com>:
> >   - align new struct member assignments with tabs
> >   - replace CLONE_MAX by with a non-uapi exported CLONE_LEGACY_FLAGS and
> >     define it as  0xffffffffULL for clarity
> >   - make copy_clone_args_from_user() noinline
> >   - avoid assigning to local variables from struct kernel_clone_args
> >     members in cases where it makes sense
> > ---
> >  arch/x86/ia32/sys_ia32.c   |  12 ++-
> >  include/linux/sched/task.h |  17 +++-
> >  include/linux/syscalls.h   |   4 +
> >  include/uapi/linux/sched.h |  16 +++
> >  kernel/fork.c              | 201 ++++++++++++++++++++++++++++---------
> >  5 files changed, 199 insertions(+), 51 deletions(-)
