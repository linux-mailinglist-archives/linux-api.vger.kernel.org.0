Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE36662E1
	for <lists+linux-api@lfdr.de>; Fri, 12 Jul 2019 02:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfGLAcf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jul 2019 20:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbfGLAcf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 11 Jul 2019 20:32:35 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A7A216FD
        for <linux-api@vger.kernel.org>; Fri, 12 Jul 2019 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562891554;
        bh=mWM1msUOi3sWCWjf4g3ssBFe9C4HtXvJFdU4LXMJXnc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TNBTRT9qR6L8EFYhNz5ASz+ZSFBFK7Podkuohl7zBGCBx3dor5jxsyP6TgcBTP4vx
         rRURMYTNBt/YTG1Vrh0NTFXQa2ENANmkzHM28Eg8BloZigmelWTTjfGQsAoJsDUFVi
         Dc9aFjzSzlb3K5GcZjhEvMO5QIwy/352cHXlh5oA=
Received: by mail-wr1-f50.google.com with SMTP id 31so8132024wrm.1
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2019 17:32:34 -0700 (PDT)
X-Gm-Message-State: APjAAAX4ph7/Jr3vhd0XF5GdTV3fNtlNjlNXVXZ4WDr3WOAzUc6u2zVI
        uYK5ZDvVwYajRLc15e8xnV0HVeM2iU12z0UBohwoXA==
X-Google-Smtp-Source: APXvYqzYUbiQjsAFPvwO5qXqTxo0KY5ClCpaWxsq/N/U0gdy8IwG3JlKoh9B7aRbc28in82BCDpQ4MvKw3xy/GQuTjQ=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr7002359wrm.265.1562891552611;
 Thu, 11 Jul 2019 17:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190712014223.66326995@hikaru>
In-Reply-To: <20190712014223.66326995@hikaru>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Jul 2019 17:32:21 -0700
X-Gmail-Original-Message-ID: <CALCETrWkmaB5K4AR0R6CYcdq8mJwKtbWbmYEq6oxeaoqdA3ZWA@mail.gmail.com>
Message-ID: <CALCETrWkmaB5K4AR0R6CYcdq8mJwKtbWbmYEq6oxeaoqdA3ZWA@mail.gmail.com>
Subject: Re: On
To:     Carlo Wood <carlo@alinoe.com>
Cc:     wangyun@linux.vnet.ibm.com, palewis@adobe.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, jbaron@redhat.com,
        pholland@adobe.com, Davide Libenzi <davidel@xmailserver.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 11, 2019 at 5:01 PM Carlo Wood <carlo@alinoe.com> wrote:
>
> I believe that the only safe solution is to let the Event Loop
> Thread do the deleting. So, if all else fails I'll have to add
> objects that a Worker Thread thinks need to be deleted to a
> FIFO that is processed by the Event Loop Thread before entering
> epoll_wait(). But that is a lot of extra code for something
> that could be achieved with just a small change to epoll:

This doesn't seem so bad at all.

>
>
> I propose to add a new EPOLL event EPOLLCLOSED that will cause
> epoll_wait to return (for that event) whenever a file descriptor is
> closed.

This totally falls apart if you ever want to add a feature to your
library to detach the handler for a given fd without closing the fd.

>
> The Worker Thread then does not remove an object from the
> interest list, but either adds (if it was removed before) or
> modifies the event (using EPOLL_CTL_MOD) to watch that fd
> for closing, and then closes it.
>
> Aka,
>
>   Working Thread:
>
>   epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &event);
>   close(fd);
>
> where event contains the new EPOLLCLOSED (compare EPOLLOUT, EPOLLIN
> etc).
>
> This must then guarantee the event EPOLLCLOSED to be reported
> by exactly one epoll_wait(), the caller thread of which can then
> proceed with deleting the resources.
>
> Note that close(fd) must cause the removal from the interest list
> of any epoll struct before causing the event - and that the
> EPOLLCLOSED event may only be reported after all other events
> for that fd have already been reported (although it would be
> ok to report them at the same time: simply handle the other
> events first).

This is a bunch of subtle semantics in the kernel to support your
particular use case.

>
> I am not sure how this will work when more than one thread
> calls epoll_wait and more than one watch the same fd: in
> that case it is less trivial because then it seems always
> possible that the EPOLLCLOSED event will be reported before
> another event in another thread.

But this case is fairly straightforward with the user mode approach --
for example, add it to the list for all threads calling epoll_wait.
Or otherwise defer the deletion until all epoll_wait threads have
woken.
