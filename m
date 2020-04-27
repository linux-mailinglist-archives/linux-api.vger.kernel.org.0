Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801E91BAB3E
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgD0R3Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgD0R3Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 13:29:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44100C03C1A8
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 10:29:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b2so18442355ljp.4
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHuBjEFsXuCOnXrDPerkRVxxxGJlefJzzkBgVwYtJlA=;
        b=QALnd6imJ7V1ZuG0QY9Bq/9Z9J1unuBZ9xPj6KDxnYPc7fE4lJB9FjEFiP03awwA3b
         zb92lKkogwPFCwFlntiLQ99F5H75z+x8WzXhoPMhhvlWFvDQWXj2cYnZUSCLhGNeLVH3
         Wu6HU4F6I0ezMQ/bFDI9rQDlpnTEZ3wrIJYoZQmdRPTh3pdEsoZAT47tzLqkSGDIjpQy
         tmlUnZwLfgtwDZ69d33p8fJFSwztMFMQ7TD9ZZwVoht1dQHhyFO54Ny3fBd/zbgLm/MQ
         W7tuhO0gvn0im4FWdXx/ffwDttk/8EC2jVjhCbp0iO8kAIYiTqIiJjT9kL0duhgGyvCF
         UcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHuBjEFsXuCOnXrDPerkRVxxxGJlefJzzkBgVwYtJlA=;
        b=V06rOKTLeXLspPLMSd4Tpy6dVRSQP3mMAyxoL1L1TS+a9GIujlrIZrnsu6FBNyoLbJ
         H2O444kIhXFyYoKyQq5r0AtlvyBR95gc8q3757MfecFHfZPGDWlN+osqxjlWZ+f14N+4
         92shATpJZfJduTYP/S8JtqBnijO1WdEPhuEQM/nF3DctCRKcJAc1W5UYLAmL461UlwpD
         BxF8Ek7/VDfNmJo7QSW3OFlHXxmW3dzSDS986xBWd0iQazNBVf6sSDmc37PR11FnWm8b
         UCkOoVc0ZE0qHUvrX9cdmz0VWHSLBe6mokrT5z4sZOQHUO+d49e3+T8CQBdP+u1JYQrB
         mLfA==
X-Gm-Message-State: AGi0PubvS3TA7lLGAax5cwJTtpLTEyDOmHwTg68oiQsOy3W9QSUhC9Dk
        7mqlpyUP6mt7SuRA71OR+Crzy7zBbz4x5pVZf0SZDA==
X-Google-Smtp-Source: APiQypLRikU2kj4lwV6Hlv63XRM9RyOKCs8RknvaYiOvJdZc7VVr5C780JaTVTCUKgNwbuwUujWo/vMtAOfrKhTqrI8=
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr14032917ljj.176.1588008563374;
 Mon, 27 Apr 2020 10:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200427143646.619227-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200427143646.619227-1-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Apr 2020 19:28:56 +0200
Message-ID: <CAG48ez3eSJSODADpo=O-j9txJ=2R+EupunRvs5H9t5Wa8mvkRA@mail.gmail.com>
Subject: Re: [PATCH] nsproxy: attach to namespaces via pidfds
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 27, 2020 at 4:47 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> For quite a while we have been thinking about using pidfds to attach to
> namespaces. This patchset has existed for about a year already but we've
> wanted to wait to see how the general api would be received and adopted.
> Now that more and more programs in userspace have started using pidfds
> for process management it's time to send this one out.

