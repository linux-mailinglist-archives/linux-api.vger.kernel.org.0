Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A909BB69E
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437724AbfIWOXs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 10:23:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40997 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437634AbfIWOXs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Sep 2019 10:23:48 -0400
Received: from [172.58.27.190] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iCPFc-0000sx-O6; Mon, 23 Sep 2019 14:23:41 +0000
Date:   Mon, 23 Sep 2019 16:23:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
Message-ID: <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnjr9rth.fsf@mid.deneb.enyo.de>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 23, 2019 at 01:26:34PM +0200, Florian Weimer wrote:
> * Michael Kerrisk:
> 
> > SYNOPSIS
> >        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,
> >                              unsigned int flags);
> 
> This probably should reference a header for siginfo_t.

Agreed.

> 
> >        ESRCH  The target process does not exist.
> 
> If the descriptor is valid, does this mean the process has been waited
> for?  Maybe this can be made more explicit.

If by valid you mean "refers to a process/thread-group leader" aka is a
pidfd then yes: Getting ESRCH means that the process has exited and has
already been waited upon.
If it had only exited but not waited upon aka is a zombie, then sending
a signal will just work because that's currently how sending signals to
zombies works, i.e. if you only send a signal and don't do any
additional checks you won't notice a difference between a process being
alive and a process being a zombie. The userspace visible behavior in
terms of signaling them is identical.

> 
> >        The  pidfd_send_signal()  system call allows the avoidance of race
> >        conditions that occur when using traditional interfaces  (such  as
> >        kill(2)) to signal a process.  The problem is that the traditional
> >        interfaces specify the target process via a process ID (PID), with
> >        the  result  that the sender may accidentally send a signal to the
> >        wrong process if the originally intended target process has termi‐
> >        nated  and its PID has been recycled for another process.  By con‐
> >        trast, a PID file descriptor is a stable reference to  a  specific
> >        process;  if  that  process  terminates,  then the file descriptor
> >        ceases to be  valid  and  the  caller  of  pidfd_send_signal()  is
> >        informed of this fact via an ESRCH error.
> 
> It would be nice to explain somewhere how you can avoid the race using
> a PID descriptor.  Is there anything else besides CLONE_PIDFD?

If you're the parent of the process you can do this without CLONE_PIDFD:
pid = fork();
pidfd = pidfd_open();
ret = pidfd_send_signal(pidfd, 0, NULL, 0);
if (ret < 0 && errno == ESRCH)
	/* pidfd refers to another, recycled process */

> 
> >        static
> >        int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> >                unsigned int flags)
> >        {
> >            return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> >        }
> 
> Please use a different function name.  Thanks.
