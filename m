Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245FCF5E07
	for <lists+linux-api@lfdr.de>; Sat,  9 Nov 2019 09:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfKIIKE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 9 Nov 2019 03:10:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46159 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfKIIKE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 9 Nov 2019 03:10:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so9426180wrs.13;
        Sat, 09 Nov 2019 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oEKw5lIBCmfI0ZEX5etTuVSgptAFbWSdiSQKqU4xrOQ=;
        b=PooplUB0ePQ/cy2iWR6YGEPuKmOeUEySfAhGMmPcRjog5YOnCnlZAn2ymm/9zw/UyZ
         TBf3IFiz7t7AnGCjLBedmTLingciByzX3HMq7Du2m8ZbLMXTmCLHNLE5JOqN3GYUka2F
         EXdL5ej37ev2nA5nXNAwzp5ZpC//JhY1gsQFGEsKKr8WIAgAMMnRJrM9DPYyYkYqUTHw
         2BQDrQFU1eTBAZtApf4u7HkKMPki95RgGumoUSoqtd+n70O2YWnUjvKd02imG9O3IwLe
         NNn+fGIz6CuJBgFKi6A98XvjY1W12L+ak276HsLV+HrI37VUat2WpH9AvVnMiGby+6BM
         hKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oEKw5lIBCmfI0ZEX5etTuVSgptAFbWSdiSQKqU4xrOQ=;
        b=FmzpLH+ZNJgvyV4uebDrSvO5zK/jvNWkC1r2sUqeH7oRJ+CRZBJcQRCDHclKCudrhd
         dOs53txdo8uLaBGMWDH++5sW3tP/T3gcAB+LiNplHaokTnqPV0sldyxmfvAMCGODKJxL
         PN+glNOoZnKzdB2KFDJJhCESBkspdGwDzVUVzKhorHXw7t6+eqGawXYHZ1QjIxPcVexi
         yq/9jWqZnibmAegaBt1VFid6d8SKPiSC2/XPRDc7mNdrXLDtcl2LU6rtxSqXsr13ow9o
         7HR5+yI5yBwW8Bj+0AZL5LWEXgV3+YKIAzGj1qGWCk4MAfWjYYO8r1EkOYEEqCbrondq
         84fw==
X-Gm-Message-State: APjAAAXNFjvitbufKkvlpZ8L2ZyNUVJ1NGggMV86IsAubIzxiBHN0m2n
        qMoMlYhdTYXIQUWSSYYSv5E=
X-Google-Smtp-Source: APXvYqyMhPYwp0MhEvqMf0r/eI9YHU2TPeqy4qEFG/yUNheRso3ur9VboXh30e7orUXRcP/Cneta/Q==
X-Received: by 2002:adf:dc0e:: with SMTP id t14mr11820043wri.170.1573286996012;
        Sat, 09 Nov 2019 00:09:56 -0800 (PST)
Received: from ?IPv6:2001:a61:25f7:501:a05a:4985:4904:9989? ([2001:a61:25f7:501:a05a:4985:4904:9989])
        by smtp.gmail.com with ESMTPSA id b66sm9932823wmh.39.2019.11.09.00.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 00:09:54 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
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
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
Date:   Sat, 9 Nov 2019 09:09:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191107151941.dw4gtul5lrtax4se@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[CC += Ingo, in case he has something to add re MAP_STACK; perhaps
Florian also might have some thoughts]

Hello Christian,

Thanks not only for reviewing the clone3() stuff, but also
in effect the entire page! You turned up some useful points
from the historical text.

On 11/7/19 4:19 PM, Christian Brauner wrote:
> On Fri, Oct 25, 2019 at 06:59:31PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Christian and all,
>>
>> I've made a first shot at adding documentation for clone3(). You can
>> see the diff here:
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=faa0e55ae9e490d71c826546bbdef954a1800969
>>
>> In the end, I decided that the most straightforward approach was to
>> add the documentation as part of the existing clone(2) page. This has
>> the advantage of avoiding duplication of information across two pages,
>> and perhaps also makes it easier to see the commonality of the two
>> APIs.
>>
>> Because the new text is integrated into the existing page, I think it
>> makes most sense to just show that page text for review purposes. I
>> welcome input on the below.
>>
>> The notable changes are:
>> * In the first part of the page, up to and including the paragraph
>> with the subheading "The flags bit mask"
>> * Minor changes in the description of CLONE_CHILD_CLEARTID,
>> CLONE_CHILD_SETTID, CLONE_PARENT_SETTID, and CLONE_PIDFD, to reflect
>> the argument differences between clone() and clone2()
> 
> (Fyi, I think you meant to write clone3()here. clone2() is specific to ia64.)

(Yes.)

>> Most of the resy of page is unchanged.
>>
>> I welcome fixes, suggestions for improvements, etc.
>>
>> Thanks,
>>
>> Michael
>>
>> CLONE(2)                Linux Programmer's Manual                CLONE(2)
>>
>> NAME
>>        clone, __clone2 - create a child process
> 
> Should this include clone3()?
> 
>>
>> SYNOPSIS
>>        /* Prototype for the glibc wrapper function */
>>
>>        #define _GNU_SOURCE
>>        #include <sched.h>
>>
>>        int clone(int (*fn)(void *), void *stack, int flags, void *arg, ...
>>                  /* pid_t *parent_tid, void *tls, pid_t *child_tid */ );
> 
> I've always been confused by the "..." for the glibc wrapper. The glibc
> prototype in bits/sched.h also looks like this:

I'm not sure that I understand your confusion. The point is, it's a
variadic function: the extra arguments are only ever touched if the
relevant flags are specified.

Or maybe you just meant: "this should not be a variadic function,
but rather that all 7 arguments should always be specified"? But,
then I think the point is that clone() (and the underlying syscall)
did not always have this number of arguments. Before Linux 2.6, the
wrapper and syscall only had 4 arguments.

> extern int clone (int (*__fn) (void *__arg), void *__child_stack, int __flags, void *__arg, ...) __THROW;
> 
> The additionl args parent_tid, tls, and child_tid are present in _all_
> clone version in the same order. In fact the glibc wrapper here give the
> illusion that it's parent_tid, tls, child_tid. The underlying syscall
> has a different order parent_tidptr, child_tidptr, tls.
> 
> Florian, can you advise what prototype we should mention for the glibc
> clone() wrapper here. I'd like it to be as simple as possible and get
> rid of the ...
> Architectural differences are explained in detail below anyway.
> 
>>
>>        /* For the prototype of the raw clone() system call, see NOTES */
>>
>>        long clone3(struct  clone_args *cl_args, size_t size);
>>
>>        Note: There is not yet a glibc wrapper for clone3(); see NOTES.
>>
>> DESCRIPTION
>>        These  system  calls  create a new process, in a manner similar to
>>        fork(2).
>>
>>        Unlike fork(2), these system calls  allow  the  child  process  to
>>        share  parts  of  its  execution context with the calling process,
> 
> Hm, sharing part of the execution context is not the only thing that
> clone{3}() does. 

True. That text has been in the page for 21 years. It probably needs
a new coat of paint...

> Maybe something like:
> 
> 	Unlike fork(2), these system calls allow to create a child process with
> 	different properties than its parent. For example, these syscalls allow
> 	the child to share various parts of the execution context with the
> 	calling process such as [...]. They also allow placing the process in a
> 	new set of namespaces.
> 
> Just a thought.

A good thought...

