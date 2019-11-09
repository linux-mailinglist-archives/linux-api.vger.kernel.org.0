Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36AF6056
	for <lists+linux-api@lfdr.de>; Sat,  9 Nov 2019 17:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfKIQyA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 9 Nov 2019 11:54:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38379 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfKIQyA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 9 Nov 2019 11:54:00 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iTTzj-0005xS-NB; Sat, 09 Nov 2019 16:53:51 +0000
Date:   Sat, 9 Nov 2019 17:53:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: For review: documentation of clone3() system call
Message-ID: <20191109165349.ec5jkuqt7gtm2iy2@wittgenstein>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
 <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 09, 2019 at 09:09:51AM +0100, Michael Kerrisk (man-pages) wrote:
> [CC += Ingo, in case he has something to add re MAP_STACK; perhaps
> Florian also might have some thoughts]

Good idea.

> >> NAME
> >>        clone, __clone2 - create a child process
> > 
> > Should this include clone3()?
> > 
> >>
> >> SYNOPSIS
> >>        /* Prototype for the glibc wrapper function */
> >>
> >>        #define _GNU_SOURCE
> >>        #include <sched.h>
> >>
> >>        int clone(int (*fn)(void *), void *stack, int flags, void *arg, ...
> >>                  /* pid_t *parent_tid, void *tls, pid_t *child_tid */ );
> > 
> > I've always been confused by the "..." for the glibc wrapper. The glibc
> > prototype in bits/sched.h also looks like this:
> 
> I'm not sure that I understand your confusion. The point is, it's a
> variadic function: the extra arguments are only ever touched if the
> relevant flags are specified.

Sure. My confusion is why it is a) variadic in the first place and b)
even if it is can't we just advertise it as non-variadic since these
functions will not grow any additional arguments.

> 
> Or maybe you just meant: "this should not be a variadic function,
> but rather that all 7 arguments should always be specified"? But,
> then I think the point is that clone() (and the underlying syscall)
> did not always have this number of arguments. Before Linux 2.6, the
> wrapper and syscall only had 4 arguments.

Yeah, though I wonder whether this is all so ancient that it doesn't
matter anymore at this point in time.

> >> DESCRIPTION
> >>        These  system  calls  create a new process, in a manner similar to
> >>        fork(2).
> >>
> >>        Unlike fork(2), these system calls  allow  the  child  process  to
> >>        share  parts  of  its  execution context with the calling process,
> > 
> > Hm, sharing part of the execution context is not the only thing that
> > clone{3}() does. 
> 
> True. That text has been in the page for 21 years. It probably needs
> a new coat of paint...
> 
> > Maybe something like:
> > 
> > 	Unlike fork(2), these system calls allow to create a child process with
> > 	different properties than its parent. For example, these syscalls allow
> > 	the child to share various parts of the execution context with the
> > 	calling process such as [...]. They also allow placing the process in a
> > 	new set of namespaces.
> > 
> > Just a thought.
> 
> A good thought...
> 
> I changed the text to read:
> 
>        Unlike fork(2), these system calls allow the child to  be  created
>        with various properties that differ from the parent.  For example,
>        these system calls provide more precise control over  what  pieces
>        of  execution  context  are shared between the calling process and
>        the child process.  For example, using  these  system  calls,  the
>        caller can control whether or not the two processes share the vir‐
>        tual address space, the table of file descriptors, and  the  table
>        of  signal handlers.  These system system calls also allow the new
>        child process to placed in separate namespaces(7).
> 
> Okay?

Nit: The second and thirs sentence both start with "For example".
Otherwise sounds great.

