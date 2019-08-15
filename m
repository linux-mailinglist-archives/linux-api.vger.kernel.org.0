Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13588F10E
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfHOQio (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:38:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53777 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbfHOQin (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:38:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so1789465wmp.3
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRSMso32eChn7oiULCZK23KPysbllAGq+urBKY8Qqx8=;
        b=TUXJSkcuNRqcGwJZciPE2Zmm9n68ZZ31mImo19853pZ6MqlcGuBKcUgyReJB75cq8B
         UQvuEV3dEbBpvqlyG36ufvjm7IHnWL+hc3aStuFLEDgzEtYGjaZ405U3WXoY164+gebZ
         4qVvK12WPamYp3+aFYdpDDsecTT7r6DfNUSZYe1CnBAnmkWPd9f8zNmzdqbQhOUb5l5O
         844ZvBAtoQpU3dhUXU4lh/u+w/SP9xK9noJvUlVx+7cU73Yu9dMWyNg2N2bLwWxZVEAE
         PZxQcy59mGd3imkA208OPaZd1Ty48RDqrkLmIPw9CoDH8I4+Q9ztzyiVYKVZlRlxe5Ff
         WM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRSMso32eChn7oiULCZK23KPysbllAGq+urBKY8Qqx8=;
        b=Rgfoq2joI/qCGrJRYeKmCvmgzF/cCXsQJ1y7du+kTxXWsSL1Pz9YfqqBmKefTiFIFx
         3sC0H+9BDp0wd1vRzqxUX25uW5CNq3SgfoUNF4DjMa/S8/irG16h65no+ghED40B0awx
         DzBc8b1DyIX4o3sM64yfE3EKn/W4k5p8YI7I/bVjJe2s2XHclafEeMFqVln/PswcCOSi
         iuLPopk/iPWuTgo2FjPOASbY4krjkxVdWfPlhx439vSRaEkvXHI9qrf1yB/O+sa8OENt
         lDKr1aZ5aww9+Fp8ZwYw2kgQlrXrPfmXZZVWtuSuZDFCWZAc6HCaIuIvc6zbG4xKGlO0
         q1YA==
X-Gm-Message-State: APjAAAUJDlwLPfRuH2geXMIz0Idtybxiq3UTLYWjIDHMob4TvexPXwlg
        nsRtVbcc7li0fDLN65zdXa8tWA==
X-Google-Smtp-Source: APXvYqzvovCsyBOhFE78s5j0iHWLsnyKHZCTXGWf5YBIwrJVNd5+IWX+QEHRfKPfZ5Ye62BBiwWVhQ==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr3616346wme.29.1565887119828;
        Thu, 15 Aug 2019 09:38:39 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:39 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
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
Subject: [PATCHv6 01/36] ns: Introduce Time Namespace
Date:   Thu, 15 Aug 2019 17:38:01 +0100
Message-Id: <20190815163836.2927-2-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
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

All available clone flags have been used, so CLONE_NEWTIME uses the
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
 include/linux/proc_ns.h        |   3 +
 include/linux/time_namespace.h |  69 +++++++++++
 include/linux/user_namespace.h |   1 +
 include/uapi/linux/sched.h     |   6 +
 init/Kconfig                   |   7 ++
 kernel/Makefile                |   1 +
 kernel/fork.c                  |  16 ++-
 kernel/nsproxy.c               |  41 +++++--
 kernel/time_namespace.c        | 217 +++++++++++++++++++++++++++++++++
 12 files changed, 359 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/time_namespace.h
 create mode 100644 kernel/time_namespace.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 420567d1519a..97b7737f5aba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12898,6 +12898,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
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
index d31cb6215905..d312e6281e69 100644
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
@@ -43,6 +45,7 @@ enum {
 	PROC_USER_INIT_INO	= 0xEFFFFFFDU,
 	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
 	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
+	PROC_TIME_INIT_INO	= 0xEFFFFFFAU,
 };
 
 #ifdef CONFIG_PROC_FS
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
index fb9f4f799554..6ef1c7109fc4 100644
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
index e1ce103a2c47..f3f5c496ce44 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -33,6 +33,12 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/*
+ * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
+ * syscalls only:
+ */
+#define CLONE_NEWTIME	0x00000080	/* New time namespace */
+
 /*
  * Arguments for the clone3 syscall
  */
diff --git a/init/Kconfig b/init/Kconfig
index befcbb43cd2a..525dc3ed86c4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1072,6 +1072,13 @@ config UTS_NS
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
index e4dc0e7907b5..d0b48c6ed171 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
 obj-$(CONFIG_UTS_NS) += utsname.o
+obj-$(CONFIG_TIME_NS) += time_namespace.o
 obj-$(CONFIG_USER_NS) += user_namespace.o
 obj-$(CONFIG_PID_NS) += pid_namespace.o
 obj-$(CONFIG_IKCONFIG) += configs.o
diff --git a/kernel/fork.c b/kernel/fork.c
index b84534b6a463..23eed98b68bb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1804,6 +1804,7 @@ static __latent_entropy struct task_struct *copy_process(
 	struct multiprocess_signals delayed;
 	struct file *pidfile = NULL;
 	u64 clone_flags = args->flags;
+	struct nsproxy *nsp = current->nsproxy;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1846,8 +1847,16 @@ static __latent_entropy struct task_struct *copy_process(
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
+		if (nsp->time_ns != nsp->time_ns_for_children)
 			return ERR_PTR(-EINVAL);
 	}
 
@@ -2739,7 +2748,8 @@ static int check_unshare_flags(unsigned long unshare_flags)
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
 				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
-				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP))
+				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
+				CLONE_NEWTIME))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
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
index 000000000000..8fd8384b7261
--- /dev/null
+++ b/kernel/time_namespace.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Andrei Vagin <avagin@openvz.org>
+ * Author: Dmitry Safonov <dima@arista.com>
+ */
+
+#include <linux/time_namespace.h>
+#include <linux/user_namespace.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
+#include <linux/proc_ns.h>
+#include <linux/export.h>
+#include <linux/time.h>
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/err.h>
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
+	if (!current_is_single_threaded())
+		return -EUSERS;
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
+	.ns.inum = PROC_TIME_INIT_INO,
+	.ns.ops = &timens_operations,
+};
+
+static int __init time_ns_init(void)
+{
+	return 0;
+}
+subsys_initcall(time_ns_init);
-- 
2.22.0

