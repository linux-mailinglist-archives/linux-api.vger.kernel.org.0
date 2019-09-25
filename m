Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A863BDF77
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407084AbfIYNxQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 09:53:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41400 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407078AbfIYNxQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 09:53:16 -0400
Received: from [65.39.69.237] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iD7jC-00064k-2E; Wed, 25 Sep 2019 13:53:10 +0000
Date:   Wed, 25 Sep 2019 15:53:09 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>, Oleg Nesterov <oleg@redhat.com>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
Message-ID: <20190925135308.rev5tczcigyuchae@wittgenstein>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
 <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
 <20190924195701.7pw2olbviieqsg5q@wittgenstein>
 <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
 <20190924215316.gxev2anuqffegocw@wittgenstein>
 <331cc245-3f70-dd43-31f9-8c1680ca6b20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <331cc245-3f70-dd43-31f9-8c1680ca6b20@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 25, 2019 at 03:46:26PM +0200, Michael Kerrisk (man-pages) wrote:
> On 9/24/19 11:53 PM, Christian Brauner wrote:
> > On Tue, Sep 24, 2019 at 11:00:03PM +0200, Michael Kerrisk (man-pages) wrote:
> >> Hello Christian,
> >>
> >>>>> If you're the parent of the process you can do this without CLONE_PIDFD:
> >>>>> pid = fork();
> >>>>> pidfd = pidfd_open();
> >>>>> ret = pidfd_send_signal(pidfd, 0, NULL, 0);
> >>>>> if (ret < 0 && errno == ESRCH)
> >>>>> 	/* pidfd refers to another, recycled process */
> >>>>
> >>>> Although there is still the race between the fork() and the
> >>>> pidfd_open(), right?
> >>>
> >>> Actually no and my code is even too complex.
> >>> If you are the parent, and this is really a sequence that obeys the
> >>> ordering pidfd_open() before waiting:
> >>>
> >>> pid = fork();
> >>> if (pid == 0)
> >>> 	exit(EXIT_SUCCESS);
> >>> pidfd = pidfd_open(pid, 0);
> >>> waitid(pid, ...);
> >>>
> >>> Then you are guaranteed that pidfd will refer to pid. No recycling can
> >>> happen since the process has not been waited upon yet (That is,
> >>
> >> D'oh! Yes, of course. 
> >>
> >>> excluding special cases such as where you have a mainloop where a
> >>> callback reacts to a SIGCHLD event and waits on the child behind your
> >>> back and your next callback in the mainloop calls pidfd_open() while the
> >>> pid has been recycled etc.).
> >>> A race could only appear in sequences where waiting happens before
> >>> pidfd_open():
> >>>
> >>> pid = fork();
> >>> if (pid == 0)
> >>> 	exit(EXIT_SUCCESS);
> >>> waitid(pid, ...);
> >>> pidfd = pidfd_open(pid, 0);
> >>>
> >>> which honestly simply doesn't make any sense. So if you're the parent
> >>> and you combine fork() + pidfd_open() correctly things should be fine
> >>> without even having to verify via pidfd_send_signal() (I missed that in
> >>> my first mail.).
> >>
> >> Thanks for the additional detail.
> > 
> > You're very welcome.
> > 
> >>
> >> I added the following to the pidfd_open() page, to
> >> prevent people making the same thinko as me:
> >>
> >>        The following code sequence can be used to obtain a file  descrip‐
> >>        tor for the child of fork(2):
> >>
> >>            pid = fork();
> >>            if (pid > 0) {     /* If parent */
> >>                pidfd = pidfd_open(pid, 0);
> >>                ...
> >>            }
> >>
> >>        Even  if  the  child process has already terminated by the time of
> >>        the pidfd_open() call, the returned file descriptor is  guaranteed
> >>        to refer to the child because the parent has not yet waited on the
> >>        child (and therefore, the child's ID has not been recycled).
> > 
> > Thanks! I'm fine with the example. The code illustrates the basics. If
> > you want to go overboard, you can mention my callback example and put my
> > SIG_IGN code snippet from my earlier mails (cf. [1] and [2]) in there.
> > But imho, that'll complicate the manpage and I'm not sure it's worth it.
> 
> I agree that we should not complicate this discussion with more code,
> but how about we refine the text as follows:
> 
>        The following code sequence can be used to obtain a file  descrip‐
>        tor for the child of fork(2):
> 
>            pid = fork();
>            if (pid > 0) {     /* If parent */
>                pidfd = pidfd_open(pid, 0);
>                ...
>            }
> 
>        Even  if  the  child  has  already  terminated  by the time of the
>        pidfd_open() call, its PID will not have  been  recycled  and  the
>        returned  file  descriptor  will  refer  to  the  resulting zombie
>        process.  Note, however, that this is guaranteed only if the  fol‐
>        lowing conditions hold true:
> 
>        *  the  disposition  of  SIGCHLD  has  not  been explicitly set to
>           SIG_IGN (see sigaction(2)); and

Ugh, I forgot a third one. There's also SA_NOCLDWAIT. When set and
the SIGCHLD handler is set to SIG_DFL then no zombie processes are
created and no SIGCHLD signal is sent. When an explicit handler for
SIGCHLD is set then a SIGCHLD signal is generated but the process will
still not be turned into a zombie...

> 
>        *  the zombie process was not  reaped  elsewhere  in  the  program
>           (e.g.,  either  by an asynchronously executed signal handler or
>           by wait(2) or similar in another thread).
> 
>        If these conditions don't hold true, then the child process should

"If any of these conditions does not hold, the child process..."

That might be clearer. But I leave the call on that to you. :)

Christian
