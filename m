Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E995E409DD4
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 22:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348003AbhIMUG1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 16:06:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:38689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347968AbhIMUGH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 13 Sep 2021 16:06:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336385"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336385"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643931"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:32 -0700
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
Subject: [RFC PATCH 10/13] x86/uintr: Introduce user IPI sender syscalls
Date:   Mon, 13 Sep 2021 13:01:29 -0700
Message-Id: <20210913200132.3396598-11-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a registration syscall for a task to register itself as a user
interrupt sender using the uintr_fd generated by the receiver. A task
can register multiple uintr_fds. Each unique successful connection
creates a new entry in the User Interrupt Target Table (UITT).

Each entry in the UITT table is referred by the UITT index (uipi_index).
The uipi_index returned during the registration syscall lets a sender
generate a user IPI using the 'SENDUIPI <uipi_index>' instruction.

Also, add a sender unregister syscall to unregister a particular task
from the uintr_fd. Calling close on the uintr_fd will disconnect all
threads in a sender process from that FD.

Currently, the UITT size is arbitrarily chosen as 256 entries
corresponding to a 4KB page. Based on feedback and usage data this can
either be increased/decreased or made dynamic later.

Architecturally, the UITT table can be unique for each thread or shared
across threads of the same thread group. The current implementation
keeps the UITT as unique for the each thread. This makes the kernel
implementation relatively simple and only threads that use uintr get
setup with the related structures. However, this means that the
uipi_index for each thread would be inconsistent wrt to other threads.
(Executing 'SENDUIPI 2' on threads of the same process could generate
different user interrupts.)

Alternatively, the benefit of sharing the UITT table is that all threads
would see the same view of the UITT table. Also the kernel UITT memory
allocation would be more efficient if multiple threads connect to the
same uintr_fd. However, this would mean the kernel needs to keep the
UITT table size MISC_MSR[] in sync across these threads. Also the
UPID/UITT teardown flows might need additional consideration.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/processor.h |   2 +
 arch/x86/include/asm/uintr.h     |  15 ++
 arch/x86/kernel/process.c        |   1 +
 arch/x86/kernel/uintr_core.c     | 355 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/uintr_fd.c       | 133 ++++++++++++
 5 files changed, 495 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d229bfac8b4f..3482c3182e39 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -10,6 +10,7 @@ struct mm_struct;
 struct io_bitmap;
 struct vm86;
 struct uintr_receiver;
+struct uintr_sender;
 
 #include <asm/math_emu.h>
 #include <asm/segment.h>