> 
> >>        such as the virtual address space, the table of file  descriptors,
> >>        and the table of signal handlers.  (Note that on this manual page,
> >>        "calling process" normally corresponds to "parent  process".   But
> >>        see the description of CLONE_PARENT below.)
> >>
> >>        This page describes the following interfaces:
> >>
> >>        *  The  glibc  clone()  wrapper function and the underlying system
> >>           call on which it is based.  The main text describes the wrapper
> >>           function; the differences for the raw system call are described
> >>           toward the end of this page.
> >>
> >>        *  The newer clone3() system call.
> >>
> >>    The clone() wrapper function
> >>        When the child process is created with the clone()  wrapper  func‐
> >>        tion, it commences execution by calling the function pointed to by
> >>        the argument fn.  (This differs from fork(2), where execution con‐
> >>        tinues  in the child from the point of the fork(2) call.)  The arg
> >>        argument is passed as the argument of the function fn.
> >>
> >>        When the fn(arg) function returns, the child  process  terminates.
> >>        The  integer  returned  by  fn  is  the  exit status for the child
> >>        process.  The child process may also terminate explicitly by call‐
> >>        ing exit(2) or after receiving a fatal signal.
> >>
> >>        The stack argument specifies the location of the stack used by the
> >>        child process.  Since the child and calling process may share mem‐
> >>        ory,  it  is  not possible for the child process to execute in the
> >>        same stack as the  calling  process.   The  calling  process  must
> >>        therefore  set  up  memory  space  for  the child stack and pass a
> >>        pointer to this space to clone().  Stacks  grow  downward  on  all
> > 
> > It might be a good idea to advise people to use mmap() to create a
> > stack. The "canonical" way of doing this would usually be something like
> > 
> > #define DEFAULT_STACK_SIZE (4 * 1024 * 1024) /* 8 MB usually on Linux */
> > void *stack = mmap(NULL, DEFAULT_STACK_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
> > 
> > (Yes, the MAP_STACK is usally a noop but people should always include it
> >  in case some arch will have weird alignment requirement in which case
> >  this flag can be changed to actually do something...)
> 
> So, I'm getting a little bit of an education here, and maybe you are
> going to further educate me. Long ago, I added the documentation of
> MAP_STACK to mmap(2), but I never quite connected the dots.
> 
> However, you say MAP_STACK is *usually* a noop. As far as I can see,
> in current kernels it is *always* a noop. And AFAICS, since it was first
> added in 2.6.27 (2008), it has always been a noop.
> 
> I wonder if it will always be a noop.
> 
> If we go back and look at the commit:
> 
> [[
> commit 2fdc86901d2ab30a12402b46238951d2a7891590
> Author: Ingo Molnar <mingo@elte.hu>
> Date:   Wed Aug 13 18:02:18 2008 +0200
> 
>     x86: add MAP_STACK mmap flag
>     
>     as per this discussion:
>     
>        http://lkml.org/lkml/2008/8/12/423
>     
>     Pardo reported that 64-bit threaded apps, if their stacks exceed the
>     combined size of ~4GB, slow down drastically in pthread_create() - because
>     glibc uses MAP_32BIT to allocate the stacks. The use of MAP_32BIT is
>     a legacy hack - to speed up context switching on certain early model
>     64-bit P4 CPUs.
>     
>     So introduce a new flag to be used by glibc instead, to not constrain
>     64-bit apps like this.
>     
>     glibc can switch to this new flag straight away - it will be ignored
>     by the kernel. If those old CPUs ever matter to anyone, support for
>     it can be implemented.
> ]]
> 
> And see also https://lwn.net/Articles/294642/
> 
> So, my understanding from the above is that MAP_STACK was added to 
> allow a possible fix on some old architectures, should anyone decide it
> was worth doing the work of implementing it. But so far, after 12 years,
> no one did. It kind of looks like no one ever will (since those old
> architectures become less and less relevant).
> 
> So, AFAICT, while it's not wrong to tell people to use mmap(MAP_STACKED),
> it doesn't provide any benefit (and perhaps never will), and it is a
> more clumsy than plain old malloc().

Apart from MAP_STACK at some point (however unlikely) becoming relevant
I also like that mmap() makes it explicit that the page needs to be
readable (PROT_READ) and writeable (PROT_WRITE) and also every
(relevant) libc I know uses the explicit mmap() in their pthread
implementation. If you prefer the malloc() as an example that's
obviously fine.

> Yeah, but I didn't get mentioned in the commit ;-)

You provided your Ack after I had taken the patch into my tree and I've
already changed it once for Arnd's ack so I didn't want to change it
again.

> >>        CLONE_NEWUTS (since Linux 2.6.19)
> >>               If CLONE_NEWUTS is set, then create the process  in  a  new
> >>               UTS  namespace, whose identifiers are initialized by dupli‐
> >>               cating the identifiers from the UTS namespace of the  call‐
> >>               ing  process.   If  this  flag  is  not  set, then (as with
> >>               fork(2)) the process is created in the same  UTS  namespace
> >>               as  the  calling  process.   This  flag is intended for the
> >>               implementation of containers.
> >>
> >>               A UTS namespace is  the  set  of  identifiers  returned  by
> >>               uname(2); among these, the domain name and the hostname can
> >>               be modified by setdomainname(2) and sethostname(2), respec‐
> >>               tively.  Changes made to the identifiers in a UTS namespace
> >>               are visible to all other processes in the  same  namespace,
> >>               but are not visible to processes in other UTS namespaces.
> > 
> > Might again be a little too detailed but that's just my opinion. :)
> 
> I agree. The thing is that the clone(2) text was written long before
> the section 7 namespaces manual pages, and some duplication occurred.
> I've removed this text, and done the same for the corresponding text
> in CLONE_NEWNET and CLONE_NEWIPC.

Excellent.

> I changed the text here to read:
> 
>        CLONE_PID (Linux 2.0 to 2.5.15)
>               If  CLONE_PID is set, the child process is created with the
>               same process ID as the calling process.  This is  good  for
>               hacking  the  system,  but otherwise of not much use.  From
>               Linux 2.3.21 onward, this flag could be specified  only  by
>               the system boot process (PID 0).  The flag disappeared com‐
>               pletely from the kernel sources in  Linux  2.5.16.   Subse‐
>               quently,  the  kernel  silently  ignored this bit if it was
>               specified in the flags mask.  Much later, the same bit  was
>               recycled for use as the CLONE_PIDFD flag.

Yip, sounds good.

>        CLONE_DETACHED (historical)
>               For a while (during the Linux 2.5 development series) there
>               was a CLONE_DETACHED flag, which caused the parent  not  to
>               receive  a  signal  when the child terminated.  Ultimately,
>               the effect of this flag was subsumed under the CLONE_THREAD
>               flag  and  by  the time Linux 2.6.0 was released, this flag
>               had no effect.  Starting in Linux 2.6.2, the need  to  give
>               this flag together with CLONE_THREAD disappeared.
> 
>               This  flag is still defined, but it is usually ignored when
>               calling  clone().   However,   see   the   description   of
>               CLONE_PIDFD for some exceptions.
> 
> And then under CLONE_PIDFD, I have:
> 
>               If  the obsolete CLONE_DETACHED flag is specified alongside
>               CLONE_PIDFD when calling clone(), an error is returned.  An
>               error  also  results  if  CLONE_DETACHED  is specified when
>               calling clone3().  This error behavior ensures that the bit
>               corresponding  to  CLONE_DETACHED can be reused for further
>               PID file descriptor features in the future.
> 
> Okay?

Yip.

> >>        CLONE_SETTLS (since Linux 2.5.32)
> >>               The TLS (Thread Local Storage) descriptor is set to tls.
> >>
> >>               The interpretation of  tls  and  the  resulting  effect  is
> >>               architecture  dependent.   On  x86, tls is interpreted as a
> >>               struct user_desc * (see set_thread_area(2)).  On x86-64  it
> >>               is  the  new value to be set for the %fs base register (see
> >>               the ARCH_SET_FS argument to arch_prctl(2)).   On  architec‐
> >>               tures with a dedicated TLS register, it is the new value of
> >>               that register.
> > 
> > Probably a gentle warning that this is a very advanced option and
> > usually should not be used by callers other than libraries implementing
> > threading or with specific use cases directly.
> 
> I added:
> 
>     Use of this flag requires detailed knowledge and generally it
>     should not be used except in libraries implementing threading.

Sounds good.

> >>               If  any  of  the  threads  in  a  thread  group performs an
> >>               execve(2), then all threads other  than  the  thread  group
> >>               leader  are  terminated, and the new program is executed in
> > 
> > s/is executed in/becomes the/?
> 
> Hmmm, a program is not a task, so this doesn't feel quite right.
> Why don't you like the existing text?

Just read odd to me "executed in the thread group leader".

> > I won't do a deep review of the thread section now but you might want to
> > mention that fatal signals always take down the whole thread-group, i.e.
> > SIGKILL, SIGSEGV, etc...
> 
> That point is covered above, in the paragraph that begins: "Signal
> dispositions  and  actions  are process-wide...". Does that not
> suffice?

This is probably too detailed from my end.
Signals can be either thread-group-directed or thread-directed. That's
one aspect. The other aspect is whether they are delivered
thread-specific or thread-group-wide. While signals can be
thread-group-directed kill() they are not necessarily delivered
thread-group-wide. (I can go into details but that's not necessarily too
useful for this manpage.) My point was just that mentioning fatal
signals (e.g. SIGKILL, SIGSTOP) are always delivered thread-group-wide
no matter if they are thread-group-directed or thread-directed. This
might all be covered by your wording already and I just didn't read
close enough.

> >>        Note that the glibc clone() wrapper function makes some changes in
> >>        the memory pointed to by stack (changes required to set the  stack
> >>        up  correctly  for  the  child) before invoking the clone() system
> > 
> > In essence, you can't really use the clone{3}() syscall with a stack
> > argument directly without having to do some assembly. 
> 
> (Yes.)
> 
> > User needing to
> > mess with stacks are well-advised to use the glibc wrapper or need to
> > really know what they are doing for _each_ arch they are using the
> > syscall on.
> 
> I understand the issues (I think), but it's not clear to me if
> you mean that some text in the manual page needs changing.

It might be worth mentioning that using it with a stack involves more
than just allocating and passing it because people tend to assume that
using the syscall (not the glibc wrapper) with a stack just works. So
it's similar to the TLS comment we added with the difference that once
we have a glibc wrapper for clone3() the stack argument becomes easier
to use.

> Thanks. I made it:
> 
>        In  contrast  to  the  glibc  wrapper, the raw clone() system call
>        accepts NULL as a stack argument  (and  clone3()  likewise  allows
>        cl_args.stack  to be NULL).  In this case, the child uses a dupli‐
>        cate of the parent's stack. [...]

Sounds good.

> > I wouldn't even mention clone() for ia64 anymore. It will _not_ work
> > correctly at all. ia64 requires stack_size as it expects the stack to be
> > passed pointing to the lowest address but the clone() version for ia64
> > does not have a stack_size argument... So the only way to get clone() to
> > work on ia64 is by using the ia64 specific clone2().
> 
> Fair enough. I removed mention of is-64 here.

Thanks.

> >>            long clone(unsigned long flags, void *stack,
> >>                       int stack_size,         /* Size of stack */
> >>                       int *parent_tid, int *child_tid,
> >>                       unsigned long tls);
> > 
> > The additional argument is stack_size and contrary to what one would
> > expect _ignored_. I.e. on microblaze one still needs to pass stack
> > pointing to the top of the stack.
> 
> I added this sentence:
> 
>        Although a stack_size argument is provided, stack must still point
>        to the top of the stack.

Thanks.

> I made it:
> 
>        EINVAL (clone3() only)
>               CLONE_DETACHED was specified in the flags mask.
> 
>        EINVAL (clone() only)
>               CLONE_PIDFD  was  specified together with CLONE_DETACHED in
>               the flags mask.
> 
> Okay?

Yip.

> Thanks for the detailed feedback, Christian!

Thanks for the detailed manpage.

Christian
