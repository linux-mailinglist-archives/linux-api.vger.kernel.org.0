Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18702FC1E
	for <lists+linux-api@lfdr.de>; Thu, 30 May 2019 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfE3NUQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 May 2019 09:20:16 -0400
Received: from port70.net ([81.7.13.123]:46612 "EHLO port70.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfE3NUQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 May 2019 09:20:16 -0400
Received: by port70.net (Postfix, from userid 1002)
        id EFC27ABEC0B8; Thu, 30 May 2019 15:20:12 +0200 (CEST)
Date:   Thu, 30 May 2019 15:20:12 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v1 1/2] fork: add clone3
Message-ID: <20190530132012.GS16415@port70.net>
References: <20190529152237.10719-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529152237.10719-1-christian@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christian Brauner <christian@brauner.io> [2019-05-29 17:22:36 +0200]:
> This adds the clone3 system call.
> 
> As mentioned several times already (cf. [7], [8]) here's the promised
> patchset for clone3().
> 
> We recently merged the CLONE_PIDFD patchset (cf. [1]). It took the last
> free flag from clone().
> 
> Independent of the CLONE_PIDFD patchset a time namespace has been discussed
> at Linux Plumber Conference last year and has been sent out and reviewed
> (cf. [5]). It is expected that it will go upstream in the not too distant
> future. However, it relies on the addition of the CLONE_NEWTIME flag to
> clone(). The only other good candidate - CLONE_DETACHED - is currently not
> recyclable as we have identified at least two large or widely used
> codebases that currently pass this flag (cf. [2], [3], and [4]). Given that
> CLONE_PIDFD grabbed the last clone() flag the time namespace is effectively
> blocked. clone3() has the advantage that it will unblock this patchset
> again.
> 
> The idea is to keep clone3() very simple and close to the original clone(),
> specifically, to keep on supporting old clone()-based workloads.
> We know there have been various creative proposals how a new process
> creation syscall or even api is supposed to look like. Some people even
> going so far as to argue that the traditional fork()+exec() split should be
> abandoned in favor of an in-kernel version of spawn(). Independent of
> whether or not we personally think spawn() is a good idea this patchset has
> and does not want to have anything to do with this.
> One stance we take is that there's no real good alternative to
> clone()+exec() and we need and want to support this model going forward;
> independent of spawn().
> The following requirements guided clone3():
> - bump the number of available flags
> - move arguments that are currently passed as separate arguments
>   in clone() into a dedicated struct clone_args
>   - choose a struct layout that is easy to handle on 32 and on 64 bit
>   - choose a struct layout that is extensible
>   - give new flags that currently need to abuse another flag's dedicated
>     return argument in clone() their own dedicated return argument
>     (e.g. CLONE_PIDFD)
>   - use a separate kernel internal struct kernel_clone_args that is
>     properly typed according to current kernel conventions in fork.c and is
>     different from  the uapi struct clone_args
> - port _do_fork() to use kernel_clone_args so that all process creation
>   syscalls such as fork(), vfork(), clone(), and clone3() behave identical
>   (Arnd suggested, that we can probably also port do_fork() itself in a
>    separate patchset.)
> - ease of transition for userspace from clone() to clone3()
>   This very much means that we do *not* remove functionality that userspace
>   currently relies on as the latter is a good way of creating a syscall
>   that won't be adopted.
> - do not try to be clever or complex: keep clone3() as dumb as possible
> 
> In accordance with Linus suggestions, clone3() has the following signature:
> 
> /* uapi */
> struct clone_args {
>         __aligned_u64 flags;
>         __aligned_u64 pidfd;
>         __aligned_u64 parent_tidptr;
>         __aligned_u64 child_tidptr;
>         __aligned_u64 stack;
>         __aligned_u64 stack_size;
>         __aligned_u64 tls;
> };

is this new linux syscall api style to pass pointers as u64?

i think it will look a bit ugly in userspace where cast
to u64 would signextend pointers on most 32bit targets, so
user code would have to do something like

arg.ptr = (uint64_t)(uintptr_t)ptr;

such ugliness can be hidden by the libc with a different
struct definition, but it will require bigendian and alignment
hackery (or translation in libc, but that does not really work
when user calls raw syscall).

> 
> /* kernel internal */
> struct kernel_clone_args {
>         u64 flags;
>         int __user *pidfd;
>         int __user *parent_tidptr;
>         int __user *child_tidptr;
>         unsigned long stack;
>         unsigned long stack_size;
>         unsigned long tls;
> };
> 
> long sys_clone3(struct clone_args __user *uargs, size_t size)
> 
> clone3() cleanly supports all of the supported flags from clone() and thus
> all legacy workloads.
> The advantage of sticking close to the old clone() is the low cost for
> userspace to switch to this new api. Quite a lot of userspace apis (e.g.
> pthreads) are based on the clone() syscall. With the new clone3() syscall
> supporting all of the old workloads and opening up the ability to add new
> features should make switching to it for userspace more appealing. In
> essence, glibc can just write a simple wrapper to switch from clone() to
> clone3().
> 
> There has been some interest in this patchset already. We have received a
> patch from the CRIU corner for clone3() that would set the PID/TID of a
> restored process without /proc/sys/kernel/ns_last_pid to eliminate a race.
> 
> /* References */
> [1]: b3e5838252665ee4cfa76b82bdf1198dca81e5be
> [2]: https://dxr.mozilla.org/mozilla-central/source/security/sandbox/linux/SandboxFilter.cpp#343
> [3]: https://git.musl-libc.org/cgit/musl/tree/src/thread/pthread_create.c#n233
> [4]: https://sources.debian.org/src/blcr/0.8.5-2.3/cr_module/cr_dump_self.c/?hl=740#L740
> [5]: https://lore.kernel.org/lkml/20190425161416.26600-1-dima@arista.com/
> [6]: https://lore.kernel.org/lkml/20190425161416.26600-2-dima@arista.com/
> [7]: https://lore.kernel.org/lkml/CAHrFyr5HxpGXA2YrKza-oB-GGwJCqwPfyhD-Y5wbktWZdt0sGQ@mail.gmail.com/
> [8]: https://lore.kernel.org/lkml/20190524102756.qjsjxukuq2f4t6bo@brauner.io/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Adrian Reber <adrian@lisas.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: linux-api@vger.kernel.org
> --
> v1:
> - Linus Torvalds <torvalds@linux-foundation.org>:
>   - redesign based on Linus proposal
>   - switch from arg-based to revision-based naming scheme: s/clone6/clone3/
> - Arnd Bergmann <arnd@arndb.de>:
>   - use a single copy_from_user() instead of multiple get_user() calls
>     since the latter have a constant overhead on some architectures
>   - a range of other tweaks and suggestions
> ---
>  arch/x86/ia32/sys_ia32.c   |  11 ++-
>  include/linux/sched/task.h |  13 ++-
>  include/linux/syscalls.h   |   6 ++
>  include/uapi/linux/sched.h |  16 ++++
>  kernel/fork.c              | 176 ++++++++++++++++++++++++++++---------
>  5 files changed, 177 insertions(+), 45 deletions(-)
...
