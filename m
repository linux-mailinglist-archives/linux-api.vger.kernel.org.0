Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80648410AA5
	for <lists+linux-api@lfdr.de>; Sun, 19 Sep 2021 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhISH5x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Sep 2021 03:57:53 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:39187 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhISH5x (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 19 Sep 2021 03:57:53 -0400
Date:   Sun, 19 Sep 2021 09:56:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1632038184; bh=xL2yRU3hqjAA5AqzA2w+f8V99mm7v0UdBYoQwkYruO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nys5Uaav2i7LlbeSiyABxBYqroPRxVhUJAupsl0zqwyFqWmWgzM/Zn+Hn4njNnpt2
         QsWIxEyiTj0G8OzYSmzxgQJRpr3kPHCQwo4Oe54z4xuIp/K/TlUelx7vVjhYDVX6Se
         VPMoF89DkpBUjeKI7qQQE9A0Nb1F+24q1V4MzzL4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
 <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021-09-18T11:47-0700, Andy Lutomirski wrote:
> On Thu, Sep 16, 2021, at 2:27 AM, Christian Brauner wrote:
> > On Wed, Sep 15, 2021 at 09:47:25AM -0700, Andy Lutomirski wrote:
> > > On Wed, Sep 15, 2021 at 8:50 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I would like to propose a new syscall that exposes the functionality of
> > > > request_module() to userspace.
> > > >
> > > > Propsed signature: request_module(char *module_name, char **args, int flags);
> > > > Where args and flags have to be NULL and 0 for the time being.
> > > >
> > > > Rationale:
> > > >
> > > > We are using nested, privileged containers which are loading kernel modules.
> > > > Currently we have to always pass around the contents of /lib/modules from the
> > > > root namespace which contains the modules.
> > > > (Also the containers need to have userspace components for moduleloading
> > > > installed)
> > > >
> > > > The syscall would remove the need for this bookkeeping work.
> > > 
> > > I feel like I'm missing something, and I don't understand the purpose
> > > of this syscall.  Wouldn't the right solution be for the container to
> > > have a stub module loader (maybe doable with a special /sbin/modprobe
> > > or maybe a kernel patch would be needed, depending on the exact use
> > > case) and have the stub call out to the container manager to request
> > > the module?  The container manager would check its security policy and
> > > load the module or not load it as appropriate.
> > 
> > I don't see the need for a syscall like this yet either.
> > 
> > This should be the job of the container manager. modprobe just calls the
> > init_module() syscall, right?
> 
> Not quite so simple. modprobe parses things in /lib/modules and maybe /etc to decide what init_module() calls to do.
> 
> But I admit I’m a bit confused.  What exactly is the container doing that causes the container’s copy of modprobe to be called?

The container is running an instance of the docker daemon in swarm mode.
That needs the "ip_vs" module (amongst others) and explicitly tries to load it
via modprobe.

> > If so the seccomp notifier can be used to intercept this system call for
> > the container and verify the module against an allowlist similar to how
> > we currently handle mount.
> > 
> > Christian
> > 
