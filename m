Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2F3D5E9D
	for <lists+linux-api@lfdr.de>; Mon, 26 Jul 2021 17:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhGZPLD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Jul 2021 11:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236734AbhGZPJr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Jul 2021 11:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627314615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XgsuJsqBr9kyZ7zj2ygISOlArfFVIIfczRuQHcGCOnA=;
        b=aLkmavssjXiLeNOZ2wCQlceCIo7H7o9xNSL6Fj9v1xUhksUO9oQhGQPAmAj/tKNUbruXlz
        Af+RyBwUydDcJDS99LyLD36Lj8xm5ZL7OjdazFd2PB+WQ9fG29J26RBLh64Lf2xDqF6ISV
        bCPBvcgv5T4zlHBjcmjtVU2sWwbkrW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-YwsBknGRN-mDp0-0o9nRCQ-1; Mon, 26 Jul 2021 11:50:11 -0400
X-MC-Unique: YwsBknGRN-mDp0-0o9nRCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5750E92500;
        Mon, 26 Jul 2021 15:50:07 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-199.ams2.redhat.com [10.36.112.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B386510190AA;
        Mon, 26 Jul 2021 15:49:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Linux API <linux-api@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Ram Pai <linuxram@us.ibm.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1] mm/madvise: report SIGBUS as -EFAULT for MADV_POPULATE_(READ|WRITE)
Date:   Mon, 26 Jul 2021 17:49:32 +0200
Message-Id: <20210726154932.102880-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Doing some extended tests and polishing the man page update for
MADV_POPULATE_(READ|WRITE), I realized that we end up converting also
SIGBUS (via -EFAULT) to -EINVAL, making it look like yet another
madvise() user error.

We want to report only problematic mappings and permission problems that
the user could have know as -EINVAL.

Let's not convert -EFAULT arising due to SIGBUS (or SIGSEGV) to
-EINVAL, but instead indicate -EFAULT to user space. While we could also
convert it to -ENOMEM, using -EFAULT looks more helpful when user space
might want to troubleshoot what's going wrong: MADV_POPULATE_(READ|WRITE)
is not part of an final Linux release and we can still adjust the behavior.

Fixes: 4ca9b3859dac ("mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page tables")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c     | 7 +++++--
 mm/madvise.c | 4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 42b8b1fa6521..b94717977d17 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1558,9 +1558,12 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 		gup_flags |= FOLL_WRITE;
 
 	/*
-	 * See check_vma_flags(): Will return -EFAULT on incompatible mappings
-	 * or with insufficient permissions.
+	 * We want to report -EINVAL instead of -EFAULT for any permission
+	 * problems or incompatible mappings.
 	 */
+	if (check_vma_flags(vma, gup_flags))
+		return -EINVAL;
+
 	return __get_user_pages(mm, start, nr_pages, gup_flags,
 				NULL, NULL, locked);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 6d3d348b17f4..5c065bc8b5f6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -862,10 +862,12 @@ static long madvise_populate(struct vm_area_struct *vma,
 			switch (pages) {
 			case -EINTR:
 				return -EINTR;
-			case -EFAULT: /* Incompatible mappings / permissions. */
+			case -EINVAL: /* Incompatible mappings / permissions. */
 				return -EINVAL;
 			case -EHWPOISON:
 				return -EHWPOISON;
+			case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
+				return -EFAULT;
 			default:
 				pr_warn_once("%s: unhandled return value: %ld\n",
 					     __func__, pages);
-- 
2.31.1

