Return-Path: <linux-api+bounces-5939-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPI3FTcXtGlkgwAAu9opvQ
	(envelope-from <linux-api+bounces-5939-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 14:55:03 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D7D2844E7
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A29930D31A2
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4A39D6DE;
	Fri, 13 Mar 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="u+JIlGPC"
X-Original-To: linux-api@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5B30F7F2;
	Fri, 13 Mar 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409215; cv=none; b=k8LJb6OIEp13zn4tuKwXiO98HiwND/ctgZgr0/xRWxEFoPn5KkI3o/SIWg9hoZulM7k4fhg4CJVCVtziAUYAOvVVESx/k12Kl6/RFeh+ilc/zpfPVEsRGOYS9aG7U/UPfr7xiSyPBisp7BJci6y1SSfMS9V/ZZbcAgNaCqx2xMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409215; c=relaxed/simple;
	bh=R0NnwwUvyRTUdD1UPOtk/X+Xcwb1bwQ5B7e1XhRRVQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IF373IHZUAYkKcmEEzF6nFZYmpzvYADJUwNbEBEeU6vIAWa8habvMAfeYXyhPrpyh/4Xvs9yyPSVFHNxQMynvvSsaj/vmc8CQ2W47OFJ1u2ktGVuMzldfmxwuLnpBN91N7h88rRsiZ1LjAGqtI5Vn30ik9DjuvzMRWCxhc4JCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=u+JIlGPC; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1773409206;
	bh=cL/jr3CJVnX65vkN+iePs/6Wa4wXZX6WX+Xo85awnXs=;
	h=From:To:Cc:Subject:Date:From;
	b=u+JIlGPCGT+LEV+mtI3CjevNBAVXA0qAAszz8IrWbj6fFkHoA9wqq9J7hYeTBWlOR
	 /XYP/KhPBMk0TzbGaicIWzz8ceIW7PtPUX7hA2aBpjlD98NVso1ZYpd1apanjUmXNr
	 lq4O8KMBOw4KJrYp0vc1ux6Fz7B2HW4nRr45bm1QdmqPyVuGrWcU2gSWzshkmxai7B
	 o/29SnC9ac6BRsd8wrtF2xC2ujVknFbNGQCzfgYiHHdWYrSjWdPuDDq3CkJCq0xtI2
	 /Uka61gZ3xoBR8d1KEMOGSdMQWMhMSAdw9EroFCxpHtgYq/cxEW/64R01JHfQIKQDm
	 fcevNQnoRjyag==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4fXQbB2LW8zPpW;
	Fri, 13 Mar 2026 09:40:06 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Carlos O'Donell <carlos@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Rich Felker <dalias@aerifal.cx>,
	Torvald Riegel <triegel@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Arnd Bergmann <arnd@arndb.de>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	linux-api@vger.kernel.org
Subject: [RFC PATCH v4] futex: Introduce __vdso_robust_futex_unlock and __vdso_robust_pi_futex_try_unlock
Date: Fri, 13 Mar 2026 09:39:03 -0400
Message-Id: <20260313133903.2202079-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=smtpout1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5939-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[efficios.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0D7D2844E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a long standing data corruption race condition with robust futexes,
as pointed out here:

  "File corruption race condition in robust mutex unlocking"
  https://sourceware.org/bugzilla/show_bug.cgi?id=14485

The culprit of this issue is the fact that atomic instructions (at least
on x86) only take a single memory operand. The exchange and
compare-and-exchange populate the result (loaded value or success) into
registers or flags, which creates a window of instructions where the
kernel does not easily have access to that state. Therefore, handling of
process termination can incorrectly assume that the futex value state
still needs to be cleared, which can lead to corruption.

The approach taken to fix this is to introduce two vDSO and extend the
x86 vDSO exception table to track the relevant ip ranges: one for non-PI
robust futexes, and one for PI robust futexes.

The __vdso_robust_futex_unlock vDSO unlocks the robust futex by
exchanging the content of uaddr with 0 with a store-release
semantic. If the futex has waiters, it sets bit 1 of
*robust_list_head->list_op_pending, else it clears
*robust_list_head->list_op_pending. Those operations are within a code
region known by the kernel, making them safe with respect to
asynchronous program termination either from thread context or from a
nested signal handler.

Expected use of this vDSO:

if ((__vdso_robust_futex_unlock((u32 *) &mutex->__data.__lock, robust_list_head)
    & FUTEX_WAITERS) != 0)
        futex_wake((u32 *) &mutex->__data.__lock, 1, private);
WRITE_ONCE(robust_list_head->list_op_pending, 0);

Also introduce __vdso_robust_pi_futex_try_unlock to fix a similar
unlock race with robust PI futexes.

The __vdso_robust_pi_futex_try_unlock vDSO try to perform a
compare-and-exchange with release semantic to set the expected
*uaddr content to 0. If the futex has waiters, it fails, and
userspace needs to call futex_unlock_pi(). Before exiting the
critical section, if the cmpxchg fails, it sets bit 1 of
*robust_list_head->list_op_pending. If the cmpxchg succeeds, it
clears *@robust_list_head->list_op_pending. Those operations are
within a code region known by the kernel, making them safe with
respect to asynchronous program termination either from thread
context or from a nested signal handler.

Expected use of this vDSO:

int l = atomic_load_relaxed(&mutex->__data.__lock);
do {
        if (((l & FUTEX_WAITERS) != 0) || (l != READ_ONCE(pd->tid))) {
                futex_unlock_pi((unsigned int *) &mutex->__data.__lock, private);
                break;
        }
} while (!__vdso_robust_pi_futex_try_unlock(&mutex->__data.__lock,
                                            &l, robust_list_head));
WRITE_ONCE(robust_list_head->list_op_pending, 0);

The four kernel execution paths impacted by this change are:

  1) exit_robust_list/compat_exit_robust_list (process exit)
  2) setup_rt_frame (signal delivery)
  3) futex_wake
  4) futex_unlock_pi

