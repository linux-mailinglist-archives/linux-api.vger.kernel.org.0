Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF720405B
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 21:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgFVT3X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 15:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgFVT3V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 15:29:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F81CC061573;
        Mon, 22 Jun 2020 12:29:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s23so8848403pfh.7;
        Mon, 22 Jun 2020 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3JuTEjghAicVhpP3vjlU6kU69UJKgziUDQvHvBQ/uI=;
        b=efQqQCrRNUbPpgGdNX2jRo5CzXLCC/ONYkjNXtWepdaBWgqdqJqe7ZjD2CE0vuSq1G
         IsF6whri9Ib4WlPiXBBrKClRl3OnDT/Jxt0e6HJEQxPV+21+0q+yAEYI9/0VASvfHzaQ
         dzG+h8eSs2AadPiWNd24KAtNqVSltBlNvGa15tbOgISOa3C3RNGwsenIp5Cwq//BA21k
         kPMI2n+5E9WqUSd4MqBr2ACnid6mU4XUN8NM9vliVBXtqAggJn4V0XIGoxSySJKgTO0s
         OoswG38fK4tvVvoK6szJwspaJ4MXkhbVt/JjRN890saVxrIh8/ydLgugPQ+qW9KrXdSZ
         Wa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q3JuTEjghAicVhpP3vjlU6kU69UJKgziUDQvHvBQ/uI=;
        b=HxP5j/4NRmMkBXHHiTyfJABx2vFmxJDHiNlKcn/hwxdk4H9FbEQFsml7OiTJz1lSXl
         z9cF6gbb9ZgKkmvwGj+KOzrOeK5kNIl67u1TI/BcLYoaSVAdvRdTD+8eLj9sULejMhwf
         2fFWstBEBjIDqBYBKwU6+CDkWdk32aGRrSrT8jxRuJOao/8o/fvtNUWFtqpAIVKx54QH
         zhOW7KvLmOexlSkZcinIfaSKtgx9vBoEkthiNbwKs6Gu6cfuy6FdL3fWVDpk16pPeEPC
         TQZnk4LW+nSXgq2ndqN7QGll4ipL4aWsbcFVhFvh9I3vASaBZ610FCZX3VWjJ/uOy0RH
         Nd2Q==
X-Gm-Message-State: AOAM532wsxQllMfgE7J9UuxcutXrcCWl9Y5NeFlXM3rSPIlVPMRbcABD
        aDOXQaKm9ZreCHzvwUcCltg=
X-Google-Smtp-Source: ABdhPJxsEb+Njf2Ib1Eq+o7glFyLevlLb4Kh7MSI1HSp2QXlfJtDyyfHc4DRcUK70WMUQtH5QM6SQA==
X-Received: by 2002:a63:6cd:: with SMTP id 196mr10455265pgg.169.1592854160491;
        Mon, 22 Jun 2020 12:29:20 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id mu17sm264603pjb.53.2020.06.22.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:29:18 -0700 (PDT)
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
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall: an external memory hinting API
Date:   Mon, 22 Jun 2020 12:28:59 -0700
Message-Id: <20200622192900.22757-4-minchan@kernel.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622192900.22757-1-minchan@kernel.org>
References: <20200622192900.22757-1-minchan@kernel.org>
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

If someone want to add other hints, we could hear hear the usecase and
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
Link: http://lkml.kernel.org/r/20200302193630.68771-3-minchan@kernel.org
Link: http://lkml.kernel.org/r/20200508183320.GA125527@google.com
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 include/linux/compat.h                      |   4 +
 include/linux/syscalls.h                    |   2 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/sys_ni.c                             |   2 +
 mm/madvise.c                                | 121 ++++++++++++++++++++
 23 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 0aea820a4851..2e156975f573 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -482,3 +482,4 @@
 550	common	watch_mount			sys_watch_mount
 551	common	watch_sb			sys_watch_sb
 552	common	fsinfo				sys_fsinfo
+553	common	process_madvise			sys_process_madvise
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 74fec675e2fe..b166a5383a60 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -456,3 +456,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 949788f5ba40..d1f7d35f986e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		443
+#define __NR_compat_syscalls		444
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 629fe05d7e7d..a377aff42d39 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -893,6 +893,8 @@ __SYSCALL(__NR_watch_mount, sys_watch_mount)
 __SYSCALL(__NR_watch_sb, sys_watch_sb)
 #define __NR_fsinfo 442
 __SYSCALL(__NR_fsinfo, sys_fsinfo)
+#define __NR_fsinfo 443
+__SYSCALL(__NR_process_madvise, compat_sys_process_madvise)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 7c9e0dba2647..71337e11f01c 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -363,3 +363,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 0516e5eee098..460fb0f9bb4b 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 669584129d71..a95897a4ea76 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -448,3 +448,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 2aac2722ca74..5ede2681f4e1 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -381,3 +381,4 @@
 440	n32	watch_mount			sys_watch_mount
 441	n32	watch_sb			sys_watch_sb
 442	n32	fsinfo				sys_fsinfo
+443	n32	process_madvise			compat_sys_process_madvise
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 1f854c23c5b5..daa607c4afe6 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -357,3 +357,4 @@
 440	n64	watch_mount			sys_watch_mount
 441	n64	watch_sb			sys_watch_sb
 442	n64	fsinfo				sys_fsinfo
+443	n64	process_madvise			sys_process_madvise
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 0b59ec2dbfcb..0dffd81fb345 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -430,3 +430,4 @@
 440	o32	watch_mount			sys_watch_mount
 441	o32	watch_sb			sys_watch_sb
 442	o32	fsinfo				sys_fsinfo
