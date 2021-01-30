Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E973D309880
	for <lists+linux-api@lfdr.de>; Sat, 30 Jan 2021 22:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhA3Vf2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 30 Jan 2021 16:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3Vf1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 30 Jan 2021 16:35:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CC5C061573;
        Sat, 30 Jan 2021 13:34:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e15so9928985wme.0;
        Sat, 30 Jan 2021 13:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SW/mV66sPAE2qiydRxCrklKjnZmi3JBx4cGjcnPkhe4=;
        b=olVQCvzmjA4m4XNKpRZwERWL0GnpHPphK5fqWxu3cvxv3wNetDUjQhAWItz0+VFBPU
         rR6J8AB++/FDiLvUk9qmFqWfX6c1YM9MKj7Pxp4jwPBCcniniGJo5BTSkc4ITzP06ak5
         hmkTCBHfQPaQRMbI9E4HAUqJZHdW5MeTocXysO1Qswj/7eRzK0KzGKDnd80Y46GnI0yu
         /ogJDL1phruZGmhYCUJioSQbCMVdVesoXv1e+ubffpN7U2g1pzNnCie8CtEKflhI5wJV
         FsKTIy/858f8gNuhrxm34VinFhinwQWq0i8hsGqgb86WHkDaNbiUBK/d4PKM12yJdJK1
         fNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SW/mV66sPAE2qiydRxCrklKjnZmi3JBx4cGjcnPkhe4=;
        b=Mjo5Awv8Cw/ceIY3mufxfF9jI/O2fB/NaC5U78DmXA6SPDVbpG102cFRVPolz9rJ2t
         HnpCWl47HkCvixpN1WIM59lAebwitt5+qoKM7GMLMMDsVorx5wA0ZumVvdUI3Kt5qCER
         ASone8j83miLAejHR8lrEd2I0S+swKEAfPe7V7cOLcYp4Xp2VKf3ZQdmPIm8I6nnbrYt
         czzPCSqT7NJFAcEYIXeSSgU53lGGfSdXF/KfSCzVdP33iMiqIcqfsXo6PM6aaqUbDxJj
         aPIkmv4xdUBfmL5iE5Ri5RDnDADy/c03jQWmGLWOzsCDIcgk6di0Qrvqv0eR2nQv+EFg
         jt+A==
X-Gm-Message-State: AOAM531rOmucbTn587V/+eOk0oIdRZgubDnW3fwPCR2PUK/ELdzjXfBu
        EMCt5zOLc//NDzMAlqdY8uM=
X-Google-Smtp-Source: ABdhPJz0AMrfUOpmQyar+wUfUiDUc8va0CIYbMmX6640GcB7hyr4bP6/+JU6cBtEx5EJ4J1xb7IwAg==
X-Received: by 2002:a7b:c3d6:: with SMTP id t22mr8945866wmj.1.1612042485574;
        Sat, 30 Jan 2021 13:34:45 -0800 (PST)
Received: from ?IPv6:2001:a61:24b6:8501:2c15:7f0b:b48e:84e3? ([2001:a61:24b6:8501:2c15:7f0b:b48e:84e3])
        by smtp.gmail.com with ESMTPSA id f18sm14957659wmj.28.2021.01.30.13.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 13:34:44 -0800 (PST)
Cc:     mtk.manpages@gmail.com, akpm@linux-foundation.org,
        jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] process_madvise.2: Add process_madvise man page
To:     Suren Baghdasaryan <surenb@google.com>, linux-man@vger.kernel.org
References: <20210129070340.566340-1-surenb@google.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <09477683-6752-ebac-2a04-53c53e079acd@gmail.com>
Date:   Sat, 30 Jan 2021 22:34:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210129070340.566340-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Suren,

Thank you for the revisions! Just a few more comments: all pretty small
stuff (many points that I overlooked the first time rround), since the
page already looks pretty good by now.

Again, thanks for the rendered version. As before, I've added my
comments to the page source.

On 1/29/21 8:03 AM, Suren Baghdasaryan wrote:
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
> ---
> changes in v2:
> - Changed description of MADV_COLD per Michal Hocko's suggestion
> - Appled fixes suggested by Michael Kerrisk
> 
> NAME
>     process_madvise - give advice about use of memory to a process

