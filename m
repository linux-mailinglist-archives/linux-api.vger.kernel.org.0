Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3929FF0D7
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 09:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfD3HCE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Apr 2019 03:02:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3HCE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 30 Apr 2019 03:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CC433091740;
        Tue, 30 Apr 2019 07:02:03 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-90.ams2.redhat.com [10.36.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0807D1001E86;
        Tue, 30 Apr 2019 07:01:53 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt\, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
References: <20190414201436.19502-1-christian@brauner.io>
        <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
        <20190415195911.z7b7miwsj67ha54y@yavin>
        <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
        <20190420071406.GA22257@ip-172-31-15-78>
        <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
        <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
        <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
        <87zho8bl8x.fsf@oldenburg2.str.redhat.com>
        <CAHk-=wiPv4QJBC0qX8xxnT5P2C7S5uDG0HKdvdSpcoXaHG91tQ@mail.gmail.com>
Date:   Tue, 30 Apr 2019 09:01:52 +0200
In-Reply-To: <CAHk-=wiPv4QJBC0qX8xxnT5P2C7S5uDG0HKdvdSpcoXaHG91tQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 29 Apr 2019 14:31:30 -0700")
Message-ID: <87muk8asdb.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 30 Apr 2019 07:02:04 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Linus Torvalds:

> On Mon, Apr 29, 2019 at 1:38 PM Florian Weimer <fweimer@redhat.com> wrote:
>>
>> In Linux-as-the-ABI (as opposed to Linux-as-the-implementation), vfork
>> is sometimes implemented as fork, so applications cannot rely on the
>> vfork behavior regarding the stopped parent and the shared address
>> space.
>
> What broken library does that?
>
> Sure, we didn't have a proper vfork() long long long ago. But that
> predates both git and BK, so it's some time in the 90's. We've had a
> proper vfork() *forever*.

It's not so much about libraries, it's alternative implementations of
the system call interface: valgrind, qemu-user and WSL.  For valgrind
and qemu-user, it's about cloning the internal data structures, so that
the subprocess does not clobber what's in the parent process (which may
have multiple threads and may not be fully blocked due to vfork).  For
WSL, who knows what's going on there.

>> In fact, it would be nice to have a flag we can check in the posix_spawn
>> implementation, so that we can support vfork-as-fork without any run
>> time cost to native Linux.
>
> No. Just make a bug-report to whatever broken library you use. What's
> the point of having a library that can't even get vfork() right? Why
> would you want to have a flag to say "vfork is broken"?

It's apparently quite difficult to fix valgrind and qemu-user.  WSL is
apparently not given the resources it needs, yet a surprising number of
people see it as a viable replacement and report what are essentially
vfork-related bugs.

If I had the flag, I could at least fix posix_spawn in glibc to consult
it before assuming that vfork shares address space.  (The sharing allows
straightforward reporting of the vfork error code, without resorting to
pipes or creating a MAP_SHARED mapping.)  For obvious reasons, I do not
want to apply the workaround unconditionally.

Thanks,
Florian