@@ -533,6 +534,7 @@ struct thread_struct {
 #ifdef CONFIG_X86_USER_INTERRUPTS
 	/* User Interrupt state*/
 	struct uintr_receiver	*ui_recv;
+	struct uintr_sender	*ui_send;
 #endif
 
 	/* Floating point and extended processor state */
diff --git a/arch/x86/include/asm/uintr.h b/arch/x86/include/asm/uintr.h
index 1f00e2a63da4..ef3521dd7fb9 100644
--- a/arch/x86/include/asm/uintr.h
+++ b/arch/x86/include/asm/uintr.h
@@ -8,6 +8,7 @@ struct uintr_upid_ctx {
 	struct task_struct *task;	/* Receiver task */
 	struct uintr_upid *upid;
 	refcount_t refs;
+	bool receiver_active;		/* Flag for UPID being mapped to a receiver */
 };
 
 struct uintr_receiver_info {
@@ -16,12 +17,26 @@ struct uintr_receiver_info {
 	u64 uvec;				/* Vector number */
 };
 
+struct uintr_sender_info {
+	struct list_head node;
+	struct uintr_uitt_ctx *uitt_ctx;
+	struct task_struct *task;
+	struct uintr_upid_ctx *r_upid_ctx;	/* Receiver's UPID context */
+	struct callback_head twork;		/* Task work head */
+	unsigned int uitt_index;
+};
+
 bool uintr_arch_enabled(void);
 int do_uintr_register_handler(u64 handler);
 int do_uintr_unregister_handler(void);
 int do_uintr_register_vector(struct uintr_receiver_info *r_info);
 void do_uintr_unregister_vector(struct uintr_receiver_info *r_info);
 
+int do_uintr_register_sender(struct uintr_receiver_info *r_info,
+			     struct uintr_sender_info *s_info);
+void do_uintr_unregister_sender(struct uintr_receiver_info *r_info,
+				struct uintr_sender_info *s_info);
+
 void uintr_free(struct task_struct *task);
 
 /* TODO: Inline the context switch related functions */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 83677f76bd7b..9db33e467b30 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -92,6 +92,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_X86_USER_INTERRUPTS
 	/* User Interrupt state is unique for each task */
 	dst->thread.ui_recv = NULL;
+	dst->thread.ui_send = NULL;
 #endif
 
 	return fpu_clone(dst);
diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
index 9dcb9f60e5bc..8f331c5fe0cf 100644
--- a/arch/x86/kernel/uintr_core.c
+++ b/arch/x86/kernel/uintr_core.c
@@ -21,6 +21,11 @@
 #include <asm/msr-index.h>
 #include <asm/uintr.h>
 
+/*
+ * Each UITT entry is 16 bytes in size.
+ * Current UITT table size is set as 4KB (256 * 16 bytes)
+ */
+#define UINTR_MAX_UITT_NR 256
 #define UINTR_MAX_UVEC_NR 64
 
 /* User Posted Interrupt Descriptor (UPID) */
@@ -44,6 +49,27 @@ struct uintr_receiver {
 	u64 uvec_mask;	/* track active vector per bit */
 };
 
+/* User Interrupt Target Table Entry (UITTE) */
+struct uintr_uitt_entry {
+	u8	valid;			/* bit 0: valid, bit 1-7: reserved */
+	u8	user_vec;
+	u8	reserved[6];
+	u64	target_upid_addr;
+} __packed __aligned(16);
+
+struct uintr_uitt_ctx {
+	struct uintr_uitt_entry *uitt;
+	/* Protect UITT */
+	spinlock_t uitt_lock;
+	refcount_t refs;
+};
+
+struct uintr_sender {
+	struct uintr_uitt_ctx *uitt_ctx;
+	/* track active uitt entries per bit */
+	u64 uitt_mask[BITS_TO_U64(UINTR_MAX_UITT_NR)];
+};
+
 inline bool uintr_arch_enabled(void)
 {
 	return static_cpu_has(X86_FEATURE_UINTR);
@@ -54,6 +80,36 @@ static inline bool is_uintr_receiver(struct task_struct *t)
 	return !!t->thread.ui_recv;
 }
 
+static inline bool is_uintr_sender(struct task_struct *t)
+{
+	return !!t->thread.ui_send;
+}
+
+static inline bool is_uintr_task(struct task_struct *t)
+{
+	return(is_uintr_receiver(t) || is_uintr_sender(t));
+}
+
+static inline bool is_uitt_empty(struct task_struct *t)
+{
+	return !!bitmap_empty((unsigned long *)t->thread.ui_send->uitt_mask,
+			      UINTR_MAX_UITT_NR);
+}
+
+/*
+ * No lock is needed to read the active flag. Writes only happen from
+ * r_info->task that owns the UPID. Everyone else would just read this flag.
+ *
+ * This only provides a static check. The receiver may become inactive right
+ * after this check. The primary reason to have this check is to prevent future
+ * senders from connecting with this UPID, since the receiver task has already
+ * made this UPID inactive.
+ */
+static bool uintr_is_receiver_active(struct uintr_receiver_info *r_info)
+{
+	return r_info->upid_ctx->receiver_active;
+}
+
 static inline u32 cpu_to_ndst(int cpu)
 {
 	u32 apicid = (u32)apic->cpu_present_to_apicid(cpu);
@@ -94,6 +150,7 @@ static struct uintr_upid_ctx *alloc_upid(void)
 	upid_ctx->upid = upid;
 	refcount_set(&upid_ctx->refs, 1);
 	upid_ctx->task = get_task_struct(current);
+	upid_ctx->receiver_active = true;
 
 	return upid_ctx;
 }
@@ -110,6 +167,64 @@ static struct uintr_upid_ctx *get_upid_ref(struct uintr_upid_ctx *upid_ctx)
 	return upid_ctx;
 }
 
+static void free_uitt(struct uintr_uitt_ctx *uitt_ctx)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&uitt_ctx->uitt_lock, flags);
+	kfree(uitt_ctx->uitt);
+	uitt_ctx->uitt = NULL;
+	spin_unlock_irqrestore(&uitt_ctx->uitt_lock, flags);
+
+	kfree(uitt_ctx);
+}
+
+/* TODO: Replace UITT allocation with KPTI compatible memory allocator */
+static struct uintr_uitt_ctx *alloc_uitt(void)
+{
+	struct uintr_uitt_ctx *uitt_ctx;
+	struct uintr_uitt_entry *uitt;
+
+	uitt_ctx = kzalloc(sizeof(*uitt_ctx), GFP_KERNEL);
+	if (!uitt_ctx)
+		return NULL;
+
+	uitt = kzalloc(sizeof(*uitt) * UINTR_MAX_UITT_NR, GFP_KERNEL);
+	if (!uitt) {
+		kfree(uitt_ctx);
+		return NULL;
+	}
+
+	uitt_ctx->uitt = uitt;
+	spin_lock_init(&uitt_ctx->uitt_lock);
+	refcount_set(&uitt_ctx->refs, 1);
+
+	return uitt_ctx;
+}
+
+static void put_uitt_ref(struct uintr_uitt_ctx *uitt_ctx)
+{
+	if (refcount_dec_and_test(&uitt_ctx->refs))
+		free_uitt(uitt_ctx);
+}
+
+static struct uintr_uitt_ctx *get_uitt_ref(struct uintr_uitt_ctx *uitt_ctx)
+{
+	refcount_inc(&uitt_ctx->refs);
+	return uitt_ctx;
+}
+
+static inline void mark_uitte_invalid(struct uintr_sender_info *s_info)
+{
+	struct uintr_uitt_entry *uitte;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s_info->uitt_ctx->uitt_lock, flags);
+	uitte = &s_info->uitt_ctx->uitt[s_info->uitt_index];
+	uitte->valid = 0;
+	spin_unlock_irqrestore(&s_info->uitt_ctx->uitt_lock, flags);
+}
+
 static void __clear_vector_from_upid(u64 uvec, struct uintr_upid *upid)
 {
 	clear_bit(uvec, (unsigned long *)&upid->puir);
@@ -175,6 +290,210 @@ static void receiver_clear_uvec(struct callback_head *head)
 	kfree(r_info);
 }
 
