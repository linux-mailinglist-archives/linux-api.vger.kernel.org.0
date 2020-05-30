Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E31E91E0
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgE3N6f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 30 May 2020 09:58:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48282 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N6f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 30 May 2020 09:58:35 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jf20K-0008Tw-Cb; Sat, 30 May 2020 13:58:28 +0000
Date:   Sat, 30 May 2020 15:58:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200530135827.cxltfmiqara4yaki@wittgenstein>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <CAG48ez0+BvbLoSc+zcZwnwfOSCFt2LHnUkzzt-d4LQFJYXZC9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0+BvbLoSc+zcZwnwfOSCFt2LHnUkzzt-d4LQFJYXZC9w@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 30, 2020 at 05:17:24AM +0200, Jann Horn wrote:
> On Sat, May 30, 2020 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
> > I mean, yes, that's certainly better, but it just seems a shame that
> > everyone has to do the get_unused/put_unused dance just because of how
> > SCM_RIGHTS does this weird put_user() in the middle.
> >
> > Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> > move the put_user() after instead?
> 
> Honestly, I think trying to remove file descriptors and such after
> -EFAULT is a waste of time. If userspace runs into -EFAULT, userspace

Agreed, we've never bothered with trying to recover from EFAULT. Just
look at kernel/fork.c:_do_fork():
	if (clone_flags & CLONE_PARENT_SETTID)
		put_user(nr, args->parent_tid);

we don't even bother even though we technically could.

> is beyond saving and can't really do much other than exit immediately.
> There are a bunch of places that will change state and then throw
> -EFAULT at the end if userspace supplied an invalid address, because
> trying to hold locks across userspace accesses just in case userspace
> supplied a bogus address is kinda silly (and often borderline
> impossible).
> 
> You can actually see that even scm_detach_fds() currently just
> silently swallows errors if writing some header fields fails at the
> end.

There's really no point in trying to save a broken scm message imho.
