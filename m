Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB47E1BF134
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgD3HT4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgD3HTz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:19:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E5D214D8;
        Thu, 30 Apr 2020 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588231194;
        bh=+03YLlI6FbLFcnnQpBsL2PbOhXaeMhXanrbkLEgzXK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pfLHqPe5VaNBslXHYWuNkfFCBWTbaqQHyheki6ue5fWS3eL3awJ6612OCpgalhcN
         +CmA6edbhMz5OZl90aE3+rbTqgGQjEe/O/+5bEmjmz8/a6xrl/hxnjJW0o2G6yHJG4
         G4Vva72pGv4MfcgdW1Jmg6qZVhMA6evpm8EO9MXk=
Date:   Thu, 30 Apr 2020 09:19:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Arseny Maslennikov <ar@cs.msu.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Subject: Re: [PATCH v3 4/7] linux/signal.h: Ignore SIGINFO by default in new
 tasks
Message-ID: <20200430071952.GA2411804@kroah.com>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
 <20200430064301.1099452-5-ar@cs.msu.ru>
 <780cb05e-a749-77a0-dabc-bd09982aa028@suse.cz>
 <20200430071437.x3ilwkh3lyf4iq6u@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430071437.x3ilwkh3lyf4iq6u@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 30, 2020 at 09:14:37AM +0200, Christian Brauner wrote:
> On Thu, Apr 30, 2020 at 08:53:56AM +0200, Jiri Slaby wrote:
> > On 30. 04. 20, 8:42, Arseny Maslennikov wrote:
> > > This matches the behaviour of other Unix-like systems that have SIGINFO
> > > and causes less harm to processes that do not install handlers for this
> > > signal, making the keyboard status character non-fatal for them.
> > > 
> > > This is implemented with the assumption that SIGINFO is defined
> > > to be equivalent to SIGPWR; still, there is no reason for PWR to
> > > result in termination of the signal recipient anyway — it does not
> > > indicate there is a fatal problem with the recipient's execution
> > > context (like e.g. FPE/ILL do), and we have TERM/KILL for explicit
> > > termination requests.
> > > 
> > > To put it another way:
> > > The only scenario where system behaviour actually changes is when the
> > > signal recipient has default disposition for SIGPWR. If a process
> > > chose to interpret a SIGPWR as an incentive to cleanly terminate, it
> > > would supply its own handler — and this commit does not affect processes
> > > with non-default handlers.
> > > 
> > > Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> > > ---
> > >  include/linux/signal.h | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > > index 05bacd2ab..dc31da8fc 100644
> > > --- a/include/linux/signal.h
> > > +++ b/include/linux/signal.h
> > > @@ -369,7 +369,7 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
> > >   *	|  SIGSYS/SIGUNUSED  |	coredump 	|
> > >   *	|  SIGSTKFLT         |	terminate	|
> > >   *	|  SIGWINCH          |	ignore   	|
> > > - *	|  SIGPWR            |	terminate	|
> > > + *	|  SIGPWR            |	ignore   	|
> > 
> > You need to update signal.7 too:
> > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man7/signal.7#n285
> 
> (I fail this whole thread via b4 and it appears that a bunch of messages
> are missing on lore. Might just be delay though.)
> 
> How this is this not going to break userspace?

That's my main hesitation for taking this patchset.

> Just for a start, SIGPWR (for better or worse) was used for a long time
> by some sandboxing/container runtimes to shutdown a process and still
> is.

That's a good reason to not do this :(

greg k-h
