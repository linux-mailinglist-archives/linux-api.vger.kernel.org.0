Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F0F5B0751
	for <lists+linux-api@lfdr.de>; Wed,  7 Sep 2022 16:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIGOpo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Sep 2022 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiIGOpg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Sep 2022 10:45:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A243B948
        for <linux-api@vger.kernel.org>; Wed,  7 Sep 2022 07:45:35 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g11-20020a17090a4b0b00b001fb5f1e195fso6686071pjh.6
        for <linux-api@vger.kernel.org>; Wed, 07 Sep 2022 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=eofNcK+q/CbjT029Irog10r6Ae95r0p58L4FY8syOsE=;
        b=MP9epeJ31sSPPV+UklrXAKP7pJ86makbOoWvv7CCMG3zixGj+mJIuUstjy2fKpFJlt
         UgVKQAfx20UxSCSWyx6OBxQcqSCT5fsdF52+lUqkYsFOcEXsHoRjmWy1GLILPrltZzeA
         NQ6eADS/7GUmFYDuINMPBuxjcYHEsM31gzYdk4uSnBZZEdBEdClI1mFRARSeN57o4DxT
         WrNSzZOaquMdrQg8mxCZp58gBe503I3AQdbobrfRzFrqkou9s3p/PhmsebCdL+T663Ie
         QOslOr3uiaRwwU6v1/ZYwOlwnRlsYWhLIIszHTmv1UgvJXvasvylIAvy0F07YTwzjSvf
         MJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=eofNcK+q/CbjT029Irog10r6Ae95r0p58L4FY8syOsE=;
        b=AaMAsQlxXIiM2w2V/lspv2gki/eUquXRpE/vR+IRJ0r14s6w3WOK7ErQ/1N8TuNdqX
         P2M/3Ry8/JunLiFYbLDTMtB971STnusv1BBhN52iZvy5j4H6QoXCC7Lvbs15+G1ewNnb
         trC7sYmxkC3EbkfKkuq+l310eKUTIcWvrI3MYAZV89Cd0nQ1OVjWCVVSu49nQ1vQXKRO
         T+rMAWiAvXpJkQ9PO0mHIR797/1seY38gwCVFesrwR5hA+DS+o/Mc7GdpuK5aLwQBfis
         M2ASs0PBWt7e57ZqX0U0xTnmG4rXfqPDCC2sLAUzNWyDpCNuAcAYNa3iJoSgSeIwGwJB
         y8CA==
X-Gm-Message-State: ACgBeo2HlqzDt2TBvPQh2ZMB+f+BaiaNUKAHV4dR3fYSozTPuncMFr7r
        3YC2CSKIvGPUSX/sb+oclgzD9NOr/MEX
X-Google-Smtp-Source: AA6agR41xC/YM0VEtZUMSaQv6s6ydFF+YZAmiUA5IIxlkEqXt8HOceritlOQ0tM0LylJMxxFgy9no+9bquGs
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:90b:4c52:b0:1f5:5129:af1a with SMTP id
 np18-20020a17090b4c5200b001f55129af1amr30526464pjb.202.1662561934849; Wed, 07
 Sep 2022 07:45:34 -0700 (PDT)
Date:   Wed,  7 Sep 2022 07:45:11 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907144521.3115321-1-zokeefe@google.com>
Subject: [PATCH mm-unstable v3 00/10] mm: add file/shmem support to MADV_COLLAPSE
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

v3 Forward

This version cleans up a few small issues in v2, expands selftest
coverage, rebases on some recent khugepaged changes and adds more details
to commit descriptions to help with review.

The three main cleanups made are:

(1)	Patch 2: In hpage_collapse_scan_file() and collapse_file(),
	don't use then xa_state.xa_index to determine if the
	HPAGE_PMD_ORDER THP is properly aligned.  Instead, check
	the compound_head(page)->index. Not only is it better to not
	rely on internal data in struct xa_state (as the comments
	above said struct definition ask), but it is slightly more
	accurate / future proof in case we encounter an unaligned
	compound page of order HPAGE_PMD_ORDER (AFAIK not possible today).
	Moreover, especially for hpage_collapse_scan_file() where the RCU
	lock might be dropped as we traverse the XArray, we want to
	be checking the compound_head(), since otherwise we might
	erroneously be looking at a tail page if a collapse happened from
	under us.

(2)	Patch 2: When hpage_collapse_scan_file() returns
	SCAN_PTE_MAPPED_HUGEPAGE in the khugepaged path, check the pmd
	maps a pte table before adding the mm/address to the deferred
	collapse array. The reason is: we will grab mmap_lock in write
	every time we attempt collapse_pte_mapped_thp(), so we should
	try to avoid this if possible.  This also prevents khugepaged
	from repeatedly adding the same mm/address pair to the deferred
	collapse array after the page cache has already been updated with
	the new hugepage, but before the memory has been refaulted.

(3)	Patch 3: In find_pmd_thp_or_none(), check pmd_none() instead of
	!pmd_present() when detecting pmds that have been cleared.  The
	reason this check exists is because MADV_COLLAPSE might be
	operating on memory which was already collapsed by khugepaged,
	but before the memory had been refaulted.  In this case, khugepaged
	cleared the pmd, and so the correct pmd entry to look for is the
	"none" pmd.
--------------------------------

v2 Forward

Mostly a RESEND: rebase on latest mm-unstable + minor bug fixes from
kernel test robot.
--------------------------------

This series builds on top of the previous "mm: userspace hugepage collapse"
series which introduced the MADV_COLLAPSE madvise mode and added support
for private, anonymous mappings[1], by adding support for file and shmem
backed memory to CONFIG_READ_ONLY_THP_FOR_FS=y kernels.