Bit 1 of the robust_list_head->list_op_pending pointer is used to flag
whether there is either a pending wakeup or futex_unlock_pi action
(FUTEX_UADDR_NEED_ACTION). This allows extending the "need action" state
beyond the vDSO and lets the caller issue futex_wake and futex_unlock_pi
system calls. This "need action" flag is cleared by the caller when
zeroing robust_list_head->list_op_pending.

futex_wake now clears the robust_list_head->list_op_pending to close the
race between call to futex_wake and clearing of the
robust_list_head->list_op_pending by the application. This prevents
multiple calls to futex_wake in case a crash happens within that window.

futex_unlock_pi now clears the robust_list_head->list_op_pending
to close the race between call to futex_unlock_pi and
clearing of the robust_list_head->list_op_pending by the application.
This prevents multiple calls to futex_unlock_pi in case a crash happens
within that window.

[ This patch is lightly compiled tested on x86-64 only, submitted for feedback.
  It implements the vDSO for x86-32 and x86-64.
  It is based on v7.0-rc3. ]

Link: https://lore.kernel.org/lkml/20260311185409.1988269-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20260220202620.139584-1-andrealmeid@igalia.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "André Almeida" <andrealmeid@igalia.com>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Rich Felker <dalias@aerifal.cx>
Cc: Torvald Riegel <triegel@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-api@vger.kernel.org
---
Changes since v3:
- Remove _u32 suffix.
- Remove "val" parameter (always 0 per robust futex ABI).

Changes since v2:
- Pass robust_list_head as vdso argument.
- Add "val" parameter to each vdso.
- Add _u32 suffix to each vdso.
- Introduce ARCH_HAS_VDSO_FUTEX to provide a futex_vdso_exception stub
  when not implemented by the architecture.
- Wire up x86 vdso32 vfutex.o.

Changes since v1:
- Remove unlock_store_done leftover code from handle_futex_death.
- Handle robust PI futexes.
---
 arch/Kconfig                        |   3 +
 arch/x86/Kconfig                    |   1 +
 arch/x86/entry/vdso/common/vfutex.c |  90 +++++++++++++
 arch/x86/entry/vdso/extable.c       |  59 ++++++++-
 arch/x86/entry/vdso/extable.h       |  37 ++++--
 arch/x86/entry/vdso/vdso32/Makefile |   1 +
 arch/x86/entry/vdso/vdso32/vfutex.c |   1 +
 arch/x86/entry/vdso/vdso64/Makefile |   1 +
 arch/x86/entry/vdso/vdso64/vfutex.c |   1 +
 arch/x86/entry/vdso/vdso64/vsgx.S   |   2 +-
 arch/x86/include/asm/vdso.h         |   3 +
 arch/x86/kernel/signal.c            |   4 +
 include/linux/futex.h               |   1 +
 include/vdso/futex.h                |  72 +++++++++++
 kernel/futex/core.c                 | 188 ++++++++++++++++++++++++----
 kernel/futex/futex.h                |   2 +
 kernel/futex/pi.c                   |   3 +
 kernel/futex/waitwake.c             |   3 +
 18 files changed, 439 insertions(+), 33 deletions(-)
 create mode 100644 arch/x86/entry/vdso/common/vfutex.c
 create mode 100644 arch/x86/entry/vdso/vdso32/vfutex.c
 create mode 100644 arch/x86/entry/vdso/vdso64/vfutex.c
 create mode 100644 include/vdso/futex.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 102ddbd4298e..4f3e1be29af1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1670,6 +1670,9 @@ config ARCH_HAS_VDSO_ARCH_DATA
 config ARCH_HAS_VDSO_TIME_DATA
 	bool
 
