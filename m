Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A591A1F54
	for <lists+linux-api@lfdr.de>; Wed,  8 Apr 2020 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgDHK6e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Apr 2020 06:58:34 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:41327 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgDHK6d (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 8 Apr 2020 06:58:33 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id D4C9120211;
        Wed,  8 Apr 2020 12:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1586343510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxctWyT+JiKrOGfDcnyPqiR72gwRBwMAOHj/nXnmMmQ=;
        b=U5OnwhQRandBWbat075WDft87Vg33GbkBWrkIxbPshxbX/Hu+xj8O7C+UPuevYVStG3A67
        9vv+LfRaZG1sZ2Adio2P1hafXpSyeMJ9xGRvnf8GEg983sX3w6UhgnpygxXMHMRSkjFxzt
        7d4Go9fa4cFFBWQQ7vOrCgCPOKmvxHzwup/igMtNtmwvFulKpBWsJAjY1whm+cMyiUftgv
        lYVNj5sbEuVRqN1sKaqZtx45x+J3aWBSj4LXRD/izIS4QZng9jGfKhz+AKvYedPgreWIcO
        rOIvraRchmS4Wu1OLCdIiL0DtL0bfcSceZrAnpF2BY1ToSrqWfXzcYbqE4E8TQ==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Wed, 8 Apr 2020
 12:58:30 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Wed, 8 Apr 2020 12:58:30 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>
CC:     Sargun Dhillon <sargun@sargun.me>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "jld@mozilla.com" <jld@mozilla.com>, Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "gpascutto@mozilla.com" <gpascutto@mozilla.com>,
        "ealvarez@mozilla.com" <ealvarez@mozilla.com>
Subject: AW: [RESEND] RFC: pidfd_getfd(2) manual page
Thread-Topic: [RESEND] RFC: pidfd_getfd(2) manual page
Thread-Index: AQHWDQ1QKS6wDf99bkOBKNwglDAIE6hut5OAgAANW4CAAEktag==
Date:   Wed, 8 Apr 2020 10:58:30 +0000
Message-ID: <7bc4e35c0ff945abb8b917d637f5c42a@bfs.de>
References: <d6be97d1-38a5-bf43-7c80-7c952a5a44a3@gmail.com>
 <20200408074459.q3njmvizjge7timg@wittgenstein>,<CAKgNAkjeUo4j9f=nBvoK3Vg1U9MqT=SgQBxHQ046-eL1nFbF2w@mail.gmail.com>
In-Reply-To: <CAKgNAkjeUo4j9f=nBvoK3Vg1U9MqT=SgQBxHQ046-eL1nFbF2w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=1.40
X-Spam-Level: *
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [1.40 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_HAM(-0.10)[65.56%];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[18];
         NEURAL_HAM(-0.00)[-0.868];
         FREEMAIL_TO(0.00)[ubuntu.com,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


________________________________________
Von: linux-man-owner@vger.kernel.org <linux-man-owner@vger.kernel.org> im A=
uftrag von Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Gesendet: Mittwoch, 8. April 2020 10:32
An: Christian Brauner
Cc: Sargun Dhillon; linux-man; Linux API; lkml; Tycho Andersen; Jann Horn; =
Aleksa Sarai; Christian Brauner; Oleg Nesterov; Andy Lutomirski; Alexander =
Viro; jld@mozilla.com; Arnd Bergmann; Florian Weimer; gpascutto@mozilla.com=
; ealvarez@mozilla.com
Betreff: Re: [RESEND] RFC: pidfd_getfd(2) manual page

Hello Christian,

On Wed, 8 Apr 2020 at 09:45, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Apr 07, 2020 at 08:49:35PM +0200, Michael Kerrisk (man-pages) wro=
te:
> > [No response on my mail of a week ago, so I try again; the page
> > text is unchanged since the draft sent out on 31 March]
>
> Sorry for the delay.
>
> >
> > Hello Sargun et al.
> >
> > I've taken a shot at writing a manual page for pidfd_getfd().
> > I would be happy to receive comments, suggestions for
> > improvements, etc. The text is as follows (the groff source
> > is at the foot of this mail):
>
> Thanks for that! Really appreciated. Just a few nits below.

Thanks for the review!

> > NAME
> >        pidfd_getfd  -  obtain  a  duplicate  of  another  process's  fi=
le
> >        descriptor
> >
> > SYNOPSIS
> >        int pidfd_getfd(int pidfd, int targetfd, unsigned int flags);
> >
> > DESCRIPTION
> >        The pidfd_getfd() system call allocates a new file  descriptor  =
in
> >        the  calling  process.  This new file descriptor is a duplicate =
of
> >        an existing file descriptor, targetfd, in the process referred  =
to
> >        by the PID file descriptor pidfd.
> >
> >        The  duplicate  file  descriptor  refers  to  the  same  open fi=
le
> >        description (see open(2)) as the original file descriptor  in  t=
he
> >        process referred to by pidfd.  The two file descriptors thus sha=
re
> >        file status flags and file offset.  Furthermore, operations on t=
he
> >        underlying  file  object  (for  example, assigning an address to=
 a
> >        socket object using bind(2)) can be equally be performed  via  t=
he
>
> s/can be equally be performed/can be equally performed
> ?

Thanks. I made it: "can equally be performed"

> >        duplicate file descriptor.
> >
> >        The  close-on-exec  flag  (FD_CLOEXEC; see fcntl(2)) is set on t=
he
> >        file descriptor returned by pidfd_getfd().
> >
> >        The flags argument is reserved for future use.  Currently, it mu=
st
> >        be specified as 0.
> >
> >        Permission  to duplicate another process's file descriptor is go=
v=1B$B!>=1B(B
> >        erned by a ptrace access mode  PTRACE_MODE_ATTACH_REALCREDS  che=
ck
> >        (see ptrace(2)).
> >
> > RETURN VALUE
> >        On  success,  pidfd_getfd() returns a nonnegative file descripto=
r.
>
> Imho, this makes it sound like there are negative file descriptor
> numbers. But as a non-native speaker that might just be a subtle
> misreading on my part. Maybe just like open() just mention:
> "On success, pidfd_getfd() returns a file descriptor."

You're right. That wording is just clumsy! I fixed it.

    On success, pidfd_getfd() returns a file descriptor (a
    nonnegative integer).

And I also fixed similar clumsy wordings in a number of other pages.


perhaps "greater or equal 0" instead on nonnegativ, people are
bad with negations.
re,
 wh

> >        On error, -1 is returned and errno is set to indicate the cause =
of
> >        the error.
> >
> > ERRORS
> >        EBADF  pidfd is not a valid PID file descriptor.
> >
> >        EBADF  targetfd  is  not  an  open  file descriptor in the proce=
ss
> >               referred to by pidfd.
> >
> >        EINVAL flags is not 0.
> >
> >        EMFILE The per-process limit on the number of open  file  descri=
p=1B$B!>=1B(B
> >               tors has been reached (see the description of RLIMIT_NOFI=
LE
> >               in getrlimit(2)).
> >
> >        ENFILE The system-wide limit on the total number of open files h=
as
> >               been reached.
> >
> >        ESRCH  The  process  referred to by pidfd does not exist (i.e., =
it
> >               has terminated and been waited on).
>
> EPERM   The calling process did not have PTRACE_MODE_ATTACH_REALCREDS
>         permissions (see ptrace(2)) over the process referred to by
>         pidfd.

Oh yes. Thanks. Added.

> Technically, there should also be a disclaimer that other errno values
> are possible because of LSM denials, e.g. selinux could return EACCES or
> any other errno code in their file_receive() hook. But I'm not whether we
> generally do this. In any case, I would find it useful as a developer.

No, the manual pages don't generally include this. Mainly because I
just don't know all the details.

> (Is there actually a place where all LSMs are forced to record their
> errno returns for their security hooks for each syscall they hook into an=
d
> that's visible to userspace? Because that'd be really useful...)

Nothing that I'm aware of, unfortunately.

Thanks again for the review!

Cheers,

Michael


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
