Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD818176410
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 20:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCBTgn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 14:36:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40532 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCBTgm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 14:36:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id l184so201344pfl.7;
        Mon, 02 Mar 2020 11:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMbLmFmNY35d4+zrcJ8Avt+7fb1SsJEUi6gGO52WjWM=;
        b=pUVh3p06Aoy9RRjjq34SFPs3RDs/FzYH69zh3n/FTfYt4cekg/L3kDChQKj/3M4mV+
         2nVUAWk7A4aSemBgcQlUqi66yqReBaGo7nPgRkL24RslGjF/u9bqQuqRmhrulJM7HEmm
         vcYrtrvyHvD2bCp1w2FwTgD0OENMZdVu/USGlZ4AQBjAH82xb6Q+tOi4JPEwPJAnwsKc
         oAThkgchJPGnT0OV2KxRy31qlWtXSbxP4c84Vz0WOz4o6SZK6gGEwaSvp8+EY4X76zTD
         BOIaJhrHjd/n7RoATCDRYoyX43h+op6375Qw/uicgaHPtNQ3D1kjU2/8Rav5wizf0qAz
         2FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kMbLmFmNY35d4+zrcJ8Avt+7fb1SsJEUi6gGO52WjWM=;
        b=idBOWej4qMBCfnkvAlsK+ZJ3AgYa7rsqcm340O06LEtCFVAvyhVV7Ssz9pv9fmGpw9
         cuq0IZpjR0VY0QDEy1t4dBAImtYPu7JrOdGBVrvoy/yyAMr3dLaQkZRj9ZU3NbQOA/Jm
         EzezZqsrOSw8miRVCvlBuBbp5K6Z6jVyDuTgZX+3aovGHZxc8mPFOp9Gl7/QEA3OoKTc
         CPjnGJbioObqju+WhnucvGjF90recUNez9bTuFh/HlBBpgk+VcDOKinadeho2wUHxA7l
         b2mswIPTL6XLzmlAqvdg2ZoE1GhaFhgc+pZwtdYzqANvdBVbMtN9GTYuXM7CWf2EJltA
         ZSFA==
X-Gm-Message-State: ANhLgQ1yQ5nS++0yIuq63ERKCDFJs+5kq7FvgHFKtO15ZHfWc7qCGpda
        /kL5Ya+Mmt2q5/pB6s7PIFQ=
X-Google-Smtp-Source: ADFU+vvFSAjP3wLA8JL6Rsi8dQuGLmQfq9SZDJpyKlY+BZNzsfIB/vBgpw1uEf3g35MTcy+Ut7np3A==
X-Received: by 2002:a62:ed0b:: with SMTP id u11mr563966pfh.46.1583177800544;
        Mon, 02 Mar 2020 11:36:40 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id hg6sm35441pjb.22.2020.03.02.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:36:39 -0800 (PST)
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
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v7 0/7] introduce memory hinting API for external process
Date:   Mon,  2 Mar 2020 11:36:23 -0800
Message-Id: <20200302193630.68771-1-minchan@kernel.org>
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

* from v6 - https://lore.kernel.org/linux-api/20200219014433.88424-1-minchan@kernel.org/
  * fix comments and descriptions - Suren
  * Add Reviewed-by - Suren
  * fix build break reported by 0-day

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