I changed the text to read:

       Unlike fork(2), these system calls allow the child to  be  created
       with various properties that differ from the parent.  For example,
       these system calls provide more precise control over  what  pieces
       of  execution  context  are shared between the calling process and
       the child process.  For example, using  these  system  calls,  the
       caller can control whether or not the two processes share the vir‐
       tual address space, the table of file descriptors, and  the  table
       of  signal handlers.  These system system calls also allow the new
       child process to placed in separate namespaces(7).

Okay?

>>        such as the virtual address space, the table of file  descriptors,
>>        and the table of signal handlers.  (Note that on this manual page,
>>        "calling process" normally corresponds to "parent  process".   But
>>        see the description of CLONE_PARENT below.)
>>
>>        This page describes the following interfaces:
>>
>>        *  The  glibc  clone()  wrapper function and the underlying system
>>           call on which it is based.  The main text describes the wrapper
>>           function; the differences for the raw system call are described
>>           toward the end of this page.
>>
>>        *  The newer clone3() system call.
>>
>>    The clone() wrapper function
>>        When the child process is created with the clone()  wrapper  func‐
>>        tion, it commences execution by calling the function pointed to by
>>        the argument fn.  (This differs from fork(2), where execution con‐
>>        tinues  in the child from the point of the fork(2) call.)  The arg
>>        argument is passed as the argument of the function fn.
>>
>>        When the fn(arg) function returns, the child  process  terminates.
>>        The  integer  returned  by  fn  is  the  exit status for the child
>>        process.  The child process may also terminate explicitly by call‐
>>        ing exit(2) or after receiving a fatal signal.
>>
>>        The stack argument specifies the location of the stack used by the
>>        child process.  Since the child and calling process may share mem‐
>>        ory,  it  is  not possible for the child process to execute in the
>>        same stack as the  calling  process.   The  calling  process  must
>>        therefore  set  up  memory  space  for  the child stack and pass a
>>        pointer to this space to clone().  Stacks  grow  downward  on  all
> 
> It might be a good idea to advise people to use mmap() to create a
> stack. The "canonical" way of doing this would usually be something like
> 
> #define DEFAULT_STACK_SIZE (4 * 1024 * 1024) /* 8 MB usually on Linux */
> void *stack = mmap(NULL, DEFAULT_STACK_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
> 
> (Yes, the MAP_STACK is usally a noop but people should always include it
>  in case some arch will have weird alignment requirement in which case
>  this flag can be changed to actually do something...)

So, I'm getting a little bit of an education here, and maybe you are
going to further educate me. Long ago, I added the documentation of
MAP_STACK to mmap(2), but I never quite connected the dots.

However, you say MAP_STACK is *usually* a noop. As far as I can see,
in current kernels it is *always* a noop. And AFAICS, since it was first
added in 2.6.27 (2008), it has always been a noop.

I wonder if it will always be a noop.

If we go back and look at the commit:

[[
commit 2fdc86901d2ab30a12402b46238951d2a7891590
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Aug 13 18:02:18 2008 +0200

    x86: add MAP_STACK mmap flag
    
    as per this discussion:
    
       http://lkml.org/lkml/2008/8/12/423
    
    Pardo reported that 64-bit threaded apps, if their stacks exceed the
    combined size of ~4GB, slow down drastically in pthread_create() - because
    glibc uses MAP_32BIT to allocate the stacks. The use of MAP_32BIT is
    a legacy hack - to speed up context switching on certain early model
    64-bit P4 CPUs.
    
    So introduce a new flag to be used by glibc instead, to not constrain
    64-bit apps like this.
    
    glibc can switch to this new flag straight away - it will be ignored
    by the kernel. If those old CPUs ever matter to anyone, support for
    it can be implemented.
]]

And see also https://lwn.net/Articles/294642/

So, my understanding from the above is that MAP_STACK was added to 
allow a possible fix on some old architectures, should anyone decide it
was worth doing the work of implementing it. But so far, after 12 years,
no one did. It kind of looks like no one ever will (since those old
architectures become less and less relevant).

So, AFAICT, while it's not wrong to tell people to use mmap(MAP_STACKED),
it doesn't provide any benefit (and perhaps never will), and it is a
more clumsy than plain old malloc().

But, it could well be that there's something I still don't know here,
and I'd be interested to get further education.

>>        processors  that run Linux (except the HP PA processors), so stack
>>        usually points to the topmost address of the memory space  set  up
>>        for  the  child stack.  Note that clone() does not provide a means
>>        whereby the caller can inform the kernel of the size of the  stack
>>        area.
>>
>>        The remaining arguments to clone() are discussed below.
>>
>>    clone3()
>>        The  clone3() system call provides a superset of the functionality
>>        of the older clone() interface.  It also provides a number of  API
> 
> Technically, clone3() currently provides the same functionality as
> clone() it just has (hopefully) saner semantics, i.e. where as clone()
> _silently_ ignores unknown options clone3() will reject them with
> EINVAL (e.g. CSIGNAL and CLONE_DETACHED).
> But it's good enough and will be true with v5.5

Exactly. My text was future-proofing ;-).

>>        improvements,  including: space for additional flags bits; cleaner
>>        separation in the use of various arguments;  and  the  ability  to
>>        specify the size of the child's stack area.
>>
>>        As  with  fork(2),  clone3()  returns  in  both the parent and the
>>        child.  It returns 0 in the child process and returns the  PID  of
>>        the child in the parent.
>>
>>        The  cl_args  argument of clone3() is a structure of the following
>>        form:
>>
>>            struct clone_args {
>>                u64 flags;        /* Flags bit mask */
>>                u64 pidfd;        /* Where to store PID file descriptor
>>                                     (int *) */
>>                u64 child_tid;    /* Where to store child TID,
>>                                     in child's memory (int *) */
>>                u64 parent_tid;   /* Where to store child TID,
>>                                     in parent's memory (int *) */
>>                u64 exit_signal;  /* Signal to deliver to parent on
>>                                     child termination */
>>                u64 stack;        /* Pointer to lowest byte of stack */
>>                u64 stack_size;   /* Size of stack */
>>                u64 tls;          /* Location of new TLS */
>>            };
>>
>>        The size argument that is supplied to clone3() should be  initial‐
>>        ized  to  the  size of this structure.  (The existence of the size
>>        argument permits future extensions to the clone_args structure.)
>>
>>        The stack for the child process is  specified  via  cl_args.stack,
>>        which   points   to  the  lowest  byte  of  the  stack  area,  and
>>        cl_args.stack_size, which specifies  the  size  of  the  stack  in
>>        bytes.   In the case where the CLONE_VM flag (see below) is speci‐
> 
> This is now actually true. :)

Yeah, but I didn't get mentioned in the commit ;-)

>>        fied, a stack must be explicitly allocated and specified.   Other‐
>>        wise,  these  two  fields  can  be  specified as NULL and 0, which
>>        causes the child to use the same stack area as the parent (in  the
>>        child's own virtual address space).
>>
>>        The remaining fields in the cl_args argument are discussed below.
>>
>>    Equivalence between clone() and clone3() arguments
>>        Unlike  the  older  clone()  interface, where arguments are passed
>>        individually, in the newer clone3() interface  the  arguments  are
>>        packaged  into  the clone_args structure shown above.  This struc‐
>>        ture allows for a superset  of  the  information  passed  via  the
>>        clone() arguments.
>>
>>        The following table shows the equivalence between the arguments of
>>        clone() and the fields in  the  clone_args  argument  supplied  to
>>        clone3():
>>
>>               clone()         clone(3)        Notes
>>                               cl_args field
>>               flags & ~0xff   flags
> 
> CLONE_DETACHED doesn't work.

So, in the Notes column I added "For most flags; details below".

>>               parent_tid      pidfd           See CLONE_PIDFD
>>               child_tid       child_tid       See CLONE_CHILD_SETTID
>>               parent_tid      parent_tid      See CLONE_PARENT_SETTID
>>               flags & 0xff    exit_signal
>>               stack           stack
>>
>>               ---             stack_size
> 
> posterity: Apart from microblaze and ia64's clone2() which both have a
> stack_size argument. :)

