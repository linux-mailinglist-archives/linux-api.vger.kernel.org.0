Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2E2584A8
	for <lists+linux-api@lfdr.de>; Tue,  1 Sep 2020 02:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIAAIE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 31 Aug 2020 20:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIAAHz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 31 Aug 2020 20:07:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4ABC061573;
        Mon, 31 Aug 2020 17:07:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c15so4045738plq.4;
        Mon, 31 Aug 2020 17:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRhlKsjH35KaXYFjcU4lt/tZ0GbvBHn7uFQg96aqkQw=;
        b=MNqNFd2tbZELWPHD8SqpnalRqlKX/C7mB9dtIUaAekXRyn1FW42sxVfXSxVYVbyDJs
         yjcu/uf6nOl7w+FQAsbsDySyTapiVXVGXeSnj3NcvKcNaYci0WG8cYMCdZvI3Okxkb5v
         4CQ1ScZD5c/mBQBv+Sr7tD1LdGTVBDJ4eFgGwdTJmfk9mvl4qsOYqwVh3j3v8i2giBNU
         P3FLdtqziYE8vE7DYFa8Hs7g3Bi769/dIZBpfKkC68XL5jKssSgBNsYYdT6jT/SPT7pg
         NJAq+f0f0KnbOUmoVhyRjqz21mEZnPt3Gz3nkjNk0getL9MyD6qYLdy/VNhK31ItvWYf
         t9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RRhlKsjH35KaXYFjcU4lt/tZ0GbvBHn7uFQg96aqkQw=;
        b=ubSxq54zM+tSwH/VeERWUFs2QDTnfqJ2BzA1/z8i4OzmsE0PN5GH9w79Mvi3l7U5G+
         TsbkFWsqTZ4pEPzAUFLP3qIC7dLQo5KsWoLEnv9w5b56wWN2RF8crYPPniqE9YMoj1Oj
         ZH9l3lbaQX4wndGE4ndGGBoLv47rV5ZTnUqI5IXvHNUbOWlHZ3WldeyiUnTRqXqX1vdM
         L1XPpb8CFEZx2a1AwSfHlTT7QUuRARMqDO6lF+iYAAcc6plDKO8n3Pl/q+kQLDWA/96U
         aeqVvSysPt8MiZNrtsJXc/0RIFECgO77WP2L+MqTiYF/17fMxUZxqRCWIzUcEX/xIDzX
         t7Bg==
X-Gm-Message-State: AOAM533SN2SLepbiCmB8XV6aKfmvK7q6yA7A2uFDiDIiXiPT7VVxDvdB
        U4qCScM/p++osmSYYRPKZMU=
X-Google-Smtp-Source: ABdhPJzaQYg5LC/YRZ+oM8lPFv3XZZQPxe9xG4XkOxTND4xcMucifLwPe/8BuOaHenDDm2wcfwYCEA==
X-Received: by 2002:a17:90a:f683:: with SMTP id cl3mr1693652pjb.124.1598918873975;
        Mon, 31 Aug 2020 17:07:53 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id k5sm769777pjq.5.2020.08.31.17.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 17:07:53 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: [PATCH v9 3/3] mm/madvise: introduce process_madvise() syscall: an external memory hinting API
Date:   Mon, 31 Aug 2020 17:06:33 -0700
Message-Id: <20200901000633.1920247-4-minchan@kernel.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901000633.1920247-1-minchan@kernel.org>
References: <20200901000633.1920247-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There is usecase that System Management Software(SMS) want to give a
memory hint like MADV_[COLD|PAGEEOUT] to other processes and in the
case of Android, it is the ActivityManagerService.

The information required to make the reclaim decision is not known to
the app.  Instead, it is known to the centralized userspace
daemon(ActivityManagerService), and that daemon must be able to
initiate reclaim on its own without any app involvement.

To solve the issue, this patch introduces a new syscall process_madvise(2).
It uses pidfd of an external process to give the hint. It also supports
vector address range because Android app has thousands of vmas due to
zygote so it's totally waste of CPU and power if we should call the
syscall one by one for each vma.(With testing 2000-vma syscall vs
1-vector syscall, it showed 15% performance improvement.  I think it
would be bigger in real practice because the testing ran very cache
friendly environment).

Another potential use case for the vector range is to amortize the cost
ofTLB shootdowns for multiple ranges when using MADV_DONTNEED; this
could benefit users like TCP receive zerocopy and malloc implementations.
In future, we could find more usecases for other advises so let's make it
happens as API since we introduce a new syscall at this moment.  With
that, existing madvise(2) user could replace it with process_madvise(2)
with their own pid if they want to have batch address ranges support
feature.

