Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE491C0342
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD3Q5h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 12:57:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54561 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgD3Q5g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 12:57:36 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jUCVB-0005V3-TD; Thu, 30 Apr 2020 16:57:34 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 3/4] nsproxy: attach to namespaces via pidfds
Date:   Thu, 30 Apr 2020 18:57:16 +0200
Message-Id: <20200430165717.1001605-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430165717.1001605-1-christian.brauner@ubuntu.com>
References: <20200430165717.1001605-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

For quite a while we have been thinking about using pidfds to attach to
namespaces. This patchset has existed for about a year already but we've
wanted to wait to see how the general api would be received and adopted.
Now that more and more programs in userspace have started using pidfds
for process management it's time to send this one out.

This patch makes it possible to use pidfds to attach to the namespaces
of another process, i.e. they can be passed as the first argument to the
setns() syscall. When only a single namespace type is specified the
semantics are equivalent to passing an nsfd. That means
setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET). However,
when a pidfd is passed, multiple namespace flags can be specified in the
second setns() argument and setns() will attach the caller to all the
specified namespaces all at once or to none of them. Specifying 0 is not
valid together with a pidfd.

The obvious example where this is useful is a standard container
manager interacting with a running container: pushing and pulling files
or directories, injecting mounts, attaching/execing any kind of process,
managing network devices all these operations require attaching to all
or at least multiple namespaces at the same time. Given that nowadays
most containers are spawned with all namespaces enabled we're currently
looking at at least 14 syscalls, 7 to open the /proc/<pid>/ns/<ns>
nsfds, another 7 to actually perform the namespace switch. With time
namespaces we're looking at about 16 syscalls.
(We could amortize the first 7 or 8 syscalls for opening the nsfds by
 stashing them in each container's monitor process but that would mean
 we need to send around those file descriptors through unix sockets
 everytime we want to interact with the container or keep on-disk
 state. Even in scenarios where a caller wants to join a particular
 namespace in a particular order callers still profit from batching
 other namespaces. That mostly applies to the user namespace but
 all container runtimes I found join the user namespace first no matter
 if it privileges or deprivileges the container similar to how unshare
 behaves.)
With pidfds this becomes a single syscall no matter how many namespaces
are supposed to be attached to.

A decently designed, large-scale container manager usually isn't the
parent of any of the containers it spawns so the containers don't die
when it crashes or needs to update or reinitialize. This means that
for the manager to interact with containers through pids is inherently
racy especially on systems where the maximum pid number is not
significicantly bumped. This is even more problematic since we often spawn
and manage thousands or ten-thousands of containers. Interacting with a
container through a pid thus can become risky quite quickly. Especially
since we allow for an administrator to enable advanced features such as
syscall interception where we're performing syscalls in lieu of the
container. In all of those cases we use pidfds if they are available and
we pass them around as stable references. Using them to setns() to the
target process' namespaces is as reliable as using nsfds. Either the
target process is already dead and we get ESRCH or we manage to attach
to its namespaces but we can't accidently attach to another process'
namespaces. So pidfds lend themselves to be used with this api.
The other main advantage is that with this change the pidfd becomes the
only relevant token for most container interactions and it's the only
token we need to create and send around.

Apart from significiantly reducing the number of syscalls from double
digit to single digit which is a decent reason post-spectre/meltdown
this also allows to switch to a set of namespaces atomically, i.e.
either attaching to all the specified namespaces succeeds or we fail. If
we fail we haven't changed a single namespace. There are currently three
namespaces that can fail (other than for ENOMEM which really is not
very interesting since we then have other problems anyway) for
non-trivial reasons, user, mount, and pid namespaces. We can fail to
attach to a pid namespace if it is not our current active pid namespace
or a descendant of it. We can fail to attach to a user namespace because
we are multi-threaded or because our current mount namespace shares
filesystem state with other tasks, or because we're trying to setns()
to the same user namespace, i.e. the target task has the same user
namespace as we do. We can fail to attach to a mount namespace because
it shares filesystem state with other tasks or because we fail to lookup
the new root for the new mount namespace. In most non-pathological
scenarios these issues can be somewhat mitigated. But there are cases where
we're half-attached to some namespace and failing to attach to another one.
I've talked about some of these problem during the hallway track (something
only the pre-COVID-19 generation will remember) of Plumbers in Los Angeles
in 2018(?). Even if all these issues could be avoided with super careful
userspace coding it would be nicer to have this done in-kernel. Pidfds seem
to lend themselves nicely for this.

