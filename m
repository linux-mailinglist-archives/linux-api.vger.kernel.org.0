Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFCF15E935
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392573AbgBNRFm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 12:05:42 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53396 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbgBNRFl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 12:05:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so4123966pjc.3;
        Fri, 14 Feb 2020 09:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNlByY054icvI6mdU8f/7zppc96H8+Hj/ekQYXNSLtg=;
        b=PG+iPDIXxskkfRMUJ5ywooQu/7tHQ1k/SbkMSTelZdJJeTH0qzLSJkj+/qtsJzLqdr
         S3D3du4ZMClP79gCmH6VSQSPbbZigTC+l5VqHDNKWrELIJxIT6eNruvuM9alnMAZndw2
         6x+u3omu+FlPlk9VkvEcK/PMhps3ZQS8xDr9nok8CQnEEYcWAjXJAcdgHwbfa4IZQafP
         Co1xKRyGEodbKPlyK3W9i/B2x5xd3KmLjPamuSYPWlOQJHGwX9ashaFJX+Eggk65H+CL
         bopnx+uS8t+WMMpJ0IE+FtB2Zm3oGgKHCbCZidQPVKoI1nUK7EFQQONb1iYi1PH6LMTZ
         l7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DNlByY054icvI6mdU8f/7zppc96H8+Hj/ekQYXNSLtg=;
        b=RkwC7xM8qzGjlJ15CkctX5+bXEuTn75Vj1CSt7I3sRmPGtCIBPhn3K8009uco42q5h
         UuZBp5nDVs8jNNTmqMLhC92LmmeS4pd3pkiAv8gayZwNcEmx2dF9VRCLw9KDpl8UQbJ2
         Koz9ymx/7Sgj5opYJnAR5nA67Zxsc2mUgnSLRvuXR7suSfZRW6jZguVQZRcBnUn275x/
         J8+cqL0WzlZcPfrh3Sj8uyG8hpLm10f/c1juLL5Ip+j9Obi2FXPhV+4hsy6LdfecYvmA
         u0ljzmOZdjvttJ6XaraSDQcgW/wCFDgTFaRS830BDb+cVlWZyddSvNUJzY/sdh0xf4DS
         X8Xg==
X-Gm-Message-State: APjAAAXjK5R0PONWBv4eoH26e/X3Ym6HEOXSXiexpOAEcXb4F5+WE/Un
        19g3FXDS6iXKMhKWtUwrsUE=
X-Google-Smtp-Source: APXvYqwVi2UegPb1oX4Cfj9nK1b3+YMr3+jpWlK6EWbFDOQEPfELPcREZMhSMA5sDOLmJmNAcaykfg==
X-Received: by 2002:a17:90a:c708:: with SMTP id o8mr4872545pjt.104.1581699940461;
        Fri, 14 Feb 2020 09:05:40 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a13sm7662924pfg.65.2020.02.14.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 09:05:34 -0800 (PST)
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
Subject: [PATCH v5 0/7] introduce memory hinting API for external process
Date:   Fri, 14 Feb 2020 09:05:13 -0800
Message-Id: <20200214170520.160271-1-minchan@kernel.org>
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
  pid: export pidfd_get_pid
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
 mm/madvise.c                                | 142 ++++++++++++++++----
 26 files changed, 165 insertions(+), 44 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