+static void teardown_uitt(void)
+{
+	struct task_struct *t = current;
+	struct fpu *fpu = &t->thread.fpu;
+	u64 msr64;
+
+	put_uitt_ref(t->thread.ui_send->uitt_ctx);
+	kfree(t->thread.ui_send);
+	t->thread.ui_send = NULL;
+
+	fpregs_lock();
+
+	if (fpregs_state_valid(fpu, smp_processor_id())) {
+		/* Modify only the relevant bits of the MISC MSR */
+		rdmsrl(MSR_IA32_UINTR_MISC, msr64);
+		msr64 &= GENMASK_ULL(63, 32);
+		wrmsrl(MSR_IA32_UINTR_MISC, msr64);
+		wrmsrl(MSR_IA32_UINTR_TT, 0ULL);
+	} else {
+		struct uintr_state *p;
+
+		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_UINTR);
+		if (p) {
+			p->uitt_size = 0;
+			p->uitt_addr = 0;
+		}
+	}
+
+	fpregs_unlock();
+}
+
+static int init_uitt(void)
+{
+	struct task_struct *t = current;
+	struct fpu *fpu = &t->thread.fpu;
+	struct uintr_sender *ui_send;
+	u64 msr64;
+
+	ui_send = kzalloc(sizeof(*t->thread.ui_send), GFP_KERNEL);
+	if (!ui_send)
+		return -ENOMEM;
+
+	ui_send->uitt_ctx = alloc_uitt();
+	if (!ui_send->uitt_ctx) {
+		pr_debug("send: Alloc UITT failed for task=%d\n", t->pid);
+		kfree(ui_send);
+		return -ENOMEM;
+	}
+
+	fpregs_lock();
+
+	if (fpregs_state_valid(fpu, smp_processor_id())) {
+		wrmsrl(MSR_IA32_UINTR_TT, (u64)ui_send->uitt_ctx->uitt | 1);
+		/* Modify only the relevant bits of the MISC MSR */
+		rdmsrl(MSR_IA32_UINTR_MISC, msr64);
+		msr64 &= GENMASK_ULL(63, 32);
+		msr64 |= UINTR_MAX_UITT_NR;
+		wrmsrl(MSR_IA32_UINTR_MISC, msr64);
+	} else {
+		struct xregs_state *xsave;
+		struct uintr_state *p;
+
+		xsave = &fpu->state.xsave;
+		xsave->header.xfeatures |= XFEATURE_MASK_UINTR;
+		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_UINTR);
+		if (p) {
+			p->uitt_size = UINTR_MAX_UITT_NR;
+			p->uitt_addr = (u64)ui_send->uitt_ctx->uitt | 1;
+		}
+	}
+
+	fpregs_unlock();
+
+	pr_debug("send: Setup a new UITT=%px for task=%d with size %d\n",
+		 ui_send->uitt_ctx->uitt, t->pid, UINTR_MAX_UITT_NR * 16);
+
+	t->thread.ui_send = ui_send;
+
+	return 0;
+}
+
+static void __free_uitt_entry(unsigned int entry)
+{
+	struct task_struct *t = current;
+	unsigned long flags;
+
+	if (entry >= UINTR_MAX_UITT_NR)
+		return;
+
+	if (!is_uintr_sender(t))
+		return;
+
+	pr_debug("send: Freeing UITTE entry %d for task=%d\n", entry, t->pid);
+
+	spin_lock_irqsave(&t->thread.ui_send->uitt_ctx->uitt_lock, flags);
+	memset(&t->thread.ui_send->uitt_ctx->uitt[entry], 0,
+	       sizeof(struct uintr_uitt_entry));
+	spin_unlock_irqrestore(&t->thread.ui_send->uitt_ctx->uitt_lock, flags);
+
+	clear_bit(entry, (unsigned long *)t->thread.ui_send->uitt_mask);
+
+	if (is_uitt_empty(t)) {
+		pr_debug("send: UITT mask is empty. Dereference and teardown UITT\n");
+		teardown_uitt();
+	}
+}
+
+static void sender_free_uitte(struct callback_head *head)
+{
+	struct uintr_sender_info *s_info;
+
+	s_info = container_of(head, struct uintr_sender_info, twork);
+
+	__free_uitt_entry(s_info->uitt_index);
+	put_uitt_ref(s_info->uitt_ctx);
+	put_upid_ref(s_info->r_upid_ctx);
+	put_task_struct(s_info->task);
+	kfree(s_info);
+}
+
+void do_uintr_unregister_sender(struct uintr_receiver_info *r_info,
+				struct uintr_sender_info *s_info)
+{
+	int ret;
+
+	/*
+	 * To make sure any new senduipi result in a #GP fault.
+	 * The task work might take non-zero time to kick the process out.
+	 */
+	mark_uitte_invalid(s_info);
+
+	pr_debug("send: Adding Free UITTE %d task work for task=%d\n",
+		 s_info->uitt_index, s_info->task->pid);
+
+	init_task_work(&s_info->twork, sender_free_uitte);
+	ret = task_work_add(s_info->task, &s_info->twork, true);
+	if (ret) {
+		/*
+		 * Dereferencing the UITT and UPID here since the task has
+		 * exited.
+		 */
+		pr_debug("send: Free UITTE %d task=%d has already exited\n",
+			 s_info->uitt_index, s_info->task->pid);
+		put_upid_ref(s_info->r_upid_ctx);
+		put_uitt_ref(s_info->uitt_ctx);
+		put_task_struct(s_info->task);
+		kfree(s_info);
+		return;
+	}
+}
+
+int do_uintr_register_sender(struct uintr_receiver_info *r_info,
+			     struct uintr_sender_info *s_info)
+{
+	struct uintr_uitt_entry *uitte = NULL;
+	struct uintr_sender *ui_send;
+	struct task_struct *t = current;
+	unsigned long flags;
+	int entry;
+	int ret;
+
+	/*
+	 * Only a static check. Receiver could exit anytime after this check.
+	 * This check only prevents connections using uintr_fd after the
+	 * receiver has already exited/unregistered.
+	 */
+	if (!uintr_is_receiver_active(r_info))
+		return -ESHUTDOWN;
+
+	if (is_uintr_sender(t)) {
+		entry = find_first_zero_bit((unsigned long *)t->thread.ui_send->uitt_mask,
+					    UINTR_MAX_UITT_NR);
+		if (entry >= UINTR_MAX_UITT_NR)
+			return -ENOSPC;
+	} else {
+		BUILD_BUG_ON(UINTR_MAX_UITT_NR < 1);
+		entry = 0;
+		ret = init_uitt();
+		if (ret)
+			return ret;
+	}
+
+	ui_send = t->thread.ui_send;
+
+	set_bit(entry, (unsigned long *)ui_send->uitt_mask);
+
+	spin_lock_irqsave(&ui_send->uitt_ctx->uitt_lock, flags);
+	uitte = &ui_send->uitt_ctx->uitt[entry];
+	pr_debug("send: sender=%d receiver=%d UITTE entry %d address %px\n",
+		 current->pid, r_info->upid_ctx->task->pid, entry, uitte);
+
+	uitte->user_vec = r_info->uvec;
+	uitte->target_upid_addr = (u64)r_info->upid_ctx->upid;
+	uitte->valid = 1;
+	spin_unlock_irqrestore(&ui_send->uitt_ctx->uitt_lock, flags);
+
+	s_info->r_upid_ctx = get_upid_ref(r_info->upid_ctx);
+	s_info->uitt_ctx = get_uitt_ref(ui_send->uitt_ctx);
+	s_info->task = get_task_struct(current);
+	s_info->uitt_index = entry;
+
+	return 0;
+}
+
 int do_uintr_unregister_handler(void)
 {
 	struct task_struct *t = current;
@@ -222,6 +541,8 @@ int do_uintr_unregister_handler(void)
 	}
 
 	ui_recv = t->thread.ui_recv;