You can already reliably switch to a specific namespace of another
process like this given a pidfd and the pid of the process (which, if
you don't have it, you can get via fdinfo), right?

int switch_ns_to(int pidfd, int pid, char *nstypename) {
  char ns_path[100];
  snprintf(ns_path, sizeof(ns_path), "/proc/%d/ns/%s", pid, nstypename);
  int fd = open(ns_path, O_RDONLY|O_CLOEXEC);
  int errno_after_open = errno;

  if (pidfd_send_signal(pidfd, 0, NULL, 0))
    return -1;

  if (fd == -1) {
    errno = errno_after_open;
    return -1;
  }

  int ret = setns(fd, 0);
  close(fd);
  return ret;
}

> This patch makes it possible to use pidfds to attach to the namespaces
> of another process, i.e. they can be passed as the first argument to the
> setns() syscall. When only a single namespace type is specified the
> semantics are equivalent to passing an nsfd.

This introduces a difference in terms of security: With the old API,
you need PTRACE_MODE_READ_FSCREDS on the task whose namespace you're
attaching to (to dereference the link /proc/*/ns/*) *AND* whatever
access checks the namespace itself enforces (always includes a check
for CAP_SYS_ADMIN on the namespace). The ptrace check has the
advantage, among other things, that it allows an LSM to see the
relationship between the task that's accessing the namespace (subject)
and the task whose namespace is being accessed (object).

I feel slightly twitchy about this relaxation, and I'm wondering
whether we can add a ptrace access check analogous to what you'd have
needed via procfs.

> That means
> setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET). However,
> when a pidfd is passed, multiple namespace flags can be specified in the
> second setns() argument and setns() will attach the caller to all the
> specified namespaces all at once or to none of them. If 0 is specified
> together with a pidfd then setns() will interpret it the same way 0 is
> interpreted together with a nsfd argument, i.e. attach to any/all
> namespaces.
[...]
> Apart from significiantly reducing the number of syscalls from double
> digit to single digit which is a decent reason post-spectre/meltdown
> this also allows to switch to a set of namespaces atomically, i.e.
> either attaching to all the specified namespaces succeeds or we fail.

Apart from the issues I've pointed out below, I think it's worth
calling out explicitly that with the current design, the switch will
not, in fact, be fully atomic - the process will temporarily be in
intermediate stages where the switches to some namespaces have
completed while the switches to other namespaces are still pending;
and while there will be less of these intermediate stages than before,
it also means that they will be less explicit to userspace.

[...]
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
[...]
> +/*
> + * Ordering is equivalent to the standard ordering used everywhere
> + * else during unshare and process creation.
> + */
> +static int ns_install(struct nsproxy *nsproxy, struct pid *pid, int flags)
> +{
> +       int ret = 0;
> +       struct task_struct *tsk;
> +       struct nsproxy *nsp;
> +
> +       tsk = get_pid_task(pid, PIDTYPE_PID);
> +       if (!tsk)
> +               return -ESRCH;
> +
> +       get_nsproxy(tsk->nsproxy);
> +       nsp = tsk->nsproxy;

How is this correct? Are you holding any locks that protect tsk->nsproxy?

> +#ifdef CONFIG_USER_NS
> +       if (wants_ns(flags, CLONE_NEWUSER)) {
> +               struct user_namespace *user_ns;
> +
> +               user_ns = get_user_ns(__task_cred(tsk)->user_ns);
> +               ret = __ns_install(nsproxy, &user_ns->ns);

If ret == 0, then at this point you've already committed the user
namespace change *to the calling process*. The ->install handler of
user namespaces doesn't touch the nsproxy at all.

> +               put_user_ns(user_ns);
> +       }
> +#else
> +       if (flags & CLONE_NEWUSER)
> +               ret = -EINVAL;
> +#endif
> +
> +       if (!ret && wants_ns(flags, CLONE_NEWNS))
> +               ret = __ns_install(nsproxy, mnt_ns_to_common(nsp->mnt_ns));

And this one might be even worse, because the mount namespace change
itself is only stored in the nsproxy at this point, but the cwd and
root paths have already been overwritten on the task's fs_struct.

To actually make sys_set_ns() atomic, I think you'd need some
moderately complicated prep work, splitting the ->install handlers up
into prep work and a commit phase that can't fail.

[...]
> +#ifdef CONFIG_PID_NS
> +       if (!ret && wants_ns(flags, CLONE_NEWPID)) {
> +               struct pid_namespace *pidns;
> +
> +               pidns = task_active_pid_ns(tsk);
> +               if (pidns) {
> +                       get_pid_ns(pidns);
> +                       ret = __ns_install(nsproxy, &pidns->ns);
> +                       put_pid_ns(pidns);
> +               }

If you can't get the task's pidns, shouldn't that be an error?

> +       }
[...]
