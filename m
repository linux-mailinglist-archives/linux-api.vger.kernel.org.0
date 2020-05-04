Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A971C3FAC
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2020 18:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgEDQTd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 May 2020 12:19:33 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47954 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgEDQTd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 May 2020 12:19:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jVdoY-00028A-As; Mon, 04 May 2020 10:19:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jVdoK-0006sQ-2F; Mon, 04 May 2020 10:19:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org
References: <20200504144141.3605533-1-christian.brauner@ubuntu.com>
        <20200504144141.3605533-2-christian.brauner@ubuntu.com>
Date:   Mon, 04 May 2020 11:15:54 -0500
In-Reply-To: <20200504144141.3605533-2-christian.brauner@ubuntu.com>
        (Christian Brauner's message of "Mon, 4 May 2020 16:41:39 +0200")
Message-ID: <87wo5roev9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jVdoK-0006sQ-2F;;;mid=<87wo5roev9.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19s9XilEgKCflxk3PVw2Z9qDUxK+Oca3oU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,
        T_XMDrugObfuBody_08 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1690 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (0.6%), b_tie_ro: 9 (0.5%), parse: 2.4 (0.1%),
        extract_message_metadata: 42 (2.5%), get_uri_detail_list: 13 (0.7%),
        tests_pri_-1000: 47 (2.8%), tests_pri_-950: 1.70 (0.1%),
        tests_pri_-900: 1.55 (0.1%), tests_pri_-90: 241 (14.3%), check_bayes:
        219 (13.0%), b_tokenize: 27 (1.6%), b_tok_get_all: 102 (6.1%),
        b_comp_prob: 7 (0.4%), b_tok_touch_all: 78 (4.6%), b_finish: 0.95
        (0.1%), tests_pri_0: 1320 (78.1%), check_dkim_signature: 0.84 (0.0%),
        check_dkim_adsp: 2.2 (0.1%), poll_dns_idle: 0.53 (0.0%), tests_pri_10:
        3.3 (0.2%), tests_pri_500: 14 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 1/3] nsproxy: add struct nsset
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Add a simple struct nsset. It holds all necessary pieces to switch to a new
> set of namespaces without leaving a task in a half-switched state which we
> will make use of in the next patch. This patch simply switches the existing
> setns logic over without causing a change in setns() behavior. This brings
> setns() closer to how unshare() works(). The prepare_ns() function is
> responsible to prepare all necessary information. This has two reasons.
> First it minimizes dependencies between individual namespaces, i.e. all
> install handler can expect that all fields are properly initialized
> independent in what order they are called in. Second, this makes the code
> easier to maintain and easier to follow if it needs to be changed.

This is buggy.

Your code assume that nstype == 0 is invalid.

Passing nstype == 0 means don't verify the kind of file descriptor
passed.

Quite frankly doing nstype & CLONE_XYZ is wrong.  It always
needs to be nstype == CLONE_XYZ.

Maybe we change that in a later patch but here where you are just
upgrading the infrastructure semantics changes are not ok.

Eric


> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> patch introduced
>
> /* v3 */
> - Eric W. Biederman <ebiederm@xmission.com>:
>   - Remove the prior ns_capable_cred() patch and simplify the permission
>     check from ns_capable_cred(nsset, nsset->cred->user_ns, CAP_SYS_ADMIN))
>     to from ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN)).
> patch introduced
> ---
>  fs/namespace.c                | 10 ++--
>  include/linux/mnt_namespace.h |  1 +
>  include/linux/nsproxy.h       | 24 +++++++++
>  include/linux/proc_ns.h       |  4 +-
>  ipc/namespace.c               |  7 ++-
>  kernel/cgroup/namespace.c     |  5 +-
>  kernel/nsproxy.c              | 94 ++++++++++++++++++++++++++++++-----
>  kernel/pid_namespace.c        |  5 +-
>  kernel/time/namespace.c       |  5 +-
>  kernel/user_namespace.c       |  8 +--
>  kernel/utsname.c              |  5 +-
>  net/core/net_namespace.c      |  5 +-
>  12 files changed, 137 insertions(+), 36 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a28e4db075ed..62899fad4a04 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3954,16 +3954,18 @@ static void mntns_put(struct ns_common *ns)
>  	put_mnt_ns(to_mnt_ns(ns));
>  }
>  
> -static int mntns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> +static int mntns_install(struct nsset *nsset, struct ns_common *ns)
>  {
> -	struct fs_struct *fs = current->fs;
> +	struct nsproxy *nsproxy = nsset->nsproxy;
> +	struct fs_struct *fs = nsset->fs;
>  	struct mnt_namespace *mnt_ns = to_mnt_ns(ns), *old_mnt_ns;
> +	struct user_namespace *user_ns = nsset->cred->user_ns;
>  	struct path root;
>  	int err;
>  
>  	if (!ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN) ||
> -	    !ns_capable(current_user_ns(), CAP_SYS_CHROOT) ||
> -	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +	    !ns_capable(user_ns, CAP_SYS_CHROOT) ||
> +	    !ns_capable(user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	if (is_anon_ns(mnt_ns))
> diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
> index 35942084cd40..007cfa52efb2 100644
> --- a/include/linux/mnt_namespace.h
> +++ b/include/linux/mnt_namespace.h
> @@ -6,6 +6,7 @@
>  struct mnt_namespace;
>  struct fs_struct;
>  struct user_namespace;
> +struct ns_common;
>  
>  extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
>  		struct user_namespace *, struct fs_struct *);
> diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
> index 074f395b9ad2..cdb171efc7cb 100644
> --- a/include/linux/nsproxy.h
> +++ b/include/linux/nsproxy.h
> @@ -41,6 +41,30 @@ struct nsproxy {
>  };
>  extern struct nsproxy init_nsproxy;
>  
> +/*
> + * A structure to encompass all bits needed to install
> + * a partial or complete new set of namespaces.
> + *
> + * If a new user namespace is requested cred will
> + * point to a modifiable set of credentials. If a pointer
> + * to a modifiable set is needed nsset_cred() must be
> + * used and tested.
> + */
> +struct nsset {
> +	unsigned flags;
> +	struct nsproxy *nsproxy;
> +	struct fs_struct *fs;
> +	const struct cred *cred;
> +};
> +
> +static inline struct cred *nsset_cred(struct nsset *set)
> +{
> +	if (set->flags & CLONE_NEWUSER)
> +		return (struct cred *)set->cred;
> +
> +	return NULL;
> +}
> +
>  /*
>   * the namespaces access rules are:
>   *
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 6abe85c34681..75807ecef880 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -8,7 +8,7 @@
>  #include <linux/ns_common.h>
>  
>  struct pid_namespace;
> -struct nsproxy;
> +struct nsset;
>  struct path;
>  struct task_struct;
>  struct inode;
> @@ -19,7 +19,7 @@ struct proc_ns_operations {
>  	int type;
>  	struct ns_common *(*get)(struct task_struct *task);
>  	void (*put)(struct ns_common *ns);
> -	int (*install)(struct nsproxy *nsproxy, struct ns_common *ns);
> +	int (*install)(struct nsset *nsset, struct ns_common *ns);
>  	struct user_namespace *(*owner)(struct ns_common *ns);
>  	struct ns_common *(*get_parent)(struct ns_common *ns);
>  } __randomize_layout;
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index b3ca1476ca51..fdc3b5f3f53a 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -177,15 +177,14 @@ static void ipcns_put(struct ns_common *ns)
>  	return put_ipc_ns(to_ipc_ns(ns));
>  }
>  
> -static int ipcns_install(struct nsproxy *nsproxy, struct ns_common *new)
> +static int ipcns_install(struct nsset *nsset, struct ns_common *new)
>  {
> +	struct nsproxy *nsproxy = nsset->nsproxy;
>  	struct ipc_namespace *ns = to_ipc_ns(new);
>  	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> -	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> -	/* Ditch state from the old ipc namespace */
> -	exit_sem(current);
>  	put_ipc_ns(nsproxy->ipc_ns);
>  	nsproxy->ipc_ns = get_ipc_ns(ns);
>  	return 0;
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index b05f1dd58a62..812a61afd538 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -95,11 +95,12 @@ static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
>  	return container_of(ns, struct cgroup_namespace, ns);
>  }
>  
> -static int cgroupns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> +static int cgroupns_install(struct nsset *nsset, struct ns_common *ns)
>  {
> +	struct nsproxy *nsproxy = nsset->nsproxy;
>  	struct cgroup_namespace *cgroup_ns = to_cg_ns(ns);
>  
> -	if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN) ||
> +	if (!ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN) ||
>  	    !ns_capable(cgroup_ns->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index ed9882108cd2..2da463bab58a 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -19,6 +19,7 @@
>  #include <net/net_namespace.h>
>  #include <linux/ipc_namespace.h>
>  #include <linux/time_namespace.h>
> +#include <linux/fs_struct.h>
>  #include <linux/proc_ns.h>
>  #include <linux/file.h>
>  #include <linux/syscalls.h>
> @@ -257,12 +258,85 @@ void exit_task_namespaces(struct task_struct *p)
>  	switch_task_namespaces(p, NULL);
>  }
>  
> +static void put_nsset(struct nsset *nsset)
> +{
> +	unsigned flags = nsset->flags;
> +
> +	if (flags & CLONE_NEWUSER)
> +		put_cred(nsset_cred(nsset));
> +	if (nsset->nsproxy)
> +		free_nsproxy(nsset->nsproxy);
> +}
> +
> +static int prepare_nsset(unsigned flags, struct nsset *nsset)
> +{
> +	struct task_struct *me = current;
> +
> +	nsset->nsproxy = create_new_namespaces(0, me, current_user_ns(), me->fs);
> +	if (IS_ERR(nsset->nsproxy))
> +		return PTR_ERR(nsset->nsproxy);
> +
> +	if (flags & CLONE_NEWUSER)
> +		nsset->cred = prepare_creds();
> +	else
> +		nsset->cred = current_cred();
> +	if (!nsset->cred)
> +		goto out;
> +
> +	if (flags & CLONE_NEWNS)
> +		nsset->fs = me->fs;
> +
> +	nsset->flags = flags;
> +	return 0;
> +
> +out:
> +	put_nsset(nsset);
> +	return -ENOMEM;
> +}
> +
> +/*
> + * This is the point of no return. There are just a few namespaces
> + * that do some actual work here and it's sufficiently minimal that
> + * a separate ns_common operation seems unnecessary for now.
> + * Unshare is doing the same thing. If we'll end up needing to do
> + * more in a given namespace or a helper here is ultimately not
> + * exported anymore a simple commit handler for each namespace
> + * should be added to ns_common.
> + */
> +static void commit_nsset(struct nsset *nsset)
> +{
> +	unsigned flags = nsset->flags;
> +	struct task_struct *me = current;
> +
> +#ifdef CONFIG_USER_NS
> +	if (flags & CLONE_NEWUSER) {
> +		/* transfer ownership */
> +		commit_creds(nsset_cred(nsset));
> +		nsset->cred = NULL;
> +	}
> +#endif
> +
> +#ifdef CONFIG_IPC_NS
> +	if (flags & CLONE_NEWIPC)
> +		exit_sem(me);
> +#endif
> +
> +	/* transfer ownership */
> +	switch_task_namespaces(me, nsset->nsproxy);
> +	nsset->nsproxy = NULL;
> +}
> +
> +static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
> +{
> +	return ns->ops->install(nsset, ns);
> +}
> +
>  SYSCALL_DEFINE2(setns, int, fd, int, nstype)
>  {
>  	struct task_struct *tsk = current;
> -	struct nsproxy *new_nsproxy;
>  	struct file *file;
>  	struct ns_common *ns;
> +	struct nsset nsset = {};
>  	int err;
>  
>  	file = proc_ns_fget(fd);
> @@ -274,20 +348,16 @@ SYSCALL_DEFINE2(setns, int, fd, int, nstype)
>  	if (nstype && (ns->ops->type != nstype))
>  		goto out;
>  
> -	new_nsproxy = create_new_namespaces(0, tsk, current_user_ns(), tsk->fs);
> -	if (IS_ERR(new_nsproxy)) {
> -		err = PTR_ERR(new_nsproxy);
> +	err = prepare_nsset(nstype, &nsset);
> +	if (err)
>  		goto out;
> -	}
>  
> -	err = ns->ops->install(new_nsproxy, ns);
> -	if (err) {
> -		free_nsproxy(new_nsproxy);
> -		goto out;
> +	err = validate_ns(&nsset, ns);
> +	if (!err) {
> +		commit_nsset(&nsset);
> +		perf_event_namespaces(tsk);
>  	}
> -	switch_task_namespaces(tsk, new_nsproxy);
> -
> -	perf_event_namespaces(tsk);
> +	put_nsset(&nsset);
>  out:
>  	fput(file);
>  	return err;
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 01f8ba32cc0c..11db2bdbb41e 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -378,13 +378,14 @@ static void pidns_put(struct ns_common *ns)
>  	put_pid_ns(to_pid_ns(ns));
>  }
>  
> -static int pidns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> +static int pidns_install(struct nsset *nsset, struct ns_common *ns)
>  {
> +	struct nsproxy *nsproxy = nsset->nsproxy;
>  	struct pid_namespace *active = task_active_pid_ns(current);
>  	struct pid_namespace *ancestor, *new = to_pid_ns(ns);
>  
>  	if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
> -	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	/*
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 53bce347cd50..5d9fc22d836a 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -280,8 +280,9 @@ static void timens_put(struct ns_common *ns)
>  	put_time_ns(to_time_ns(ns));
>  }
>  
> -static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
> +static int timens_install(struct nsset *nsset, struct ns_common *new)
>  {
> +	struct nsproxy *nsproxy = nsset->nsproxy;
>  	struct time_namespace *ns = to_time_ns(new);
>  	int err;
>  
> @@ -289,7 +290,7 @@ static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
>  		return -EUSERS;
>  
>  	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> -	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	timens_set_vvar_page(current, ns);
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 8eadadc478f9..87804e0371fe 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1253,7 +1253,7 @@ static void userns_put(struct ns_common *ns)
>  	put_user_ns(to_user_ns(ns));
>  }
>  
> -static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> +static int userns_install(struct nsset *nsset, struct ns_common *ns)
>  {
>  	struct user_namespace *user_ns = to_user_ns(ns);
>  	struct cred *cred;
> @@ -1274,14 +1274,14 @@ static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>  	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> -	cred = prepare_creds();
> +	cred = nsset_cred(nsset);
>  	if (!cred)
> -		return -ENOMEM;
> +		return -EINVAL;
>  
>  	put_user_ns(cred->user_ns);
>  	set_cred_user_ns(cred, get_user_ns(user_ns));
>  
> -	return commit_creds(cred);
> +	return 0;
>  }
>  
>  struct ns_common *ns_get_owner(struct ns_common *ns)
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index f0e491193009..e488d0e2ab45 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -140,12 +140,13 @@ static void utsns_put(struct ns_common *ns)
>  	put_uts_ns(to_uts_ns(ns));
>  }
>  
> -static int utsns_install(struct nsproxy *nsproxy, struct ns_common *new)
> +static int utsns_install(struct nsset *nsset, struct ns_common *new)
>  {
> +	struct nsproxy *nsproxy = nsset->nsproxy;
>  	struct uts_namespace *ns = to_uts_ns(new);
>  
>  	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> -	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	get_uts_ns(ns);
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 190ca66a383b..dcd61aca343e 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -1353,12 +1353,13 @@ static void netns_put(struct ns_common *ns)
>  	put_net(to_net_ns(ns));
>  }
>  
> -static int netns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> +static int netns_install(struct nsset *nsset, struct ns_common *ns)
>  {
> +	struct nsproxy *nsproxy = nsset->nsproxy;
>  	struct net *net = to_net_ns(ns);
>  
>  	if (!ns_capable(net->user_ns, CAP_SYS_ADMIN) ||
> -	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	put_net(nsproxy->net_ns);
