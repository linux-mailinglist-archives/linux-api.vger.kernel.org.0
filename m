Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B60203EC8
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgFVSIT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 14:08:19 -0400
Received: from mail.efficios.com ([167.114.26.124]:35302 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgFVSIR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 14:08:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 038602B7002;
        Mon, 22 Jun 2020 14:08:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KHvBAp9-wRWn; Mon, 22 Jun 2020 14:08:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A414A2B6A2F;
        Mon, 22 Jun 2020 14:08:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A414A2B6A2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1592849289;
        bh=j5KylElY3N5ea/Yd7h8DFP6AcmAqq1nwIKJ8D7+cOO0=;
        h=From:To:Date:Message-Id;
        b=X1bZVcBXZthlPRtUvdWAZtOt1lOoeyrLNs1x2bGVj76bl0BgrMQyAjm62hZSmAwlz
         5pXQUsH+q6q6qQVa9sb4SQfcEGttoFYbZIKzT6atTk+tzBm9VrDqoVPOsFqDbVg6Ao
         UdAzYkNQXoTQkrnxKYbMvaIr9rXHFGYBtKPg1lh/SgZ+rj6SFfcnciVwnwRui+Xqxo
         IiV0cUoXYqrJNCJoa64FEF3jiqLq9nR1xi2bfGbOi6uMeIToQde3WAGrta7Otd9zkt
         9Hnp8j6CniOODXIHGX4Vja+UxDBK/DxZ5GjbZV4Lpt/JCpSLkxe9dsub5/lBJ7GiYA
         20T0P7Kg04TwQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sD5K8W6NEWjS; Mon, 22 Jun 2020 14:08:09 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 261202B6FBD;
        Mon, 22 Jun 2020 14:08:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH 1/3] glibc: Perform rseq registration at C startup and thread creation (v21)
Date:   Mon, 22 Jun 2020 14:08:01 -0400
Message-Id: <20200622180803.1449-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622180803.1449-1-mathieu.desnoyers@efficios.com>
References: <20200622180803.1449-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Register rseq TLS for each thread (including main), and unregister for
each thread (excluding main).  "rseq" stands for Restartable Sequences.

See the rseq(2) man page proposed here:
  https://lkml.org/lkml/2018/9/19/647

Those are based on glibc master branch commit c013d5d3aa.
The rseq system call was merged into Linux 4.18.

The TLS_STATIC_SURPLUS define is increased to leave additional room for
dlopen'd initial-exec TLS, which keeps elf/tst-auditmany working.

The increase (76 bytes) is larger than 32 bytes because it has not been
increased in quite a while.  The cost in terms of additional TLS storage
is quite significant, but it will also obscure some initial-exec-related
dlopen failures.

CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
CC: Joseph Myers <joseph@codesourcery.com>
CC: Szabolcs Nagy <szabolcs.nagy@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ben Maurer <bmaurer@fb.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Dave Watson <davejwatson@fb.com>
CC: Paul Turner <pjt@google.com>
CC: Rich Felker <dalias@libc.org>
CC: libc-alpha@sourceware.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
---
Changes since v1:
- Move __rseq_refcount to an extra field at the end of __rseq_abi to
  eliminate one symbol.

  All libraries/programs which try to register rseq (glibc,
  early-adopter applications, early-adopter libraries) should use the
  rseq refcount.  It becomes part of the ABI within a user-space
  process, but it's not part of the ABI shared with the kernel per se.

- Restructure how this code is organized so glibc keeps building on
  non-Linux targets.

- Use non-weak symbol for __rseq_abi.

- Move rseq registration/unregistration implementation into its own
  nptl/rseq.c compile unit.

- Move __rseq_abi symbol under GLIBC_2.29.

Changes since v2:
- Move __rseq_refcount to its own symbol, which is less ugly than
  trying to play tricks with the rseq uapi.
- Move __rseq_abi from nptl to csu (C start up), so it can be used
  across glibc, including memory allocator and sched_getcpu().  The
  __rseq_refcount symbol is kept in nptl, because there is no reason
  to use it elsewhere in glibc.

Changes since v3:
- Set __rseq_refcount TLS to 1 on register/set to 0 on unregister
  because glibc is the first/last user.
- Unconditionally register/unregister rseq at thread start/exit, because
  glibc is the first/last user.
- Add missing abilist items.
- Rebase on glibc master commit a502c5294.
- Add NEWS entry.

Changes since v4:
- Do not use "weak" symbols for __rseq_abi and __rseq_refcount.  Based on
  "System V Application Binary Interface", weak only affects the link
  editor, not the dynamic linker.
- Install a new sys/rseq.h system header on Linux, which contains the
  RSEQ_SIG definition, __rseq_abi declaration and __rseq_refcount
  declaration.  Move those definition/declarations from rseq-internal.h
  to the installed sys/rseq.h header.
- Considering that rseq is only available on Linux, move csu/rseq.c to
  sysdeps/unix/sysv/linux/rseq-sym.c.
- Move __rseq_refcount from nptl/rseq.c to
  sysdeps/unix/sysv/linux/rseq-sym.c, so it is only defined on Linux.
- Move both ABI definitions for __rseq_abi and __rseq_refcount to
  sysdeps/unix/sysv/linux/Versions, so they only appear on Linux.
- Document __rseq_abi and __rseq_refcount volatile.
- Document the RSEQ_SIG signature define.
- Move registration functions from rseq.c to rseq-internal.h static
  inline functions.  Introduce empty stubs in misc/rseq-internal.h,
  which can be overridden by architecture code in
  sysdeps/unix/sysv/linux/rseq-internal.h.
- Rename __rseq_register_current_thread and __rseq_unregister_current_thread
  to rseq_register_current_thread and rseq_unregister_current_thread,
  now that those are only visible as internal static inline functions.
- Invoke rseq_register_current_thread() from libc-start.c LIBC_START_MAIN
  rather than nptl init, so applications not linked against
  libpthread.so have rseq registered for their main() thread.  Note that
  it is invoked separately for SHARED and !SHARED builds.

Changes since v5:
- Replace __rseq_refcount by __rseq_lib_abi, which contains two
  uint32_t: register_state and refcount.  The "register_state" field
  allows inhibiting rseq registration from signal handlers nested on top
  of glibc registration and occuring after rseq unregistration by glibc.
