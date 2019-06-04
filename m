Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D434CEB
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfFDQKC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 12:10:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54168 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfFDQKB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 12:10:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so665078wmb.3
        for <linux-api@vger.kernel.org>; Tue, 04 Jun 2019 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Te8wg6ugfyHac0jQO2RG87GED4UWrp9MEIgEMaPvrSY=;
        b=TIUVqn4uarAgU20bG4LQ9bRfzLDZLL9ByXyaxaT9c9s9HKGSX/qlRwlIs5FigDKPbU
         BifiPYsZIow4UY60UC4EAWtzgh7YI4BjPDzut+jre2qpfdmyA3BnHTjkV/jui5/p6Ids
         8wEAt71FO4sdmGhsn+hcCDLYFKlBtGW8yMUa3DrBgWTZmrMZ99nJFwDXO7Z+NN+qqicD
         SfmSTvWT/GaxEn3XylN3vioATzRtH/1EFqPymrEYopjRV8PqfSuPJB9XKKJa0B+IhVxv
         E55QQ4NLPpDqa9YoICbI4ukiamSL9qPrRRuu7igHtOcUkH4vX88to5eTduHtNRMTjlTJ
         jVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Te8wg6ugfyHac0jQO2RG87GED4UWrp9MEIgEMaPvrSY=;
        b=sGVftsZAy6J8jwRrsXZOHUdLM5u/ecknBRaj3+jCQ8ehHx4Hbn0nIed3tVu2r69/QO
         5xcpIC21QApAh5mnJCXM0KHGyCbjJTtI+yz6RVWLec51VEkamvYF0wdArwzMm7dcZMTY
         51n1SQV92MKhLQEgIcfwxes/njuj7GzVqBjXCZobT1Fvym2YVpTLMX4O0TA9eL9A6IoX
         pO5B8Ht91ubTRvE1HiBZvDU9It34xLP/7Oy3G07UOEdRaf/V1UbU//PcQXXaDK2LNVid
         E3kjKUybp857J4c8T3uYsfh0TWbwoKIxTDsq/yLhojtX00OIs7Lnn0z4K3oogvZnoFqs
         eGzw==
X-Gm-Message-State: APjAAAUS/QCVfX7iCJz7dV3goco/OZMQ2nen1RYflIcyb0VuPAae7HMY
        zq7e6USePZUsvXLoh0FAdOttxA==
X-Google-Smtp-Source: APXvYqyfnkOwwQpiE6m6bKeEjgGIfEBqbBxJfoFPjXLK2D8PpF98KLK0Y1LuzzINgKq5d0q/p4zJYg==
X-Received: by 2002:a1c:9c4d:: with SMTP id f74mr6718011wme.156.1559664597217;
        Tue, 04 Jun 2019 09:09:57 -0700 (PDT)
Received: from localhost.localdomain (p548C9938.dip0.t-ipconnect.de. [84.140.153.56])
        by smtp.gmail.com with ESMTPSA id e6sm10578055wrw.83.2019.06.04.09.09.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 09:09:56 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com
Cc:     keescook@chromium.org, fweimer@redhat.com, oleg@redhat.com,
        arnd@arndb.de, dhowells@redhat.com,
        Christian Brauner <christian@brauner.io>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
Subject: [PATCH v3 1/2] fork: add clone3
Date:   Tue,  4 Jun 2019 18:09:43 +0200
Message-Id: <20190604160944.4058-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This adds the clone3 system call.

As mentioned several times already (cf. [7], [8]) here's the promised
patchset for clone3().

We recently merged the CLONE_PIDFD patchset (cf. [1]). It took the last
free flag from clone().

Independent of the CLONE_PIDFD patchset a time namespace has been discussed
at Linux Plumber Conference last year and has been sent out and reviewed
(cf. [5]). It is expected that it will go upstream in the not too distant
future. However, it relies on the addition of the CLONE_NEWTIME flag to
clone(). The only other good candidate - CLONE_DETACHED - is currently not
recyclable as we have identified at least two large or widely used
codebases that currently pass this flag (cf. [2], [3], and [4]). Given that
CLONE_PIDFD grabbed the last clone() flag the time namespace is effectively
blocked. clone3() has the advantage that it will unblock this patchset
again. In general, clone3() is extensible and allows for the implementation
of new features.

