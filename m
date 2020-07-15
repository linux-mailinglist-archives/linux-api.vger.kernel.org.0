Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5440D220CF8
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgGOMdd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 08:33:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45772 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgGOMdd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 08:33:33 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvgbE-0004UJ-FS; Wed, 15 Jul 2020 12:33:24 +0000
Date:   Wed, 15 Jul 2020 14:33:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, carlos@redhat.com
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
Message-ID: <20200715123323.vrmblagnvkdp4pyy@wittgenstein>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
 <20200715113849.yy6amhynxya64arv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715113849.yy6amhynxya64arv@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 15, 2020 at 01:38:51PM +0200, Christian Brauner wrote:
> On Mon, Jul 13, 2020 at 11:03:46PM -0400, Mathieu Desnoyers wrote:
> > Add a __rseq_abi.flags "RSEQ_TLS_FLAG_SIZE", which indicates support for
> > extending struct rseq. This adds two new fields to struct rseq:
> > user_size and kernel_size.
> > 
> > The user_size field allows the size of the __rseq_abi definition (which
> > can be overridden by symbol interposition either by a preloaded library
> > or by the application) to be handed over to the kernel at registration.
> > This registration can be performed by a library, e.g. glibc, which does
> > not know there is interposition taking place.
> > 
> > The kernel_size is populated by the kernel when the "RSEQ_TLS_FLAG_SIZE"
> > flag is set in __rseq_abi.flags to the minimum between user_size and
> > the offset of the "end" field of struct rseq as known by the kernel.
> > This allows user-space to query which fields are effectively populated
> > by the kernel.
> > 
> > A rseq_size field is added to the task struct to keep track of the
> > "kernel_size" effective for each thread.
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > ---
> >  include/linux/sched.h     |  4 ++++
> >  include/uapi/linux/rseq.h | 37 ++++++++++++++++++++++++++++++++--
> >  kernel/rseq.c             | 42 +++++++++++++++++++++++++++++++++------
> >  3 files changed, 75 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 692e327d7455..5d61a3197987 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1147,6 +1147,7 @@ struct task_struct {
> >  #ifdef CONFIG_RSEQ
> >  	struct rseq __user *rseq;
> >  	u32 rseq_sig;
> > +	u32 rseq_size;
> >  	/*
> >  	 * RmW on rseq_event_mask must be performed atomically
> >  	 * with respect to preemption.
> > @@ -1976,10 +1977,12 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
> >  	if (clone_flags & CLONE_VM) {
> >  		t->rseq = NULL;
> >  		t->rseq_sig = 0;
> > +		t->rseq_size = 0;
> >  		t->rseq_event_mask = 0;
> >  	} else {
> >  		t->rseq = current->rseq;
> >  		t->rseq_sig = current->rseq_sig;
> > +		t->rseq_size = current->rseq_size;
> >  		t->rseq_event_mask = current->rseq_event_mask;
> >  	}
> >  }
> > @@ -1988,6 +1991,7 @@ static inline void rseq_execve(struct task_struct *t)
> >  {
> >  	t->rseq = NULL;
> >  	t->rseq_sig = 0;
> > +	t->rseq_size = 0;
> >  	t->rseq_event_mask = 0;
> >  }
> >  
> > diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> > index e11d9df5e564..03c0b5e9a859 100644
> > --- a/include/uapi/linux/rseq.h
> > +++ b/include/uapi/linux/rseq.h
> > @@ -37,6 +37,15 @@ enum rseq_cs_flags {
> >  		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
> >  };
> >  
> > +enum rseq_tls_flags_bit {
> > +	/* enum rseq_cs_flags reserves bits 0-2. */
> > +	RSEQ_TLS_FLAG_SIZE_BIT = 3,
> > +};
> > +
> > +enum rseq_tls_flags {
> > +	RSEQ_TLS_FLAG_SIZE = (1U << RSEQ_TLS_FLAG_SIZE_BIT),
> > +};
> > +
> >  /* The rseq_len expected by rseq registration is always 32 bytes. */
> >  enum rseq_len_expected {
> >  	RSEQ_LEN_EXPECTED = 32,
> > @@ -133,8 +142,9 @@ struct rseq {
> >  	 *
> >  	 * This field should only be updated by the thread which
> >  	 * registered this data structure. Read by the kernel.
> > -	 * Mainly used for single-stepping through rseq critical sections
> > -	 * with debuggers.
> > +	 *
> > +	 * The RSEQ_CS flags are mainly used for single-stepping through rseq
> > +	 * critical sections with debuggers.
> >  	 *
> >  	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> >  	 *     Inhibit instruction sequence block restart on preemption
> > @@ -145,8 +155,31 @@ struct rseq {
> >  	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> >  	 *     Inhibit instruction sequence block restart on migration for
> >  	 *     this thread.
> > +	 *
> > +	 * - RSEQ_TLS_FLAG_SIZE
> > +	 *     Extensible struct rseq ABI. This flag should be statically
> > +	 *     initialized.
> >  	 */
> >  	__u32 flags;
> > +	/*
> > +	 * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, user_size should be
> > +	 * statically initialized to offsetof(struct rseq, end).
> > +	 */
> > +	__u16 user_size;
> > +	/*
> > +	 * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, if the kernel supports
> > +	 * extensible struct rseq ABI, the kernel_size field is populated by
> > +	 * the kernel to the minimum between user_size and the offset of the
> > +	 * "end" field within the struct rseq supported by the kernel on
> > +	 * successful registration. Should be initialized to 0.
> > +	 */
> > +	__u16 kernel_size;
> 
> (Btw, this what I suggested - minus the user_size part - when I said
> "expose the size of struct rseq" the kernel knows about. The approach
> here is of course more general.)
> 
> It's pretty uncommon to use __u16 for sizes at least in public facing
> structs. I'd suggest to use __u32 user_size and __u32 kernel_size and if
> needed, insert padding. Seems you have done this in your union above
> already.
> 
> > +
> > +	/*
> > +	 * Very last field of the structure, to calculate size excluding padding
> > +	 * with offsetof().
> > +	 */
> > +	char end[];
> 
> Hm, could this mess with alignment or break making the struct
> extensible? Feels like you're adding new members always before this
> which is also pretty non-standard in terms of how we'd usually extend
> structs.
> 
> >  } __attribute__((aligned(4 * sizeof(__u64))));
> >  
> >  #endif /* _UAPI_LINUX_RSEQ_H */
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index a4f86a9d6937..bbc57fc18573 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -96,6 +96,7 @@ static int rseq_update_cpu_id(struct task_struct *t)
> >  static int rseq_reset_rseq_cpu_id(struct task_struct *t)
> >  {
> >  	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
> > +	u16 kernel_size = 0;
> >  
> >  	/*
> >  	 * Reset cpu_id_start to its initial state (0).
> > @@ -109,6 +110,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
> >  	 */
> >  	if (put_user(cpu_id, &t->rseq->cpu_id))
> >  		return -EFAULT;
> > +	/*
> > +	 * Reset kernel_size to its initial state (0).
> > +	 */
> > +	if (put_user(kernel_size, &t->rseq->kernel_size))
> > +		return -EFAULT;
> >  	return 0;
> >  }
> >  
> > @@ -266,7 +272,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >  
> >  	if (unlikely(t->flags & PF_EXITING))
> >  		return;
> > -	if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
> > +	if (unlikely(!access_ok(t->rseq, t->rseq_size)))
> >  		goto error;
> >  	ret = rseq_ip_fixup(regs);
> >  	if (unlikely(ret < 0))
> > @@ -294,7 +300,7 @@ void rseq_syscall(struct pt_regs *regs)
> >  
> >  	if (!t->rseq)
> >  		return;
> > -	if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
> > +	if (!access_ok(t->rseq, t->rseq_size) ||
> >  	    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
> >  		force_sig(SIGSEGV);
> >  }
> > @@ -308,6 +314,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
> >  		int, flags, u32, sig)
> >  {
> >  	int ret;
> > +	u32 tls_flags;
> >  
> >  	if (flags & RSEQ_FLAG_UNREGISTER) {
> >  		if (flags & ~RSEQ_FLAG_UNREGISTER)
> > @@ -315,7 +322,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
> >  		/* Unregister rseq for current thread. */
> >  		if (current->rseq != rseq || !current->rseq)
> >  			return -EINVAL;
> > -		if (rseq_len != sizeof(*rseq))
> > +		if (rseq_len != RSEQ_LEN_EXPECTED)
> 
> So I have to say that I think it's not a great to fix the length of the
> rseq_len argument basically making it somewhat a nop. If I recall
> correctly Florian said something about the rseq_len becoming part of the
> glibc abi and that's why it can't be changed?
> Is there any way we can avoid that so we can use the rseq_len argument
> to have userspace pass down the size of struct rseq they know about?
> 
> It's really unintuitive to pass down an extensible struct but the length
> argument associated with it is fixed.
> 
> I also think there should be some compile-time sanity checks here
> similar to what we do in other places see e.g.
> 
> 	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
> 
> So here should at least be sm like:
> 
> 	BUILD_BUG_ON(sizeof(struct rseq) != RSEQ_LEN_EXPECTED);
> 

So here's a very free-wheeling draft of roughly what I had in mind. Not
even compile-tested just to illustrate what I'd change and sorry if that
code will make you sob in your hands:

From 2879e3c30dbe6ba0fc53884b1c41deaa444924a8 Mon Sep 17 00:00:00 2001
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Mon, 13 Jul 2020 23:03:46 -0400
Subject: [PATCH] [UNTESTED] rseq: Allow extending struct rseq

Add a __rseq_abi.flags "RSEQ_TLS_FLAG_SIZE", which indicates support for
extending struct rseq. This adds two new fields to struct rseq:
user_size and kernel_size.

The user_size field allows the size of the __rseq_abi definition (which
can be overridden by symbol interposition either by a preloaded library
or by the application) to be handed over to the kernel at registration.
This registration can be performed by a library, e.g. glibc, which does
not know there is interposition taking place.

The kernel_size is populated by the kernel when the "RSEQ_TLS_FLAG_SIZE"
flag is set in __rseq_abi.flags to the minimum between user_size and
the offset of the "end" field of struct rseq as known by the kernel.
This allows user-space to query which fields are effectively populated
by the kernel.

A rseq_size field is added to the task struct to keep track of the
"kernel_size" effective for each thread.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/sched.h     |  4 +++
 include/uapi/linux/rseq.h | 36 ++++++++++++++++++--
 kernel/rseq.c             | 72 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..5d61a3197987 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1147,6 +1147,7 @@ struct task_struct {
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
 	u32 rseq_sig;
+	u32 rseq_size;
 	/*
 	 * RmW on rseq_event_mask must be performed atomically
 	 * with respect to preemption.
@@ -1976,10 +1977,12 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 	if (clone_flags & CLONE_VM) {
 		t->rseq = NULL;
 		t->rseq_sig = 0;
+		t->rseq_size = 0;
 		t->rseq_event_mask = 0;
 	} else {
 		t->rseq = current->rseq;
 		t->rseq_sig = current->rseq_sig;
+		t->rseq_size = current->rseq_size;
 		t->rseq_event_mask = current->rseq_event_mask;
 	}
 }
@@ -1988,6 +1991,7 @@ static inline void rseq_execve(struct task_struct *t)
 {
 	t->rseq = NULL;
 	t->rseq_sig = 0;
+	t->rseq_size = 0;
 	t->rseq_event_mask = 0;
 }
 
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 9a402fdb60e9..f10ce38d9712 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -37,6 +37,15 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 };
 
+enum rseq_tls_flags_bit {
+	/* enum rseq_cs_flags reserves bits 0-2. */
+	RSEQ_TLS_FLAG_SIZE_BIT = 3,
+};
+
+enum rseq_tls_flags {
+	RSEQ_TLS_FLAG_SIZE = (1U << RSEQ_TLS_FLAG_SIZE_BIT),
+};
+
 /*
  * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line. It is usually declared as
@@ -128,8 +137,9 @@ struct rseq {
 	 *
 	 * This field should only be updated by the thread which
 	 * registered this data structure. Read by the kernel.
-	 * Mainly used for single-stepping through rseq critical sections
-	 * with debuggers.
+	 *
+	 * The RSEQ_CS flags are mainly used for single-stepping through rseq
+	 * critical sections with debuggers.
 	 *
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
 	 *     Inhibit instruction sequence block restart on preemption
@@ -140,8 +150,30 @@ struct rseq {
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
 	 *     Inhibit instruction sequence block restart on migration for
 	 *     this thread.
+	 *
+	 * - RSEQ_TLS_FLAG_SIZE
+	 *     Extensible struct rseq ABI. This flag should be statically
+	 *     initialized.
 	 */
 	__u32 flags;
+	/*
+	 * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, user_size should be
+	 * statically initialized to offsetof(struct rseq, end).
+	 */
+	__u32 user_size;
+	/*
+	 * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, if the kernel supports
+	 * extensible struct rseq ABI, the kernel_size field is populated by
+	 * the kernel to the minimum between user_size and the offset of the
+	 * "end" field within the struct rseq supported by the kernel on
+	 * successful registration. Should be initialized to 0.
+	 */
+	__u32 kernel_size;
+	__u32 active_size;
 } __attribute__((aligned(4 * sizeof(__u64))));
 
+#define RSEQ_SIZE_VER0 24 /* sizeof first published struct */
+#define RSEQ_SIZE_VER1 32 /* sizeof second published struct */
+#define RSEQ_SIZE_LATEST RSEQ_SIZE_VER1 /* sizeof last published struct */
+
 #endif /* _UAPI_LINUX_RSEQ_H */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937..9d28b41a99cd 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -96,6 +96,7 @@ static int rseq_update_cpu_id(struct task_struct *t)
 static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 {
 	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+	u16 kernel_size = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -109,6 +110,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	 */
 	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
+	/*
+	 * Reset kernel_size to its initial state (0).
+	 */
+	if (put_user(kernel_size, &t->rseq->kernel_size))
+		return -EFAULT;
 	return 0;
 }
 
@@ -266,7 +272,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
-	if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
+	if (unlikely(!access_ok(t->rseq, t->rseq_size)))
 		goto error;
 	ret = rseq_ip_fixup(regs);
 	if (unlikely(ret < 0))
@@ -294,7 +300,7 @@ void rseq_syscall(struct pt_regs *regs)
 
 	if (!t->rseq)
 		return;
-	if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
+	if (!access_ok(t->rseq, t->rseq_size) ||
 	    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
 		force_sig(SIGSEGV);
 }
@@ -308,6 +314,11 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		int, flags, u32, sig)
 {
 	int ret;
+	u32 tls_flags;
+
+	BUILD_BUG_ON(offsetofend(struct rseq, flags) != RSEQ_SIZE_VER0);
+	BUILD_BUG_ON(offsetofend(struct rseq, active_size) != RSEQ_SIZE_VER1);
+	BUILD_BUG_ON(sizeof(struct rseq) != RSEQ_SIZE_LATEST);
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -315,14 +326,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-		if (rseq_len != sizeof(*rseq))
+		if (rseq_len < RSEQ_SIZE_VER0)
 			return -EINVAL;
+		if (!access_ok(rseq, rseq_len))
+			return -EFAULT;
 		if (current->rseq_sig != sig)
 			return -EPERM;
 		ret = rseq_reset_rseq_cpu_id(current);
 		if (ret)
 			return ret;
 		current->rseq = NULL;
+		current->rseq_size = 0;
 		current->rseq_sig = 0;
 		return 0;
 	}
@@ -336,7 +350,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+		if (current->rseq != rseq || rseq_len != RSEQ_LEN_EXPECTED)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -349,10 +363,58 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	 * ensure the provided rseq is properly aligned and valid.
 	 */
 	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
-	    rseq_len != sizeof(*rseq))
+	    rseq_len < RSEQ_SIZE_VER0)
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+
+	/* Handle extensible struct rseq ABI. */
+	ret = get_user(tls_flags, &rseq->flags);
+	if (ret)
+		return ret;
+	if (tls_flags & RSEQ_TLS_FLAG_SIZE) {
+		u32 user_size, kernel_size, active_size;
+
+		/* Can probably be made nicer by using check_zeroed_user(). */
+		ret = get_user(user_size, &rseq->user_size);
+		if (ret)
+			return ret;
+		if (user_size != 0)
+			return -EINVAL;
+
+		ret = get_user(active_size, &rseq->active_size);
+		if (ret)
+			return ret;
+		if (active_size != 0)
+			return -EINVAL;
+
+		ret = get_user(active_size, &rseq->kernel_size);
+		if (ret)
+			return ret;
+		if (kernel_size != 0)
+			return -EINVAL;
+
+		/* Calculate the useable size. */
+		active_size = min_t(u32, rseq_len, RSEQ_SIZE_LATEST);
+		ret = put_user(active_size, &rseq->active_size);
+		if (ret)
+			return ret;
+
+		/* Let other users know what userspace used to register. */
+		ret = put_user(rseq_len, &rseq->user_size);
+		if (ret)
+			return -EFAULT;
+
+		/* Let other users know what size the kernel supports. */
+		ret = put_user(RSEQ_SIZE_LATEST, &rseq->kernel_size);
+		if (ret)
+			return -EFAULT;
+
+		current->rseq_size = active_size;
+	} else {
+		current->rseq_size = RSEQ_SIZE_VER0;
+	}
+
 	current->rseq = rseq;
 	current->rseq_sig = sig;
 	/*
-- 
2.27.0