+config ARCH_HAS_VDSO_FUTEX
+	bool
+
 config HAVE_STATIC_CALL
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..957d5d9209a1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -111,6 +111,7 @@ config X86
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_VDSO_FUTEX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAVE_EXTRA_ELF_NOTES
diff --git a/arch/x86/entry/vdso/common/vfutex.c b/arch/x86/entry/vdso/common/vfutex.c
new file mode 100644
index 000000000000..336095b04952
--- /dev/null
+++ b/arch/x86/entry/vdso/common/vfutex.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+#include <linux/types.h>
+#include <linux/futex.h>
+#include <vdso/futex.h>
+#include "extable.h"
+
+#ifdef CONFIG_X86_64
+# define ASM_PTR_BIT_SET	"btsq "
+# define ASM_PTR_SET		"movq "
+#else
+# define ASM_PTR_BIT_SET	"btsl "
+# define ASM_PTR_SET		"movl "
+#endif
+
+u32 __vdso_robust_futex_unlock(u32 *uaddr, struct robust_list_head *robust_list_head)
+{
+	u32 val = 0;
+
+	/*
+	 * Within the ip range identified by the futex exception table,
+	 * the register "eax" contains the value loaded by xchg. This is
+	 * expected by futex_vdso_exception() to check whether waiters
+	 * need to be woken up. This register state is transferred to
+	 * bit 1 (NEED_ACTION) of *op_pending_addr before the ip range
+	 * ends.
+	 */
+	asm volatile (
+		_ASM_VDSO_EXTABLE_FUTEX_HANDLE(1f, 3f)
+		/* Exchange uaddr (store-release). */
+		"xchg %[uaddr], %[val]\n\t"
+		"1:\n\t"
+		/* Test if FUTEX_WAITERS (0x80000000) is set. */
+		"test %[val], %[val]\n\t"
+		"js 2f\n\t"
+		/* Clear *op_pending_addr if there are no waiters. */
+		ASM_PTR_SET "$0, %[op_pending_addr]\n\t"
+		"jmp 3f\n\t"
+		"2:\n\t"
+		/* Set bit 1 (NEED_ACTION) in *op_pending_addr. */
+		ASM_PTR_BIT_SET "$1, %[op_pending_addr]\n\t"
+		"3:\n\t"
+		: [val] "+a" (val),
+		  [uaddr] "+m" (*uaddr)
+		: [op_pending_addr] "m" (robust_list_head->list_op_pending)
+		: "memory"
+	);
+	return val;
+}
+
+u32 robust_futex_unlock(u32 *, struct robust_list_head *)
+	__attribute__((weak, alias("__vdso_robust_futex_unlock")));
+
+int __vdso_robust_pi_futex_try_unlock(u32 *uaddr, u32 *expected, struct robust_list_head *robust_list_head)
+{
+	u32 val = 0, orig, expect = *expected;
+
+	orig = expect;
+	/*
+	 * The ZF is set/cleared by cmpxchg and expected to stay
+	 * invariant for the rest of the code region.
+	 */
+	asm volatile (
+		_ASM_VDSO_EXTABLE_PI_FUTEX_HANDLE(1f, 3f)
+		/* Compare-and-exchange uaddr (store-release). Set/clear the ZF. */
+		"lock; cmpxchg %[val], %[uaddr]\n\t"
+		"1:\n\t"
+		/* Check whether cmpxchg fails. */
+		"jnz 2f\n\t"
+		/* Clear *op_pending_addr. */
+		ASM_PTR_SET "$0, %[op_pending_addr]\n\t"
+		"jmp 3f\n\t"
+		"2:\n\t"
+		/* Set bit 1 (NEED_ACTION) in *op_pending_addr. */
+		ASM_PTR_BIT_SET "$1, %[op_pending_addr]\n\t"
+		"3:\n\t"
+		: [expect] "+a" (expect),
+		  [uaddr] "+m" (*uaddr)
+		: [op_pending_addr] "m" (robust_list_head->list_op_pending),
+		  [val] "r" (val)
+		: "memory"
+	);
+	*expected = expect;
+	return expect == orig;
+}
+
+int robust_pi_futex_try_unlock(u32 *, u32 *, struct robust_list_head *)
+	__attribute__((weak, alias("__vdso_robust_pi_futex_try_unlock")));
diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
index afcf5b65beef..90a31ffb9c6d 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -1,12 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/futex.h>
 #include <asm/current.h>
 #include <asm/traps.h>
 #include <asm/vdso.h>
 
+enum vdso_extable_entry_type {
+	VDSO_EXTABLE_ENTRY_FIXUP = 0,
+	VDSO_EXTABLE_ENTRY_FUTEX = 1,
+	VDSO_EXTABLE_ENTRY_PI_FUTEX = 2,
+};
+
 struct vdso_exception_table_entry {
-	int insn, fixup;
+	int type;	/* enum vdso_extable_entry_type */
+	union {
+		struct {
+			int insn, fixup_insn;
+		} fixup;
+		struct {
+			int start, end;
+		} futex;
+	};
 };
 
 bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
