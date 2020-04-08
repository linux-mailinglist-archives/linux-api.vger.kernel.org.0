Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE41A1CC7
	for <lists+linux-api@lfdr.de>; Wed,  8 Apr 2020 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgDHHpF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Apr 2020 03:45:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52813 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgDHHpE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Apr 2020 03:45:04 -0400
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jM5OO-0007fN-PD; Wed, 08 Apr 2020 07:45:00 +0000
Date:   Wed, 8 Apr 2020 09:44:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
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
Subject: Re: [RESEND] RFC: pidfd_getfd(2) manual page
Message-ID: <20200408074459.q3njmvizjge7timg@wittgenstein>
References: <d6be97d1-38a5-bf43-7c80-7c952a5a44a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6be97d1-38a5-bf43-7c80-7c952a5a44a3@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 07, 2020 at 08:49:35PM +0200, Michael Kerrisk (man-pages) wrote:
> [No response on my mail of a week ago, so I try again; the page
> text is unchanged since the draft sent out on 31 March]

Sorry for the delay.

> 
> Hello Sargun et al.
> 
> I've taken a shot at writing a manual page for pidfd_getfd().
> I would be happy to receive comments, suggestions for
> improvements, etc. The text is as follows (the groff source 
> is at the foot of this mail):

Thanks for that! Really appreciated. Just a few nits below.

> 
> NAME
>        pidfd_getfd  -  obtain  a  duplicate  of  another  process's  file
>        descriptor
> 
> SYNOPSIS
>        int pidfd_getfd(int pidfd, int targetfd, unsigned int flags);
> 
> DESCRIPTION
>        The pidfd_getfd() system call allocates a new file  descriptor  in
>        the  calling  process.  This new file descriptor is a duplicate of
>        an existing file descriptor, targetfd, in the process referred  to
>        by the PID file descriptor pidfd.
> 
>        The  duplicate  file  descriptor  refers  to  the  same  open file
>        description (see open(2)) as the original file descriptor  in  the
>        process referred to by pidfd.  The two file descriptors thus share
>        file status flags and file offset.  Furthermore, operations on the
>        underlying  file  object  (for  example, assigning an address to a
>        socket object using bind(2)) can be equally be performed  via  the

s/can be equally be performed/can be equally performed
?

>        duplicate file descriptor.
> 
>        The  close-on-exec  flag  (FD_CLOEXEC; see fcntl(2)) is set on the
>        file descriptor returned by pidfd_getfd().
> 
>        The flags argument is reserved for future use.  Currently, it must
>        be specified as 0.
> 
>        Permission  to duplicate another process's file descriptor is gov‐
>        erned by a ptrace access mode  PTRACE_MODE_ATTACH_REALCREDS  check
>        (see ptrace(2)).
> 
> RETURN VALUE
>        On  success,  pidfd_getfd() returns a nonnegative file descriptor.

Imho, this makes it sound like there are negative file descriptor
numbers. But as a non-native speaker that might just be a subtle
misreading on my part. Maybe just like open() just mention:
"On success, pidfd_getfd() returns a file descriptor."

>        On error, -1 is returned and errno is set to indicate the cause of
>        the error.
> 
> ERRORS
>        EBADF  pidfd is not a valid PID file descriptor.
> 
>        EBADF  targetfd  is  not  an  open  file descriptor in the process
>               referred to by pidfd.
> 
>        EINVAL flags is not 0.
> 
>        EMFILE The per-process limit on the number of open  file  descrip‐
>               tors has been reached (see the description of RLIMIT_NOFILE
>               in getrlimit(2)).
> 
>        ENFILE The system-wide limit on the total number of open files has
>               been reached.
> 
>        ESRCH  The  process  referred to by pidfd does not exist (i.e., it
>               has terminated and been waited on).

EPERM	The calling process did not have PTRACE_MODE_ATTACH_REALCREDS
	permissions (see ptrace(2)) over the process referred to by
	pidfd.

Technically, there should also be a disclaimer that other errno values
are possible because of LSM denials, e.g. selinux could return EACCES or
any other errno code in their file_receive() hook. But I'm not whether we
generally do this. In any case, I would find it useful as a developer.

(Is there actually a place where all LSMs are forced to record their
errno returns for their security hooks for each syscall they hook into and
that's visible to userspace? Because that'd be really useful...)

Christian