+443	o32	process_madvise			sys_process_madvise		compat_sys_process_madvise
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 68d10778b7ae..09ac0b4aac30 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise		compat_sys_process_madvise
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 1adfad158267..3a1fecc30987 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -487,3 +487,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise		compat_sys_process_madvise
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 9104f034129d..068310185c50 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -445,3 +445,4 @@
 440	common	watch_mount		sys_watch_mount			sys_watch_mount
 441	common	watch_sb		sys_watch_sb			sys_watch_sb
 442  common	fsinfo			sys_fsinfo			sys_fsinfo
+443	common	process_madvise		sys_process_madvise		compat_sys_process_madvise
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 1ce9c9473904..792539111ed8 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -445,3 +445,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 7c0d97dffd35..4f8eebfcd07e 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -488,3 +488,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise		compat_sys_process_madvise
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index f1295eae4ba8..29e49a70c99e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -447,3 +447,4 @@
 440	i386	watch_mount		sys_watch_mount
 441	i386	watch_sb		sys_watch_sb
 442	i386	fsinfo			sys_fsinfo
+443	i386	process_madvise		sys_process_madvise		compat_sys_process_madvise
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 94bf4958d114..8f959d90338a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -364,6 +364,7 @@
 440	common	watch_mount		sys_watch_mount
 441	common	watch_sb		sys_watch_sb
 442	common	fsinfo			sys_fsinfo
+443	64	process_madvise		sys_process_madvise
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
@@ -407,3 +408,4 @@
 545	x32	execveat		compat_sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
+548	x32	process_madvise		compat_sys_process_madvise
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 7eb1d01127f4..173bd27f61dd 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -413,3 +413,4 @@
 440	common	watch_mount			sys_watch_mount
 441	common	watch_sb			sys_watch_sb
 442	common	fsinfo				sys_fsinfo
+443	common	process_madvise			sys_process_madvise
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 605a95fc5b31..4b48b6c49637 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -827,6 +827,10 @@ asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
 		unsigned long vlen, loff_t pos, rwf_t flags);
 #endif
 
+asmlinkage ssize_t compat_sys_process_madvise(compat_int_t pidfd,
+		const struct compat_iovec __user *vec,
+		compat_ulong_t vlen, compat_int_t behavior,
+		compat_uint_t flags);
 
 /*
  * Deprecated system calls which are still defined in
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3b922deee72e..35cd2c0e7665 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -880,6 +880,8 @@ asmlinkage long sys_munlockall(void);
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 				unsigned char __user * vec);
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
+asmlinkage long sys_process_madvise(int pidfd, const struct iovec __user *vec,
+		unsigned long vlen, int behavior, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 25b1bdfb3e97..367cf21d0292 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -865,9 +865,11 @@ __SYSCALL(__NR_watch_mount, sys_watch_mount)
 __SYSCALL(__NR_watch_sb, sys_watch_sb)
 #define __NR_fsinfo 442
 __SYSCALL(__NR_fsinfo, sys_fsinfo)
+#define __NR_fsinfo 443
+__SC_COMP(__NR_process_madvise, sys_process_madvise, compat_sys_process_madvise)
 
 #undef __NR_syscalls
-#define __NR_syscalls 443
+#define __NR_syscalls 444
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f51a1e1a3c32..c935c1819ba3 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -287,6 +287,8 @@ COND_SYSCALL(mlockall);
 COND_SYSCALL(munlockall);
 COND_SYSCALL(mincore);
 COND_SYSCALL(madvise);
+COND_SYSCALL(process_madvise);
+COND_SYSCALL_COMPAT(process_madvise);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
 COND_SYSCALL_COMPAT(mbind);
diff --git a/mm/madvise.c b/mm/madvise.c
index 551ed816eefe..23abca3f93fa 100644
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
@@ -995,6 +996,18 @@ madvise_behavior_valid(int behavior)
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
@@ -1042,6 +1055,11 @@ madvise_behavior_valid(int behavior)
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
@@ -1176,3 +1194,106 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
 	return do_madvise(current, current->mm, start, len_in, behavior);
 }
+
+static int process_madvise_vec(struct task_struct *target_task,
+		struct mm_struct *mm, struct iov_iter *iter, int behavior)
+{
+	struct iovec iovec;
+	int ret = 0;
+
+	while (iov_iter_count(iter)) {
+		iovec = iov_iter_iovec(iter);
+		ret = do_madvise(target_task, mm, (unsigned long)iovec.iov_base,
+					iovec.iov_len, behavior);
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
+	ret = process_madvise_vec(task, mm, iter, behavior);
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
+SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
+		unsigned long, vlen, int, behavior, unsigned int, flags)
+{
+	ssize_t ret;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov = iovstack;
+	struct iov_iter iter;
+
+	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	if (ret >= 0) {
+		ret = do_process_madvise(pidfd, &iter, behavior, flags);
+		kfree(iov);
+	}
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE5(process_madvise, compat_int_t, pidfd,
+			const struct compat_iovec __user *, vec,
+			compat_ulong_t, vlen,
+			compat_int_t, behavior,
+			compat_uint_t, flags)
+
+{
+	ssize_t ret;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov = iovstack;
+	struct iov_iter iter;
+
+	ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
+				&iov, &iter);
+	if (ret >= 0) {
+		ret = do_process_madvise(pidfd, &iter, behavior, flags);
+		kfree(iov);
+	}
+	return ret;
+}
+#endif
-- 
2.27.0.111.gc72c7da667-goog