Yes, but those are details I only want to get into later in the page.

>>               tls             tls             See CLONE_SETTLS
>>
>>    The child termination signal
>>        When  the  child  process  terminates, a signal may be sent to the
>>        parent.  The termination signal is specified in the  low  byte  of
>>        flags  (clone())  or  in  cl_args.exit_signal (clone3()).  If this
>>        signal is specified as anything other than SIGCHLD, then the  par‐
>>        ent process must specify the __WALL or __WCLONE options when wait‐
>>        ing for the child with wait(2).  If  no  signal  (i.e.,  zero)  is
>>        specified,  then the parent process is not signaled when the child
>>        terminates.
>>
>>    The flags bit mask
>>        Both clone() and clone3() allow a flags  bit  mask  that  modifies
>>        their  behavior  and  allows  the caller to specify what is shared
>>        between the calling process and the child process.  This bit  mask
>>        is  specified  as  a  bitwise-OR  of zero or more of the constants
>>        listed below.  Except as otherwise noted below,  these  flags  are
>>        available (and have the same effect) in both clone() and clone3().
>>
>>        CLONE_CHILD_CLEARTID (since Linux 2.5.49)
>>               Clear (zero) the child thread ID at the location pointed to
>>               by child_tid (clone()) or cl_args.child_tid  (clone3())  in
>>               child  memory  when the child exits, and do a wakeup on the
>>               futex at that address.  The address involved may be changed
>>               by  the  set_tid_address(2)  system  call.  This is used by
>>               threading libraries.
>>
>>        CLONE_CHILD_SETTID (since Linux 2.5.49)
>>               Store the child thread ID at the  location  pointed  to  by
>>               child_tid  (clone()) or cl_args.child_tid (clone3()) in the
>>               child's  memory.   The  store  operation  completes  before
>>               clone() returns control to user space in the child process.
>>               (Note that the  store  operation  may  not  have  completed
>>               before clone() returns in the parent process, which will be
>>               relevant if the CLONE_VM flag is also employed.)
>>
>>        CLONE_FILES (since Linux 2.0)
>>               If CLONE_FILES is set, the calling process  and  the  child
>>               process  share  the  same  file descriptor table.  Any file
>>               descriptor created by the calling process or by  the  child
>>               process  is also valid in the other process.  Similarly, if
>>               one of the processes closes a file descriptor,  or  changes
>>               its  associated  flags  (using  the fcntl(2) F_SETFD opera‐
>>               tion), the other process is also affected.   If  a  process
>>               sharing  a  file descriptor table calls execve(2), its file
>>               descriptor table is duplicated (unshared).
>>
>>               If CLONE_FILES is not set, the  child  process  inherits  a
>>               copy  of all file descriptors opened in the calling process
>>               at the time of clone().  Subsequent operations that open or
>>               close  file  descriptors,  or change file descriptor flags,
>>               performed by  either  the  calling  process  or  the  child
>>               process  do  not  affect the other process.  Note, however,
>>               that the duplicated file descriptors in the child refer  to
>>               the  same  open file descriptions as the corresponding file
>>               descriptors in the calling process,  and  thus  share  file
>>               offsets and file status flags (see open(2)).
>>
>>        CLONE_FS (since Linux 2.0)
>>               If  CLONE_FS is set, the caller and the child process share
>>               the same filesystem information.  This includes the root of
>>               the  filesystem,  the  current  working  directory, and the
>>               umask.  Any call to chroot(2), chdir(2), or  umask(2)  per‐
>>               formed  by  the  calling  process or the child process also
>>               affects the other process.
>>
>>               If CLONE_FS is not set, the child process works on  a  copy
>>               of the filesystem information of the calling process at the
>>               time of the clone() call.  Calls to chroot(2), chdir(2), or
>>               umask(2)  performed  later  by  one of the processes do not
>>               affect the other process.
>>
>>        CLONE_IO (since Linux 2.6.25)
>>               If CLONE_IO is set, then the new process shares an I/O con‐
>>               text  with  the  calling process.  If this flag is not set,
>>               then (as with fork(2)) the new process has its own I/O con‐
>>               text.
>>
>>               The  I/O  context  is  the  I/O scope of the disk scheduler
>>               (i.e., what the I/O scheduler uses to model scheduling of a
>>               process's  I/O).   If processes share the same I/O context,
>>               they are treated as one by the I/O scheduler.  As a  conse‐
>>               quence,  they  get to share disk time.  For some I/O sched‐
>>               ulers, if two processes share an I/O context, they will  be
>>               allowed  to  interleave  their  disk  access.   If  several
>>               threads are  doing  I/O  on  behalf  of  the  same  process
>>               (aio_read(3), for instance), they should employ CLONE_IO to
>>               get better I/O performance.
>>
>>               If the kernel  is  not  configured  with  the  CONFIG_BLOCK
>>               option, this flag is a no-op.
>>
>>        CLONE_NEWCGROUP (since Linux 4.6)
>>               Create the process in a new cgroup namespace.  If this flag
>>               is not set, then (as with fork(2)) the process  is  created
>>               in the same cgroup namespaces as the calling process.  This
>>               flag is intended for the implementation of containers.
>>
>>               For  further  information   on   cgroup   namespaces,   see
>>               cgroup_namespaces(7).
>>
>>               Only   a  privileged  process  (CAP_SYS_ADMIN)  can  employ
>>               CLONE_NEWCGROUP.
>>
>>        CLONE_NEWIPC (since Linux 2.6.19)
>>               If CLONE_NEWIPC is set, then create the process  in  a  new
>>               IPC  namespace.   If  this  flag  is not set, then (as with
>>               fork(2)), the process is created in the same IPC  namespace
>>               as  the  calling  process.   This  flag is intended for the
>>               implementation of containers.
>>
>>               An IPC namespace provides an isolated view of System V  IPC
>>               objects  (see  sysvipc(7))  and  (since Linux 2.6.30) POSIX
>>               message queues (see mq_overview(7)).  The common character‐
>>               istic of these IPC mechanisms is that IPC objects are iden‐
>>               tified by mechanisms other than filesystem pathnames.
>>
>>               Objects created in an IPC  namespace  are  visible  to  all
>>               other processes that are members of that namespace, but are
>>               not visible to processes in other IPC namespaces.
>>
>>               When an IPC namespace is destroyed  (i.e.,  when  the  last
>>               process  that is a member of the namespace terminates), all
>>               IPC objects in the namespace are automatically destroyed.
>>
>>               Only  a  privileged  process  (CAP_SYS_ADMIN)  can   employ
>>               CLONE_NEWIPC.   This flag can't be specified in conjunction
>>               with CLONE_SYSVSEM.
>>
>>               For further  information  on  IPC  namespaces,  see  names‐
>>               paces(7).
>>
>>        CLONE_NEWNET (since Linux 2.6.24)
>>               (The  implementation  of  this  flag  was completed only by
>>               about kernel version 2.6.29.)
>>
>>               If CLONE_NEWNET is set, then create the process  in  a  new
>>               network  namespace.  If this flag is not set, then (as with
>>               fork(2)) the process is created in the same network  names‐
>>               pace as the calling process.  This flag is intended for the
>>               implementation of containers.
>>
>>               A network namespace provides an isolated view of  the  net‐
>>               working  stack  (network  device  interfaces, IPv4 and IPv6
>>               protocol stacks, IP routing  tables,  firewall  rules,  the
>>               /proc/net  and  /sys/class/net  directory  trees,  sockets,
>>               etc.).  A physical network device can live in  exactly  one
>>               network namespace.  A virtual network (veth(4)) device pair
>>               provides a pipe-like abstraction that can be used to create
>>               tunnels between network namespaces, and can be used to cre‐
>>               ate a bridge to a physical network device in another names‐
>>               pace.
>>
>>               When  a  network  namespace  is  freed (i.e., when the last
>>               process in the namespace terminates), its physical  network
>>               devices  are  moved  back  to the initial network namespace
>>               (not to the parent of the process).  For  further  informa‐
>>               tion on network namespaces, see namespaces(7).
> 
> That's a lot of network namespace specific information, no? Maybe just
> point to man network_namespaces?

It's true.  See below.

>>               Only   a  privileged  process  (CAP_SYS_ADMIN)  can  employ
>>               CLONE_NEWNET.
>>
>>        CLONE_NEWNS (since Linux 2.4.19)
>>               If CLONE_NEWNS is set, the cloned child is started in a new
>>               mount  namespace,  initialized with a copy of the namespace
>>               of the parent.  If CLONE_NEWNS is not set, the child  lives
>>               in the same mount namespace as the parent.
>>
>>               Only   a  privileged  process  (CAP_SYS_ADMIN)  can  employ
>>               CLONE_NEWNS.   It  is  not  permitted   to   specify   both
>>               CLONE_NEWNS and CLONE_FS in the same clone() call.
> 
> Wait, I just realized that CLONE_FS has __different__ semantics in
> clone(2) than in unshare(2). That's crazy.
> unshare(2)'s basically ~CLONE_FS for clone2()...
> That deserves a big fat warning imho. At leats it's mentioned in the
> unshare(2) manpage.

Sigh....
https://lore.kernel.org/lkml/1101.1141274924@www008.gmx.net/

>>               For  further  information  on  mount namespaces, see names‐
>>               paces(7) and mount_namespaces(7).
>>
>>        CLONE_NEWPID (since Linux 2.6.24)
>>               If CLONE_NEWPID is set, then create the process  in  a  new
>>               PID  namespace.   If  this  flag  is not set, then (as with
>>               fork(2)) the process is created in the same  PID  namespace
>>               as  the  calling  process.   This  flag is intended for the
>>               implementation of containers.
>>
>>               For further  information  on  PID  namespaces,  see  names‐
>>               paces(7) and pid_namespaces(7).
>>
>>               Only   a  privileged  process  (CAP_SYS_ADMIN)  can  employ
>>               CLONE_NEWPID.  This flag can't be specified in  conjunction
>>               with CLONE_THREAD or CLONE_PARENT.
>>
>>        CLONE_NEWUSER
>>               (This  flag  first  became  meaningful for clone() in Linux
>>               2.6.23, the current clone() semantics were merged in  Linux
>>               3.5,  and the final pieces to make the user namespaces com‐
>>               pletely usable were merged in Linux 3.8.)
>>
>>               If CLONE_NEWUSER is set, then create the process in  a  new
>>               user  namespace.   If  this  flag is not set, then (as with
>>               fork(2)) the process is created in the same user  namespace
>>               as the calling process.
>>
>>               Before  Linux  3.8,  use of CLONE_NEWUSER required that the
>>               caller have three capabilities: CAP_SYS_ADMIN,  CAP_SETUID,
>>               and CAP_SETGID.  Starting with Linux 3.8, no privileges are
>>               needed to create a user namespace.
>>
>>               This  flag  can't  be   specified   in   conjunction   with
>>               CLONE_THREAD   or   CLONE_PARENT.   For  security  reasons,
>>               CLONE_NEWUSER  cannot  be  specified  in  conjunction  with
>>               CLONE_FS.
>>
>>               For  further  information  on  user  namespaces, see names‐
>>               paces(7) and user_namespaces(7).
>>
>>        CLONE_NEWUTS (since Linux 2.6.19)
>>               If CLONE_NEWUTS is set, then create the process  in  a  new
>>               UTS  namespace, whose identifiers are initialized by dupli‐
>>               cating the identifiers from the UTS namespace of the  call‐
>>               ing  process.   If  this  flag  is  not  set, then (as with
>>               fork(2)) the process is created in the same  UTS  namespace
>>               as  the  calling  process.   This  flag is intended for the
>>               implementation of containers.
>>
>>               A UTS namespace is  the  set  of  identifiers  returned  by
>>               uname(2); among these, the domain name and the hostname can
>>               be modified by setdomainname(2) and sethostname(2), respec‐
>>               tively.  Changes made to the identifiers in a UTS namespace
>>               are visible to all other processes in the  same  namespace,
>>               but are not visible to processes in other UTS namespaces.
> 
> Might again be a little too detailed but that's just my opinion. :)

I agree. The thing is that the clone(2) text was written long before
the section 7 namespaces manual pages, and some duplication occurred.
I've removed this text, and done the same for the corresponding text
in CLONE_NEWNET and CLONE_NEWIPC.

>>               Only   a  privileged  process  (CAP_SYS_ADMIN)  can  employ
>>               CLONE_NEWUTS.
>>
>>               For further  information  on  UTS  namespaces,  see  names‐
>>               paces(7).
>>
>>        CLONE_PARENT (since Linux 2.3.12)
>>               If  CLONE_PARENT  is  set, then the parent of the new child
>>               (as returned by getppid(2)) will be the same as that of the
>>               calling process.
>>
>>               If  CLONE_PARENT  is  not  set,  then (as with fork(2)) the
>>               child's parent is the calling process.
>>
>>               Note that it is the parent process, as  returned  by  getp‐
>>               pid(2),  which  is  signaled  when the child terminates, so
>>               that if CLONE_PARENT is set, then the parent of the calling
>>               process,  rather  than  the calling process itself, will be
>>               signaled.
>>
>>        CLONE_PARENT_SETTID (since Linux 2.5.49)
>>               Store the child thread ID at the  location  pointed  to  by
>>               parent_tid (clone()) or cl_args.child_tid (clone3()) in the
>>               parent's memory.  (In Linux 2.5.32-2.5.48 there was a  flag
>>               CLONE_SETTID that did this.)  The store operation completes
>>               before clone() returns control to user space.
>>
>>        CLONE_PID (Linux 2.0 to 2.5.15)
>>               If CLONE_PID is set, the child process is created with  the
>>               same  process  ID as the calling process.  This is good for
>>               hacking the system, but otherwise of not  much  use.   From
>>               Linux  2.3.21  onward, this flag could be specified only by
>>               the system boot process (PID 0).  The flag disappeared com‐
>>               pletely  from  the  kernel  sources in Linux 2.5.16.  Since
>>               then, the kernel silently ignores this bit if it is  speci‐
>>               fied in flags.
> 
> He, not true anymore. :)
> If Thomas' history tree is not lying to me than CLONE_PID used to be:
> #define CLONE_PID      0x00001000      /* set if pid shared */
> which then got replaced with
> #define CLONE_IDLETASK 0x00001000      /* set if new pid should be 0
> in 27568369be8c ("[PATCH] Hotplug CPU prep")
> CLONE_IDLETASK itself got removed in f4205a53c8f5 ("[PATCH] sched: consolidate CLONE_IDLETASK masking")