s/-/\-/

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
>     The process_madvise() system call is used to give advice or directions
>     to the kernel about the address ranges of other process as well as of
>     the calling process. It provides the advice to address ranges of process
>     described by iovec and vlen. The goal of such advice is to improve system
>     or application performance.
> 
>     The pidfd argument is a PID file descriptor (see pidofd_open(2)) that
>     specifies the process to which the advice is to be applied.
> 
>     The pointer iovec points to an array of iovec structures, defined in
>     <sys/uio.h> as:
> 
>     struct iovec {
>         void  *iov_base;    /* Starting address */
>         size_t iov_len;     /* Number of bytes to transfer */
>     };
> 
>     The iovec structure describes address ranges beginning at iov_base address
>     and with the size of iov_len bytes.
> 
>     The vlen represents the number of elements in the iovec structure.
> 
>     The advice argument is one of the values listed below.
> 
>   Linux-specific advice values
>     The following Linux-specific advice values have no counterparts in the
>     POSIX-specified posix_madvise(3), and may or may not have counterparts
>     in the madvise(2) interface available on other implementations.
> 
>     MADV_COLD (since Linux 5.4.1)
>         Deactive a given range of pages which will make them a more probable
>         reclaim target should there be a memory pressure. This is a non-
>         destructive operation. The advice might be ignored for some pages in
>         the range when it is not applicable.
> 
>     MADV_PAGEOUT (since Linux 5.4.1)
>         Reclaim a given range of pages. This is done to free up memory occupied
>         by these pages. If a page is anonymous it will be swapped out. If a
>         page is file-backed and dirty it will be written back to the backing
>         storage. The advice might be ignored for some pages in the range when
>         it is not applicable.
> 
>     The flags argument is reserved for future use; currently, this argument
>     must be specified as 0.
> 
>     The value specified in the vlen argument must be less than or equal to
>     IOV_MAX (defined in <limits.h> or accessible via the call
>     sysconf(_SC_IOV_MAX)).
> 
>     The vlen and iovec arguments are checked before applying any hints. If
>     the vlen is too big, or iovec is invalid, an error will be returned
>     immediately.
> 
>     The hint might be applied to a part of iovec if one of its elements points
>     to an invalid memory region in the remote process. No further elements will
>     be processed beyond that point.
> 
>     Permission to provide a hint to another process is governed by a ptrace
>     access mode PTRACE_MODE_READ_REALCREDS check (see ptrace(2)); in addition,
>     the caller must have the CAP_SYS_ADMIN capability due to performance
>     implications of applying the hint.
> 
> RETURN VALUE
>     On success, process_madvise() returns the number of bytes advised. This
>     return value may be less than the total number of requested bytes, if an
>     error occurred after some iovec elements were already processed. The caller
>     should check the return value to determine whether a partial advice
>     occurred.
> 
>     On error, -1 is returned and errno is set to indicate the error.
> 
> ERRORS
>     EFAULT The memory described by iovec is outside the accessible address
>            space of the process referred to by pidfd.
>     EINVAL flags is not 0.
>     EINVAL The sum of the iov_len values of iovec overflows a ssize_t value.
>     EINVAL vlen is too large.
>     ENOMEM Could not allocate memory for internal copies of the iovec
>            structures.
>     EPERM The caller does not have permission to access the address space of
>           the process pidfd.
>     ESRCH The target process does not exist (i.e., it has terminated and been
>           waited on).
>     EBADF pidfd is not a valid PID file descriptor.
> 
> VERSIONS
>     This system call first appeared in Linux 5.10, Support for this system
>     call is optional, depending on the setting of the CONFIG_ADVISE_SYSCALLS
>     configuration option.
> 
> SEE ALSO
>     madvise(2), pidofd_open(2), process_vm_readv(2), process_vm_write(2)
> 
>  man2/process_madvise.2 | 222 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 222 insertions(+)
>  create mode 100644 man2/process_madvise.2
> 
> diff --git a/man2/process_madvise.2 b/man2/process_madvise.2
> new file mode 100644
> index 000000000..07553289f
> --- /dev/null
> +++ b/man2/process_madvise.2
> @@ -0,0 +1,222 @@
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
> +system call is used to give advice or directions to the kernel about the
> +address ranges of other process as well as of the calling process.

