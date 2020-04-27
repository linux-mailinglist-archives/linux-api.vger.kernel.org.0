Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68521BAC1E
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD0SPZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 14:15:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40121 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0SPY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 14:15:24 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jT8Hd-0003H6-D9; Mon, 27 Apr 2020 18:15:09 +0000
Date:   Mon, 27 Apr 2020 20:15:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] nsproxy: attach to namespaces via pidfds
Message-ID: <20200427181507.ry3hw7ufiifwhi5k@wittgenstein>
References: <20200427143646.619227-1-christian.brauner@ubuntu.com>
 <CAG48ez3eSJSODADpo=O-j9txJ=2R+EupunRvs5H9t5Wa8mvkRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3eSJSODADpo=O-j9txJ=2R+EupunRvs5H9t5Wa8mvkRA@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 27, 2020 at 07:28:56PM +0200, Jann Horn wrote:
> On Mon, Apr 27, 2020 at 4:47 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > For quite a while we have been thinking about using pidfds to attach to
> > namespaces. This patchset has existed for about a year already but we've
> > wanted to wait to see how the general api would be received and adopted.
> > Now that more and more programs in userspace have started using pidfds
> > for process management it's time to send this one out.
> 
> You can already reliably switch to a specific namespace of another
> process like this given a pidfd and the pid of the process (which, if
> you don't have it, you can get via fdinfo), right?

Yep, of course. See the sample program in my earlier response. But that
wasn't the point as I've tried to stress in the commit message. 

> 
> int switch_ns_to(int pidfd, int pid, char *nstypename) {
>   char ns_path[100];
>   snprintf(ns_path, sizeof(ns_path), "/proc/%d/ns/%s", pid, nstypename);
>   int fd = open(ns_path, O_RDONLY|O_CLOEXEC);
>   int errno_after_open = errno;
> 
>   if (pidfd_send_signal(pidfd, 0, NULL, 0))
>     return -1;
> 
>   if (fd == -1) {
>     errno = errno_after_open;
>     return -1;
>   }
> 
>   int ret = setns(fd, 0);
>   close(fd);
>   return ret;
> }
> 
> > This patch makes it possible to use pidfds to attach to the namespaces
> > of another process, i.e. they can be passed as the first argument to the
> > setns() syscall. When only a single namespace type is specified the
> > semantics are equivalent to passing an nsfd.
> 
> This introduces a difference in terms of security: With the old API,
> you need PTRACE_MODE_READ_FSCREDS on the task whose namespace you're
> attaching to (to dereference the link /proc/*/ns/*) *AND* whatever
> access checks the namespace itself enforces (always includes a check
> for CAP_SYS_ADMIN on the namespace). The ptrace check has the
> advantage, among other things, that it allows an LSM to see the
> relationship between the task that's accessing the namespace (subject)
> and the task whose namespace is being accessed (object).
> 
> I feel slightly twitchy about this relaxation, and I'm wondering
> whether we can add a ptrace access check analogous to what you'd have
> needed via procfs.

Right, that's probably a sane requirement.

> 
> > That means
> > setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET). However,
> > when a pidfd is passed, multiple namespace flags can be specified in the
> > second setns() argument and setns() will attach the caller to all the
> > specified namespaces all at once or to none of them. If 0 is specified
> > together with a pidfd then setns() will interpret it the same way 0 is
> > interpreted together with a nsfd argument, i.e. attach to any/all
> > namespaces.
> [...]
> > Apart from significiantly reducing the number of syscalls from double
> > digit to single digit which is a decent reason post-spectre/meltdown
> > this also allows to switch to a set of namespaces atomically, i.e.
> > either attaching to all the specified namespaces succeeds or we fail.
> 
> Apart from the issues I've pointed out below, I think it's worth
> calling out explicitly that with the current design, the switch will
> not, in fact, be fully atomic - the process will temporarily be in
> intermediate stages where the switches to some namespaces have
> completed while the switches to other namespaces are still pending;
> and while there will be less of these intermediate stages than before,
> it also means that they will be less explicit to userspace.

Right, that can be fixed by switching to the unshare model of getting a
new set of credentials and committing it after the nsproxy has been
installed? Then there shouldn't be an intermediate state anymore or
rather an intermediate stage where we can still fail somehow.

> 
> [...]
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> [...]
> > +/*
> > + * Ordering is equivalent to the standard ordering used everywhere
> > + * else during unshare and process creation.
> > + */
> > +static int ns_install(struct nsproxy *nsproxy, struct pid *pid, int flags)
> > +{
> > +       int ret = 0;
> > +       struct task_struct *tsk;
> > +       struct nsproxy *nsp;
> > +
> > +       tsk = get_pid_task(pid, PIDTYPE_PID);
> > +       if (!tsk)
> > +               return -ESRCH;
> > +
> > +       get_nsproxy(tsk->nsproxy);
> > +       nsp = tsk->nsproxy;
> 
> How is this correct? Are you holding any locks that protect tsk->nsproxy?

You're absolutely right, this misses task_lock().


> 
> > +#ifdef CONFIG_USER_NS
> > +       if (wants_ns(flags, CLONE_NEWUSER)) {
> > +               struct user_namespace *user_ns;
> > +
> > +               user_ns = get_user_ns(__task_cred(tsk)->user_ns);
> > +               ret = __ns_install(nsproxy, &user_ns->ns);
> 
> If ret == 0, then at this point you've already committed the user
> namespace change *to the calling process*. The ->install handler of
> user namespaces doesn't touch the nsproxy at all.

Yeah, I think this can be fixed by copying the unshare model.

> 
> > +               put_user_ns(user_ns);
> > +       }
> > +#else
> > +       if (flags & CLONE_NEWUSER)
> > +               ret = -EINVAL;
> > +#endif
> > +
> > +       if (!ret && wants_ns(flags, CLONE_NEWNS))
> > +               ret = __ns_install(nsproxy, mnt_ns_to_common(nsp->mnt_ns));
> 
> And this one might be even worse, because the mount namespace change
> itself is only stored in the nsproxy at this point, but the cwd and
> root paths have already been overwritten on the task's fs_struct.
> 
> To actually make sys_set_ns() atomic, I think you'd need some
> moderately complicated prep work, splitting the ->install handlers up
> into prep work and a commit phase that can't fail.

Wouldn't it be sufficient to move to an unshare like model, i.e.
creating a new set of creds, and passing the new user_ns to
create_new_namespaces() as well as having a temporary new_fs struct?
That should get rid of all intermediate stages.

> 
> [...]
> > +#ifdef CONFIG_PID_NS
> > +       if (!ret && wants_ns(flags, CLONE_NEWPID)) {
> > +               struct pid_namespace *pidns;
> > +
> > +               pidns = task_active_pid_ns(tsk);
> > +               if (pidns) {
> > +                       get_pid_ns(pidns);
> > +                       ret = __ns_install(nsproxy, &pidns->ns);
> > +                       put_pid_ns(pidns);
> > +               }
> 
> If you can't get the task's pidns, shouldn't that be an error?

Yep, that's right. Thanks!

Christian