The idea is to keep clone3() very simple and close to the original clone(),
specifically, to keep on supporting old clone()-based workloads.
We know there have been various creative proposals how a new process
creation syscall or even api is supposed to look like. Some people even
going so far as to argue that the traditional fork()+exec() split should be
abandoned in favor of an in-kernel version of spawn(). Independent of
whether or not we personally think spawn() is a good idea this patchset has
and does not want to have anything to do with this.
One stance we take is that there's no real good alternative to
clone()+exec() and we need and want to support this model going forward;
independent of spawn().
The following requirements guided clone3():
- bump the number of available flags
- move arguments that are currently passed as separate arguments
  in clone() into a dedicated struct clone_args
  - choose a struct layout that is easy to handle on 32 and on 64 bit
  - choose a struct layout that is extensible
  - give new flags that currently need to abuse another flag's dedicated
    return argument in clone() their own dedicated return argument
    (e.g. CLONE_PIDFD)
  - use a separate kernel internal struct kernel_clone_args that is
    properly typed according to current kernel conventions in fork.c and is
    different from  the uapi struct clone_args
- port _do_fork() to use kernel_clone_args so that all process creation
  syscalls such as fork(), vfork(), clone(), and clone3() behave identical
  (Arnd suggested, that we can probably also port do_fork() itself in a
   separate patchset.)
- ease of transition for userspace from clone() to clone3()
  This very much means that we do *not* remove functionality that userspace
  currently relies on as the latter is a good way of creating a syscall
  that won't be adopted.
- do not try to be clever or complex: keep clone3() as dumb as possible

In accordance with Linus suggestions (cf. [11]), clone3() has the following
signature:

/* uapi */
struct clone_args {
        __aligned_u64 flags;
        __aligned_u64 pidfd;
        __aligned_u64 child_tid;
        __aligned_u64 parent_tid;
        __aligned_u64 exit_signal;
        __aligned_u64 stack;
        __aligned_u64 stack_size;
        __aligned_u64 tls;
};

/* kernel internal */
struct kernel_clone_args {
        u64 flags;
        int __user *pidfd;
        int __user *child_tid;
        int __user *parent_tid;
        int exit_signal;
        unsigned long stack;
        unsigned long stack_size;
        unsigned long tls;
};

long sys_clone3(struct clone_args __user *uargs, size_t size)

clone3() cleanly supports all of the supported flags from clone() and thus
all legacy workloads.
The advantage of sticking close to the old clone() is the low cost for
userspace to switch to this new api. Quite a lot of userspace apis (e.g.
pthreads) are based on the clone() syscall. With the new clone3() syscall
supporting all of the old workloads and opening up the ability to add new
features should make switching to it for userspace more appealing. In
essence, glibc can just write a simple wrapper to switch from clone() to
clone3().

There has been some interest in this patchset already. We have received a
patch from the CRIU corner for clone3() that would set the PID/TID of a
restored process without /proc/sys/kernel/ns_last_pid to eliminate a race.

/* User visible differences to legacy clone() */
- CLONE_DETACHED will cause EINVAL with clone3()
- CSIGNAL is deprecated
  It is superseeded by a dedicated "exit_signal" argument in struct
  clone_args freeing up space for additional flags.
  This is based on a suggestion from Andrei and Linus (cf. [9] and [10])

