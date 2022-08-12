Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA185909D4
	for <lists+linux-api@lfdr.de>; Fri, 12 Aug 2022 03:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiHLB3N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Aug 2022 21:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHLB3M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Aug 2022 21:29:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A149BB51
        for <linux-api@vger.kernel.org>; Thu, 11 Aug 2022 18:29:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3225b644be1so162635727b3.1
        for <linux-api@vger.kernel.org>; Thu, 11 Aug 2022 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=if6uvJ3UFEkHYXJdm0V6NqlZ2nbAtRfgdCIDdGufHqk=;
        b=f1qIxcWBpgUufqegB/VCYfxG65M3tQBjlGY00iCGIyKGgqzKQoYoSeMtQaChrxuhQa
         VQ+MggfBQGj8fvSJ+rjWpWZvv6ApWhp/WA/Wqbh3ix8umCYh9cUOnM6m1AxamlJIZ1tO
         KfdqIGPtcxQlBoGc0JQYLcd3xVwyYrzeHCB5sSWqn2Oy0WbbuT77/s9tjNztd9VcaBpU
         F0VeKM4iQGpZc7YgcoF5wJ2kKG30iND3+YBeTVR7YL7DgiejooAvwjLV78p0HWLmMIUp
         aKiMXEWHum3aTUVFtFf/e0wO7QqLzb8myS19ASXtHXviZwH78i/hGnyRjydqUltg9x8h
         t87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=if6uvJ3UFEkHYXJdm0V6NqlZ2nbAtRfgdCIDdGufHqk=;
        b=FuQABjTHSxy6jDeyHDl6TNC96cbiX65KQiqWYrogxVsxYxDJLAyROs7ot8vzxXBpU4
         f464Pqfpop6AIQRmJwKzai1C1MFMrMoREKKgtrr6VmD1EjQfp850yJLmI+8xE6YVX8Zt
         EPokA5uoy90YGeFwjKFhn3sgJ6a76NCR1dceBU5CX+DRArK6IrF50JiioKkyiVS9fERL
         Hs1SW91pf9O8xPnc5fwCwmKC1NrSkMPNCsfmb0GwaJzzyX7ZF3q3a9sLOaRH9T8uDwAG
         sMUI4u8PsAPhcexWcj8kjfKdaqtRh49ogGAnjF819+F5qGn7ct7J9fI2JbfCYuVi28KO
         cmAA==
X-Gm-Message-State: ACgBeo2+vaKF5woNjm6uz5aRxOKbrqNj/8KiOUpWqyAoAfIlXq1kjFuJ
        Uc9AxhyThrpzrloQWlcMvj4wXMhAUxne
X-Google-Smtp-Source: AA6agR5/yGF/fzg551Z5jnnuhxriIQy2SWtQ2Mki9B5nZLwTovKFrS/tr+NhvFSesuwKe+E7J9Ot3a/G4jzD
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a81:6dca:0:b0:325:472d:bcb0 with SMTP id
 i193-20020a816dca000000b00325472dbcb0mr1859096ywc.300.1660267750918; Thu, 11
 Aug 2022 18:29:10 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:28:34 -0700
Message-Id: <20220812012843.3948330-1-zokeefe@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH mm-unstable 0/9] mm: add file/shmem support to MADV_COLLAPSE
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
Patches 5-8 	Refactor existing khugepaged selftests to work with new
		memory types.
Patch 9 	Adds a userfaultfd selftest mode to mimic a functional test
		of UFFDIO_REGISTER_MODE_MINOR+MADV_COLLAPSE live migration.

Applies against mm-unstable.

[1] https://lore.kernel.org/linux-mm/20220706235936.2197195-1-zokeefe@google.com/
[2] https://lore.kernel.org/linux-mm/YtBmhaiPHUTkJml8@google.com/


Zach O'Keefe (9):
  mm/shmem: add flag to enforce shmem THP in hugepage_vma_check()
  mm/khugepaged: attempt to map file/shmem-backed pte-mapped THPs by
    pmds
  mm/madvise: add file and shmem support to MADV_COLLAPSE
  mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
  selftests/vm: dedup THP helpers
  selftests/vm: modularize thp collapse memory operations
  selftests/vm: add thp collapse file and tmpfs testing
  selftests/vm: add thp collapse shmem testing
  selftests/vm: add selftest for MADV_COLLAPSE of uffd-minor memory

 include/linux/khugepaged.h                    |  11 +-
 include/linux/shmem_fs.h                      |  10 +-
 include/trace/events/huge_memory.h            |  36 +
 kernel/events/uprobes.c                       |   2 +-
 mm/huge_memory.c                              |   2 +-
 mm/khugepaged.c                               | 285 ++++--
 mm/shmem.c                                    |  18 +-
 tools/testing/selftests/vm/Makefile           |   2 +
 tools/testing/selftests/vm/khugepaged.c       | 828 ++++++++++++------
 tools/testing/selftests/vm/soft-dirty.c       |   2 +-
 .../selftests/vm/split_huge_page_test.c       |  12 +-
 tools/testing/selftests/vm/userfaultfd.c      | 171 +++-
 tools/testing/selftests/vm/vm_util.c          |  36 +-
 tools/testing/selftests/vm/vm_util.h          |   5 +-
 14 files changed, 1034 insertions(+), 386 deletions(-)

-- 
2.37.1.559.g78731f0fdb-goog

