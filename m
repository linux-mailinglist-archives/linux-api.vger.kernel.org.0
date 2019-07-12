Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6389466348
	for <lists+linux-api@lfdr.de>; Fri, 12 Jul 2019 03:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfGLBTW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jul 2019 21:19:22 -0400
Received: from smtpq5.tb.mail.iss.as9143.net ([212.54.42.168]:53982 "EHLO
        smtpq5.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729061AbfGLBTW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jul 2019 21:19:22 -0400
Received: from [212.54.42.117] (helo=lsmtp3.tb.mail.iss.as9143.net)
        by smtpq5.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1hlkDW-000327-Lw; Fri, 12 Jul 2019 03:19:18 +0200
Received: from 92-109-146-195.cable.dynamic.v4.ziggo.nl ([92.109.146.195] helo=mail9.alinoe.com)
        by lsmtp3.tb.mail.iss.as9143.net with esmtp (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1hlkDW-00069n-Hq; Fri, 12 Jul 2019 03:19:18 +0200
Received: from carlo by mail9.alinoe.com with local (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1hlkDV-0003FT-Ky; Fri, 12 Jul 2019 03:19:17 +0200
Date:   Fri, 12 Jul 2019 03:19:17 +0200
From:   Carlo Wood <carlo@alinoe.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     wangyun@linux.vnet.ibm.com, palewis@adobe.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, jbaron@redhat.com,
        pholland@adobe.com, Davide Libenzi <davidel@xmailserver.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Neal Cardwell <ncardwell@google.com>, carlo@alinoe.com
Subject: Re: Is a new EPOLLCLOSED a solution to the problem that
 EPOLL_CTL_DISABLE tried to solve?
Message-ID: <20190712031917.4eabf240@hikaru>
In-Reply-To: <CALCETrWkmaB5K4AR0R6CYcdq8mJwKtbWbmYEq6oxeaoqdA3ZWA@mail.gmail.com>
References: <20190712014223.66326995@hikaru>
        <CALCETrWkmaB5K4AR0R6CYcdq8mJwKtbWbmYEq6oxeaoqdA3ZWA@mail.gmail.com>
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
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=JMuPTPCb c=1 sm=1 tr=0 a=at3gEZHPcpTZPMkiLtqVSg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10 a=VwQbUJbxAAAA:8 a=BjFOTwK7AAAA:8 a=hNgpY4UhNZx4Anvnp_cA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=N3Up1mgHhB-0MyeZKEz1:22
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andy,

thank you for you quick reply.

On Thu, 11 Jul 2019 17:32:21 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> > I propose to add a new EPOLL event EPOLLCLOSED that will cause
> > epoll_wait to return (for that event) whenever a file descriptor is
> > closed.  
> 
> This totally falls apart if you ever want to add a feature to your
> library to detach the handler for a given fd without closing the fd.

Another way to cause epoll_wait() to wake up for that specific fd is
okay too, of course.

For example, since the new event basically will mean "resources
can now be deleted", the event could be called EPOLLDELETE.
It is just needed to have some easy way to trigger this event.

Nevertheless, in the more exceptional case that one wants to destroy
the object/rss that data.ptr points to without closing the fd it is
probably possible to first dup the fd and then close the old one.

> > The Worker Thread then does not remove an object from the
> > interest list, but either adds (if it was removed before) or
> > modifies the event (using EPOLL_CTL_MOD) to watch that fd
> > for closing, and then closes it.
> >
> > Aka,
> >
> >   Working Thread:
> >
> >   epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &event);
> >   close(fd);
> >
> > where event contains the new EPOLLCLOSED (compare EPOLLOUT, EPOLLIN
> > etc).
> >
> > This must then guarantee the event EPOLLCLOSED to be reported
> > by exactly one epoll_wait(), the caller thread of which can then
> > proceed with deleting the resources.
> >
> > Note that close(fd) must cause the removal from the interest list
> > of any epoll struct before causing the event - and that the
> > EPOLLCLOSED event may only be reported after all other events
> > for that fd have already been reported (although it would be
> > ok to report them at the same time: simply handle the other
> > events first).  
> 
> This is a bunch of subtle semantics in the kernel to support your
> particular use case.

My particular use case? How so? The problem I'm trying to address
is the fact that "It is not currently possible to reliably delete epoll
items when using the same epoll set from multiple threads", end quote
of Paton Lewis' email from 2012.

If there is a simple, generally accepted solution for this in user-space
then of course there is no reason to change the kernel; but despite
all my efforts to research the net for a solution for this, all can
find are people with the same question and no good answers.

If there was a way to pass a special event to the thread waiting in
epoll_wait() that it now is safe to free the memory that data.ptr is
pointing to, then problem would evaporate to something trivally simple.

Lets say we would not be using close(2), but instead some
epoll_destruct(epoll_fd, fd). Then the worker thread, instead of,

  if (last reference to object has gone)
  {
    epoll_ctl(epoll_fd, EPOLL_CTL_DEL, object->fd, NULL);
    delete object;  // Unsafe
  }

could do,

  if (last reference to object has gone)
    epoll_destuct(epoll_fd, object->fd);
        // Or [optionally dup() and] close(object->fd);

Whereas the thread that waits for epoll_fd would take care
of the deletion:

  for (;;)
  {
    int ready = epoll_wait(epoll_fd, s_events, maxevents, -1);
    while (ready > 0)
    {
      epoll_event& event(s_events[--ready]);
      if ((event.events & EPOLLDELETE)) // Or EPOLLCLOSED, or
                                        // whatever the name is.
      {
        delete event.data.ptr;
        break;
      }
      // Handle other events.
    }
  }

In this case, if epoll_wait() had returned just prior to
the call to epoll_destruct()/close(), the object will not be deleted;
The returned events would be handled, epoll_wait() reentered,
and only once EPOLLDELETE is returned the object would be deleted.

The bunch of subtle requirements as you call it is just about how
to implement this in a way that it will do what it is supposed to do,
and in no way specific for my particular use case.

The requirements are, namely:

1. Only one epoll_fd may have added an epoll_event structure with
   a pointer to the resource (if more than one need to point to it,
   you could add a pointer to a smart pointer to the object to
   the epoll_event structure instead). I'd be surprised if this
   is not ALREADY a required for normal implementations.

2. The call to epoll_destruct() (as introduced as example above)
   must remove the fd from the epoll's interest list. Of course
   it doesn't HAVE to - but then the user MUST call epoll_ctl(epoll_fd,
   EPOLL_CTL_DEL, ...) right before it, so why not? The reason
   I opted close(2) is because that ALREADY has this behavior,
   hence it seems a good candidate for epoll_destruct.

3. After an EPOLLDELETE (formly EPOLLCLOSED) has been returned by
   an epoll_wait() no other events may be returned for that fd.
   This is obvious, and should be easy to implement. I just added it for
   completeness ;).
 
> But this case is fairly straightforward with the user mode approach --
> for example, add it to the list for all threads calling epoll_wait.
> Or otherwise defer the deletion until all epoll_wait threads have
> woken.

That really seems a hell of lot more complex (involving mutexes and
updating a queue that might grow till unknown sizes, hence requiring
possibly calls to malloc) then my proposed solution, for something that
basically every application that uses epoll needs.

-- 
Carlo Wood <carlo@alinoe.com>
