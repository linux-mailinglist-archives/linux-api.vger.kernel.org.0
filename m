Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6353F25D636
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgIDK3Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 06:29:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35547 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDK3O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 06:29:14 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kE8xv-0001oE-SE; Fri, 04 Sep 2020 10:29:07 +0000
Date:   Fri, 4 Sep 2020 12:29:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/4] exit: support non-blocking pidfds
Message-ID: <20200904102907.2t6w6k7ud5i6ak2o@wittgenstein>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-3-christian.brauner@ubuntu.com>
 <20200903235659.GC210207@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903235659.GC210207@localhost>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 03, 2020 at 04:56:59PM -0700, Josh Triplett wrote:
> On Wed, Sep 02, 2020 at 12:21:28PM +0200, Christian Brauner wrote:
> > Passing a non-blocking pidfd to waitid() currently has no effect, i.e.  is not
> > supported. There are users which would like to use waitid() on pidfds that are
> > O_NONBLOCK and mix it with pidfds that are blocking and both pass them to
> > waitid().
> > The expected behavior is to have waitid() return -EAGAIN for non-blocking
> > pidfds and to block for blocking pidfds without needing to perform any
> > additional checks for flags set on the pidfd before passing it to waitid().
> > Non-blocking pidfds will return EAGAIN from waitid() when no child process is
> > ready yet. Returning -EAGAIN for non-blocking pidfds makes it easier for event
> > loops that handle EAGAIN specially.
> > 
> > It also makes the API more consistent and uniform. In essence, waitid() is
> > treated like a read on a non-blocking pidfd or a recvmsg() on a non-blocking
> > socket.
> > With the addition of support for non-blocking pidfds we support the same
> > functionality that sockets do. For sockets() recvmsg() supports MSG_DONTWAIT
> > for pidfds waitid() supports WNOHANG. Both flags are per-call options. In
> > contrast non-blocking pidfds and non-blocking sockets are a setting on an open
> > file description affecting all threads in the calling process as well as other
> > processes that hold file descriptors referring to the same open file
> > description. Both behaviors, per call and per open file description, have
> > genuine use-cases.
> > 
> > The implementation should be straightforward, we simply raise the WNOHANG flag
> > when a non-blocking pidfd is passed and when do_wait() returns without finding
> > an eligible task and the pidfd is non-blocking we set EAGAIN.  If no child
> > process exists non-blocking pidfd users will continue to see ECHILD but if
> > child processes exist but have not yet exited users will see EAGAIN.
> > 
> > A concrete use-case that was brought on-list was Josh's async pidfd library.
> > Ever since the introduction of pidfds and more advanced async io various
> > programming languages such as Rust have grown support for async event
> > libraries. These libraries are created to help build epoll-based event loops
> > around file descriptors. A common pattern is to automatically make all file
> > descriptors they manage to O_NONBLOCK.
> > 
> > For such libraries the EAGAIN error code is treated specially. When a function
> > is called that returns EAGAIN the function isn't called again until the event
> > loop indicates the the file descriptor is ready.  Supporting EAGAIN when
> > waiting on pidfds makes such libraries just work with little effort.
> > 
> > Link: https://lore.kernel.org/lkml/20200811181236.GA18763@localhost/
> > Link: https://github.com/joshtriplett/async-pidfd
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Sargun Dhillon <sargun@sargun.me>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Suggested-by: Josh Triplett <josh@joshtriplett.org>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> With or without the discussed change to WNOHANG behavior for
> compatibility:
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

I think that WNOHANG compatibility change might be a good idea. So I've
changed this to:

	ret = do_wait(&wo);
	if (!ret && !(options & WNOHANG) && (f_flags & O_NONBLOCK))
		ret = -EAGAIN;

> 
> Also, I think you should flip the order of patches 1 and 2, so that
> there isn't a one-patch window in kernel history where you can create an
> O_NONBLOCK pidfd with pidfd_open but it has no effect. I'd expect
> userspace to use pidfd_open accepting or EINVAL-ing the flag as an
> indication of whether it'll work.

Good point! I've changed the order now.

Thanks!
Christian