s/other/another/
s/as well as of/or/

> +It provides the advice to address ranges of process described by

s/address ranges of process/the address ranges/

> +.I iovec
> +and
> +.IR vlen .
> +The goal of such advice is to improve system or application performance.
> +.PP
> +The
> +.I pidfd
> +argument is a PID file descriptor (see
> +.BR pidofd_open (2))

s/pidofd_open/pidfd_open/
(I overlooked this last time.)

> +that specifies the process to which the advice is to be applied.
> +.PP
> +The pointer
> +.I iovec
> +points to an array of
> +.I iovec
> +structures, defined in
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
> +structure describes address ranges beginning at
> +.I iov_base
> +address and with the size of
> +.I iov_len
> +bytes.
> +.PP
> +The
> +.I vlen
> +represents the number of elements in the
> +.I iovec
> +structure.
> +.PP
> +The
> +.I advice
> +argument is one of the values listed below.
> +.\"
> +.\" ======================================================================
> +.\"
> +.SS Linux-specific advice values
> +The following Linux-specific
> +.I advice
> +values have no counterparts in the POSIX-specified
> +.BR posix_madvise (3),
> +and may or may not have counterparts in the
> +.BR madvise (2)
> +interface available on other implementations.
> +.TP
> +.BR MADV_COLD " (since Linux 5.4.1)"
> +.\" commit 9c276cc65a58faf98be8e56962745ec99ab87636
> +Deactive a given range of pages which will make them a more probable
> +reclaim target should there be a memory pressure.
> +This is a non-destructive operation.

s/non-destructive/nondestructive/

> +The advice might be ignored for some pages in the range when it is not
> +applicable.
> +.TP
> +.BR MADV_PAGEOUT " (since Linux 5.4.1)"
> +.\" commit 1a4e58cce84ee88129d5d49c064bd2852b481357
> +Reclaim a given range of pages.
> +This is done to free up memory occupied by these pages.
> +If a page is anonymous it will be swapped out.
> +If a page is file-backed and dirty it will be written back to the backing
> +storage.
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

s/immediately/immediately and no advice will be applied/ ?

That's just a guess on my part. Is it correct?

> +.PP
> +The hint might be applied to a part of
> +.I iovec
> +if one of its elements points to an invalid memory region in the
> +remote process.
> +No further elements will be processed beyond that point.
> +.PP
> +Permission to provide a hint to another process is governed by a
> +ptrace access mode
> +.B PTRACE_MODE_READ_REALCREDS
> +check (see
> +.BR ptrace (2));
> +in addition, the caller must have the
> +.B CAP_SYS_ADMIN
> +capability due to performance implications of applying the hint.

Great addition. Thanks.

> +.SH RETURN VALUE
> +On success, process_madvise() returns the number of bytes advised.
> +This return value may be less than the total number of requested bytes,
> +if an error occurred after some iovec elements were already processed.
> +The caller should check the return value to determine whether a partial
> +advice occurred.
> +.PP
> +On error, \-1 is returned and
> +.I errno
> +is set to indicate the error.

Thanks. That's better!

> +.SH ERRORS

I should have mentioned this last time: could you place the errors 
in alphabetical order please.

> +.TP
> +.B EFAULT
> +The memory described by
> +.I iovec
> +is outside the accessible address space of the process referred to by
> +.IR pidfd .
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
> +overflows a
> +.I ssize_t
> +value.
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
> +.IR pidfd .
> +.TP
> +.B ESRCH
> +The target process does not exist (i.e., it has terminated and been waited on).
> +.TP
> +.B EBADF
> +.I pidfd
> +is not a valid PID file descriptor.
> +.SH VERSIONS
> +This system call first appeared in Linux 5.10,

s/,/./

> +.\" commit ecb8ac8b1f146915aa6b96449b66dd48984caacc
> +Support for this system call is optional,
> +depending on the setting of the
> +.B CONFIG_ADVISE_SYSCALLS
> +configuration option.
> +.SH SEE ALSO
> +.BR madvise (2),
> +.BR pidofd_open(2),

s/pidofd_open/pidfd_open/

> +.BR process_vm_readv (2),
> +.BR process_vm_write (2)

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
