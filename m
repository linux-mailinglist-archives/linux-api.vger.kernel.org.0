Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447CB43018
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfFLT0i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40676 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfFLT0f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so18143704wre.7
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BijmyDXWUSusUHaSfCv+qqh5iFfiN3LRSmlibqQ8kjU=;
        b=Tq4brge0a9cqa68APx0yiV9oCFZAt/OgbuTZVFxvR5OufAWSOhKInirAlbFrjyZkBJ
         33wWnStEB844o29slvwEuHDllAjbHNrsONeSSIAeQqhEOwixBCmiVI3t0BWO9YuDuTME
         BAOINMmOf/AP7DApNBmzazYQ38GkYSpWxsMZLYiFxc+SEIj8ZDsbGJfThQqwDkkzY5QM
         P4YaXTj5QDoRCiaCM8nCJ+2z7+XMiLJBH0uH6MkIKv/ONUMjNILagM7wv6xM+qdUHpY7
         C6XmMt4xFMZiSd4VmV1ETfrzduMr0SJ6O3oR4g8Rs7ZHikQXNWxD52sVmCRM2bg+NUkG
         tUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BijmyDXWUSusUHaSfCv+qqh5iFfiN3LRSmlibqQ8kjU=;
        b=Zwj8AydAUMoNJIsT003/HzzElc4Q1KRNC88NQGDbryKFzBP+zjJ6ZI9qliqQgFQaFe
         v6jdDVnhXz5Celn9pOczgJrjzr1nGThpxPNwv0uWVGi2Nk4PrG/fX4J/9cZ/cUmx+67j
         lff4IZFXP9HQJIjya0nb5y9Tgkq89wsFVhYXVtRzlSzL/z4jSWFf3HwEnjx4/yVv8Xm7
         1YN/eusAwYmAjoq7Q+V/+dNZQSG+w8Jti/kVZ4IefJWSL++8lturn92Pn7dF6hWVX4gN
         MRmMY70rDr/2He6XHLLFsA5ycxF/y23Pv0Gd9jBCdaoDFTALFf+8C2iymgUG4hO89AwO
         LOkw==
X-Gm-Message-State: APjAAAVo4cVS/H4hvyQhRK3q1nggWodOCI7legswIfWU6NRBZNaBG/vH
        Onysd+KIfLRTdyFzqQxnHab+iw==
X-Google-Smtp-Source: APXvYqxEWv40Dv0sZRAK4hhy2UJPYSsw2WeNkXdRzvYRsvgM6gkqJYGM1El6JfUJknKmMtag3uaZ/Q==
X-Received: by 2002:adf:db12:: with SMTP id s18mr3208121wri.335.1560367591542;
        Wed, 12 Jun 2019 12:26:31 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:30 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 01/28] ns: Introduce Time Namespace
Date:   Wed, 12 Jun 2019 20:26:00 +0100
Message-Id: <20190612192628.23797-2-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Time Namespace isolates clock values.

The kernel provides access to several clocks CLOCK_REALTIME,
CLOCK_MONOTONIC, CLOCK_BOOTTIME, etc.

CLOCK_REALTIME
      System-wide clock that measures real (i.e., wall-clock) time.

CLOCK_MONOTONIC
      Clock that cannot be set and represents monotonic time since
      some unspecified starting point.

CLOCK_BOOTTIME
      Identical to CLOCK_MONOTONIC, except it also includes any time
      that the system is suspended.

For many users, the time namespace means the ability to changes date and
time in a container (CLOCK_REALTIME).

But in a context of the checkpoint/restore functionality, monotonic and
bootime clocks become interesting. Both clocks are monotonic with
unspecified staring points. These clocks are widely used to measure time
slices and set timers. After restoring or migrating processes, we have to
guarantee that they never go backward. In an ideal case, the behavior of
these clocks should be the same as for a case when a whole system is
suspended. All this means that we need to be able to set CLOCK_MONOTONIC
and CLOCK_BOOTTIME clocks, what can be done by adding per-namespace
offsets for clocks.

A time namespace is similar to a pid namespace in a way how it is
created: unshare(CLONE_NEWTIME) system call creates a new time namespace,
but doesn't set it to the current process. Then all children of
the process will be born in the new time namespace, or a process can
use the setns() system call to join a namespace.

