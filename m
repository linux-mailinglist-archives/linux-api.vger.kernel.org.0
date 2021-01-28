Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF72307624
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 13:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhA1M0x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 07:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhA1MZF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Jan 2021 07:25:05 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0778C061756;
        Thu, 28 Jan 2021 04:24:24 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id y72so1361400ooa.5;
        Thu, 28 Jan 2021 04:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=35ssVsxn75Z2ZkJPsI1hORY4xDk+LjLwz4eQia5uiHM=;
        b=LAZMIhF5ZAWEv3DaEm8JDIlxNOaBPeYsqDxhX3jTgbRppxh1m0JL4luK69+2TJEyen
         bc8LmYuy7IUbsya+yozYp8o/3Xsqa8WDZuUAUsBFi3+NCm95JNsDZkHAYi59WOCI06Qd
         wmFILxhpqYB2Dkxr7DSDpPiwHuVjUY1f6G+YZvbJ0jP0tbvZ0aDWTbQtIEdrDfODeyGk
         Yd96MsrHnvDLdhEhKivC5+D86JKxi+yPwZ2b1B8VWcHbBH3wEgWW2oXS9v2phbD5NRfh
         vNkwMHVY3GFcli0Q+R1ZZS7POA5DpGnHXduuBgX7R2nUMsieKDxnndjMKMmZQRnfYGY7
         LNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=35ssVsxn75Z2ZkJPsI1hORY4xDk+LjLwz4eQia5uiHM=;
        b=SbPRQ/aLw+tX8542JO+AlalE971XVST8E9pVl795XdkStcv5atGJkfGu5oTJrQzVRu
         JdAI7Zx6aVQTaWJEHQpviMThMLiVkly8ZBMPuz+dxPTEeWZ2tl6H5T0R6VLxAP8ptZCL
         x3exgKPc+nRTwKuRpd894KwaofTnwyVrDtzpGgf86S38yc9efRuV5kZDSOSQg+3g7dmR
         r1P7UTOgXE8rywhvzDN8VUQ34IpmhVRhvyYcSWzz3hrJxLX7/IiI6NPfg3HkraMAxHWT
         2n+tG6OsNI9L5630U1xWAwAJ414UYGjoqLB+RzQWhiy4kN3df43F/cj5XFCvhYwe4j7Y
         O2fQ==
X-Gm-Message-State: AOAM532I8MyktGOVMEzn/p1p9ylAi6Jj0dePoAF9aECvkTF1DJxxFiRl
        JFgPFEbnDL3ObAMdch3zE28fGegWuTliyo/ANH0=
X-Google-Smtp-Source: ABdhPJyJezCXdgF8esgy/OD9XuWc18dKvS72elOWT2P4HtELfDMnO3qyRrbvcxsh2zz6D1mVRt1DUMsQkD0mB2lm+iM=
X-Received: by 2002:a4a:d384:: with SMTP id i4mr11218423oos.14.1611836664065;
 Thu, 28 Jan 2021 04:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20210120202337.1481402-1-surenb@google.com>
In-Reply-To: <20210120202337.1481402-1-surenb@google.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 28 Jan 2021 13:24:12 +0100
Message-ID: <CAKgNAkgsQWL3QAyF6CQU=yifzA1tfp_E5kBBNKuAq_+sB4Amyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] process_madvise.2: Add process_madvise man page
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, jeffv@google.com,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, shakeelb@google.com,
        David Rientjes <rientjes@google.com>, edgararriaga@google.com,
        Tim Murray <timmurray@google.com>,
        Linux-MM <linux-mm@kvack.org>, selinux@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Suren,

Thank you for writing this page! Some comments below.

On Wed, 20 Jan 2021 at 21:36, Suren Baghdasaryan <surenb@google.com> wrote:
>
> Initial version of process_madvise(2) manual page. Initial text was
> extracted from [1], amended after fix [2] and more details added using
> man pages of madvise(2) and process_vm_read(2) as examples. It also
> includes the changes to required permission proposed in [3].
>
> [1] https://lore.kernel.org/patchwork/patch/1297933/
> [2] https://lkml.org/lkml/2020/12/8/1282
> [3] https://patchwork.kernel.org/project/selinux/patch/20210111170622.2613577-1-surenb@google.com/#23888311
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>
> Adding the plane text version for ease of review:

Thanks for adding the rendered version. I will make my comments
against the source, below.

