Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB98CBD4A8
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 23:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbfIXVx0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 17:53:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfIXVxZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 17:53:25 -0400
Received: from mon75-17-88-175-211-167.fbx.proxad.net ([88.175.211.167] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iCskI-0008Sw-H1; Tue, 24 Sep 2019 21:53:18 +0000
Date:   Tue, 24 Sep 2019 23:53:17 +0200
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
Message-ID: <20190924215316.gxev2anuqffegocw@wittgenstein>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
 <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
 <20190924195701.7pw2olbviieqsg5q@wittgenstein>
 <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 24, 2019 at 11:00:03PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Christian,
> 
> >>> If you're the parent of the process you can do this without CLONE_PIDFD:
> >>> pid = fork();
> >>> pidfd = pidfd_open();
> >>> ret = pidfd_send_signal(pidfd, 0, NULL, 0);
> >>> if (ret < 0 && errno == ESRCH)
> >>> 	/* pidfd refers to another, recycled process */
> >>
> >> Although there is still the race between the fork() and the
> >> pidfd_open(), right?
> > 
> > Actually no and my code is even too complex.
> > If you are the parent, and this is really a sequence that obeys the
> > ordering pidfd_open() before waiting:
> > 
> > pid = fork();
> > if (pid == 0)
> > 	exit(EXIT_SUCCESS);
> > pidfd = pidfd_open(pid, 0);
> > waitid(pid, ...);
> > 
> > Then you are guaranteed that pidfd will refer to pid. No recycling can
> > happen since the process has not been waited upon yet (That is,
> 
> D'oh! Yes, of course. 
> 
> > excluding special cases such as where you have a mainloop where a
> > callback reacts to a SIGCHLD event and waits on the child behind your
> > back and your next callback in the mainloop calls pidfd_open() while the
> > pid has been recycled etc.).
> > A race could only appear in sequences where waiting happens before
> > pidfd_open():
> > 
> > pid = fork();
> > if (pid == 0)
> > 	exit(EXIT_SUCCESS);
> > waitid(pid, ...);
> > pidfd = pidfd_open(pid, 0);
> > 
> > which honestly simply doesn't make any sense. So if you're the parent
> > and you combine fork() + pidfd_open() correctly things should be fine
> > without even having to verify via pidfd_send_signal() (I missed that in
> > my first mail.).
> 
> Thanks for the additional detail.

You're very welcome.

> 
> I added the following to the pidfd_open() page, to
> prevent people making the same thinko as me:
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
>        Even  if  the  child process has already terminated by the time of
>        the pidfd_open() call, the returned file descriptor is  guaranteed
>        to refer to the child because the parent has not yet waited on the
>        child (and therefore, the child's ID has not been recycled).

Thanks! I'm fine with the example. The code illustrates the basics. If
you want to go overboard, you can mention my callback example and put my
SIG_IGN code snippet from my earlier mails (cf. [1] and [2]) in there.
But imho, that'll complicate the manpage and I'm not sure it's worth it.

Thanks!
Christian

/* References */
[1]: https://lore.kernel.org/r/20190924195701.7pw2olbviieqsg5q@wittgenstein
[2]: https://lore.kernel.org/r/20190924200735.2dvqhan7ynnmfc7s@wittgenstein
