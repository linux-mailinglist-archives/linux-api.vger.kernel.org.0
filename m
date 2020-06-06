Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6B1F0461
	for <lists+linux-api@lfdr.de>; Sat,  6 Jun 2020 05:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgFFDRj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Jun 2020 23:17:39 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:30288 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgFFDRj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 5 Jun 2020 23:17:39 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 4768C89CD4
        for <linux-api@vger.kernel.org>; Sat,  6 Jun 2020 03:17:38 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 49f4Sy07PPz4d48
        for <linux-api@vger.kernel.org>; Sat,  6 Jun 2020 03:17:36 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
        (Authenticated sender: kevans)
        by smtp.freebsd.org (Postfix) with ESMTPSA id EF8F12066D
        for <linux-api@vger.kernel.org>; Sat,  6 Jun 2020 03:17:35 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: by mail-qt1-f169.google.com with SMTP id z1so10355647qtn.2
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2020 20:17:35 -0700 (PDT)
X-Gm-Message-State: AOAM530tRVtGiVeMJvr0hU1wiDxAL9DAysF2zI0XIRAXlWddf6Y0TetM
        QQQJaaK+thCTLKmuAb1mgiROSWkoH7YGaXevfWA=
X-Received: by 2002:ac8:1c71:: with SMTP id j46mt13825159qtk.60.1591413085829;
 Fri, 05 Jun 2020 20:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <20200602204219.186620-2-christian.brauner@ubuntu.com> <20200605145549.GC673948@port70.net>
 <CACNAnaEjjQBB8ieZH+td8jk-Aitg3CjGB1WwGQwEv-STg5Do+g@mail.gmail.com>
In-Reply-To: <CACNAnaEjjQBB8ieZH+td8jk-Aitg3CjGB1WwGQwEv-STg5Do+g@mail.gmail.com>
From:   Kyle Evans <kevans@freebsd.org>
Date:   Fri, 5 Jun 2020 22:11:14 -0500
X-Gmail-Original-Message-ID: <CACNAnaGKr2WMGhiXUb4_HVQCKwe5RH7fTNuRHuwCtbfnBK-gXQ@mail.gmail.com>
Message-ID: <CACNAnaGKr2WMGhiXUb4_HVQCKwe5RH7fTNuRHuwCtbfnBK-gXQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] open: add close_range()
Cc:     Szabolcs Nagy <nsz@port70.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        torvalds@linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Victor Stinner <victor.stinner@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, fweimer@redhat.com, jannh@google.com,
        oleg@redhat.com, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, ldv@altlinux.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 5, 2020 at 9:54 PM Kyle Evans <kevans@freebsd.org> wrote:
>
> On Fri, Jun 5, 2020 at 9:55 AM Szabolcs Nagy <nsz@port70.net> wrote:
> >
> > * Christian Brauner <christian.brauner@ubuntu.com> [2020-06-02 22:42:17 +0200]:
> > > [... snip ...]
> > >
> > > First, it helps to close all file descriptors of an exec()ing task. This
> > > can be done safely via (quoting Al's example from [1] verbatim):
> > >
> > >         /* that exec is sensitive */
> > >         unshare(CLONE_FILES);
> > >         /* we don't want anything past stderr here */
> > >         close_range(3, ~0U);
> > >         execve(....);
> >
> > this api needs a documentation patch if there isn't yet.
> >
> > currently there is no libc interface contract in place that
> > says which calls may use libc internal fds e.g. i've seen
> >
> >   openlog(...) // opens libc internal syslog fd
> >   ...
> >   fork()
> >   closefrom(...) // close syslog fd
> >   open(...) // something that reuses the closed fd
> >   syslog(...) // unsafe: uses the wrong fd
> >   execve(...)
> >
> > syslog uses a libc internal fd that the user trampled on and
> > this can go bad in many ways depending on what libc apis are
> > used between closefrom (or equivalent) and exec.
> >
>
> Documentation is good. :-) I think you'll find that while this example
> seems to be innocuous on FreeBSD (and likely other *BSD), this is an
> atypical scenario and generally not advised.  You would usually not
> start closing until you're actually ready to exec/fail.
>

Minor correction: not innocuous here, either; O_CLOFORK is not yet a thing. :-)
