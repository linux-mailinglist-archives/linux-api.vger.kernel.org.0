Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88C30B70F
	for <lists+linux-api@lfdr.de>; Tue,  2 Feb 2021 06:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBBFct (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Feb 2021 00:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBBFcp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Feb 2021 00:32:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89AC0613D6
        for <linux-api@vger.kernel.org>; Mon,  1 Feb 2021 21:30:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l197so13727316ybf.17
        for <linux-api@vger.kernel.org>; Mon, 01 Feb 2021 21:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=32gsMLlwt+T81buP80NhpW9x2AUNBey7vO33EXErlNg=;
        b=cBTQRaswM5rzUMedK+N1r2vvPDqRAUvlRQxA0CLSo7/KpMEW3W8gr8ip9bAm/eZCk6
         qoaRrHXuO4dFAFI5qvjVVp/3GdhPfvAK/h0s3gvCNNv7Oxo7b+7tJK7ovMX0UDLq2UO/
         9JWsLWM8cN35hsznX9JA+dIHy3WcUPduUoDr72J1SpM5YQEHEzmU6mIs1sryNzt7ivGH
         3F4L1cA/GoxPmsrp6s5Kw1kKzMWUc/q/PFJKnDLXbRPFyZiTMU9kBpOuy0Uau/1vttrV
         5xB3Qyxa+3xFtPTWf6Ge43Pt3gQo0X1VjhEjNZ3v6PJOtHXHtbAvnw7N+kojdD1V3xTG
         DgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=32gsMLlwt+T81buP80NhpW9x2AUNBey7vO33EXErlNg=;
        b=ghbhOoEaW/7MYGTxQJPkrL6fHFRk+Ddgm7DwuT8NMefdYkyvjOatdkkWNjSly+W+N/
         GzofPE1BS+xTr0ml38cxrOjQoiO9zh8EbRfRByZRaoue50r9YO7eYeScUFR/V9UlGlem
         72ZLZlNMYBjBCDm0xqENdvaB921vTUf5xjk/LBdeeh7uYk2yTvfNssNxf4Y2C8b6z347
         S2JViFWArLqcr7s+y44AEoVLYlk1qMq7/SKAtMG25qGAKkEcGfgPXhBRq7NOrLA06/TX
         wMCnjnMQ/z0ds8Rr2QvxPDohWXNy8t/XnN9fFy01pnPG6o/5Y/Wq0fYNbMV3NK6Z+v8I
         8NRA==
X-Gm-Message-State: AOAM532neb5UEbdH/2eBhTE1fsx8N8MDEh0SO9bLCN6wbUHd5DXEwElg
        PY9KhtwJNYFsYmKOOb5lwaHhKpOLTxQ=
X-Google-Smtp-Source: ABdhPJxEwNFqA8Xbbl2qhD3jUdIx+5N6rPSvCPwndcIBHQZINieSLzJ4wp+Cq/QSsWaYqsPSfIx+ZRPvSIk=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:f693:9fff:fef4:2055])
 (user=surenb job=sendgmr) by 2002:a25:9b88:: with SMTP id v8mr30455262ybo.338.1612243850942;
 Mon, 01 Feb 2021 21:30:50 -0800 (PST)
Date:   Mon,  1 Feb 2021 21:30:46 -0800
Message-Id: <20210202053046.1653012-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 1/1] process_madvise.2: Add process_madvise man page
From:   Suren Baghdasaryan <surenb@google.com>
To:     linux-man@vger.kernel.org
Cc:     mtk.manpages@gmail.com, akpm@linux-foundation.org,
        jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Initial version of process_madvise(2) manual page. Initial text was
extracted from [1], amended after fix [2] and more details added using
man pages of madvise(2) and process_vm_read(2) as examples. It also
includes the changes to required permission proposed in [3].

[1] https://lore.kernel.org/patchwork/patch/1297933/
[2] https://lkml.org/lkml/2020/12/8/1282
[3] https://patchwork.kernel.org/project/selinux/patch/20210111170622.2613577-1-surenb@google.com/#23888311

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Michal Hocko <mhocko@suse.com>
---
changes in v2:
- Changed description of MADV_COLD per Michal Hocko's suggestion
- Applied fixes suggested by Michael Kerrisk
changes in v3:
- Added Michal's Reviewed-by
- Applied additional fixes suggested by Michael Kerrisk

NAME
    process_madvise - give advice about use of memory to a process

SYNOPSIS
    #include <sys/uio.h>

    ssize_t process_madvise(int pidfd,
                           const struct iovec *iovec,
                           unsigned long vlen,
                           int advice,
                           unsigned int flags);