ince it could affect other process's address range, only privileged
process(PTRACE_MODE_ATTACH_FSCREDS) or something else(e.g., being the
same UID) gives it the right to ptrace the process could use it
successfully. The flag argument is reserved for future use if we need to
extend the API.

I think supporting all hints madvise has/will supported/support to
process_madvise is rather risky.  Because we are not sure all hints
make sense from external process and implementation for the hint may
rely on the caller being in the current context so it could be
error-prone.  Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this
patch.

If someone want to add other hints, we could hear the usecase and
review it for each hint.  It's safer for maintenance rather than
introducing a buggy syscall but hard to fix it later.

So finally, the API is as follows,

      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
                unsigned long vlen, int advice, unsigned int flags);

    DESCRIPTION
      The process_madvise() system call is used to give advice or directions
      to the kernel about the address ranges from external process as well as
      local process. It provides the advice to address ranges of process
      described by iovec and vlen. The goal of such advice is to improve system
      or application performance.

      The pidfd selects the process referred to by the PID file descriptor
      specified in pidfd. (See pidofd_open(2) for further information)

      The pointer iovec points to an array of iovec structures, defined in
      <sys/uio.h> as:

        struct iovec {
            void *iov_base;         /* starting address */
            size_t iov_len;         /* number of bytes to be advised */
        };

      The iovec describes address ranges beginning at address(iov_base)
      and with size length of bytes(iov_len).

      The vlen represents the number of elements in iovec.

      The advice is indicated in the advice argument, which is one of the
      following at this moment if the target process specified by pidfd is
      external.

        MADV_COLD
        MADV_PAGEOUT

      Permission to provide a hint to external process is governed by a
      ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).

      The process_madvise supports every advice madvise(2) has if target
      process is in same thread group with calling process so user could
      use process_madvise(2) to extend existing madvise(2) to support
      vector address ranges.

    RETURN VALUE
      On success, process_madvise() returns the number of bytes advised.
      This return value may be less than the total number of requested
      bytes, if an error occurred. The caller should check return value
      to determine whether a partial advice occurred.

FAQ:

Q.1 - Why does any external entity have better knowledge?

Quote from Sandeep

"For Android, every application (including the special SystemServer)
are forked from Zygote.  The reason of course is to share as many
libraries and classes between the two as possible to benefit from the
preloading during boot.

After applications start, (almost) all of the APIs end up calling into
this SystemServer process over IPC (binder) and back to the
application.

In a fully running system, the SystemServer monitors every single
process periodically to calculate their PSS / RSS and also decides
which process is "important" to the user for interactivity.

So, because of how these processes start _and_ the fact that the
SystemServer is looping to monitor each process, it does tend to *know*
which address range of the application is not used / useful.

Besides, we can never rely on applications to clean things up
themselves.  We've had the "hey app1, the system is low on memory,
please trim your memory usage down" notifications for a long time[1].
They rely on applications honoring the broadcasts and very few do.

So, if we want to avoid the inevitable killing of the application and
restarting it, some way to be able to tell the OS about unimportant
memory in these applications will be useful.

- ssp

Q.2 - How to guarantee the race(i.e., object validation) between when
giving a hint from an external process and get the hint from the target
process?

process_madvise operates on the target process's address space as it
exists at the instant that process_madvise is called.  If the space
target process can run between the time the process_madvise process
inspects the target process address space and the time that
process_madvise is actually called, process_madvise may operate on
memory regions that the calling process does not expect.  It's the
responsibility of the process calling process_madvise to close this
race condition.  For example, the calling process can suspend the
target process with ptrace, SIGSTOP, or the freezer cgroup so that it
doesn't have an opportunity to change its own address space before
process_madvise is called.  Another option is to operate on memory
regions that the caller knows a priori will be unchanged in the target
process.  Yet another option is to accept the race for certain
process_madvise calls after reasoning that mistargeting will do no
harm.  The suggested API itself does not provide synchronization.  It
also apply other APIs like move_pages, process_vm_write.

The race isn't really a problem though.  Why is it so wrong to require
that callers do their own synchronization in some manner?  Nobody
objects to write(2) merely because it's possible for two processes to
open the same file and clobber each other's writes --- instead, we tell
people to use flock or something.  Think about mmap.  It never
guarantees newly allocated address space is still valid when the user
tries to access it because other threads could unmap the memory right
before.  That's where we need synchronization by using other API or
design from userside.  It shouldn't be part of API itself.  If someone
needs more fine-grained synchronization rather than process level,
there were two ideas suggested - cookie[2] and anon-fd[3].  Both are
applicable via using last reserved argument of the API but I don't
think it's necessary right now since we have already ways to prevent
the race so don't want to add additional complexity with more
fine-grained optimization model.