/* References */
[1]: b3e5838252665ee4cfa76b82bdf1198dca81e5be
[2]: https://dxr.mozilla.org/mozilla-central/source/security/sandbox/linux/SandboxFilter.cpp#343
[3]: https://git.musl-libc.org/cgit/musl/tree/src/thread/pthread_create.c#n233
[4]: https://sources.debian.org/src/blcr/0.8.5-2.3/cr_module/cr_dump_self.c/?hl=740#L740
[5]: https://lore.kernel.org/lkml/20190425161416.26600-1-dima@arista.com/
[6]: https://lore.kernel.org/lkml/20190425161416.26600-2-dima@arista.com/
[7]: https://lore.kernel.org/lkml/CAHrFyr5HxpGXA2YrKza-oB-GGwJCqwPfyhD-Y5wbktWZdt0sGQ@mail.gmail.com/
[8]: https://lore.kernel.org/lkml/20190524102756.qjsjxukuq2f4t6bo@brauner.io/
[9]: https://lore.kernel.org/lkml/20190529222414.GA6492@gmail.com/
[10]: https://lore.kernel.org/lkml/CAHk-=whQP-Ykxi=zSYaV9iXsHsENa+2fdj-zYKwyeyed63Lsfw@mail.gmail.com/
[11]: https://lore.kernel.org/lkml/CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Adrian Reber <adrian@lisas.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: linux-api@vger.kernel.org
---
v1:
- Linus Torvalds <torvalds@linux-foundation.org>:
  - redesign based on Linus proposal
  - switch from arg-based to revision-based naming scheme: s/clone6/clone3/
- Arnd Bergmann <arnd@arndb.de>:
  - use a single copy_from_user() instead of multiple get_user() calls
    since the latter have a constant overhead on some architectures
  - a range of other tweaks and suggestions
v2:
- Linus Torvalds <torvalds@linux-foundation.org>,
  Andrei Vagin <avagin@gmail.com>:
  - replace CSIGNAL flag with dedicated exit_signal argument in struct
    clone_args
- Christian Brauner <christian@brauner.io>:
  - improve naming for some struct clone_args members
v3:
- Arnd Bergmann <arnd@arndb.de>:
  - replace memset with constructor for clarity and better object code
  - call flag verification function clone3_flags_valid() on
    kernel_clone_args instead of clone_args
  - remove __ARCH_WANT_SYS_CLONE ifdefine around sys_clone3()
- Christian Brauner <christian@brauner.io>:
  - replace clone3_flags_valid() with clone3_args_valid() and call in
    clone3() directly rather than in copy_clone_args_from_user()
    This cleanly separates copying the args from userspace from the
    verification whether those args are sane.
- David Howells <dhowells@redhat.com>:
  - align new struct member assignments with tabs
  - replace CLONE_MAX by with a non-uapi exported CLONE_LEGACY_FLAGS and
    define it as  0xffffffffULL for clarity
  - make copy_clone_args_from_user() noinline
  - avoid assigning to local variables from struct kernel_clone_args
    members in cases where it makes sense
---
 arch/x86/ia32/sys_ia32.c   |  12 ++-
 include/linux/sched/task.h |  17 +++-
 include/linux/syscalls.h   |   4 +
 include/uapi/linux/sched.h |  16 +++
 kernel/fork.c              | 201 ++++++++++++++++++++++++++++---------
 5 files changed, 199 insertions(+), 51 deletions(-)

diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index a43212036257..64a6c952091e 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -237,6 +237,14 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
 		       unsigned long, newsp, int __user *, parent_tidptr,
 		       unsigned long, tls_val, int __user *, child_tidptr)
 {
-	return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr,
-			tls_val);
+	struct kernel_clone_args args = {
+		.flags		= (clone_flags & ~CSIGNAL),
+		.child_tid	= child_tidptr,
+		.parent_tid	= parent_tidptr,
+		.exit_signal	= (clone_flags & CSIGNAL),
+		.stack		= newsp,
+		.tls		= tls_val,
+	};
+
+	return _do_fork(&args);
 }
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index f1227f2c38a4..109a0df5af39 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -8,11 +8,26 @@
  */
 
 #include <linux/sched.h>
+#include <linux/uaccess.h>
 
 struct task_struct;
 struct rusage;
 union thread_union;
 