+	ui_recv->upid_ctx->receiver_active = false;
+
 	/*
 	 * Suppress notifications so that no further interrupts are generated
 	 * based on this UPID.
@@ -437,14 +758,14 @@ void switch_uintr_return(void)
  * This should only be called from exit_thread().
  * exit_thread() can happen in current context when the current thread is
  * exiting or it can happen for a new thread that is being created.
- * For new threads is_uintr_receiver() should fail.
+ * For new threads is_uintr_task() should fail.
  */
 void uintr_free(struct task_struct *t)
 {
 	struct uintr_receiver *ui_recv;
 	struct fpu *fpu;
 
-	if (!static_cpu_has(X86_FEATURE_UINTR) || !is_uintr_receiver(t))
+	if (!static_cpu_has(X86_FEATURE_UINTR) || !is_uintr_task(t))
 		return;
 
 	if (WARN_ON_ONCE(t != current))
@@ -456,6 +777,7 @@ void uintr_free(struct task_struct *t)
 
 	if (fpregs_state_valid(fpu, smp_processor_id())) {
 		wrmsrl(MSR_IA32_UINTR_MISC, 0ULL);
+		wrmsrl(MSR_IA32_UINTR_TT, 0ULL);
 		wrmsrl(MSR_IA32_UINTR_PD, 0ULL);
 		wrmsrl(MSR_IA32_UINTR_RR, 0ULL);
 		wrmsrl(MSR_IA32_UINTR_STACKADJUST, 0ULL);
@@ -470,20 +792,31 @@ void uintr_free(struct task_struct *t)
 			p->upid_addr = 0;
 			p->stack_adjust = 0;
 			p->uinv = 0;
+			p->uitt_addr = 0;
+			p->uitt_size = 0;
 		}
 	}
 
 	/* Check: Can a thread be context switched while it is exiting? */
