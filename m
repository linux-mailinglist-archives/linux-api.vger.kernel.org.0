Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97477409DBA
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347912AbhIMUF5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 16:05:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:38697 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347806AbhIMUFs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336371"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336371"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643918"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:31 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 06/13] x86/uintr: Introduce uintr receiver syscalls
Date:   Mon, 13 Sep 2021 13:01:25 -0700
Message-Id: <20210913200132.3396598-7-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Any application that wants to receive a user interrupt needs to register
an interrupt handler with the kernel. Add a registration syscall that
sets up the interrupt handler and the related kernel structures for
the task that makes this syscall.

Only one interrupt handler per task can be registered with the
kernel/hardware. Each task has its private interrupt vector space of 64
vectors. The vector registration and the related FD management is
covered later.

Also add an unregister syscall to let a task unregister the interrupt
handler.

The UPID for each receiver task needs to be updated whenever a task gets
context switched or it moves from one cpu to another. This will also be
covered later. The system calls haven't been wired up yet so no real
harm is done if we don't update the UPID right now.

<Code typically in the x86/kernel directory doesn't deal with file
descriptor management. I have kept uintr_fd.c separate to make it easier
to move it somewhere else if needed.>

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/processor.h |   6 +
 arch/x86/include/asm/uintr.h     |  13 ++
 arch/x86/kernel/Makefile         |   1 +
 arch/x86/kernel/uintr_core.c     | 240 +++++++++++++++++++++++++++++++
 arch/x86/kernel/uintr_fd.c       |  58 ++++++++
 5 files changed, 318 insertions(+)
 create mode 100644 arch/x86/include/asm/uintr.h
 create mode 100644 arch/x86/kernel/uintr_core.c
 create mode 100644 arch/x86/kernel/uintr_fd.c

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9ad2acaaae9b..d229bfac8b4f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -9,6 +9,7 @@ struct task_struct;
 struct mm_struct;
 struct io_bitmap;
 struct vm86;
+struct uintr_receiver;
 
 #include <asm/math_emu.h>
 #include <asm/segment.h>