Yes, but CLONE_IDLETASK was never accessible from userspace, as far
as I know. (That is, if you specified that bit in flags, it was
ignored. Rusty's commit message obliquely states this.) 

> And then CLONE_PIDFD took that bit. :)

Congratulations :-).

I changed the text here to read:

       CLONE_PID (Linux 2.0 to 2.5.15)
              If  CLONE_PID is set, the child process is created with the
              same process ID as the calling process.  This is  good  for
              hacking  the  system,  but otherwise of not much use.  From
              Linux 2.3.21 onward, this flag could be specified  only  by
              the system boot process (PID 0).  The flag disappeared com‐
              pletely from the kernel sources in  Linux  2.5.16.   Subse‐
              quently,  the  kernel  silently  ignored this bit if it was
              specified in the flags mask.  Much later, the same bit  was
              recycled for use as the CLONE_PIDFD flag.

>>        CLONE_PIDFD (since Linux 5.2)
>>               If  this flag is specified, a PID file descriptor referring
>>               to the child process is allocated and placed at a specified
>>               location in the parent's memory.  The close-on-exec flag is
>>               set on this new file descriptor.  PID file descriptors  can
>>               be used for the purposes described in pidfd_open(2).
>>
>>               *  When  using  clone3(), the PID file descriptor is placed
>>                  at the location pointed to by cl_args.pidfd.
>>
>>               *  When using clone(), the PID file descriptor is placed at
>>                  the  location  pointed to by parent_tid.  Since the par‐
>>                  ent_tid argument is used to return the PID file descrip‐
>>                  tor, CLONE_PIDFD cannot be used with CLONE_PARENT_SETTID
>>                  when calling clone().
>>
>>               It is currently not possible to use this flag together with
>>               CLONE_THREAD.   This  means  that the process identified by
>>               the PID file  descriptor  will  always  be  a  thread-group
>>               leader.
>>
>>               For  a while there was a CLONE_DETACHED flag.  This flag is
>>               usually ignored when passed along with other  flags.   How‐
>>               ever,  when  passed  alongside  CLONE_PIDFD,  an  error  is
>>               returned.  This ensures that this flag can  be  reused  for
>>               further PID file descriptor features in the future.
> 
> This section only applies to legacy clone(), i.e. legacy clone EINVALs
> you with CLONE_DETACHED | CLONE_PIDFD whereas clone3() EINVALS you for
> CLONE_DETACHED by itself.

