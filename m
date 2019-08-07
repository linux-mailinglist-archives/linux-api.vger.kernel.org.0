Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1884EB2
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2019 16:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbfHGO1r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 10:27:47 -0400
Received: from mail.efficios.com ([167.114.142.138]:52148 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbfHGO1q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 10:27:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C344C2B7469;
        Wed,  7 Aug 2019 10:27:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CaFHd4OeA8GA; Wed,  7 Aug 2019 10:27:38 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 855962B742D;
        Wed,  7 Aug 2019 10:27:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 855962B742D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1565188058;
        bh=NUI/RyDshs/p88GFG96QoHNbMp94nvQChO3z3jLsWJk=;
        h=From:To:Date:Message-Id;
        b=nbggPplEK4Qnnzo9g3piA39kWDOHtaQQYBp/rQSUR0YQWHKrowGGbq/EBzu2qCWGb
         B/dKo3og0uOPin5d0C7bG2ZLnqdJzRChfAQ43cfYeGSTX3mBzmeMh0+tCTJ3/2nLqL
         sf7kPiON7veEg9M7jyY5s0PeQtSkZBIECG/7Wt48ZI8OxtUImvkAH8bWJhVm7Yc9Nb
         3Mkj4Gd87pySKuZxfXbwOIrFZwJ8N9wXGtCha5qBvmoGdNTdnxegh2mWy0eXQxW6AY
         YcDTbLJxRohMiCsYWfV5AZFHwi4F2O9gJyXTDFz3lBsEYiNTvpA6c6Iu+QKO8/7Dfq
         dUm+ZW9/zQTfQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 1KKe7r0VxAab; Wed,  7 Aug 2019 10:27:38 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 141662B7416;
        Wed,  7 Aug 2019 10:27:38 -0400 (EDT)
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
Subject: [PATCH glibc 2.31 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v12)
Date:   Wed,  7 Aug 2019 10:27:22 -0400
Message-Id: <20190807142726.2579-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807142726.2579-1-mathieu.desnoyers@efficios.com>
References: <20190807142726.2579-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Register rseq(2) TLS for each thread (including main), and unregister
for each thread (excluding main). "rseq" stands for Restartable
Sequences.

See the rseq(2) man page proposed here:
  https://lkml.org/lkml/2018/9/19/647

This patch is based on glibc-2.30. The rseq(2) system call was merged
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
 ChangeLog                                     | 78 ++++++++++++++++
 NEWS                                          | 15 ++++
 csu/libc-start.c                              | 14 ++-
 elf/dl-support.c                              | 22 +++++
 elf/rtld.c                                    | 26 ++++++
 misc/rseq-internal.h                          | 38 ++++++++
 nptl/pthread_create.c                         |  9 ++
 sysdeps/unix/sysv/linux/Makefile              |  4 +-
 sysdeps/unix/sysv/linux/Versions              | 10 +++
 sysdeps/unix/sysv/linux/aarch64/bits/rseq.h   | 43 +++++++++
 sysdeps/unix/sysv/linux/aarch64/ld.abilist    |  1 +
 sysdeps/unix/sysv/linux/aarch64/libc.abilist  |  1 +
 sysdeps/unix/sysv/linux/alpha/ld.abilist      |  1 +
 sysdeps/unix/sysv/linux/alpha/libc.abilist    |  1 +
 sysdeps/unix/sysv/linux/arm/bits/rseq.h       | 83 +++++++++++++++++
 sysdeps/unix/sysv/linux/arm/ld.abilist        |  1 +
 sysdeps/unix/sysv/linux/arm/libc.abilist      |  1 +
 sysdeps/unix/sysv/linux/bits/rseq.h           | 29 ++++++
 sysdeps/unix/sysv/linux/csky/ld.abilist       |  1 +
 sysdeps/unix/sysv/linux/csky/libc.abilist     |  1 +
 sysdeps/unix/sysv/linux/hppa/ld.abilist       |  1 +
 sysdeps/unix/sysv/linux/hppa/libc.abilist     |  1 +
 sysdeps/unix/sysv/linux/i386/ld.abilist       |  1 +
 sysdeps/unix/sysv/linux/i386/libc.abilist     |  1 +
 sysdeps/unix/sysv/linux/ia64/ld.abilist       |  1 +
 sysdeps/unix/sysv/linux/ia64/libc.abilist     |  1 +
 .../unix/sysv/linux/m68k/coldfire/ld.abilist  |  1 +
 .../sysv/linux/m68k/coldfire/libc.abilist     |  1 +
 .../unix/sysv/linux/m68k/m680x0/ld.abilist    |  1 +
 .../unix/sysv/linux/m68k/m680x0/libc.abilist  |  1 +
 sysdeps/unix/sysv/linux/microblaze/ld.abilist |  1 +
 .../unix/sysv/linux/microblaze/libc.abilist   |  1 +
 sysdeps/unix/sysv/linux/mips/bits/rseq.h      | 62 +++++++++++++
 .../sysv/linux/mips/mips32/fpu/libc.abilist   |  1 +
 .../unix/sysv/linux/mips/mips32/ld.abilist    |  1 +
 .../sysv/linux/mips/mips32/nofpu/libc.abilist |  1 +
 .../sysv/linux/mips/mips64/n32/ld.abilist     |  1 +
 .../sysv/linux/mips/mips64/n32/libc.abilist   |  1 +
 .../sysv/linux/mips/mips64/n64/ld.abilist     |  1 +
 .../sysv/linux/mips/mips64/n64/libc.abilist   |  1 +
 sysdeps/unix/sysv/linux/nios2/ld.abilist      |  1 +
 sysdeps/unix/sysv/linux/nios2/libc.abilist    |  1 +
 sysdeps/unix/sysv/linux/powerpc/bits/rseq.h   | 37 ++++++++
 .../linux/powerpc/powerpc32/fpu/libc.abilist  |  1 +
 .../sysv/linux/powerpc/powerpc32/ld.abilist   |  1 +
 .../powerpc/powerpc32/nofpu/libc.abilist      |  1 +
 .../linux/powerpc/powerpc64/be/ld.abilist     |  1 +
 .../linux/powerpc/powerpc64/be/libc.abilist   |  1 +
 .../linux/powerpc/powerpc64/le/ld.abilist     |  1 +
 .../linux/powerpc/powerpc64/le/libc.abilist   |  1 +
 sysdeps/unix/sysv/linux/riscv/rv64/ld.abilist |  1 +
 .../unix/sysv/linux/riscv/rv64/libc.abilist   |  1 +
 sysdeps/unix/sysv/linux/rseq-internal.h       | 88 +++++++++++++++++++
 sysdeps/unix/sysv/linux/rseq-sym.c            | 43 +++++++++
 sysdeps/unix/sysv/linux/s390/bits/rseq.h      | 37 ++++++++
 .../unix/sysv/linux/s390/s390-32/ld.abilist   |  1 +
 .../unix/sysv/linux/s390/s390-32/libc.abilist |  1 +
 .../unix/sysv/linux/s390/s390-64/ld.abilist   |  1 +
 .../unix/sysv/linux/s390/s390-64/libc.abilist |  1 +
 sysdeps/unix/sysv/linux/sh/ld.abilist         |  1 +
 sysdeps/unix/sysv/linux/sh/libc.abilist       |  1 +
 .../unix/sysv/linux/sparc/sparc32/ld.abilist  |  1 +
 .../sysv/linux/sparc/sparc32/libc.abilist     |  1 +
 .../unix/sysv/linux/sparc/sparc64/ld.abilist  |  1 +
 .../sysv/linux/sparc/sparc64/libc.abilist     |  1 +
 sysdeps/unix/sysv/linux/sys/rseq.h            | 52 +++++++++++
 sysdeps/unix/sysv/linux/x86/bits/rseq.h       | 30 +++++++
 sysdeps/unix/sysv/linux/x86_64/64/ld.abilist  |  1 +
 .../unix/sysv/linux/x86_64/64/libc.abilist    |  1 +
 sysdeps/unix/sysv/linux/x86_64/x32/ld.abilist |  1 +
 .../unix/sysv/linux/x86_64/x32/libc.abilist   |  1 +
 71 files changed, 768 insertions(+), 4 deletions(-)
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

diff --git a/ChangeLog b/ChangeLog
index cdb9e14881..9a1930248f 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,81 @@
+2019-08-06  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+
+	* NEWS: Add Restartable Sequences feature description.
+	* csu/libc-start.c: Perform rseq(2) registration at C startup.
+	* elf/rtld.c: Initialize __rseq_handled at dynamic linker
+	startup for shared libc.
+	* elf/dl-support.c: Initialize __rseq_handled at dynamic linker
+	startup for static libc.
+	* nptl/pthread_create.c: Perform rseq(2) registration at thread
+	creation, unregistration at thread exit.
+	* sysdeps/unix/sysv/linux/Makefile: Add rseq-sym, sys/rseq.h,
+	bits/rseq.h.
+	* sysdeps/unix/sysv/linux/Versions: Export __rseq_abi from libc
+	and __rseq_handled from ld.
+	* sysdeps/unix/sysv/linux/aarch64/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/aarch64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/alpha/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/alpha/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/arm/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/arm/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/csky/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/csky/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/hppa/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/hppa/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/i386/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/i386/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/ia64/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/ia64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/m68k/coldfire/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/m68k/m680x0/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/microblaze/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/microblaze/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips32/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips64/n32/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips64/n64/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/nios2/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/nios2/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc32/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc64/be/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc64/le/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/riscv/rv64/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/riscv/rv64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/s390/s390-32/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/s390/s390-64/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sh/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sh/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sparc/sparc32/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sparc/sparc64/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/x86_64/64/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/x86_64/64/libc.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/x86_64/x32/ld.abilist: Likewise.
+	* sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist: Likewise.
+	* misc/rseq-internal.h: New file.
+	* sysdeps/unix/sysv/linux/rseq-internal.h: Likewise.
+	* sysdeps/unix/sysv/linux/rseq-sym.c: Likewise.
+	* sysdeps/unix/sysv/linux/sys/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/aarch64/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/arm/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/mips/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/powerpc/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/s390/bits/rseq.h: Likewise.
+	* sysdeps/unix/sysv/linux/x86/bits/rseq.h: Likewise.
+
 2019-08-01  Carlos O'Donell <carlos@redhat.com>
 
 	* version.h (RELEASE): Set to "stable".
diff --git a/NEWS b/NEWS
index ee9ed4de5a..5b2ee85da2 100644
--- a/NEWS
+++ b/NEWS
@@ -5,6 +5,21 @@ See the end for copying conditions.
 Please send GNU C library bug reports via <https://sourceware.org/bugzilla/>
 using `glibc' in the "product" field.
 
+Version 2.31
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
 Version 2.30
 
 Major new features:
diff --git a/csu/libc-start.c b/csu/libc-start.c
index 5d9c3675fa..136d30ace9 100644
--- a/csu/libc-start.c
+++ b/csu/libc-start.c
@@ -22,6 +22,8 @@
 #include <ldsodefs.h>
 #include <exit-thread.h>
 #include <libc-internal.h>
+#include <rseq-internal.h>
+#include <ldsodefs.h>
 
 #include <elf/dl-tunables.h>
 
@@ -140,7 +142,13 @@ LIBC_START_MAIN (int (*main) (int, char **, char ** MAIN_AUXVEC_DECL),
 
   __libc_multiple_libcs = &_dl_starting_up && !_dl_starting_up;
 
-#ifndef SHARED
+#ifdef SHARED
+  if (rtld_active ())
+    {
+      /* Register rseq ABI to the kernel.   */
+      (void) rseq_register_current_thread ();
+    }
+#else
   _dl_relocate_static_pie ();
 
   char **ev = &argv[argc + 1];
@@ -231,7 +239,9 @@ LIBC_START_MAIN (int (*main) (int, char **, char ** MAIN_AUXVEC_DECL),
   __pointer_chk_guard_local = pointer_chk_guard;
 # endif
 
-#endif /* !SHARED  */
+    /* Register rseq ABI to the kernel.   */
+    (void) rseq_register_current_thread ();
+#endif
 
   /* Register the destructor of the dynamic linker if there is any.  */
   if (__glibc_likely (rtld_fini != NULL))
diff --git a/elf/dl-support.c b/elf/dl-support.c
index 0a8b636d02..f717afed75 100644
--- a/elf/dl-support.c
+++ b/elf/dl-support.c
@@ -34,6 +34,7 @@
 #include <unsecvars.h>
 #include <hp-timing.h>
 #include <stackinfo.h>
+#include <rseq-internal.h>
 
 extern char *__progname;
 char **_dl_argv = &__progname;	/* This is checked for some error messages.  */
@@ -215,6 +216,24 @@ __rtld_lock_define_initialized_recursive (, _dl_load_lock)
    that list.  */
 __rtld_lock_define_initialized_recursive (, _dl_load_write_lock)
 
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
 
 #ifdef HAVE_AUX_VECTOR
 int _dl_clktck;
@@ -375,6 +394,9 @@ _dl_non_dynamic_init (void)
 	  _dl_stack_flags = _dl_phdr[i].p_flags;
 	  break;
 	}
+
+  /* Publicize rseq registration ownership.  */
+  rseq_init ();
 }
 
 #ifdef DL_SYSINFO_IMPLEMENTATION
diff --git a/elf/rtld.c b/elf/rtld.c
index c9490ff694..ef24c2faff 100644
--- a/elf/rtld.c
+++ b/elf/rtld.c
@@ -43,6 +43,7 @@
 #include <stap-probe.h>
 #include <stackinfo.h>
 #include <not-cancel.h>
+#include <rseq-internal.h>
 
 #include <assert.h>
 
@@ -157,6 +158,25 @@ strong_alias (__pointer_chk_guard_local, __pointer_chk_guard)
 # define SECURE_PATH_LIMIT 1024
 #endif
 
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
+
 /* Check that AT_SECURE=0, or that the passed name does not contain
    directories and is not overly long.  Reject empty names
    unconditionally.  */
@@ -2314,6 +2334,12 @@ ERROR: '%s': cannot process note segment.\n", _dl_argv[0]);
       rtld_timer_accum (&relocate_time, start);
     }
 
+  /* Publicize rseq registration ownership.  This must be performed
+     after rtld re-relocation, before invoking constructors of
+     preloaded libraries.  IFUNC resolvers are called before this
+     initialization, so they may not observe the initialized state.  */
+  rseq_init ();
+
   /* Do any necessary cleanups for the startup OS interface code.
      We do these now so that no calls are made after rtld re-relocation
      which might be resolved to different functions than we expect.
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
index 18b7bbe765..f15dc8694f 100644
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
 
   /* Initialize resolver state pointer.  */
   __resp = &pd->res;
@@ -389,6 +391,9 @@ START_THREAD_DEFN
   if (__glibc_unlikely (atomic_exchange_acq (&pd->setxid_futex, 0) == -2))
     futex_wake (&pd->setxid_futex, 1, FUTEX_PRIVATE);
 
+  /* Register rseq TLS to the kernel. */
+  has_rseq = !rseq_register_current_thread ();
+
 #ifdef __NR_set_robust_list
 # ifndef __ASSUME_SET_ROBUST_LIST
   if (__set_robust_list_avail >= 0)
@@ -566,6 +571,10 @@ START_THREAD_DEFN
     }
 #endif
 
+  /* Unregister rseq TLS from kernel. */
+  if (has_rseq && rseq_unregister_current_thread ())
+    abort();
+
   advise_stack_range (pd->stackblock, pd->stackblock_size, (uintptr_t) pd,
 		      pd->guardsize);
 
diff --git a/sysdeps/unix/sysv/linux/Makefile b/sysdeps/unix/sysv/linux/Makefile
index 1ab6bcbfc8..f2bbe25c02 100644
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
index 1ca102a9e2..01639a81e8 100644
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
@@ -188,3 +191,10 @@ libc {
     __netlink_assert_response;
   }
 }
+
+ld {
+  # Symbols required by dynamic linker
+  GLIBC_2.31 {
+    __rseq_handled;
+  }
+}
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
diff --git a/sysdeps/unix/sysv/linux/aarch64/ld.abilist b/sysdeps/unix/sysv/linux/aarch64/ld.abilist
index 4ffe688649..89a7312e8c 100644
--- a/sysdeps/unix/sysv/linux/aarch64/ld.abilist
+++ b/sysdeps/unix/sysv/linux/aarch64/ld.abilist
@@ -7,3 +7,4 @@ GLIBC_2.17 calloc F
 GLIBC_2.17 free F
 GLIBC_2.17 malloc F
 GLIBC_2.17 realloc F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/aarch64/libc.abilist b/sysdeps/unix/sysv/linux/aarch64/libc.abilist
index a4c31932cb..6784f13c09 100644
--- a/sysdeps/unix/sysv/linux/aarch64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/aarch64/libc.abilist
@@ -2145,3 +2145,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/alpha/ld.abilist b/sysdeps/unix/sysv/linux/alpha/ld.abilist
index 98b66edabf..029176ab4c 100644
--- a/sysdeps/unix/sysv/linux/alpha/ld.abilist
+++ b/sysdeps/unix/sysv/linux/alpha/ld.abilist
@@ -6,4 +6,5 @@ GLIBC_2.0 realloc F
 GLIBC_2.1 __libc_stack_end D 0x8
 GLIBC_2.1 _dl_mcount F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x8
diff --git a/sysdeps/unix/sysv/linux/alpha/libc.abilist b/sysdeps/unix/sysv/linux/alpha/libc.abilist
index fe85a35620..8a1be3a6a2 100644
--- a/sysdeps/unix/sysv/linux/alpha/libc.abilist
+++ b/sysdeps/unix/sysv/linux/alpha/libc.abilist
@@ -2220,6 +2220,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/arm/bits/rseq.h b/sysdeps/unix/sysv/linux/arm/bits/rseq.h
new file mode 100644
index 0000000000..cd00513bfb
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/arm/bits/rseq.h
@@ -0,0 +1,83 @@
+/* Restartable Sequences Linux arm architecture header.
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
diff --git a/sysdeps/unix/sysv/linux/arm/ld.abilist b/sysdeps/unix/sysv/linux/arm/ld.abilist
index a301c6ebc4..c65e9a7aa4 100644
--- a/sysdeps/unix/sysv/linux/arm/ld.abilist
+++ b/sysdeps/unix/sysv/linux/arm/ld.abilist
@@ -1,3 +1,4 @@
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __libc_stack_end D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x4
 GLIBC_2.4 __tls_get_addr F
diff --git a/sysdeps/unix/sysv/linux/arm/libc.abilist b/sysdeps/unix/sysv/linux/arm/libc.abilist
index bc3df8dcea..10137cfcee 100644
--- a/sysdeps/unix/sysv/linux/arm/libc.abilist
+++ b/sysdeps/unix/sysv/linux/arm/libc.abilist
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
diff --git a/sysdeps/unix/sysv/linux/csky/ld.abilist b/sysdeps/unix/sysv/linux/csky/ld.abilist
index 71576160ed..e801578569 100644
--- a/sysdeps/unix/sysv/linux/csky/ld.abilist
+++ b/sysdeps/unix/sysv/linux/csky/ld.abilist
@@ -7,3 +7,4 @@ GLIBC_2.29 calloc F
 GLIBC_2.29 free F
 GLIBC_2.29 malloc F
 GLIBC_2.29 realloc F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/csky/libc.abilist b/sysdeps/unix/sysv/linux/csky/libc.abilist
index 9b3cee65bb..b7ed346b1c 100644
--- a/sysdeps/unix/sysv/linux/csky/libc.abilist
+++ b/sysdeps/unix/sysv/linux/csky/libc.abilist
@@ -2089,3 +2089,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/hppa/ld.abilist b/sysdeps/unix/sysv/linux/hppa/ld.abilist
index 0387614d8f..88a5f35dc6 100644
--- a/sysdeps/unix/sysv/linux/hppa/ld.abilist
+++ b/sysdeps/unix/sysv/linux/hppa/ld.abilist
@@ -6,4 +6,5 @@ GLIBC_2.2 free F
 GLIBC_2.2 malloc F
 GLIBC_2.2 realloc F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x4
diff --git a/sysdeps/unix/sysv/linux/hppa/libc.abilist b/sysdeps/unix/sysv/linux/hppa/libc.abilist
index 75edece94a..37fd5f8525 100644
--- a/sysdeps/unix/sysv/linux/hppa/libc.abilist
+++ b/sysdeps/unix/sysv/linux/hppa/libc.abilist
@@ -2041,6 +2041,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/i386/ld.abilist b/sysdeps/unix/sysv/linux/i386/ld.abilist
index edb7307228..a371a40db3 100644
--- a/sysdeps/unix/sysv/linux/i386/ld.abilist
+++ b/sysdeps/unix/sysv/linux/i386/ld.abilist
@@ -7,3 +7,4 @@ GLIBC_2.1 __libc_stack_end D 0x4
 GLIBC_2.1 _dl_mcount F
 GLIBC_2.3 ___tls_get_addr F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/i386/libc.abilist b/sysdeps/unix/sysv/linux/i386/libc.abilist
index edeaf8e722..c7862ab47d 100644
--- a/sysdeps/unix/sysv/linux/i386/libc.abilist
+++ b/sysdeps/unix/sysv/linux/i386/libc.abilist
@@ -2207,6 +2207,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/ia64/ld.abilist b/sysdeps/unix/sysv/linux/ia64/ld.abilist
index 82042472c3..97d5962b13 100644
--- a/sysdeps/unix/sysv/linux/ia64/ld.abilist
+++ b/sysdeps/unix/sysv/linux/ia64/ld.abilist
@@ -6,3 +6,4 @@ GLIBC_2.2 free F
 GLIBC_2.2 malloc F
 GLIBC_2.2 realloc F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/ia64/libc.abilist b/sysdeps/unix/sysv/linux/ia64/libc.abilist
index b5d460eeb2..87b478c0fc 100644
--- a/sysdeps/unix/sysv/linux/ia64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/ia64/libc.abilist
@@ -2073,6 +2073,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/m68k/coldfire/ld.abilist b/sysdeps/unix/sysv/linux/m68k/coldfire/ld.abilist
index a301c6ebc4..c65e9a7aa4 100644
--- a/sysdeps/unix/sysv/linux/m68k/coldfire/ld.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/coldfire/ld.abilist
@@ -1,3 +1,4 @@
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __libc_stack_end D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x4
 GLIBC_2.4 __tls_get_addr F
diff --git a/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist b/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
index 05633b3cb8..444996f828 100644
--- a/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/coldfire/libc.abilist
@@ -131,6 +131,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _Exit F
 GLIBC_2.4 _IO_2_1_stderr_ D 0x98
 GLIBC_2.4 _IO_2_1_stdin_ D 0x98
diff --git a/sysdeps/unix/sysv/linux/m68k/m680x0/ld.abilist b/sysdeps/unix/sysv/linux/m68k/m680x0/ld.abilist
index c9ec45cf1c..b314193557 100644
--- a/sysdeps/unix/sysv/linux/m68k/m680x0/ld.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/m680x0/ld.abilist
@@ -6,4 +6,5 @@ GLIBC_2.0 realloc F
 GLIBC_2.1 __libc_stack_end D 0x4
 GLIBC_2.1 _dl_mcount F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x4
diff --git a/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist b/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
index 47eb7b4608..0f7ca57a45 100644
--- a/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
+++ b/sysdeps/unix/sysv/linux/m68k/m680x0/libc.abilist
@@ -2150,6 +2150,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/microblaze/ld.abilist b/sysdeps/unix/sysv/linux/microblaze/ld.abilist
index aa0d71150a..8113f09614 100644
--- a/sysdeps/unix/sysv/linux/microblaze/ld.abilist
+++ b/sysdeps/unix/sysv/linux/microblaze/ld.abilist
@@ -7,3 +7,4 @@ GLIBC_2.18 calloc F
 GLIBC_2.18 free F
 GLIBC_2.18 malloc F
 GLIBC_2.18 realloc F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/microblaze/libc.abilist b/sysdeps/unix/sysv/linux/microblaze/libc.abilist
index f7ced487f7..a2ce147dde 100644
--- a/sysdeps/unix/sysv/linux/microblaze/libc.abilist
+++ b/sysdeps/unix/sysv/linux/microblaze/libc.abilist
@@ -2137,3 +2137,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/mips/bits/rseq.h b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
new file mode 100644
index 0000000000..8c75f107e7
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
@@ -0,0 +1,62 @@
+/* Restartable Sequences Linux mips architecture header.
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
index e49dc4272e..c4e49c839a 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/fpu/libc.abilist
@@ -2124,6 +2124,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips32/ld.abilist b/sysdeps/unix/sysv/linux/mips/mips32/ld.abilist
index 55d48868e8..a28e9bf372 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/ld.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/ld.abilist
@@ -6,4 +6,5 @@ GLIBC_2.0 realloc F
 GLIBC_2.2 __libc_stack_end D 0x4
 GLIBC_2.2 _dl_mcount F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x4
diff --git a/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
index daa3b60c5b..b8b61569bc 100644
--- a/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips32/nofpu/libc.abilist
@@ -2122,6 +2122,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n32/ld.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n32/ld.abilist
index 55d48868e8..a28e9bf372 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n32/ld.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n32/ld.abilist
@@ -6,4 +6,5 @@ GLIBC_2.0 realloc F
 GLIBC_2.2 __libc_stack_end D 0x4
 GLIBC_2.2 _dl_mcount F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x4
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
index 457ce0b6f2..9d6c5cb025 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n32/libc.abilist
@@ -2130,6 +2130,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n64/ld.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n64/ld.abilist
index 44b345b7cf..6251bc8901 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n64/ld.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n64/ld.abilist
@@ -6,4 +6,5 @@ GLIBC_2.0 realloc F
 GLIBC_2.2 __libc_stack_end D 0x8
 GLIBC_2.2 _dl_mcount F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x8
diff --git a/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist b/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
index 63d5c03bfb..444c2f112a 100644
--- a/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/mips/mips64/n64/libc.abilist
@@ -2124,6 +2124,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/nios2/ld.abilist b/sysdeps/unix/sysv/linux/nios2/ld.abilist
index 110f1039fa..64d8acc083 100644
--- a/sysdeps/unix/sysv/linux/nios2/ld.abilist
+++ b/sysdeps/unix/sysv/linux/nios2/ld.abilist
@@ -7,3 +7,4 @@ GLIBC_2.21 calloc F
 GLIBC_2.21 free F
 GLIBC_2.21 malloc F
 GLIBC_2.21 realloc F
+GLIBC_2.31 __rseq_handled D 0x4
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
index 0000000000..bae8f4aaa1
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/powerpc/bits/rseq.h
@@ -0,0 +1,37 @@
+/* Restartable Sequences Linux powerpc architecture header.
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
+   RSEQ_SIG uses the following trap instruction:
+
+   powerpc-be:    0f e5 00 0b           twui   r5,11
+   powerpc64-le:  0b 00 e5 0f           twui   r5,11
+   powerpc64-be:  0f e5 00 0b           twui   r5,11  */
+
+#define RSEQ_SIG	0x0fe5000b
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
index 9200a54309..76b2595f64 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/fpu/libc.abilist
@@ -2180,6 +2180,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/ld.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/ld.abilist
index e8b0ea3a9b..b7589928de 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/ld.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/ld.abilist
@@ -8,3 +8,4 @@ GLIBC_2.1 _dl_mcount F
 GLIBC_2.22 __tls_get_addr_opt F
 GLIBC_2.23 __parse_hwcap_and_convert_at_platform F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
index ef7779905f..1ce88283bc 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc32/nofpu/libc.abilist
@@ -2213,6 +2213,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/ld.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/ld.abilist
index edfc9ca56f..81f41a27ea 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/ld.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/ld.abilist
@@ -8,3 +8,4 @@ GLIBC_2.3 calloc F
 GLIBC_2.3 free F
 GLIBC_2.3 malloc F
 GLIBC_2.3 realloc F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
index 2860df8ebc..a123a607f0 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/be/libc.abilist
@@ -2043,6 +2043,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/ld.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/ld.abilist
index 37c8f6684b..d1f99b8d39 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/ld.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/ld.abilist
@@ -8,3 +8,4 @@ GLIBC_2.17 malloc F
 GLIBC_2.17 realloc F
 GLIBC_2.22 __tls_get_addr_opt F
 GLIBC_2.23 __parse_hwcap_and_convert_at_platform F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
index 2229a1dcc0..608ad49593 100644
--- a/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
+++ b/sysdeps/unix/sysv/linux/powerpc/powerpc64/le/libc.abilist
@@ -2247,3 +2247,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
diff --git a/sysdeps/unix/sysv/linux/riscv/rv64/ld.abilist b/sysdeps/unix/sysv/linux/riscv/rv64/ld.abilist
index b411871d06..a1536257dd 100644
--- a/sysdeps/unix/sysv/linux/riscv/rv64/ld.abilist
+++ b/sysdeps/unix/sysv/linux/riscv/rv64/ld.abilist
@@ -7,3 +7,4 @@ GLIBC_2.27 calloc F
 GLIBC_2.27 free F
 GLIBC_2.27 malloc F
 GLIBC_2.27 realloc F
+GLIBC_2.31 __rseq_handled D 0x4
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
index 0000000000..f86869a380
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/rseq-sym.c
@@ -0,0 +1,43 @@
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
+__thread struct rseq __rseq_abi = {
+  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+};
diff --git a/sysdeps/unix/sysv/linux/s390/bits/rseq.h b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
new file mode 100644
index 0000000000..453250d761
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/s390/bits/rseq.h
@@ -0,0 +1,37 @@
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
diff --git a/sysdeps/unix/sysv/linux/s390/s390-32/ld.abilist b/sysdeps/unix/sysv/linux/s390/s390-32/ld.abilist
index 0576c9575e..bea49478af 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-32/ld.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-32/ld.abilist
@@ -6,3 +6,4 @@ GLIBC_2.0 realloc F
 GLIBC_2.1 __libc_stack_end D 0x4
 GLIBC_2.1 _dl_mcount F
 GLIBC_2.3 __tls_get_offset F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist b/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
index 576295deff..4ca893d263 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-32/libc.abilist
@@ -2175,6 +2175,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/s390/s390-64/ld.abilist b/sysdeps/unix/sysv/linux/s390/s390-64/ld.abilist
index 1fbb890d1d..f11ac862b0 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-64/ld.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-64/ld.abilist
@@ -6,3 +6,4 @@ GLIBC_2.2 free F
 GLIBC_2.2 malloc F
 GLIBC_2.2 realloc F
 GLIBC_2.3 __tls_get_offset F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist b/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
index abf0473683..2af0d8b13c 100644
--- a/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/s390/s390-64/libc.abilist
@@ -2079,6 +2079,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/sh/ld.abilist b/sysdeps/unix/sysv/linux/sh/ld.abilist
index 0387614d8f..88a5f35dc6 100644
--- a/sysdeps/unix/sysv/linux/sh/ld.abilist
+++ b/sysdeps/unix/sysv/linux/sh/ld.abilist
@@ -6,4 +6,5 @@ GLIBC_2.2 free F
 GLIBC_2.2 malloc F
 GLIBC_2.2 realloc F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
 GLIBC_2.4 __stack_chk_guard D 0x4
diff --git a/sysdeps/unix/sysv/linux/sh/libc.abilist b/sysdeps/unix/sysv/linux/sh/libc.abilist
index 41977f6e9c..eec216c8d1 100644
--- a/sysdeps/unix/sysv/linux/sh/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sh/libc.abilist
@@ -2045,6 +2045,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc32/ld.abilist b/sysdeps/unix/sysv/linux/sparc/sparc32/ld.abilist
index fd0b33f86d..cac31f73af 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc32/ld.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc32/ld.abilist
@@ -6,3 +6,4 @@ GLIBC_2.0 realloc F
 GLIBC_2.1 __libc_stack_end D 0x4
 GLIBC_2.1 _dl_mcount F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist b/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
index 3d2f00ca52..bc59a9ee5c 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc32/libc.abilist
@@ -2169,6 +2169,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 _IO_fprintf F
 GLIBC_2.4 _IO_printf F
 GLIBC_2.4 _IO_sprintf F
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc64/ld.abilist b/sysdeps/unix/sysv/linux/sparc/sparc64/ld.abilist
index 82042472c3..97d5962b13 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc64/ld.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc64/ld.abilist
@@ -6,3 +6,4 @@ GLIBC_2.2 free F
 GLIBC_2.2 malloc F
 GLIBC_2.2 realloc F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist b/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
index 2f20643e8e..9489cf146e 100644
--- a/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/sparc/sparc64/libc.abilist
@@ -2096,6 +2096,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h b/sysdeps/unix/sysv/linux/sys/rseq.h
new file mode 100644
index 0000000000..56a2b1ebbe
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/sys/rseq.h
@@ -0,0 +1,52 @@
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
+extern __thread struct rseq __rseq_abi
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
+   destructors, or at program startup.
+
+   The fact that a library handles rseq registration is orthogonal to whether
+   the running kernel implements the rseq system call or not.  */
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
diff --git a/sysdeps/unix/sysv/linux/x86_64/64/ld.abilist b/sysdeps/unix/sysv/linux/x86_64/64/ld.abilist
index 0dc9430611..910127139e 100644
--- a/sysdeps/unix/sysv/linux/x86_64/64/ld.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/64/ld.abilist
@@ -6,3 +6,4 @@ GLIBC_2.2.5 free F
 GLIBC_2.2.5 malloc F
 GLIBC_2.2.5 realloc F
 GLIBC_2.3 __tls_get_addr F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist b/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
index 59f85d9373..da4e2a95d7 100644
--- a/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/64/libc.abilist
@@ -2054,6 +2054,7 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
 GLIBC_2.4 __confstr_chk F
 GLIBC_2.4 __fgets_chk F
 GLIBC_2.4 __fgets_unlocked_chk F
diff --git a/sysdeps/unix/sysv/linux/x86_64/x32/ld.abilist b/sysdeps/unix/sysv/linux/x86_64/x32/ld.abilist
index 80f3161586..e866e0a653 100644
--- a/sysdeps/unix/sysv/linux/x86_64/x32/ld.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/x32/ld.abilist
@@ -6,3 +6,4 @@ GLIBC_2.16 calloc F
 GLIBC_2.16 free F
 GLIBC_2.16 malloc F
 GLIBC_2.16 realloc F
+GLIBC_2.31 __rseq_handled D 0x4
diff --git a/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist b/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
index 67a4e238d6..d152b4d217 100644
--- a/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/x32/libc.abilist
@@ -2153,3 +2153,4 @@ GLIBC_2.30 getdents64 F
 GLIBC_2.30 gettid F
 GLIBC_2.30 tgkill F
 GLIBC_2.30 twalk_r F
+GLIBC_2.31 __rseq_abi T 0x20
-- 
2.17.1