-	ui_recv = t->thread.ui_recv;
+	if (is_uintr_receiver(t)) {
+		ui_recv = t->thread.ui_recv;
 
-	/*
-	 * Suppress notifications so that no further interrupts are
-	 * generated based on this UPID.
-	 */
-	set_bit(UPID_SN, (unsigned long *)&ui_recv->upid_ctx->upid->nc.status);
-	put_upid_ref(ui_recv->upid_ctx);
-	kfree(ui_recv);
-	t->thread.ui_recv = NULL;
+		/*
+		 * Suppress notifications so that no further interrupts are
+		 * generated based on this UPID.
+		 */
+		set_bit(UPID_SN, (unsigned long *)&ui_recv->upid_ctx->upid->nc.status);
+		ui_recv->upid_ctx->receiver_active = false;
+		put_upid_ref(ui_recv->upid_ctx);
+		kfree(ui_recv);
+		t->thread.ui_recv = NULL;
+	}
 
 	fpregs_unlock();
+
+	if (is_uintr_sender(t)) {
+		put_uitt_ref(t->thread.ui_send->uitt_ctx);
+		kfree(t->thread.ui_send);
+		t->thread.ui_send = NULL;
+	}
 }
diff --git a/arch/x86/kernel/uintr_fd.c b/arch/x86/kernel/uintr_fd.c
index f0548bbac776..3c82c032c0b9 100644
--- a/arch/x86/kernel/uintr_fd.c
+++ b/arch/x86/kernel/uintr_fd.c
@@ -15,6 +15,9 @@
 
 struct uintrfd_ctx {
 	struct uintr_receiver_info *r_info;
+	/* Protect sender_list */
+	spinlock_t sender_lock;
+	struct list_head sender_list;
 };
 
 #ifdef CONFIG_PROC_FS
