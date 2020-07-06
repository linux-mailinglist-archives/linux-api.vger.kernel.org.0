Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B436215CE7
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgGFRVA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 13:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbgGFRVA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 6 Jul 2020 13:21:00 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28431206CD;
        Mon,  6 Jul 2020 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594056059;
        bh=rp3iLbG4NzFQ6srRlKxeSGp+kPRUVlRaIbnd6z2D5UY=;
        h=From:To:Cc:Subject:Date:From;
        b=l76C5n6D647knTaiC1Ofb1gHincOwMnY9GaLtoXpCGO4qWLWz68KmJY4gVJQ/6d/k
         VR/PWu6VIqUgb9u1FiEtG5Gf3RnfhjbueTLXu9dsFSDOZ2ky6V19VYmfJjX5c3HeU/
         pCMYh7UCO/5pYVrWEUvl/qjqN1iCeEqppXWkAh9c=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC PATCH v2 0/5] mm: extend memfd with ability to create "secret" memory areas
Date:   Mon,  6 Jul 2020 20:20:46 +0300
Message-Id: <20200706172051.19465-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is a second version of "secret" mappings implementation backed by a
file descriptor. 

The file descriptor is created using memfd_create() syscall with a new
MFD_SECRET flag. The file descriptor should be configured using ioctl() to
define the desired protection and then mmap() of the fd will create a
"secret" memory mapping. The pages in that mapping will be marked as not
present in the direct map and will have desired protection bits set in the
user page table. For instance, current implementation allows uncached
mappings.

Hiding secret memory mappings behind an anonymous file allows (ab)use of
the page cache for tracking pages allocated for the "secret" mappings as
well as using address_space_operations for e.g. page migration callbacks.

The anonymous file may be also used implicitly, like hugetlb files, to
implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
ABIs.

As the fragmentation of the direct map was one of the major concerns raised
during the previous postings, I've added an amortizing cache of PMD-size
pages to each file descriptor and an ability to reserve large chunks of the
physical memory at boot time and then use this memory as an allocation pool
for the secret memory areas.

In addition, I've tried to find some numbers that show the benefit of using
larger pages in the direct map, but I couldn't find anything so I've run a
couple of benchmarks from phoronix-test-suite on my laptop (i7-8650U with
32G RAM).

I've tested three variants: the default with 28G of the physical memory
covered with 1G pages, then I disabled 1G pages using "nogbpages" in the
kernel command line and at last I've forced the entire direct map to use 4K
pages using a simple patch to arch/x86/mm/init.c.
I've made runs of the benchmarks with SSD and tmpfs.

Surprisingly, the results does not show huge advantage for large pages. For
instance, here the results for kernel build with 'make -j8', in seconds:

                        |  1G    |  2M    |  4K
------------------------+--------+--------+---------
ssd, mitigations=on	| 308.75 | 317.37 | 314.9 
ssd, mitigations=off	| 305.25 | 295.32 | 304.92 
ram, mitigations=on	| 301.58 | 322.49 | 306.54 
ram, mitigations=off	| 299.32 | 288.44 | 310.65

All the results I have are available at [1].
If anybody is interested in plain text, please let me know.

[1] https://docs.google.com/spreadsheets/d/1tdD-cu8e93vnfGsTFxZ5YdaEfs2E1GELlvWNOGkJV2U/edit?usp=sharing

Mike Rapoport (5):
  mm: make HPAGE_PxD_{SHIFT,MASK,SIZE} always available
  mmap: make mlock_future_check() global
  mm: extend memfd with ability to create "secret" memory areas
  mm: secretmem: use PMD-size pages to amortize direct map fragmentation
  mm: secretmem: add ability to reserve memory at boot

 include/linux/huge_mm.h    |  10 +-
 include/linux/memfd.h      |   9 +
 include/uapi/linux/magic.h |   1 +
 include/uapi/linux/memfd.h |   6 +
 mm/Kconfig                 |   3 +
 mm/Makefile                |   1 +
 mm/internal.h              |   3 +
 mm/memfd.c                 |  10 +-
 mm/mmap.c                  |   5 +-
 mm/secretmem.c             | 445 +++++++++++++++++++++++++++++++++++++
 10 files changed, 480 insertions(+), 13 deletions(-)
 create mode 100644 mm/secretmem.c


base-commit: 7c30b859a947535f2213277e827d7ac7dcff9c84
-- 
2.26.2