- Introduce enum rseq_register_state, which contains the states allowed
  for the struct rseq_lib_abi register_state field.

Changes since v6:
- Introduce bits/rseq.h to define RSEQ_SIG for each architecture.
  The generic bits/rseq.h does not define RSEQ_SIG, meaning that each
  architecture implementing rseq needs to implement bits/rseq.h.
- Rename enum item RSEQ_REGISTER_NESTED to RSEQ_REGISTER_ONGOING.
- Port to glibc-2.29.

Changes since v7:
- Remove __rseq_lib_abi symbol, including refcount and register_state
  fields.
- Remove reference counting and nested signals handling from
  registration/unregistration functions.
- Introduce new __rseq_handled exported symbol, which is set to 1
  by glibc on C startup when it handles restartable sequences.
  This allows glibc to coexist with early adopter libraries and
  applications wishing to register restartable sequences when it
  is not handled by glibc.
- Introduce rseq_init (), which sets __rseq_handled to 1 from
  C startup.
- Update NEWS entry.
- Update comments at the beginning of new files.
- Registration depends on both __NR_rseq and RSEQ_SIG.
- Remove ARM, powerpc, MIPS RSEQ_SIG until we agree with maintainers
  on the signature choice.
- Update x86, s390 RSEQ_SIG based on discussion with arch maintainers.
- Remove rseq-internal.h from headers list of misc/Makefile, so it
  it not installed by make install.

Changes since v8:
- Introduce RSEQ_SIG_CODE and RSEQ_SIG_DATA on aarch64 to handle
  compiling with -mbig-endian.

Changes since v9:
- Update Changelog.
- Remove unneeded new file comment header newlines.

Changes since v10:
- Remove volatile from __rseq_abi declaration.
- Document that __rseq_handled is about library managing rseq
  registration, independently of whether rseq is available or not.
- Move __rseq_handled symbol to ld.so, initialize this symbol within
  the dynamic linker initialization for both shared (rtld.c) and static
  (dl-support.c) builds.
- Only register the rseq TLS on initialization once in multiple-libc
  scenarios.  Use rtld_active () for this purpose.
- In the static libc case, register the rseq TLS after LD_PRELOAD
  constructors are run, so it matches the order of this initialization
  vs LD_PRELOAD contructors execution for the shared libc.
- Agreed on signature choice with powerpc and MIPS maintainers,
  re-adding those signatures,
- The main architecture still left out signature-wise is ARM32.

Changes since v11:
- Rebase on glibc 2.30.
- Re-introduce ARM RSEQ_SIG following feedback from Will Deacon.

Changes since v12:
- Remove __rseq_handled,
- Rely on OS implicit rseq unregistration on thread teardown,
- Register main thread in __libc_early_init ().
- Add Restartable Sequences entry to threads manual.

Changes since v13:
- Update following be/le abilist split for arm, microblaze, and sh.
- Update manual to add the __rseq_abi variable and RSEQ_SIG macro to
  generate manual index entries, and add missing "Restartable Sequences"
  menu entry to the threads chapter.

Changes since v14:
- Update copyright range to include 2020.
- Introduce __ASSUME_RSEQ defined for --enable-kernel=4.18.0 and higher.
- Use ifdef __ASSUME_RSEQ rather than ifdef __NR_rseq to discover rseq
  availability.  This is necessary now that the system call numbers are
  integrated within glibc.

Changes since v15:
- Remove __ASSUME_RSEQ from kernel features.
- rseq internal: remove assume rseq
- remove assume rseq and struct rseq def from sysdeps/unix/sysv/linux/rseq-sym.c
- sys/rseq.h: detect rseq header, implement fallback
- sysdeps/unix/sysv/linux/sys/rseq.h include cdefs.h, add _Static_assert
  to validate struct rseq and struct rseq_cs alignment.
- sys/rseq.h: document that posix_memalign should be used rather than
  malloc if allocating struct rseq or struct rseq_cs on the heap.  This
  is required to guarantee 32-byte alignement.

Changes since v16:
- Move rseq NEWS entry under 2.32.
- Move new __rseq_abi symbol to GLIBC_2.32.

Changes since v17:
- Change copyright year to 2020.
- Refer to GNU C Library manual rather than rseq manpage in NEWS.
- Use "initial" parameter from __libc_early_init ().
- Manual: rseq is Linux rather than GNU std.
- Remove rseq_unregister_current_thread () (unused).
- rseq_register_current_thread () returns void.
- Coding style fixes.
- sys/rseq.h: use "32" for alignment.
- Change http:// for https:// in comments.
- Add const struct rseq_cs * field to rseq_cs union.

Changes since v18:
- NEWS update.
- Manual update.
- Move misc/rseq-internal.h to sysdeps/generic/rseq-internal.h.
- Fix coding style in sysdeps/unix/sysv/linux/sys/rseq.h.
- Abort libc if __rseq_abi is already initialized in
  rseq_register_current_thread (), which is unexpected.
- Abort libc in rseq_register_current_thread () on all
  errno except EPERM (seccomp), EACCES (seccomp), and ENOSYS
  (not implemented).

Changes since v19:
- Take care of feedback from Florian.
- Update manual to remove uptr field, which is removed from sys/rseq.h.
- Rebase on current master branch.

