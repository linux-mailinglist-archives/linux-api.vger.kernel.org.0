Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94774148C1
	for <lists+linux-api@lfdr.de>; Wed, 22 Sep 2021 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhIVM1A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Sep 2021 08:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235335AbhIVM1A (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 22 Sep 2021 08:27:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 443DF610A1;
        Wed, 22 Sep 2021 12:25:28 +0000 (UTC)
Date:   Wed, 22 Sep 2021 14:25:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <20210922122523.72ypzg4pm2x6nkod@wittgenstein>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
 <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
 <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
 <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de>
 <YUi95tFDWS7oceYP@bombadil.infradead.org>
 <CALCETrX9keVFxEZYUkKr7_dWb9Ubo9q4E2aTY_ZOWGSHyRph8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrX9keVFxEZYUkKr7_dWb9Ubo9q4E2aTY_ZOWGSHyRph8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 20, 2021 at 11:36:47AM -0700, Andy Lutomirski wrote:
> On Mon, Sep 20, 2021 at 11:16 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Sep 20, 2021 at 04:51:19PM +0200, Thomas Weißschuh wrote:
> 
> > > > Do you mean it literally invokes /sbin/modprobe?  If so, hooking this
> > > > at /sbin/modprobe and calling out to the container manager seems like
> > > > a decent solution.
> > >
> > > Yes it does. Thanks for the idea, I'll see how this works out.
> >
> > Would documentation guiding you in that way have helped? If so
> > I welcome a patch that does just that.
> 
> If someone wants to make this classy, we should probably have the
> container counterpart of a standardized paravirt interface.  There
> should be a way for a container to, in a runtime-agnostic way, issue
> requests to its manager, and requesting a module by (name, Linux
> kernel version for which that name makes sense) seems like an
> excellent use of such an interface.

I always thought of this in two ways we currently do this:

1. Caller transparent container manager requests.
   This is the seccomp notifier where we transparently handle syscalls
   including intercepting init_module() where we parse out the module to
   be loaded from the syscall args of the container and if it is
   allow-listed load it for the container otherwise continue the syscall
   letting it fail or failing directly through seccomp return value.

2. A process in the container explicitly calling out to the container
   manager.
   One example how this happens is systemd-nspawn via dbus messages
   between systemd in the container and systemd outside the container to
   e.g. allocate a new terminal in the container (kinda insecure but
   that's another issue) or other stuff.

So what was your idea: would it be like a device file that could be
exposed to the container where it writes requestes to the container
manager? What would be the advantage to just standardizing a socket
protocol which is what we do for example (it doesn't do module loading
of course as we handle that differently):

## Container to host communication
LXD sets up a socket at `/dev/lxd/sock` which root in the container can
use to communicate with LXD on the host.

In LXD, this feature is implemented through a /dev/lxd/sock node which
is created and setup for all LXD instances.

This file is a Unix socket which processes inside the instance can
connect to. It's multi-threaded so multiple clients can be connected at
the same time.

Implementation details
LXD on the host binds /var/lib/lxd/devlxd/sock and starts listening for
new connections on it.

This socket is then exposed into every single instance started by LXD at
/dev/lxd/sock.

The single socket is required so we can exceed 4096 instances,
otherwise, LXD would have to bind a different socket for every instance,
quickly reaching the FD limit.

Authentication
Queries on /dev/lxd/sock will only return information related to the
requesting instance. To figure out where a request comes from, LXD will
extract the initial socket ucred and compare that to the list of
instances it manages.

Protocol
The protocol on /dev/lxd/sock is plain-text HTTP with JSON messaging, so
very similar to the local version of the LXD protocol.

Unlike the main LXD API, there is no background operation and no
authentication support in the /dev/lxd/sock API.

Christian
