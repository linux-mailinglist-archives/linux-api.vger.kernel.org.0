Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B095A8854
	for <lists+linux-api@lfdr.de>; Wed, 31 Aug 2022 23:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiHaVra (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Aug 2022 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHaVr3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Aug 2022 17:47:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DEB5A47
        for <linux-api@vger.kernel.org>; Wed, 31 Aug 2022 14:47:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y29so11634799pfq.0
        for <linux-api@vger.kernel.org>; Wed, 31 Aug 2022 14:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ELixXInJVYw7QNOqvSmbAXONuMRK6cy3zM9Z/tGjGTI=;
        b=C/jS+be9Q+YMOi1N3uYIuS8tm9uYTNrB0ZSLSLBTTKZlPagUMDisDD9dQJjcXN8l/4
         XAIAQwooCGhp+NkoYNU0ikqCXj8zOsL5cVRO6XN/bYuBLX3W1ePzLS+Tcs9BswIgG+gF
         eAcDQuP8VkVlvyLv/VMfePE0SlDdLAsFwWmtR4X0XDFAPCypLdD2N7aMoaTkzFDxoZ27
         CZaTtcHuhLe/NkTFlzywJHzMrLORetyQI3DnqD7cqMFOZhZV9ieQOUnom4I9Z9c1AQ8s
         5nUe4nltIy7/M8kOZFamKTR0lLP0XR5FKNBBDMTQTyO/n/wn4gFfkxRkK7x64PR8t67J
         cZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ELixXInJVYw7QNOqvSmbAXONuMRK6cy3zM9Z/tGjGTI=;
        b=jhPn/dlwb6hTya8/XdPEnNrMS8gxDp+/NeYfiQg0UbyGtph6iJjCAx+GjwLEAlpYaK
         lHEbfmgrXtV0cDcYVQphkxadYRiyCfp/xo9NWRKFnWRkbODpXg/U74U3rreEwwhMmJ0T
         XnXYPgImwBNzX0pMnwHYHnOuqBD4h9jk1/wkKG4ZQUJLjgLQ4aO7AWSmDIbxFFOzMykS
         6BvMoVoxKTO2MRaE0t3ckA7PyObDmoHLj2GUJvf+TVca9SExFsoYI+0gjf9AuxTluGwC
         hM7cxEWOOXg38TVf923mtuF0KNBbrQsTXJuh4IMpJCWsRdiAU2mnLJQG34PsfiqsVyiv
         374Q==
X-Gm-Message-State: ACgBeo2u+xXLWd++KgFdmXVOOJCTFBKiInylmpqjGuWCj92yeYmkCI4N
        bIF/9PgO4iWezZB7hQLVFZuRmJBxXuYBizJp1TU=
X-Google-Smtp-Source: AA6agR5ra5USkJUdskHOKQoaMlkJskiIbdCsZIHLzh3CgQDh9+ZhY5dGpUkzghnIqepLPWl3f0poG6t4QKfzt+J3KCQ=
X-Received: by 2002:a05:6a00:4393:b0:52f:3603:e62f with SMTP id
 bt19-20020a056a00439300b0052f3603e62fmr27986300pfb.23.1661982448387; Wed, 31
 Aug 2022 14:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220826220329.1495407-1-zokeefe@google.com>
In-Reply-To: <20220826220329.1495407-1-zokeefe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 14:47:16 -0700
Message-ID: <CAHbLzkr4GP409ONt-ivPH14rd-doQ5CoSr5WR=P4Sfk44pXEjw@mail.gmail.com>
Subject: Re:
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
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
        Patrick Xia <patrickx@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Zach,

I did a quick look at the series, basically no show stopper to me. But
I didn't find time to review them thoroughly yet, quite busy on
something else. Just a heads up, I didn't mean to ignore you. I will
review them when I find some time.

Thanks,
Yang

On Fri, Aug 26, 2022 at 3:03 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> Subject: [PATCH mm-unstable v2 0/9] mm: add file/shmem support to MADV_COLLAPSE
>
> v2 Forward
>
> Mostly a RESEND: rebase on latest mm-unstable + minor bug fixes from
> kernel test robot.
> --------------------------------
>
> This series builds on top of the previous "mm: userspace hugepage collapse"
> series which introduced the MADV_COLLAPSE madvise mode and added support
> for private, anonymous mappings[1], by adding support for file and shmem
> backed memory to CONFIG_READ_ONLY_THP_FOR_FS=y kernels.
>
> File and shmem support have been added with effort to align with existing
> MADV_COLLAPSE semantics and policy decisions[2].  Collapse of shmem-backed
> memory ignores kernel-guiding directives and heuristics including all
> sysfs settings (transparent_hugepage/shmem_enabled), and tmpfs huge= mount
> options (shmem always supports large folios).  Like anonymous mappings, on
> successful return of MADV_COLLAPSE on file/shmem memory, the contents of
> memory mapped by the addresses provided will be synchronously pmd-mapped
> THPs.
>
> This functionality unlocks two important uses:
>
> (1)     Immediately back executable text by THPs.  Current support provided
>         by CONFIG_READ_ONLY_THP_FOR_FS may take a long time on a large
>         system which might impair services from serving at their full rated
>         load after (re)starting.  Tricks like mremap(2)'ing text onto
>         anonymous memory to immediately realize iTLB performance prevents
>         page sharing and demand paging, both of which increase steady state
>         memory footprint.  Now, we can have the best of both worlds: Peak
>         upfront performance and lower RAM footprints.
>
> (2)     userfaultfd-based live migration of virtual machines satisfy UFFD
>         faults by fetching native-sized pages over the network (to avoid
>         latency of transferring an entire hugepage).  However, after guest
>         memory has been fully copied to the new host, MADV_COLLAPSE can
>         be used to immediately increase guest performance.
>
> khugepaged has received a small improvement by association and can now
> detect and collapse pte-mapped THPs.  However, there is still work to be
> done along the file collapse path.  Compound pages of arbitrary order still
> needs to be supported and THP collapse needs to be converted to using
> folios in general.  Eventually, we'd like to move away from the read-only
> and executable-mapped constraints currently imposed on eligible files and
> support any inode claiming huge folio support.  That said, I think the
> series as-is covers enough to claim that MADV_COLLAPSE supports file/shmem
> memory.
>
> Patches 1-3     Implement the guts of the series.
> Patch 4         Is a tracepoint for debugging.
> Patches 5-8     Refactor existing khugepaged selftests to work with new
>                 memory types.
> Patch 9         Adds a userfaultfd selftest mode to mimic a functional test
>                 of UFFDIO_REGISTER_MODE_MINOR+MADV_COLLAPSE live migration.
>
> Applies against mm-unstable.
>
> [1] https://lore.kernel.org/linux-mm/20220706235936.2197195-1-zokeefe@google.com/
> [2] https://lore.kernel.org/linux-mm/YtBmhaiPHUTkJml8@google.com/
>
> v1 -> v2:
> - Add missing definition for khugepaged_add_pte_mapped_thp() in
>   !CONFIG_SHEM builds, in "mm/khugepaged: attempt to map
>   file/shmem-backed pte-mapped THPs by pmds"
> - Minor bugfixes in "mm/madvise: add file and shmem support to
>   MADV_COLLAPSE" for !CONFIG_SHMEM, !CONFIG_TRANSPARENT_HUGEPAGE and some
>   compiler settings.
> - Rebased on latest mm-unstable
>
> Zach O'Keefe (9):
>   mm/shmem: add flag to enforce shmem THP in hugepage_vma_check()
>   mm/khugepaged: attempt to map file/shmem-backed pte-mapped THPs by
>     pmds
>   mm/madvise: add file and shmem support to MADV_COLLAPSE
>   mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
>   selftests/vm: dedup THP helpers
>   selftests/vm: modularize thp collapse memory operations
>   selftests/vm: add thp collapse file and tmpfs testing
>   selftests/vm: add thp collapse shmem testing
>   selftests/vm: add selftest for MADV_COLLAPSE of uffd-minor memory
>
>  include/linux/khugepaged.h                    |  13 +-
>  include/linux/shmem_fs.h                      |  10 +-
>  include/trace/events/huge_memory.h            |  36 +
>  kernel/events/uprobes.c                       |   2 +-
>  mm/huge_memory.c                              |   2 +-
>  mm/khugepaged.c                               | 289 ++++--
>  mm/shmem.c                                    |  18 +-
>  tools/testing/selftests/vm/Makefile           |   2 +
>  tools/testing/selftests/vm/khugepaged.c       | 828 ++++++++++++------
>  tools/testing/selftests/vm/soft-dirty.c       |   2 +-
>  .../selftests/vm/split_huge_page_test.c       |  12 +-
>  tools/testing/selftests/vm/userfaultfd.c      | 171 +++-
>  tools/testing/selftests/vm/vm_util.c          |  36 +-
>  tools/testing/selftests/vm/vm_util.h          |   5 +-
>  14 files changed, 1040 insertions(+), 386 deletions(-)
>
> --
> 2.37.2.672.g94769d06f0-goog
>
