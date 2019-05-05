Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4212513CCE
	for <lists+linux-api@lfdr.de>; Sun,  5 May 2019 04:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfEECcI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 4 May 2019 22:32:08 -0400
Received: from mail.hallyn.com ([178.63.66.53]:40736 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfEECcH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 4 May 2019 22:32:07 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id EEBF95E2; Sat,  4 May 2019 21:32:04 -0500 (CDT)
Date:   Sat, 4 May 2019 21:32:04 -0500
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
Message-ID: <20190505023204.GA4445@mail.hallyn.com>
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415155034.GA25351@mail.hallyn.com>
 <000a64d6-1e22-21bf-f232-15f141092e44@metux.net>
 <20190429154949.GA23456@mail.hallyn.com>
 <c95fbdbb-a62b-4ad1-f4be-7d1a8f96f508@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95fbdbb-a62b-4ad1-f4be-7d1a8f96f508@metux.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 07:31:43PM +0200, Enrico Weigelt, metux IT consult wrote:

Argh.  Sorry, it seems your emails aren't making it into my inbox, only
my once-in-a-long-while-checked lkml folder.  Sorry again.

> On 29.04.19 17:49, Serge E. Hallyn wrote:
> 
> >> * all users are equal - no root at all. the only exception is the>>   initial process, which gets the kernel devices mounted into his>>
>  namespace.> > This does not match my understanding, but I'm most likely
> wrong.  (I thought> there was an actual 'host owner' uid, which mostly
> is only used for initial> process, but is basically root with a
> different name, and used far less.  No> uid transitions without factotem
> so that it *looked* like no root user).
> Not quite (IIRC). The hostowner is just the user who booted the machine,
> the initial process runs under this uname and gets the kernel devices
> bound into his namespace, so he can start fileservers on them.
> 
> Also the caphash device (the one you can create capabilities, eg. for
> user change, which then can be used via capuse device) can only be
> opened once - usually by the host factotum.
> 
> There really is no such thing like root user.
> 
> >> What I'd like to achieve on Linux:>>>> * unprivileged users can have their own mount namespace, where
> they>>   can mount at will (maybe just 9P).> > No problem, you can do
> that now.
>
> But only within separate userns, IMHO. (and, when I last tried, plain

"Only within a separate userns" - but why does that matter?  It's just
a different uid mapping.

> users couldn't directly create their userns).

Plain users can definately create their own userns, directly.  On some
distros there is a kernel knob like

#cat /proc/sys/kernel/unprivileged_userns_clone
1

which when unset prevents unprivileged users creating a namespace.

> >> * but they still appear as the same normal users to the rest of the
> >>   system
> > 
> > No problem, you can do that now.
> 
> How exactly ? Did I miss something vital ?

By unsharing your namespace and writing the new uid mapping.  You can of
course only map your own uid without using any privileged helpers at all.
And it requires help from a second process, which does the writing to
the uid map file after the first process has unshared.  But you can do it.
For instance, using the nsexec.c at

	https://github.com/fcicq/nsexec

You can:

Terminal 1:
	shallyn@stp:~/src/nsexec$ ./nsexec -UWm
	about to unshare with 10020000
	Press any key to exec (I am 31157)

Now in terminal 2:

Terminal 2:
	shallyn@stp:~/src/nsexec$ echo "0 1000 1" > /proc/31157/uid_map
	shallyn@stp:~/src/nsexec$ echo deny > /proc/31157/setgroups
	shallyn@stp:~/src/nsexec$ echo "0 1000 1" > /proc/31157/gid_map

Then back in terminal 1:
	# id
	uid=0(root) gid=0(root) groups=0(root),65534(nogroup)
	# mount --bind /etc /mnt
	# echo $?
	0
	# ls /root
	ls: cannot open directory '/root': Permission denied

To the rest of the system you look like uid 1000.  You could have
chosen uid 1000 in your new namespace, but then you couldn't mount.
Of course you can nest user namespaces so you could create another,
this time mapping uid 1000 so you look like 1000 to yourself as well.

> >> * 9p programs (compiled for Linux ABI) can run parallel to traditional
> >>   linux programs within the same user and sessions (eg. from a terminal,
> >>   i can call both the same way)
> >> * namespace modifications affect both equally (eg. I could run ff in
> >>   an own ns)
> > 
> > affect both of what equally?
> 
> mount / bind.
> 
> > That's exactly what user namespaces are for.  You can create a new
> > user namespace, using no privilege at all, with your current uid (i.e.
> > 1000) mapped to whatever uid you like; if you pick 0, then you can unshare all
> > the namespaces you like.  
> 
> But I don't like to appear as 'root' in here. I just wanna have my own
> filesystem namespace, nothing more.

Right.  As you know setuid makes that impossible, unfortunately.  That's
where nonewprivs shows promise.

> > Once you unshare mnt_ns, you can mount to your
> > heart's content.  To other processes on the host, your process is
> > uid 1000.
> 
> Is that the uid, I'm appearing to filesystems ?

Yes.

> > Regarding factotem, I agree that with the pidfd work going on etc, it's getting
> > more and more tempting to attempt a switch to that.  Looking back at my folder,
> > I see you posted a kernel patch for it.  I had done the same long ago.  Happy to
> > work with you again on that, and put a simple daemon into shadow package, if
> > util-linux isn't deemed the far better place.
> 
> Yeah :)
> 
> 
> --mtx
> 
> -- 
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
