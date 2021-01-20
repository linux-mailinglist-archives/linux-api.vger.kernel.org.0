Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC78E2FDAF7
	for <lists+linux-api@lfdr.de>; Wed, 20 Jan 2021 21:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbhATU1C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Jan 2021 15:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbhATUYo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Jan 2021 15:24:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE18C0613CF
        for <linux-api@vger.kernel.org>; Wed, 20 Jan 2021 12:24:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j12so5990471ybg.4
        for <linux-api@vger.kernel.org>; Wed, 20 Jan 2021 12:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=aXMIL5qsalVtc+s+kBFolu7vThL+LyG1arvRPXSP7r0=;
        b=ioUDFuwefqa9RVnEymE/YPxgB/WIkiuDcEqqGn02yX7EnnX2/QelUlthpRYq1CXQbu
         LSp4OZJFsH/tYQAXQi38QxIohN2LDXwNBM1RRFssDuRskT2YfhcZy/vlPbWfMNEsarE1
         Jp6RVSbN+tiiFS3fueneYQoOk+RchbXyMlm0cyY9Mjk3wT24BuGP073dOaISx8/+QoT4
         GtEmalX94PPnfftf0+GbraKEP9WHdvVxMmxFSK/xJYeXxUoGykHwGzR+y8Pfc6CmBymM
         teQ+1DGbmn0aWS26wZmX/WyKK95QjFahlQMV39F9s4tl5qpNwhupBCjqv+HDa2iV3zxa
         PPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=aXMIL5qsalVtc+s+kBFolu7vThL+LyG1arvRPXSP7r0=;
        b=YPrAk3QJLCIpF1kPpULhCr3Xy5ATpP6HpDJuDzm7qytJo+TA5Ho4ci6bwAdaisvZLK
         lHnw9T0iIqeCljo9aC4ZVtyxbjuZ403s0AKw1l24XPSW6IUnduWqfyokh+sPqepAZ+0b
         kNfUdQ+OPB8sYBctJIN2JmzDQFbLsLdr60vCbE4bNMcnJBLdKaTvNoxXmc36KABuHpuT
         uN4gjlDuH/3VoSwxOiTYpluCOfVbcBgzU3g91RaqPuoY8GRDGw7GCnOkxVxF6z9k/QxM
         bcBzW0ymLmwXBjAt8qVit4c3YbwX3xWhPVG1/PSbcbOCjGuqLh3zKTxsz11lWpT2NTBt
         TFPA==
X-Gm-Message-State: AOAM530Y3WhHcuYxY3uhmLeo0O7HXXsIpo+pL0fALLqPqu00h38OCp2s
        PL/Fb7glIKZY5eNPC+jg2EFF+R0bOF4=
X-Google-Smtp-Source: ABdhPJyEZ0oi4rNCubYOlOujp4VAKYBunoFZKIwkq6C78pmuAXpjocHhun54CgedRBYmMIk3NG2UOovXhjE=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:f693:9fff:fef4:2055])
 (user=surenb job=sendgmr) by 2002:a25:2349:: with SMTP id j70mr16364263ybj.362.1611174240945;
 Wed, 20 Jan 2021 12:24:00 -0800 (PST)
Date:   Wed, 20 Jan 2021 12:23:37 -0800
Message-Id: <20210120202337.1481402-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/1] process_madvise.2: Add process_madvise man page
From:   Suren Baghdasaryan <surenb@google.com>
To:     linux-man@vger.kernel.org
Cc:     akpm@linux-foundation.org, jannh@google.com, keescook@chromium.org,
        jeffv@google.com, minchan@kernel.org, mhocko@suse.com,
        shakeelb@google.com, rientjes@google.com, edgararriaga@google.com,
        timmurray@google.com, linux-mm@kvack.org, selinux@vger.kernel.org,
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
Signed-off-by: Minchan Kim <minchan@kernel.org>
---

Adding the plane text version for ease of review:

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
    The process_madvise() system call is used to give advice or directions to
    the kernel about the address ranges from external process as well as local
    process. It provides the advice to address ranges of process described by
    iovec and vlen. The goal of such advice is to improve system or application
    performance.

    The pidfd selects the process referred to by the PID file descriptor
    specified in pidfd. (see pidofd_open(2) for further information).

    The pointer iovec points to an array of iovec structures, defined in
    <sys/uio.h> as:

    struct iovec {
        void  *iov_base;    /* Starting address */
        size_t iov_len;     /* Number of bytes to transfer */
    };

    The iovec describes address ranges beginning at iov_base address and with
    the size of iov_len bytes.

    The vlen represents the number of elements in iovec.

    The advice can be one of the values listed below.

  Linux-specific advice values
    The following Linux-specific advice values have no counterparts in the
    POSIX-specified posix_madvise(3), and may or may not have counterparts in
    the madvise() interface available on other implementations.

    MADV_COLD (since Linux 5.4.1)
        Deactivate a given range of pages by moving them from active to
        inactive LRU list. This is done to accelerate the reclaim of these
        pages. The advice might be ignored for some pages in the range when it
        is not applicable.
    MADV_PAGEOUT (since Linux 5.4.1)
        Reclaim a given range of pages. This is done to free up memory occupied
        by these pages. If a page is anonymous it will be swapped out. If a
        page is file-backed and dirty it will be written back into the backing
        storage. The advice might be ignored for some pages in the range when
        it is not applicable.

    The flags argument is reserved for future use; currently, this argument must
    be specified as 0.

    The value specified in the vlen argument must be less than or equal to
    IOV_MAX (defined in <limits.h> or accessible via the call
    sysconf(_SC_IOV_MAX)).

    The vlen and iovec arguments are checked before applying any hints. If the
    vlen is too big, or iovec is invalid, an error will be returned
    immediately.

    Hint might be applied to a part of iovec if one of its elements points to
    an invalid memory region in the remote process. No further elements will be
    processed beyond that point.

    Permission to provide a hint to external process is governed by a ptrace
    access mode PTRACE_MODE_READ_REALCREDS check; see ptrace(2) and
    CAP_SYS_ADMIN capability that caller should have in order to affect
    performance of an external process.