Okay -- but *you* added this text to the man page ;-).

So, here's what I have done.

15 years after its demise, CLONE_DETACHED gets equal status with
other flags in the manual page:

       CLONE_DETACHED (historical)
              For a while (during the Linux 2.5 development series) there
              was a CLONE_DETACHED flag, which caused the parent  not  to
              receive  a  signal  when the child terminated.  Ultimately,
              the effect of this flag was subsumed under the CLONE_THREAD
              flag  and  by  the time Linux 2.6.0 was released, this flag
              had no effect.  Starting in Linux 2.6.2, the need  to  give
              this flag together with CLONE_THREAD disappeared.

              This  flag is still defined, but it is usually ignored when
              calling  clone().   However,   see   the   description   of
              CLONE_PIDFD for some exceptions.

And then under CLONE_PIDFD, I have:

              If  the obsolete CLONE_DETACHED flag is specified alongside
              CLONE_PIDFD when calling clone(), an error is returned.  An
              error  also  results  if  CLONE_DETACHED  is specified when
              calling clone3().  This error behavior ensures that the bit
              corresponding  to  CLONE_DETACHED can be reused for further
              PID file descriptor features in the future.

Okay?

>>        CLONE_PTRACE (since Linux 2.2)
>>               If  CLONE_PTRACE  is  specified, and the calling process is
>>               being traced, then trace the child also (see ptrace(2)).
>>
>>        CLONE_SETTLS (since Linux 2.5.32)
>>               The TLS (Thread Local Storage) descriptor is set to tls.
>>
>>               The interpretation of  tls  and  the  resulting  effect  is
>>               architecture  dependent.   On  x86, tls is interpreted as a
>>               struct user_desc * (see set_thread_area(2)).  On x86-64  it
>>               is  the  new value to be set for the %fs base register (see
>>               the ARCH_SET_FS argument to arch_prctl(2)).   On  architec‐
>>               tures with a dedicated TLS register, it is the new value of
>>               that register.
> 
> Probably a gentle warning that this is a very advanced option and
> usually should not be used by callers other than libraries implementing
> threading or with specific use cases directly.

I added:

    Use of this flag requires detailed knowledge and generally it
    should not be used except in libraries implementing threading.

>>
>>        CLONE_SIGHAND (since Linux 2.0)
>>               If CLONE_SIGHAND is set, the calling process and the  child
>>               process  share  the  same table of signal handlers.  If the
>>               calling process or  child  process  calls  sigaction(2)  to
>>               change  the behavior associated with a signal, the behavior
>>               is changed in the other  process  as  well.   However,  the
>>               calling  process  and  child  processes still have distinct
>>               signal masks and sets of pending signals.  So, one of  them
>>               may  block  or unblock signals using sigprocmask(2) without
>>               affecting the other process.
>>
>>               If CLONE_SIGHAND is not set, the child process  inherits  a
>>               copy  of  the signal handlers of the calling process at the
>>               time clone() is called.  Calls  to  sigaction(2)  performed
>>               later  by  one of the processes have no effect on the other
>>               process.
>>
>>               Since Linux 2.6.0, flags  must  also  include  CLONE_VM  if
>>               CLONE_SIGHAND is specified
>>
>>        CLONE_STOPPED (since Linux 2.6.0)
>>               If  CLONE_STOPPED  is  set,  then  the  child  is initially
>>               stopped (as though it was sent a SIGSTOP signal), and  must
>>               be resumed by sending it a SIGCONT signal.
>>
>>               This  flag was deprecated from Linux 2.6.25 onward, and was
>>               removed altogether in Linux 2.6.38.  Since then, the kernel
>>               silently  ignores  it  without  error.  Starting with Linux
>>               4.6, the same bit was reused for the CLONE_NEWCGROUP flag.
>>
>>        CLONE_SYSVSEM (since Linux 2.5.10)
>>               If CLONE_SYSVSEM is set, then the  child  and  the  calling
>>               process  share  a single list of System V semaphore adjust‐
>>               ment (semadj) values (see semop(2)).   In  this  case,  the
>>               shared  list accumulates semadj values across all processes
>>               sharing the list, and semaphore adjustments  are  performed
>>               only  when the last process that is sharing the list termi‐
>>               nates (or ceases sharing the list  using  unshare(2)).   If
>>               this  flag is not set, then the child has a separate semadj
>>               list that is initially empty.
>>
>>        CLONE_THREAD (since Linux 2.4.0)
>>               If CLONE_THREAD is set, the child is  placed  in  the  same
>>               thread group as the calling process.  To make the remainder
>>               of the discussion of CLONE_THREAD more readable,  the  term
>>               "thread"  is used to refer to the processes within a thread
>>               group.
>>
>>               Thread groups were a feature added in Linux 2.4 to  support
>>               the  POSIX  threads notion of a set of threads that share a
>>               single PID.  Internally, this shared PID is  the  so-called
>>               thread group identifier (TGID) for the thread group.  Since
>>               Linux 2.4, calls to getpid(2) return the TGID of the  call‐
>>               er.
>>
>>               The  threads  within  a group can be distinguished by their
>>               (system-wide) unique thread IDs (TID).  A new thread's  TID
>>               is  available as the function result returned to the caller
>>               of clone(), and a thread can obtain its own TID using  get‐
>>               tid(2).
>>
>>               When   a   call  is  made  to  clone()  without  specifying
>>               CLONE_THREAD, then the resulting thread is placed in a  new
>>               thread  group  whose  TGID is the same as the thread's TID.
>>               This thread is the leader of the new thread group.
>>
>>               A new thread created with CLONE_THREAD has the same  parent
>>               process as the caller of clone() (i.e., like CLONE_PARENT),
> 
> Nit: s/i.e.,/i.e./?