To make the API extend, it reserved an unsigned long as last argument
so we could support it in future if someone really needs it.

Q.3 - Why doesn't ptrace work?

Injecting an madvise in the target process using ptrace would not work
for us because such injected madvise would have to be executed by the
target process, which means that process would have to be runnable and
that creates the risk of the abovementioned race and hinting a wrong
VMA.  Furthermore, we want to act the hint in caller's context, not the
callee's, because the callee is usually limited in cpuset/cgroups or
even freezed state so they can't act by themselves quick enough, which
causes more thrashing/kill.  It doesn't work if the target process are
ptraced(e.g., strace, debugger, minidump) because a process can have at
most one ptracer.

[1] https://developer.android.com/topic/performance/memory"

[2] process_getinfo for getting the cookie which is updated whenever
    vma of process address layout are changed - Daniel Colascione -
    https://lore.kernel.org/lkml/20190520035254.57579-1-minchan@kernel.org/T/#m7694416fd179b2066a2c62b5b139b14e3894e224

[3] anonymous fd which is used for the object(i.e., address range)
    validation - Michal Hocko -
    https://lore.kernel.org/lkml/20200120112722.GY18451@dhcp22.suse.cz/

[minchan@kernel.org: fix process_madvise build break for arm64]
  Link: http://lkml.kernel.org/r/20200303145756.GA219683@google.com
[minchan@kernel.org: fix build error for mips of process_madvise]
  Link: http://lkml.kernel.org/r/20200508052517.GA197378@google.com
[akpm@linux-foundation.org: fix patch ordering issue]
[akpm@linux-foundation.org: fix arm64 whoops]
Link: http://lkml.kernel.org/r/20200302193630.68771-3-minchan@kernel.org
Link: http://lkml.kernel.org/r/20200508183320.GA125527@google.com
Link: http://lkml.kernel.org/r/20200622192900.22757-4-minchan@kernel.org
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Daniel Colascione <dancol@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Dias <joaodias@google.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Sonny Rao <sonnyrao@google.com>
Cc: Tim Murray <timmurray@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: <linux-man@vger.kernel.org>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 include/linux/syscalls.h                    |   2 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/sys_ni.c                             |   1 +
 mm/madvise.c                                | 109 ++++++++++++++++++++
 21 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 805d2ca50b4d..160cb7c46db0 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -480,3 +480,4 @@
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	faccessat2			sys_faccessat2
 550	common	watch_mount			sys_watch_mount
+551	common	process_madvise			sys_process_madvise
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 974d25b28316..3d3a3fe6931e 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -454,3 +454,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index b3b2019f8d16..86a9d7b3eabe 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		441
+#define __NR_compat_syscalls		442
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 30e0cb686071..ef98f5e2300c 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -889,6 +889,8 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_watch_mount 440
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
+#define __NR_watch_mount 441
+__SYSCALL(__NR_process_madvise, sys_process_madvise)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index f27af175bc75..7e30a024062b 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -361,3 +361,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 25db9c8e412e..3b237088ef9c 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index e74adc19b288..fbbe9ad06f14 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -446,3 +446,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 4f51890c8eeb..05513235b7a9 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -379,3 +379,4 @@
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	faccessat2			sys_faccessat2
 440	n32	watch_mount			sys_watch_mount
+441	n32	process_madvise			sys_process_madvise
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 608922cddddb..f3d1fb1c5626 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -428,3 +428,4 @@
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	faccessat2			sys_faccessat2
 440	o32	watch_mount			sys_watch_mount
+441	o32	process_madvise			sys_process_madvise
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 714e5359e259..94d1f465f82a 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 07c1ab563b78..1bd3de01b87f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -530,3 +530,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 957a776b8646..9ed96b429ba9 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -443,3 +443,4 @@
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440	common	watch_mount		sys_watch_mount			sys_watch_mount
+441  common	process_madvise		sys_process_madvise		sys_process_madvise
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 6de03fe8c589..17147784ac47 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -443,3 +443,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index a14b56b56dbd..320f49cfd1e8 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -486,3 +486,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 54560f3035f7..805cd33d483c 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -445,3 +445,4 @@
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
 440	i386	watch_mount		sys_watch_mount
+441	i386	process_madvise		sys_process_madvise
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f08845dbfaa1..1dfad1dd7ec8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -362,6 +362,7 @@
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
 440	common	watch_mount		sys_watch_mount