@@ -30,11 +33,20 @@ static void uintrfd_show_fdinfo(struct seq_file *m, struct file *file)
 static int uintrfd_release(struct inode *inode, struct file *file)
 {
 	struct uintrfd_ctx *uintrfd_ctx = file->private_data;
+	struct uintr_sender_info *s_info, *tmp;
+	unsigned long flags;
 
 	pr_debug("recv: Release uintrfd for r_task %d uvec %llu\n",
 		 uintrfd_ctx->r_info->upid_ctx->task->pid,
 		 uintrfd_ctx->r_info->uvec);
 
+	spin_lock_irqsave(&uintrfd_ctx->sender_lock, flags);
+	list_for_each_entry_safe(s_info, tmp, &uintrfd_ctx->sender_list, node) {
+		list_del(&s_info->node);
+		do_uintr_unregister_sender(uintrfd_ctx->r_info, s_info);
+	}
+	spin_unlock_irqrestore(&uintrfd_ctx->sender_lock, flags);
+
 	do_uintr_unregister_vector(uintrfd_ctx->r_info);
 	kfree(uintrfd_ctx);
 
@@ -81,6 +93,9 @@ SYSCALL_DEFINE2(uintr_create_fd, u64, vector, unsigned int, flags)
 		goto out_free_ctx;
 	}
 
+	INIT_LIST_HEAD(&uintrfd_ctx->sender_list);
+	spin_lock_init(&uintrfd_ctx->sender_lock);
+
 	/* TODO: Get user input for flags - UFD_CLOEXEC */
 	/* Check: Do we need O_NONBLOCK? */
 	uintrfd = anon_inode_getfd("[uintrfd]", &uintrfd_fops, uintrfd_ctx,
@@ -150,3 +165,121 @@ SYSCALL_DEFINE1(uintr_unregister_handler, unsigned int, flags)
 
 	return ret;
 }
