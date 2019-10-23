Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03237E131B
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 09:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbfJWH31 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 03:29:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37520 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389459AbfJWH30 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 03:29:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so19940700lje.4;
        Wed, 23 Oct 2019 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ln81R0efE/ZH1psBIcBlQmI7xQI8ZFqWWj7CvH8xre0=;
        b=KvKekcwv0dOijxy2Al4fHEN72Et9MQpp1mxiQfImKOQYNJwxlPvDZy4ISGWKtINQlY
         f6893cHnHV1EvufCLn2Vv6uzhVcXK2EG5xnHHQbgwNid1K5IBSoEQCQ75QKmuQYbU5if
         GJqmymIATeN7XkaNU4PT5M0suDtvKDVIrieyayDb1d0+mz6TgJ44bKzzobxaKnBrr6kS
         pDyECDwobqJIVkR85PLN0nqfp4JNIvMN1Erlrv9HmXML4MgmsGcVcPM+Q+KUMwFksoIQ
         58XwyaZXXEqHQ+zoynFXTfcHEc3gCRB5sTnR+fxblm8/sCJ9FD39r0o8KoXlJGr0K5uU
         CNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ln81R0efE/ZH1psBIcBlQmI7xQI8ZFqWWj7CvH8xre0=;
        b=ZNu1J6jolsdDVqcgZaxD7wnq6OrAm9L7nRLFZT0WtpE3xyyzB/ahLIAsNJJIhWl+ou
         dnkauQe72gt4Eyjh3bULfZVfIEldQv7LopLoKezAnmN5Zgg5XeFxoPP/CvXvM0TLFMpY
         2Jny+7EqnOMQGRDzLvY5SRMzkgI1AWXyOn5tkV9npmgu024f2irORDjyNWynif4Fram9
         NKRSeUdz24JMwRxG/sSw5C+s27fxoc09M358zP7Oy4UxGs++AB2ty3ppmCvL5v2HRPB4
         23uUmuL/7YF0M094cHld+ITfKAveJBV3KcFTcgOfy55kFYjSAPCU9aS2+lC+wN/JqFVt
         Jx4A==
X-Gm-Message-State: APjAAAVP70K+hGH2PfRekqv6LdZWOWPTwyvNxzUGloEMLCWLxFixKkwn
        3tsspMLlGCkz7tE0xu2hFHNbnlcO
X-Google-Smtp-Source: APXvYqzMaq6WCqannQ5qOGTc2Wl+Lp5cCBUZ9bu6HJgeq4GU1xz01AmOS487IIOca6jO+wYQLJAoBg==
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr20563733ljk.108.1571815764054;
        Wed, 23 Oct 2019 00:29:24 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id g27sm9236540lja.33.2019.10.23.00.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 00:29:22 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 76D83460F9C; Wed, 23 Oct 2019 10:29:20 +0300 (MSK)
Date:   Wed, 23 Oct 2019 10:29:20 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Pavel Emelyanov <xemul@virtuozzo.com>,
        Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Andrey Vagin <avagin@gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
Message-ID: <20191023072920.GF12121@uranus.lan>
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CALCETrX=1XUwsuKc6dinj3ZTnrK85m_+UL=iaYKj4EZtf-xm5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX=1XUwsuKc6dinj3ZTnrK85m_+UL=iaYKj4EZtf-xm5g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 22, 2019 at 09:11:04PM -0700, Andy Lutomirski wrote:
> Trying again.  It looks like I used the wrong address for Pavel.

Thanks for CC Andy! I must confess I didn't dive into userfaultfd engine
personally but let me CC more people involved from criu side. (overquoting
left untouched for their sake).

> 
> On Sat, Oct 12, 2019 at 6:14 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > [adding more people because this is going to be an ABI break, sigh]
> >
> > On Sat, Oct 12, 2019 at 5:52 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > On Sat, Oct 12, 2019 at 4:10 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > >
> > > > On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> > > > >
> > > > > The new secure flag makes userfaultfd use a new "secure" anonymous
> > > > > file object instead of the default one, letting security modules
> > > > > supervise userfaultfd use.
> > > > >
> > > > > Requiring that users pass a new flag lets us avoid changing the
> > > > > semantics for existing callers.
> > > >
> > > > Is there any good reason not to make this be the default?
> > > >
> > > >
> > > > The only downside I can see is that it would increase the memory usage
> > > > of userfaultfd(), but that doesn't seem like such a big deal.  A
> > > > lighter-weight alternative would be to have a single inode shared by
> > > > all userfaultfd instances, which would require a somewhat different
> > > > internal anon_inode API.
> > >
> > > I'd also prefer to just make SELinux use mandatory, but there's a
> > > nasty interaction with UFFD_EVENT_FORK. Adding a new UFFD_SECURE mode
> > > which blocks UFFD_EVENT_FORK sidesteps this problem. Maybe you know a
> > > better way to deal with it.
> >
> > ...
> >
> > > But maybe we can go further: let's separate authentication and
> > > authorization, as we do in other LSM hooks. Let's split my
> > > inode_init_security_anon into two hooks, inode_init_security_anon and
> > > inode_create_anon. We'd define the former to just initialize the file
> > > object's security information --- in the SELinux case, figuring out
> > > its class and SID --- and define the latter to answer the yes/no
> > > question of whether a particular anonymous inode creation should be
> > > allowed. Normally, anon_inode_getfile2() would just call both hooks.
> > > We'd add another anon_inode_getfd flag, ANON_INODE_SKIP_AUTHORIZATION
> > > or something, that would tell anon_inode_getfile2() to skip calling
> > > the authorization hook, effectively making the creation always
> > > succeed. We can then make the UFFD code pass
> > > ANON_INODE_SKIP_AUTHORIZATION when it's creating a file object in the
> > > fork child while creating UFFD_EVENT_FORK messages.
> >
> > That sounds like an improvement.  Or maybe just teach SELinux that
> > this particular fd creation is actually making an anon_inode that is a
> > child of an existing anon inode and that the context should be copied
> > or whatever SELinux wants to do.  Like this, maybe:
> >
> > static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
> >                                   struct userfaultfd_ctx *new,
> >                                   struct uffd_msg *msg)
> > {
> >         int fd;
> >
> > Change this:
> >
> >         fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
> >                               O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
> >
> > to something like:
> >
> >       fd = anon_inode_make_child_fd(..., ctx->inode, ...);
> >
> > where ctx->inode is the one context's inode.
> >
> > *** HOWEVER *** !!!
> >
> > Now that you've pointed this mechanism out, it is utterly and
> > completely broken and should be removed from the kernel outright or at
> > least severely restricted.  A .read implementation MUST NOT ACT ON THE
> > CALLING TASK.  Ever.  Just imagine the effect of passing a userfaultfd
> > as stdin to a setuid program.
> >
> > So I think the right solution might be to attempt to *remove*
> > UFFD_EVENT_FORK.  Maybe the solution is to say that, unless the
> > creator of a userfaultfd() has global CAP_SYS_ADMIN, then it cannot
> > use UFFD_FEATURE_EVENT_FORK) and print a warning (once) when
> > UFFD_FEATURE_EVENT_FORK is allowed.  And, after some suitable
> > deprecation period, just remove it.  If it's genuinely useful, it
> > needs an entirely new API based on ioctl() or a syscall.  Or even
> > recvmsg() :)
> >
> > And UFFD_SECURE should just become automatic, since you don't have a
> > problem any more. :-p
> >
> > --Andy
> 

	Cyrill