Actually not. "i.e." is considered equal to "for example" and the latter
would be followed by a comma.

>>               so that calls to getppid(2) return the same value  for  all
>>               of  the  threads  in  a  thread group.  When a CLONE_THREAD
>>               thread terminates, the thread that created it using clone()
>>               is  not  sent  a SIGCHLD (or other termination) signal; nor
>>               can the status of such a thread be obtained using  wait(2).
>>               (The thread is said to be detached.)
>>
>>               After  all  of  the threads in a thread group terminate the
>>               parent process of the thread group is sent  a  SIGCHLD  (or
>>               other termination) signal.
>>
>>               If  any  of  the  threads  in  a  thread  group performs an
>>               execve(2), then all threads other  than  the  thread  group
>>               leader  are  terminated, and the new program is executed in
> 
> s/is executed in/becomes the/?

Hmmm, a program is not a task, so this doesn't feel quite right.
Why don't you like the existing text?

>>               the thread group leader.
>>
>>               If one of the threads in a thread  group  creates  a  child
>>               using fork(2), then any thread in the group can wait(2) for
>>               that child.
>>
>>               Since Linux 2.5.35, flags must also  include  CLONE_SIGHAND
>>               if  CLONE_THREAD  is  specified (and note that, since Linux
>>               2.6.0,  CLONE_SIGHAND  also   requires   CLONE_VM   to   be
>>               included).
>>
>>               Signal  dispositions  and  actions  are process-wide: if an
>>               unhandled signal is delivered to a  thread,  then  it  will
>>               affect  (terminate, stop, continue, be ignored in) all mem‐
>>               bers of the thread group.
>>
>>               Each thread has its own signal mask,  as  set  by  sigproc‐
>>               mask(2).
>>
>>               A  signal  may  be  process-directed or thread-directed.  A
>>               process-directed signal  is  targeted  at  a  thread  group
>>               (i.e., a TGID), and is delivered to an arbitrarily selected
>>               thread from among those that are not blocking  the  signal.
>>               A  signal  may be process-directed because it was generated
>>               by the kernel for reasons other than a hardware  exception,
>>               or  because  it  was  sent using kill(2) or sigqueue(3).  A
>>               thread-directed signal is targeted at (i.e., delivered  to)
>>               a specific thread.  A signal may be thread directed because
>>               it was sent  using  tgkill(2)  or  pthread_sigqueue(3),  or
>>               because  the thread executed a machine language instruction
>>               that triggered a hardware exception (e.g.,  invalid  memory
>>               access  triggering  SIGSEGV  or  a floating-point exception
>>               triggering SIGFPE).
>>
>>               A call to sigpending(2) returns a signal set  that  is  the
>>               union  of the pending process-directed signals and the sig‐
>>               nals that are pending for the calling thread.
>>
>>               If a process-directed  signal  is  delivered  to  a  thread
>>               group, and the thread group has installed a handler for the
>>               signal, then the handler will be invoked  in  exactly  one,
>>               arbitrarily  selected  member  of the thread group that has
>>               not blocked the signal.  If multiple threads in a group are
>>               waiting to accept the same signal using sigwaitinfo(2), the
>>               kernel will arbitrarily select  one  of  these  threads  to
>>               receive the signal.
> 
> I won't do a deep review of the thread section now but you might want to
> mention that fatal signals always take down the whole thread-group, i.e.
> SIGKILL, SIGSEGV, etc...

That point is covered above, in the paragraph that begins: "Signal
dispositions  and  actions  are process-wide...". Does that not
suffice?

>>
>>        CLONE_UNTRACED (since Linux 2.5.46)
>>               If CLONE_UNTRACED is specified, then a tracing process can‐
>>               not force CLONE_PTRACE on this child process.
>>
>>        CLONE_VFORK (since Linux 2.2)
>>               If CLONE_VFORK is set, the execution of the calling process
>>               is  suspended  until  the child releases its virtual memory
>>               resources via a call to  execve(2)  or  _exit(2)  (as  with
>>               vfork(2)).
>>
>>               If  CLONE_VFORK  is  not set, then both the calling process
>>               and the child are schedulable after the call, and an appli‐
>>               cation  should  not rely on execution occurring in any par‐
>>               ticular order.
>>
>>        CLONE_VM (since Linux 2.0)
>>               If CLONE_VM is set,  the  calling  process  and  the  child
>>               process  run in the same memory space.  In particular, mem‐
>>               ory writes performed by the calling process or by the child
>>               process  are  also visible in the other process.  Moreover,
>>               any memory mapping or unmapping performed with  mmap(2)  or
>>               munmap(2)  by the child or calling process also affects the
>>               other process.
>>
>>               If CLONE_VM is not set, the child process runs in  a  sepa‐
>>               rate copy of the memory space of the calling process at the
>>               time of clone().  Memory writes or file mappings/unmappings
>>               performed  by one of the processes do not affect the other,
>>               as with fork(2).
>>
>> NOTES
>>        One use of these systems calls is to implement  threads:  multiple
>>        flows  of  control  in a program that run concurrently in a shared
>>        address space.
>>
>>        Glibc does not provide a  wrapper  for  clone(3);  call  it  using
> 
> s/clone(3)/clone(2)/?

Yep. Branden Robinson already reported this and I fixed it.

>>        syscall(2).
>>
>>        Note that the glibc clone() wrapper function makes some changes in
>>        the memory pointed to by stack (changes required to set the  stack
>>        up  correctly  for  the  child) before invoking the clone() system
> 
> In essence, you can't really use the clone{3}() syscall with a stack
> argument directly without having to do some assembly. 

(Yes.)

> User needing to
> mess with stacks are well-advised to use the glibc wrapper or need to
> really know what they are doing for _each_ arch they are using the
> syscall on.

I understand the issues (I think), but it's not clear to me if
you mean that some text in the manual page needs changing.

>>        call.  So, in cases where clone() is used  to  recursively  create
>>        children, do not use the buffer employed for the parent's stack as
>>        the stack of the child.
>>
>>    C library/kernel differences
>>        The raw clone() system call corresponds more closely to fork(2) in
>>        that  execution in the child continues from the point of the call.
>>        As such, the fn and arg arguments of the clone() wrapper  function
>>        are omitted.
>>
>>        Another  difference  for  the  raw clone() system call is that the
>>        stack argument may be NULL, in which case the child uses a  dupli‐
>>        cate  of the parent's stack.  (Copy-on-write semantics ensure that
> 
> That reads misleading, I think. It seems to me what you want to say is
> that the raw syscall is perfectly happy to accept a NULL stack argument
> for both clone() and clone3() but that the glibc wrapper does not allow
> that. So this should probably read:
> 
>          In contrast to the glibc wrapper the raw clone() system call
> 	 accepts NULL as stack argument. In this case the child uses a  dupli‐
>          cate  of the parent's stack.  (Copy-on-write semantics ensure that
> 
> or something similar. :)