@@ -33,8 +48,10 @@ bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 	extable = image->extable;
 
 	for (i = 0; i < nr_entries; i++) {
-		if (regs->ip == base + extable[i].insn) {
-			regs->ip = base + extable[i].fixup;
+		if (extable[i].type != VDSO_EXTABLE_ENTRY_FIXUP)
+			continue;
+		if (regs->ip == base + extable[i].fixup.insn) {
+			regs->ip = base + extable[i].fixup.fixup_insn;
 			regs->di = trapnr;
 			regs->si = error_code;
 			regs->dx = fault_addr;
@@ -44,3 +61,39 @@ bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 
 	return false;
 }
+
+void futex_vdso_exception(struct pt_regs *regs,
+			  bool *_in_futex_vdso,
+			  bool *_need_action)
+{
+	const struct vdso_image *image = current->mm->context.vdso_image;
+	const struct vdso_exception_table_entry *extable;
+	bool in_futex_vdso = false, need_action = false;
+	unsigned int nr_entries, i;
+	unsigned long base;
+
+	if (!current->mm->context.vdso)
+		goto end;
+
+	base = (unsigned long)current->mm->context.vdso + image->extable_base;
+	nr_entries = image->extable_len / (sizeof(*extable));
+	extable = image->extable;
+
+	for (i = 0; i < nr_entries; i++) {
+		if (extable[i].type != VDSO_EXTABLE_ENTRY_FUTEX &&
+		    extable[i].type != VDSO_EXTABLE_ENTRY_PI_FUTEX)
+			continue;
+		if (regs->ip >= base + extable[i].futex.start &&
+		    regs->ip < base + extable[i].futex.end) {
+			in_futex_vdso = true;
+			if (extable[i].type == VDSO_EXTABLE_ENTRY_FUTEX)
+				need_action = (regs->ax & FUTEX_WAITERS);
+			else
+				need_action = !(regs->flags & X86_EFLAGS_ZF);
+			break;
+		}
+	}
+end:
+	*_in_futex_vdso = in_futex_vdso;
+	*_need_action = need_action;
+}
diff --git a/arch/x86/entry/vdso/extable.h b/arch/x86/entry/vdso/extable.h
index baba612b832c..5dfbde724065 100644
--- a/arch/x86/entry/vdso/extable.h
+++ b/arch/x86/entry/vdso/extable.h
@@ -8,21 +8,44 @@
  * exception table, not each individual entry.
  */
 #ifdef __ASSEMBLER__
-#define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
-	ASM_VDSO_EXTABLE_HANDLE from to
+#define _ASM_VDSO_EXTABLE_FIXUP_HANDLE(from, to)	\
+	ASM_VDSO_EXTABLE_FIXUP_HANDLE from to
 
-.macro ASM_VDSO_EXTABLE_HANDLE from:req to:req
+.macro ASM_VDSO_EXTABLE_FIXUP_HANDLE from:req to:req
 	.pushsection __ex_table, "a"
+	.long 0		/* type: fixup */
 	.long (\from) - __ex_table
 	.long (\to) - __ex_table
 	.popsection
 .endm
 #else
-#define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
-	".pushsection __ex_table, \"a\"\n"      \
-	".long (" #from ") - __ex_table\n"      \
-	".long (" #to ") - __ex_table\n"        \
+#define _ASM_VDSO_EXTABLE_FIXUP_HANDLE(from, to)	\
+	".pushsection __ex_table, \"a\"\n"		\
+	".long 0\n"	/* type: fixup */		\
+	".long (" #from ") - __ex_table\n"		\
+	".long (" #to ") - __ex_table\n"		\
 	".popsection\n"
+
+/*
+ * Identify robust futex unlock critical section.
+ */
+#define _ASM_VDSO_EXTABLE_FUTEX_HANDLE(start, end)	\
+	".pushsection __ex_table, \"a\"\n"		\
+	".long 1\n"	/* type: futex */		\
+	".long (" #start ") - __ex_table\n"		\
+	".long (" #end ") - __ex_table\n"		\
+	".popsection\n"
+
+/*
+ * Identify robust PI futex unlock critical section.
+ */
+#define _ASM_VDSO_EXTABLE_PI_FUTEX_HANDLE(start, end)	\
+	".pushsection __ex_table, \"a\"\n"		\
+	".long 2\n"	/* type: pi_futex */		\
+	".long (" #start ") - __ex_table\n"		\
+	".long (" #end ") - __ex_table\n"		\
+	".popsection\n"
+
 #endif
 
 #endif /* __VDSO_EXTABLE_H */
diff --git a/arch/x86/entry/vdso/vdso32/Makefile b/arch/x86/entry/vdso/vdso32/Makefile
index add6afb484ba..acf4f990be98 100644
--- a/arch/x86/entry/vdso/vdso32/Makefile
+++ b/arch/x86/entry/vdso/vdso32/Makefile
@@ -9,6 +9,7 @@ vdsos-y			:= 32
 # Files to link into the vDSO:
 vobjs-y			:= note.o vclock_gettime.o vgetcpu.o
 vobjs-y			+= system_call.o sigreturn.o
+vobjs-y			+= vfutex.o
 
 # Compilation flags
 flags-y			:= -DBUILD_VDSO32 -m32 -mregparm=0
diff --git a/arch/x86/entry/vdso/vdso32/vfutex.c b/arch/x86/entry/vdso/vdso32/vfutex.c
new file mode 100644
index 000000000000..940a6ee30026
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso32/vfutex.c
@@ -0,0 +1 @@
+#include "common/vfutex.c"
diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64/Makefile
index bfffaf1aeecc..df53c2d0037d 100644
--- a/arch/x86/entry/vdso/vdso64/Makefile
+++ b/arch/x86/entry/vdso/vdso64/Makefile
@@ -10,6 +10,7 @@ vdsos-$(CONFIG_X86_X32_ABI)	+= x32
 # Files to link into the vDSO:
 vobjs-y				:= note.o vclock_gettime.o vgetcpu.o
 vobjs-y				+= vgetrandom.o vgetrandom-chacha.o
+vobjs-y				+= vfutex.o
 vobjs-$(CONFIG_X86_SGX)		+= vsgx.o
 
 # Compilation flags
diff --git a/arch/x86/entry/vdso/vdso64/vfutex.c b/arch/x86/entry/vdso/vdso64/vfutex.c
new file mode 100644
index 000000000000..940a6ee30026
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/vfutex.c
@@ -0,0 +1 @@
+#include "common/vfutex.c"
diff --git a/arch/x86/entry/vdso/vdso64/vsgx.S b/arch/x86/entry/vdso/vdso64/vsgx.S
index 37a3d4c02366..0ea5a1ebd455 100644
--- a/arch/x86/entry/vdso/vdso64/vsgx.S
+++ b/arch/x86/entry/vdso/vdso64/vsgx.S
@@ -145,6 +145,6 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 
 	.cfi_endproc
 
-_ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
+_ASM_VDSO_EXTABLE_FIXUP_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
 
 SYM_FUNC_END(__vdso_sgx_enter_enclave)
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index e8afbe9faa5b..9ac7af34cdc4 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -38,6 +38,9 @@ extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
 extern bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 				 unsigned long error_code,
 				 unsigned long fault_addr);
+extern void futex_vdso_exception(struct pt_regs *regs,
+				 bool *in_futex_vdso,
+				 bool *need_action);
 #endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_VDSO_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2404233336ab..c2e4db89f16d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -28,6 +28,7 @@
 #include <linux/entry-common.h>
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
+#include <linux/futex.h>
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -235,6 +236,9 @@ unsigned long get_sigframe_size(void)
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	/* Handle futex robust list fixup. */
+	futex_signal_deliver(ksig, regs);
+
 	/* Perform fixup for the pre-signal frame. */
 	rseq_signal_deliver(ksig, regs);
 
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9e9750f04980..6c274c79e176 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -81,6 +81,7 @@ void futex_exec_release(struct task_struct *tsk);
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
+void futex_signal_deliver(struct ksignal *ksig, struct pt_regs *regs);
 
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
diff --git a/include/vdso/futex.h b/include/vdso/futex.h
new file mode 100644
index 000000000000..757623b99250
--- /dev/null
+++ b/include/vdso/futex.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _VDSO_FUTEX_H
+#define _VDSO_FUTEX_H
+
+#include <linux/types.h>
+#include <linux/futex.h>
+
+/**
+ * __vdso_robust_futex_unlock - Architecture-specific vDSO implementation of robust futex unlock.
+ * @uaddr:		Lock address (points to a 32-bit unsigned integer type).
+ * @robust_list_head:	The thread-specific robust list that has been registered with set_robust_list.
+ *
+ * This vDSO unlocks the robust futex by exchanging the content of
+ * *@uaddr with 0 with a store-release semantic. If the futex has
+ * waiters, it sets bit 1 of *@robust_list_head->list_op_pending, else
+ * it clears *@robust_list_head->list_op_pending. Those operations are
+ * within a code region known by the kernel, making them safe with
+ * respect to asynchronous program termination either from thread
+ * context or from a nested signal handler.
+ *
+ * Returns:	The old value present at *@uaddr.
+ *
+ * Expected use of this vDSO:
+ *
+ * robust_list_head is the thread-specific robust list that has been
+ * registered with set_robust_list.
+ *
+ * if ((__vdso_robust_futex_unlock((u32 *) &mutex->__data.__lock, robust_list_head)
+ *     & FUTEX_WAITERS) != 0)
+ *         futex_wake((u32 *) &mutex->__data.__lock, 1, private);
+ * WRITE_ONCE(robust_list_head->list_op_pending, 0);
+ */
+extern u32 __vdso_robust_futex_unlock(u32 *uaddr, struct robust_list_head *robust_list_head);
+
+/*
+ * __vdso_robust_pi_futex_try_unlock - Architecture-specific vDSO implementation of robust PI futex unlock.
+ * @uaddr:		Lock address (points to a 32-bit unsigned integer type).
+ * @expected:		Expected value (in), value loaded by compare-and-exchange (out).
+ * @robust_list_head:	The thread-specific robust list that has been registered with set_robust_list.
+ *
+ * This vDSO try to perform a compare-and-exchange with release semantic
+ * to set the expected *@uaddr content to 0. If the futex has
+ * waiters, it fails, and userspace needs to call futex_unlock_pi().
+ * Before exiting the critical section, if the cmpxchg fails, it sets
+ * bit 1 of *@robust_list_head->list_op_pending. If the cmpxchg
+ * succeeds, it clears *@robust_list_head->list_op_pending. Those
+ * operations are within a code region known by the kernel, making them
+ * safe with respect to asynchronous program termination either from
+ * thread context or from a nested signal handler.
+ *
+ * Returns:	Zero if the operation fails to release the lock, non-zero on success.
+ *
+ * Expected use of this vDSO:
+ *
+ *
+ * int l = atomic_load_relaxed(&mutex->__data.__lock);
+ * do {
+ *         if (((l & FUTEX_WAITERS) != 0) || (l != READ_ONCE(pd->tid))) {
+ *                 futex_unlock_pi((unsigned int *) &mutex->__data.__lock, private);
+ *                 break;
+ *         }
+ * } while (!__vdso_robust_pi_futex_try_unlock(&mutex->__data.__lock,
+ *                                             &l, robust_list_head));
+ * WRITE_ONCE(robust_list_head->list_op_pending, 0);
+ */
+int __vdso_robust_pi_futex_try_unlock(u32 *uaddr, u32 *expected, struct robust_list_head *robust_list_head);
+
+#endif /* _VDSO_FUTEX_H */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index cf7e610eac42..28bcbe6156ee 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -48,6 +48,10 @@
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
 
+#define FUTEX_UADDR_PI		(1UL << 0)
+#define FUTEX_UADDR_NEED_ACTION	(1UL << 1)
+#define FUTEX_UADDR_MASK	(~(FUTEX_UADDR_PI | FUTEX_UADDR_NEED_ACTION))
+
 /*
  * The base of the bucket array and its size are always used together
  * (after initialization only in futex_hash()), so ensure that they
@@ -1004,6 +1008,118 @@ void futex_unqueue_pi(struct futex_q *q)
 	q->pi_state = NULL;
 }
 
+#ifndef CONFIG_ARCH_HAS_VDSO_FUTEX
+static void futex_vdso_exception(struct pt_regs *regs, bool *in_futex_vdso, bool *need_action)
+{
+	*in_futex_vdso = false;
+	*need_action = false;
+}
+#endif
+
+/*
+ * Transfer the need action state from vDSO stack to the
+ * FUTEX_UADDR_NEED_ACTION list_op_pending bit so it's observed if the
+ * program is terminated while executing the signal handler.
+ */
+static void signal_delivery_fixup_robust_list(struct task_struct *curr, struct pt_regs *regs)
+{
+	struct robust_list_head __user *head = curr->robust_list;
+	bool in_futex_vdso, need_action;
+	unsigned long pending;
+
+	if (!head)
+		return;
+	futex_vdso_exception(regs, &in_futex_vdso, &need_action);
+	if (!in_futex_vdso)
+		return;
+
+	if (need_action) {
+		if (get_user(pending, (unsigned long __user *)&head->list_op_pending))
+			goto fault;
+		pending |= FUTEX_UADDR_NEED_ACTION;
+		if (put_user(pending, (unsigned long __user *)&head->list_op_pending))
+			goto fault;
+	} else {
+		if (put_user(0UL, (unsigned long __user *)&head->list_op_pending))
+			goto fault;
+	}
+	return;
+fault:
+	force_sig(SIGSEGV);
+}
+
+#ifdef CONFIG_COMPAT
+static void compat_signal_delivery_fixup_robust_list(struct task_struct *curr, struct pt_regs *regs)
+{
+	struct compat_robust_list_head __user *head = curr->compat_robust_list;
+	bool in_futex_vdso, need_action;
+	unsigned int pending;
+
+	if (!head)
+		return;
+	futex_vdso_exception(regs, &in_futex_vdso, &need_action);
+	if (!in_futex_vdso)
+		return;
+	if (need_action) {
+		if (get_user(pending, (compat_uptr_t __user *)&head->list_op_pending))
+			goto fault;
+		pending |= FUTEX_UADDR_NEED_ACTION;
+		if (put_user(pending, (compat_uptr_t __user *)&head->list_op_pending))
+			goto fault;
+	} else {
+		if (put_user(0U, (compat_uptr_t __user *)&head->list_op_pending))
+			goto fault;
+	}
+	return;
+fault:
+	force_sig(SIGSEGV);
+}
+#endif
+
+void futex_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+
+	if (unlikely(tsk->robust_list))
+		signal_delivery_fixup_robust_list(tsk, regs);
+#ifdef CONFIG_COMPAT
+	if (unlikely(tsk->compat_robust_list))
+		compat_signal_delivery_fixup_robust_list(tsk, regs);
+#endif
+}
+
+static void do_clear_robust_list_pending_op(struct task_struct *curr)
+{
+	struct robust_list_head __user *head = curr->robust_list;
+
+	if (!head)
+		return;
+	if (put_user(0UL, (unsigned long __user *)&head->list_op_pending))
+		force_sig(SIGSEGV);
+}
+
+#ifdef CONFIG_COMPAT
+static void do_compat_clear_robust_list_pending_op(struct task_struct *curr)
+{
+	struct robust_list_head __user *head = curr->robust_list;
+
+	if (!head)
+		return;
+	if (put_user(0U, (unsigned int __user *)&head->list_op_pending))
+		force_sig(SIGSEGV);
+}
+#endif
+
+void clear_robust_list_pending_op(struct task_struct *curr)
+{
+	if (unlikely(curr->robust_list))
+		do_clear_robust_list_pending_op(curr);
+#ifdef CONFIG_COMPAT
+	if (unlikely(curr->compat_robust_list))
+		do_compat_clear_robust_list_pending_op(curr);
+#endif
+}
+
 /* Constants for the pending_op argument of handle_futex_death */
 #define HANDLE_DEATH_PENDING	true
 #define HANDLE_DEATH_LIST	false