The other neat thing about this is that setns() becomes an actual
counterpart to the namespace bits of unshare().

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
Seems that some people do in fact find this useful and I still have
hopes that I can potentially send this for v5.8. I've added some
expanded testing to this whole series to catch any mistakes.
The lifecycle management for various objects was certainly the
most interesting aspect so I'd appreciate a close look.
/* v2 */
- Michael Kerrisk <mtk.manpages@gmail.com>:
  - Michael pointed out that the semantics for setns(nsfd, 0) and
    setns(pidfd, 0) are not comparable. setns(pidfd, 0) is now
    disallowed completely. Users wanting to attach to all namespaces
    should simply specify them explicitly just as with unshare() and
    clone3().
- Jann Horn <jannh@google.com>:
  - Jann pointed out that the setns() in its first form wasn't atomic in
    that userspace could end up in an intermediate state where e.g. the
    process had moved into the target user namespace but failed to move
    into the target mount namespace.
    In this new version I've removed all intermediate states. There's an
    installation/preparation state and a commit state similar to
    prepare_creds() and commit_creds().
---
 fs/nsfs.c               |   7 +-
 include/linux/proc_fs.h |   6 ++
 kernel/nsproxy.c        | 228 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 222 insertions(+), 19 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 4f1205725cfe..b023c1a367c8 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -229,6 +229,11 @@ int ns_get_name(char *buf, size_t size, struct task_struct *task,
 	return res;
 }
 
+bool proc_ns_file(const struct file *file)
+{
+	return file->f_op == &ns_file_operations;
+}
+
 struct file *proc_ns_fget(int fd)
 {
 	struct file *file;
@@ -237,7 +242,7 @@ struct file *proc_ns_fget(int fd)
 	if (!file)
 		return ERR_PTR(-EBADF);
 
-	if (file->f_op != &ns_file_operations)
+	if (!proc_ns_file(file))
 		goto out_invalid;
 
 	return file;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 45c05fd9c99d..acfd5012db4e 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -104,6 +104,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 						    proc_write_t write,
 						    void *data);
 extern struct pid *tgid_pidfd_to_pid(const struct file *file);
+extern bool proc_ns_file(const struct file *file);
 
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
@@ -159,6 +160,11 @@ static inline struct pid *tgid_pidfd_to_pid(const struct file *file)
 	return ERR_PTR(-EBADF);
 }
 
+static inline bool proc_ns_file(const struct file *file)
+{
+	return false;
+}
+
 #endif /* CONFIG_PROC_FS */
 
 struct net;
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 2da463bab58a..8cae508acb9c 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -20,6 +20,7 @@
 #include <linux/ipc_namespace.h>
 #include <linux/time_namespace.h>
 #include <linux/fs_struct.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
@@ -258,12 +259,53 @@ void exit_task_namespaces(struct task_struct *p)
 	switch_task_namespaces(p, NULL);
 }
 