@@ -529,6 +530,11 @@ struct thread_struct {
 	 */
 	u32			pkru;
 
+#ifdef CONFIG_X86_USER_INTERRUPTS
+	/* User Interrupt state*/
+	struct uintr_receiver	*ui_recv;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/include/asm/uintr.h b/arch/x86/include/asm/uintr.h
new file mode 100644
index 000000000000..4f35bd8bd4e0
--- /dev/null
+++ b/arch/x86/include/asm/uintr.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UINTR_H
+#define _ASM_X86_UINTR_H
+
+#ifdef CONFIG_X86_USER_INTERRUPTS
+
+bool uintr_arch_enabled(void);
+int do_uintr_register_handler(u64 handler);
+int do_uintr_unregister_handler(void);
+
+#endif /* CONFIG_X86_USER_INTERRUPTS */
+
+#endif /* _ASM_X86_UINTR_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8f4e8fa6ed75..060ca9f23e23 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_UPROBES)			+= uprobes.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
+obj-$(CONFIG_X86_USER_INTERRUPTS)	+= uintr_fd.o uintr_core.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
 
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
new file mode 100644
index 000000000000..2c6042a6840a
--- /dev/null
+++ b/arch/x86/kernel/uintr_core.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, Intel Corporation.
+ *
+ * Sohil Mehta <sohil.mehta@intel.com>
+ * Jacob Pan <jacob.jun.pan@linux.intel.com>
+ */
+#define pr_fmt(fmt)    "uintr: " fmt
+
+#include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <asm/apic.h>
+#include <asm/fpu/internal.h>
+#include <asm/irq_vectors.h>
+#include <asm/msr.h>
+#include <asm/msr-index.h>
+#include <asm/uintr.h>
+
+/* User Posted Interrupt Descriptor (UPID) */
+struct uintr_upid {
+	struct {
+		u8 status;	/* bit 0: ON, bit 1: SN, bit 2-7: reserved */
+		u8 reserved1;	/* Reserved */
+		u8 nv;		/* Notification vector */
+		u8 reserved2;	/* Reserved */
+		u32 ndst;	/* Notification destination */
+	} nc __packed;		/* Notification control */
+	u64 puir;		/* Posted user interrupt requests */
+} __aligned(64);
+
+/* UPID Notification control status */
+#define UPID_ON		0x0	/* Outstanding notification */
+#define UPID_SN		0x1	/* Suppressed notification */
+
+struct uintr_upid_ctx {
+	struct uintr_upid *upid;
+	refcount_t refs;
+};
+
+struct uintr_receiver {
+	struct uintr_upid_ctx *upid_ctx;
+};
+
+inline bool uintr_arch_enabled(void)
+{
+	return static_cpu_has(X86_FEATURE_UINTR);
+}
+
+static inline bool is_uintr_receiver(struct task_struct *t)
+{
+	return !!t->thread.ui_recv;
+}
+
+static inline u32 cpu_to_ndst(int cpu)
+{
+	u32 apicid = (u32)apic->cpu_present_to_apicid(cpu);
+
+	WARN_ON_ONCE(apicid == BAD_APICID);
+
+	if (!x2apic_enabled())
+		return (apicid << 8) & 0xFF00;
+
+	return apicid;
+}
+
+static void free_upid(struct uintr_upid_ctx *upid_ctx)
+{
+	kfree(upid_ctx->upid);
+	upid_ctx->upid = NULL;
+	kfree(upid_ctx);
+}
+
+/* TODO: UPID needs to be allocated by a KPTI compatible allocator */
+static struct uintr_upid_ctx *alloc_upid(void)
+{
+	struct uintr_upid_ctx *upid_ctx;
+	struct uintr_upid *upid;
+
+	upid_ctx = kzalloc(sizeof(*upid_ctx), GFP_KERNEL);
+	if (!upid_ctx)
+		return NULL;
+
+	upid = kzalloc(sizeof(*upid), GFP_KERNEL);
+
+	if (!upid) {
+		kfree(upid_ctx);
+		return NULL;
+	}
+
+	upid_ctx->upid = upid;
+	refcount_set(&upid_ctx->refs, 1);
+
+	return upid_ctx;
+}
+
+static void put_upid_ref(struct uintr_upid_ctx *upid_ctx)
+{
+	if (refcount_dec_and_test(&upid_ctx->refs))
+		free_upid(upid_ctx);
+}
+
+int do_uintr_unregister_handler(void)
+{
+	struct task_struct *t = current;
+	struct fpu *fpu = &t->thread.fpu;
+	struct uintr_receiver *ui_recv;
+	u64 msr64;
+
+	if (!is_uintr_receiver(t))
+		return -EINVAL;
+
+	pr_debug("recv: Unregister handler and clear MSRs for task=%d\n",
+		 t->pid);
+
+	/*
+	 * TODO: Evaluate usage of fpregs_lock() and get_xsave_addr(). Bugs
+	 * have been reported recently for PASID and WRPKRU.
+	 *
+	 * UPID and ui_recv will be referenced during context switch. Need to
+	 * disable preemption while modifying the MSRs, UPID and ui_recv thread
+	 * struct.
+	 */
+	fpregs_lock();
+
+	/* Clear only the receiver specific state. Sender related state is not modified */
+	if (fpregs_state_valid(fpu, smp_processor_id())) {
+		/* Modify only the relevant bits of the MISC MSR */
+		rdmsrl(MSR_IA32_UINTR_MISC, msr64);
+		msr64 &= ~GENMASK_ULL(39, 32);
+		wrmsrl(MSR_IA32_UINTR_MISC, msr64);
+		wrmsrl(MSR_IA32_UINTR_PD, 0ULL);
+		wrmsrl(MSR_IA32_UINTR_RR, 0ULL);
+		wrmsrl(MSR_IA32_UINTR_STACKADJUST, 0ULL);
+		wrmsrl(MSR_IA32_UINTR_HANDLER, 0ULL);
+	} else {
+		struct uintr_state *p;
+
+		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_UINTR);
+		if (p) {
+			p->handler = 0;
+			p->stack_adjust = 0;
+			p->upid_addr = 0;
+			p->uinv = 0;
+			p->uirr = 0;
+		}
+	}
+
+	ui_recv = t->thread.ui_recv;
+	/*
+	 * Suppress notifications so that no further interrupts are generated
+	 * based on this UPID.
+	 */
+	set_bit(UPID_SN, (unsigned long *)&ui_recv->upid_ctx->upid->nc.status);
+
+	put_upid_ref(ui_recv->upid_ctx);
+	kfree(ui_recv);
+	t->thread.ui_recv = NULL;
+
+	fpregs_unlock();
+
+	return 0;
+}
+
+int do_uintr_register_handler(u64 handler)
+{
+	struct uintr_receiver *ui_recv;
+	struct uintr_upid *upid;
+	struct task_struct *t = current;
+	struct fpu *fpu = &t->thread.fpu;
+	u64 misc_msr;
+	int cpu;
+
+	if (is_uintr_receiver(t))
+		return -EBUSY;
+
+	ui_recv = kzalloc(sizeof(*ui_recv), GFP_KERNEL);
+	if (!ui_recv)
+		return -ENOMEM;
+
+	ui_recv->upid_ctx = alloc_upid();
+	if (!ui_recv->upid_ctx) {
+		kfree(ui_recv);
+		pr_debug("recv: alloc upid failed for task=%d\n", t->pid);
+		return -ENOMEM;
+	}
+
+	/*
+	 * TODO: Evaluate usage of fpregs_lock() and get_xsave_addr(). Bugs
+	 * have been reported recently for PASID and WRPKRU.
+	 *
+	 * UPID and ui_recv will be referenced during context switch. Need to
+	 * disable preemption while modifying the MSRs, UPID and ui_recv thread
+	 * struct.
+	 */
+	fpregs_lock();
+
+	cpu = smp_processor_id();
+	upid = ui_recv->upid_ctx->upid;
+	upid->nc.nv = UINTR_NOTIFICATION_VECTOR;
+	upid->nc.ndst = cpu_to_ndst(cpu);
+
+	t->thread.ui_recv = ui_recv;
+
+	if (fpregs_state_valid(fpu, cpu)) {
+		wrmsrl(MSR_IA32_UINTR_HANDLER, handler);
+		wrmsrl(MSR_IA32_UINTR_PD, (u64)ui_recv->upid_ctx->upid);
+
+		/* Set value as size of ABI redzone */
+		wrmsrl(MSR_IA32_UINTR_STACKADJUST, 128);
+
+		/* Modify only the relevant bits of the MISC MSR */
+		rdmsrl(MSR_IA32_UINTR_MISC, misc_msr);
+		misc_msr |= (u64)UINTR_NOTIFICATION_VECTOR << 32;
+		wrmsrl(MSR_IA32_UINTR_MISC, misc_msr);
+	} else {
+		struct xregs_state *xsave;
+		struct uintr_state *p;
+
+		xsave = &fpu->state.xsave;
+		xsave->header.xfeatures |= XFEATURE_MASK_UINTR;
+		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_UINTR);
+		if (p) {
+			p->handler = handler;
+			p->upid_addr = (u64)ui_recv->upid_ctx->upid;
+			p->stack_adjust = 128;
+			p->uinv = UINTR_NOTIFICATION_VECTOR;
+		}
+	}
+
+	fpregs_unlock();
+
+	pr_debug("recv: task=%d register handler=%llx upid %px\n",
+		 t->pid, handler, upid);
+
+	return 0;
+}
diff --git a/arch/x86/kernel/uintr_fd.c b/arch/x86/kernel/uintr_fd.c
new file mode 100644
index 000000000000..a1a9c105fdab
--- /dev/null
+++ b/arch/x86/kernel/uintr_fd.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, Intel Corporation.
+ *
+ * Sohil Mehta <sohil.mehta@intel.com>
+ */
+#define pr_fmt(fmt)	"uintr: " fmt
+
+#include <linux/sched.h>
+#include <linux/syscalls.h>
+
+#include <asm/uintr.h>
+
+/*
+ * sys_uintr_register_handler - setup user interrupt handler for receiver.
+ */
+SYSCALL_DEFINE2(uintr_register_handler, u64 __user *, handler, unsigned int, flags)
+{
+	int ret;
+
+	if (!uintr_arch_enabled())
+		return -EOPNOTSUPP;
+
+	if (flags)
+		return -EINVAL;
+
+	/* TODO: Validate the handler address */
+	if (!handler)
+		return -EFAULT;
+
+	ret = do_uintr_register_handler((u64)handler);
+
+	pr_debug("recv: register handler task=%d flags %d handler %lx ret %d\n",
+		 current->pid, flags, (unsigned long)handler, ret);
+
+	return ret;
+}
+
+/*
+ * sys_uintr_unregister_handler - Teardown user interrupt handler for receiver.
+ */
+SYSCALL_DEFINE1(uintr_unregister_handler, unsigned int, flags)
+{
+	int ret;
+
+	if (!uintr_arch_enabled())
+		return -EOPNOTSUPP;
+
+	if (flags)
+		return -EINVAL;
+
+	ret = do_uintr_unregister_handler();
+
+	pr_debug("recv: unregister handler task=%d flags %d ret %d\n",
+		 current->pid, flags, ret);
+
+	return ret;
+}
-- 
2.33.0