@@ -1013,12 +1129,34 @@ void futex_unqueue_pi(struct futex_q *q)
  * dying task, and do notification if so:
  */
 static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
-			      bool pi, bool pending_op)
+			      bool pi, bool pending_op, bool need_action)
 {
 	u32 uval, nval, mval;
 	pid_t owner;
 	int err;
 
+	/*
+	 * Process dies after the store unlocking futex, before clearing
+	 * the pending ops. Perform the required action if needed.
+	 * For non-PI futex, the action is to wake up the waiter.
+	 * For PI futex, the action is to call robust_unlock_pi.
+	 * Prevent storing to the futex after it was unlocked.
+	 */
+	if (pending_op) {
+		bool in_futex_vdso, vdso_need_action;
+
+		futex_vdso_exception(task_pt_regs(curr), &in_futex_vdso, &vdso_need_action);
+		if (need_action || vdso_need_action) {
+			if (pi)
+				futex_unlock_pi(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED);
+			else
+				futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, 1,
+					   FUTEX_BITSET_MATCH_ANY);
+		}
+		if (need_action || in_futex_vdso)
+			return 0;
+	}
+
 	/* Futex address must be 32bit aligned */
 	if ((((unsigned long)uaddr) % sizeof(*uaddr)) != 0)
 		return -1;
