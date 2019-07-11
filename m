Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91006629F
	for <lists+linux-api@lfdr.de>; Fri, 12 Jul 2019 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfGLABg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jul 2019 20:01:36 -0400
Received: from smtpq2.tb.mail.iss.as9143.net ([212.54.42.165]:56684 "EHLO
        smtpq2.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728102AbfGLABf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jul 2019 20:01:35 -0400
X-Greylist: delayed 1146 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 20:01:33 EDT
Received: from [212.54.42.115] (helo=lsmtp1.tb.mail.iss.as9143.net)
        by smtpq2.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1hlihk-0000hR-Qz; Fri, 12 Jul 2019 01:42:24 +0200
Received: from 92-109-146-195.cable.dynamic.v4.ziggo.nl ([92.109.146.195] helo=mail9.alinoe.com)
        by lsmtp1.tb.mail.iss.as9143.net with esmtp (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1hlihk-0006D4-NE; Fri, 12 Jul 2019 01:42:24 +0200
Received: from carlo by mail9.alinoe.com with local (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1hlihj-0002MM-VI; Fri, 12 Jul 2019 01:42:23 +0200
Date:   Fri, 12 Jul 2019 01:42:23 +0200
From:   Carlo Wood <carlo@alinoe.com>
To:     wangyun@linux.vnet.ibm.com
Cc:     palewis@adobe.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, jbaron@redhat.com, pholland@adobe.com,
        davidel@xmailserver.org, mtk.manpages@gmail.com,
        paulmck@linux.vnet.ibm.com, ncardwell@google.com
Subject: On
Message-ID: <20190712014223.66326995@hikaru>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: carlo@alinoe.com
X-SA-Exim-Scanned: No (on mail9.alinoe.com); SAEximRunCond expanded to false
X-SourceIP: 92.109.146.195
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=XMeEtjpE c=1 sm=1 tr=0 a=at3gEZHPcpTZPMkiLtqVSg==:17 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10 a=D19gQVrFAAAA:8 a=BjFOTwK7AAAA:8 a=tsnVmnQLuO20XHqAJgYA:9 a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=N3Up1mgHhB-0MyeZKEz1:22
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello everyone,

this is a follow up to a discussion from 2012 about EPOLL_CTL_DISABLE,
which ended up NOT being accepted in the kernel.

I believe however that this issue wasn't addressed.
Michael Kerrisk did an excellent job writing a summary of the problem:
https://lkml.org/lkml/2012/10/16/302 (the first four listed points).

In the past two years I've been working on "yet another" event driven
I/O library, exclusively for linux however, with the general aim to
be highly scalable for many cores. The I/O part (around epoll) is only
part of that library - but it is what I spent the last two years on.

I ran independently into the same problem as described by Paton Lewis
and only afterwards, when I couldn't think of a working solution and
started to do heavy research, found related articles about the problem.

Reading through the thread on lkml.org that given above, it still
isn't clear to me that this would be a non-issue that can be solved
in user space (without severe (unnecessary) performance penalties).

Let me summarize the problem in my own way (probably less general,
but more related to my personal case):

1. The epoll interest list stores a pointer in epoll_event::data.ptr
   that points to a specific file descriptor related object, which
   indeed can be seen as a user-space cache of data related to that
   file descriptor. In my case this includes one mutex that protects
   an unsigned int whose bits keep track of things like whether or
   not that object (pointer) is in the epoll interest list (was added
   with epoll_ctl) and which events are being watched specifically,
   as well as whether or not the fd was closed (after removing it
   from the interest list with EPOLL_CTL_DEL) etc.

2. At least one thread (only one, in my case) calls epoll_wait
   (epoll_pwait) in a loop. I use no timeout because that seems too
   inaccurate, my timers are signal based. When epoll_wait returns, the
   pointer epoll_event::data.ptr is used to call a member function on
   the dereferenced FileDescriptor class. For non-C++ coders, that
   means a function is passed as first parameter the value of
   epoll_event::data.ptr (the 'this' pointer) which is subsequently
   dereferenced inside that function. The exact function depends on the
   actual event. In most cases the handling of the event is passed on
   to a thread pool queue for handling by another thread - but before
   that happens the pointer was already dereferenced (which, among
   others, allows me to increment a reference count for that object).
   This obviously means that epoll_event::data.ptr may never point to
   freed data.

3. As almost all processing happens by worker threads of a thread
   pool - it will be some other thread that decides that an object
   is done and needs to be freed. This thread first removes the object
   from the epoll interest list, and then deletes the object.
   Unfortunately this does not work -- and apart from adding a delay
   before the object is really deleted (which isn't a real solution
   as several of you already pointed out in 2012), I do not see any
   possible alternative.

The reason it can't work is because the Event Loop Thread (that loops
around epoll_wait) may already be in the process of returning from
epoll_wait, lets say -- it already returned from epoll_wait, but
wasn't able to execute ANY code following it. And because this is
ALWAYS possible there is NEVER a safe moment to delete the object.

The scenario is, for example:

   Event Loop Thread                           Worker thread

   Returns from epoll_wait() passing
   back to user space a data.ptr pointing
   to a user allocated object.

                                               Removes the object
                                               from the epoll interest
                                               list with EPOLL_CTL_DEL

                                               <arbitrary delay here,
                                                for example, no delay>

                                               Free the object pointed
                                               to by data.ptr.

   Dereferences data.ptr and crashes.


The solution proposed by Andy Lutomirski
(https://lkml.org/lkml/2012/10/18/434) does not work here:
In order use RCU the ptr must be removed from the protected
"list" before the grace period is started, which must start
before a read-side critical area ends. But the "list" here
is the epoll interest list - and removing it from that list
requires the call to epoll_ctl(..., EPOLL_CTL_DEL, ...) to 
finish. In other words, the Worker thread is the RCU "updater"
and the "arbitrary delay" must be the rcu grace period.
No problems there. The event loop thread however must call
rcu_read_lock() before accessing the epoll_event structure,
which is not possible because that happens inside epoll_wait(),
which doesn't provide a hook to add such call.

As far as the Worker Thread is concerned there are no readers,
and the grace period can finish instantly, simply because
there is no way to register that data.ptr was already copied.

If one tries to begin a read-side critical area after epoll_wait()
returns, then that won't work: in that case you should not
be able to access that ptr when it was already removed from
the interest list. The only way that RCU would work here is
when a reader subscribes *before* the kernel copies the
corresponding epoll_event structure to user space, in a way
that that will never happen when the EPOLL_CTL_DEL finished
before it got to that point.


I believe that the only safe solution is to let the Event Loop
Thread do the deleting. So, if all else fails I'll have to add
objects that a Worker Thread thinks need to be deleted to a
FIFO that is processed by the Event Loop Thread before entering
epoll_wait(). But that is a lot of extra code for something
that could be achieved with just a small change to epoll:


I propose to add a new EPOLL event EPOLLCLOSED that will cause
epoll_wait to return (for that event) whenever a file descriptor is
closed.

The Worker Thread then does not remove an object from the
interest list, but either adds (if it was removed before) or
modifies the event (using EPOLL_CTL_MOD) to watch that fd
for closing, and then closes it.

Aka,

  Working Thread:

  epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &event);
  close(fd);

where event contains the new EPOLLCLOSED (compare EPOLLOUT, EPOLLIN
etc).

This must then guarantee the event EPOLLCLOSED to be reported
by exactly one epoll_wait(), the caller thread of which can then
proceed with deleting the resources.

Note that close(fd) must cause the removal from the interest list
of any epoll struct before causing the event - and that the
EPOLLCLOSED event may only be reported after all other events
for that fd have already been reported (although it would be
ok to report them at the same time: simply handle the other
events first).

I am not sure how this will work when more than one thread
calls epoll_wait and more than one watch the same fd: in
that case it is less trivial because then it seems always
possible that the EPOLLCLOSED event will be reported before
another event in another thread.


What are your thoughts? Is the addition of EPOLLCLOSED
event feasible?

-- 
Carlo Wood <carlo@alinoe.com>
