Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE64625CE94
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 01:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgICXy7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Sep 2020 19:54:59 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39655 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXy7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Sep 2020 19:54:59 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6C0091C0002;
        Thu,  3 Sep 2020 23:54:48 +0000 (UTC)
Date:   Thu, 3 Sep 2020 16:54:45 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/4] exit: support non-blocking pidfds
Message-ID: <20200903235445.GB210207@localhost>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-3-christian.brauner@ubuntu.com>
 <20200903142241.GI4386@redhat.com>
 <20200903153847.zvi5dzwj6v4eap6i@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903153847.zvi5dzwj6v4eap6i@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 03, 2020 at 05:38:47PM +0200, Christian Brauner wrote:
> On Thu, Sep 03, 2020 at 04:22:42PM +0200, Oleg Nesterov wrote:
> > On 09/02, Christian Brauner wrote:
> > >
> > > It also makes the API more consistent and uniform. In essence, waitid() is
> > > treated like a read on a non-blocking pidfd or a recvmsg() on a non-blocking
> > > socket.
> > > With the addition of support for non-blocking pidfds we support the same
> > > functionality that sockets do. For sockets() recvmsg() supports MSG_DONTWAIT
> > > for pidfds waitid() supports WNOHANG.
> > 
> > What I personally do not like is that waitid(WNOHANG) returns zero or EAGAIN
> > depending on f_flags & O_NONBLOCK... This doesn't match recvmsg(MSG_DONTWAIT)
> > and doesn't look consistent to me.
> 
> It's not my favorite thing either but async event loops are usually
> modeled around EAGAIN so I think this has benefits. Josh can speak more
> to that.

I wouldn't expect the same application to use both WNOHANG and
O_NONBLOCK, since the latter makes the former unnecessary. I'd have no
objection if WNOHANG continued to have the same "return 0 and you have
to check the structure to figure out what that means" behavior
regardless of the fd flags, for compatibility with an application or
library that expects that behavior with WNOHANG and didn't expect the
return value to change with a non-blocking fd.  waitid could just return
EAGAIN on a non-blocking fd if *not* passed WNOHANG, which would make
pidfd Just Work in non-blocking event loops.
