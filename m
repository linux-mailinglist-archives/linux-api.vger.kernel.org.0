Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2B5133B0
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2019 20:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfECSma (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 May 2019 14:42:30 -0400
Received: from mail.efficios.com ([167.114.142.138]:47836 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfECSma (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 May 2019 14:42:30 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E73671DD9E2;
        Fri,  3 May 2019 14:42:26 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id e3BWfSpZlVCL; Fri,  3 May 2019 14:42:25 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 33BA21DD9BC;
        Fri,  3 May 2019 14:42:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 33BA21DD9BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556908945;
        bh=XBWJDxlHcm/Jqw2D418/8iicc3UkU5VuXGVcxNx+Yxc=;
        h=From:To:Date:Message-Id;
        b=M14TyQ7/e5ITTMNzzVttupBBNrYmLU6OvaUORMIz7z2b2iswnfZINWd1jGQ8E+w63
         JFIDSfZmMD7df3MmLAhtONKCtmP+nh+vlwKUhjo0U8E+m9vRXAmCnEOfLLaDN1SLbf
         ec+cOXySIp4Yfvlb57LmgFnEhpKBsSKN8hzT8e7aAKwk9TrZit86dFxBk5YxE2T702
         i8NfoBsPnCvnOJvbNR6Mhjykp2zHF6T4gY3hoOmN8b10X1FSSYwHbm+bhkViHOrpwE
         VUsfgV9hHaNiUpKGx6a66ClCTZgP3awUEKag8fasaU1Su3Sy30I7xsuXsHSWJQmwzC
         i0AvGms/ULAhg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id uTIDw-vg9Mrm; Fri,  3 May 2019 14:42:25 -0400 (EDT)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id B51331DD9A8;
        Fri,  3 May 2019 14:42:24 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
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
Subject: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Date:   Fri,  3 May 2019 14:42:15 -0400
Message-Id: <20190503184219.19266-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Register rseq(2) TLS for each thread (including main), and unregister
for each thread (excluding main). "rseq" stands for Restartable
Sequences.

See the rseq(2) man page proposed here:
  https://lkml.org/lkml/2018/9/19/647

This patch is based on glibc-2.29. The rseq(2) system call was merged
into Linux 4.18.

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
  rseq refcount. It becomes part of the ABI within a user-space
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
  across glibc, including memory allocator and sched_getcpu(). The
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
- Do not use "weak" symbols for __rseq_abi and __rseq_refcount. Based on
  "System V Application Binary Interface", weak only affects the link
  editor, not the dynamic linker.
- Install a new sys/rseq.h system header on Linux, which contains the
  RSEQ_SIG definition, __rseq_abi declaration and __rseq_refcount
  declaration. Move those definition/declarations from rseq-internal.h
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
  inline functions. Introduce empty stubs in misc/rseq-internal.h,
  which can be overridden by architecture code in
  sysdeps/unix/sysv/linux/rseq-internal.h.
- Rename __rseq_register_current_thread and __rseq_unregister_current_thread
  to rseq_register_current_thread and rseq_unregister_current_thread,
  now that those are only visible as internal static inline functions.
- Invoke rseq_register_current_thread() from libc-start.c LIBC_START_MAIN
  rather than nptl init, so applications not linked against
  libpthread.so have rseq registered for their main() thread. Note that
  it is invoked separately for SHARED and !SHARED builds.

Changes since v5:
- Replace __rseq_refcount by __rseq_lib_abi, which contains two
  uint32_t: register_state and refcount. The "register_state" field
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
CC: Dave Watson <davejwatson@fb.com>
CC: Paul Turner <pjt@google.com>
CC: Rich Felker <dalias@libc.org>
CC: libc-alpha@sourceware.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
---
 ChangeLog                                     | 47 ++++++++++
 NEWS                                          | 15 ++++
 csu/libc-start.c                              | 14 ++-
 misc/rseq-internal.h                          | 38 ++++++++
 nptl/pthread_create.c                         |  9 ++
 sysdeps/unix/sysv/linux/Makefile              |  4 +-
 sysdeps/unix/sysv/linux/Versions              |  4 +
 sysdeps/unix/sysv/linux/aarch64/bits/rseq.h   | 43 +++++++++
 sysdeps/unix/sysv/linux/aarch64/libc.abilist  |  2 +
 sysdeps/unix/sysv/linux/alpha/libc.abilist    |  2 +
 sysdeps/unix/sysv/linux/arm/libc.abilist      |  2 +
 sysdeps/unix/sysv/linux/bits/rseq.h           | 29 ++++++
 sysdeps/unix/sysv/linux/csky/libc.abilist     |  2 +
 sysdeps/unix/sysv/linux/hppa/libc.abilist     |  2 +
 sysdeps/unix/sysv/linux/i386/libc.abilist     |  2 +
 sysdeps/unix/sysv/linux/ia64/libc.abilist     |  2 +
 .../sysv/linux/m68k/coldfire/libc.abilist     |  2 +
 .../unix/sysv/linux/m68k/m680x0/libc.abilist  |  2 +
 .../unix/sysv/linux/microblaze/libc.abilist   |  2 +
 .../sysv/linux/mips/mips32/fpu/libc.abilist   |  2 +
 .../sysv/linux/mips/mips32/nofpu/libc.abilist |  2 +
 .../sysv/linux/mips/mips64/n32/libc.abilist   |  2 +
 .../sysv/linux/mips/mips64/n64/libc.abilist   |  2 +
 sysdeps/unix/sysv/linux/nios2/libc.abilist    |  2 +
 .../linux/powerpc/powerpc32/fpu/libc.abilist  |  2 +
 .../powerpc/powerpc32/nofpu/libc.abilist      |  2 +
 .../linux/powerpc/powerpc64/be/libc.abilist   |  2 +
 .../linux/powerpc/powerpc64/le/libc.abilist   |  2 +
 .../unix/sysv/linux/riscv/rv64/libc.abilist   |  2 +
 sysdeps/unix/sysv/linux/rseq-internal.h       | 88 +++++++++++++++++++
 sysdeps/unix/sysv/linux/rseq-sym.c            | 63 +++++++++++++
 sysdeps/unix/sysv/linux/s390/bits/rseq.h      | 30 +++++++
 .../unix/sysv/linux/s390/s390-32/libc.abilist |  2 +
 .../unix/sysv/linux/s390/s390-64/libc.abilist |  2 +
 sysdeps/unix/sysv/linux/sh/libc.abilist       |  2 +
 .../sysv/linux/sparc/sparc32/libc.abilist     |  2 +
 .../sysv/linux/sparc/sparc64/libc.abilist     |  2 +
 sysdeps/unix/sysv/linux/sys/rseq.h            | 50 +++++++++++
 sysdeps/unix/sysv/linux/x86/bits/rseq.h       | 30 +++++++
 .../unix/sysv/linux/x86_64/64/libc.abilist    |  2 +
 .../unix/sysv/linux/x86_64/x32/libc.abilist   |  2 +
 41 files changed, 513 insertions(+), 5 deletions(-)
 create mode 100644 misc/rseq-internal.h
 create mode 100644 sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/rseq-internal.h
 create mode 100644 sysdeps/unix/sysv/linux/rseq-sym.c
 create mode 100644 sysdeps/unix/sysv/linux/s390/bits/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/sys/rseq.h
 create mode 100644 sysdeps/unix/sysv/linux/x86/bits/rseq.h

diff --git a/ChangeLog b/ChangeLog
index 59dab18463..459af8f1a5 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,50 @@
+2019-04-23  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+
+	* NEWS: Add Restartable Sequences feature description.
+	* csu/libc-start.c: Perform rseq(2) registration at C startup and
+	thread creation.
+	* nptl/pthread_create.c: Likewise.
+	* sysdeps/unix/sysv/linux/Makefile: Add rseq-sym, sys/rseq.h,
+	bits/rseq.h.
+	* sysdeps/unix/sysv/linux/Versions: Export __rseq_abi and
+	__rseq_handled from libc.
+	* sysdeps/unix/sysv/linux/aarch64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/alpha/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/arm/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/csky/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/hppa/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/i386/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/ia64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/microblaze/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/nios2/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist:
+	Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sh/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/x86_64/64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist: Likewise.
+	* misc/rseq-internal.h: New file.
+	* sysdeps/unix/sysv/linux/rseq-internal.h: Likewise.
+	* sysdeps/unix/sysv/linux/rseq-sym.c: Likewise.
+	* sysdeps/unix/sysv/linux/sys/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/aarch64/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/s390/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/x86/bits/rseq.h: Likewise.
+
 2019-01-31  Siddhesh Poyarekar  <siddhesh@sourceware.org>
 
 	* version.h (RELEASE): Set to "stable".
diff --git a/NEWS b/NEWS
index 912a9bdc0f..7276a09b08 100644
--- a/NEWS
+++ b/NEWS
@@ -5,6 +5,21 @@ See the end for copying conditions.
 Please send GNU C library bug reports via <https://sourceware.org/bugzilla/>
 using `glibc' in the "product" field.
 
+Version 2.30
+
+Major new features:
+
+* Support for automatically registering threads with the Linux rseq(2)
+  system call has been added.  This system call is implemented starting
+  from Linux 4.18.  The Restartable Sequences ABI accelerates user-space
+  operations on per-cpu data.  It allows user-space to perform updates
+  on per-cpu data without requiring heavy-weight atomic operations.
+  Automatically registering threads allows all libraries, including libc,
+  to make immediate use of the rseq(2) support by using the documented ABI.
+  See 'man 2 rseq' for the details of the ABI shared between libc and the
+  kernel.
+
+
 Version 2.29
 
 Major new features:
diff --git a/csu/libc-start.c b/csu/libc-start.c
index 5d9c3675fa..e101196b0d 100644
--- a/csu/libc-start.c
+++ b/csu/libc-start.c
@@ -22,6 +22,7 @@
 #include <ldsodefs.h>
 #include <exit-thread.h>
 #include <libc-internal.h>
+#include <rseq-internal.h>
 
 #include <elf/dl-tunables.h>
 
@@ -140,7 +141,12 @@ LIBC_START_MAIN (int (*main) (int, char **, char ** MAIN_AUXVEC_DECL),
 
   __libc_multiple_libcs = &_dl_starting_up && !_dl_starting_up;
 
-#ifndef SHARED
+  rseq_init ();
+
+#ifdef SHARED
+  /* Register rseq ABI to the kernel. */
+  (void) rseq_register_current_thread ();
+#else
   _dl_relocate_static_pie ();
 
   char **ev = &argv[argc + 1];
@@ -218,6 +224,9 @@ LIBC_START_MAIN (int (*main) (int, char **, char ** MAIN_AUXVEC_DECL),
     }
 # endif
 
+  /* Register rseq ABI to the kernel. */
+  (void) rseq_register_current_thread ();
+
   /* Initialize libpthread if linked in.  */
   if (__pthread_initialize_minimal != NULL)
     __pthread_initialize_minimal ();
@@ -230,8 +239,7 @@ LIBC_START_MAIN (int (*main) (int, char **, char ** MAIN_AUXVEC_DECL),
 # else
   __pointer_chk_guard_local = pointer_chk_guard;
 # endif
-
-#endif /* !SHARED  */
+#endif
 
   /* Register the destructor of the dynamic linker if there is any.  */
   if (__glibc_likely (rtld_fini != NULL))
diff --git a/misc/rseq-internal.h b/misc/rseq-internal.h
new file mode 100644
index 0000000000..ccad30bca5
--- /dev/null
+++ b/misc/rseq-internal.h
@@ -0,0 +1,38 @@
+/* Restartable Sequences internal API. Stub version.
+   Copyright (C) 2019 Free Software Foundation, Inc.
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
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef RSEQ_INTERNAL_H
+#define RSEQ_INTERNAL_H
+
+static inline int
+rseq_register_current_thread (void)
+{
+  return -1;
+}
+
+static inline int
+rseq_unregister_current_thread (void)
+{
+  return -1;
+}
+
+static inline int
+rseq_init (void)
+{
+}
+
+#endif /* rseq-internal.h */
diff --git a/nptl/pthread_create.c b/nptl/pthread_create.c
index 2bd2b10727..90b3419390 100644
--- a/nptl/pthread_create.c
+++ b/nptl/pthread_create.c
@@ -33,6 +33,7 @@
 #include <default-sched.h>
 #include <futex-internal.h>
 #include <tls-setup.h>
+#include <rseq-internal.h>
 #include "libioP.h"
 
 #include <shlib-compat.h>
@@ -378,6 +379,7 @@ __free_tcb (struct pthread *pd)
 START_THREAD_DEFN
 {
   struct pthread *pd = START_THREAD_SELF;
+  bool has_rseq = false;
 
 #if HP_TIMING_AVAIL
   /* Remember the time when the thread was started.  */
@@ -396,6 +398,9 @@ START_THREAD_DEFN
   if (__glibc_unlikely (atomic_exchange_acq (&pd->setxid_futex, 0) == -2))
     futex_wake (&pd->setxid_futex, 1, FUTEX_PRIVATE);
 
+  /* Register rseq TLS to the kernel. */
+  has_rseq = !rseq_register_current_thread ();
+
 #ifdef __NR_set_robust_list
 # ifndef __ASSUME_SET_ROBUST_LIST
   if (__set_robust_list_avail >= 0)
@@ -573,6 +578,10 @@ START_THREAD_DEFN
     }
 #endif
 
+  /* Unregister rseq TLS from kernel. */
+  if (has_rseq && rseq_unregister_current_thread ())
+    abort();
+
   advise_stack_range (pd->stackblock, pd->stackblock_size, (uintptr_t) pd,
 		      pd->guardsize);
 
diff --git a/sysdeps/unix/sysv/linux/Makefile b/sysdeps/unix/sysv/linux/Makefile
index 5f8c2c7c7d..5b541469ec 100644
--- a/sysdeps/unix/sysv/linux/Makefile
+++ b/sysdeps/unix/sysv/linux/Makefile
@@ -1,5 +1,5 @@
 ifeq ($(subdir),csu)
-sysdep_routines += errno-loc
+sysdep_routines += errno-loc rseq-sym
 endif
 
 ifeq ($(subdir),assert)
@@ -48,7 +48,7 @@ sysdep_headers += sys/mount.h sys/acct.h sys/sysctl.h \
 		  bits/termios-c_iflag.h bits/termios-c_oflag.h \
 		  bits/termios-baud.h bits/termios-c_cflag.h \
 		  bits/termios-c_lflag.h bits/termios-tcflow.h \
-		  bits/termios-misc.h
+		  bits/termios-misc.h sys/rseq.h bits/rseq.h
 
 tests += tst-clone tst-clone2 tst-clone3 tst-fanotify tst-personality \
 	 tst-quota tst-sync_file_range tst-sysconf-iov_max tst-ttyname \
diff --git a/sysdeps/unix/sysv/linux/Versions b/sysdeps/unix/sysv/linux/Versions
index f1e12d9c69..bee3d727e5 100644
--- a/sysdeps/unix/sysv/linux/Versions
+++ b/sysdeps/unix/sysv/linux/Versions
@@ -174,6 +174,10 @@ libc {
   GLIBC_2.29 {
     getcpu;
   }
+  GLIBC_2.30 {
+    __rseq_abi;
+    __rseq_handled;
+  }
   GLIBC_PRIVATE {
     # functions used in other libraries
     __syscall_rt_sigqueueinfo;
diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
new file mode 100644
index 0000000000..35fcc41f1e
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
@@ -0,0 +1,43 @@
+/* Restartable Sequences Linux aarch64 architecture header.
+   Copyright (C) 2019 Free Software Foundation, Inc.
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
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries. It needs to be defined for each
+   architecture. When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.
+
+   aarch64 -mbig-endian generates mixed endianness code vs data:
+   little-endian code and big-endian data. Ensure the RSEQ_SIG signature
+   matches code endianness.  */
+
+#define RSEQ_SIG_CODE	0xd428bc00	/* BRK #0x45E0.  */
+
+#ifdef __AARCH64EB__
+#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
+#else
+#define RSEQ_SIG_DATA	RSEQ_SIG_CODE
+#endif
+
+#define RSEQ_SIG	RSEQ_SIG_DATA
diff --git a/sysdeps/unix/sysv/linux/aarch64/libc.abilist b/sysdeps/unix/sysv/linux/aarch64/libc.abilist
index 9c330f325e..331f39e41a 100644
--- a/sysdeps/unix/sysv/linux/aarch64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/aarch64/libc.abilist
@@ -2141,3 +2141,5 @@ GLIBC_2.28 thrd_yield F
 GLIBC_2.29 getcpu F
 GLIBC_2.29 posix_spawn_file_actions_addchdir_np F
 GLIBC_2.29 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/alpha/libc.abilist b/sysdeps/unix/sysv/linux/alpha/libc.abilist
index f630fa4c6f..05dfdd3393 100644
--- a/sysdeps/unix/sysv/linux/alpha/libc.abilist
+++ b/sysdeps/unix/sysv/linux/alpha/libc.abilist
@@ -2204,6 +2204,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/arm/libc.abilist b/sysdeps/unix/sysv/linux/arm/libc.abilist
index b96f45590f..24e9b89a50 100644
--- a/sysdeps/unix/sysv/linux/arm/libc.abilist
+++ b/sysdeps/unix/sysv/linux/arm/libc.abilist
@@ -126,6 +126,8 @@ GLIBC_2.28 thrd_yield F
 GLIBC_2.29 getcpu F
 GLIBC_2.29 posix_spawn_file_actions_addchdir_np F
 GLIBC_2.29 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _Exit F
 GLIBC_2.4 _IO_2_1_stderr_ D 0xa0
 GLIBC_2.4 _IO_2_1_stdin_ D 0xa0
diff --git a/sysdeps/unix/sysv/linux/bits/rseq.h b/sysdeps/unix/sysv/linux/bits/rseq.h
new file mode 100644
index 0000000000..a3c023f5c7
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/bits/rseq.h
@@ -0,0 +1,29 @@
+/* Restartable Sequences architecture header. Stub version.
+   Copyright (C) 2019 Free Software Foundation, Inc.
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
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries. It needs to be defined for each
+   architecture. When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.  */
diff --git a/sysdeps/unix/sysv/linux/csky/libc.abilist b/sysdeps/unix/sysv/linux/csky/libc.abilist
index 019044c3cd..e2b0538088 100644
--- a/sysdeps/unix/sysv/linux/csky/libc.abilist
+++ b/sysdeps/unix/sysv/linux/csky/libc.abilist
@@ -2085,3 +2085,5 @@ GLIBC_2.29 xdrstdio_create F
 GLIBC_2.29 xencrypt F
 GLIBC_2.29 xprt_register F
 GLIBC_2.29 xprt_unregister F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/hppa/libc.abilist b/sysdeps/unix/sysv/linux/hppa/libc.abilist
index 088a8ee369..263a91b97e 100644
--- a/sysdeps/unix/sysv/linux/hppa/libc.abilist
+++ b/sysdeps/unix/sysv/linux/hppa/libc.abilist
@@ -2037,6 +2037,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/i386/libc.abilist b/sysdeps/unix/sysv/linux/i386/libc.abilist
index f7ff2c57b9..18ce09d48a 100644
--- a/sysdeps/unix/sysv/linux/i386/libc.abilist
+++ b/sysdeps/unix/sysv/linux/i386/libc.abilist
@@ -2203,6 +2203,8 @@ GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 vm86 F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/ia64/libc.abilist b/sysdeps/unix/sysv/linux/ia64/libc.abilist
index becd8b1033..b61e2ee010 100644
--- a/sysdeps/unix/sysv/linux/ia64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/ia64/libc.abilist
@@ -2069,6 +2069,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist b/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
index 74e42a5209..e55792bb22 100644
--- a/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
@@ -127,6 +127,8 @@ GLIBC_2.28 thrd_yield F
 GLIBC_2.29 getcpu F
 GLIBC_2.29 posix_spawn_file_actions_addchdir_np F
 GLIBC_2.29 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _Exit F
 GLIBC_2.4 _IO_2_1_stderr_ D 0x98
 GLIBC_2.4 _IO_2_1_stdin_ D 0x98
diff --git a/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist b/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
index 4af5a74e8a..9845499048 100644
--- a/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
@@ -2146,6 +2146,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/microblaze/libc.abilist b/sysdeps/unix/sysv/linux/microblaze/libc.abilist
index ccef673fd2..1aba8cb86c 100644
--- a/sysdeps/unix/sysv/linux/microblaze/libc.abilist
+++ b/sysdeps/unix/sysv/linux/microblaze/libc.abilist
@@ -2133,3 +2133,5 @@ GLIBC_2.28 thrd_yield F
 GLIBC_2.29 getcpu F
 GLIBC_2.29 posix_spawn_file_actions_addchdir_np F
 GLIBC_2.29 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
index 1054bb599e..df54e2adab 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
@@ -2120,6 +2120,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
index 4f5b5ffebf..ce95ae7e86 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
@@ -2118,6 +2118,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
index 943aee58d4..c9fb5d2096 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
@@ -2126,6 +2126,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
index 17a5d17ef9..6335df9acf 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
@@ -2120,6 +2120,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/nios2/libc.abilist b/sysdeps/unix/sysv/linux/nios2/libc.abilist
index 4d62a540fd..5465b96768 100644
--- a/sysdeps/unix/sysv/linux/nios2/libc.abilist
+++ b/sysdeps/unix/sysv/linux/nios2/libc.abilist
@@ -2174,3 +2174,5 @@ GLIBC_2.28 thrd_yield F
 GLIBC_2.29 getcpu F
 GLIBC_2.29 posix_spawn_file_actions_addchdir_np F
 GLIBC_2.29 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
index ecc2d6fa13..eb3808dbd4 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
@@ -2164,6 +2164,8 @@ GLIBC_2.3.4 siglongjmp F
 GLIBC_2.3.4 swapcontext F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
index f5830f9c33..6a49a7b718 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
@@ -2197,6 +2197,8 @@ GLIBC_2.3.4 siglongjmp F
 GLIBC_2.3.4 swapcontext F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
index 633d8f4792..83177dc75f 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
@@ -2027,6 +2027,8 @@ GLIBC_2.3.4 siglongjmp F
 GLIBC_2.3.4 swapcontext F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
index 2c712636ef..e714de994c 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
@@ -2231,3 +2231,5 @@ GLIBC_2.28 thrd_yield F
 GLIBC_2.29 getcpu F
 GLIBC_2.29 posix_spawn_file_actions_addchdir_np F
 GLIBC_2.29 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist b/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
index 195bc8b2cf..d190623993 100644
--- a/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
@@ -2103,3 +2103,5 @@ GLIBC_2.28 thrd_yield F
 GLIBC_2.29 getcpu F
 GLIBC_2.29 posix_spawn_file_actions_addchdir_np F
 GLIBC_2.29 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h b/sysdeps/unix/sysv/linux/rseq-internal.h
new file mode 100644
index 0000000000..edb31b1c3c
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/rseq-internal.h
@@ -0,0 +1,88 @@
+/* Restartable Sequences internal API. Linux implementation.
+   Copyright (C) 2019 Free Software Foundation, Inc.
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
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef RSEQ_INTERNAL_H
+#define RSEQ_INTERNAL_H
+
+#include <sysdep.h>
+#include <errno.h>
+
+#ifdef __NR_rseq
+#include <sys/rseq.h>
+#endif
+
+#if defined __NR_rseq && defined RSEQ_SIG
+
+static inline int
+rseq_register_current_thread (void)
+{
+  int rc, ret = 0;
+  INTERNAL_SYSCALL_DECL (err);
+
+  if (__rseq_abi.cpu_id == RSEQ_CPU_ID_REGISTRATION_FAILED)
+    return -1;
+  rc = INTERNAL_SYSCALL_CALL (rseq, err, &__rseq_abi, sizeof (struct rseq),
+                              0, RSEQ_SIG);
+  if (!rc)
+    goto end;
+  if (INTERNAL_SYSCALL_ERRNO (rc, err) != EBUSY)
+    __rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
+  ret = -1;
+end:
+  return ret;
+}
+
+static inline int
+rseq_unregister_current_thread (void)
+{
+  int rc, ret = 0;
+  INTERNAL_SYSCALL_DECL (err);
+
+  rc = INTERNAL_SYSCALL_CALL (rseq, err, &__rseq_abi, sizeof (struct rseq),
+                              RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
+  if (!rc)
+    goto end;
+  ret = -1;
+end:
+  return ret;
+}
+
+static inline void
+rseq_init (void)
+{
+  __rseq_handled = 1;
+}
+#else
+static inline int
+rseq_register_current_thread (void)
+{
+  return -1;
+}
+
+static inline int
+rseq_unregister_current_thread (void)
+{
+  return -1;
+}
+
+static inline void
+rseq_init (void)
+{
+}
+#endif
+
+#endif /* rseq-internal.h */
diff --git a/sysdeps/unix/sysv/linux/rseq-sym.c b/sysdeps/unix/sysv/linux/rseq-sym.c
new file mode 100644
index 0000000000..8e3abab3d0
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/rseq-sym.c
@@ -0,0 +1,63 @@
+/* Restartable Sequences exported symbols. Linux Implementation.
+   Copyright (C) 2019 Free Software Foundation, Inc.
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
+   <http://www.gnu.org/licenses/>.  */
+
+#include <sys/syscall.h>
+#include <stdint.h>
+
+#ifdef __NR_rseq
+#include <sys/rseq.h>
+#else
+
+enum rseq_cpu_id_state {
+  RSEQ_CPU_ID_UNINITIALIZED = -1,
+  RSEQ_CPU_ID_REGISTRATION_FAILED = -2,
+};
+
+/* linux/rseq.h defines struct rseq as aligned on 32 bytes. The kernel ABI
+   size is 20 bytes.  */
+struct rseq {
+  uint32_t cpu_id_start;
+  uint32_t cpu_id;
+  uint64_t rseq_cs;
+  uint32_t flags;
+} __attribute__ ((aligned(4 * sizeof(uint64_t))));
+
+#endif
+
+/* volatile because fields can be read/updated by the kernel.  */
+__thread volatile struct rseq __rseq_abi = {
+  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+};
+
+/* Advertise Restartable Sequences registration ownership across
+   application and shared libraries.
+
+   Libraries and applications must check whether this variable is zero or
+   non-zero if they wish to perform rseq registration on their own. If it
+   is zero, it means restartable sequence registration is not handled, and
+   the library or application is free to perform rseq registration. In
+   that case, the library or application is taking ownership of rseq
+   registration, and may set __rseq_handled to 1. It may then set it back
+   to 0 after it completes unregistering rseq.
+
+   If __rseq_handled is found to be non-zero, it means that another
+   library (or the application) is currently handling rseq registration.
+
+   Typical use of __rseq_handled is within library constructors and
+   destructors, or at program startup.  */
+
+int __rseq_handled;
diff --git a/sysdeps/unix/sysv/linux/s390/bits/rseq.h b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
new file mode 100644
index 0000000000..0ed16c23a4
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
@@ -0,0 +1,30 @@
+/* Restartable Sequences Linux s390 architecture header.
+   Copyright (C) 2019 Free Software Foundation, Inc.
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
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
+#endif
+
+/* RSEQ_SIG is a signature required before each abort handler code.
+
+   RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
+   access-register mode nor the linkage stack this instruction will always
+   cause a special-operation exception (the trap-enabled bit in the DUCT
+   is and will stay 0). The instruction pattern is
+	b2 ff 0f ff	trap4   4095(%r0)  */
+
+#define RSEQ_SIG	0xB2FF0FFF
diff --git a/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist b/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
index 334def033c..dacae17ec4 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
@@ -2159,6 +2159,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist b/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
index 536f4c4ced..c277b3bd90 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
@@ -2063,6 +2063,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/sh/libc.abilist b/sysdeps/unix/sysv/linux/sh/libc.abilist
index 30ae3b6ebb..5f70e5c53b 100644
--- a/sysdeps/unix/sysv/linux/sh/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sh/libc.abilist
@@ -2041,6 +2041,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist b/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
index 68b107d080..537da009d3 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
@@ -2153,6 +2153,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist b/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
index e5b6a4da50..1fee8e34fc 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
@@ -2092,6 +2092,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h b/sysdeps/unix/sysv/linux/sys/rseq.h
new file mode 100644
index 0000000000..5698f4a96d
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/sys/rseq.h
@@ -0,0 +1,50 @@
+/* Restartable Sequences exported symbols. Linux header.
+   Copyright (C) 2019 Free Software Foundation, Inc.
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
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef _SYS_RSEQ_H
+#define _SYS_RSEQ_H	1
+
+/* We use the structures declarations from the kernel headers.  */
+#include <linux/rseq.h>
+/* Architecture-specific rseq signature.  */
+#include <bits/rseq.h>
+#include <stdint.h>
+
+/* volatile because fields can be read/updated by the kernel.  */
+extern __thread volatile struct rseq __rseq_abi
+__attribute__ ((tls_model ("initial-exec")));
+
+/* Advertise Restartable Sequences registration ownership across
+   application and shared libraries.
+
+   Libraries and applications must check whether this variable is zero or
+   non-zero if they wish to perform rseq registration on their own. If it
+   is zero, it means restartable sequence registration is not handled, and
+   the library or application is free to perform rseq registration. In
+   that case, the library or application is taking ownership of rseq
+   registration, and may set __rseq_handled to 1. It may then set it back
+   to 0 after it completes unregistering rseq.
+
+   If __rseq_handled is found to be non-zero, it means that another
+   library (or the application) is currently handling rseq registration.
+
+   Typical use of __rseq_handled is within library constructors and
+   destructors, or at program startup.  */
+
+extern int __rseq_handled;
+
+#endif /* sys/rseq.h */
diff --git a/sysdeps/unix/sysv/linux/x86/bits/rseq.h b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
new file mode 100644
index 0000000000..a2918c4617
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
@@ -0,0 +1,30 @@
+/* Restartable Sequences Linux x86 architecture header.
+   Copyright (C) 2019 Free Software Foundation, Inc.
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
+   <http://www.gnu.org/licenses/>.  */
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
+#define RSEQ_SIG	0x53053053
diff --git a/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist b/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
index 86dfb0c94d..a834f65383 100644
--- a/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
@@ -2050,6 +2050,8 @@ GLIBC_2.3.4 setipv4sourcefilter F
 GLIBC_2.3.4 setsourcefilter F
 GLIBC_2.3.4 xdr_quad_t F
 GLIBC_2.3.4 xdr_u_quad_t F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist b/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
index dd688263aa..fb8417bde7 100644
--- a/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
@@ -2149,3 +2149,5 @@ GLIBC_2.28 thrd_yield F
 GLIBC_2.29 getcpu F
 GLIBC_2.29 posix_spawn_file_actions_addchdir_np F
 GLIBC_2.29 posix_spawn_file_actions_addfchdir_np F
+GLIBC_2.30 __rseq_abi T 0x20
+GLIBC_2.30 __rseq_handled D 0x4
-- 
2.17.1