@@ -1128,19 +1266,23 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 }
 
 /*
- * Fetch a robust-list pointer. Bit 0 signals PI futexes:
+ * Fetch a robust-list pointer. Bit 0 signals PI futexes, bit 1 signals
+ * need action:
  */
 static inline int fetch_robust_entry(struct robust_list __user **entry,
 				     struct robust_list __user * __user *head,
-				     unsigned int *pi)
+				     unsigned int *pi,
+				     unsigned int *need_action)
 {
 	unsigned long uentry;
 
 	if (get_user(uentry, (unsigned long __user *)head))
 		return -EFAULT;
 
-	*entry = (void __user *)(uentry & ~1UL);
-	*pi = uentry & 1;
+	*entry = (void __user *)(uentry & FUTEX_UADDR_MASK);
+	*pi = uentry & FUTEX_UADDR_PI;
+	if (need_action)
+		*need_action = uentry & FUTEX_UADDR_NEED_ACTION;
 
 	return 0;
 }
@@ -1155,7 +1297,7 @@ static void exit_robust_list(struct task_struct *curr)
 {
 	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
-	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
+	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip, need_action;
 	unsigned int next_pi;
 	unsigned long futex_offset;
 	int rc;
@@ -1164,7 +1306,7 @@ static void exit_robust_list(struct task_struct *curr)
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
 	 */
-	if (fetch_robust_entry(&entry, &head->list.next, &pi))
+	if (fetch_robust_entry(&entry, &head->list.next, &pi, NULL))
 		return;
 	/*
 	 * Fetch the relative futex offset:
@@ -1175,7 +1317,7 @@ static void exit_robust_list(struct task_struct *curr)
 	 * Fetch any possibly pending lock-add first, and handle it
 	 * if it exists:
 	 */
-	if (fetch_robust_entry(&pending, &head->list_op_pending, &pip))
+	if (fetch_robust_entry(&pending, &head->list_op_pending, &pip, &need_action))
 		return;
 
 	next_entry = NULL;	/* avoid warning with gcc */
@@ -1184,14 +1326,14 @@ static void exit_robust_list(struct task_struct *curr)
 		 * Fetch the next entry in the list before calling
 		 * handle_futex_death:
 		 */
-		rc = fetch_robust_entry(&next_entry, &entry->next, &next_pi);
+		rc = fetch_robust_entry(&next_entry, &entry->next, &next_pi, NULL);
 		/*
 		 * A pending lock might already be on the list, so
 		 * don't process it twice:
 		 */
 		if (entry != pending) {
 			if (handle_futex_death((void __user *)entry + futex_offset,
-						curr, pi, HANDLE_DEATH_LIST))
+						curr, pi, HANDLE_DEATH_LIST, false))
 				return;
 		}
 		if (rc)
