Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F893D9F93
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhG2I3J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 04:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234256AbhG2I3I (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Jul 2021 04:29:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C81960D07;
        Thu, 29 Jul 2021 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627547346;
        bh=YkYp2gBenrrqFbWlwBkBunts6riSeDwI8+WtP6GKnb8=;
        h=From:To:Cc:Subject:Date:From;
        b=AVxzwWiP5kuwoCTjjVux0Fv5frS1TwUEvdi6KSl1Uo5gevqi/mjmbGu/msrdwXe5m
         RMLbnY/8G/jiJXGzqtKBp8idSMngH8S1aMJw9Xd/FZMNLO5jXiVUUdU7SEmjQm3geW
         A7wKjoUW61EVafXnyeqeW4jVk2e/B4+rk3vghRzOq3GFyTe5UzBZMXfhyjJabr26y5
         VDvC54XXkc+8rrNEf/3L+3sU1bg+6z58Iuldh2WPHDIGHE0r17097QFfWRYuMWIpPP
         4vBAUTHBxkIQGUtcXwqrhAr3rD+40+DvUj/U4Cc2/KXNJiOVDWIXJhBrn7Rt/DGeFf
         cH5ihMUXxHq/g==
From:   Mike Rapoport <rppt@kernel.org>
To:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] man2: new page describing memfd_secret() system call
Date:   Thu, 29 Jul 2021 11:29:00 +0300
Message-Id: <20210729082900.1581359-1-rppt@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

v2: address Alex's comments:
* update synopsis to match new style for syscalls without a wrapper
* drop note about absence of glibc wrapper
* update formatting

v1: https://lore.kernel.org/linux-api/20210727124140.1487079-1-rppt@kernel.org

 man2/memfd_secret.2 | 147 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 man2/memfd_secret.2

diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
new file mode 100644
index 000000000..5a70cb5d2
--- /dev/null
+++ b/man2/memfd_secret.2
@@ -0,0 +1,147 @@
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
+.PP
+.BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
+.B #include <unistd.h>
+.PP
+.BI "int syscall(SYS_memfd_secret, int " cmd ", unsigned int " flags \
+", int " cpu_id );
+.fi
+.PP
+.IR Note :
+glibc provides no wrapper for
+.BR memfd_secret (),
+necessitating the use of
+.BR syscall (2).
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
+.I flags
+to control the behavior of
+.BR memfd_secret (2):
+.TP
+.B FD_CLOEXEC
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
+.SH SEE ALSO
+.BR fcntl (2),
+.BR ftruncate (2),
+.BR mlock (2),
+.BR mmap (2),
+.BR setrlimit (2)
-- 
2.31.1

