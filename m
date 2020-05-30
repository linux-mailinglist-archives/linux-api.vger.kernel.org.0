Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD31E9293
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgE3QV3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 30 May 2020 12:21:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50436 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3QV3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 30 May 2020 12:21:29 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jf4Ee-0000Jx-FW; Sat, 30 May 2020 16:21:24 +0000
Date:   Sat, 30 May 2020 18:21:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     rsesek@google.com, palmer@google.com, jannh@google.com,
        jeffv@google.com, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200530162123.eqfgoc7lkyyxcmut@wittgenstein>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <20200530035817.GA20457@ircssh-2.c.rugged-nimbus-611.internal>
 <202005292223.1701AB31@keescook>
 <20200530141329.tjrtrdy66jhqzojy@wittgenstein>
 <202005300911.AAE71F1955@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005300911.AAE71F1955@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 30, 2020 at 09:14:50AM -0700, Kees Cook wrote:
> On Sat, May 30, 2020 at 04:13:29PM +0200, Christian Brauner wrote:
> > On Fri, May 29, 2020 at 10:47:12PM -0700, Kees Cook wrote:
> > > Oh hey! Look at scm_detach_fds_compat(). It needs this too. (And it's
> > > missing the cgroup tracking.) That would fix:
> > > 
> > > 48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
> > > d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")
> > > 
> > > So, yes, let's get this fixed up. I'd say first fix the missing sock
> > > update in the compat path (so it can be CCed stable). Then fix the missing
> > 
> > send this patch to net.
> > 
> > > sock update in pidfd_getfd() (so it can be CCed stable), then write the
> > 
> > send this patch to me.
> > 
> > > helper with a refactoring of scm_detach_fds(), scm_detach_fds_compat(),
> > 
> > this would be net-next most likely.
> > 
> > > and pidfd_getfd(). And then add the addfd seccomp user_notif ioctl cmd.
> > 
> > If you do this first, I'd suggest you resend the series here after all
> > this has been merged. We're not in a rush since this won't make it for
> > the 5.8 merge window anyway. By the time the changes land Kees might've
> > applied my changes to his tree so you can rebase yours on top of it
> > relieving Kees from fixing up merge conflicts.
> > 
> > About your potential net and net-next changes. Just in case you don't
> > know - otherwise ignore this - please read and treat
> > https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> > as the gospel. Also note, that after this Sunday - assuming Linus
> > releases - net-next will be closed until the merge window is closed,
> > i.e. for _at least_ 2 weeks. After the merge window closes you can check
> > http://vger.kernel.org/~davem/net-next.html
> > which either has a picture saying "Come In We're Open" or a sign saying
> > "Sorry, We're Closed". Only send when the first sign is up or the wrath
> > of Dave might hit you. :)
> 
> Yeah, timing is awkward here. I was originally thinking it could all
> just land via seccomp (with appropriate Acks). Hmmm.

I don't particularly care so sure. :)
Christian
