Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B8F1BAE66
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD0TsU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 15:48:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43192 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgD0TsU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 15:48:20 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jT9jk-0003p6-AT; Mon, 27 Apr 2020 19:48:16 +0000
Date:   Mon, 27 Apr 2020 21:48:15 +0200
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
Message-ID: <20200427194815.nc22k7mj543swk7z@wittgenstein>
References: <20200427143646.619227-1-christian.brauner@ubuntu.com>
 <CAG48ez3eSJSODADpo=O-j9txJ=2R+EupunRvs5H9t5Wa8mvkRA@mail.gmail.com>
 <20200427181507.ry3hw7ufiifwhi5k@wittgenstein>
 <CAG48ez2D36QZU0djiXGbirCgcFeAWA02s8PCk6SWEY5MoKg_kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2D36QZU0djiXGbirCgcFeAWA02s8PCk6SWEY5MoKg_kg@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 27, 2020 at 09:41:20PM +0200, Jann Horn wrote:
> On Mon, Apr 27, 2020 at 8:15 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Mon, Apr 27, 2020 at 07:28:56PM +0200, Jann Horn wrote:
> > > On Mon, Apr 27, 2020 at 4:47 PM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> [...]
> > > > That means
> > > > setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET). However,
> > > > when a pidfd is passed, multiple namespace flags can be specified in the
> > > > second setns() argument and setns() will attach the caller to all the
> > > > specified namespaces all at once or to none of them. If 0 is specified
> > > > together with a pidfd then setns() will interpret it the same way 0 is
> > > > interpreted together with a nsfd argument, i.e. attach to any/all
> > > > namespaces.
> > > [...]
> > > > Apart from significiantly reducing the number of syscalls from double
> > > > digit to single digit which is a decent reason post-spectre/meltdown
> > > > this also allows to switch to a set of namespaces atomically, i.e.
> > > > either attaching to all the specified namespaces succeeds or we fail.
> > >
> > > Apart from the issues I've pointed out below, I think it's worth
> > > calling out explicitly that with the current design, the switch will
> > > not, in fact, be fully atomic - the process will temporarily be in
> > > intermediate stages where the switches to some namespaces have
> > > completed while the switches to other namespaces are still pending;
> > > and while there will be less of these intermediate stages than before,
> > > it also means that they will be less explicit to userspace.
> >
> > Right, that can be fixed by switching to the unshare model of getting a
> > new set of credentials and committing it after the nsproxy has been
> > installed? Then there shouldn't be an intermediate state anymore or
> > rather an intermediate stage where we can still fail somehow.
> 
> It still wouldn't be atomic (in the sense of parallelism, not in the
> sense of intermediate error handling) though; for example, if task B
> does setns(<pidfd_of_task_a>, 0) and task C concurrently does
> setns(<pidfd_of_task_b>, 0), then task C may end up with the new mount
> namespace of task B but the old user namespace, or something like
> that. If C is more privileged than B, that may cause C to have more
> privileges through its configuration of namespaces than B does (e.g.
> by running in the &init_user_ns but with a mount namespace owned by an
> unprivileged user), which C may not expect. Same thing for racing
> between unshare() and setns().
> 
> [...]
> > > > +               put_user_ns(user_ns);
> > > > +       }
> > > > +#else
> > > > +       if (flags & CLONE_NEWUSER)
> > > > +               ret = -EINVAL;
> > > > +#endif
> > > > +
> > > > +       if (!ret && wants_ns(flags, CLONE_NEWNS))
> > > > +               ret = __ns_install(nsproxy, mnt_ns_to_common(nsp->mnt_ns));
> > >
> > > And this one might be even worse, because the mount namespace change
> > > itself is only stored in the nsproxy at this point, but the cwd and
> > > root paths have already been overwritten on the task's fs_struct.
> > >
> > > To actually make sys_set_ns() atomic, I think you'd need some
> > > moderately complicated prep work, splitting the ->install handlers up
> > > into prep work and a commit phase that can't fail.
> >
> > Wouldn't it be sufficient to move to an unshare like model, i.e.
> > creating a new set of creds, and passing the new user_ns to
> > create_new_namespaces() as well as having a temporary new_fs struct?
> > That should get rid of all intermediate stages.
> 
> Ah, good point, I didn't realize that that already exists for unshare().

Let me try and switch the patch to that.

Christian
