Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614F73C5838
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353593AbhGLInK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 04:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350308AbhGLImT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 04:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626079171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nWJUYOez7eAAIVRuvZFT1uKCzfdN0rxKg/h1MnIYqcE=;
        b=NKVVXLn3mvXlhd8Zzvu6iANoK0wIPQJtxCJ5ODhc++6e97IOjzrUrSw2znWBWcDUQhhqeb
        lUy1ffc+ANGSdC0z/EW6smi64jDshWw1kps7CGLNA2SH90U7KjgYt4bPI7fEdw1JY/I43b
        h16zSEMfzSY/+ntsPSTCAUAA9uzaH8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-soJ3PwFuObWp_v98xq5Dog-1; Mon, 12 Jul 2021 04:39:27 -0400
X-MC-Unique: soJ3PwFuObWp_v98xq5Dog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53D3D1906810;
        Mon, 12 Jul 2021 08:39:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-111.rdu2.redhat.com [10.10.113.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F9DA60CA0;
        Mon, 12 Jul 2021 08:39:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH v1] madvise.2: Document MADV_POPULATE_READ and MADV_POPULATE_WRITE
Date:   Mon, 12 Jul 2021 10:39:17 +0200
Message-Id: <20210712083917.16361-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.

Let's document the behavior and error conditions of these new madvise()
options.

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
 man2/madvise.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/man2/madvise.2 b/man2/madvise.2
index f1f384c0c..3ec8c53a7 100644
--- a/man2/madvise.2
+++ b/man2/madvise.2
@@ -469,6 +469,59 @@ If a page is file-backed and dirty, it will be written back to the backing
 storage.
 The advice might be ignored for some pages in the range when it is not
 applicable.
+.TP
+.BR MADV_POPULATE_READ " (since Linux 5.14)
+Populate (prefault) page tables readable for the whole range without actually
+reading. Depending on the underlying mapping, map the shared zeropage,
+preallocate memory or read the underlying file; files with holes might or
+might not preallocate blocks.
+Do not generate
+.B SIGBUS
+when populating fails, return an error instead.
+.IP
+If
+.B MADV_POPULATE_READ
+succeeds, all page tables have been populated (prefaulted) readable once.
+If
+.B MADV_POPULATE_READ
+fails, some page tables might have been populated.
+.IP
+.B MADV_POPULATE_READ
+cannot be applied to mappings without read permissions
+and special mappings marked with the kernel-internal
+.B VM_PFNMAP
+and
+.BR VM_IO .
+.IP
+Note that with
+.BR MADV_POPULATE_READ ,
+the process can be killed at any moment when the system runs out of memory.
+.TP
+.BR MADV_POPULATE_WRITE " (since Linux 5.14)
+Populate (prefault) page tables writable for the whole range without actually
+writing. Depending on the underlying mapping, preallocate memory or read the
+underlying file; files with holes will preallocate blocks.
+Do not generate
+.B SIGBUS
+when populating fails, return an error instead.
+.IP
+If
+.B MADV_POPULATE_WRITE
+succeeds, all page tables have been populated (prefaulted) writable once.
+If
+.B MADV_POPULATE_WRITE
+fails, some page tables might have been populated.
+.IP
+.B MADV_POPULATE_WRITE
+cannot be applied to mappings without write permissions
+and special mappings marked with the kernel-internal
+.B VM_PFNMAP
+and
+.BR VM_IO .
+.IP
+Note that
+.BR MADV_POPULATE_WRITE ,
+the process can be killed at any moment when the system runs out of memory.
 .SH RETURN VALUE
 On success,
 .BR madvise ()
@@ -533,6 +586,17 @@ or
 .BR VM_PFNMAP
 ranges.
 .TP
+.B EINVAL
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+but the specified address range includes ranges with insufficient permissions,
+.B VM_IO
+or
+.BR VM_PFNMAP.
+.TP
 .B EIO
 (for
 .BR MADV_WILLNEED )
@@ -548,6 +612,14 @@ Not enough memory: paging in failed.
 Addresses in the specified range are not currently
 mapped, or are outside the address space of the process.
 .TP
+.B ENOMEM
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+but populating (prefaulting) page tables failed.
+.TP
 .B EPERM
 .I advice
 is
@@ -555,6 +627,14 @@ is
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
+and a HW poisoned page is encountered.
 .SH VERSIONS
 Since Linux 3.18,
 .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb
-- 
2.31.1