> NAME
>     process_madvise - give advice about use of memory to a process
>
> SYNOPSIS
>     #include <sys/uio.h>
>
>     ssize_t process_madvise(int pidfd,
>                            const struct iovec *iovec,
>                            unsigned long vlen,
>                            int advice,
>                            unsigned int flags);
>
> DESCRIPTION
>     The process_madvise() system call is used to give advice or directions to
>     the kernel about the address ranges from external process as well as local
>     process. It provides the advice to address ranges of process described by
>     iovec and vlen. The goal of such advice is to improve system or application
>     performance.
>
>     The pidfd selects the process referred to by the PID file descriptor
>     specified in pidfd. (see pidofd_open(2) for further information).
>
>     The pointer iovec points to an array of iovec structures, defined in
>     <sys/uio.h> as:
>
>     struct iovec {
>         void  *iov_base;    /* Starting address */
>         size_t iov_len;     /* Number of bytes to transfer */
>     };
>
>     The iovec describes address ranges beginning at iov_base address and with
>     the size of iov_len bytes.
>
>     The vlen represents the number of elements in iovec.
>
>     The advice can be one of the values listed below.
>
>   Linux-specific advice values
>     The following Linux-specific advice values have no counterparts in the
>     POSIX-specified posix_madvise(3), and may or may not have counterparts in
>     the madvise() interface available on other implementations.
>
>     MADV_COLD (since Linux 5.4.1)
>         Deactivate a given range of pages by moving them from active to
>         inactive LRU list. This is done to accelerate the reclaim of these
>         pages. The advice might be ignored for some pages in the range when it
>         is not applicable.
>     MADV_PAGEOUT (since Linux 5.4.1)
>         Reclaim a given range of pages. This is done to free up memory occupied
>         by these pages. If a page is anonymous it will be swapped out. If a
>         page is file-backed and dirty it will be written back into the backing
>         storage. The advice might be ignored for some pages in the range when
>         it is not applicable.
>
>     The flags argument is reserved for future use; currently, this argument must
>     be specified as 0.
>
>     The value specified in the vlen argument must be less than or equal to
>     IOV_MAX (defined in <limits.h> or accessible via the call
>     sysconf(_SC_IOV_MAX)).
>
>     The vlen and iovec arguments are checked before applying any hints. If the
>     vlen is too big, or iovec is invalid, an error will be returned
>     immediately.
>
>     Hint might be applied to a part of iovec if one of its elements points to
>     an invalid memory region in the remote process. No further elements will be
>     processed beyond that point.
>
>     Permission to provide a hint to external process is governed by a ptrace
>     access mode PTRACE_MODE_READ_REALCREDS check; see ptrace(2) and
>     CAP_SYS_ADMIN capability that caller should have in order to affect
>     performance of an external process.
>
> RETURN VALUE
>     On success, process_madvise() returns the number of bytes advised. This
>     return value may be less than the total number of requested bytes, if an
>     error occurred. The caller should check return value to determine whether
>     a partial advice occurred.

So there are three return values possible,
> ERRORS
>     EFAULT The memory described by iovec is outside the accessible address
>            space of the process pid.

s/pid/
of the process referred to by
.IR pidfd .

>     EINVAL flags is not 0.
>     EINVAL The sum of the iov_len values of iovec overflows a ssize_t value.
>     EINVAL vlen is too large.
>     ENOMEM Could not allocate memory for internal copies of the iovec
>            structures.
>     EPERM The caller does not have permission to access the address space of
>           the process pidfd.
>     ESRCH No process with ID pidfd exists.
>
> VERSIONS
>     Since Linux 5.10, support for this system call is optional, depending on
>     the setting of the CONFIG_ADVISE_SYSCALLS configuration option.
>
> SEE ALSO
>     madvise(2), pidofd_open(2), process_vm_readv(2), process_vm_write(2)
>
>  man2/process_madvise.2 | 208 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 man2/process_madvise.2
>
> diff --git a/man2/process_madvise.2 b/man2/process_madvise.2
> new file mode 100644
> index 000000000..9bb5cb5ed
> --- /dev/null
> +++ b/man2/process_madvise.2
> @@ -0,0 +1,208 @@
> +.\" Copyright (C) 2021 Suren Baghdasaryan <surenb@google.com>
> +.\" and Copyright (C) 2021 Minchan Kim <minchan@kernel.org>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.\" Commit ecb8ac8b1f146915aa6b96449b66dd48984caacc
> +.\"
> +.TH PROCESS_MADVISE 2 2021-01-12 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +process_madvise \- give advice about use of memory to a process
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/uio.h>
> +.PP
> +.BI "ssize_t process_madvise(int " pidfd ,
> +.BI "                       const struct iovec *" iovec ,
> +.BI "                       unsigned long " vlen ,
> +.BI "                       int " advice ,
> +.BI "                       unsigned int " flags ");"
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR process_madvise()
> +system call is used to give advice or directions
> +to the kernel about the address ranges from external process as well as

s/from external/of other/

> +local process. It provides the advice to address ranges of process

s/local/of the calling/

Please start new sentence on new lines. (See the discussion of
semantic newlines in man-pages(7).)

> +described by
> +.I iovec
> +and
> +.I vlen\.
> +The goal of such advice is to improve system or application performance.
> +.PP
> +The
> +.I pidfd
> +selects the process referred to by the PID file descriptor
> +specified in pidfd. (see
> +.BR pidofd_open(2)
> +for further information).

Rewrite the previous as:

