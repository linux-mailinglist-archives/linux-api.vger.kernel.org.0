Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA4A15B4E0
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 00:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgBLXjv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 18:39:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32855 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgBLXjv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 18:39:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so2048757pgk.0;
        Wed, 12 Feb 2020 15:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=maCkSEFpOGFtAnibDn0I8ai2JTyywVBbgNcmf7oqPjw=;
        b=FRvI5l7pXfY+eb7PcI9dLXj2jZE2ViOj48HYHkHvl9gbl+eg9y7yYwPof96dHndGJ8
         mVYDf7GIi2wOFnw0VDodP6JaRiYGLdfMwRVBP303xxccf2pB/Q9Rg+qxfC4kiZ4yMecb
         smnEMiD1aP5+EYX5Zif2IjRtsYE+pm7X75oetFwJffJZ6iQAAw5hCew6o2cyTwflGcmt
         w5qymEz1NowkqfxQ5vvxdfGBTE88jTMzVr13h3aKLE0X3xzNiAbodJ8ayH6RzWQZLdYt
         QAKIWlpOtVFowSygIoiMEadNzuRWVxDL113fFBDwCEh6sGMEv0/Kpe/fUFEzWhI8sQKz
         OyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=maCkSEFpOGFtAnibDn0I8ai2JTyywVBbgNcmf7oqPjw=;
        b=VcSHpFNCU3wHFv+sOQC3E2iNE8JUrcqDmKex2RS27Ujw5NzfQpxY50ZyKqe507an+C
         ipbB7RsQvSXpQqyKn0SHs+VayWUq4y9wTRCuU+mUfY6U0ATGDbweC1FaXsaI9JGjLEp/
         M8Bm7F3i1nR5UErIZPHKA+c0NGyVbGQ8SOOS2DMW8UAyShDS1mAZ5AueT2+7BWKdVbnL
         egM2Qmx1x5b7hsMRMBcnnVmCqU/MmYkjlXtAU6zC4AlSNQTqEA8tbUZ4AuxkZHUsiLSO
         jpBRXSVtVXAJJSH7rRS2HXXocFZlhrDq17l3RaEQsaj9cjWDDwx7sWJEmDzn+p1h6qIZ
         rGwQ==
X-Gm-Message-State: APjAAAV2fRs/RdJcLiQmjbzJeCUE9y61Gb+EJd/6k9l/ONHsg9F8ATx8
        GyXdR2HKXb3+ye6958pzqpY=
X-Google-Smtp-Source: APXvYqyOU7R1CIXlJxfxeSynAEoVQtBrKo+86izmUdz3lEWoFckBWfx1cL3tXyX9kMspcBQkuKCG4w==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr10857499pfm.251.1581550790211;
        Wed, 12 Feb 2020 15:39:50 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k5sm296664pju.29.2020.02.12.15.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:39:49 -0800 (PST)
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
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 0/8] introduce memory hinting API for external process
Date:   Wed, 12 Feb 2020 15:39:38 -0800
Message-Id: <20200212233946.246210-1-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
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

Minchan Kim (6):
  mm: pass task to do_madvise
  mm: introduce external memory hinting API
  mm: validate mm in do_madvise
  mm: check fatal signal pending of target process
  pid: export pidfd_get_pid
  mm: support both pid and pidfd for process_madvise

Oleksandr Natalenko (2):
  mm/madvise: employ mmget_still_valid for write lock
  mm/madvise: allow KSM hints for remote API

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
 mm/madvise.c                                | 149 ++++++++++++++++----
 26 files changed, 170 insertions(+), 46 deletions(-)

-- 
2.25.0.225.g125e21ebc7-goog