This scheme allows setting clock offsets for a namespace, before any
processes appear in it.

All avaliable clone flags have been used, so CLONE_NEWTIME uses the
highest bit of CSIGNAL. It means that we can use it with the unshare
system call only. Rith now, this works for us, because time namespace
offsets can be set only when a new time namespace is not populated. In a
future, we will have the clone3 system call [1] which will allow to use
the CSIGNAL mask for clone flags.

[1]: httmps://lkml.kernel.org/r/20190604160944.4058-1-christian@brauner.io

Link: https://criu.org/Time_namespace
Link: https://lists.openvz.org/pipermail/criu/2018-June/041504.html
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 MAINTAINERS                    |   2 +
 fs/proc/namespaces.c           |   4 +
 include/linux/nsproxy.h        |   2 +
 include/linux/proc_ns.h        |   2 +
 include/linux/time_namespace.h |  69 +++++++++++
 include/linux/user_namespace.h |   1 +
 include/uapi/linux/sched.h     |   5 +
 init/Kconfig                   |   7 ++
 kernel/Makefile                |   1 +
 kernel/fork.c                  |  29 ++++-
 kernel/nsproxy.c               |  41 +++++--
 kernel/time_namespace.c        | 215 +++++++++++++++++++++++++++++++++
 12 files changed, 367 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/time_namespace.h
 create mode 100644 kernel/time_namespace.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..323ab92b963b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12589,6 +12589,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
+F:	include/linux/time_namespace.h
+F:	kernel/time_namespace.c
 F:	kernel/time/*timer*
 
 POWER MANAGEMENT CORE
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index dd2b35f78b09..8b5c720fe5d7 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -33,6 +33,10 @@ static const struct proc_ns_operations *ns_entries[] = {
 #ifdef CONFIG_CGROUPS
 	&cgroupns_operations,
 #endif
+#ifdef CONFIG_TIME_NS
+	&timens_operations,
+	&timens_for_children_operations,
+#endif
 };
 
 static const char *proc_ns_get_link(struct dentry *dentry,
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 2ae1b1a4d84d..074f395b9ad2 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -35,6 +35,8 @@ struct nsproxy {
 	struct mnt_namespace *mnt_ns;
 	struct pid_namespace *pid_ns_for_children;
 	struct net 	     *net_ns;
+	struct time_namespace *time_ns;
+	struct time_namespace *time_ns_for_children;
 	struct cgroup_namespace *cgroup_ns;
 };
 extern struct nsproxy init_nsproxy;
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index d31cb6215905..3e6f332da465 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -32,6 +32,8 @@ extern const struct proc_ns_operations pidns_for_children_operations;
 extern const struct proc_ns_operations userns_operations;
 extern const struct proc_ns_operations mntns_operations;
 extern const struct proc_ns_operations cgroupns_operations;
+extern const struct proc_ns_operations timens_operations;
+extern const struct proc_ns_operations timens_for_children_operations;
 
 /*
  * We always define these enumerators
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
new file mode 100644
index 000000000000..9507ed7072fe
--- /dev/null
+++ b/include/linux/time_namespace.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIMENS_H
+#define _LINUX_TIMENS_H
+
+
+#include <linux/sched.h>
+#include <linux/kref.h>
+#include <linux/nsproxy.h>
+#include <linux/ns_common.h>
+#include <linux/err.h>
+
+struct user_namespace;
+extern struct user_namespace init_user_ns;
+
+struct time_namespace {
+	struct kref kref;
+	struct user_namespace *user_ns;
+	struct ucounts *ucounts;
+	struct ns_common ns;
+	struct timens_offsets *offsets;
+	bool   initialized;
+} __randomize_layout;
+extern struct time_namespace init_time_ns;
+
+#ifdef CONFIG_TIME_NS
+static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
+{
+	kref_get(&ns->kref);
+	return ns;
+}
+
+extern struct time_namespace *copy_time_ns(unsigned long flags,
+	struct user_namespace *user_ns, struct time_namespace *old_ns);
+extern void free_time_ns(struct kref *kref);
+extern int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+
+static inline void put_time_ns(struct time_namespace *ns)
+{
+	kref_put(&ns->kref, free_time_ns);
+}
+
+
+#else
+static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
+{
+	return NULL;
+}
+
+static inline void put_time_ns(struct time_namespace *ns)
+{
+}
+
+static inline struct time_namespace *copy_time_ns(unsigned long flags,
+	struct user_namespace *user_ns, struct time_namespace *old_ns)
+{
+	if (flags & CLONE_NEWTIME)
+		return ERR_PTR(-EINVAL);
+
+	return old_ns;
+}
+
+static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+{
+	return 0;
+}
+
+#endif
+
+#endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index d6b74b91096b..bf84f93dc411 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -45,6 +45,7 @@ enum ucount_type {
 	UCOUNT_NET_NAMESPACES,
 	UCOUNT_MNT_NAMESPACES,
 	UCOUNT_CGROUP_NAMESPACES,
+	UCOUNT_TIME_NAMESPACES,
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_INOTIFY_INSTANCES,
 	UCOUNT_INOTIFY_WATCHES,
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index ed4ee170bee2..6c4d7a5d5253 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -31,6 +31,11 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/*
+ * cloning flags which can be used with the unshare syscall only:
+ */
+#define CLONE_NEWTIME	0x00000080	/* New time namespace */
+
 /*
  * Scheduling policies
  */
