Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3A1A1D74
	for <lists+linux-api@lfdr.de>; Wed,  8 Apr 2020 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgDHIdC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Apr 2020 04:33:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42485 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgDHIdC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Apr 2020 04:33:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id cw6so7468943edb.9;
        Wed, 08 Apr 2020 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HN3PmUZ9fhU3DNXcfKan8qYGWgSRdIlUaBvY047r1SM=;
        b=BGTSeYrGs6nPwW0pBTwetxOvG3h4Vd6HUpUGfZ5rIw3eiXZCxuWi+RH6UpAgUftEg6
         zPBlbaYdJBTL6Hxcsz3RyLUm8ngmae4RqBCCV4ctAxgxNu32UBMO4rfX1iNadhbL0BPs
         f7ZjlUGvJiAD9LMRUxq2QBUw5vheF8E17s3Wha/fak6um0pr6m38ixUNOWcjsyJEZWik
         85yfqBynH2mPaHM3ic4TempYghYKUBGJ8ZSZWvVIiWPffuGlRe30s2rBkYuXla86bkGw
         fE/UDoKrfZR1ucy85k72pT+gjUXMykqdcwubbePajNp4DqBhcyG/lSp4D5xJutzrHQzD
         2a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HN3PmUZ9fhU3DNXcfKan8qYGWgSRdIlUaBvY047r1SM=;
        b=NA6eGPZybbDZuSkylQ9p1x3EzXWonssefRXU0ukc3p54ktn0HyWDFRBHnWCMLNv1Pp
         qU/dWqJSEfZct/f982Thkg6h/nylPv9ZiGVx5velJGkJRfWF+w9/J8DVhmn1lrEzXz0O
         hiPnbwaOpAdLf5MMaPOoda0ibqdpUTh9c2IvS8cnIZ1JsEkyTSAF5vBbWIUZVsuPFSxR
         p0ch6hmk22K/yWNpMDDX5uJfojqt8mo/o0+0FlIMXj7O7hvkA//233tRPE1qq5B/nTds
         y+yxyK/5cd/1OhnGqosOkPCc12zm46iDzmpzXAxZyOCPwXpqwxl64PKI+nrkEaqRwhH/
         4DBw==
X-Gm-Message-State: AGi0Pub9FEha6+EfNQc/vX9c+5y7wtCch9erBfMQQVsvTgc8aW0GUcGq
        5wpFSnQNBoKTLQwh5XC1mX/0mqBPZb99OT8L+3c=
X-Google-Smtp-Source: APiQypI12Fy83Q8xdUmDBUv3sQoaKGjwp78gJSBCygBXGeyhDI8Rn75HBxevzEpYv522bnR7VvPd0zJiESwOoJN+iRo=
X-Received: by 2002:a17:906:228d:: with SMTP id p13mr5304737eja.113.1586334778849;
 Wed, 08 Apr 2020 01:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <d6be97d1-38a5-bf43-7c80-7c952a5a44a3@gmail.com> <20200408074459.q3njmvizjge7timg@wittgenstein>
In-Reply-To: <20200408074459.q3njmvizjge7timg@wittgenstein>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 8 Apr 2020 10:32:47 +0200
Message-ID: <CAKgNAkjeUo4j9f=nBvoK3Vg1U9MqT=SgQBxHQ046-eL1nFbF2w@mail.gmail.com>
Subject: Re: [RESEND] RFC: pidfd_getfd(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>, jld@mozilla.com,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>, gpascutto@mozilla.com,
        ealvarez@mozilla.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

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
v=E2=80=90
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
p=E2=80=90
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


--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