+static int check_setns_flags(unsigned long flags)
+{
+	if (!flags || (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
+				 CLONE_NEWNET | CLONE_NEWUSER | CLONE_NEWPID |
+				 CLONE_NEWCGROUP)))
+		return -EINVAL;
+
+#ifndef CONFIG_USER_NS
+	if (flags & CLONE_NEWUSER)
+		return -EINVAL;
+#endif
+#ifndef CONFIG_PID_NS
+	if (flags & CLONE_NEWPID)
+		return -EINVAL;
+#endif
+#ifndef CONFIG_UTS_NS
+	if (flags & CLONE_NEWUTS)
+		return -EINVAL;
+#endif
+#ifndef CONFIG_IPC_NS
+	if (flags & CLONE_NEWIPC)
+		return -EINVAL;
+#endif
+#ifndef CONFIG_CGROUPS
+	if (flags & CLONE_NEWCGROUP)
+		return -EINVAL;
+#endif
+#ifndef CONFIG_NET_NS
+	if (flags & CLONE_NEWNET)
+		return -EINVAL;
+#endif
+
+	return 0;
+}
+
 static void put_nsset(struct nsset *nsset)
 {
 	unsigned flags = nsset->flags;
 
 	if (flags & CLONE_NEWUSER)
 		put_cred(nsset_cred(nsset));
+	/*
+	 * We only created a temporary copy if we attached to more than just
+	 * the mount namespace.
+	 */
+	if (nsset->fs && (flags & CLONE_NEWNS) && (flags & ~CLONE_NEWNS))
+		free_fs_struct(nsset->fs);
 	if (nsset->nsproxy)
 		free_nsproxy(nsset->nsproxy);
 }
@@ -283,8 +325,14 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
 	if (!nsset->cred)
 		goto out;
 
-	if (flags & CLONE_NEWNS)
+	/* Only create a temporary copy of fs_struct if we really need to. */
+	if (flags == CLONE_NEWNS) {
 		nsset->fs = me->fs;
+	} else if (flags & CLONE_NEWNS) {
+		nsset->fs = copy_fs_struct(me->fs);
+		if (!nsset->fs)
+			goto out;
+	}
 
 	nsset->flags = flags;
 	return 0;
@@ -294,6 +342,138 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
 	return -ENOMEM;
 }
 
