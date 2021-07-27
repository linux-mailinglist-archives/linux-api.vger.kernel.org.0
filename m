Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1233D7535
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhG0Mlr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Jul 2021 08:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhG0Mlq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 27 Jul 2021 08:41:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F65561529;
        Tue, 27 Jul 2021 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627389707;
        bh=3J1zJxHBD3QbA2mfKS/yX525GubQQz70bCJr8IdanNI=;
        h=From:To:Cc:Subject:Date:From;
        b=fr9QIdmizLo58K9Q160qqazGihb2l5Y+cvp1vQGQz6IU56V8wgunrJ6iFRNlPMbaV
         8eN+iSVICIgtghf1h0MkpE2JgRe4VXs1ta8mtxIv9WwdZ0FLkMWGhL/Y+m54REIdln
         GLubQ1BqAKoDqMM3SLfsYoDtYtIp4Erefx+GRsFxf/9IZ1N3rNvfCS0Ut98y1A7RK6
         YydB1gZUN8ZW1a+XM7/uDvZbXViJluH6NaBN/LYOy61Aj8BdOhtg0lTRzzQoNXmUV3
         +VfMmIhxTBD1WPJuWyNLMofa7vveEaRyq3Q4bTPbWJtgrl4oLFSZEGdYoGPuhcdlBF
         CKhohG/rdOBNw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] man2: new page describing memfd_secret() system call
Date:   Tue, 27 Jul 2021 15:41:40 +0300
Message-Id: <20210727124140.1487079-1-rppt@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

Hi,

There were a lot of changes to memfd_secret implementation since the
previous posting of this man page, so its contents also changed
significantly and there is not much sense to call it v2.

 man2/memfd_secret.2 | 143 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 man2/memfd_secret.2

diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
new file mode 100644
index 000000000..e6eee7018
--- /dev/null
+++ b/man2/memfd_secret.2
@@ -0,0 +1,143 @@
+.\" Copyright (c) 2021, IBM Corporation.
+.\" Written by Mike Rapoport <rppt@linux.ibm.com>
+.\"
+.\" Based on memfd_create(2) man page
+.\" Copyright (C) 2014 Michael Kerrisk <mtk.manpages@gmail.com>
+.\" and Copyright (C) 2014 David Herrmann <dh.herrmann@gmail.com>
+.\"
+.\" %%%LICENSE_START(GPLv2+)
+.\"
+.\" This program is free software; you can redistribute it and/or modify
+.\" it under the terms of the GNU General Public License as published by
+.\" the Free Software Foundation; either version 2 of the License, or
+.\" (at your option) any later version.
+.\"
+.\" This program is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, see
+.\" <http://www.gnu.org/licenses/>.
+.\" %%%LICENSE_END
+.\"
+.TH MEMFD_SECRET 2 2020-08-02 Linux "Linux Programmer's Manual"
+.SH NAME
+memfd_secret \- create an anonymous file to access secret memory regions
+.SH SYNOPSIS
+.nf
+.BI "int memfd_secret(unsigned int " flags ");"
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call; see NOTES.
+.SH DESCRIPTION
+.BR memfd_secret ()
+creates an anonymous file and returns a file descriptor that refers to it.
+The file provides a way to create and access memory regions
+with stronger protection than usual RAM-based files and
+anonymous memory mappings.
+Once all references to the file are dropped, it is automatically released.
+The initial size of the file is set to 0.
+Following the call, the file size should be set using
+.BR ftruncate (2).
+.PP
+The memory areas backing the file created with
+.BR memfd_create(2)
+are visible only to the contexts that have access to the file descriptor.
+These areas are removed from the kernel page tables
+and only the page tables of the processes holding the file descriptor
+map the corresponding physical memory.
+.PP
+The following values may be bitwise ORed in
+.IR flags
+to control the behavior of
+.BR memfd_secret (2):
+.TP
+.BR FD_CLOEXEC
+Set the close-on-exec flag on the new file descriptor.
+See the description of the
+.B O_CLOEXEC
+flag in
+.BR open (2)
+for reasons why this may be useful.
+.PP
+As its return value,
+.BR memfd_secret ()
+returns a new file descriptor that can be used to refer to an anonymous file.
+This file descriptor is opened for both reading and writing
+.RB ( O_RDWR )
+and
+.B O_LARGEFILE
+is set for the file descriptor.
+.PP
+With respect to
+.BR fork (2)
+and
+.BR execve (2),
+the usual semantics apply for the file descriptor created by
+.BR memfd_secret ().
+A copy of the file descriptor is inherited by the child produced by
+.BR fork (2)
+and refers to the same file.
+The file descriptor is preserved across
+.BR execve (2),
+unless the close-on-exec flag has been set.
+.PP
+The memory regions backed with
+.BR memfd_secret ()
+are locked in the same way as
+.BR mlock (2),
+however the implementation will not try to
+populate the whole range during the
+.BR mmap (2)
+call.
+The amount of memory allowed for memory mappings
+of the file descriptor obeys the same rules as
+.BR mlock (2)
+and cannot exceed
+.BR RLIMIT_MEMLOCK .
+.SH RETURN VALUE
+On success,
+.BR memfd_secret ()
+returns a new file descriptor.
+On error, \-1 is returned and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EINVAL
+.I flags
+included unknown bits.
+.TP
+.B EMFILE
+The per-process limit on the number of open file descriptors has been reached.
+.TP
+.B EMFILE
+The system-wide limit on the total number of open files has been reached.
+.TP
+.B ENOMEM
+There was insufficient memory to create a new anonymous file.
+.TP
+.B ENOSYS
+.BR memfd_secret ()
+is not implemented on this architecture.
+.SH VERSIONS
+The
+.BR memfd_secret (2)
+system call first appeared in Linux 5.14.
+.SH CONFORMING TO
+The
+.BR memfd_secret (2)
+system call is Linux-specific.
+.SH NOTES
+.PP
+Glibc does not provide a wrapper for this system call; call it using
+.BR syscall (2).
+.SH SEE ALSO
+.BR fcntl (2),
+.BR ftruncate (2),
+.BR mlock (2),
+.BR mmap (2),
+.BR setrlimit (2)
-- 
2.31.1