DESCRIPTION
    The process_madvise() system call is used to give advice or directions
    to the kernel about the address ranges of another process or the calling
    process. It provides the advice to the address ranges described by iovec
    and vlen. The goal of such advice is to improve system or application
    performance.

    The pidfd argument is a PID file descriptor (see pidfd_open(2)) that
    specifies the process to which the advice is to be applied.

    The pointer iovec points to an array of iovec structures, defined in
    <sys/uio.h> as:

    struct iovec {
        void  *iov_base;    /* Starting address */
        size_t iov_len;     /* Number of bytes to transfer */
    };

    The iovec structure describes address ranges beginning at iov_base address
    and with the size of iov_len bytes.

    The vlen represents the number of elements in the iovec structure.

    The advice argument is one of the values listed below.

  Linux-specific advice values
    The following Linux-specific advice values have no counterparts in the
    POSIX-specified posix_madvise(3), and may or may not have counterparts
    in the madvise(2) interface available on other implementations.

    MADV_COLD (since Linux 5.4.1)
        Deactive a given range of pages which will make them a more probable
        reclaim target should there be a memory pressure. This is a
        nondestructive operation. The advice might be ignored for some pages
        in the range when it is not applicable.

    MADV_PAGEOUT (since Linux 5.4.1)
        Reclaim a given range of pages. This is done to free up memory occupied
        by these pages. If a page is anonymous it will be swapped out. If a
        page is file-backed and dirty it will be written back to the backing
        storage. The advice might be ignored for some pages in the range when
        it is not applicable.

    The flags argument is reserved for future use; currently, this argument
    must be specified as 0.

    The value specified in the vlen argument must be less than or equal to
    IOV_MAX (defined in <limits.h> or accessible via the call
    sysconf(_SC_IOV_MAX)).

    The vlen and iovec arguments are checked before applying any hints. If
    the vlen is too big, or iovec is invalid, an error will be returned
    immediately and no advice will be applied.

    The hint might be applied to a part of iovec if one of its elements points
    to an invalid memory region in the remote process. No further elements will
    be processed beyond that point.

    Permission to provide a hint to another process is governed by a ptrace
    access mode PTRACE_MODE_READ_REALCREDS check (see ptrace(2)); in addition,
    the caller must have the CAP_SYS_ADMIN capability due to performance
    implications of applying the hint.

RETURN VALUE
    On success, process_madvise() returns the number of bytes advised. This
    return value may be less than the total number of requested bytes, if an
    error occurred after some iovec elements were already processed. The caller
    should check the return value to determine whether a partial advice
    occurred.

    On error, -1 is returned and errno is set to indicate the error.

ERRORS
    EBADF pidfd is not a valid PID file descriptor.
    EFAULT The memory described by iovec is outside the accessible address
           space of the process referred to by pidfd.
    EINVAL flags is not 0.
    EINVAL The sum of the iov_len values of iovec overflows a ssize_t value.
    EINVAL vlen is too large.
    ENOMEM Could not allocate memory for internal copies of the iovec
           structures.
    EPERM The caller does not have permission to access the address space of
          the process pidfd.
    ESRCH The target process does not exist (i.e., it has terminated and been
          waited on).

VERSIONS
    This system call first appeared in Linux 5.10. Support for this system
    call is optional, depending on the setting of the CONFIG_ADVISE_SYSCALLS
    configuration option.

SEE ALSO
    madvise(2), pidfd_open(2), process_vm_readv(2), process_vm_write(2)

 man2/process_madvise.2 | 223 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)
 create mode 100644 man2/process_madvise.2

