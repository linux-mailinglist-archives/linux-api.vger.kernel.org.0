Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499BF411794
	for <lists+linux-api@lfdr.de>; Mon, 20 Sep 2021 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbhITOw6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Sep 2021 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbhITOws (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Sep 2021 10:52:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0F9C061760;
        Mon, 20 Sep 2021 07:51:21 -0700 (PDT)
Date:   Mon, 20 Sep 2021 16:51:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1632149479; bh=co/dJGbqJm5L551DrmibCGSFvaBj4t8FzFeyP56ZHDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbnCHL07pER3pMrTk+foKktbBS+c9XGku7CuzoHy4CC9xQAB7mZwrNsBJx+VnhmzU
         p6/BO1sh6ZjTjvjF/8L4xpZ9QYD0jufhyyWS7vSLFbtJsUF4gc8ELPNeYUreCVq4cn
         H0H2cor5HYhPIqaVD7HDGx67ll4zTls7O/b5oVb0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
 <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
 <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-PGP-Key: https://t-8ch.de/pubkey.asc
X-PGP-Key-Fingerprint: 187EF7CE
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021-09-19T07:37-0700, Andy Lutomirski wrote:
> On Sun, Sep 19, 2021 at 12:56 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2021-09-18T11:47-0700, Andy Lutomirski wrote:
> > > On Thu, Sep 16, 2021, at 2:27 AM, Christian Brauner wrote:
> > > > On Wed, Sep 15, 2021 at 09:47:25AM -0700, Andy Lutomirski wrote:
> > > > > On Wed, Sep 15, 2021 at 8:50 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > I would like to propose a new syscall that exposes the functionality of
> > > > > > request_module() to userspace.
> > > > > >
> > > > > > Propsed signature: request_module(char *module_name, char **args, int flags);
> > > > > > Where args and flags have to be NULL and 0 for the time being.
> > > > > >
> > > > > > Rationale:
> > > > > >
> > > > > > We are using nested, privileged containers which are loading kernel modules.
> > > > > > Currently we have to always pass around the contents of /lib/modules from the
> > > > > > root namespace which contains the modules.
> > > > > > (Also the containers need to have userspace components for moduleloading
> > > > > > installed)
> > > > > >
> > > > > > The syscall would remove the need for this bookkeeping work.
> > > > >
> > > > > I feel like I'm missing something, and I don't understand the purpose
> > > > > of this syscall.  Wouldn't the right solution be for the container to
> > > > > have a stub module loader (maybe doable with a special /sbin/modprobe
> > > > > or maybe a kernel patch would be needed, depending on the exact use
> > > > > case) and have the stub call out to the container manager to request
> > > > > the module?  The container manager would check its security policy and
> > > > > load the module or not load it as appropriate.
> > > >
> > > > I don't see the need for a syscall like this yet either.
> > > >
> > > > This should be the job of the container manager. modprobe just calls the
> > > > init_module() syscall, right?
> > >
> > > Not quite so simple. modprobe parses things in /lib/modules and maybe /etc to decide what init_module() calls to do.
> > >
> > > But I admit I’m a bit confused.  What exactly is the container doing that causes the container’s copy of modprobe to be called?
> >
> > The container is running an instance of the docker daemon in swarm mode.
> > That needs the "ip_vs" module (amongst others) and explicitly tries to load it
> > via modprobe.
> >
> 
> Do you mean it literally invokes /sbin/modprobe?  If so, hooking this
> at /sbin/modprobe and calling out to the container manager seems like
> a decent solution.

Yes it does. Thanks for the idea, I'll see how this works out.

> > > > If so the seccomp notifier can be used to intercept this system call for
> > > > the container and verify the module against an allowlist similar to how
> > > > we currently handle mount.
> > > >
> > > > Christian
> > > >