+
+/*
+ * sys_uintr_register_sender - setup user inter-processor interrupt sender.
+ */
+SYSCALL_DEFINE2(uintr_register_sender, int, uintrfd, unsigned int, flags)
+{
+	struct uintr_sender_info *s_info;
+	struct uintrfd_ctx *uintrfd_ctx;
+	unsigned long lock_flags;
+	struct file *uintr_f;
+	struct fd f;
+	int ret = 0;
+
+	if (!uintr_arch_enabled())
+		return -EOPNOTSUPP;
+
+	if (flags)
+		return -EINVAL;
+
+	f = fdget(uintrfd);
+	uintr_f = f.file;
+	if (!uintr_f)
+		return -EBADF;
+
+	if (uintr_f->f_op != &uintrfd_fops) {
+		ret = -EOPNOTSUPP;
+		goto out_fdput;
+	}
+
+	uintrfd_ctx = (struct uintrfd_ctx *)uintr_f->private_data;
+
+	spin_lock_irqsave(&uintrfd_ctx->sender_lock, lock_flags);
+	list_for_each_entry(s_info, &uintrfd_ctx->sender_list, node) {
+		if (s_info->task == current) {
+			ret = -EISCONN;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&uintrfd_ctx->sender_lock, lock_flags);
+
+	if (ret)
+		goto out_fdput;
+
+	s_info = kzalloc(sizeof(*s_info), GFP_KERNEL);
+	if (!s_info) {
+		ret = -ENOMEM;
+		goto out_fdput;
+	}
+
+	ret = do_uintr_register_sender(uintrfd_ctx->r_info, s_info);
+	if (ret) {
+		kfree(s_info);
+		goto out_fdput;
+	}
+
+	spin_lock_irqsave(&uintrfd_ctx->sender_lock, lock_flags);
+	list_add(&s_info->node, &uintrfd_ctx->sender_list);
+	spin_unlock_irqrestore(&uintrfd_ctx->sender_lock, lock_flags);
+
+	ret = s_info->uitt_index;
+
+out_fdput:
+	pr_debug("send: register sender task=%d flags %d ret(uipi_id)=%d\n",
+		 current->pid, flags, ret);
+
+	fdput(f);
+	return ret;
+}
+
+/*
+ * sys_uintr_unregister_sender - Unregister user inter-processor interrupt sender.
+ */
+SYSCALL_DEFINE2(uintr_unregister_sender, int, uintrfd, unsigned int, flags)
+{
+	struct uintr_sender_info *s_info;
+	struct uintrfd_ctx *uintrfd_ctx;
+	struct file *uintr_f;
+	unsigned long lock_flags;
+	struct fd f;
+	int ret;
+
+	if (!uintr_arch_enabled())
+		return -EOPNOTSUPP;
+
+	if (flags)
+		return -EINVAL;
+
+	f = fdget(uintrfd);
+	uintr_f = f.file;
+	if (!uintr_f)
+		return -EBADF;
+
+	if (uintr_f->f_op != &uintrfd_fops) {
+		ret = -EOPNOTSUPP;
+		goto out_fdput;
+	}
+
+	uintrfd_ctx = (struct uintrfd_ctx *)uintr_f->private_data;
+
+	ret = -EINVAL;
+	spin_lock_irqsave(&uintrfd_ctx->sender_lock, lock_flags);
+	list_for_each_entry(s_info, &uintrfd_ctx->sender_list, node) {
+		if (s_info->task == current) {
+			ret = 0;
+			list_del(&s_info->node);
+			do_uintr_unregister_sender(uintrfd_ctx->r_info, s_info);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&uintrfd_ctx->sender_lock, lock_flags);
+
+	pr_debug("send: unregister sender uintrfd %d for task=%d ret %d\n",
+		 uintrfd, current->pid, ret);
+
+out_fdput:
+	fdput(f);
+	return ret;
+}
-- 
2.33.0

