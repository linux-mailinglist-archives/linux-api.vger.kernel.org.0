Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338183ED025
	for <lists+linux-api@lfdr.de>; Mon, 16 Aug 2021 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhHPIUF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Aug 2021 04:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234386AbhHPIUE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Aug 2021 04:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629101973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JJy1wTV0mXwECxuw+eS0iCkYTF/8HGBJnP6WAB8OQEQ=;
        b=dv5XzXbXG/1RW0hiPjXhLsjO07Bcisa+BspUep9TFqWGupPoPzrEsV5Igg3vac95dcVYNS
        DTnyOsNBTi4NsdpU5uodznPAqYP8XHlKsbVP/z9eQZssonRZe39ARMevmLQnc/vUwE/nqH
        R/wrlu4gChv5agGKlsaGeNr8BbZa3k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Qk4NXh_TM16hKZO6MpW73A-1; Mon, 16 Aug 2021 04:19:31 -0400
X-MC-Unique: Qk4NXh_TM16hKZO6MpW73A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99229107ACF5;
        Mon, 16 Aug 2021 08:19:29 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36C50620DE;
        Mon, 16 Aug 2021 08:19:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta@ionos.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH v2] madvise.2: Document MADV_POPULATE_READ and MADV_POPULATE_WRITE
Date:   Mon, 16 Aug 2021 10:19:22 +0200
Message-Id: <20210816081922.5155-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.

Further, commit eb2faa513c24 ("mm/madvise: report SIGBUS as -EFAULT for
MADV_POPULATE_(READ|WRITE)"), part of v5.14-rc6, made sure that SIGBUS is
converted to -EFAULT instead of -EINVAL.

Let's document the behavior and error conditions of these new madvise()
options.

Acked-by: Pankaj Gupta <pankaj.gupta@ionos.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: linux-mm@kvack.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Use semantic newlines in all cases
- Add two missing "
- Document -EFAULT handling
- Rephrase some parts to make it more generic: VM_PFNMAP and VM_IO are only
  examples for special mappings

---
 man2/madvise.2 | 107 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/man2/madvise.2 b/man2/madvise.2
index f1f384c0c..f6cea9ad2 100644
--- a/man2/madvise.2
+++ b/man2/madvise.2
@@ -469,6 +469,72 @@ If a page is file-backed and dirty, it will be written back to the backing
 storage.
 The advice might be ignored for some pages in the range when it is not
 applicable.
+.TP
+.BR MADV_POPULATE_READ " (since Linux 5.14)"
+Populate (prefault) page tables readable for the whole range without actually
+reading memory.
+Depending on the underlying mapping,
+map the shared zeropage,
+preallocate memory or read the underlying file;
+files with holes might or might not preallocate blocks.
+Do not generate
+.B SIGBUS
+when populating fails,
+return an error instead.
+.IP
+If
+.B MADV_POPULATE_READ
+succeeds,
+all page tables have been populated (prefaulted) readable once.
+If
+.B MADV_POPULATE_READ
+fails,
+some page tables might have been populated.
+.IP
+.B MADV_POPULATE_READ
+cannot be applied to mappings without read permissions
+and special mappings,
+for example,
+marked with the kernel-internal
+.B VM_PFNMAP
+and
+.BR VM_IO .
+.IP
+Note that with
+.BR MADV_POPULATE_READ ,
+the process can be killed at any moment when the system runs out of memory.
+.TP
+.BR MADV_POPULATE_WRITE " (since Linux 5.14)"
+Populate (prefault) page tables writable for the whole range without actually
+writing memory.
+Depending on the underlying mapping,
+preallocate memory or read the underlying file;
+files with holes will preallocate blocks.
+Do not generate
+.B SIGBUS
+when populating fails,
+return an error instead.
+.IP
+If
+.B MADV_POPULATE_WRITE
+succeeds,
+all page tables have been populated (prefaulted) writable once.
+If
+.B MADV_POPULATE_WRITE
+fails, some page tables might have been populated.
+.IP
+.B MADV_POPULATE_WRITE
+cannot be applied to mappings without write permissions
+and special mappings,
+for example,
+marked with the kernel-internal
+.B VM_PFNMAP
+and
+.BR VM_IO .
+.IP
+Note that with
+.BR MADV_POPULATE_WRITE ,
+the process can be killed at any moment when the system runs out of memory.
 .SH RETURN VALUE
 On success,
 .BR madvise ()
@@ -490,6 +556,17 @@ A kernel resource was temporarily unavailable.
 .B EBADF
 The map exists, but the area maps something that isn't a file.
 .TP
+.B EFAULT
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+and populating (prefaulting) page tables failed because a
+.B SIGBUS
+would have been generated on actual memory access and the reason is not a
+HW poisoned page.
+.TP
 .B EINVAL
 .I addr
 is not page-aligned or
@@ -533,6 +610,18 @@ or
 .BR VM_PFNMAP
 ranges.
 .TP
+.B EINVAL
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+but the specified address range includes ranges with insufficient permissions
+or incompatible mappings such as
+.B VM_IO
+or
+.BR VM_PFNMAP.
+.TP
 .B EIO
 (for
 .BR MADV_WILLNEED )
@@ -548,6 +637,15 @@ Not enough memory: paging in failed.
 Addresses in the specified range are not currently
 mapped, or are outside the address space of the process.
 .TP
+.B ENOMEM
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+and populating (prefaulting) page tables failed because there was not enough
+memory.
+.TP
 .B EPERM
 .I advice
 is
@@ -555,6 +653,15 @@ is
 but the caller does not have the
 .B CAP_SYS_ADMIN
 capability.
+.TP
+.B EHWPOISON
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+and populating (prefaulting) page tables failed because a HW poisoned page
+was encountered.
 .SH VERSIONS
 Since Linux 3.18,
 .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb
-- 
2.31.1

