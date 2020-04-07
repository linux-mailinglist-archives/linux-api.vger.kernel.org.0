Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9556D1A1540
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 20:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgDGSto (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 14:49:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44972 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGStn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 14:49:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id c15so5048803wro.11;
        Tue, 07 Apr 2020 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fSW6zqhPZsThdcoTatdLbp7WJ3WUZiNlQXUswn8hhu4=;
        b=aRXxvQ38Ou9GCSVIy7YCqt5Ig+frDurJp4o/OLK1RDtexLvZtLqLuTX1d1HE8VXNik
         2he3dnHygK09W0+AtGtaao9wrNR+bmh0eRqBF4bTNKaPEQsD0FHeWktVfYFQ5+vmKJwJ
         tBsdqozpQf+O2ZHbqMqP5GkV99hL8JD45K4xiquvpvLuOwfn8C/lnvlEZPDqrdhwQVbI
         /8DekddnNDDs7OQD/yFWHwKAoF+5l1kNUPvmeHUIJL9h7PUvkN1EIY27NS/Pfxejxs33
         wgOFL5J8z+3Pk2etHsAGxVa25AuoNcic6dNiidJK1nPbK7lorUTux3vX6BEniF1FHyZY
         6C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fSW6zqhPZsThdcoTatdLbp7WJ3WUZiNlQXUswn8hhu4=;
        b=fHO4+BbUJS5QtmOrLTI85MLAZQ2cytfuP0Va00RzhH8Gn/uGVCBkBM6e/AJJXkYDnl
         ooGehYILgkRwIZ/qs8oaX8GWT9TTLJu7weKzZzmD0SAUhiY0gJ4dwNMR48d5LE///lJj
         ePWhqp1MSYnSigpY8k/7LTD6WuQcO08NU+NWCoRYgN7/7LKjj5YD4DuRMRsGjjyk77Ve
         U74Ole2rbBena5l6UpZj+2J37xtl2dEQiJk7XKx94B8Nx4ab8zq4INjNyxIBQZ7gFJSk
         oaCLT3bST6/Csmn67fSjN8lgs3kBSQyxJo6awI7mBZPWd923S5NGbx2GJddJXAxtNwEM
         vxAQ==
X-Gm-Message-State: AGi0PuaEaXUR7fFMle+9A5bLZAToWUeOd2VDdldXU4pPg2cKnSX+vPuP
        iIO+gh4XO6lsPdLhi/UqUIA=
X-Google-Smtp-Source: APiQypJx9PMgsqdL0juRTEGxcxw5lzragXeKvyV7yIea6qodVlFrFLc7v1oj122EmZyqCXzFqf8nog==
X-Received: by 2002:adf:9344:: with SMTP id 62mr4443781wro.12.1586285377287;
        Tue, 07 Apr 2020 11:49:37 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id p13sm31701896wru.3.2020.04.07.11.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 11:49:36 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>,
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
To:     Sargun Dhillon <sargun@sargun.me>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [RESEND] RFC: pidfd_getfd(2) manual page
Message-ID: <d6be97d1-38a5-bf43-7c80-7c952a5a44a3@gmail.com>
Date:   Tue, 7 Apr 2020 20:49:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[No response on my mail of a week ago, so I try again; the page
text is unchanged since the draft sent out on 31 March]

Hello Sargun et al.

I've taken a shot at writing a manual page for pidfd_getfd().
I would be happy to receive comments, suggestions for
improvements, etc. The text is as follows (the groff source 
is at the foot of this mail):

NAME
       pidfd_getfd  -  obtain  a  duplicate  of  another  process's  file
       descriptor

SYNOPSIS
       int pidfd_getfd(int pidfd, int targetfd, unsigned int flags);

DESCRIPTION
       The pidfd_getfd() system call allocates a new file  descriptor  in
       the  calling  process.  This new file descriptor is a duplicate of
       an existing file descriptor, targetfd, in the process referred  to
       by the PID file descriptor pidfd.

       The  duplicate  file  descriptor  refers  to  the  same  open file
       description (see open(2)) as the original file descriptor  in  the
       process referred to by pidfd.  The two file descriptors thus share
       file status flags and file offset.  Furthermore, operations on the
       underlying  file  object  (for  example, assigning an address to a
       socket object using bind(2)) can be equally be performed  via  the
       duplicate file descriptor.

       The  close-on-exec  flag  (FD_CLOEXEC; see fcntl(2)) is set on the
       file descriptor returned by pidfd_getfd().

       The flags argument is reserved for future use.  Currently, it must
       be specified as 0.

       Permission  to duplicate another process's file descriptor is gov‐
       erned by a ptrace access mode  PTRACE_MODE_ATTACH_REALCREDS  check
       (see ptrace(2)).

RETURN VALUE
       On  success,  pidfd_getfd() returns a nonnegative file descriptor.
       On error, -1 is returned and errno is set to indicate the cause of
       the error.

ERRORS
       EBADF  pidfd is not a valid PID file descriptor.

       EBADF  targetfd  is  not  an  open  file descriptor in the process
              referred to by pidfd.

       EINVAL flags is not 0.

       EMFILE The per-process limit on the number of open  file  descrip‐
              tors has been reached (see the description of RLIMIT_NOFILE
              in getrlimit(2)).

       ENFILE The system-wide limit on the total number of open files has
              been reached.

       ESRCH  The  process  referred to by pidfd does not exist (i.e., it
              has terminated and been waited on).

VERSIONS
       pidfd_getfd() first appeared in Linux 5.6.

CONFORMING TO
       pidfd_getfd() is Linux specific.

NOTES
       Currently, there is no glibc wrapper for this system call; call it
       using syscall(2).

       For a description of PID file descriptors, see pidfd_open(2).

SEE ALSO
       clone3(2), kcmp(2), pidfd_open(2)

Cheers,

Michael

.\" Copyright (c) 2020 by Michael Kerrisk <mtk.manpages@gmail.com>
.\"
.\" %%%LICENSE_START(VERBATIM)
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.\" %%%LICENSE_END
.\"
.TH PIDFD_GETFD 2 2020-03-31 "Linux" "Linux Programmer's Manual"
.SH NAME
pidfd_getfd \- obtain a duplicate of another process's file descriptor
.SH SYNOPSIS
.nf
.BI "int pidfd_getfd(int " pidfd ", int " targetfd ", unsigned int " flags );
.fi
.SH DESCRIPTION
The
.BR pidfd_getfd ()
system call allocates a new file descriptor in the calling process.
This new file descriptor is a duplicate of an existing file descriptor,
.IR targetfd ,
in the process referred to by the PID file descriptor
.IR pidfd .
.PP
The duplicate file descriptor refers to the same open file description (see
.BR open (2))
as the original file descriptor in the process referred to by
.IR pidfd .
The two file descriptors thus share file status flags and file offset.
Furthermore, operations on the underlying file object
(for example, assigning an address to a socket object using
.BR bind (2))
can be equally be performed via the duplicate file descriptor.
.PP
The close-on-exec flag
.RB ( FD_CLOEXEC ;
see
.BR fcntl (2))
is set on the file descriptor returned by
.BR pidfd_getfd ().
.PP
The
.I flags
argument is reserved for future use.
Currently, it must be specified as 0.
.PP
Permission to duplicate another process's file descriptor
is governed by a ptrace access mode
.B PTRACE_MODE_ATTACH_REALCREDS
check (see
.BR ptrace (2)).
.SH RETURN VALUE
On success,
.BR pidfd_getfd ()
returns a nonnegative file descriptor.
On error, \-1 is returned and
.I errno
is set to indicate the cause of the error.
.SH ERRORS
.TP
.B EBADF
.I pidfd
is not a valid PID file descriptor.
.TP
.B EBADF
.I targetfd
is not an open file descriptor in the process referred to by
.IR pidfd .
.BR 
.TP
.B EINVAL
.I flags
is not 0.
.TP
.B EMFILE
The per-process limit on the number of open file descriptors has been reached
(see the description of
.BR RLIMIT_NOFILE
in
.BR getrlimit (2)).
.TP
.B ENFILE
The system-wide limit on the total number of open files has been reached.
.TP
.B ESRCH
The process referred to by
.I pidfd
does not exist
(i.e., it has terminated and been waited on).
.SH VERSIONS
.BR pidfd_getfd ()
first appeared in Linux 5.6.
.\" commit 8649c322f75c96e7ced2fec201e123b2b073bf09
.SH CONFORMING TO
.BR pidfd_getfd ()
is Linux specific.
.SH NOTES
Currently, there is no glibc wrapper for this system call; call it using
.BR syscall (2).
.PP
For a description of PID file descriptors, see
.BR pidfd_open (2).
.SH SEE ALSO
.BR clone3 (2),
.BR kcmp (2),
.BR pidfd_open (2)

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