Changes since v20:
- Rebase on current glibc master.
- Update TLS_STATIC_SURPLUS value.
- Use attribute __aligned__ to have same approach as Linux UAPI header.
- Update manual to include link to librseq rseq.2 system call man page.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
CC: Joseph Myers <joseph@codesourcery.com>
CC: Szabolcs Nagy <szabolcs.nagy@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ben Maurer <bmaurer@fb.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Paul Turner <pjt@google.com>
CC: Rich Felker <dalias@libc.org>
CC: libc-alpha@sourceware.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
---
 NEWS                                          |  10 +
 elf/dl-tls.c                                  |   2 +-
 elf/libc_early_init.c                         |   4 +
 manual/threads.texi                           |  64 +++++
 nptl/pthread_create.c                         |  13 +
 sysdeps/generic/rseq-internal.h               |  26 ++
 sysdeps/unix/sysv/linux/Makefile              |   5 +-
 sysdeps/unix/sysv/linux/Versions              |   1 +
 sysdeps/unix/sysv/linux/aarch64/bits/rseq.h   |  43 ++++
 sysdeps/unix/sysv/linux/aarch64/libc.abilist  |   1 +
 sysdeps/unix/sysv/linux/alpha/libc.abilist    |   1 +
 sysdeps/unix/sysv/linux/arm/be/libc.abilist   |   1 +
 sysdeps/unix/sysv/linux/arm/bits/rseq.h       |  83 +++++++
 sysdeps/unix/sysv/linux/arm/le/libc.abilist   |   1 +
 sysdeps/unix/sysv/linux/bits/rseq.h           |  29 +++
 sysdeps/unix/sysv/linux/csky/libc.abilist     |   1 +
 sysdeps/unix/sysv/linux/hppa/libc.abilist     |   1 +
 sysdeps/unix/sysv/linux/i386/libc.abilist     |   1 +
 sysdeps/unix/sysv/linux/ia64/libc.abilist     |   1 +
 .../sysv/linux/m68k/coldfire/libc.abilist     |   1 +
 .../unix/sysv/linux/m68k/m680x0/libc.abilist  |   1 +
 .../sysv/linux/microblaze/be/libc.abilist     |   1 +
 .../sysv/linux/microblaze/le/libc.abilist     |   1 +
 sysdeps/unix/sysv/linux/mips/bits/rseq.h      |  62 +++++
 .../sysv/linux/mips/mips32/fpu/libc.abilist   |   1 +
 .../sysv/linux/mips/mips32/nofpu/libc.abilist |   1 +
 .../sysv/linux/mips/mips64/n32/libc.abilist   |   1 +
 .../sysv/linux/mips/mips64/n64/libc.abilist   |   1 +
 sysdeps/unix/sysv/linux/nios2/libc.abilist    |   1 +
 sysdeps/unix/sysv/linux/powerpc/bits/rseq.h   |  37 +++
 .../linux/powerpc/powerpc32/fpu/libc.abilist  |   1 +
 .../powerpc/powerpc32/nofpu/libc.abilist      |   1 +
 .../linux/powerpc/powerpc64/be/libc.abilist   |   1 +
 .../linux/powerpc/powerpc64/le/libc.abilist   |   1 +
 .../unix/sysv/linux/riscv/rv64/libc.abilist   |   1 +
 sysdeps/unix/sysv/linux/rseq-internal.h       |  73 ++++++
 sysdeps/unix/sysv/linux/rseq-sym.c            |  26 ++
 sysdeps/unix/sysv/linux/s390/bits/rseq.h      |  37 +++
 .../unix/sysv/linux/s390/s390-32/libc.abilist |   1 +
 .../unix/sysv/linux/s390/s390-64/libc.abilist |   1 +
 sysdeps/unix/sysv/linux/sh/be/libc.abilist    |   1 +
 sysdeps/unix/sysv/linux/sh/le/libc.abilist    |   1 +
 .../sysv/linux/sparc/sparc32/libc.abilist     |   1 +
 .../sysv/linux/sparc/sparc64/libc.abilist     |   1 +
 sysdeps/unix/sysv/linux/sys/rseq.h            | 223 ++++++++++++++++++
 sysdeps/unix/sysv/linux/x86/bits/rseq.h       |  30 +++
 .../unix/sysv/linux/x86_64/64/libc.abilist    |   1 +
 .../unix/sysv/linux/x86_64/x32/libc.abilist   |   1 +
 48 files changed, 795 insertions(+), 3 deletions(-)
 create mode 100644 sysdeps/generic/rseq-internal.h
 create mode 100644 sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/arm/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/mips/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/powerpc/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/rseq-internal.h
 create mode 100644 sysdeps/unix/sysv/linux/rseq-sym.c
 create mode 100644 sysdeps/unix/sysv/linux/s390/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/sys/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/x86/bits/rseq.h

diff --git a/NEWS b/NEWS
index a660fc59a8..a12b9378e7 100644
--- a/NEWS
+++ b/NEWS
@@ -31,6 +31,16 @@ Major new features:
   pthread_attr_getsigmask_np have been added.  They allow applications
   to specify the signal mask of a thread created with pthread_create.
 
+* Support for automatically registering threads with the Linux rseq
+  system call has been added.  This system call is implemented starting
+  from Linux 4.18.  The Restartable Sequences ABI accelerates user-space
+  operations on per-cpu data.  It allows user-space to perform updates
+  on per-cpu data without requiring heavy-weight atomic operations.
+  Automatically registering threads allows all libraries, including libc,
+  to make immediate use of the rseq support by using the documented ABI.
+  The GNU C Library manual has details on integration of Restartable
+  Sequences.
+
 Deprecated and removed features, and other changes affecting compatibility:
 
 * The deprecated <sys/sysctl.h> header and the sysctl function have been
diff --git a/elf/dl-tls.c b/elf/dl-tls.c
index fa03234610..817bcbbf59 100644
--- a/elf/dl-tls.c
+++ b/elf/dl-tls.c
@@ -31,7 +31,7 @@
 
 /* Amount of excess space to allocate in the static TLS area
    to allow dynamic loading of modules defining IE-model TLS data.  */
-#define TLS_STATIC_SURPLUS	64 + DL_NNS * 100
+#define TLS_STATIC_SURPLUS	64 + DL_NNS * 176
 
 
 /* Out-of-memory handler.  */
diff --git a/elf/libc_early_init.c b/elf/libc_early_init.c
index e6c64fb526..f0fcf6448e 100644
--- a/elf/libc_early_init.c
+++ b/elf/libc_early_init.c
@@ -18,10 +18,14 @@
 
 #include <ctype.h>
 #include <libc-early-init.h>
+#include <rseq-internal.h>
 
 void
 __libc_early_init (_Bool initial)
 {
   /* Initialize ctype data.  */
   __ctype_init ();
+  /* Register rseq ABI to the kernel for the main program's libc.   */
+  if (initial)
+    rseq_register_current_thread ();
 }
diff --git a/manual/threads.texi b/manual/threads.texi
index bb7a42c655..d5069d5581 100644
--- a/manual/threads.texi
+++ b/manual/threads.texi
@@ -628,6 +628,8 @@ the standard.
 * Initial Thread Signal Mask::            Setting the initial mask of threads.
 * Waiting with Explicit Clocks::          Functions for waiting with an
                                           explicit clock specification.
