Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB6A364556
	for <lists+linux-api@lfdr.de>; Mon, 19 Apr 2021 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhDSNze (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Apr 2021 09:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235854AbhDSNze (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Apr 2021 09:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618840504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sH/va859G7+kPRIk42Cl7YV9RauhBxFyo2eED4b+bpA=;
        b=htLGTrB758fNAXh4b7rPyPGldsFba3K+n1S6oEdkcnsor3PionW2EAsAcwJ2sttreKmC/+
        yJFDY1iGDocYZFPV1Vqn8qcNkPY+8aq0Oq8vbLMCUO899nCM39I8s7LVcAkLyGUoWJChbk
        lQ47lhKzmS+/5EkykXzGbHCGlQqqnxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-em2bedRCMIOvFc4uC3t2lA-1; Mon, 19 Apr 2021 09:55:01 -0400
X-MC-Unique: em2bedRCMIOvFc4uC3t2lA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45A27107B02A;
        Mon, 19 Apr 2021 13:54:56 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-67.ams2.redhat.com [10.36.115.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27A3E10016FD;
        Mon, 19 Apr 2021 13:54:43 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Rik van Riel <riel@surriel.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page tables
Date:   Mon, 19 Apr 2021 15:54:38 +0200
Message-Id: <20210419135443.12822-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excessive details on MADV_POPULATE_(READ|WRITE) can be found in patch #2.

v1 -> v2:
- "mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page
   tables"
-- Renamed patch/series to match what's happening -- prefault page tables
-- Clarified MADV_POPULATE_READ semantics on file holes and that we might
   want fallocate().
-- Updated/clarified description
-- Dropped -EINVAL and -EBUSY checks
-- Added a comment regarding FOLL_TOUCH and why we don't care that
   pages will get set dirty when triggering write-faults for now.
-- Reran and extended performance measurements by more fallocate()
   combinations

RFCv2 -> v1
- "mm: fix variable name in declaration of populate_vma_page_range()"
-- Added
- "mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault ..."
-- Fix detection of memory holes when we have to re-lookup the VMA
-- Return -EHWPOISON to user space when we hit HW poisoned pages
-- Make variable names in definition and declaration consistent
- "MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT"
-- Added
- "selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore"
-- Added
- "selftests/vm: add test for MADV_POPULATE_(READ|WRITE)"
-- Added

RFC -> RFCv2:
- Fix re-locking (-> set "locked = 1;")
- Don't mimic MAP_POPULATE semantics:
--> Explicit READ/WRITE request instead of selecting it automatically,
    which makes it more generic and better suited for some use cases (e.g., we
    usually want to prefault shmem writable)
--> Require proper access permissions
- Introduce and use faultin_vma_page_range()
--> Properly handle HWPOISON pages (FOLL_HWPOISON)
--> Require proper access permissions (!FOLL_FORCE)
- Let faultin_vma_page_range() check for compatible mappings/permissions
- Extend patch description and add some performance numbers


David Hildenbrand (5):
  mm: make variable names for populate_vma_page_range() consistent
  mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page
    tables
  MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT
  selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore
  selftests/vm: add test for MADV_POPULATE_(READ|WRITE)

 MAINTAINERS                                |   1 +
 arch/alpha/include/uapi/asm/mman.h         |   3 +
 arch/mips/include/uapi/asm/mman.h          |   3 +
 arch/parisc/include/uapi/asm/mman.h        |   3 +
 arch/xtensa/include/uapi/asm/mman.h        |   3 +
 include/uapi/asm-generic/mman-common.h     |   3 +
 mm/gup.c                                   |  58 ++++
 mm/internal.h                              |   5 +-
 mm/madvise.c                               |  66 ++++
 tools/testing/selftests/vm/.gitignore      |   3 +
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/madv_populate.c | 342 +++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh  |  16 +
 13 files changed, 506 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/madv_populate.c

-- 
2.30.2