[[
The
.I pidfd
argument is a PID file descriptor (see
.BR pidofd_open (2))
that specifies the process to which the advice is to be applied.

> +.PP
> +The pointer
> +.I iovec
> +points to an array of iovec structures, defined in

"iovec" should be formatted as

.I iovec

> +.IR <sys/uio.h>
> +as:
> +.PP
> +.in +4n
> +.EX
> +struct iovec {
> +    void  *iov_base;    /* Starting address */
> +    size_t iov_len;     /* Number of bytes to transfer */
> +};
> +.EE
> +.in
> +.PP
> +The
> +.I iovec
> +describes address ranges beginning at

s/describes/structure describes/

> +.I iov_base
> +address and with the size of
> +.I iov_len
> +bytes.
> +.PP
> +The
> +.I vlen
> +represents the number of elements in
> +.I iovec\.

==>
the
.IR iovec
structure.
> +.PP
> +The
> +.I advice
> +can be one of the values listed below.

s/can be/argument is/

> +.\"
> +.\" ======================================================================
> +.\"
> +.SS Linux-specific advice values
> +The following Linux-specific
> +.I advice
> +values have no counterparts in the POSIX-specified
> +.BR posix_madvise (3),
> +and may or may not have counterparts in the
> +.BR madvise ()
> +interface available on other implementations.
> +.TP
> +.BR MADV_COLD " (since Linux 5.4.1)"
> +.\" commit 9c276cc65a58faf98be8e56962745ec99ab87636
> +Deactivate a given range of pages by moving them from active to inactive
> +LRU list. This is done to accelerate the reclaim of these pages. The advice

New sentences on new lines.

> +might be ignored for some pages in the range when it is not applicable.
> +.TP
> +.BR MADV_PAGEOUT " (since Linux 5.4.1)"
> +.\" commit 1a4e58cce84ee88129d5d49c064bd2852b481357
> +Reclaim a given range of pages. This is done to free up memory occupied by
> +these pages. If a page is anonymous it will be swapped out. If a page is
> +file-backed and dirty it will be written back into the backing storage.

s/into/to/

> +The advice might be ignored for some pages in the range when it is not
> +applicable.
> +.PP
> +The
> +.I flags
> +argument is reserved for future use; currently, this argument must be
> +specified as 0.
> +.PP
> +The value specified in the
> +.I vlen
> +argument must be less than or equal to
> +.BR IOV_MAX
> +(defined in
> +.I <limits.h>
> +or accessible via the call
> +.IR sysconf(_SC_IOV_MAX) ).
> +.PP
> +The
> +.I vlen
> +and
> +.I iovec
> +arguments are checked before applying any hints.
> +If the
> +.I vlen
> +is too big, or
> +.I iovec
> +is invalid, an error will be returned immediately.
> +.PP
> +Hint might be applied to a part of

s/Hint/The hint/

> +.I iovec
> +if one of its elements points to an invalid memory
> +region in the remote process. No further elements will be
> +processed beyond that point.
> +.PP
> +Permission to provide a hint to external process is governed by a
> +ptrace access mode
> +.B PTRACE_MODE_READ_REALCREDS
> +check; see
> +.BR ptrace (2)
> +and
> +.B CAP_SYS_ADMIN
> +capability that caller should have in order to affect performance
> +of an external process.

The preceding sentence is garbled. Missing words?

> +.SH RETURN VALUE
> +On success, process_madvise() returns the number of bytes advised.
> +This return value may be less than the total number of requested
> +bytes, if an error occurred. The caller should check return value
> +to determine whether a partial advice occurred.
> +.SH ERRORS
> +.TP
> +.B EFAULT
> +The memory described by
> +.I iovec
> +is outside the accessible address space of the process pid.

s/process pid./
the process referred to by
.IR pidfd .
/

> +.TP
> +.B EINVAL
> +.I flags
> +is not 0.
> +.TP
> +.B EINVAL
> +The sum of the
> +.I iov_len
> +values of
> +.I iovec
> +overflows a ssize_t value.

.I ssize_t

> +.TP
> +.B EINVAL
> +.I vlen
> +is too large.
> +.TP
> +.B ENOMEM
> +Could not allocate memory for internal copies of the
> +.I iovec
> +structures.
> +.TP
> +.B EPERM
> +The caller does not have permission to access the address space of the process
> +.I pidfd.

.IR pidfd .

> +.TP
> +.B ESRCH
> +No process with ID
> +.I pidfd
> +exists.

Should this maybe be:
[[
The target process does not exist (i.e., it has terminated and
been waited on).
]]

See pidfd_send_signal(2).

Also, is an EBADF error possible? Again, see pidfd_send_signal(2).

> +.SH VERSIONS
> +Since Linux 5.10,

Better: This system call first appeared in Linux 5.10.

> +.\" commit ecb8ac8b1f146915aa6b96449b66dd48984caacc
> +support for this system call is optional,

s/support/Support/

> +depending on the setting of the
> +.B CONFIG_ADVISE_SYSCALLS
> +configuration option.
> +.SH SEE ALSO
> +.BR madvise (2),
> +.BR pidofd_open(2),
> +.BR process_vm_readv (2),
> +.BR process_vm_write (2)

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