+* Restartable Sequences::                 Linux-specific Restartable Sequences
+                                          integration.
 @end menu
 
 @node Default Thread Attributes
@@ -843,6 +845,68 @@ Behaves like @code{pthread_timedjoin_np} except that the absolute time in
 @var{abstime} is measured against the clock specified by @var{clockid}.
 @end deftypefun
 
+@node Restartable Sequences
+@subsubsection Restartable Sequences
+
+This section describes Restartable Sequences integration for
+@theglibc{}.  This functionality is only available on Linux.
+
+@deftypevar {struct rseq} __rseq_abi
+@standards{Linux, sys/rseq.h}
+@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with
+the Restartable Sequences system call.  The layout of this structure is
+defined by the @file{sys/rseq.h} header.  Registration of each thread's
+@code{__rseq_abi} is performed by @theglibc{} at library initialization
+and thread creation. The manual for the rseq system call can be found
+at @uref{https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2}.
+
+The main executable and shared libraries may either have an undefined
+@code{__rseq_abi} TLS symbol, or define their own, with the same
+declaration as the one present in @file{sys/rseq.h}.  The dynamic linker
+will ensure that only one of those available symbols will be used at
+runtime across the process.
+
+If the main executable or shared libraries observe an uninitialized
+@code{__rseq_abi.cpu_id} field (value @code{RSEQ_CPU_ID_UNINITIALIZED}),
+they may perform rseq registration to the kernel: this means either
+glibc was prevented from doing the registration, or an older glibc
+version, which does not include rseq support, is in use.  When the main
+executable or a library thus takes ownership of the registration, the
+memory used to hold the @code{__rseq_abi} TLS variable must stay
+allocated, and is not re-used, until the very end of the thread lifetime
+or until an explicit rseq unregistration for that thread is performed.
+It is not recommended to @code{dlclose} libraries owning the
+@code{__rseq_abi} TLS variable.
+
+Users of the @code{__rseq_abi} TLS symbol can store the address of a
+@code{struct rseq_cs} to the @code{__rseq_abi.rseq_cs} TLS variable,
+thus informing the kernel that it enters a Restartable Sequence critical
+section.  This pointer and the code areas it itself points to must not
+be left pointing to memory areas which are freed or re-used.  Several
+approaches can guarantee this.  If the application or library can
+guarantee that the memory used to hold the @code{struct rseq_cs} and the
+code areas it refers to are never freed or re-used, no special action
+must be taken.  Else, before that memory is re-used of freed, the
+application is responsible for setting the @code{__rseq_abi.rseq_cs} TLS
+variable to @code{NULL} in each thread's TLS to guarantee that it does
+not leak dangling references.  Because the application does not
+typically have knowledge of libraries' use of Restartable Sequences, it
+is recommended that libraries using Restartable Sequences which may end
+up freeing or re-using their memory set the @code{__rseq_abi.rseq_cs}
+TLS variable to @code{NULL} before returning from library functions
+which use Restartable Sequences.
+
+@end deftypevar
+
+@deftypevr Macro int RSEQ_SIG
+@standards{Linux, sys/rseq.h}
+Each supported architecture provides a @code{RSEQ_SIG} macro in
+@file{sys/rseq.h} which contains a signature.  That signature is
+expected to be present in the code before each Restartable Sequences
+abort handler.  Failure to provide the expected signature may terminate
+the process with a segmentation fault.
+@end deftypevr
+
 @c FIXME these are undocumented:
 @c pthread_atfork
 @c pthread_attr_destroy
diff --git a/nptl/pthread_create.c b/nptl/pthread_create.c
index 35a9927cf2..45e7cd0f16 100644
--- a/nptl/pthread_create.c
+++ b/nptl/pthread_create.c
@@ -33,6 +33,7 @@
 #include <default-sched.h>
 #include <futex-internal.h>
 #include <tls-setup.h>
+#include <rseq-internal.h>
 #include "libioP.h"
 
 #include <shlib-compat.h>
@@ -384,6 +385,9 @@ START_THREAD_DEFN
   /* Initialize pointers to locale data.  */
   __ctype_init ();
 
+  /* Register rseq TLS to the kernel.  */
+  rseq_register_current_thread ();
+
 #ifndef __ASSUME_SET_ROBUST_LIST
   if (__set_robust_list_avail >= 0)
 #endif
@@ -579,6 +583,15 @@ START_THREAD_DEFN
      process is really dead since 'clone' got passed the CLONE_CHILD_CLEARTID
      flag.  The 'tid' field in the TCB will be set to zero.
 
+     rseq TLS is still registered at this point.  Rely on implicit
+     unregistration performed by the kernel on thread teardown.  This is not a
+     problem because the rseq TLS lives on the stack, and the stack outlives
+     the thread.  If TCB allocation is ever changed, additional steps may be
+     required, such as performing explicit rseq unregistration before
+     reclaiming the rseq TLS area memory.  It is NOT sufficient to block
+     signals because the kernel may write to the rseq area even without
+     signals.
+
      The exit code is zero since in case all threads exit by calling
      'pthread_exit' the exit status must be 0 (zero).  */
   __exit_thread ();
diff --git a/sysdeps/generic/rseq-internal.h b/sysdeps/generic/rseq-internal.h
new file mode 100644
index 0000000000..16f197397f
--- /dev/null
+++ b/sysdeps/generic/rseq-internal.h
@@ -0,0 +1,26 @@
+/* Restartable Sequences internal API.  Stub version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef RSEQ_INTERNAL_H
+#define RSEQ_INTERNAL_H
+
+static inline void
+rseq_register_current_thread (void)
+{
+}
+
+#endif /* rseq-internal.h */
diff --git a/sysdeps/unix/sysv/linux/Makefile b/sysdeps/unix/sysv/linux/Makefile
index e02065dc8d..e855db2cb9 100644
--- a/sysdeps/unix/sysv/linux/Makefile
+++ b/sysdeps/unix/sysv/linux/Makefile
@@ -41,7 +41,7 @@ update-syscall-lists: arch-syscall.h
 endif
 
 ifeq ($(subdir),csu)