diff --git a/init/Kconfig b/init/Kconfig
index 0e2344389501..098fe185360c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -991,6 +991,13 @@ config UTS_NS
 	  In this namespace tasks see different info provided with the
 	  uname() system call
 
+config TIME_NS
+	bool "TIME namespace"
+	default y
+	help
+	  In this namespace boottime and monotonic clocks can be set.
+	  The time will keep going with the same pace.
+
 config IPC_NS
 	bool "IPC namespace"
 	depends on (SYSVIPC || POSIX_MQUEUE)
diff --git a/kernel/Makefile b/kernel/Makefile
index a8d923b5481b..a8654c9aa2f5 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
 obj-$(CONFIG_UTS_NS) += utsname.o
+obj-$(CONFIG_TIME_NS) += time_namespace.o
 obj-$(CONFIG_USER_NS) += user_namespace.o
 obj-$(CONFIG_PID_NS) += pid_namespace.o
 obj-$(CONFIG_IKCONFIG) += configs.o
diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf6df..09dacb708b4f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1774,6 +1774,15 @@ static __latent_entropy struct task_struct *copy_process(
 	int pidfd = -1, retval;
 	struct task_struct *p;
 	struct multiprocess_signals delayed;
+	struct nsproxy *nsp = current->nsproxy;
+	int exit_signal;
+
+	/*
+	 * Exclude clone flags which intersect with CSIGNAL and can be used
+	 * with the unshare syscall only.
+	 */
+	exit_signal = clone_flags & CSIGNAL;
+	clone_flags &= ~CSIGNAL;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1816,8 +1825,17 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	if (clone_flags & CLONE_THREAD) {
 		if ((clone_flags & (CLONE_NEWUSER | CLONE_NEWPID)) ||
-		    (task_active_pid_ns(current) !=
-				current->nsproxy->pid_ns_for_children))
+		    (task_active_pid_ns(current) != nsp->pid_ns_for_children))
+			return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * If the new process will be in a different time namespace
+	 * do not allow it to share VM or a thread group with the forking task.
+	 */
+	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
+		if ((clone_flags & CLONE_NEWTIME) ||
+		    (nsp->time_ns != nsp->time_ns_for_children))
 			return ERR_PTR(-EINVAL);
 	}
 
@@ -2106,7 +2124,7 @@ static __latent_entropy struct task_struct *copy_process(
 		if (clone_flags & CLONE_PARENT)
 			p->exit_signal = current->group_leader->exit_signal;
 		else
-			p->exit_signal = (clone_flags & CSIGNAL);
+			p->exit_signal = exit_signal;
 		p->group_leader = p;
 		p->tgid = p->pid;
 	}
@@ -2568,7 +2586,8 @@ static int check_unshare_flags(unsigned long unshare_flags)
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
 				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