+441	common	process_madvise		sys_process_madvise
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index de025a07d958..3e65f24adfe1 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -411,3 +411,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	watch_mount			sys_watch_mount
+441	common	process_madvise			sys_process_madvise
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2ba46d811fe8..0c486cf267cf 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -879,6 +879,8 @@ asmlinkage long sys_munlockall(void);
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 				unsigned char __user * vec);
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
+asmlinkage long sys_process_madvise(int pidfd, const struct iovec __user *vec,
+			unsigned long vlen, int behavior, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index b9285f261a9e..e678a93f55ec 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -861,9 +861,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_watch_mount 440
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
+#define __NR_watch_mount 441
+__SYSCALL(__NR_process_madvise, sys_process_madvise)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 66e05c695842..10c32a2f4864 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -283,6 +283,7 @@ COND_SYSCALL(mlockall);
 COND_SYSCALL(munlockall);
 COND_SYSCALL(mincore);
 COND_SYSCALL(madvise);
+COND_SYSCALL(process_madvise);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
 COND_SYSCALL_COMPAT(mbind);
diff --git a/mm/madvise.c b/mm/madvise.c
index 3bf5c8261f1c..54ea958a6f3b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -17,6 +17,7 @@
 #include <linux/falloc.h>
 #include <linux/fadvise.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/ksm.h>
 #include <linux/fs.h>
 #include <linux/file.h>
@@ -989,6 +990,18 @@ madvise_behavior_valid(int behavior)
 	}
 }
 
+static bool
+process_madvise_behavior_valid(int behavior)
+{
+	switch (behavior) {
+	case MADV_COLD:
+	case MADV_PAGEOUT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * The madvise(2) system call.
  *
@@ -1036,6 +1049,11 @@ madvise_behavior_valid(int behavior)
  *  MADV_DONTDUMP - the application wants to prevent pages in the given range
  *		from being included in its core dump.
  *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
+ *  MADV_COLD - the application is not expected to use this memory soon,
+ *		deactivate pages in this range so that they can be reclaimed
+ *		easily if memory pressure hanppens.
+ *  MADV_PAGEOUT - the application is not expected to use this memory soon,
+ *		page out the pages in this range immediately.
  *
  * return values:
  *  zero    - success
@@ -1152,3 +1170,94 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
 	return do_madvise(current->mm, start, len_in, behavior);
 }
+
+static int process_madvise_vec(struct mm_struct *mm, struct iov_iter *iter, int behavior)
+{
+	struct iovec iovec;
+	int ret = 0;
+
+	while (iov_iter_count(iter)) {
+		iovec = iov_iter_iovec(iter);
+		ret = do_madvise(mm, (unsigned long)iovec.iov_base, iovec.iov_len, behavior);
+		if (ret < 0)
+			break;
+		iov_iter_advance(iter, iovec.iov_len);
+	}
+
+	return ret;
+}
+
+static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
+				int behavior, unsigned int flags)
+{
+	ssize_t ret;
+	struct pid *pid;
+	struct task_struct *task;
+	struct mm_struct *mm;
+	size_t total_len = iov_iter_count(iter);
+
+	if (flags != 0)
+		return -EINVAL;
+
+	pid = pidfd_get_pid(pidfd);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		ret = -ESRCH;
+		goto put_pid;
+	}
+
+	if (task->mm != current->mm &&
+			!process_madvise_behavior_valid(behavior)) {
+		ret = -EINVAL;
+		goto release_task;
+	}
+
+	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	if (IS_ERR_OR_NULL(mm)) {
+		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+		goto release_task;
+	}
+
+	ret = process_madvise_vec(mm, iter, behavior);
+	if (ret >= 0)
+		ret = total_len - iov_iter_count(iter);
+
+	mmput(mm);
+release_task:
+	put_task_struct(task);
+put_pid:
+	put_pid(pid);
+	return ret;
+}
+
+static inline int madv_import_iovec(int type, const struct iovec __user *uvec, unsigned int nr_segs,
+		unsigned int fast_segs, struct iovec **iov, struct iov_iter *i)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return compat_import_iovec(type, (struct compat_iovec __user *)uvec, nr_segs,
+				fast_segs, iov, i);
+#endif
+
+	return import_iovec(type, uvec, nr_segs, fast_segs, iov, i);
+}
+
+SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
+		unsigned long, vlen, int, behavior, unsigned int, flags)
+{
+	ssize_t ret;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov = iovstack;
+	struct iov_iter iter;
+
+	ret = madv_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	if (ret < 0)
+		return ret;
+
+	ret = do_process_madvise(pidfd, &iter, behavior, flags);
+	kfree(iov);
+	return ret;
+}
-- 
2.28.0.402.g5ffc5be6b7-goog

