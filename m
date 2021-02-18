Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04531EF9E
	for <lists+linux-api@lfdr.de>; Thu, 18 Feb 2021 20:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhBRTUB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Feb 2021 14:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhBRSVZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Feb 2021 13:21:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19723C061756
        for <linux-api@vger.kernel.org>; Thu, 18 Feb 2021 10:20:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u14so4037497wri.3
        for <linux-api@vger.kernel.org>; Thu, 18 Feb 2021 10:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A6JvujsO2Df0YCGBHxHBzGTn/K+aJ9sF4URnvS2DhpE=;
        b=PdfBdSipNfU5cOPT5ougmEeo1+CgHeQo5k4LU11qUA75lMd1w6OVTj8jJ35bSIgRjS
         EMd5rFVvXZiggdJW8H+Wl8zQtqf+9sRr+g1Vf8b7CpIMTW8d1cehZKK4q8vcDen9wlEI
         bqdwgI3tBZ9gFMBkPkLMtJ5nGzKss0j+GGyaOuXBZiaoD3iLWdFC28cHR/0gamPSICv/
         d3AYYIWpahamNxP+PDQVxHmZRkbDK2Qu3eMPrmHz4qNPQ6Re0FzknP3g8IHuxNkUbgF8
         uA+tgiA8NeNwQVMQ98t6CBAuh2ri7ALC9Un3EZ609BRhXPPN2b45p48itrnlUsRt1z41
         AG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A6JvujsO2Df0YCGBHxHBzGTn/K+aJ9sF4URnvS2DhpE=;
        b=NkwBinczsgFHWXKpwsk1NrCJaVwWPHa6z4U6nzzOux+Zaq4v7GpbTYC+zs59GnjmAm
         bt8WXgr3m3W92Sz2IEZk/oiJp29X8bsW/6r3aTmvpjQHEnPyAytBwQwmIAchOiY3ENnW
         k55GaC29HaLVFLQjiE4C6/uOhDv84MpIX8h5a6LsNKXTWqkMoRswQCEL3g96T1lWRoN6
         1CBAlmAfl1CERX9Sf8REcN4u45jQhRMlCAHLtaDu25+PAQ8qsKi02xUqwwH/rzTxYeYc
         m6FyMXRJZc3Sq/yZOQe+LzYcM3J/DlnZJEVKjt8j0wmSIqCRY4YlVsye5YGMMw7ximaa
         SLNA==
X-Gm-Message-State: AOAM530Fsx4/Bw/L6tpv7SjtLVinMF/AxQOcqjTuF8WsChdojK74uM3y
        Pzd3uyP8Gaq+lZt+FmNw3dXFANVWznW+JK/ittHm4Q==
X-Google-Smtp-Source: ABdhPJwUro94gO/qGz4eRbhu+BIbq6W4NJ6UwoC0fGKFP2tvyoO+3SM/RLEPxTtE0knIsRq3pcxCN07LlInrrW6ZteU=
X-Received: by 2002:a5d:610a:: with SMTP id v10mr5622545wrt.334.1613672442415;
 Thu, 18 Feb 2021 10:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20210202053046.1653012-1-surenb@google.com> <079db245-a08c-0dbd-01d4-8065f533652e@gmail.com>
 <CAJuCfpGotx_04Stn5Nw6Au+TVG9LuAJ=CB_s7uxjMLOLerw-GA@mail.gmail.com>
 <2d303517-cdcd-9ec8-e57d-3d065edb573c@gmail.com> <CAJuCfpFC0B=jXFEuPYYBZAjgx1B6S8vG-i7_0iBc_RHeWynyzw@mail.gmail.com>
 <7fb20d93-92d0-14b3-f7f9-8b9af4ebb584@gmail.com>
In-Reply-To: <7fb20d93-92d0-14b3-f7f9-8b9af4ebb584@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 18 Feb 2021 10:20:30 -0800
Message-ID: <CAJuCfpGpeccwOueJFdZo-XUdr856Gk1sMUFvZN003HEvNgTTQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] process_madvise.2: Add process_madvise man page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 17, 2021 at 11:55 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Suren,
>
> >> Thanks. I added a few words to clarify this.>
> > Any link where I can see the final version?
>
> Sure:
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/pro=
cess_madvise.2
>
> Also rendered below.