RETURN VALUE
    On success, process_madvise() returns the number of bytes advised. This
    return value may be less than the total number of requested bytes, if an
    error occurred. The caller should check return value to determine whether
    a partial advice occurred.
ERRORS
    EFAULT The memory described by iovec is outside the accessible address
           space of the process pid.
    EINVAL flags is not 0.
    EINVAL The sum of the iov_len values of iovec overflows a ssize_t value.
    EINVAL vlen is too large.
    ENOMEM Could not allocate memory for internal copies of the iovec
           structures.
    EPERM The caller does not have permission to access the address space of
          the process pidfd.
    ESRCH No process with ID pidfd exists.

VERSIONS
    Since Linux 5.10, support for this system call is optional, depending on
    the setting of the CONFIG_ADVISE_SYSCALLS configuration option.

SEE ALSO
    madvise(2), pidofd_open(2), process_vm_readv(2), process_vm_write(2)

 man2/process_madvise.2 | 208 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 man2/process_madvise.2

diff --git a/man2/process_madvise.2 b/man2/process_madvise.2
new file mode 100644
index 000000000..9bb5cb5ed
--- /dev/null
+++ b/man2/process_madvise.2
@@ -0,0 +1,208 @@
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
+system call is used to give advice or directions
+to the kernel about the address ranges from external process as well as
+local process. It provides the advice to address ranges of process
+described by
+.I iovec
+and
+.I vlen\.
+The goal of such advice is to improve system or application performance.
+.PP
+The
+.I pidfd
+selects the process referred to by the PID file descriptor
+specified in pidfd. (see
+.BR pidofd_open(2)
+for further information).
+.PP
+The pointer
+.I iovec
+points to an array of iovec structures, defined in
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
+describes address ranges beginning at
+.I iov_base
+address and with the size of
+.I iov_len
+bytes.
+.PP
+The
+.I vlen
+represents the number of elements in
+.I iovec\.
+.PP
+The
+.I advice
+can be one of the values listed below.
+.\"
+.\" ======================================================================
+.\"
+.SS Linux-specific advice values
+The following Linux-specific
+.I advice
+values have no counterparts in the POSIX-specified
+.BR posix_madvise (3),
+and may or may not have counterparts in the
+.BR madvise ()
+interface available on other implementations.
+.TP
+.BR MADV_COLD " (since Linux 5.4.1)"
+.\" commit 9c276cc65a58faf98be8e56962745ec99ab87636
+Deactivate a given range of pages by moving them from active to inactive
+LRU list. This is done to accelerate the reclaim of these pages. The advice
+might be ignored for some pages in the range when it is not applicable.
+.TP
+.BR MADV_PAGEOUT " (since Linux 5.4.1)"
+.\" commit 1a4e58cce84ee88129d5d49c064bd2852b481357
+Reclaim a given range of pages. This is done to free up memory occupied by
+these pages. If a page is anonymous it will be swapped out. If a page is
+file-backed and dirty it will be written back into the backing storage.
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
+is invalid, an error will be returned immediately.
+.PP
+Hint might be applied to a part of
+.I iovec
+if one of its elements points to an invalid memory
+region in the remote process. No further elements will be
+processed beyond that point.
+.PP
+Permission to provide a hint to external process is governed by a
+ptrace access mode
+.B PTRACE_MODE_READ_REALCREDS
+check; see
+.BR ptrace (2)
+and
+.B CAP_SYS_ADMIN
+capability that caller should have in order to affect performance
+of an external process.
+.SH RETURN VALUE
+On success, process_madvise() returns the number of bytes advised.
+This return value may be less than the total number of requested
+bytes, if an error occurred. The caller should check return value
+to determine whether a partial advice occurred.
+.SH ERRORS
+.TP
+.B EFAULT
+The memory described by
+.I iovec
+is outside the accessible address space of the process pid.
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
+overflows a ssize_t value.
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
+.I pidfd.
+.TP
+.B ESRCH
+No process with ID
+.I pidfd
+exists.
+.SH VERSIONS
+Since Linux 5.10,
+.\" commit ecb8ac8b1f146915aa6b96449b66dd48984caacc
+support for this system call is optional,
+depending on the setting of the
+.B CONFIG_ADVISE_SYSCALLS
+configuration option.
+.SH SEE ALSO
+.BR madvise (2),
+.BR pidofd_open(2),
+.BR process_vm_readv (2),
+.BR process_vm_write (2)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

