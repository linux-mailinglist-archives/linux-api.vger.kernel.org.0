Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5403CC0D4
	for <lists+linux-api@lfdr.de>; Sat, 17 Jul 2021 05:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbhGQDCz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 23:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhGQDCz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 23:02:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BCDC061760
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 19:59:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z64-20020a257e430000b0290550b1931c8dso15274787ybc.4
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OejThO9U7IkzrDDyCk4DT+oqrxwXtnahBtcnsZfFAwQ=;
        b=CPgeoEnhtdRlN+LrymMN8D/U57gZ4d4VKDzl3BBFvJ/t4UkOCMOpMAPlIhGVYZkhwQ
         adQHSP7U5ftflJkAQKk9UNQywQNxc3a2+awXCjnVGqdlOo6Q7rElF8Fdb5z8lO41tqKW
         pMN+ssnpuQqNYsGOE+7tQBBBy4KLLJWQyxQMdWJQQ8naLJeffrXoPkpZvIHhxGP1qzNS
         FwgGHPIDIVmOLRF7No+dWglwwbP/VJUrF1rwDKk85vmiMFK09rfSE2fdaVggWxbxCBJH
         KNwXQ5o2/eJ5aeeHE5g/dwVnvLuBmwGIJLmoOE1CMJnbX/iPxjFvKytx7KWkIwBJ2y+O
         nwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OejThO9U7IkzrDDyCk4DT+oqrxwXtnahBtcnsZfFAwQ=;
        b=WFY7sx5uu7ox7Rfr1WQNuZNIU0NtecQeJwgxiBrpFS95s5wHqCr/8WZuDfgnQNXojL
         T+cIwSOnbwTE7sX3duypnOQ2dr3GMftigHN9uZsuXtJtVXOY1HhE+6Yn8lBN1Z+X5KOB
         NOjaQNR+K7gmznDkbu8s6KWeiTL8J3LWFCtWakislxok6X5HxT9GQU60HeqgzBbAtfRm
         AKQaDjGbCAg27qyIEScBqvxfUGSvaO3NAi5sseoNtS/l2P/XnX88t0FK5+WX4/HnQD24
         i03xzxB/DDjvU0CpRqcb0MGhDvzOsk0T9tQIH7kKafRqfWhSa1k2+cEvpvZ8618bR8vo
         NbaQ==
X-Gm-Message-State: AOAM533gh1PWUsL8Ad7k4kUiP2ioGMEuPN7bBdVpg3MYQkq0T1MMzwBF
        ppBH58OwmsRe6PPYLxjnyqxye+w=
X-Google-Smtp-Source: ABdhPJw0Hll9OtU9YXnGycNCR3KDGCfnmUJm0p/DDzcJNWNnHpIWwpU/tCIze7NanEGfSWjI3RO3VgY=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:fc3c:d89a:88e2:5cfc])
 (user=pcc job=sendgmr) by 2002:a25:7316:: with SMTP id o22mr17005025ybc.349.1626490797837;
 Fri, 16 Jul 2021 19:59:57 -0700 (PDT)
Date:   Fri, 16 Jul 2021 19:59:51 -0700
Message-Id: <20210717025951.3946505-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH] refpage_create.2: Document refpage_create(2)
From:   Peter Collingbourne <pcc@google.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Peter Collingbourne <pcc@google.com>, Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

---
The syscall has not landed in the kernel yet.
Therefore, as usual, the patch should not be taken yet
and I've used 5.x as the introducing kernel version for now.

 man2/refpage_create.2 | 167 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 man2/refpage_create.2

