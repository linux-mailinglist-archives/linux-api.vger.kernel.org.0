Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A152B25849F
	for <lists+linux-api@lfdr.de>; Tue,  1 Sep 2020 02:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgIAAHs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 31 Aug 2020 20:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgIAAHr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 31 Aug 2020 20:07:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511ABC061573;
        Mon, 31 Aug 2020 17:07:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so1632276pfi.4;
        Mon, 31 Aug 2020 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qhlsr+suuDkN/ZVkq37k+a1bP/C6TH/jBPPik3MNM3E=;
        b=VBhEdOAw9J6tfskz+U2eNtrKbJi9CZSc9QFc49BdI8wskdNqDi3UDJc7R2gQkJGA2k
         ZXVCADlVT2TJgZ1mxBun3T0kTRN03VOgEyK4RBqFS7TmdU/TUfFxKtHslManRVHqJEjQ
         ADI3FUK+jFBYtHyOVD//c5KVHMgqy5ZdfDwT2rnTwqjFgUD6Fzzv1RY7m24RIxh/QM0X
         FrjsdzDX7No/55e5OXCdOCBe8Gh0Dfqo/zgePKKEk9S1rn0lmrGCuQrpQTKvx6PUN0s3
         me9PTx/goe1rFzqvjXcfEKJdKJCZ8yHmcxzWQCV48Wv+Sjt3FeA5p61D90tmorZC/S4v
         eYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Qhlsr+suuDkN/ZVkq37k+a1bP/C6TH/jBPPik3MNM3E=;
        b=jldyPYSZvqnCwAWZxjUj0nFiVSQn6tr6Owai1/MKIjiHkxuXomrBrUiCYWMUA8kUbW
         1GI1IZ5Pd4o4O5sZ7lUzqmHu/yGoRRiaYgf0jERlAEz7uFdblSmXH2twVXM39kWMHqzG
         PN+nMfU88nGeGMwnKmfjT4EQHPoYw4c4I//7nTYLfGx93aa0SLOdbego/6/4UAc//6Qa
         3S9CKUL+5noJA7m+S6/6dCTmHxMvegorOw/K4Z7Zt1CYX9Bbw5Gn6zz6hWFOhR0nO/7t
         /cunVYLRNEzJw4bzqwaINOQQFT/2yjPwUeTmamDF6m5jRukBLCnhFQOJPgXJDw8ScjuS
         Gg3Q==
X-Gm-Message-State: AOAM533QXWz/1bCRB5ckxDzmFbFjytuPJaAjONL3Zqjfp6Ia8kz+ebPP
        NNScIHz7BkMa6kjarmGe5EDByOau/f8=
X-Google-Smtp-Source: ABdhPJwTkw89fLl8yoCut62uET3njozAyscjbC1KEVyOrdhZDCNO99/4q/7r9iDjxjBzWeu/IF2zvA==
X-Received: by 2002:aa7:9910:: with SMTP id z16mr3322533pff.120.1598918866562;
        Mon, 31 Aug 2020 17:07:46 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id k5sm769777pjq.5.2020.08.31.17.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 17:07:45 -0700 (PDT)
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v9 0/3] introduce memory hinting API for external process
Date:   Mon, 31 Aug 2020 17:06:30 -0700
Message-Id: <20200901000633.1920247-1-minchan@kernel.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
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

* from v8 - https://lore.kernel.org/linux-api/20200622192900.22757-1-minchan@kernel.org/
  * drop passing task_struct to do_madvise - Linus
  * remove compat syscall entry - Christian
  * drop mmget_still_valid since we don't need any longer
    * https://patchwork.kernel.org/patch/11740595/

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
  * use right commit description for moving pidfd_get_pid - Christian

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

This patchset is against on v5.9-rc2-mmots-2020-08-30-18-40.

Minchan Kim (3):
  mm/madvise: pass mm to do_madvise
  pid: move pidfd_get_pid() to pid.c
  mm/madvise: introduce process_madvise() syscall: an external memory
    hinting API

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/io_uring.c                               |   2 +-
 include/linux/mm.h                          |   2 +-
 include/linux/pid.h                         |   1 +
 include/linux/syscalls.h                    |   2 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/exit.c                               |  17 ---
 kernel/pid.c                                |  17 +++
 kernel/sys_ni.c                             |   1 +
 mm/madvise.c                                | 141 ++++++++++++++++++--
 26 files changed, 171 insertions(+), 35 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

