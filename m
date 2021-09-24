Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1141756B
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbhIXNWW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 09:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346169AbhIXNVQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 24 Sep 2021 09:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13D0060FC1;
        Fri, 24 Sep 2021 13:19:41 +0000 (UTC)
Date:   Fri, 24 Sep 2021 15:19:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <20210924131939.4jaou665fodiziml@wittgenstein>
References: <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
 <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
 <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de>
 <YUi95tFDWS7oceYP@bombadil.infradead.org>
 <CALCETrX9keVFxEZYUkKr7_dWb9Ubo9q4E2aTY_ZOWGSHyRph8g@mail.gmail.com>
 <20210922122523.72ypzg4pm2x6nkod@wittgenstein>
 <59e230b3-0e85-42ff-84a8-6b30ad0719d8@www.fastmail.com>
 <20210922155253.nj5dorsyv7loduws@wittgenstein>
 <0f209e1c-3d5c-46be-b5e7-323970112a8e@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f209e1c-3d5c-46be-b5e7-323970112a8e@www.fastmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 22, 2021 at 01:06:49PM -0700, Andy Lutomirski wrote:
> 
> 
> On Wed, Sep 22, 2021, at 8:52 AM, Christian Brauner wrote:
> > On Wed, Sep 22, 2021 at 08:34:23AM -0700, Andy Lutomirski wrote:
> >> On Wed, Sep 22, 2021, at 5:25 AM, Christian Brauner wrote:
> >> > On Mon, Sep 20, 2021 at 11:36:47AM -0700, Andy Lutomirski wrote:
> >> >> On Mon, Sep 20, 2021 at 11:16 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >> >> >
> >> >> > On Mon, Sep 20, 2021 at 04:51:19PM +0200, Thomas Weißschuh wrote:
> >> >> 
> >> >> > > > Do you mean it literally invokes /sbin/modprobe?  If so, hooking this
> >> >> > > > at /sbin/modprobe and calling out to the container manager seems like
> >> >> > > > a decent solution.
> >> >> > >
> >> >> > > Yes it does. Thanks for the idea, I'll see how this works out.
> >> >> >
> >> >> > Would documentation guiding you in that way have helped? If so
> >> >> > I welcome a patch that does just that.
> >> >> 
> >> >> If someone wants to make this classy, we should probably have the
> >> >> container counterpart of a standardized paravirt interface.  There
> >> >> should be a way for a container to, in a runtime-agnostic way, issue
> >> >> requests to its manager, and requesting a module by (name, Linux
> >> >> kernel version for which that name makes sense) seems like an
> >> >> excellent use of such an interface.
> >> >
> >> > I always thought of this in two ways we currently do this:
> >> >
> >> > 1. Caller transparent container manager requests.
> >> >    This is the seccomp notifier where we transparently handle syscalls
> >> >    including intercepting init_module() where we parse out the module to
> >> >    be loaded from the syscall args of the container and if it is
> >> >    allow-listed load it for the container otherwise continue the syscall
> >> >    letting it fail or failing directly through seccomp return value.
> >> 
> >> Specific problems here include aliases and dependencies.  My modules.alias file, for example, has:
> >> 
> >> alias net-pf-16-proto-16-family-wireguard wireguard
> >> 
> >> If I do modprobe net-pf-16-proto-16-family-wireguard, modprobe parses some files in /lib/modules/`uname -r` and issues init_module() asking for 'wireguard'.  So hooking init_module() is at the wrong layer -- for that to work, the container's /sbin/modprobe needs to already have figured out that the desired module is wireguard and have a .ko for it.
> >
> > You can't use the container's .ko module. For this you would need to
> > trust the image that the container wants you to load. The container
> > manager should always load a host module.
> >
> 
> Agreed. 
> 
> >> 
> >> >
> >> > 2. A process in the container explicitly calling out to the container
> >> >    manager.
> >> >    One example how this happens is systemd-nspawn via dbus messages
> >> >    between systemd in the container and systemd outside the container to
> >> >    e.g. allocate a new terminal in the container (kinda insecure but
> >> >    that's another issue) or other stuff.
> >> >
> >> > So what was your idea: would it be like a device file that could be
> >> > exposed to the container where it writes requestes to the container
> >> > manager? What would be the advantage to just standardizing a socket
> >> > protocol which is what we do for example (it doesn't do module loading
> >> > of course as we handle that differently):
> >> 
> >> My idea is standardizing *something*.  I think it would be nice if, for example, distros could ship a /sbin/modprobe that would do the right thing inside any compliant container runtime as well as when running outside a container.
> >> 
> >> I suppose container managers could also bind-mount over /sbin/modprobe, but that's more intrusive.
> >
> > I don't see this is a big issue because that is fairly trivial.
> > I think we never want to trust the container's modules.
> > What probably should be happening is that the manager exposes a list of
> > modules the container can request in some form. We have precedence for
> > doing something like this.
> > So now modprobe and similar tools can be made aware that if they are in
> > a container they should request that module from the container manager
> > be it via a socket request or something else.
> > Nesting will be a bit funny but can probably be made to work by just
> > bind-mounting the outermost socket into the container or relaying the
> > request.
> 
> Why bother with a list?  I think it should be sufficient for the container to ask for a module and either get it or not get it.

I just meant that the programs in the container can see the modules
available on the host. Simplest thing could be bind-mounting in the
host's module folder with suitable protection (locked read-only mount).
But yeah, it can likely be as simple as allowing it to ask for a module
and not bother telling it about what is available.
