Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DC4E6E6
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfD2Ptx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 11:49:53 -0400
Received: from mail.hallyn.com ([178.63.66.53]:39526 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbfD2Ptx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 29 Apr 2019 11:49:53 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id D18296C6; Mon, 29 Apr 2019 10:49:49 -0500 (CDT)
Date:   Mon, 29 Apr 2019 10:49:49 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
Message-ID: <20190429154949.GA23456@mail.hallyn.com>
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415155034.GA25351@mail.hallyn.com>
 <000a64d6-1e22-21bf-f232-15f141092e44@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a64d6-1e22-21bf-f232-15f141092e44@metux.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 16, 2019 at 08:32:50PM +0200, Enrico Weigelt, metux IT consult wrote:

(Sorry for the late reply, I had missed this one)

> On 15.04.19 17:50, Serge E. Hallyn wrote:
> 
> Hi,
> 
> >> I'm working on implementing plan9-like fs namespaces, where unprivileged>> processes can change their own namespace at will. For that, certain>
> > Is there any place where we can see previous discussion about this?
> Yes, lkml and constainers list.
> It's stalled since few month, as I'm too busy w/ other things.
> 
> > If you have to disable suid anyway, then is there any reason why the> existing ability to do this in a private user namespace, with only>
> your own uid mapped (which you can do without any privilege) does> not
> suffice?  That was actually one of the main design goals of user>
> namespaces, to be able to clone(CLONE_NEWUSER), map your current uid,>
> then clone(CLONE_NEWNS) and bind mount at will.
> Well, it's not that easy ... maybe I should explain a bit more about how
> Plan9 works, and how I intent to map it into Linux:
> 
> * on plan9, anybody can alter his own fs namespace (bind and mount), as
>   well as spawning new ones
> * basically anything is coming from some fileserver - even devices
>   (eg. there is no such thing like device nodes)
> * access control is done by the individual fileservers, based on the
>   initial authentication (on connecting to the server, before mounting)

yes, so far I'm aware of this,

> * all users are equal - no root at all. the only exception is the
>   initial process, which gets the kernel devices mounted into his
>   namespace.

This does not match my understanding, but I'm most likely wrong.  (I thought
there was an actual 'host owner' uid, which mostly is only used for initial
process, but is basically root with a different name, and used far less.  No
uid transitions without factotem so that it *looked* like no root user).

> What I'd like to achieve on Linux:
> 
> * unprivileged users can have their own mount namespace, where they
>   can mount at will (maybe just 9P).

No problem, you can do that now.

> * but they still appear as the same normal users to the rest of the
>   system

No problem, you can do that now.

> * 9p programs (compiled for Linux ABI) can run parallel to traditional
>   linux programs within the same user and sessions (eg. from a terminal,
>   i can call both the same way)
> * namespace modifications affect both equally (eg. I could run ff in
>   an own ns)

affect both of what equally?

> * these namespaces exist as long as there's one process alive in here

That's sort of how it is now, except you can also pin the namespaces
with their fds.

> * creating a new ns can be done by unprivileged user

That's true now.

>  One of the things to make this work (w/o introducing a massive security
> hole) is disable suid for those processes (actually, one day i'd like to
> get rid of it completely, but that's another story).

That's exactly what user namespaces are for.  You can create a new
user namespace, using no privilege at all, with your current uid (i.e.
1000) mapped to whatever uid you like; if you pick 0, then you can unshare all
the namespaces you like.  Once you unshare mnt_ns, you can mount to your
heart's content.  To other processes on the host, your process is
uid 1000.  Host uid 0 is not mapped into your ns, so you cannot exploit
suid to host root.

Regarding factotem, I agree that with the pidfd work going on etc, it's getting
more and more tempting to attempt a switch to that.  Looking back at my folder,
I see you posted a kernel patch for it.  I had done the same long ago.  Happy to
work with you again on that, and put a simple daemon into shadow package, if
util-linux isn't deemed the far better place.

-serge
