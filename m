Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736F3F1EF
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfD3IVd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Apr 2019 04:21:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfD3IVd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 30 Apr 2019 04:21:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E71933082B44;
        Tue, 30 Apr 2019 08:21:31 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-90.ams2.redhat.com [10.36.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51C6A6B8E9;
        Tue, 30 Apr 2019 08:21:22 +0000 (UTC)
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
        <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
        <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com>
Date:   Tue, 30 Apr 2019 10:21:20 +0200
In-Reply-To: <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 29 Apr 2019 19:16:11 -0700")
Message-ID: <87r29jaoov.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 30 Apr 2019 08:21:32 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Linus Torvalds:

> Note that vfork() is "exciting" for the compiler in much the same way
> "setjmp/longjmp()" is, because of the shared stack use in the child
> and the parent. It is *very* easy to get this wrong and cause massive
> and subtle memory corruption issues because the parent returns to
> something that has been messed up by the child.

Just using a wrapper around vfork is enough for that, if the return
address is saved on the stack.  It's surprising hard to write a test
case for that, but the corruption is definitely there.

> (In fact, if I recall correctly, the _reason_ we have an explicit
> 'vfork()' entry point rather than using clone() with magic parameters
> was that the lack of arguments meant that you didn't have to
> save/restore any registers in user space, which made the whole stack
> issue simpler. But it's been two decades, so my memory is bitrotting).

That's an interesting point.  Using a callback-style interface avoids
that because you never need to restore the registers in the new
subprocess.  It's still appropriate to use an assembler implementation,
I think, because it will be more obviously correct.

> Also, particularly if you have a big address space, vfork()+execve()
> can be quite a bit faster than fork()+execve(). Linux fork() is pretty
> efficient, but if you have gigabytes of VM space to copy, it's going
> to take time even if you do it fairly well.

vfork is also more benign from a memory accounting perspective.  In some
environments, it's not possible to call fork from a large process
because the accounting assumes (conservatively) that the new process
will dirty a lot of its private memory.

Thanks,
Florian