File and shmem support have been added with effort to align with existing
MADV_COLLAPSE semantics and policy decisions[2].  Collapse of shmem-backed
memory ignores kernel-guiding directives and heuristics including all
sysfs settings (transparent_hugepage/shmem_enabled), and tmpfs huge= mount
options (shmem always supports large folios).  Like anonymous mappings, on
successful return of MADV_COLLAPSE on file/shmem memory, the contents of
memory mapped by the addresses provided will be synchronously pmd-mapped
THPs.

This functionality unlocks two important uses:

(1)	Immediately back executable text by THPs.  Current support provided
	by CONFIG_READ_ONLY_THP_FOR_FS may take a long time on a large
	system which might impair services from serving at their full rated
	load after (re)starting.  Tricks like mremap(2)'ing text onto
	anonymous memory to immediately realize iTLB performance prevents
	page sharing and demand paging, both of which increase steady state
	memory footprint.  Now, we can have the best of both worlds: Peak
	upfront performance and lower RAM footprints.

(2)	userfaultfd-based live migration of virtual machines satisfy UFFD
	faults by fetching native-sized pages over the network (to avoid
	latency of transferring an entire hugepage).  However, after guest
	memory has been fully copied to the new host, MADV_COLLAPSE can
	be used to immediately increase guest performance.

khugepaged has received a small improvement by association and can now
detect and collapse pte-mapped THPs.  However, there is still work to be
done along the file collapse path.  Compound pages of arbitrary order still
needs to be supported and THP collapse needs to be converted to using
folios in general.  Eventually, we'd like to move away from the read-only
and executable-mapped constraints currently imposed on eligible files and
support any inode claiming huge folio support.  That said, I think the
series as-is covers enough to claim that MADV_COLLAPSE supports file/shmem
memory.

Patches 1-3	Implement the guts of the series.
Patch 4 	Is a tracepoint for debugging.
Patches 5-9 	Refactor existing khugepaged selftests to work with new
		memory types + new collapse tests.
Patch 10 	Adds a userfaultfd selftest mode to mimic a functional test
		of UFFDIO_REGISTER_MODE_MINOR+MADV_COLLAPSE live migration.
		(v3 note: "userfaultfd shmem" selftest is failing as of
		Sep 5 mm-unstable)

Applies against mm-unstable.

[1] https://lore.kernel.org/linux-mm/20220706235936.2197195-1-zokeefe@google.com/
[2] https://lore.kernel.org/linux-mm/YtBmhaiPHUTkJml8@google.com/

Previous versions:
v1: https://lore.kernel.org/linux-mm/20220812012843.3948330-1-zokeefe@google.com/
v2: https://lore.kernel.org/linux-mm/20220826220329.1495407-1-zokeefe@google.com/

v2 -> v3:
- The 3 changes mentioned in the v3 Forward
- Drop redundant PageTransCompound() check in collapse_pte_mapped_thp() in
  "mm/madvise: add file and shmem support to MADV_COLLAPSE" (it is covered
  by PageHead() and hugepage_vma_check() for !HugeTLB.
- In "selftests/vm: add thp collapse file and tmpfs testing", don't assume
  path used for file collapse testing will be on /dev/sda - instead, use the
  major/minor device numbers returned from stat(2) to traverse sysfs and find
  the correct block device.  Also only do stat() statfs() checks on
  user-supplied test directory once (instead of every time we create a test
  file).
- Added "selftests/vm: add file/shmem MADV_COLLAPSE selftest for cleared
  pmd" which tests a common case of MADV_COLLAPSE applied to file/shmem
  memory that has been "collapsed" (in the page cache) by khugepaged, but
  not yet refaulted by the process.

v1 -> v2:
- Add missing definition for khugepaged_add_pte_mapped_thp() in
  !CONFIG_SHEM builds, in "mm/khugepaged: attempt to map
  file/shmem-backed pte-mapped THPs by pmds"
- Minor bugfixes in "mm/madvise: add file and shmem support to
  MADV_COLLAPSE" for !CONFIG_SHMEM, !CONFIG_TRANSPARENT_HUGEPAGE and some
  compiler settings.
- Rebased on latest mm-unstable

Zach O'Keefe (10):
  mm/shmem: add flag to enforce shmem THP in hugepage_vma_check()
  mm/khugepaged: attempt to map file/shmem-backed pte-mapped THPs by
    pmds
  mm/madvise: add file and shmem support to MADV_COLLAPSE
  mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
  selftests/vm: dedup THP helpers
  selftests/vm: modularize thp collapse memory operations
  selftests/vm: add thp collapse file and tmpfs testing
  selftests/vm: add thp collapse shmem testing
  selftests/vm: add file/shmem MADV_COLLAPSE selftest for cleared pmd
  selftests/vm: add selftest for MADV_COLLAPSE of uffd-minor memory

 include/linux/khugepaged.h                    |  13 +-
 include/linux/shmem_fs.h                      |  10 +-
 include/trace/events/huge_memory.h            |  36 +
 kernel/events/uprobes.c                       |   2 +-
 mm/huge_memory.c                              |   2 +-
 mm/khugepaged.c                               | 304 ++++--
 mm/shmem.c                                    |  18 +-
 tools/testing/selftests/vm/Makefile           |   2 +
 tools/testing/selftests/vm/khugepaged.c       | 904 +++++++++++++-----
 tools/testing/selftests/vm/soft-dirty.c       |   2 +-
 .../selftests/vm/split_huge_page_test.c       |  12 +-
 tools/testing/selftests/vm/userfaultfd.c      | 171 +++-
 tools/testing/selftests/vm/vm_util.c          |  36 +-
 tools/testing/selftests/vm/vm_util.h          |   5 +-
 14 files changed, 1143 insertions(+), 374 deletions(-)

-- 
2.37.2.789.g6183377224-goog

