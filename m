Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1869BEE5
	for <lists+linux-api@lfdr.de>; Sun, 19 Feb 2023 08:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBSHd2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Feb 2023 02:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSHd1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 19 Feb 2023 02:33:27 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB2FF09;
        Sat, 18 Feb 2023 23:33:26 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-171d57fcba3so403549fac.11;
        Sat, 18 Feb 2023 23:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YkLqesT26PDlQjhQXn4IlepRpuZlcVw6wZTGqd23uOM=;
        b=KlBzoXu6leOvXsbKZEE/DdXu2JAdlx5qnLIElF3EN/8yJL7saLK+07QI4MkvwlZ0iI
         r1wNrUXB/thUpranTfqVv1QaB67ma3+o9NgU7GYn+DG9XkJlJZzKdlQ+8MizoMzT+WmO
         UYlXde/iRVSx6TaigtZDpvctklvxP32qZbEkEGKz6AL/Am0JkkKc9WSDfdrv31VSGkcn
         bOSI6uDxAUIvdutQFAQycdGtWc/AL0MCn6u6zttbXdVqG0ZFICsru0+8sNcXchq+Wk89
         i1zieOJiB6UlQzNvC1p+5bCW0X2CkwQ99Bp+nkYc/P1kOdZ6AY6iDL2aHN/t/zeSETlJ
         3EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkLqesT26PDlQjhQXn4IlepRpuZlcVw6wZTGqd23uOM=;
        b=QTYSFDjOxECKhMc080mQbd4oPpKixPv7y2DEJi9G2Y5y7lnT7irO71RtXFhp/jehg3
         MAJEiXvkKWgY04SkD1iw8UDTPcECQaSNmWAEnJjjLLQOa1YlhZq804hUSKgz/FmjoSiJ
         +I9o0r7kj1gMyeyF2Wjs62+UBt0lBxader6GAIwZ6Bn7znoUE1vRK5KPWpA/CHEAFHSQ
         pxcs9W+NGam9Ek2u7+CKRtnzINjCNuMFVYB8rJKiMBJgPbDbkAo4qsFYBSpDKzgxpmC8
         u8rv49y2xMFAHmtEvz0eRDt2Sd5p7YMHEXPSY6Hg6aIdKbve7rHsckmolWslVRGEgbnX
         Cq5A==
X-Gm-Message-State: AO0yUKWyq8phTtPKCFFMKLV2PyjMAmG0OOkFVMOnDvEKbjp6v13+Q/cA
        agXV8yGvz9bvOMPD6xDJoT8=
X-Google-Smtp-Source: AK7set/aNuIVedOzWF1NbBuhIitn6w3joEyjQQTw3I5a5T4DIpsqPLy8GASC15+FjFc7lLA1E1E0tA==
X-Received: by 2002:a05:6870:d287:b0:171:9a7c:c32b with SMTP id d7-20020a056870d28700b001719a7cc32bmr2333227oae.8.1676792005533;
        Sat, 18 Feb 2023 23:33:25 -0800 (PST)
Received: from localhost (227.sub-174-197-65.myvzw.com. [174.197.65.227])
        by smtp.gmail.com with ESMTPSA id t1-20020a05687044c100b00163b85ef1bfsm3434565oai.35.2023.02.18.23.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 23:33:25 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v10 0/3] cachestat: a new syscall for page cache state of files
Date:   Sat, 18 Feb 2023 23:33:15 -0800
Message-Id: <20230219073318.366189-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Changelog:
v10:
  * Reorder the arguments for archs with alignment requirements.
    (patch 2) (suggested by Arnd Bergmann)
v9:
  * Remove syscall from all the architectures syscall table except x86
    (patch 2)
  * API change: handle different cases for offset and add compat syscall.
    (patch 2) (suggested by Johannes Weiner and Arnd Bergmann)
v8:
  * Add syscall to mips syscall tables (detected by kernel test robot)
    (patch 2)
  * Add a missing return (suggested by Yu Zhao) (patch 2)