Looks great. Thanks for improving it, Michael!

>
> Thanks,
>
> Michael
>
> NAME
>        process_madvise - give advice about use of memory to a process
>
> SYNOPSIS
>        #include <sys/uio.h>
>
>        ssize_t process_madvise(int pidfd, const struct iovec *iovec,
>                                size_t vlen, int advice,
>                                unsigned int flags);
>
>        Note: There is no glibc wrapper for this system call; see NOTES.
>
> DESCRIPTION
>        The process_madvise() system call is used to give advice or direc=
=E2=80=90
>        tions to the kernel about the address ranges of another process or
>        of  the  calling  process.  It provides the advice for the address
>        ranges described by iovec and vlen.  The goal of such advice is to
>        improve system or application performance.
>
>        The  pidfd  argument  is a PID file descriptor (see pidfd_open(2))
>        that specifies the process to which the advice is to be applied.
>
>        The pointer iovec points to an array of iovec structures,  defined
>        in <sys/uio.h> as:
>
>            struct iovec {
>                void  *iov_base;    /* Starting address */
>                size_t iov_len;     /* Length of region */
>            };
>
>        The iovec structure describes address ranges beginning at iov_base
>        address and with the size of iov_len bytes.
>
>        The vlen specifies the number of elements in the iovec  structure.
>        This value must be less than or equal to IOV_MAX (defined in <lim=
=E2=80=90
>        its.h> or accessible via the call sysconf(_SC_IOV_MAX)).
>
>        The advice argument is one of the following values:
>
>        MADV_COLD
>               See madvise(2).
>
>        MADV_PAGEOUT
>               See madvise(2).
>
>        The flags argument is reserved for future use; currently, this ar=
=E2=80=90
>        gument must be specified as 0.
>
>        The  vlen  and iovec arguments are checked before applying any ad=
=E2=80=90
>        vice.  If vlen is too big, or iovec is invalid, then an error will
>        be returned immediately and no advice will be applied.
>
>        The  advice might be applied to only a part of iovec if one of its
>        elements points to an invalid memory region in the remote process.
>        No further elements will be processed beyond that point.  (See the
>        discussion regarding partial advice in RETURN VALUE.)
>
>        Permission to apply advice to another process  is  governed  by  a
>        ptrace   access   mode   PTRACE_MODE_READ_REALCREDS   check   (see
>        ptrace(2)); in addition, because of the  performance  implications
>        of applying the advice, the caller must have the CAP_SYS_ADMIN ca=
=E2=80=90
>        pability.
>
> RETURN VALUE
>        On success, process_madvise() returns the number of bytes advised.
>        This  return  value may be less than the total number of requested
>        bytes, if an error occurred after some iovec elements were already
>        processed.   The caller should check the return value to determine
>        whether a partial advice occurred.
>
>        On error, -1 is returned and errno is set to indicate the error.
>
> ERRORS
>        EBADF  pidfd is not a valid PID file descriptor.
>
>        EFAULT The memory described by iovec is outside the accessible ad=
=E2=80=90
>               dress space of the process referred to by pidfd.
>
>        EINVAL flags is not 0.
>
>        EINVAL The  sum of the iov_len values of iovec overflows a ssize_t
>               value.
>
>        EINVAL vlen is too large.
>
>        ENOMEM Could not allocate memory for internal copies of the  iovec
>               structures.
>
>        EPERM  The  caller  does not have permission to access the address
>               space of the process pidfd.
>
>        ESRCH  The target process does not exist (i.e., it has  terminated
>               and been waited on).
>
> VERSIONS
>        This  system  call first appeared in Linux 5.10.  Support for this
>        system call is optional, depending on  the  setting  of  the  CON=
=E2=80=90
>        FIG_ADVISE_SYSCALLS configuration option.
>
> CONFORMING TO
>        The process_madvise() system call is Linux-specific.
>
> NOTES
>        Glibc does not provide a wrapper for this system call; call it us=
=E2=80=90
>        ing syscall(2).
>
> SEE ALSO
>        madvise(2),          pidfd_open(2),           process_vm_readv(2),
>        process_vm_write(2)
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