diff --git a/man2/process_madvise.2 b/man2/process_madvise.2
new file mode 100644
index 000000000..24ff7cb3d
--- /dev/null
+++ b/man2/process_madvise.2
@@ -0,0 +1,223 @@
+.\" Copyright (C) 2021 Suren Baghdasaryan <surenb@google.com>
+.\" and Copyright (C) 2021 Minchan Kim <minchan@kernel.org>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.\"
+.\" Commit ecb8ac8b1f146915aa6b96449b66dd48984caacc
+.\"
+.TH PROCESS_MADVISE 2 2021-01-12 "Linux" "Linux Programmer's Manual"
+.SH NAME
+process_madvise \- give advice about use of memory to a process
+.SH SYNOPSIS
+.nf
+.B #include <sys/uio.h>
+.PP
+.BI "ssize_t process_madvise(int " pidfd ,
+.BI "                       const struct iovec *" iovec ,
+.BI "                       unsigned long " vlen ,
+.BI "                       int " advice ,
+.BI "                       unsigned int " flags ");"
+.fi
+.SH DESCRIPTION
+The
+.BR process_madvise()
+system call is used to give advice or directions to the kernel about the
+address ranges of another process or the calling process.
+It provides the advice to the address ranges described by
+.I iovec
+and
+.IR vlen .
+The goal of such advice is to improve system or application performance.
+.PP
+The
+.I pidfd
+argument is a PID file descriptor (see
+.BR pidfd_open (2))
+that specifies the process to which the advice is to be applied.
+.PP
+The pointer
+.I iovec
+points to an array of
+.I iovec
+structures, defined in
+.IR <sys/uio.h>
+as:
+.PP
+.in +4n
+.EX
+struct iovec {
+    void  *iov_base;    /* Starting address */
+    size_t iov_len;     /* Number of bytes to transfer */
+};
+.EE
+.in
+.PP
+The
+.I iovec
+structure describes address ranges beginning at
+.I iov_base
+address and with the size of
+.I iov_len
+bytes.
+.PP
+The
+.I vlen
+represents the number of elements in the
+.I iovec
+structure.
+.PP
+The
+.I advice
+argument is one of the values listed below.
+.\"
+.\" ======================================================================
+.\"
+.SS Linux-specific advice values
+The following Linux-specific
+.I advice
+values have no counterparts in the POSIX-specified
+.BR posix_madvise (3),
+and may or may not have counterparts in the
+.BR madvise (2)
+interface available on other implementations.
+.TP
+.BR MADV_COLD " (since Linux 5.4.1)"
+.\" commit 9c276cc65a58faf98be8e56962745ec99ab87636
+Deactive a given range of pages which will make them a more probable
+reclaim target should there be a memory pressure.
+This is a nondestructive operation.
+The advice might be ignored for some pages in the range when it is not
+applicable.
+.TP
+.BR MADV_PAGEOUT " (since Linux 5.4.1)"
+.\" commit 1a4e58cce84ee88129d5d49c064bd2852b481357
+Reclaim a given range of pages.
+This is done to free up memory occupied by these pages.
+If a page is anonymous it will be swapped out.
+If a page is file-backed and dirty it will be written back to the backing
+storage.
+The advice might be ignored for some pages in the range when it is not
+applicable.
+.PP
+The
+.I flags
+argument is reserved for future use; currently, this argument must be
+specified as 0.
+.PP
+The value specified in the
+.I vlen
+argument must be less than or equal to
+.BR IOV_MAX
+(defined in
+.I <limits.h>
+or accessible via the call
+.IR sysconf(_SC_IOV_MAX) ).
+.PP
+The
+.I vlen
+and
+.I iovec
+arguments are checked before applying any hints.
+If the
+.I vlen
+is too big, or
+.I iovec
+is invalid,
+an error will be returned immediately and no advice will be applied.
+.PP
+The hint might be applied to a part of
+.I iovec
+if one of its elements points to an invalid memory region in the
+remote process.
+No further elements will be processed beyond that point.
+.PP
+Permission to provide a hint to another process is governed by a
+ptrace access mode
+.B PTRACE_MODE_READ_REALCREDS
+check (see
+.BR ptrace (2));
+in addition, the caller must have the
+.B CAP_SYS_ADMIN
+capability due to performance implications of applying the hint.
+.SH RETURN VALUE
+On success, process_madvise() returns the number of bytes advised.
+This return value may be less than the total number of requested bytes,
+if an error occurred after some iovec elements were already processed.
+The caller should check the return value to determine whether a partial
+advice occurred.
+.PP
+On error, \-1 is returned and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EBADF
+.I pidfd
+is not a valid PID file descriptor.
+.TP
+.B EFAULT
+The memory described by
+.I iovec
+is outside the accessible address space of the process referred to by
+.IR pidfd .
+.TP
+.B EINVAL
+.I flags
+is not 0.
+.TP
+.B EINVAL
+The sum of the
+.I iov_len
+values of
+.I iovec
+overflows a
+.I ssize_t
+value.
+.TP
+.B EINVAL
+.I vlen
+is too large.
+.TP
+.B ENOMEM
+Could not allocate memory for internal copies of the
+.I iovec
+structures.
+.TP
+.B EPERM
+The caller does not have permission to access the address space of the process
+.IR pidfd .
+.TP
+.B ESRCH
+The target process does not exist (i.e., it has terminated and been waited on).
+.SH VERSIONS
+This system call first appeared in Linux 5.10.
+.\" commit ecb8ac8b1f146915aa6b96449b66dd48984caacc
+Support for this system call is optional,
+depending on the setting of the
+.B CONFIG_ADVISE_SYSCALLS
+configuration option.
+.SH SEE ALSO
+.BR madvise (2),
+.BR pidfd_open(2),
+.BR process_vm_readv (2),
+.BR process_vm_write (2)
-- 
2.30.0.365.g02bc693789-goog

