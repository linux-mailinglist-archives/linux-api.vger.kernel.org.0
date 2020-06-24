Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0E20729D
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403822AbgFXLzB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 07:55:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59042 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403776AbgFXLzB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 07:55:01 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jo3zV-0001JU-Me; Wed, 24 Jun 2020 11:54:57 +0000
Date:   Wed, 24 Jun 2020 13:54:56 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        systemd-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/3] nsproxy: attach to namespaces via pidfds
Message-ID: <20200624115456.rvzlgn77jol2a2oc@wittgenstein>
References: <20200505140432.181565-1-christian.brauner@ubuntu.com>
 <20200505140432.181565-3-christian.brauner@ubuntu.com>
 <20200624114437.GA117125@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624114437.GA117125@blackbook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 24, 2020 at 01:44:37PM +0200, Michal Koutný wrote:
> Hi.
> 
> On Tue, May 05, 2020 at 04:04:31PM +0200, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > -SYSCALL_DEFINE2(setns, int, fd, int, nstype)
> > +SYSCALL_DEFINE2(setns, int, fd, int, flags)
> > [...]
> > -	file = proc_ns_fget(fd);
> > -	if (IS_ERR(file))
> > -		return PTR_ERR(file);
> > +	int err = 0;
> >  
> > -	err = -EINVAL;
> > -	ns = get_proc_ns(file_inode(file));
> > -	if (nstype && (ns->ops->type != nstype))
> > +	file = fget(fd);
> > +	if (!file)
> > +		return -EBADF;
> > +
> > +	if (proc_ns_file(file)) {
> > +		ns = get_proc_ns(file_inode(file));
> > +		if (flags && (ns->ops->type != flags))
> > +			err = -EINVAL;
> > +		flags = ns->ops->type;
> > +	} else if (pidfd_pid(file)) {
> > +		err = check_setns_flags(flags);
> > +	} else {
> > +		err = -EBADF;
> > +	}
> > +	if (err)
> >  		goto out;
> >  
> > -	err = prepare_nsset(ns->ops->type, &nsset);
> > +	err = prepare_nsset(flags, &nsset);
> >  	if (err)
> >  		goto out;
> This modification changed the returned error when a valid file
> descriptor is passed but it doesn't represent a namespace (nor pidfd).
> The error is now EBADF although originally and per man page it
> was/should be EINVAL.
> 
> A change like below would restore it, however, I see it may be less
> consistent with other pidfd calls(?), then I'd suggest updating the
> manpage to capture this.
> 
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -531,7 +531,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
>         } else if (!IS_ERR(pidfd_pid(file))) {
>                 err = check_setns_flags(flags);
>         } else {
> -               err = -EBADF;
> +               err = -EINVAL;
>         }
>         if (err)
>                 goto out;
> 
> I noticed this breaks systemd self tests [1].

Yep, I already have a fix for this in my tree based on a previous report
from LTP. It's sitting in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fixes&id=e571d4ee334719727f22cce30c4c74471d4ef68a
with selftests:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fixes&id=86f56395feb2b106b125c47e72192e37da5dd088

I'll send it to Linus this week.

Thanks!
Christian
