Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44F8204053
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 21:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgFVT3N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 15:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgFVT3M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 15:29:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B606C061573;
        Mon, 22 Jun 2020 12:29:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so3424359pgc.5;
        Mon, 22 Jun 2020 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weFW+qBZEi0cjMZ8qKBQnrqgCTJqFGMu4e+wMxpY3S0=;
        b=hOHzZhnjPlVmB1AgzeDEpstCV1xfdjrYDO6AA94oOzYU+zA51t/S6ljcFBEau4qMa0
         BsvmBQd0s7lyOaJO17brRHx/rKD5X8w9joeMEqDt6hl3p5Gc/7weN30i8amCtoU1GXgj
         wN4ubXQaixPbfVkRu47J/wD+RtYmL4LQpTtfUdBbIRTUFqGE+3BuWmb5b3lm46Jb3eoD
         nFJ5hWenHRXHY+bHEQTbSuUIt+ph8vnfLPJGBW8wW2zGCCSG6X/M2c1o7phpj2ZuKqGC
         8+kVSaQ1fcNlZFxxsNPUZ8z2e8XeRnkC6u3NvbZ7oYcg8JTWaft30Ob0Kq5Hvbo1ymSa
         2Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=weFW+qBZEi0cjMZ8qKBQnrqgCTJqFGMu4e+wMxpY3S0=;
        b=WeoLH8Ifma99128/j4vstF85Ad2X5rK9iIzu5IzMKLWThbbG67tMvFoGyvMFPaFhBN
         oxFS36IdM/tut8OY/6fAq2/2B82Qbf1aTzFjGUp8MkWQ87Hxav0v71aLmMTXwCUSlZeW
         JXc6A/vjaGThukHh3TCqNBmC09Ex/YmW5eWutTwRsHQYZh6R2wtmShGBU4B1Zrfv6cuM
         Xz6aYF7BURQP+UJ+SABibQ4BUzgGEX1GLYyH3s4EB+fok3sef7B5jtA4xkO6o9wPCRsv
         +Ikt/bEuc2fgeqXD2PXnf8Q3H2l6CzStKXzipzO3CeMMzuhANHzMTdxyZIZ+azVJ/aej
         tjDg==
X-Gm-Message-State: AOAM531KgB0pD0enm31sFW3Z/wxIg0In+2OBkgzB5dvlmVBmTQ89IQ1Q
        9qp0lb0qMXCElyj+b7Sv3LUT3KbF
X-Google-Smtp-Source: ABdhPJzFByGxHqIqF8a8PWWKyVKm/TgcNYGpi4+R2KSq9pZvcj79Qg87brfTOkdQg+2rJVHd2ZlhZw==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr14727856pgp.333.1592854151907;
        Mon, 22 Jun 2020 12:29:11 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id mu17sm264603pjb.53.2020.06.22.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:29:10 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
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
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v8 0/4]  introduce memory hinting API for external process
Date:   Mon, 22 Jun 2020 12:28:56 -0700
Message-Id: <20200622192900.22757-1-minchan@kernel.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
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
2. It supports only MADV_{COLD|PAGEOUT} at this moment.
   Other hints in madvise will be opened when there are explicit requests from
   community to prevent unexpected bugs we couldn't support.
3. Only privileged processes can do something for other process's address
   space.

For more detail of the new API, please see "mm: introduce external memory hinting API"
description in this patchset.

* from v7 -  http://lore.kernel.org/r/20200302193630.68771-1-minchan@kernel.org
  * dropping pid support from new syscall and fold releated patches into syscall patch
  * dropping KSM patch by discussion - Oleksandr, I lost the discussion.
    Please resend the single patch against of the patchset if you resolves the discussion.
    https://lore.kernel.org/linux-api/20200302193630.68771-8-minchan@kernel.org/

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

Minchan Kim (4):
  mm/madvise: pass task and mm to do_madvise
  pid: move pidfd_get_pid() to pid.c
  mm/madvise: introduce process_madvise() syscall: an external memory
    hinting API
  mm/madvise: check fatal signal pending of target process

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/io_uring.c                               |   2 +-
 include/linux/compat.h                      |   4 +
 include/linux/mm.h                          |   3 +-
 include/linux/pid.h                         |   1 +
 include/linux/syscalls.h                    |   2 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/exit.c                               |  17 --
 kernel/pid.c                                |  17 ++
 kernel/sys_ni.c                             |   2 +
 mm/madvise.c                                | 190 +++++++++++++++++---
 28 files changed, 217 insertions(+), 46 deletions(-)

-- 
2.27.0.111.gc72c7da667-goog

