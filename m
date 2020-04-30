Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBEA1BF1F4
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgD3IA7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 04:00:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37041 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgD3IA7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 04:00:59 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jU47l-0007qu-Uk; Thu, 30 Apr 2020 08:00:50 +0000
Date:   Thu, 30 Apr 2020 10:00:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Arseny Maslennikov <ar@cs.msu.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Subject: Re: [PATCH v3 4/7] linux/signal.h: Ignore SIGINFO by default in new
 tasks
Message-ID: <20200430080049.fvivgejg4xcbaw5r@wittgenstein>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
 <20200430064301.1099452-5-ar@cs.msu.ru>
 <780cb05e-a749-77a0-dabc-bd09982aa028@suse.cz>
 <20200430071437.x3ilwkh3lyf4iq6u@wittgenstein>
 <20200430073728.36zehjhqmcllglbu@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430073728.36zehjhqmcllglbu@yavin.dot.cyphar.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 30, 2020 at 05:37:28PM +1000, Aleksa Sarai wrote:
> On 2020-04-30, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > On Thu, Apr 30, 2020 at 08:53:56AM +0200, Jiri Slaby wrote:
> > > On 30. 04. 20, 8:42, Arseny Maslennikov wrote:
> > > > This matches the behaviour of other Unix-like systems that have SIGINFO
> > > > and causes less harm to processes that do not install handlers for this
> > > > signal, making the keyboard status character non-fatal for them.
> > > > 
> > > > This is implemented with the assumption that SIGINFO is defined
> > > > to be equivalent to SIGPWR; still, there is no reason for PWR to
> > > > result in termination of the signal recipient anyway — it does not
> > > > indicate there is a fatal problem with the recipient's execution
> > > > context (like e.g. FPE/ILL do), and we have TERM/KILL for explicit
> > > > termination requests.
> > > > 
> > > > To put it another way:
> > > > The only scenario where system behaviour actually changes is when the
> > > > signal recipient has default disposition for SIGPWR. If a process
> > > > chose to interpret a SIGPWR as an incentive to cleanly terminate, it
> > > > would supply its own handler — and this commit does not affect processes
> > > > with non-default handlers.
> > > > 
> > > > Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> > > > ---
> > > >  include/linux/signal.h | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > > > index 05bacd2ab..dc31da8fc 100644
> > > > --- a/include/linux/signal.h
> > > > +++ b/include/linux/signal.h
> > > > @@ -369,7 +369,7 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
> > > >   *	|  SIGSYS/SIGUNUSED  |	coredump 	|
> > > >   *	|  SIGSTKFLT         |	terminate	|
> > > >   *	|  SIGWINCH          |	ignore   	|
> > > > - *	|  SIGPWR            |	terminate	|
> > > > + *	|  SIGPWR            |	ignore   	|
> > > 
> > > You need to update signal.7 too:
> > > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man7/signal.7#n285
> > 
> > (I fail this whole thread via b4 and it appears that a bunch of messages
> > are missing on lore. Might just be delay though.)
> > 
> > How this is this not going to break userspace? Just for a start,
> > SIGPWR (for better or worse) was used for a long time by some
> > sandboxing/container runtimes to shutdown a process and still is.
> 
> To play Devil's advocate -- pid1 has also always had a default-ignore
> signal mask (which included SIGPWR), so any pid1 that obeyed SIGPWR
> already had a non-default signal mask (and thus wouldn't be affected by
> this patch).

Sure, my point wasn't specifically about init systems but rather generic
processes. The reason that SIGPWR was originally used was because
older init systems - apart from systemd - could be shutdown with it
while other programs left it set to SIG_DFL and they would terminate
too. I'm not saying this is a great idea. But changing SIGPWR - if I
read this right - to go from "terminate" to "ignore" will mean that any
program that left SIGPWR unhandled/SIG_DFL will potentially see altered
behavior. Just looking at gvfsd and in debian.codesearch shows that they
explicitly set signal(SIGPWR, SIG_DFL) and I'm sure there are more.

(You also need to keep in mind that the default ignore mask applies to
signals sent from _within_ the pid namespace to pid 1. They'll be
delivered just fine from an ancestor pid namespace. Otherwise I'd be
interested to know how you've ever shutdown one of your containers. ;))

> 
> But I do agree that this seems like a strange change to make (SIGPWR
> seems like a signal you don't want to ignore by default). Unfortunately
> the fact that it appears to always be equal to SIGINFO means that while
> SIGINFO (to me at least) seems like it should be a no-op, the necessary
> SIGPWR change makes it harder to justify IMHO.
