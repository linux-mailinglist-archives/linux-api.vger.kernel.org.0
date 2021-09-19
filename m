Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F8410BEE
	for <lists+linux-api@lfdr.de>; Sun, 19 Sep 2021 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhISOi5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Sep 2021 10:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231588AbhISOiz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 19 Sep 2021 10:38:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D57961242
        for <linux-api@vger.kernel.org>; Sun, 19 Sep 2021 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632062250;
        bh=AnYWqh/Vn9lcDJVwlA4yA3xeryd+o1zHbhYrO7Kfiis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sLHBa0n86nsmPAjPNSixgBM0imzft4t65tN0cQjdoOlSAJXK20zZeZBMpZTVYKXBL
         jqUGd4XeOUqVnO4iy+NlvQLR9NeN2UVJTN2MS09AmhN52LyCsIFj+w77pOgPzELx/2
         +Nw8UN/YZD4oFpkQvpjLraS0OAyfc9H4TMMHYi7jrwhQoJe2t2UZ1kBT8jVQLpWNc5
         9uhAaM4SDO0kYR3g5s1LI3vZqFAbLcZiZpWcxbD9k/KlmDwXbBnUmr/cEJcf2cvISu
         AXhicw6HHP3kxAh3+LbGHbgHMOT6QIKQ4vKftkXvrNkDHuYdVnG96+1doPGtX6SpRa
         9bpipiVj8CyXQ==
Received: by mail-ed1-f44.google.com with SMTP id bx4so5424212edb.4
        for <linux-api@vger.kernel.org>; Sun, 19 Sep 2021 07:37:30 -0700 (PDT)
X-Gm-Message-State: AOAM5318X4l6yt2sXMRmySz/8SAll5e5AHXAPdasmvwGj4V6pIOfwAmA
        Kx0Yj67L4wryoj2Ks7gSY9XNWSAVNlFj8znOOnkchQ==
X-Google-Smtp-Source: ABdhPJxABpLS5hC6VSG1+CEFmVFgpUScWaiJ/5Ab/CVzOBt6wC0yxp0QbgR+/bsxTeVfo/JUbtWLDXhXfxZD5kq2GUY=
X-Received: by 2002:a17:906:32cf:: with SMTP id k15mr23665867ejk.68.1632062249221;
 Sun, 19 Sep 2021 07:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein> <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
In-Reply-To: <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 19 Sep 2021 07:37:16 -0700
X-Gmail-Original-Message-ID: <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
Message-ID: <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
Subject: Re: [RFC] Expose request_module via syscall
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Sep 19, 2021 at 12:56 AM Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wr=
ote:
>
> On 2021-09-18T11:47-0700, Andy Lutomirski wrote:
> > On Thu, Sep 16, 2021, at 2:27 AM, Christian Brauner wrote:
> > > On Wed, Sep 15, 2021 at 09:47:25AM -0700, Andy Lutomirski wrote:
> > > > On Wed, Sep 15, 2021 at 8:50 AM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I would like to propose a new syscall that exposes the functional=
ity of
> > > > > request_module() to userspace.
> > > > >
> > > > > Propsed signature: request_module(char *module_name, char **args,=
 int flags);
> > > > > Where args and flags have to be NULL and 0 for the time being.
> > > > >
> > > > > Rationale:
> > > > >
> > > > > We are using nested, privileged containers which are loading kern=
el modules.
> > > > > Currently we have to always pass around the contents of /lib/modu=
les from the
> > > > > root namespace which contains the modules.
> > > > > (Also the containers need to have userspace components for module=
loading
> > > > > installed)
> > > > >
> > > > > The syscall would remove the need for this bookkeeping work.
> > > >
> > > > I feel like I'm missing something, and I don't understand the purpo=
se
> > > > of this syscall.  Wouldn't the right solution be for the container =
to
> > > > have a stub module loader (maybe doable with a special /sbin/modpro=
be
> > > > or maybe a kernel patch would be needed, depending on the exact use
> > > > case) and have the stub call out to the container manager to reques=
t
> > > > the module?  The container manager would check its security policy =
and
> > > > load the module or not load it as appropriate.
> > >
> > > I don't see the need for a syscall like this yet either.
> > >
> > > This should be the job of the container manager. modprobe just calls =
the
> > > init_module() syscall, right?
> >
> > Not quite so simple. modprobe parses things in /lib/modules and maybe /=
etc to decide what init_module() calls to do.
> >
> > But I admit I=E2=80=99m a bit confused.  What exactly is the container =
doing that causes the container=E2=80=99s copy of modprobe to be called?
>
> The container is running an instance of the docker daemon in swarm mode.
> That needs the "ip_vs" module (amongst others) and explicitly tries to lo=
ad it
> via modprobe.
>

Do you mean it literally invokes /sbin/modprobe?  If so, hooking this
at /sbin/modprobe and calling out to the container manager seems like
a decent solution.

> > > If so the seccomp notifier can be used to intercept this system call =
for
> > > the container and verify the module against an allowlist similar to h=
ow
> > > we currently handle mount.
> > >
> > > Christian
> > >
