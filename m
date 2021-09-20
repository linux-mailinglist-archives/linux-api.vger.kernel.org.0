Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1105441228E
	for <lists+linux-api@lfdr.de>; Mon, 20 Sep 2021 20:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351649AbhITSQA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Sep 2021 14:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346019AbhITSNY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Sep 2021 14:13:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892DDC06119C;
        Mon, 20 Sep 2021 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=rPf4aIjt28J9Hb/Zj4X/fJW+KULaG2Xw2AIXFCgCE+o=; b=NQfJV104PpHXxMpeZ80pOZx2sl
        PBipLdBg+fnggnwOis6OidrVtOoxklYVwV8bV2YLNBp2xB+ukUhTCtez48Ako1NJoXI+cmzMmgBUI
        sNLa6w1YwIijD40CFX6rT4Uh2FSufCfadBhVkYHt0xAEVnlUCjeCJuSZMxnJFYDE463z35lziNLfu
        eeqDn3SoNzWEDtgLnuHVlmPmM6YBAKG0sqPcy4ZffEwwT+bcDdDbaYjSfFB7hjOzXXttI8Ce20KPO
        22/f+h2fuw+XFz0iFF3XE4kkS98u7t9/dyiq7HoXOVY51ChB06t3jvTx3FZ6bPWFO/cm0Rc1LM/E4
        8fDL8XRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSMdS-002Vfu-8Q; Mon, 20 Sep 2021 16:59:18 +0000
Date:   Mon, 20 Sep 2021 09:59:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <YUi95tFDWS7oceYP@bombadil.infradead.org>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
 <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
 <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
 <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 20, 2021 at 04:51:19PM +0200, Thomas Weißschuh wrote:
> On 2021-09-19T07:37-0700, Andy Lutomirski wrote:
> > On Sun, Sep 19, 2021 at 12:56 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > >
> > > On 2021-09-18T11:47-0700, Andy Lutomirski wrote:
> > > > On Thu, Sep 16, 2021, at 2:27 AM, Christian Brauner wrote:
> > > > > On Wed, Sep 15, 2021 at 09:47:25AM -0700, Andy Lutomirski wrote:
> > > > > > On Wed, Sep 15, 2021 at 8:50 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > I would like to propose a new syscall that exposes the functionality of
> > > > > > > request_module() to userspace.
> > > > > > >
> > > > > > > Propsed signature: request_module(char *module_name, char **args, int flags);
> > > > > > > Where args and flags have to be NULL and 0 for the time being.
> > > > > > >
> > > > > > > Rationale:
> > > > > > >
> > > > > > > We are using nested, privileged containers which are loading kernel modules.
> > > > > > > Currently we have to always pass around the contents of /lib/modules from the
> > > > > > > root namespace which contains the modules.
> > > > > > > (Also the containers need to have userspace components for moduleloading
> > > > > > > installed)
> > > > > > >
> > > > > > > The syscall would remove the need for this bookkeeping work.
> > > > > >
> > > > > > I feel like I'm missing something, and I don't understand the purpose
> > > > > > of this syscall.  Wouldn't the right solution be for the container to
> > > > > > have a stub module loader (maybe doable with a special /sbin/modprobe
> > > > > > or maybe a kernel patch would be needed, depending on the exact use
> > > > > > case) and have the stub call out to the container manager to request
> > > > > > the module?  The container manager would check its security policy and
> > > > > > load the module or not load it as appropriate.
> > > > >
> > > > > I don't see the need for a syscall like this yet either.
> > > > >
> > > > > This should be the job of the container manager. modprobe just calls the
> > > > > init_module() syscall, right?
> > > >
> > > > Not quite so simple. modprobe parses things in /lib/modules and maybe /etc to decide what init_module() calls to do.
> > > >
> > > > But I admit I’m a bit confused.  What exactly is the container doing that causes the container’s copy of modprobe to be called?
> > >
> > > The container is running an instance of the docker daemon in swarm mode.
> > > That needs the "ip_vs" module (amongst others) and explicitly tries to load it
> > > via modprobe.
> > >
> > 
> > Do you mean it literally invokes /sbin/modprobe?  If so, hooking this
> > at /sbin/modprobe and calling out to the container manager seems like
> > a decent solution.
> 
> Yes it does. Thanks for the idea, I'll see how this works out.

Would documentation guiding you in that way have helped? If so
I welcome a patch that does just that.

  Luis
