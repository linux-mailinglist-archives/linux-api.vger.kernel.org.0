Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADB8E218A
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfJWRN5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 13:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfJWRN4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 Oct 2019 13:13:56 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C82A21A4C
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571850835;
        bh=84V+tC14Q0AwxCc6Q4KhvS7f0XqOV27JoEx/anQWRjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0n4i35i1MJSHTwgpmmVzVFAkdzTs7CLNPpufO07X7oRw1t/7XhHy9SFJ7i6Se1aqL
         BtOiOEJZSHa6m4BPkGB6tgGJisZTb0vIxa1eiXlxgsZT6G2VlmXtvNsPPstMfQjIwu
         pMXRda+2kbAlq5ZmhAjXURxrzA6DlieJ/QVZpFUY=
Received: by mail-wm1-f53.google.com with SMTP id g24so12956460wmh.5
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 10:13:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXHzPi0rFu+KyWNsGDKpitb7KiCS85MLTFBTtO3UL9vLu/3zafD
        39mALVaPSnhgakXq+kInQ08xnPZVOXco9YNCX+R6CQ==
X-Google-Smtp-Source: APXvYqwr2s8i4wko75U8bFhH/6faCf6aXEqo8WvZjrhJQA086AoHSwoHuL095B/miQIW+bZLpaRkagQYEGTMDxrjQHw=
X-Received: by 2002:a7b:cf28:: with SMTP id m8mr925998wmg.161.1571850833619;
 Wed, 23 Oct 2019 10:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CALCETrX=1XUwsuKc6dinj3ZTnrK85m_+UL=iaYKj4EZtf-xm5g@mail.gmail.com>
 <20191023072920.GF12121@uranus.lan> <20191023124358.GA2109@linux.ibm.com>
In-Reply-To: <20191023124358.GA2109@linux.ibm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Oct 2019 10:13:41 -0700
X-Gmail-Original-Message-ID: <CALCETrXxgM6UHg0wNLV3sDERR1oroAhr5zh9z+YdczxC4s5F8A@mail.gmail.com>
Message-ID: <CALCETrXxgM6UHg0wNLV3sDERR1oroAhr5zh9z+YdczxC4s5F8A@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 23, 2019 at 5:44 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Oct 23, 2019 at 10:29:20AM +0300, Cyrill Gorcunov wrote:
> > On Tue, Oct 22, 2019 at 09:11:04PM -0700, Andy Lutomirski wrote:
> > > Trying again.  It looks like I used the wrong address for Pavel.
> >
> > Thanks for CC Andy! I must confess I didn't dive into userfaultfd engine
> > personally but let me CC more people involved from criu side. (overquoting
> > left untouched for their sake).
>
> Thanks for CC Cyrill!
>
>
> > > On Sat, Oct 12, 2019 at 6:14 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > >
> > > > [adding more people because this is going to be an ABI break, sigh]
> > > >
> > > > On Sat, Oct 12, 2019 at 5:52 PM Daniel Colascione <dancol@google.com> wrote:
> > > > >
> > > > > On Sat, Oct 12, 2019 at 4:10 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > > >
> > > > > > On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> > > > > > >
> > > > > > > The new secure flag makes userfaultfd use a new "secure" anonymous
> > > > > > > file object instead of the default one, letting security modules
> > > > > > > supervise userfaultfd use.
> > > > > > >
> > > > > > > Requiring that users pass a new flag lets us avoid changing the
> > > > > > > semantics for existing callers.
> > > > > >
> > > > > > Is there any good reason not to make this be the default?
> > > > > >
> > > > > >
> > > > > > The only downside I can see is that it would increase the memory usage
> > > > > > of userfaultfd(), but that doesn't seem like such a big deal.  A
> > > > > > lighter-weight alternative would be to have a single inode shared by
> > > > > > all userfaultfd instances, which would require a somewhat different
> > > > > > internal anon_inode API.
> > > > >
> > > > > I'd also prefer to just make SELinux use mandatory, but there's a
> > > > > nasty interaction with UFFD_EVENT_FORK. Adding a new UFFD_SECURE mode
> > > > > which blocks UFFD_EVENT_FORK sidesteps this problem. Maybe you know a
> > > > > better way to deal with it.
> > > > >
> > > > > Right now, when a process with a UFFD-managed VMA using
> > > > > UFFD_EVENT_FORK forks, we make a new userfaultfd_ctx out of thin air
> > > > > and enqueue it on the message queue for the parent process. When we
> > > > > dequeue that context, we get to resolve_userfault_fork, which makes up
> > > > > a new UFFD file object out of thin air in the context of the reading
> > > > > process. Following normal SELinux rules, the SID attached to that new
> > > > > file object would be the task SID of the process *reading* the fork
> > > > > event, not the SID of the new fork child. That seems wrong, because
> > > > > the label we give to the UFFD should correspond to the label of the
> > > > > process that UFFD controls.
>
> I must admit I have no idea about how SELinux works, but what's wrong with
> making the new UFFD object to inherit the properties of the "original" one?
>
> The new file object is created in the context of the same task that owns
> the initial userfault file descriptor and it is used by the same task. So
> if you have a process that registers some of its VMAs with userfaultfd
> and enables UFFD_EVENT_FORK, the same process controls UFFD of itself and
> its children.

I'm not actually convinced this is a problem.

What *is* a problem is touching the file descriptor table at all from
read(2).  That's a big no-no.

--Andy