-sysdep_routines += errno-loc
+sysdep_routines += errno-loc rseq-sym
 endif
 
 ifeq ($(subdir),assert)
@@ -92,7 +92,8 @@ sysdep_headers += sys/mount.h sys/acct.h \
 		  bits/termios-c_lflag.h bits/termios-tcflow.h \
 		  bits/termios-misc.h \
 		  bits/types/struct_semid_ds.h \
-		  bits/ipc-perm.h
+		  bits/ipc-perm.h \
+		  sys/rseq.h bits/rseq.h
 
 tests += tst-clone tst-clone2 tst-clone3 tst-fanotify tst-personality \
 	 tst-quota tst-sync_file_range tst-sysconf-iov_max tst-ttyname \
diff --git a/sysdeps/unix/sysv/linux/Versions b/sysdeps/unix/sysv/linux/Versions
index 9a58dda9f2..52ca223ab2 100644
--- a/sysdeps/unix/sysv/linux/Versions
+++ b/sysdeps/unix/sysv/linux/Versions
@@ -178,6 +178,7 @@ libc {
     getdents64; gettid; tgkill;
   }
   GLIBC_2.32 {
+    __rseq_abi;
   }
   GLIBC_PRIVATE {
     # functions used in other libraries
diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
new file mode 100644
index 0000000000..b6f6e536f4
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
@@ -0,0 +1,43 @@
+/* Restartable Sequences Linux aarch64 architecture header.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries.  It needs to be defined for each
+   architecture.  When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.
+
+   aarch64 -mbig-endian generates mixed endianness code vs data:
+   little-endian code and big-endian data.  Ensure the RSEQ_SIG signature
+   matches code endianness.  */
+
+#define RSEQ_SIG_CODE  0xd428bc00  /* BRK #0x45E0.  */
+
+#ifdef __AARCH64EB__
+# define RSEQ_SIG_DATA 0x00bc28d4  /* BRK #0x45E0.  */
+#else
+# define RSEQ_SIG_DATA RSEQ_SIG_CODE
+#endif
+
+#define RSEQ_SIG       RSEQ_SIG_DATA
diff --git a/sysdeps/unix/sysv/linux/aarch64/libc.abilist b/sysdeps/unix/sysv/linux/aarch64/libc.abilist
index 48c790b15d..e6e4f087eb 100644
--- a/sysdeps/unix/sysv/linux/aarch64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/aarch64/libc.abilist
@@ -2149,6 +2149,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/alpha/libc.abilist b/sysdeps/unix/sysv/linux/alpha/libc.abilist
index cb70cb974f..835897876b 100644
--- a/sysdeps/unix/sysv/linux/alpha/libc.abilist
+++ b/sysdeps/unix/sysv/linux/alpha/libc.abilist
@@ -2231,6 +2231,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/arm/be/libc.abilist b/sysdeps/unix/sysv/linux/arm/be/libc.abilist
index 573eca117e..f7a61fc73a 100644
--- a/sysdeps/unix/sysv/linux/arm/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/arm/be/libc.abilist
@@ -133,6 +133,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/arm/bits/rseq.h b/sysdeps/unix/sysv/linux/arm/bits/rseq.h
new file mode 100644
index 0000000000..2bf780efcd
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/arm/bits/rseq.h
@@ -0,0 +1,83 @@
+/* Restartable Sequences Linux arm architecture header.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/*
+   RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries.  It needs to be defined for each
+   architecture.  When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.
+
+   - ARM little endian
+
+   RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
+   value 0x5de3.  This traps if user-space reaches this instruction by mistake,
+   and the uncommon operand ensures the kernel does not move the instruction
+   pointer to attacker-controlled code on rseq abort.
+
+   The instruction pattern in the A32 instruction set is:
+
+   e7f5def3    udf    #24035    ; 0x5de3
+
+   This translates to the following instruction pattern in the T16 instruction
+   set:
+
+   little endian:
+   def3        udf    #243      ; 0xf3
+   e7f5        b.n    <7f5>
+
+   - ARMv6+ big endian (BE8):
+
+   ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
+   code and big-endian data.  The data value of the signature needs to have its
+   byte order reversed to generate the trap instruction:
+
+   Data: 0xf3def5e7
+
+   Translates to this A32 instruction pattern:
+
+   e7f5def3    udf    #24035    ; 0x5de3
+
+   Translates to this T16 instruction pattern:
+
+   def3        udf    #243      ; 0xf3
+   e7f5        b.n    <7f5>
+
+   - Prior to ARMv6 big endian (BE32):
+
+   Prior to ARMv6, -mbig-endian generates big-endian code and data
+   (which match), so the endianness of the data representation of the
+   signature should not be reversed.  However, the choice between BE32
+   and BE8 is done by the linker, so we cannot know whether code and
+   data endianness will be mixed before the linker is invoked.  So rather
+   than try to play tricks with the linker, the rseq signature is simply
+   data (not a trap instruction) prior to ARMv6 on big endian.  This is
+   why the signature is expressed as data (.word) rather than as
+   instruction (.inst) in assembler.  */
+
+#ifdef __ARMEB__
+# define RSEQ_SIG    0xf3def5e7      /* udf    #24035    ; 0x5de3 (ARMv6+) */
+#else
+# define RSEQ_SIG    0xe7f5def3      /* udf    #24035    ; 0x5de3 */
+#endif
diff --git a/sysdeps/unix/sysv/linux/arm/le/libc.abilist b/sysdeps/unix/sysv/linux/arm/le/libc.abilist
index 8a8633f0a4..c84ab6e5c3 100644
--- a/sysdeps/unix/sysv/linux/arm/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/arm/le/libc.abilist
@@ -130,6 +130,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/bits/rseq.h b/sysdeps/unix/sysv/linux/bits/rseq.h
new file mode 100644
index 0000000000..014c08fe0f
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/bits/rseq.h
@@ -0,0 +1,29 @@
+/* Restartable Sequences architecture header.  Stub version.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries.  It needs to be defined for each
+   architecture.  When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.  */
diff --git a/sysdeps/unix/sysv/linux/csky/libc.abilist b/sysdeps/unix/sysv/linux/csky/libc.abilist
index 3042a93084..2fadebd7ee 100644
--- a/sysdeps/unix/sysv/linux/csky/libc.abilist
+++ b/sysdeps/unix/sysv/linux/csky/libc.abilist
@@ -2093,6 +2093,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/hppa/libc.abilist b/sysdeps/unix/sysv/linux/hppa/libc.abilist
index a02a576321..c28604ffc7 100644
--- a/sysdeps/unix/sysv/linux/hppa/libc.abilist
+++ b/sysdeps/unix/sysv/linux/hppa/libc.abilist
@@ -2052,6 +2052,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/i386/libc.abilist b/sysdeps/unix/sysv/linux/i386/libc.abilist
index f0b9c9e070..4042d2b4e1 100644
--- a/sysdeps/unix/sysv/linux/i386/libc.abilist
+++ b/sysdeps/unix/sysv/linux/i386/libc.abilist
@@ -2218,6 +2218,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/ia64/libc.abilist b/sysdeps/unix/sysv/linux/ia64/libc.abilist
index 1534fd7a24..13a38cbafd 100644
--- a/sysdeps/unix/sysv/linux/ia64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/ia64/libc.abilist
@@ -2084,6 +2084,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist b/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
index 9a0ada4b52..231e41ed37 100644
--- a/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
@@ -134,6 +134,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist b/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
index 333c35bf16..b244e2a327 100644
--- a/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
@@ -2164,6 +2164,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/microblaze/be/libc.abilist b/sysdeps/unix/sysv/linux/microblaze/be/libc.abilist
index 824eceec11..8c53e8b512 100644
--- a/sysdeps/unix/sysv/linux/microblaze/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/microblaze/be/libc.abilist
@@ -2144,6 +2144,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/microblaze/le/libc.abilist b/sysdeps/unix/sysv/linux/microblaze/le/libc.abilist
index 5a6dcdd21b..fa7df5a6d8 100644
--- a/sysdeps/unix/sysv/linux/microblaze/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/microblaze/le/libc.abilist
@@ -2141,6 +2141,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/mips/bits/rseq.h b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
new file mode 100644
index 0000000000..fa945fc7c1
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
@@ -0,0 +1,62 @@
+/* Restartable Sequences Linux mips architecture header.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries.  It needs to be defined for each
+   architecture.  When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.
+
+   RSEQ_SIG uses the break instruction.  The instruction pattern is:
+
+   On MIPS:
+        0350000d        break     0x350
+
+   On nanoMIPS:
+        00100350        break     0x350
+
+   On microMIPS:
+        0000d407        break     0x350
+
+   For nanoMIPS32 and microMIPS, the instruction stream is encoded as
+   16-bit halfwords, so the signature halfwords need to be swapped
+   accordingly for little-endian.  */
+
+#if defined (__nanomips__)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG      0x03500010
+# else
+#  define RSEQ_SIG      0x00100350
+# endif
+#elif defined (__mips_micromips)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG      0xd4070000
+# else
+#  define RSEQ_SIG      0x0000d407
+# endif
+#elif defined (__mips__)
+# define RSEQ_SIG       0x0350000d
+#else
+/* Unknown MIPS architecture.  */
+#endif
diff --git a/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
index 6e5dbb28f1..831251f1fd 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
@@ -2135,6 +2135,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
index 3ee64614b2..6f3c014ed1 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
@@ -2133,6 +2133,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
index dc62615524..c3a3931e55 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
@@ -2141,6 +2141,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
index 8cf78bcf51..bdc9b416b2 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
@@ -2135,6 +2135,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/nios2/libc.abilist b/sysdeps/unix/sysv/linux/nios2/libc.abilist
index 7817aeb0e2..d8573f6bbe 100644
--- a/sysdeps/unix/sysv/linux/nios2/libc.abilist
+++ b/sysdeps/unix/sysv/linux/nios2/libc.abilist
@@ -2182,6 +2182,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h b/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h
new file mode 100644
index 0000000000..0dc608ebd5
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h
@@ -0,0 +1,37 @@
+/* Restartable Sequences Linux powerpc architecture header.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries.  It needs to be defined for each
+   architecture.  When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.
+
+   RSEQ_SIG uses the following trap instruction:
+
+   powerpc-be:    0f e5 00 0b           twui   r5,11
+   powerpc64-le:  0b 00 e5 0f           twui   r5,11
+   powerpc64-be:  0f e5 00 0b           twui   r5,11  */
+
+#define RSEQ_SIG        0x0fe5000b
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
index ca04e8f2d3..77309e8044 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
@@ -2191,6 +2191,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
index 10cb895639..84da7446ca 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
@@ -2224,6 +2224,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
index 96ddc448d7..219316b5f4 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
@@ -2054,6 +2054,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
index deddb53d83..05c99997a3 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
@@ -2291,6 +2291,7 @@ GLIBC_2.32 __qecvtieee128_r F
 GLIBC_2.32 __qfcvtieee128 F
 GLIBC_2.32 __qfcvtieee128_r F
 GLIBC_2.32 __qgcvtieee128 F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 __scanfieee128 F
 GLIBC_2.32 __snprintf_chkieee128 F
 GLIBC_2.32 __snprintfieee128 F
diff --git a/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist b/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
index 58217dcb13..22db101803 100644
--- a/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
@@ -2111,6 +2111,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h b/sysdeps/unix/sysv/linux/rseq-internal.h
new file mode 100644
index 0000000000..8f6772ca1d
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/rseq-internal.h
@@ -0,0 +1,73 @@
+/* Restartable Sequences internal API.  Linux implementation.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef RSEQ_INTERNAL_H
+#define RSEQ_INTERNAL_H
+
+#include <sysdep.h>
+#include <errno.h>
+#include <kernel-features.h>
+#include <stdio.h>
+#include <sys/rseq.h>
+
+#ifdef RSEQ_SIG
+static inline void
+rseq_register_current_thread (void)
+{
+  int ret;
+
+  if (__rseq_abi.cpu_id != RSEQ_CPU_ID_UNINITIALIZED)
+    __libc_fatal ("glibc fatal error: "
+                  "rseq already initialized for this thread\n");
+  ret = INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
+                               0, RSEQ_SIG);
+  if (INTERNAL_SYSCALL_ERROR_P (ret))
+    {
+      const char *msg = NULL;
+
+      switch (INTERNAL_SYSCALL_ERRNO (ret))
+        {
+        case ENOSYS:    /* rseq system call not implemented.  */
+        case EPERM:     /* rseq system call filtered by seccomp.  */
+        case EACCES:    /* rseq system call filtered by seccomp.  */
+          __rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
+          break;
+        case EBUSY:
+          msg = "glibc fatal error: rseq already registered for this thread\n";
+          break;
+        case EFAULT:
+          msg = "glibc fatal error: rseq parameter is an invalid address\n";
+          break;
+        case EINVAL:
+          msg = "glibc fatal error: rseq parameters are invalid\n";
+          break;
+        default:
+          msg = "glibc fatal error: unexpected rseq errno\n";
+          break;
+        }
+      if (msg != NULL)
+        __libc_fatal (msg);
+    }
+}
+#else /* RSEQ_SIG */
+static inline void
+rseq_register_current_thread (void)
+{
+}
+#endif /* RSEQ_SIG */
+
+#endif /* rseq-internal.h */
diff --git a/sysdeps/unix/sysv/linux/rseq-sym.c b/sysdeps/unix/sysv/linux/rseq-sym.c
new file mode 100644
index 0000000000..090093408f
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/rseq-sym.c
@@ -0,0 +1,26 @@
+/* Restartable Sequences exported symbols.  Linux Implementation.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <sys/syscall.h>
+#include <stdint.h>
+#include <kernel-features.h>
+#include <sys/rseq.h>
+
+__thread struct rseq __rseq_abi =
+  {
+    .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+  };
diff --git a/sysdeps/unix/sysv/linux/s390/bits/rseq.h b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
new file mode 100644
index 0000000000..3d6fd0cfb9
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
@@ -0,0 +1,37 @@
+/* Restartable Sequences Linux s390 architecture header.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries.  It needs to be defined for each
+   architecture.  When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.
+
+   RSEQ_SIG uses the trap4 instruction.  As Linux does not make use of the
+   access-register mode nor the linkage stack this instruction will always
+   cause a special-operation exception (the trap-enabled bit in the DUCT
+   is and will stay 0).  The instruction pattern is
+       b2 ff 0f ff        trap4   4095(%r0)  */
+
+#define RSEQ_SIG        0xB2FF0FFF
diff --git a/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist b/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
index c22c29b35a..256ce370ae 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
@@ -2189,6 +2189,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist b/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
index 568f1727c4..5d6304393b 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
@@ -2090,6 +2090,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/sh/be/libc.abilist b/sysdeps/unix/sysv/linux/sh/be/libc.abilist
index d9988dae90..bff6c48ae4 100644
--- a/sysdeps/unix/sysv/linux/sh/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sh/be/libc.abilist
@@ -2059,6 +2059,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/sh/le/libc.abilist b/sysdeps/unix/sysv/linux/sh/le/libc.abilist
index 39edeffe82..e55f46a5d6 100644
--- a/sysdeps/unix/sysv/linux/sh/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sh/le/libc.abilist
@@ -2056,6 +2056,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist b/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
index 8668e15e8c..96e76c76a3 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
@@ -2180,6 +2180,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist b/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
index eb884afa3e..e6bfb396b2 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
@@ -2107,6 +2107,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h b/sysdeps/unix/sysv/linux/sys/rseq.h
new file mode 100644
index 0000000000..5e118c1781
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/sys/rseq.h
@@ -0,0 +1,223 @@
+/* Restartable Sequences exported symbols.  Linux header.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+#define _SYS_RSEQ_H	1
+
+/* Architecture-specific rseq signature.  */
+#include <bits/rseq.h>
+
+#include <stdint.h>
+#include <sys/cdefs.h>
+
+#ifdef __has_include
+# if __has_include ("linux/rseq.h")
+#  define __GLIBC_HAVE_KERNEL_RSEQ
+# endif
+#else
+# include <linux/version.h>
+# if LINUX_VERSION_CODE >= KERNEL_VERSION (4, 18, 0)
+#  define __GLIBC_HAVE_KERNEL_RSEQ
+# endif
+#endif
+
+#ifdef __cplusplus
+# if  __cplusplus >= 201103L
+#  define __rseq_static_assert(expr, diagnostic) static_assert (expr, diagnostic)
+#  define __rseq_alignof(type)                   alignof (type)
+#  define __rseq_tls_storage_class               thread_local
+# endif
+#elif (defined __STDC_VERSION__ ? __STDC_VERSION__ : 0) >= 201112L
+# define __rseq_static_assert(expr, diagnostic)  _Static_assert (expr, diagnostic)
+# define __rseq_alignof(type)                    _Alignof (type)
+# define __rseq_tls_storage_class                _Thread_local
+#endif
+
+#ifndef __rseq_static_assert
+/* Try to use _Static_assert macro from sys/cdefs.h.  */
+# ifdef _Static_assert
+#  define __rseq_static_assert(expr, diagnostic) _Static_assert (expr, diagnostic)
+# else
+#  define __rseq_static_assert(expr, diagnostic) /* Nothing.  */
+# endif
+#endif
+
+/* Rely on GNU extensions for older standards and tls model.  */
+#ifdef __GNUC__
+# ifndef __rseq_alignof
+#  define __rseq_alignof(x) __alignof__ (x)
+# endif
+# define __rseq_tls_model_ie __attribute__ ((__tls_model__ ("initial-exec")))
+#else
+/* Specifying the TLS model on the declaration is optional.  */
+# define __rseq_tls_model_ie /* Nothing.  */
+#endif
+
+/* Fall back to __thread for TLS storage class.  */
+#ifndef __rseq_tls_storage_class
+# define __rseq_tls_storage_class __thread
+#endif
+
+#ifdef __GLIBC_HAVE_KERNEL_RSEQ
+/* We use the structures declarations from the kernel headers.  */
+# include <linux/rseq.h>
+#else /* __GLIBC_HAVE_KERNEL_RSEQ */
+/* We use a copy of the include/uapi/linux/rseq.h kernel header.  */
+
+# include <asm/byteorder.h>
+
+enum rseq_cpu_id_state
+  {
+    RSEQ_CPU_ID_UNINITIALIZED = -1,
+    RSEQ_CPU_ID_REGISTRATION_FAILED = -2,
+  };
+
+enum rseq_flags
+  {
+    RSEQ_FLAG_UNREGISTER = (1 << 0),
+  };
+
+enum rseq_cs_flags_bit
+  {
+    RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT = 0,
+    RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT = 1,
+    RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT = 2,
+  };
+
+enum rseq_cs_flags
+  {
+    RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT =
+      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT),
+    RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL =
+      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
+    RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE =
+      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+  };
+
+/* struct rseq_cs is aligned on 32 bytes to ensure it is always
+   contained within a single cache-line.  It is usually declared as
+   link-time constant data.  */
+struct rseq_cs
+  {
+    /* Version of this structure.  */
+    uint32_t version;
+    /* enum rseq_cs_flags.  */
+    uint32_t flags;
+    uint64_t start_ip;
+    /* Offset from start_ip.  */
+    uint64_t post_commit_offset;
+    uint64_t abort_ip;
+  } __attribute__ ((__aligned__ (32)));
+
+/* struct rseq is aligned on 32 bytes to ensure it is always
+   contained within a single cache-line.
+
+   A single struct rseq per thread is allowed.  */
+struct rseq
+  {
+    /* Restartable sequences cpu_id_start field.  Updated by the
+       kernel.  Read by user-space with single-copy atomicity
+       semantics.  This field should only be read by the thread which
+       registered this data structure.  Aligned on 32-bit.  Always
+       contains a value in the range of possible CPUs, although the
+       value may not be the actual current CPU (e.g. if rseq is not
+       initialized).  This CPU number value should always be compared
+       against the value of the cpu_id field before performing a rseq
+       commit or returning a value read from a data structure indexed
+       using the cpu_id_start value.  */
+    uint32_t cpu_id_start;
+    /* Restartable sequences cpu_id field.  Updated by the kernel.
+       Read by user-space with single-copy atomicity semantics.  This
+       field should only be read by the thread which registered this
+       data structure.  Aligned on 32-bit.  Values
+       RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+       have a special semantic: the former means "rseq uninitialized",
+       and latter means "rseq initialization failed".  This value is
+       meant to be read within rseq critical sections and compared
+       with the cpu_id_start value previously read, before performing
+       the commit instruction, or read and compared with the
+       cpu_id_start value before returning a value loaded from a data
+       structure indexed using the cpu_id_start value.  */
+    uint32_t cpu_id;
+    /* Restartable sequences rseq_cs field.
+
+       Contains NULL when no critical section is active for the current
+       thread, or holds a pointer to the currently active struct rseq_cs.
+
+       Updated by user-space, which sets the address of the currently
+       active rseq_cs at the beginning of assembly instruction sequence
+       block, and set to NULL by the kernel when it restarts an assembly
+       instruction sequence block, as well as when the kernel detects that
+       it is preempting or delivering a signal outside of the range
+       targeted by the rseq_cs.  Also needs to be set to NULL by user-space
+       before reclaiming memory that contains the targeted struct rseq_cs.
+
+       Read and set by the kernel.  Set by user-space with single-copy
+       atomicity semantics.  This field should only be updated by the
+       thread which registered this data structure.  Aligned on 64-bit.  */
+    union
+      {
+        uint64_t ptr64;
+# ifdef __LP64__
+        uint64_t ptr;
+# else /* __LP64__ */
+        struct
+          {
+#  if (defined (__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined (__BIG_ENDIAN)
+            uint32_t padding; /* Initialized to zero.  */
+            uint32_t ptr32;
+#  else /* LITTLE */
+            uint32_t ptr32;
+            uint32_t padding; /* Initialized to zero.  */
+#  endif /* ENDIAN */
+          } ptr;
+# endif /* __LP64__ */
+      } rseq_cs;
+
+    /* Restartable sequences flags field.
+
+       This field should only be updated by the thread which
+       registered this data structure.  Read by the kernel.
+       Mainly used for single-stepping through rseq critical sections
+       with debuggers.
+
+       - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
+           Inhibit instruction sequence block restart on preemption
+           for this thread.
+       - RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
+           Inhibit instruction sequence block restart on signal
+           delivery for this thread.
+       - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
+           Inhibit instruction sequence block restart on migration for
+           this thread.  */
+    uint32_t flags;
+  } __attribute__ ((__aligned__ (32)));
+
+#endif /* __GLIBC_HAVE_KERNEL_RSEQ */
+
+/* Ensure the compiler supports rseq_align.  */
+__rseq_static_assert (__rseq_alignof (struct rseq_cs) >= 32, "alignment");
+__rseq_static_assert (__rseq_alignof (struct rseq) >= 32, "alignment");
+
+/* Allocations of struct rseq and struct rseq_cs on the heap need to
+   be aligned on 32 bytes.  Therefore, use of malloc is discouraged
+   because it does not guarantee alignment.  posix_memalign should be
+   used instead.  */
+
+extern __rseq_tls_storage_class struct rseq __rseq_abi __rseq_tls_model_ie;
+
+#endif /* sys/rseq.h */
diff --git a/sysdeps/unix/sysv/linux/x86/bits/rseq.h b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
new file mode 100644
index 0000000000..f801d5d0a1
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
@@ -0,0 +1,30 @@
+/* Restartable Sequences Linux x86 architecture header.
+   Copyright (C) 2020 Free Software Foundation, Inc.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   RSEQ_SIG is used with the following reserved undefined instructions, which
+   trap in user-space:
+
+   x86-32:    0f b9 3d 53 30 05 53      ud1    0x53053053,%edi
+   x86-64:    0f b9 3d 53 30 05 53      ud1    0x53053053(%rip),%edi  */
+
+#define RSEQ_SIG        0x53053053
diff --git a/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist b/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
index a208fb3556..168ca03aa2 100644
--- a/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
@@ -2065,6 +2065,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
diff --git a/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist b/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
index 3eca3493e2..82a5089792 100644
--- a/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
@@ -2162,6 +2162,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.32 __rseq_abi T 0x20
 GLIBC_2.32 pthread_attr_getsigmask_np F
 GLIBC_2.32 pthread_attr_setaffinity_np F
 GLIBC_2.32 pthread_attr_setsigmask_np F
-- 
2.17.1