@@ -1209,7 +1351,7 @@ static void exit_robust_list(struct task_struct *curr)
 
 	if (pending) {
 		handle_futex_death((void __user *)pending + futex_offset,
-				   curr, pip, HANDLE_DEATH_PENDING);
+				   curr, pip, HANDLE_DEATH_PENDING, need_action);
 	}
 }
 
@@ -1224,17 +1366,20 @@ static void __user *futex_uaddr(struct robust_list __user *entry,
 }
 
 /*
- * Fetch a robust-list pointer. Bit 0 signals PI futexes:
+ * Fetch a robust-list pointer. Bit 0 signals PI futexes, bit 1 signals
+ * need action:
  */
 static inline int
 compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **entry,
-		   compat_uptr_t __user *head, unsigned int *pi)
+		   compat_uptr_t __user *head, unsigned int *pi, unsigned int *need_action)
 {
 	if (get_user(*uentry, head))
 		return -EFAULT;
 
-	*entry = compat_ptr((*uentry) & ~1);
-	*pi = (unsigned int)(*uentry) & 1;
+	*entry = compat_ptr((*uentry) & FUTEX_UADDR_MASK);
+	*pi = (unsigned int)(*uentry) & FUTEX_UADDR_PI;
+	if (need_action)
+		*need_action = (unsigned int)(*uentry) & FUTEX_UADDR_NEED_ACTION;
 
 	return 0;
 }