Thanks. I made it:

       In  contrast  to  the  glibc  wrapper, the raw clone() system call
       accepts NULL as a stack argument  (and  clone3()  likewise  allows
       cl_args.stack  to be NULL).  In this case, the child uses a dupli‐
       cate of the parent's stack. [...]

>>        the child gets separate copies of stack pages when either  process
>>        modifies  the  stack.)   In  this case, for correct operation, the
>>        CLONE_VM option should not be specified.  (If the child shares the
>>        parent's  memory  because of the use of the CLONE_VM flag, then no
>>        copy-on-write duplication occurs and chaos is likely to result.)
> 
> +1 on this. This is very important to mention!
> 
>>
>>        The order of the arguments also differs in the  raw  system  call,
>>        and there are variations in the arguments across architectures, as
>>        detailed in the following paragraphs.
> 
> _sigh_ don't remind me...

arch/Kconfig -- "ABI hall of shame" :-)

>>        The raw system call interface on x86-64 and some  other  architec‐
>>        tures (including sh, tile, ia-64, and alpha) is:
>>
>>            long clone(unsigned long flags, void *stack,
>>                       int *parent_tid, int *child_tid,
>>                       unsigned long tls);
> 
> I wouldn't even mention clone() for ia64 anymore. It will _not_ work
> correctly at all. ia64 requires stack_size as it expects the stack to be
> passed pointing to the lowest address but the clone() version for ia64
> does not have a stack_size argument... So the only way to get clone() to
> work on ia64 is by using the ia64 specific clone2().

Fair enough. I removed mention of is-64 here.

>>        On  x86-32,  and  several  other  common  architectures (including
>>        score, ARM, ARM 64, PA-RISC, arc, Power PC, xtensa, and MIPS), the
>>        order of the last two arguments is reversed:
>>
>>            long clone(unsigned long flags, void *stack,
>>                      int *parent_tid, unsigned long tls,
>>                      int *child_tid);
>>
>>        On  the  cris  and  s390 architectures, the order of the first two
>>        arguments is reversed:
>>
>>            long clone(void *stack, unsigned long flags,
>>                       int *parent_tid, int *child_tid,
>>                       unsigned long tls);
>>
>>        On the microblaze architecture, an  additional  argument  is  sup‐
>>        plied:
>>
>>            long clone(unsigned long flags, void *stack,
>>                       int stack_size,         /* Size of stack */
>>                       int *parent_tid, int *child_tid,
>>                       unsigned long tls);
> 
> The additional argument is stack_size and contrary to what one would
> expect _ignored_. I.e. on microblaze one still needs to pass stack
> pointing to the top of the stack.

I added this sentence:

       Although a stack_size argument is provided, stack must still point
       to the top of the stack.

>>    blackfin, m68k, and sparc
>>        The  argument-passing conventions on blackfin, m68k, and sparc are
>>        different from the descriptions above.  For details, see the  ker‐
>>        nel (and glibc) source.
>>
>>    ia64
>>        On ia64, a different interface is used:
>>
>>            int __clone2(int (*fn)(void *),
>>                         void *stack_base, size_t stack_size,
>>                         int flags, void *arg, ...
>>                      /* pid_t *parent_tid, struct user_desc *tls,
>>                         pid_t *child_tid */ );
>>
>>        The  prototype  shown above is for the glibc wrapper function; for
>>        the system call itself, the prototype can be described as  follows
>>        (it is identical to the clone() prototype on microblaze):
>>
>>            long clone2(unsigned long flags, void *stack_base,
>>                        int stack_size,         /* Size of stack */
>>                        int *parent_tid, int *child_tid,
>>                        unsigned long tls);
>>
>>        __clone2()  operates  in  the  same  way  as  clone(), except that
>>        stack_base points to the lowest address of the child's stack area,
>>        and  stack_size  specifies  the  size  of  the stack pointed to by
>>        stack_base.
>>
>>    Linux 2.4 and earlier
>>        In Linux 2.4 and earlier, clone() does  not  take  arguments  par‐
>>        ent_tid, tls, and child_tid.
>>
>> RETURN VALUE
>>        On  success, the thread ID of the child process is returned in the
>>        caller's thread of execution.  On failure, -1 is returned  in  the
>>        caller's context, no child process will be created, and errno will
>>        be set appropriately.
>>
>> ERRORS
>>        EAGAIN Too many processes are already running; see fork(2).
>>
>>        EINVAL CLONE_SIGHAND was specified, but CLONE_VM was not.   (Since
>>               Linux 2.6.0.)
>>
>>        EINVAL CLONE_THREAD  was  specified,  but  CLONE_SIGHAND  was not.
>>               (Since Linux 2.5.35.)
>>
>>        EINVAL CLONE_THREAD was specified, but the current process  previ‐
>>               ously  called unshare(2) with the CLONE_NEWPID flag or used
>>               setns(2) to reassociate itself with a PID namespace.
>>
>>        EINVAL Both CLONE_FS and CLONE_NEWNS were specified in flags.
>>
>>        EINVAL (since Linux 3.9)
>>               Both CLONE_NEWUSER and CLONE_FS were specified in flags.
>>
>>        EINVAL Both  CLONE_NEWIPC  and  CLONE_SYSVSEM  were  specified  in
>>               flags.
>>
>>        EINVAL One  (or both) of CLONE_NEWPID or CLONE_NEWUSER and one (or
>>               both) of CLONE_THREAD or  CLONE_PARENT  were  specified  in
>>               flags.
>>
>>        EINVAL Returned  by  the glibc clone() wrapper function when fn or
>>               stack is specified as NULL.
>>
>>        EINVAL CLONE_NEWIPC was specified in flags, but the kernel was not
>>               configured   with   the  CONFIG_SYSVIPC  and  CONFIG_IPC_NS
>>               options.
>>
>>        EINVAL CLONE_NEWNET was specified in flags, but the kernel was not
>>               configured with the CONFIG_NET_NS option.
>>
>>        EINVAL CLONE_NEWPID was specified in flags, but the kernel was not
>>               configured with the CONFIG_PID_NS option.
>>
>>        EINVAL CLONE_NEWUSER was specified in flags, but  the  kernel  was
>>               not configured with the CONFIG_USER_NS option.
>>
>>        EINVAL CLONE_NEWUTS was specified in flags, but the kernel was not
>>               configured with the CONFIG_UTS_NS option.
>>
>>        EINVAL stack is not aligned to a suitable boundary for this archi‐
>>               tecture.  For example, on aarch64, stack must be a multiple
>>               of 16.
> 
> If the stack was created with mmap(NULL, ...) as outlined above this
> should be taken care of, I think.

Because mmap() will return a page-aligned address? But, see
my comments above.

>>        EINVAL CLONE_PIDFD was specified together with CLONE_DETACHED.
> 
> Should be:
> 
>          EINVAL (clone3() only)
> 	        CLONE_DETACHED was specified (only with clone3()).
> 
>          EINVAL (clone() only)
> 	         CLONE_PIDFD was specified together with CLONE_DETACHED

I made it:

       EINVAL (clone3() only)
              CLONE_DETACHED was specified in the flags mask.

       EINVAL (clone() only)
              CLONE_PIDFD  was  specified together with CLONE_DETACHED in
              the flags mask.

Okay?

