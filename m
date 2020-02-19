Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34EEC16397D
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 02:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBSBoi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 20:44:38 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51911 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgBSBoi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 20:44:38 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so1861729pjb.1;
        Tue, 18 Feb 2020 17:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jexvvsJg+MaDHz4Tc7pcFF//GHPzAbjYjk1o03WxMjk=;
        b=OOtOyOOiA/Z2sEg/9aLi0DEKLDWgMMh0gloywbMYa0ILzbiUUwIiNhq9/UmbTaKmN1
         fHvjq++7nDH89D9L/zUWlcWbDaUZ77cSQ1FLA8bHVVHDqBcvA7HDC/dzjGwTo9UTydB8
         oGCSX7p3/ykmkgnUlhOrPIy9NG8TGJLvT0fh0xqgIKi+kIFllCpzN8shnF6XXHa29Jpk
         owOEf5MIcd1jBbBTehuxfxDAu40WX3QPMzKj9QnidLPDBsHND2lYL82hjXp9r5k2LeUJ
         o6MYQxk4C/GFDCapJAaHhDCsjAIc/wz96owcRuNe/Qg4QiA/JmiyOlT7YoBGuag74qYF
         OCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jexvvsJg+MaDHz4Tc7pcFF//GHPzAbjYjk1o03WxMjk=;
        b=Jku3RgMAwWbDMejBlVcDHci2Z+V4o+vTxx1UnyqNDn2EC3//ShHl8ekpSkOFXLXclT
         YZ8EbdQ/mDEtV1n+EOrWz2Fo+bK5NWm9egzujyiHyMXAwmHO/2Y/YGoKYIEynhThe8QW
         95KvsRG7L+IJ9eu4v4uBsU3tE+Gvm2Ta7BhzBYRSnWewVHd9HzCuVTl1IPAu8kxrNEPS
         IqMOFgySZ5nCBtmja9yCIlBNCcgCuExxztR3nOPSlB/mNzofGVUAs1Kei5893BSes51H
         yyN2LMKX7VDvwkG6MOIfO0+ZCvuQGl9vmn/3Xhenw2iDq5EXVKLP60ePRa4iRAOxndWA
         0avg==
X-Gm-Message-State: APjAAAUr27ovScddgXaEUlCCWpRNOOaXtRAEcP1/2nkExH+rtO2so6KB
        BAeEkiWelVO4dKpZ0T2HByM=
X-Google-Smtp-Source: APXvYqzSzVk5xtTCn6Y0eWG7homfmpB0LfjG1wXXG9Gh5SqfXEE4253LF8S/uxor/szQK15/b1qCnw==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr6336196pjn.59.1582076677219;
        Tue, 18 Feb 2020 17:44:37 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t186sm221192pgd.26.2020.02.18.17.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:44:36 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v6 0/7] introduce memory hinting API for external process
Date:   Tue, 18 Feb 2020 17:44:26 -0800
Message-Id: <20200219014433.88424-1-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
application could give hints to kernel what memory range are preferred to be
reclaimed. However, in some platform(e.g., Android), the information
required to make the hinting decision is not known to the app.
Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
and that daemon must be able to initiate reclaim on its own without any app
involvement.

To solve the concern, this patch introduces new syscall - process_madvise(2).
Bascially, it's same with madvise(2) syscall but it has some differences.

1. It needs pidfd of target process to provide the hint
2. It supports only MADV_{COLD|PAGEOUT|MERGEABLE|UNMEREABLE} at this moment.
   Other hints in madvise will be opened when there are explicit requests from
   community to prevent unexpected bugs we couldn't support.
3. Only privileged processes can do something for other process's address
   space.

For more detail of the new API, please see "mm: introduce external memory hinting API"
description in this patchset.

* from v5 - https://lore.kernel.org/linux-mm/20200214170520.160271-1-minchan@kernel.org/
  * use null task and requestor's mm for io_madvise - Jann and Jens
  * use right commit description for moving pidfd_get_pid - Christoph

* from v4 - https://lore.kernel.org/linux-mm/20200212233946.246210-1-minchan@kernel.org/
  * pass mm down to functions, not accessing task->mm - Jann
  * clean up - Alexander
  * add Reviewed-by - Alexander, SeongJae
  * patch reordering

* from v3 - https://lore.kernel.org/linux-mm/20200128001641.5086-1-minchan@kernel.org/
  * verify task->mm aftere access_mm - Oleg
  * split some patches for easy review - Alexander
  * clean up fatal signal checking - Suren

* from v2 - https://lore.kernel.org/linux-mm/20200116235953.163318-1-minchan@kernel.org/
  * check signal callee and caller to bail out - Kirill Tkhai
  * put more clarification for justification of new API

* from v1 - https://lore.kernel.org/linux-mm/20200110213433.94739-1-minchan@kernel.org/
  * fix syscall number - SeongJae
  * use get_pid_task - Kirill Tkhai
  * extend API to support pid as well as pidfd - Kirill Tkhai


Minchan Kim (5):
  mm: pass task and mm to do_madvise
  mm: introduce external memory hinting API
  mm: check fatal signal pending of target process
  pid: move pidfd_get_pid function to pid.c
  mm: support both pid and pidfd for process_madvise

Oleksandr Natalenko (2):
  mm/madvise: employ mmget_still_valid for write lock
  mm/madvise: allow KSM hints for remote API

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/io_uring.c                               |   2 +-
 include/linux/mm.h                          |   3 +-
 include/linux/pid.h                         |   1 +
 include/linux/syscalls.h                    |   3 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/exit.c                               |  17 ---
 kernel/pid.c                                |  17 +++
 kernel/sys_ni.c                             |   1 +
 mm/madvise.c                                | 144 ++++++++++++++++----
 26 files changed, 167 insertions(+), 44 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