@@ -1249,7 +1394,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 {
 	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
-	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
+	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip, need_action;
 	unsigned int next_pi;
 	compat_uptr_t uentry, next_uentry, upending;
 	compat_long_t futex_offset;
@@ -1259,7 +1404,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
 	 */
-	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
+	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi, NULL))
 		return;
 	/*
 	 * Fetch the relative futex offset:
@@ -1271,7 +1416,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	 * if it exists:
 	 */
 	if (compat_fetch_robust_entry(&upending, &pending,
-			       &head->list_op_pending, &pip))
+			       &head->list_op_pending, &pip, &need_action))
 		return;
 
 	next_entry = NULL;	/* avoid warning with gcc */
@@ -1281,7 +1426,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 		 * handle_futex_death:
 		 */
 		rc = compat_fetch_robust_entry(&next_uentry, &next_entry,
-			(compat_uptr_t __user *)&entry->next, &next_pi);
+			(compat_uptr_t __user *)&entry->next, &next_pi, NULL);
 		/*
 		 * A pending lock might already be on the list, so
 		 * dont process it twice:
@@ -1289,8 +1434,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 		if (entry != pending) {
 			void __user *uaddr = futex_uaddr(entry, futex_offset);
 
-			if (handle_futex_death(uaddr, curr, pi,
-					       HANDLE_DEATH_LIST))
+			if (handle_futex_death(uaddr, curr, pi, HANDLE_DEATH_LIST, false))
 				return;
 		}
 		if (rc)
@@ -1309,7 +1453,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	if (pending) {
 		void __user *uaddr = futex_uaddr(pending, futex_offset);
 
-		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
+		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING, need_action);
 	}
 }
 #endif
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 30c2afa03889..f64ed00463ca 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -396,6 +396,8 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 		spin_unlock(&hb2->lock);
 }
 
+extern void clear_robust_list_pending_op(struct task_struct *curr);
+
 /* syscalls */
 
 extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags, u32
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index bc1f7e83a37e..3b889dfbcdd5 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1148,6 +1148,9 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	if ((uval & FUTEX_TID_MASK) != vpid)
 		return -EPERM;
 
+	/* Clear the pending_op_list. */
+	clear_robust_list_pending_op(current);
+
 	ret = get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
 	if (ret)
 		return ret;
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 1c2dd03f11ec..7752ed8c6dc1 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -162,6 +162,9 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if (!bitset)
 		return -EINVAL;
 
+	/* Clear the pending_op_list. */
+	clear_robust_list_pending_op(current);
+
 	ret = get_futex_key(uaddr, flags, &key, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
-- 
2.39.5


