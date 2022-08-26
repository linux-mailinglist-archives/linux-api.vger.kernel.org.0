Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98D5A31AF
	for <lists+linux-api@lfdr.de>; Sat, 27 Aug 2022 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbiHZWDn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Aug 2022 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbiHZWDj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Aug 2022 18:03:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35ABE01E4
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k1-20020a17090a658100b001fb35f86ccdso5484262pjj.9
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=dXP+9vsfpxslOB78pAUAKGhf3+HQiv2Z7Puca9QzRiI=;
        b=UUdefA99whWeAPdVewQJGWtgwJAf6QFyo2nB1eXeR3D26y8jkKl2QaDFGf9nyXegQD
         PMfUFQcy+eH/Rk3bAA5auGa4yLuvXfPJdFilXlNJ1+28klatOEo/92jGP3+uZSdpkctt
         C0F49dXfx7QZbtmguaWNYAoE0+7tR61WSiqgM6BGeEZr4rg2jK0TN2svz7n7isIonl98
         KUsMlNxKo6mgGyfbY+e8xIdam+i81I97rTdl7GM/gTzXy38IIneFZ5sbhLIfHHHr3wg8
         ZrdFtrvQHTkYOVyut+B0ZgU3+Li8px1TifhggrPwV2Zk+k7mMJpx4dQnDzgtIEbC6O8b
         5J7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=dXP+9vsfpxslOB78pAUAKGhf3+HQiv2Z7Puca9QzRiI=;
        b=jfYUuCOoHNqmB2cs7jGn2Q2nZsSpmSxcSRMcGawwT5UPFG8opBUqq5cuhSDj3qJNH1
         UZlaxUVgR6r05yL1CK+xGymDRgVG9N6LMOaa3Q6cO0n2QUx22WzfHOgJslLaFsUStSmp
         LX6qtXqFkzzybYtnd76/+vkOi+Waq4JEzBIkOCBFu4PqXYEb4NPNzMp3Si7aOjQOiWxC
         9sK0bOXhZ601i4ytj1AqRl/iScatAPO3RW54/2ozvMBVCs5+TCTEOr5bWuFT3xfqnGnn
         Z9+dJJTUksydgRUc8JKuqcCWZQTRt/mzYeJZQ3o43u5EfWRhkOMrFIHqe7uRmQ9vyg9y
         9YoA==
X-Gm-Message-State: ACgBeo1a2D+pVOlDXjJMabpwf9UkGFfY4bEMqkdTFCH8/7zj1f7JyNY2
        IIQQnBH68Qolgoc8uB0eOhcLLLxdMoQT
X-Google-Smtp-Source: AA6agR7UEHuaEADQpjOa8/BfzXMogvMz51JQvcp1KYz3BoTZe3BjmDD0K1lm9ScbL81g2xPs+srLDzSYfb1S
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:3406:b0:535:f76f:c971 with SMTP
 id cn6-20020a056a00340600b00535f76fc971mr5770465pfb.5.1661551413900; Fri, 26
 Aug 2022 15:03:33 -0700 (PDT)
Date:   Fri, 26 Aug 2022 15:03:19 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826220329.1495407-1-zokeefe@google.com>
Subject: 
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

Subject: [PATCH mm-unstable v2 0/9] mm: add file/shmem support to MADV_COLLAPSE

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
Patches 5-8 	Refactor existing khugepaged selftests to work with new
		memory types.
Patch 9 	Adds a userfaultfd selftest mode to mimic a functional test
		of UFFDIO_REGISTER_MODE_MINOR+MADV_COLLAPSE live migration.

Applies against mm-unstable.

[1] https://lore.kernel.org/linux-mm/20220706235936.2197195-1-zokeefe@google.com/
[2] https://lore.kernel.org/linux-mm/YtBmhaiPHUTkJml8@google.com/

v1 -> v2:
- Add missing definition for khugepaged_add_pte_mapped_thp() in
  !CONFIG_SHEM builds, in "mm/khugepaged: attempt to map
  file/shmem-backed pte-mapped THPs by pmds"
- Minor bugfixes in "mm/madvise: add file and shmem support to
  MADV_COLLAPSE" for !CONFIG_SHMEM, !CONFIG_TRANSPARENT_HUGEPAGE and some
  compiler settings.
- Rebased on latest mm-unstable

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

 include/linux/khugepaged.h                    |  13 +-
 include/linux/shmem_fs.h                      |  10 +-
 include/trace/events/huge_memory.h            |  36 +
 kernel/events/uprobes.c                       |   2 +-
 mm/huge_memory.c                              |   2 +-
 mm/khugepaged.c                               | 289 ++++--
 mm/shmem.c                                    |  18 +-
 tools/testing/selftests/vm/Makefile           |   2 +
 tools/testing/selftests/vm/khugepaged.c       | 828 ++++++++++++------
 tools/testing/selftests/vm/soft-dirty.c       |   2 +-
 .../selftests/vm/split_huge_page_test.c       |  12 +-
 tools/testing/selftests/vm/userfaultfd.c      | 171 +++-
 tools/testing/selftests/vm/vm_util.c          |  36 +-
 tools/testing/selftests/vm/vm_util.h          |   5 +-
 14 files changed, 1040 insertions(+), 386 deletions(-)

-- 
2.37.2.672.g94769d06f0-goog