+/* All the bits taken by the old clone syscall. */
+#define CLONE_LEGACY_FLAGS 0xffffffffULL
+
+struct kernel_clone_args {
+	u64 flags;
+	int __user *pidfd;
+	int __user *child_tid;
+	int __user *parent_tid;
+	int exit_signal;
+	unsigned long stack;
+	unsigned long stack_size;
+	unsigned long tls;
+};
+
 /*
  * This serializes "schedule()" and also protects
  * the run-queue from deletions/modifications (but
@@ -73,7 +88,7 @@ extern void do_group_exit(int);
 extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
-extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
+extern long _do_fork(struct kernel_clone_args *kargs);
 extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..60a81f374ca3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -70,6 +70,7 @@ struct sigaltstack;
 struct rseq;
 union bpf_attr;
 struct io_uring_params;
+struct clone_args;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -852,6 +853,9 @@ asmlinkage long sys_clone(unsigned long, unsigned long, int __user *,
 	       int __user *, unsigned long);
 #endif
 #endif
+
+asmlinkage long sys_clone3(struct clone_args __user *uargs, size_t size);
+
 asmlinkage long sys_execve(const char __user *filename,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp);
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index ed4ee170bee2..f5331dbdcaa2 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_SCHED_H
 #define _UAPI_LINUX_SCHED_H
 
+#include <linux/types.h>
+
 /*
  * cloning flags:
  */
@@ -31,6 +33,20 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/*
+ * Arguments for the clone3 syscall
+ */
+struct clone_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+};
+
 /*
  * Scheduling policies
  */