diff --git a/man2/refpage_create.2 b/man2/refpage_create.2
new file mode 100644
index 000000000..c0b928b92
--- /dev/null
+++ b/man2/refpage_create.2
@@ -0,0 +1,167 @@
+.\" Copyright (C) 2021 Google LLC
+.\" Author: Peter Collingbourne <pcc@google.com>
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
+.TH REFPAGE_CREATE 2 2021-07-16 "Linux" "Linux Programmer's Manual"
+.SH NAME
+refpage_create \- create a reference page file descriptor
+.SH SYNOPSIS
+.nf
+.BR "#include <unistd.h>"
+.PP
+.BI "int syscall(SYS_refpage_create, void *" content ", unsigned int " size ,
+.BI "            unsigned long " flags ");"
+.fi
+.PP
+.IR Note :
+glibc provides no wrapper for
+.BR refpage_create (),
+necessitating the use of
+.BR syscall (2).
+.SH DESCRIPTION
+The
+.BR refpage_create ()
+system call is used to create a file descriptor
+that conceptually refers to a read-only file
+whose contents are an infinite repetition of
+.I size
+bytes of data read from the
+.I content
+argument to the system call,
+and which may be mapped into memory with
+.BR mmap (2).
+The file descriptor is created as if by passing
+.BR O_RDONLY | O_CLOEXEC
+to
+.BR open (2).
+.PP
+In reality, any read-only pages in the mapping are backed
+by a so-called reference page,
+whose contents are specified using the arguments to
+.BR refpage_create ().
+.PP
+The reference page will consist of repetitions of
+.I size
+bytes read
+from
+.IR content ,
+as many as are required to fill the page. The
+.I size
+argument must be a power of two less than or equal to the page size, and the
+.I content
+argument must have at least
+.I size
+alignment. The behavior is as if a copy of this data
+is made while servicing the system call;
+any updates to the data after the system call has returned
+will not be reflected in the reference page.
+.PP
+If the architecture specifies that metadata may be associated
+with memory addresses, that metadata if present is copied
+into the reference page along with the data itself,
+but only if the size argument is at least as large
+as the granularity of the metadata.
+For example, with the ARMv8.5 Memory Tagging Extension,
+the memory tags are copied, but only if the size is greater than
+or equal to the architecturally specified tag granule size of 16 bytes.
+.PP
+Writable private mappings trigger specific copy-on-write behavior
+when a page in the mapping is written to.
+The behavior is as if the reference page is copied,
+but the kernel may use a more efficient technique such as
+.BR memset (3)
+to produce the copy if the
+.I size
+argument originally used to create the reference page file descriptor
+is sufficiently small.
+For this reason it is recommended to specify as small of a
+.I size
+argument as possible
+in order to activate any such optimizations implemented in the kernel.
+.PP
+The advantage of using this system call
+over creating normal anonymous mappings
+and manually initializing the pages from userspace
+is that it is more efficient.
+If it is not known that all of the pages in the mapping
+will be faulted (for example, if the system call is used
+by a general purpose memory allocator
+where the behavior of the client program is unknown),
+letting the pages be prepared on fault only if needed
+is more efficient from both a performance
+and memory consumption perspective.
+Even if all of the pages would end up being faulted,
+it would still be more efficient
+to have the kernel initialize the pages with the required contents once
+than to have the kernel zero initialize them on fault
+and then have userspace initialize them again with different contents.
+.SH EXAMPLES
+The following program creates a 128KB memory mapping
+preinitialized with the pattern byte 0xAA
+and verifies that the contents of the mapping are correct.
+.PP
+.EX
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+int main() {
+    unsigned char pattern = 0xaa;
+    unsigned long mmap_size = 131072;
+
+    int fd = syscall(SYS_refpage_create, &pattern, 1, 0);
+    if (fd < 0) {
+        perror("refpage_create");
+        return 1;
+    }
+    unsigned char *p = mmap(0, mmap_size, PROT_READ | PROT_WRITE,
+                            MAP_PRIVATE, fd, 0);
+    if (p == MAP_FAILED) {
+        perror("mmap");
+        return 1;
+    }
+    for (unsigned i = 0; i != mmap_size; ++i) {
+        if (p[i] != pattern) {
+            fprintf(stderr, "refpage failed contents check @ %u: "
+                    "0x%x != 0x%x\n",
+                    i, p[i], pattern);
+            return 1;
+        }
+    }
+}
+.EE
+.SH NOTE
+Reading from a reference page file descriptor, e.g. with
+.BR read (2),
+is not supported, nor would this be particularly useful.
+.SH VERSIONS
+This system call first appeared in Linux 5.x.
+.SH CONFORMING TO
+The
+.BR refpage_create ()
+system call is Linux-specific.
+.SH SEE ALSO
+.BR mmap (2),
+.BR open (2).
-- 
2.32.0.402.g57bb445576-goog

