Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFABBD32F
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 21:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfIXT5M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 15:57:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38606 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfIXT5M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 15:57:12 -0400
Received: from mon75-17-88-175-211-167.fbx.proxad.net ([88.175.211.167] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iCqvp-0007Nx-Oc; Tue, 24 Sep 2019 19:57:05 +0000
Date:   Tue, 24 Sep 2019 21:57:04 +0200
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
Message-ID: <20190924195701.7pw2olbviieqsg5q@wittgenstein>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
 <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 24, 2019 at 09:44:49PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Christian,
> 
> On 9/23/19 4:23 PM, Christian Brauner wrote:
> > On Mon, Sep 23, 2019 at 01:26:34PM +0200, Florian Weimer wrote:
> >> * Michael Kerrisk:
> >>
> >>> SYNOPSIS
> >>>        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,
> >>>                              unsigned int flags);
> >>
> >> This probably should reference a header for siginfo_t.
> > 
> > Agreed.
> > 
> >>
> >>>        ESRCH  The target process does not exist.
> >>
> >> If the descriptor is valid, does this mean the process has been waited
> >> for?  Maybe this can be made more explicit.
> > 
> > If by valid you mean "refers to a process/thread-group leader" aka is a
> > pidfd then yes: Getting ESRCH means that the process has exited and has
> > already been waited upon.
> > If it had only exited but not waited upon aka is a zombie, then sending
> > a signal will just work because that's currently how sending signals to
> > zombies works, i.e. if you only send a signal and don't do any
> > additional checks you won't notice a difference between a process being
> > alive and a process being a zombie. The userspace visible behavior in
> > terms of signaling them is identical.
> 
> (Thanks for the clarification. I added the text "(i.e., it has 
> terminated and been waited on)" to the ESRCH error.)
> 
> >>>        The  pidfd_send_signal()  system call allows the avoidance of race
> >>>        conditions that occur when using traditional interfaces  (such  as
> >>>        kill(2)) to signal a process.  The problem is that the traditional
> >>>        interfaces specify the target process via a process ID (PID), with
> >>>        the  result  that the sender may accidentally send a signal to the
> >>>        wrong process if the originally intended target process has termi‐
> >>>        nated  and its PID has been recycled for another process.  By con‐
> >>>        trast, a PID file descriptor is a stable reference to  a  specific
> >>>        process;  if  that  process  terminates,  then the file descriptor
> >>>        ceases to be  valid  and  the  caller  of  pidfd_send_signal()  is
> >>>        informed of this fact via an ESRCH error.
> >>
> >> It would be nice to explain somewhere how you can avoid the race using
> >> a PID descriptor.  Is there anything else besides CLONE_PIDFD?
> > 
> > If you're the parent of the process you can do this without CLONE_PIDFD:
> > pid = fork();
> > pidfd = pidfd_open();
> > ret = pidfd_send_signal(pidfd, 0, NULL, 0);
> > if (ret < 0 && errno == ESRCH)
> > 	/* pidfd refers to another, recycled process */
> 
> Although there is still the race between the fork() and the
> pidfd_open(), right?

Actually no and my code is even too complex.
If you are the parent, and this is really a sequence that obeys the
ordering pidfd_open() before waiting:

pid = fork();
if (pid == 0)
	exit(EXIT_SUCCESS);
pidfd = pidfd_open(pid, 0);
waitid(pid, ...);

Then you are guaranteed that pidfd will refer to pid. No recycling can
happen since the process has not been waited upon yet (That is,
excluding special cases such as where you have a mainloop where a
callback reacts to a SIGCHLD event and waits on the child behind your
back and your next callback in the mainloop calls pidfd_open() while the
pid has been recycled etc.).
A race could only appear in sequences where waiting happens before
pidfd_open():

pid = fork();
if (pid == 0)
	exit(EXIT_SUCCESS);
waitid(pid, ...);
pidfd = pidfd_open(pid, 0);

which honestly simply doesn't make any sense. So if you're the parent
and you combine fork() + pidfd_open() correctly things should be fine
without even having to verify via pidfd_send_signal() (I missed that in
my first mail.).
(Now, it gets more hairy when one considers clone(CLONE_PARENT) but that
would be wildly esoteric because at that point you're using clone()
already and then you should simply pass clone(CLONE_PARENT | CLONE_PIDFD).)

If you're _not_ the parent then CLONE_PIDFD and sending around the pidfd
are your only option to avoiding the race imho.

> 
> >>>        static
> >>>        int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> >>>                unsigned int flags)
> >>>        {
> >>>            return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> >>>        }
> >>
> >> Please use a different function name.  Thanks.
> 
> Covered in another thread. I await some further feedback from Florian.

Right, that wasn't my suggestion anyway. :)

Thanks!
Christian