-				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP))
+				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
+				CLONE_NEWTIME))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
@@ -2579,6 +2598,8 @@ static int check_unshare_flags(unsigned long unshare_flags)
 	if (unshare_flags & (CLONE_THREAD | CLONE_SIGHAND | CLONE_VM)) {
 		if (!thread_group_empty(current))
 			return -EINVAL;
+		if (unshare_flags & CLONE_NEWTIME)
+			return -EINVAL;
 	}
 	if (unshare_flags & (CLONE_SIGHAND | CLONE_VM)) {
 		if (refcount_read(&current->sighand->count) > 1)
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index c815f58e6bc0..ed9882108cd2 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -18,6 +18,7 @@
 #include <linux/pid_namespace.h>
 #include <net/net_namespace.h>
 #include <linux/ipc_namespace.h>
+#include <linux/time_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
@@ -40,6 +41,10 @@ struct nsproxy init_nsproxy = {
 #ifdef CONFIG_CGROUPS
 	.cgroup_ns		= &init_cgroup_ns,
 #endif
+#ifdef CONFIG_TIME_NS
+	.time_ns		= &init_time_ns,
+	.time_ns_for_children	= &init_time_ns,
+#endif
 };
 
 static inline struct nsproxy *create_nsproxy(void)
@@ -106,8 +111,18 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
 		goto out_net;
 	}
 
+	new_nsp->time_ns_for_children = copy_time_ns(flags, user_ns,
+					tsk->nsproxy->time_ns_for_children);
+	if (IS_ERR(new_nsp->time_ns_for_children)) {
+		err = PTR_ERR(new_nsp->time_ns_for_children);
+		goto out_time;
+	}
+	new_nsp->time_ns = get_time_ns(tsk->nsproxy->time_ns);
+
 	return new_nsp;
 
+out_time:
+	put_net(new_nsp->net_ns);
 out_net:
 	put_cgroup_ns(new_nsp->cgroup_ns);
 out_cgroup:
@@ -136,15 +151,16 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
+	int ret;
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
-			      CLONE_NEWCGROUP)))) {
-		get_nsproxy(old_ns);
-		return 0;
-	}
-
-	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
+			      CLONE_NEWCGROUP | CLONE_NEWTIME)))) {
+		if (likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
+			get_nsproxy(old_ns);
+			return 0;
+		}
+	} else if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/*
@@ -162,6 +178,12 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
+	ret = timens_on_fork(new_ns, tsk);
+	if (ret) {
+		free_nsproxy(new_ns);
+		return ret;
+	}
+
 	tsk->nsproxy = new_ns;
 	return 0;
 }
@@ -176,6 +198,10 @@ void free_nsproxy(struct nsproxy *ns)
 		put_ipc_ns(ns->ipc_ns);
 	if (ns->pid_ns_for_children)
 		put_pid_ns(ns->pid_ns_for_children);
+	if (ns->time_ns)
+		put_time_ns(ns->time_ns);
+	if (ns->time_ns_for_children)
+		put_time_ns(ns->time_ns_for_children);
 	put_cgroup_ns(ns->cgroup_ns);
 	put_net(ns->net_ns);
 	kmem_cache_free(nsproxy_cachep, ns);
@@ -192,7 +218,8 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 	int err = 0;
 
 	if (!(unshare_flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP)))
+			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
+			       CLONE_NEWTIME)))
 		return 0;
 
 	user_ns = new_cred ? new_cred->user_ns : current_user_ns();
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
new file mode 100644
index 000000000000..8c600df9771d
--- /dev/null
+++ b/kernel/time_namespace.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Andrei Vagin <avagin@openvz.org>
+ * Author: Dmitry Safonov <dima@arista.com>
+ */
+
+#include <linux/export.h>
+#include <linux/time.h>
+#include <linux/time_namespace.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/user_namespace.h>
+#include <linux/proc_ns.h>
+#include <linux/sched/task.h>
+
+static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
+{
+	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
+}
+
+static void dec_time_namespaces(struct ucounts *ucounts)
+{
+	dec_ucount(ucounts, UCOUNT_TIME_NAMESPACES);
+}
+
+static struct time_namespace *create_time_ns(void)
+{
+	struct time_namespace *time_ns;
+
+	time_ns = kmalloc(sizeof(struct time_namespace), GFP_KERNEL);
+	if (time_ns) {
+		kref_init(&time_ns->kref);
+		time_ns->initialized = false;
+	}
+	return time_ns;
+}
+
+/*
+ * Clone a new ns copying @old_ns, setting refcount to 1
+ * @old_ns: namespace to clone
+ * Return the new ns or ERR_PTR.
+ */
+static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
+					  struct time_namespace *old_ns)
+{
+	struct time_namespace *ns;
+	struct ucounts *ucounts;
+	int err;
+
+	err = -ENOSPC;
+	ucounts = inc_time_namespaces(user_ns);
+	if (!ucounts)
+		goto fail;
+
+	err = -ENOMEM;
+	ns = create_time_ns();
+	if (!ns)
+		goto fail_dec;
+
+	err = ns_alloc_inum(&ns->ns);
+	if (err)
+		goto fail_free;
+
+	ns->ucounts = ucounts;
+	ns->ns.ops = &timens_operations;
+	ns->user_ns = get_user_ns(user_ns);
+	return ns;
+
+fail_free:
+	kfree(ns);
+fail_dec:
+	dec_time_namespaces(ucounts);
+fail:
+	return ERR_PTR(err);
+}
+
+/*
+ * Add a reference to old_ns, or clone it if @flags specify CLONE_NEWTIME.
+ * In latter case, changes to the time of this process won't be seen by parent,
+ * and vice versa.
+ */
+struct time_namespace *copy_time_ns(unsigned long flags,
+	struct user_namespace *user_ns, struct time_namespace *old_ns)
+{
+	if (!(flags & CLONE_NEWTIME))
+		return get_time_ns(old_ns);
+
+	return clone_time_ns(user_ns, old_ns);
+}
+
+void free_time_ns(struct kref *kref)
+{
+	struct time_namespace *ns;
+
+	ns = container_of(kref, struct time_namespace, kref);
+	dec_time_namespaces(ns->ucounts);
+	put_user_ns(ns->user_ns);
+	ns_free_inum(&ns->ns);
+	kfree(ns);
+}
+
+static struct time_namespace *to_time_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct time_namespace, ns);
+}
+
+static struct ns_common *timens_get(struct task_struct *task)
+{
+	struct time_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->time_ns;
+		get_time_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static struct ns_common *timens_for_children_get(struct task_struct *task)
+{
+	struct time_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->time_ns_for_children;
+		get_time_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static void timens_put(struct ns_common *ns)
+{
+	put_time_ns(to_time_ns(ns));
+}
+
+static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
+{
+	struct time_namespace *ns = to_time_ns(new);
+
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
+	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
+		return -EPERM;
+
+	get_time_ns(ns);
+	get_time_ns(ns);
+	put_time_ns(nsproxy->time_ns);
+	put_time_ns(nsproxy->time_ns_for_children);
+	nsproxy->time_ns = ns;
+	nsproxy->time_ns_for_children = ns;
+	ns->initialized = true;
+	return 0;
+}
+
+int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+{
+	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
+	struct time_namespace *ns = to_time_ns(nsc);
+
+	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
+		return 0;
+
+	get_time_ns(ns);
+	put_time_ns(nsproxy->time_ns);
+	nsproxy->time_ns = ns;
+	ns->initialized = true;
+
+	return 0;
+}
+
+static struct user_namespace *timens_owner(struct ns_common *ns)
+{
+	return to_time_ns(ns)->user_ns;
+}
+
+const struct proc_ns_operations timens_operations = {
+	.name		= "time",
+	.type		= CLONE_NEWTIME,
+	.get		= timens_get,
+	.put		= timens_put,
+	.install	= timens_install,
+	.owner		= timens_owner,
+};
+
+const struct proc_ns_operations timens_for_children_operations = {
+	.name		= "time_for_children",
+	.type		= CLONE_NEWTIME,
+	.get		= timens_for_children_get,
+	.put		= timens_put,
+	.install	= timens_install,
+	.owner		= timens_owner,
+};
+
+struct time_namespace init_time_ns = {
+	.kref = KREF_INIT(3),
+	.user_ns = &init_user_ns,
+	.ns.inum = PROC_UTS_INIT_INO,
+#ifdef CONFIG_UTS_NS
+	.ns.ops = &timens_operations,
+#endif
+};
+
+static int __init time_ns_init(void)
+{
+	return 0;
+}
+subsys_initcall(time_ns_init);
-- 
2.22.0