v7:
  * Fix and use lru_gen_test_recent (suggested by Brian Foster)
    (patch 2)
  * Small formatting and organizational fixes
v6:
  * Add a missing fdput() (suggested by Brian Foster) (patch 2)
  * Replace cstat_size with cstat_version (suggested by Brian Foster)
    (patch 2)
  * Add conditional resched to the xas walk. (suggested by Hillf Danton)
    (patch 2)
v5:
  * Separate first patch into its own series.
    (suggested by Andrew Morton)
  * Expose filemap_cachestat() to non-syscall usage
    (patch 2) (suggested by Brian Foster).
  * Fix some build errors from last version.
    (patch 2)
  * Explain eviction and recent eviction in the draft man page and
    documentation (suggested by Andrew Morton).
    (patch 2)
v4:
  * Refactor cachestat and move it to mm/filemap.c (patch 3)
    (suggested by Brian Foster)
  * Remove redundant checks (!folio, access_ok)
    (patch 3) (suggested by Matthew Wilcox and Al Viro)
  * Fix a bug in handling multipages folio.
    (patch 3) (suggested by Matthew Wilcox)
  * Add a selftest for shmem files, which can be used to test huge
    pages (patch 4) (suggested by Johannes Weiner)
v3:
  * Fix some minor formatting issues and build errors.
  * Add the new syscall entry to missing architecture syscall tables.
    (patch 3).
  * Add flags argument for the syscall. (patch 3).
  * Clean up the recency refactoring (patch 2) (suggested by Yu Zhao)
  * Add the new Kconfig (CONFIG_CACHESTAT) to disable the syscall.
    (patch 3) (suggested by Josh Triplett)
v2:
  * len == 0 means query to EOF. len < 0 is invalid.
    (patch 3) (suggested by Brian Foster)
  * Make cachestat extensible by adding the `cstat_size` argument in the
    syscall (patch 3)

There is currently no good way to query the page cache state of large
file sets and directory trees. There is mincore(), but it scales poorly:
the kernel writes out a lot of bitmap data that userspace has to
aggregate, when the user really doesn not care about per-page information
in that case. The user also needs to mmap and unmap each file as it goes
along, which can be quite slow as well.

This series of patches introduces a new system call, cachestat, that
summarizes the page cache statistics (number of cached pages, dirty
pages, pages marked for writeback, evicted pages etc.) of a file, in a
specified range of bytes. It also include a selftest suite that tests some
typical usage. Currently, the syscall is only wired in for x86
architecture.

This interface is inspired by past discussion and concerns with fincore,
which has a similar design (and as a result, issues) as mincore.
Relevant links:

https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04207.html
https://lkml.indiana.edu/hypermail/linux/kernel/1302.1/04209.html

For comparison with mincore, I ran both syscalls on a 2TB sparse file:

Using mincore:
real    0m37.510s
user    0m2.934s
sys     0m34.558s

Using cachestat:
real    0m0.009s
user    0m0.000s
sys     0m0.009s

This series should be applied on top of:

workingset: fix confusion around eviction vs refault container
https://lkml.org/lkml/2023/1/4/1066

This series consist of 3 patches:

Nhat Pham (3):
  workingset: refactor LRU refault to expose refault recency check
  cachestat: implement cachestat syscall
  selftests: Add selftests for cachestat

 MAINTAINERS                                   |   7 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/compat.h                        |   4 +-
 include/linux/fs.h                            |   3 +
 include/linux/swap.h                          |   1 +
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mman.h                     |   9 +
 init/Kconfig                                  |  10 +
 kernel/sys_ni.c                               |   1 +
 mm/filemap.c                                  | 158 +++++++++++
 mm/workingset.c                               | 142 ++++++----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 256 ++++++++++++++++++
 17 files changed, 564 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c


base-commit: 1440f576022887004f719883acb094e7e0dd4944
prerequisite-patch-id: 171a43d333e1b267ce14188a5beaea2f313787fb
--
2.39.1
