Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9F18F588
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2020 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgCWNRu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 09:17:50 -0400
Received: from mail.efficios.com ([167.114.26.124]:41586 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgCWNRt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Mar 2020 09:17:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 07B6D1B7C29;
        Mon, 23 Mar 2020 09:17:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5L9VbZyCRjWP; Mon, 23 Mar 2020 09:17:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1DCA01B7BB6;
        Mon, 23 Mar 2020 09:17:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1DCA01B7BB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584969461;
        bh=X6LpDBF0LP/tHE5d72ie6uZ8JONqadK/uXxol+KvhAw=;
        h=From:To:Date:Message-Id;
        b=K201S3KKyiCoHJ/2SG+kkEsKZd2CUa2MANHiOtZatUYvLlwUn8y5ewzs7u6eUVKIG
         MCXT9GFD9vA+8FENbjLwaUGA1P8PGl7/mF4txSSY7EzJuJQB3cMyDNNG2KFffLhmdU
         qD5a2eBpziCmSRCHD3JHJC0LfKAurXFtaUT3gflOfw0bHXVzu9XWoB81Z1C131cd92
         QT+RzjnHd//pywC76DM7ktvvsVb2PAe7ik4VkF8INztBzAi5EqGMQ3LSsG35sUoyyu
         L8LGSK2UFeqRg1aVdFN9XdWc8lPu5xdA0+JYEwmZmQbBWD/bch6/XaLMKQXhD1Wqzv
         6pZki5HmmbKtg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id thYbWui-xwrR; Mon, 23 Mar 2020 09:17:41 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 49E641B7CA4;
        Mon, 23 Mar 2020 09:17:38 -0400 (EDT)
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
Subject: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C startup and thread creation (v16)
Date:   Mon, 23 Mar 2020 09:16:03 -0400
Message-Id: <20200323131607.15185-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323131607.15185-1-mathieu.desnoyers@efficios.com>
References: <20200323131607.15185-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Register rseq(2) TLS for each thread (including main), and unregister
for each thread (excluding main). "rseq" stands for Restartable
Sequences.

See the rseq(2) man page proposed here:
  https://lkml.org/lkml/2018/9/19/647

This patch depends on three patches from Florian Weimer:

- Introduce <elf_machine_sym_no_match.h>
- Implement __libc_early_init
- nptl: Start new threads with all signals blocked [BZ #25098]

those are based on glibc master branch commit 1fabdb99084df004f7f4cdc7068d1be209a258be.
The rseq(2) system call was merged into Linux 4.18.

	* NEWS: Add Restartable Sequences feature description.
	* elf/libc_early_init.c: Perform rseq(2) registration at C startup.
	startup for shared libc.
	* nptl/pthread_create.c: Perform rseq(2) registration at thread
	creation.
	* manual/threads.texi: Document __rseq_abi, RSEQ_SIG, sys/rseq.h.
	* sysdeps/unix/sysv/linux/Makefile: Add rseq-sym, sys/rseq.h,
	bits/rseq.h.
	* sysdeps/unix/sysv/linux/Versions: Export __rseq_abi from libc.
	* sysdeps/unix/sysv/linux/aarch64/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/alpha/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/arm/be/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/arm/le/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/csky/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/hppa/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/i386/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/ia64/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/microblaze/be/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/microblaze/le/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/nios2/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/sh/be/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/sh/le/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/x86_64/64/libc.abilist: Likewise.
	* sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist: Likewise.
	* misc/rseq-internal.h: New file.
	* sysdeps/unix/sysv/linux/rseq-internal.h: Likewise.
	* sysdeps/unix/sysv/linux/rseq-sym.c: Likewise.
	* sysdeps/unix/sysv/linux/sys/rseq.h: Likewise.
	* sysdeps/unix/sysv/linux/bits/rseq.h: Likewise.
	* sysdeps/unix/sysv/linux/aarch64/bits/rseq.h: Likewise.
	* sysdeps/unix/sysv/linux/arm/bits/rseq.h: Likewise.
	* sysdeps/unix/sysv/linux/mips/bits/rseq.h: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/bits/rseq.h: Likewise.
	* sysdeps/unix/sysv/linux/s390/bits/rseq.h: Likewise.
	* sysdeps/unix/sysv/linux/x86/bits/rseq.h: Likewise.

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

Changes since v10:
- Remove volatile from __rseq_abi declaration.
- Document that __rseq_handled is about library managing rseq
  registration, independently of whether rseq is available or not.
- Move __rseq_handled symbol to ld.so, initialize this symbol within
  the dynamic linker initialization for both shared (rtld.c) and static
  (dl-support.c) builds.
- Only register the rseq TLS on initialization once in multiple-libc
  scenarios. Use rtld_active () for this purpose.
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
  availability. This is necessary now that the system call numbers are
  integrated within glibc.

Changes since v15:
- Remove __ASSUME_RSEQ from kernel features.
- rseq internal: remove assume rseq
- remove assume rseq and struct rseq def from sysdeps/unix/sysv/linux/rseq-sym.c
- sys/rseq.h: detect rseq header, implement fallback
- sysdeps/unix/sysv/linux/sys/rseq.h include cdefs.h, add _Static_assert
  to validate struct rseq and struct rseq_cs alignment.
- sys/rseq.h: document that posix_memalign should be used rather than
  malloc if allocating struct rseq or struct rseq_cs on the heap. This
  is required to guarantee 32-byte alignement.

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
 NEWS                                          |  10 +
 elf/libc_early_init.c                         |   3 +
 manual/threads.texi                           |  30 ++-
 misc/rseq-internal.h                          |  33 ++++
 nptl/pthread_create.c                         |  12 ++
 sysdeps/unix/sysv/linux/Makefile              |   5 +-
 sysdeps/unix/sysv/linux/Versions              |   3 +
 sysdeps/unix/sysv/linux/aarch64/bits/rseq.h   |  43 ++++
 sysdeps/unix/sysv/linux/aarch64/libc.abilist  |   1 +
 sysdeps/unix/sysv/linux/alpha/libc.abilist    |   1 +
 sysdeps/unix/sysv/linux/arm/be/libc.abilist   |   1 +
 sysdeps/unix/sysv/linux/arm/bits/rseq.h       |  83 ++++++++
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
 sysdeps/unix/sysv/linux/mips/bits/rseq.h      |  62 ++++++
 .../sysv/linux/mips/mips32/fpu/libc.abilist   |   1 +
 .../sysv/linux/mips/mips32/nofpu/libc.abilist |   1 +
 .../sysv/linux/mips/mips64/n32/libc.abilist   |   1 +
 .../sysv/linux/mips/mips64/n64/libc.abilist   |   1 +
 sysdeps/unix/sysv/linux/nios2/libc.abilist    |   1 +
 sysdeps/unix/sysv/linux/powerpc/bits/rseq.h   |  37 ++++
 .../linux/powerpc/powerpc32/fpu/libc.abilist  |   1 +
 .../powerpc/powerpc32/nofpu/libc.abilist      |   1 +
 .../linux/powerpc/powerpc64/be/libc.abilist   |   1 +
 .../linux/powerpc/powerpc64/le/libc.abilist   |   1 +
 .../unix/sysv/linux/riscv/rv64/libc.abilist   |   1 +
 sysdeps/unix/sysv/linux/rseq-internal.h       |  73 +++++++
 sysdeps/unix/sysv/linux/rseq-sym.c            |  25 +++
 sysdeps/unix/sysv/linux/s390/bits/rseq.h      |  37 ++++
 .../unix/sysv/linux/s390/s390-32/libc.abilist |   1 +
 .../unix/sysv/linux/s390/s390-64/libc.abilist |   1 +
 sysdeps/unix/sysv/linux/sh/be/libc.abilist    |   1 +
 sysdeps/unix/sysv/linux/sh/le/libc.abilist    |   1 +
 .../sysv/linux/sparc/sparc32/libc.abilist     |   1 +
 .../sysv/linux/sparc/sparc64/libc.abilist     |   1 +
 sysdeps/unix/sysv/linux/sys/rseq.h            | 186 ++++++++++++++++++
 sysdeps/unix/sysv/linux/x86/bits/rseq.h       |  30 +++
 .../unix/sysv/linux/x86_64/64/libc.abilist    |   1 +
 .../unix/sysv/linux/x86_64/x32/libc.abilist   |   1 +
 47 files changed, 727 insertions(+), 4 deletions(-)
 create mode 100644 misc/rseq-internal.h
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
index e0379fc53c..abc62ae5f5 100644
--- a/NEWS
+++ b/NEWS
@@ -61,6 +61,16 @@ Major new features:
   responses, indicating a lack of DNSSEC validation.  (Therefore, the name
   servers and the network path to them are treated as untrusted.)
 
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
 Deprecated and removed features, and other changes affecting compatibility:
 
 * The totalorder and totalordermag functions, and the corresponding
diff --git a/elf/libc_early_init.c b/elf/libc_early_init.c
index 1ac66d895d..30466afea0 100644
--- a/elf/libc_early_init.c
+++ b/elf/libc_early_init.c
@@ -18,10 +18,13 @@
 
 #include <ctype.h>
 #include <libc-early-init.h>
+#include <rseq-internal.h>
 
 void
 __libc_early_init (void)
 {
   /* Initialize ctype data.  */
   __ctype_init ();
+  /* Register rseq ABI to the kernel.   */
+  (void) rseq_register_current_thread ();
 }
diff --git a/manual/threads.texi b/manual/threads.texi
index 0858ef8f92..59f634e432 100644
--- a/manual/threads.texi
+++ b/manual/threads.texi
@@ -9,8 +9,10 @@ This chapter describes functions used for managing threads.
 POSIX threads.
 
 @menu
-* ISO C Threads::	Threads based on the ISO C specification.
-* POSIX Threads::	Threads based on the POSIX specification.
+* ISO C Threads::		Threads based on the ISO C specification.
+* POSIX Threads::		Threads based on the POSIX specification.
+* Restartable Sequences::	Linux-specific Restartable Sequences
+				integration.
 @end menu
 
 
@@ -881,3 +883,27 @@ Behaves like @code{pthread_timedjoin_np} except that the absolute time in
 @c pthread_spin_unlock
 @c pthread_testcancel
 @c pthread_yield
+
+@node Restartable Sequences
+@section Restartable Sequences
+@cindex rseq
+
+This section describes @theglibc{} Restartable Sequences integration.
+
+@deftypevar {struct rseq} __rseq_abi
+@standards{GNU, sys/rseq.h}
+@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with the
+Restartable Sequences system call (Linux-specific).  The layout of this
+structure is defined by the Linux kernel @file{linux/rseq.h} UAPI.
+Registration of each thread's @code{__rseq_abi} is performed by
+@theglibc{} at libc initialization and pthread creation.
+@end deftypevar
+
+@deftypevr Macro int RSEQ_SIG
+@standards{GNU, sys/rseq.h}
+Each supported architecture provide a @code{RSEQ_SIG} macro in
+@file{sys/rseq.h} which contains a signature.  That signature is expected to be
+present in the code before each Restartable Sequences abort handler.  Failure
+to provide the expected signature may terminate the process with a Segmentation
+fault.
+@end deftypevr
diff --git a/misc/rseq-internal.h b/misc/rseq-internal.h
new file mode 100644
index 0000000000..d564cf1bc3
--- /dev/null
+++ b/misc/rseq-internal.h
@@ -0,0 +1,33 @@
+/* Restartable Sequences internal API. Stub version.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
+#endif /* rseq-internal.h */
diff --git a/nptl/pthread_create.c b/nptl/pthread_create.c
index afd379e89a..1ff248042e 100644
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
 
+  /* Register rseq TLS to the kernel. */
+  (void) rseq_register_current_thread ();
+
 #ifndef __ASSUME_SET_ROBUST_LIST
   if (__set_robust_list_avail >= 0)
 #endif
@@ -578,6 +582,14 @@ START_THREAD_DEFN
      process is really dead since 'clone' got passed the CLONE_CHILD_CLEARTID
      flag.  The 'tid' field in the TCB will be set to zero.
 
+     rseq TLS is still registered at this point. Rely on implicit unregistration
+     performed by the kernel on thread teardown. This is not a problem because the
+     rseq TLS lives on the stack, and the stack outlives the thread. If TCB
+     allocation is ever changed, additional steps may be required, such as
+     performing explicit rseq unregistration before reclaiming the rseq TLS area
+     memory. It is NOT sufficient to block signals because the kernel may write
+     to the rseq area even without signals.
+
      The exit code is zero since in case all threads exit by calling
      'pthread_exit' the exit status must be 0 (zero).  */
   __exit_thread ();
diff --git a/sysdeps/unix/sysv/linux/Makefile b/sysdeps/unix/sysv/linux/Makefile
index 60dc5cf9e5..6c6f669d21 100644
--- a/sysdeps/unix/sysv/linux/Makefile
+++ b/sysdeps/unix/sysv/linux/Makefile
@@ -41,7 +41,7 @@ update-syscall-lists: arch-syscall.h
 endif
 
 ifeq ($(subdir),csu)
-sysdep_routines += errno-loc
+sysdep_routines += errno-loc rseq-sym
 endif
 
 ifeq ($(subdir),assert)
@@ -92,7 +92,8 @@ sysdep_headers += sys/mount.h sys/acct.h sys/sysctl.h \
 		  bits/termios-baud.h bits/termios-c_cflag.h \
 		  bits/termios-c_lflag.h bits/termios-tcflow.h \
 		  bits/termios-misc.h \
-		  bits/ipc-perm.h
+		  bits/ipc-perm.h \
+		  sys/rseq.h bits/rseq.h
 
 tests += tst-clone tst-clone2 tst-clone3 tst-fanotify tst-personality \
 	 tst-quota tst-sync_file_range tst-sysconf-iov_max tst-ttyname \
diff --git a/sysdeps/unix/sysv/linux/Versions b/sysdeps/unix/sysv/linux/Versions
index d385085c61..7f0da50580 100644
--- a/sysdeps/unix/sysv/linux/Versions
+++ b/sysdeps/unix/sysv/linux/Versions
@@ -177,6 +177,9 @@ libc {
   GLIBC_2.30 {
     getdents64; gettid; tgkill;
   }
+  GLIBC_2.31 {
+    __rseq_abi;
+  }
   GLIBC_PRIVATE {
     # functions used in other libraries
     __syscall_rt_sigqueueinfo;
diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
new file mode 100644
index 0000000000..e272c30446
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
@@ -0,0 +1,43 @@
+/* Restartable Sequences Linux aarch64 architecture header.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
index a4c31932cb..6784f13c09 100644
--- a/sysdeps/unix/sysv/linux/aarch64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/aarch64/libc.abilist
@@ -2145,3 +2145,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/alpha/libc.abilist b/sysdeps/unix/sysv/linux/alpha/libc.abilist
index e7f2174ac2..71db8422a2 100644
--- a/sysdeps/unix/sysv/linux/alpha/libc.abilist
+++ b/sysdeps/unix/sysv/linux/alpha/libc.abilist
@@ -2225,6 +2225,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/arm/be/libc.abilist b/sysdeps/unix/sysv/linux/arm/be/libc.abilist
index b152c0e24a..eecebc908f 100644
--- a/sysdeps/unix/sysv/linux/arm/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/arm/be/libc.abilist
@@ -133,6 +133,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _Exit F
 GLIBC_2.4 _IO_2_1_stderr_ D 0xa0
 GLIBC_2.4 _IO_2_1_stdin_ D 0xa0
diff --git a/sysdeps/unix/sysv/linux/arm/bits/rseq.h b/sysdeps/unix/sysv/linux/arm/bits/rseq.h
new file mode 100644
index 0000000000..45a2118dbc
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/arm/bits/rseq.h
@@ -0,0 +1,83 @@
+/* Restartable Sequences Linux arm architecture header.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
+/*
+   RSEQ_SIG is a signature required before each abort handler code.
+
+   It is a 32-bit value that maps to actual architecture code compiled
+   into applications and libraries. It needs to be defined for each
+   architecture. When choosing this value, it needs to be taken into
+   account that generating invalid instructions may have ill effects on
+   tools like objdump, and may also have impact on the CPU speculative
+   execution efficiency in some cases.
+
+   - ARM little endian
+
+   RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
+   value 0x5de3. This traps if user-space reaches this instruction by mistake,
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
+   code and big-endian data. The data value of the signature needs to have its
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
+   signature should not be reversed. However, the choice between BE32
+   and BE8 is done by the linker, so we cannot know whether code and
+   data endianness will be mixed before the linker is invoked. So rather
+   than try to play tricks with the linker, the rseq signature is simply
+   data (not a trap instruction) prior to ARMv6 on big endian. This is
+   why the signature is expressed as data (.word) rather than as
+   instruction (.inst) in assembler.  */
+
+#ifdef __ARMEB__
+#define RSEQ_SIG    0xf3def5e7      /* udf    #24035    ; 0x5de3 (ARMv6+) */
+#else
+#define RSEQ_SIG    0xe7f5def3      /* udf    #24035    ; 0x5de3 */
+#endif
diff --git a/sysdeps/unix/sysv/linux/arm/le/libc.abilist b/sysdeps/unix/sysv/linux/arm/le/libc.abilist
index 9371927927..3e7434d3d5 100644
--- a/sysdeps/unix/sysv/linux/arm/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/arm/le/libc.abilist
@@ -130,6 +130,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _Exit F
 GLIBC_2.4 _IO_2_1_stderr_ D 0xa0
 GLIBC_2.4 _IO_2_1_stdin_ D 0xa0
diff --git a/sysdeps/unix/sysv/linux/bits/rseq.h b/sysdeps/unix/sysv/linux/bits/rseq.h
new file mode 100644
index 0000000000..b8a63ed26d
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/bits/rseq.h
@@ -0,0 +1,29 @@
+/* Restartable Sequences architecture header. Stub version.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
index 9b3cee65bb..b7ed346b1c 100644
--- a/sysdeps/unix/sysv/linux/csky/libc.abilist
+++ b/sysdeps/unix/sysv/linux/csky/libc.abilist
@@ -2089,3 +2089,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/hppa/libc.abilist b/sysdeps/unix/sysv/linux/hppa/libc.abilist
index df6d96fbae..d55b153c48 100644
--- a/sysdeps/unix/sysv/linux/hppa/libc.abilist
+++ b/sysdeps/unix/sysv/linux/hppa/libc.abilist
@@ -2046,6 +2046,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/i386/libc.abilist b/sysdeps/unix/sysv/linux/i386/libc.abilist
index fcb625b6bf..c9061600f6 100644
--- a/sysdeps/unix/sysv/linux/i386/libc.abilist
+++ b/sysdeps/unix/sysv/linux/i386/libc.abilist
@@ -2212,6 +2212,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/ia64/libc.abilist b/sysdeps/unix/sysv/linux/ia64/libc.abilist
index cb556c5998..f794303f0e 100644
--- a/sysdeps/unix/sysv/linux/ia64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/ia64/libc.abilist
@@ -2078,6 +2078,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist b/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
index 5e3cdea246..e5e545f3af 100644
--- a/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
@@ -134,6 +134,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _Exit F
 GLIBC_2.4 _IO_2_1_stderr_ D 0x98
 GLIBC_2.4 _IO_2_1_stdin_ D 0x98
diff --git a/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist b/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
index ea5e7a41af..3fc1223e2c 100644
--- a/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
@@ -2158,6 +2158,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/microblaze/be/libc.abilist b/sysdeps/unix/sysv/linux/microblaze/be/libc.abilist
index ac55b0acd7..81db30b543 100644
--- a/sysdeps/unix/sysv/linux/microblaze/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/microblaze/be/libc.abilist
@@ -2140,3 +2140,4 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/microblaze/le/libc.abilist b/sysdeps/unix/sysv/linux/microblaze/le/libc.abilist
index f7ced487f7..a2ce147dde 100644
--- a/sysdeps/unix/sysv/linux/microblaze/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/microblaze/le/libc.abilist
@@ -2137,3 +2137,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/mips/bits/rseq.h b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
new file mode 100644
index 0000000000..4eee59265a
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
@@ -0,0 +1,62 @@
+/* Restartable Sequences Linux mips architecture header.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
+   RSEQ_SIG uses the break instruction. The instruction pattern is:
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
+#if defined(__nanomips__)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG	0x03500010
+# else
+#  define RSEQ_SIG	0x00100350
+# endif
+#elif defined(__mips_micromips)
+# ifdef __MIPSEL__
+#  define RSEQ_SIG	0xd4070000
+# else
+#  define RSEQ_SIG	0x0000d407
+# endif
+#elif defined(__mips__)
+# define RSEQ_SIG	0x0350000d
+#else
+/* Unknown MIPS architecture. */
+#endif
diff --git a/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
index 06c2e64edd..c0040ddd4e 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
@@ -2129,6 +2129,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
index bdfd073b86..61f19076eb 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
@@ -2127,6 +2127,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
index 3d61d4974a..df4f3a3c04 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
@@ -2135,6 +2135,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
index 675acca5db..a96de2e467 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
@@ -2129,6 +2129,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/nios2/libc.abilist b/sysdeps/unix/sysv/linux/nios2/libc.abilist
index 7fec0c9670..7b2ccbe953 100644
--- a/sysdeps/unix/sysv/linux/nios2/libc.abilist
+++ b/sysdeps/unix/sysv/linux/nios2/libc.abilist
@@ -2178,3 +2178,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h b/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h
new file mode 100644
index 0000000000..9d10000a6e
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h
@@ -0,0 +1,37 @@
+/* Restartable Sequences Linux powerpc architecture header.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
+   RSEQ_SIG uses the following trap instruction:
+
+   powerpc-be:    0f e5 00 0b           twui   r5,11
+   powerpc64-le:  0b 00 e5 0f           twui   r5,11
+   powerpc64-be:  0f e5 00 0b           twui   r5,11  */
+
+#define RSEQ_SIG	0x0fe5000b
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
index 1e8ff6f83e..6f4c6515dc 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
@@ -2185,6 +2185,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
index b5a0751d90..f9875b4e22 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
@@ -2218,6 +2218,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
index 0c86217fc6..db06080db8 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
@@ -2048,6 +2048,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
index 2229a1dcc0..608ad49593 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
@@ -2247,3 +2247,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist b/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
index 31010e6cf7..c7657ce7f6 100644
--- a/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist
@@ -2107,3 +2107,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h b/sysdeps/unix/sysv/linux/rseq-internal.h
new file mode 100644
index 0000000000..5f7f02f1ec
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/rseq-internal.h
@@ -0,0 +1,73 @@
+/* Restartable Sequences internal API. Linux implementation.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
+#include <kernel-features.h>
+#include <sys/rseq.h>
+
+#ifdef RSEQ_SIG
+
+static inline int
+rseq_register_current_thread (void)
+{
+  int rc, ret = 0;
+
+  if (__rseq_abi.cpu_id == RSEQ_CPU_ID_REGISTRATION_FAILED)
+    return -1;
+  rc = INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
+                              0, RSEQ_SIG);
+  if (!rc)
+    goto end;
+  if (INTERNAL_SYSCALL_ERRNO (rc) != EBUSY)
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
+
+  rc = INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
+                              RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
+  if (!rc)
+    goto end;
+  ret = -1;
+end:
+  return ret;
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
+#endif
+
+#endif /* rseq-internal.h */
diff --git a/sysdeps/unix/sysv/linux/rseq-sym.c b/sysdeps/unix/sysv/linux/rseq-sym.c
new file mode 100644
index 0000000000..0e33fab278
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/rseq-sym.c
@@ -0,0 +1,25 @@
+/* Restartable Sequences exported symbols. Linux Implementation.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
+#include <kernel-features.h>
+#include <sys/rseq.h>
+
+__thread struct rseq __rseq_abi = {
+  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+};
diff --git a/sysdeps/unix/sysv/linux/s390/bits/rseq.h b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
new file mode 100644
index 0000000000..c25ee67ee7
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
@@ -0,0 +1,37 @@
+/* Restartable Sequences Linux s390 architecture header.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
+   RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
+   access-register mode nor the linkage stack this instruction will always
+   cause a special-operation exception (the trap-enabled bit in the DUCT
+   is and will stay 0). The instruction pattern is
+       b2 ff 0f ff        trap4   4095(%r0)  */
+
+#define RSEQ_SIG	0xB2FF0FFF
diff --git a/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist b/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
index 4feca641b0..9c29ec0d2d 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
@@ -2183,6 +2183,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist b/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
index efe588a072..99424ceac9 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
@@ -2084,6 +2084,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/sh/be/libc.abilist b/sysdeps/unix/sysv/linux/sh/be/libc.abilist
index 6bfc2b7439..80198de5d6 100644
--- a/sysdeps/unix/sysv/linux/sh/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sh/be/libc.abilist
@@ -2053,6 +2053,7 @@ GLIBC_2.30 twalk_r F
 GLIBC_2.31 msgctl F
 GLIBC_2.31 semctl F
 GLIBC_2.31 shmctl F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/sh/le/libc.abilist b/sysdeps/unix/sysv/linux/sh/le/libc.abilist
index 4b057bf4a2..916aa0b7f0 100644
--- a/sysdeps/unix/sysv/linux/sh/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sh/le/libc.abilist
@@ -2050,6 +2050,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist b/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
index 49cd597fd6..9a27df8e43 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
@@ -2174,6 +2174,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist b/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
index 95e68e0ba1..32908666c4 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
@@ -2101,6 +2101,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h b/sysdeps/unix/sysv/linux/sys/rseq.h
new file mode 100644
index 0000000000..503dce4cac
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/sys/rseq.h
@@ -0,0 +1,186 @@
+/* Restartable Sequences exported symbols. Linux header.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
+/* Architecture-specific rseq signature.  */
+#include <bits/rseq.h>
+#include <stdint.h>
+#include <sys/cdefs.h>
+
+#ifdef __has_include
+# if __has_include ("linux/rseq.h")
+#   define __GLIBC_HAVE_KERNEL_RSEQ
+# endif
+#else
+# include <linux/version.h>
+# if LINUX_VERSION_CODE >= KERNEL_VERSION (4, 18, 0)
+#   define __GLIBC_HAVE_KERNEL_RSEQ
+# endif
+#endif
+
+#ifdef __GLIBC_HAVE_KERNEL_RSEQ
+/* We use the structures declarations from the kernel headers.  */
+# include <linux/rseq.h>
+#else
+/* We use a copy of the include/uapi/linux/rseq.h kernel header.  */
+
+#include <asm/byteorder.h>
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
+/* struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
+   contained within a single cache-line. It is usually declared as
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
+} __attribute__((aligned(4 * sizeof(uint64_t))));
+
+/* struct rseq is aligned on 4 * 8 bytes to ensure it is always
+   contained within a single cache-line.
+
+   A single struct rseq per thread is allowed.  */
+struct rseq
+  {
+    /* Restartable sequences cpu_id_start field. Updated by the
+       kernel. Read by user-space with single-copy atomicity
+       semantics. This field should only be read by the thread which
+       registered this data structure. Aligned on 32-bit. Always
+       contains a value in the range of possible CPUs, although the
+       value may not be the actual current CPU (e.g. if rseq is not
+       initialized). This CPU number value should always be compared
+       against the value of the cpu_id field before performing a rseq
+       commit or returning a value read from a data structure indexed
+       using the cpu_id_start value.  */
+    uint32_t cpu_id_start;
+    /* Restartable sequences cpu_id field. Updated by the kernel.
+       Read by user-space with single-copy atomicity semantics. This
+       field should only be read by the thread which registered this
+       data structure. Aligned on 32-bit. Values
+       RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+       have a special semantic: the former means "rseq uninitialized",
+       and latter means "rseq initialization failed". This value is
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
+       targeted by the rseq_cs. Also needs to be set to NULL by user-space
+       before reclaiming memory that contains the targeted struct rseq_cs.
+
+       Read and set by the kernel. Set by user-space with single-copy
+       atomicity semantics. This field should only be updated by the
+       thread which registered this data structure. Aligned on 64-bit.  */
+    union {
+      uint64_t ptr64;
+#ifdef __LP64__
+      uint64_t ptr;
+#else
+      struct {
+#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined(__BIG_ENDIAN)
+        uint32_t padding; /* Initialized to zero.  */
+        uint32_t ptr32;
+#else /* LITTLE */
+        uint32_t ptr32;
+        uint32_t padding; /* Initialized to zero.  */
+#endif /* ENDIAN */
+      } ptr;
+#endif
+    } rseq_cs;
+
+    /* Restartable sequences flags field.
+
+       This field should only be updated by the thread which
+       registered this data structure. Read by the kernel.
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
+  } __attribute__((aligned(4 * sizeof(uint64_t))));
+
+#endif
+
+/* Ensure the compiler supports __attribute__ ((aligned)).  */
+_Static_assert (__alignof__ (struct rseq_cs) >= 4 * sizeof(uint64_t),
+                "alignment");
+_Static_assert (__alignof__ (struct rseq) >= 4 * sizeof(uint64_t),
+                "alignment");
+
+/* Allocations of struct rseq and struct rseq_cs on the heap need to
+   be aligned on 32 bytes. Therefore, use of malloc is discouraged
+   because it does not guarantee alignment. posix_memalign should be
+   used instead.  */
+
+extern __thread struct rseq __rseq_abi
+__attribute__ ((tls_model ("initial-exec")));
+
+#endif /* sys/rseq.h */
diff --git a/sysdeps/unix/sysv/linux/x86/bits/rseq.h b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
new file mode 100644
index 0000000000..75f52d9788
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
@@ -0,0 +1,30 @@
+/* Restartable Sequences Linux x86 architecture header.
+   Copyright (C) 2019-2020 Free Software Foundation, Inc.
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
index 1f2dbd1451..7366565608 100644
--- a/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
@@ -2059,6 +2059,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist b/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
index 59da85a5d8..c1aa86f06e 100644
--- a/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
@@ -2158,3 +2158,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
-- 
2.17.1