+static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
+{
+	return ns->ops->install(nsset, ns);
+}
+
+/*
+ * This is the inverse operation to unshare().
+ * Ordering is equivalent to the standard ordering used everywhere else
+ * during unshare and process creation. The switch to the new set of
+ * namespaces occurs at the point of no return after installation of
+ * all requested namespaces was successful in commit_nsset().
+ */
+static int validate_nsset(struct nsset *nsset, struct pid *pid)
+{
+	int ret = 0;
+	unsigned flags = nsset->flags;
+	struct user_namespace *user_ns = NULL;
+	struct pid_namespace *pid_ns = NULL;
+	struct nsproxy *nsp;
+	struct task_struct *tsk;
+
+	/* Take a "snapshot" of the target task's namespaces. */
+	rcu_read_lock();
+	tsk = pid_task(pid, PIDTYPE_PID);
+	if (!tsk) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	if (!ptrace_may_access(tsk, PTRACE_MODE_READ_REALCREDS)) {
+		rcu_read_unlock();
+		return -EPERM;
+	}
+
+	task_lock(tsk);
+	nsp = tsk->nsproxy;
+	if (nsp)
+		get_nsproxy(nsp);
+	task_unlock(tsk);
+	if (!nsp) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+#ifdef CONFIG_PID_NS
+	if (flags & CLONE_NEWPID) {
+		pid_ns = task_active_pid_ns(tsk);
+		if (unlikely(!pid_ns)) {
+			rcu_read_unlock();
+			ret = -ESRCH;
+			goto out;
+		}
+		get_pid_ns(pid_ns);
+	}
+#endif
+
+#ifdef CONFIG_USER_NS
+	if (flags & CLONE_NEWUSER)
+		user_ns = get_user_ns(__task_cred(tsk)->user_ns);
+#endif
+	rcu_read_unlock();
+
+	/*
+	 * Install requested namespaces. The caller will have
+	 * verified earlier that the requested namespaces are
+	 * supported on this kernel. We don't report errors here
+	 * if a namespace is requested that isn't supported.
+	 */
+#ifdef CONFIG_USER_NS
+	if (flags & CLONE_NEWUSER) {
+		ret = validate_ns(nsset, &user_ns->ns);
+		if (ret)
+			goto out;
+	}
+#endif
+
+	if (flags & CLONE_NEWNS) {
+		ret = validate_ns(nsset, mnt_ns_to_common(nsp->mnt_ns));
+		if (ret)
+			goto out;
+	}
+
+#ifdef CONFIG_UTS_NS
+	if (flags & CLONE_NEWUTS) {
+		ret = validate_ns(nsset, &nsp->uts_ns->ns);
+		if (ret)
+			goto out;
+	}
+#endif
+
+#ifdef CONFIG_IPC_NS
+	if (flags & CLONE_NEWIPC) {
+		ret = validate_ns(nsset, &nsp->ipc_ns->ns);
+		if (ret)
+			goto out;
+	}
+#endif
+
+#ifdef CONFIG_PID_NS
+	if (flags & CLONE_NEWPID) {
+		ret = validate_ns(nsset, &pid_ns->ns);
+		if (ret)
+			goto out;
+	}
+#endif
+
+#ifdef CONFIG_CGROUPS
+	if (flags & CLONE_NEWCGROUP) {
+		ret = validate_ns(nsset, &nsp->cgroup_ns->ns);
+		if (ret)
+			goto out;
+	}
+#endif
+
+#ifdef CONFIG_NET_NS
+	if (flags & CLONE_NEWNET) {
+		ret = validate_ns(nsset, &nsp->net_ns->ns);
+		if (ret)
+			goto out;
+	}
+#endif
+
+out:
+	if (pid_ns)
+		put_pid_ns(pid_ns);
+	if (nsp)
+		put_nsproxy(nsp);
+	put_user_ns(user_ns);
+
+	return ret;
+}
+
 /*
  * This is the point of no return. There are just a few namespaces
  * that do some actual work here and it's sufficiently minimal that
@@ -316,6 +496,12 @@ static void commit_nsset(struct nsset *nsset)
 	}
 #endif
 
+	/* We only need to commit if we have used a temporary fs_struct. */
+	if ((flags & CLONE_NEWNS) && (flags & ~CLONE_NEWNS)) {
+		set_fs_root(me->fs, &nsset->fs->root);
+		set_fs_pwd(me->fs, &nsset->fs->pwd);
+	}
+
 #ifdef CONFIG_IPC_NS
 	if (flags & CLONE_NEWIPC)
 		exit_sem(me);
@@ -326,33 +512,39 @@ static void commit_nsset(struct nsset *nsset)
 	nsset->nsproxy = NULL;
 }
 
-static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
-{
-	return ns->ops->install(nsset, ns);
-}
-
-SYSCALL_DEFINE2(setns, int, fd, int, nstype)
+SYSCALL_DEFINE2(setns, int, fd, int, flags)
 {
 	struct task_struct *tsk = current;
 	struct file *file;
-	struct ns_common *ns;
+	struct ns_common *ns = NULL;
 	struct nsset nsset = {};
-	int err;
-
-	file = proc_ns_fget(fd);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	int err = 0;
 
-	err = -EINVAL;
-	ns = get_proc_ns(file_inode(file));
-	if (nstype && (ns->ops->type != nstype))
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	if (proc_ns_file(file)) {
+		ns = get_proc_ns(file_inode(file));
+		if (flags && (ns->ops->type != flags))
+			err = -EINVAL;
+		flags = ns->ops->type;
+	} else if (pidfd_pid(file)) {
+		err = check_setns_flags(flags);
+	} else {
+		err = -EBADF;
+	}
+	if (err)
 		goto out;
 
-	err = prepare_nsset(nstype, &nsset);
+	err = prepare_nsset(flags, &nsset);
 	if (err)
 		goto out;
 
-	err = validate_ns(&nsset, ns);
+	if (proc_ns_file(file))
+		err = validate_ns(&nsset, ns);
+	else
+		err = validate_nsset(&nsset, file->private_data);
 	if (!err) {
 		commit_nsset(&nsset);
 		perf_event_namespaces(tsk);
-- 
2.26.2

