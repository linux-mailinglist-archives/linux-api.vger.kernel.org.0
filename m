Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489D81E91FF
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgE3ONh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 30 May 2020 10:13:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48690 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgE3ONh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 30 May 2020 10:13:37 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jf2Es-0000wB-GV; Sat, 30 May 2020 14:13:30 +0000
Date:   Sat, 30 May 2020 16:13:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200530141329.tjrtrdy66jhqzojy@wittgenstein>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <20200530035817.GA20457@ircssh-2.c.rugged-nimbus-611.internal>
 <202005292223.1701AB31@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005292223.1701AB31@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 29, 2020 at 10:47:12PM -0700, Kees Cook wrote:
> On Sat, May 30, 2020 at 03:58:18AM +0000, Sargun Dhillon wrote:
> > Isn't the "right" way to do this to allocate a bunch of file descriptors,
> > and fill up the user buffer with them, and then install the files? This
> > seems to like half-install the file descriptors and then error out.
> > 
> > I know that's the current behaviour, but that seems like a bad idea. Do
> > we really want to perpetuate this half-broken state? I guess that some
> > userspace programs could be depending on this -- and their recovery
> > semantics could rely on this. I mean this is 10+ year old code.
> 
> Right -- my instincts on this are to leave the behavior as-is. I've
> been burned by so many "nothing could possible rely on THIS" cases. ;)
> 
> It might be worth adding a comment (or commit log note) that describes
> the alternative you suggest here. But I think building a common helper
> that does all of the work (and will get used in three^Wfour places now)
> is the correct way to refactor this.

If you do this, then probably

> 
> Oh hey! Look at scm_detach_fds_compat(). It needs this too. (And it's
> missing the cgroup tracking.) That would fix:
> 
> 48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
> d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")
> 
> So, yes, let's get this fixed up. I'd say first fix the missing sock
> update in the compat path (so it can be CCed stable). Then fix the missing

send this patch to net.

> sock update in pidfd_getfd() (so it can be CCed stable), then write the

send this patch to me.

> helper with a refactoring of scm_detach_fds(), scm_detach_fds_compat(),

this would be net-next most likely.

> and pidfd_getfd(). And then add the addfd seccomp user_notif ioctl cmd.

If you do this first, I'd suggest you resend the series here after all
this has been merged. We're not in a rush since this won't make it for
the 5.8 merge window anyway. By the time the changes land Kees might've
applied my changes to his tree so you can rebase yours on top of it
relieving Kees from fixing up merge conflicts.

About your potential net and net-next changes. Just in case you don't
know - otherwise ignore this - please read and treat
https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
as the gospel. Also note, that after this Sunday - assuming Linus
releases - net-next will be closed until the merge window is closed,
i.e. for _at least_ 2 weeks. After the merge window closes you can check
http://vger.kernel.org/~davem/net-next.html
which either has a picture saying "Come In We're Open" or a sign saying
"Sorry, We're Closed". Only send when the first sign is up or the wrath
of Dave might hit you. :)

Christian