diff --git a/kernel/fork.c b/kernel/fork.c
index b4cba953040a..08ff131f26b4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1760,19 +1760,15 @@ static __always_inline void delayed_free_task(struct task_struct *tsk)
  * flags). The actual kick-off is left to the caller.
  */
 static __latent_entropy struct task_struct *copy_process(
-					unsigned long clone_flags,
-					unsigned long stack_start,
-					unsigned long stack_size,
-					int __user *parent_tidptr,
-					int __user *child_tidptr,
 					struct pid *pid,
 					int trace,
-					unsigned long tls,
-					int node)
+					int node,
+					struct kernel_clone_args *args)
 {
 	int pidfd = -1, retval;
 	struct task_struct *p;
 	struct multiprocess_signals delayed;
+	u64 clone_flags = args->flags;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1821,27 +1817,12 @@ static __latent_entropy struct task_struct *copy_process(
 	}
 
 	if (clone_flags & CLONE_PIDFD) {
-		int reserved;
-
 		/*
-		 * - CLONE_PARENT_SETTID is useless for pidfds and also
-		 *   parent_tidptr is used to return pidfds.
 		 * - CLONE_DETACHED is blocked so that we can potentially
 		 *   reuse it later for CLONE_PIDFD.
 		 * - CLONE_THREAD is blocked until someone really needs it.
 		 */
-		if (clone_flags &
-		    (CLONE_DETACHED | CLONE_PARENT_SETTID | CLONE_THREAD))
-			return ERR_PTR(-EINVAL);
-
-		/*
-		 * Verify that parent_tidptr is sane so we can potentially
-		 * reuse it later.
-		 */
-		if (get_user(reserved, parent_tidptr))
-			return ERR_PTR(-EFAULT);
-
-		if (reserved != 0)
+		if (clone_flags & (CLONE_DETACHED | CLONE_THREAD))
 			return ERR_PTR(-EINVAL);
 	}
 
@@ -1874,11 +1855,11 @@ static __latent_entropy struct task_struct *copy_process(
 	 * p->set_child_tid which is (ab)used as a kthread's data pointer for
 	 * kernel threads (PF_KTHREAD).
 	 */
-	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
+	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? args->child_tid : NULL;
 	/*
 	 * Clear TID on mm_release()?
 	 */
-	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? child_tidptr : NULL;
+	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? args->child_tid : NULL;
 
 	ftrace_graph_init_task(p);
 
@@ -2037,7 +2018,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_io(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_namespaces;
-	retval = copy_thread_tls(clone_flags, stack_start, stack_size, p, tls);
+	retval = copy_thread_tls(clone_flags, args->stack, args->stack_size, p,
+				 args->tls);
 	if (retval)
 		goto bad_fork_cleanup_io;
 
@@ -2062,7 +2044,7 @@ static __latent_entropy struct task_struct *copy_process(
 			goto bad_fork_free_pid;
 
 		pidfd = retval;
-		retval = put_user(pidfd, parent_tidptr);
+		retval = put_user(pidfd, args->pidfd);
 		if (retval)
 			goto bad_fork_put_pidfd;
 	}
@@ -2105,7 +2087,7 @@ static __latent_entropy struct task_struct *copy_process(
 		if (clone_flags & CLONE_PARENT)
 			p->exit_signal = current->group_leader->exit_signal;
 		else
-			p->exit_signal = (clone_flags & CSIGNAL);
+			p->exit_signal = args->exit_signal;
 		p->group_leader = p;
 		p->tgid = p->pid;
 	}
@@ -2313,8 +2295,11 @@ static inline void init_idle_pids(struct task_struct *idle)
 struct task_struct *fork_idle(int cpu)
 {
 	struct task_struct *task;
-	task = copy_process(CLONE_VM, 0, 0, NULL, NULL, &init_struct_pid, 0, 0,
-			    cpu_to_node(cpu));
+	struct kernel_clone_args args = {
+		.flags = CLONE_VM,
+	};
+
+	task = copy_process(&init_struct_pid, 0, cpu_to_node(cpu), &args);
 	if (!IS_ERR(task)) {
 		init_idle_pids(task);
 		init_idle(task, cpu);
@@ -2334,13 +2319,9 @@ struct mm_struct *copy_init_mm(void)
  * It copies the process, and if successful kick-starts
  * it and waits for it to finish using the VM if required.
  */
-long _do_fork(unsigned long clone_flags,
-	      unsigned long stack_start,
-	      unsigned long stack_size,
-	      int __user *parent_tidptr,
-	      int __user *child_tidptr,
-	      unsigned long tls)
+long _do_fork(struct kernel_clone_args *args)
 {
+	u64 clone_flags = args->flags;
 	struct completion vfork;
 	struct pid *pid;
 	struct task_struct *p;
@@ -2356,7 +2337,7 @@ long _do_fork(unsigned long clone_flags,
 	if (!(clone_flags & CLONE_UNTRACED)) {
 		if (clone_flags & CLONE_VFORK)
 			trace = PTRACE_EVENT_VFORK;
-		else if ((clone_flags & CSIGNAL) != SIGCHLD)
+		else if (args->exit_signal != SIGCHLD)
 			trace = PTRACE_EVENT_CLONE;
 		else
 			trace = PTRACE_EVENT_FORK;
@@ -2365,8 +2346,7 @@ long _do_fork(unsigned long clone_flags,
 			trace = 0;
 	}
 
-	p = copy_process(clone_flags, stack_start, stack_size, parent_tidptr,
-			 child_tidptr, NULL, trace, tls, NUMA_NO_NODE);
+	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
 	add_latent_entropy();
 
 	if (IS_ERR(p))
@@ -2382,7 +2362,7 @@ long _do_fork(unsigned long clone_flags,
 	nr = pid_vnr(pid);
 
 	if (clone_flags & CLONE_PARENT_SETTID)
-		put_user(nr, parent_tidptr);
+		put_user(nr, args->parent_tid);
 
 	if (clone_flags & CLONE_VFORK) {
 		p->vfork_done = &vfork;
@@ -2414,8 +2394,16 @@ long do_fork(unsigned long clone_flags,
 	      int __user *parent_tidptr,
 	      int __user *child_tidptr)
 {
-	return _do_fork(clone_flags, stack_start, stack_size,
-			parent_tidptr, child_tidptr, 0);
+	struct kernel_clone_args args = {
+		.flags		= (clone_flags & ~CSIGNAL),
+		.child_tid	= child_tidptr,
+		.parent_tid	= parent_tidptr,
+		.exit_signal	= (clone_flags & CSIGNAL),
+		.stack		= stack_start,
+		.stack_size	= stack_size,
+	};
+
+	return _do_fork(&args);
 }
 #endif
 
@@ -2424,15 +2412,25 @@ long do_fork(unsigned long clone_flags,
  */
 pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 {
-	return _do_fork(flags|CLONE_VM|CLONE_UNTRACED, (unsigned long)fn,
-		(unsigned long)arg, NULL, NULL, 0);
+	struct kernel_clone_args args = {
+		.flags		= ((flags | CLONE_VM | CLONE_UNTRACED) & ~CSIGNAL),
+		.exit_signal	= (flags & CSIGNAL),
+		.stack		= (unsigned long)fn,
+		.stack_size	= (unsigned long)arg,
+	};
+
+	return _do_fork(&args);
 }
 
 #ifdef __ARCH_WANT_SYS_FORK
 SYSCALL_DEFINE0(fork)
 {
 #ifdef CONFIG_MMU
-	return _do_fork(SIGCHLD, 0, 0, NULL, NULL, 0);
+	struct kernel_clone_args args = {
+		.exit_signal = SIGCHLD,
+	};
+
+	return _do_fork(&args);
 #else
 	/* can not support in nommu mode */
 	return -EINVAL;
@@ -2443,8 +2441,12 @@ SYSCALL_DEFINE0(fork)
 #ifdef __ARCH_WANT_SYS_VFORK
 SYSCALL_DEFINE0(vfork)
 {
-	return _do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0,
-			0, NULL, NULL, 0);
+	struct kernel_clone_args args = {
+		.flags		= CLONE_VFORK | CLONE_VM,
+		.exit_signal	= SIGCHLD,
+	};
+
+	return _do_fork(&args);
 }
 #endif
 
@@ -2472,7 +2474,110 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 		 unsigned long, tls)
 #endif
 {
-	return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr, tls);
+	struct kernel_clone_args args = {
+		.flags		= (clone_flags & ~CSIGNAL),
+		.pidfd		= parent_tidptr,
+		.child_tid	= child_tidptr,
+		.parent_tid	= parent_tidptr,
+		.exit_signal	= (clone_flags & CSIGNAL),
+		.stack		= newsp,
+		.tls		= tls,
+	};
+
+	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
+	if ((clone_flags & CLONE_PIDFD) && (clone_flags & CLONE_PARENT_SETTID))
+		return -EINVAL;
+
+	return _do_fork(&args);
+}
+
+noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
+					      struct clone_args __user *uargs,
+					      size_t size)
+{
+	struct clone_args args;
+
+	if (unlikely(size > PAGE_SIZE))
+		return -E2BIG;
+
+	if (unlikely(size < sizeof(struct clone_args)))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(uargs, size)))
+		return -EFAULT;
+
+	if (size > sizeof(struct clone_args)) {
+		unsigned char __user *addr;
+		unsigned char __user *end;
+		unsigned char val;
+
+		addr = (void __user *)uargs + sizeof(struct clone_args);
+		end = (void __user *)uargs + size;
+
+		for (; addr < end; addr++) {
+			if (get_user(val, addr))
+				return -EFAULT;
+			if (val)
+				return -E2BIG;
+		}
+
+		size = sizeof(struct clone_args);
+	}
+
+	if (copy_from_user(&args, uargs, size))
+		return -EFAULT;
+
+	*kargs = (struct kernel_clone_args){
+		.flags		= args.flags,
+		.pidfd		= u64_to_user_ptr(args.pidfd),
+		.child_tid	= u64_to_user_ptr(args.child_tid),
+		.parent_tid	= u64_to_user_ptr(args.parent_tid),
+		.exit_signal	= args.exit_signal,
+		.stack		= args.stack,
+		.stack_size	= args.stack_size,
+		.tls		= args.tls,
+	};
+
+	return 0;
+}
+
+static bool clone3_args_valid(const struct kernel_clone_args *kargs)
+{
+	/*
+	 * All lower bits of the flag word are taken.
+	 * Verify that no other unknown flags are passed along.
+	 */
+	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
+		return false;
+
+	/*
+	 * - make the CLONE_DETACHED bit reuseable for clone3
+	 * - make the CSIGNAL bits reuseable for clone3
+	 */
+	if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
+		return false;
+
+	if ((kargs->flags & (CLONE_THREAD | CLONE_PARENT)) &&
+	    kargs->exit_signal)
+		return false;
+
+	return true;
+}
+
+SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
+{
+	int err;
+
+	struct kernel_clone_args kargs;
+
+	err = copy_clone_args_from_user(&kargs, uargs, size);
+	if (err)
+		return err;
+
+	if (!clone3_args_valid(&kargs))
+		return -EINVAL;
+
+	return _do_fork(&kargs);
 }
 #endif
 
-- 
2.21.0