>>
>>        EINVAL CLONE_PIDFD was specified together with CLONE_THREAD.
>>
>>        EINVAL (clone() only)
>>               CLONE_PIDFD was specified together  with  CLONE_PARENT_SET‐
>>               TID.
>>
>>        ENOMEM Cannot allocate sufficient memory to allocate a task struc‐
>>               ture for the child, or to copy those parts of the  caller's
>>               context that need to be copied.
>>
>>        ENOSPC (since Linux 3.7)
>>               CLONE_NEWPID  was  specified in flags, but the limit on the
>>               nesting depth of PID namespaces would have  been  exceeded;
>>               see pid_namespaces(7).
>>
>>        ENOSPC (since Linux 4.9; beforehand EUSERS)
>>               CLONE_NEWUSER  was  specified  in flags, and the call would
>>               cause the limit on the number of nested user namespaces  to
>>               be exceeded.  See user_namespaces(7).
>>
>>               From  Linux  3.11 to Linux 4.8, the error diagnosed in this
>>               case was EUSERS.
>>
>>        ENOSPC (since Linux 4.9)
>>               One of the values in flags specified the creation of a  new
>>               user  namespace,  but  doing so would have caused the limit
>>               defined by the corresponding file in /proc/sys/user  to  be
>>               exceeded.  For further details, see namespaces(7).
>>
>>        EPERM  CLONE_NEWCGROUP,  CLONE_NEWIPC,  CLONE_NEWNET, CLONE_NEWNS,
>>               CLONE_NEWPID, or CLONE_NEWUTS was specified by an  unprivi‐
>>               leged process (process without CAP_SYS_ADMIN).
>>
>>        EPERM  CLONE_PID  was specified by a process other than process 0.
>>               (This error occurs only on Linux 2.5.15 and earlier.)
>>
>>        EPERM  CLONE_NEWUSER was specified in flags, but either the effec‐
>>               tive  user  ID or the effective group ID of the caller does
>>               not have a mapping in the parent namespace (see user_names‐
>>               paces(7)).
>>
>>        EPERM (since Linux 3.9)
>>               CLONE_NEWUSER was specified in flags and the caller is in a
>>               chroot environment (i.e., the caller's root directory  does
>>               not  match  the  root  directory  of the mount namespace in
>>               which it resides).
>>
>>        ERESTARTNOINTR (since Linux 2.6.17)
>>               System call  was  interrupted  by  a  signal  and  will  be
>>               restarted.  (This can be seen only during a trace.)
>>
>>        EUSERS (Linux 3.11 to Linux 4.8)
>>               CLONE_NEWUSER  was specified in flags, and the limit on the
>>               number of nested user namespaces would  be  exceeded.   See
>>               the discussion of the ENOSPC error above.
>>
>> VERSIONS
>>        The clone3() system call first appeared in Linux 5.3.
>>
>> CONFORMING TO
>>        These  system  calls  are Linux-specific and should not be used in
>>        programs intended to be portable.
>>
>> NOTES
>>        The kcmp(2) system call can be used to test whether two  processes
>>        share  various resources such as a file descriptor table, System V
>>        semaphore undo operations, or a virtual address space.
>>
>>        Handlers registered using pthread_atfork(3) are not executed  dur‐
>>        ing a call to clone().
>>
>>        In  the  Linux  2.4.x series, CLONE_THREAD generally does not make
>>        the parent of the new thread the same as the parent of the calling
>>        process.   However,  for  kernel  versions  2.4.7  to  2.4.18  the
>>        CLONE_THREAD flag implied the CLONE_PARENT flag (as in Linux 2.6.0
>>        and later).
>>
>>        For  a while there was CLONE_DETACHED (introduced in 2.5.32): par‐
>>        ent wants no child-exit signal.  In Linux 2.6.2, the need to  give
>>        this  flag  together  with CLONE_THREAD disappeared.  This flag is
>>        still defined, but has no effect.
> 
> This is clone() specific and not true when passed together with
> CLONE_PIDFD. clone3() will EINVAL all instances where CLONE_DETACHED is
> passed.

Yes. See above. The paragraph just above has now been removed from
the page, in favor of the other text that I added (as described above).

>>
>>        On i386, clone()  should  not  be  called  through  vsyscall,  but
>>        directly through int $0x80.
>>
>> BUGS
>>        GNU  C library versions 2.3.4 up to and including 2.24 contained a
>>        wrapper function for getpid(2) that  performed  caching  of  PIDs.
>>        This  caching  relied on support in the glibc wrapper for clone(),
>>        but limitations in the implementation meant that the cache was not
>>        up  to date in some circumstances.  In particular, if a signal was
>>        delivered to the child immediately after the clone() call, then  a
>>        call to getpid(2) in a handler for the signal could return the PID
>>        of the calling process ("the parent"), if the  clone  wrapper  had
>>        not  yet had a chance to update the PID cache in the child.  (This
>>        discussion ignores the case where  the  child  was  created  using
>>        CLONE_THREAD,  when  getpid(2) should return the same value in the
>>        child and in the process that called clone(), since the caller and
>>        the  child  are in the same thread group.  The stale-cache problem
>>        also does not occur if the flags argument includes CLONE_VM.)   To
>>        get  the truth, it was sometimes necessary to use code such as the
>>        following:
>>
>>            #include <syscall.h>
>>
>>            pid_t mypid;
>>
>>            mypid = syscall(SYS_getpid);
>>
>>        Because of the stale-cache problem,  as  well  as  other  problems
>>        noted  in  getpid(2), the PID caching feature was removed in glibc
>>        2.25.
>>
>> EXAMPLE
>>        The following program demonstrates the use of clone() to create  a
>>        child  process  that  executes  in  a separate UTS namespace.  The
>>        child changes the hostname in its UTS namespace.  Both parent  and
>>        child  then display the system hostname, making it possible to see
>>        that the hostname differs in the UTS namespaces of the parent  and
>>        child.  For an example of the use of this program, see setns(2).
>>
>>    Program source
>>        #define _GNU_SOURCE
>>        #include <sys/wait.h>
>>        #include <sys/utsname.h>
>>        #include <sched.h>
>>        #include <string.h>
>>        #include <stdio.h>
>>        #include <stdlib.h>
>>        #include <unistd.h>
>>
>>        #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>>                                } while (0)
>>
>>        static int              /* Start function for cloned child */
>>        childFunc(void *arg)
>>        {
>>            struct utsname uts;
>>
>>            /* Change hostname in UTS namespace of child */
>>
>>            if (sethostname(arg, strlen(arg)) == -1)
>>                errExit("sethostname");
>>
>>            /* Retrieve and display hostname */
>>
>>            if (uname(&uts) == -1)
>>                errExit("uname");
>>            printf("uts.nodename in child:  %s\n", uts.nodename);
>>
>>            /* Keep the namespace open for a while, by sleeping.
>>               This allows some experimentation--for example, another
>>               process might join the namespace. */
>>
>>            sleep(200);
>>
>>            return 0;           /* Child terminates now */
>>        }
>>
>>        #define STACK_SIZE (1024 * 1024)    /* Stack size for cloned child */
>>
>>        int
>>        main(int argc, char *argv[])
>>        {
>>            char *stack;                    /* Start of stack buffer */
>>            char *stackTop;                 /* End of stack buffer */
>>            pid_t pid;
>>            struct utsname uts;
>>
>>            if (argc < 2) {
>>                fprintf(stderr, "Usage: %s <child-hostname>\n", argv[0]);
>>                exit(EXIT_SUCCESS);
>>            }
>>
>>            /* Allocate stack for child */
>>
>>            stack = malloc(STACK_SIZE);
> 
> I'd really change this to mmap() since it makes some of the requirements
> more obvious including the MAP_STACK flag.

See my comments above. 

Thanks for the detailed feedback, Christian!

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
