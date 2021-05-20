Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08638B623
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhETShn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhETShm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C397C061760
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v184-20020a257ac10000b02904f84a5c5297so23737088ybc.16
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y3E/s//jSqmr2fRbZ7hJsOKlIWD8vy2UGKXjvIPsYz0=;
        b=dvvcwuOwQ1etb2yg4Mmpz4XeM/8+ySJaOHOr1gM86Qo9W/48I9TARULwV/lVCORjxJ
         +oMnk/TaZMBlzBbfEsM8yI7MqNkr5B6NA73E09y7D+uB9m+oqTK7kC7U+50GtlCUmYMV
         YG5q/aY6/mcVrqYK1PuqCd2cteWBnYCdksEBGcoHvrVyI/iYnrFpMBhOBh5tW88osCvH
         gZVvfZTgRmx2Mm3N7om497biSj7/aEZw+HSgm7356PfeciivgzWoKilYtt2rSPuOsr0a
         Vf8vV0feJsl+/90eu9QabJNMIccWlx2B/CzPqQSzBeQeij2K7zHttz/UApik/Z51pp9l
         JmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y3E/s//jSqmr2fRbZ7hJsOKlIWD8vy2UGKXjvIPsYz0=;
        b=C4d7QCApzfbeOdDjrDpR2TUVbWxvmXp+xMw97+avTR0EtiZbnis+Mx1phzuXIiWPvJ
         4ldPlrwEeM9HhULCWYENDDWGoFa2f3eeBSy3VpcPBjeKTCiY0MnU4Iw/SqU1xoMoNYEH
         K843wr4unXR4QgttPvSlPWwe0MEeF2p2vfBoaxxN/78YeqFIxy3WJ6UQhwLD8HnijlFD
         cz9Lh+bh2ixPI4hRDJWuiwHiRWJYLNTywPYfZsCTFoQPEA9FkxasbQT95ieLAlYqaMXp
         4KEkg94dyQJCeeoDOnGbWmZBz6KaM+BcI3v8TPP+0QnULBu9HAXqMGMVd4TdfbhLsA5O
         qaGg==
X-Gm-Message-State: AOAM5325JxG9+cTn9I708JC90hgnGNfeyF+JWjIYGyE/q4krnQLMYui1
        OoBYZXWSUI1DYDVB3K+mrXuyj5T4
X-Google-Smtp-Source: ABdhPJzZCcXASkNwHd8nRTCHe6xe24/QF3Drz0lv3ukNETTNPqiXSf3LW5YEfINbHHHOHps6bSrNU8Fr
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a25:6c07:: with SMTP id h7mr9338929ybc.317.1621535779774;
 Thu, 20 May 2021 11:36:19 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:05 -0700
Message-Id: <20210520183614.1227046-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As indicated earlier in the FUTEX_SWAP patchset:

https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/

"Google Fibers" is a userspace scheduling framework
used widely and successfully at Google to improve in-process workload
isolation and response latencies. We are working on open-sourcing
this framework, and UMCG (User-Managed Concurrency Groups) kernel
patches are intended as the foundation of this.

This patchset is "early preview/RFC" - an earlier version of the
"core UMCG API" was discussed offlist, and I was asked to post
"what I have" to LKML before I consider the work ready for a full
review.

Notes:
- the first six patches cover "core UMCG API" and are more "ready"
  than the last three, in the sense that I expect to see few, if any,
  material changes to them, unless the whole approach is NACKed;
- the last three patches cover "server/worker UMCG API" and need
  more work and testing:
  - while I'm not aware of any specific issues with them, I have not
    implemented and/or tested, yet, many important use cases, such as:
    - tracing
    - signals/interrupts
    - explicit preemption of workers other than cooperative wait/swap
  - comments/documentation is missing in many important places, or
    maybe even wrong/outdated.

As such, please pay more attention to the high-level intended behavior
and design than to things like patch organization, contents of commit
messages, comments or indentation, especially in the last three patches.

Unless the feedback here points to a different approach, my next step
is to add timeout handling to sys_umcg_wait/sys_umcg_swap, as this
will open up a lot of Google-internal tests that cover most of
use/corner cases other than explicit preemption of workers (Google
Fibers use cooperative scheduling features only). Then I'll
work on issues uncovered by those tests. Then I'll address preemption
and tracing.


This work is loosely based on Google-internal SwitchTo and SwitchTo
Groups kernel patches developed by Paul Turner and Ben Segall.

Peter Oskolkov (9):
  sched/umcg: add UMCG syscall stubs and CONFIG_UMCG
  sched/umcg: add uapi/linux/umcg.h and sched/umcg.c
  sched: add WF_CURRENT_CPU and externise ttwu
  sched/umcg: implement core UMCG API
  lib/umcg: implement UMCG core API for userspace
  selftests/umcg: add UMCG core API selftest
  sched/umcg: add UMCG server/worker API (early RFC)
  lib/umcg: add UMCG server/worker API (early RFC)
  selftests/umcg: add UMCG server/worker API selftest

 arch/x86/entry/syscalls/syscall_64.tbl        |   11 +
 include/linux/mm_types.h                      |    5 +
 include/linux/sched.h                         |    7 +-
 include/linux/syscalls.h                      |   14 +
 include/uapi/asm-generic/unistd.h             |   25 +-
 include/uapi/linux/umcg.h                     |   70 ++
 init/Kconfig                                  |   10 +
 kernel/fork.c                                 |   11 +
 kernel/sched/Makefile                         |    1 +
 kernel/sched/core.c                           |   17 +-
 kernel/sched/fair.c                           |    4 +
 kernel/sched/sched.h                          |   15 +-
 kernel/sched/umcg.c                           | 1114 +++++++++++++++++
 kernel/sched/umcg.h                           |   96 ++
 kernel/sys_ni.c                               |   13 +
 mm/init-mm.c                                  |    4 +
 tools/lib/umcg/.gitignore                     |    4 +
 tools/lib/umcg/Makefile                       |   11 +
 tools/lib/umcg/libumcg.c                      |  572 +++++++++
 tools/lib/umcg/libumcg.h                      |  262 ++++
 tools/testing/selftests/umcg/.gitignore       |    3 +
 tools/testing/selftests/umcg/Makefile         |   15 +
 tools/testing/selftests/umcg/umcg_core_test.c |  347 +++++
 tools/testing/selftests/umcg/umcg_test.c      |  475 +++++++
 24 files changed, 3096 insertions(+), 10 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c
 create mode 100644 kernel/sched/umcg.h
 create mode 100644 tools/lib/umcg/.gitignore
 create mode 100644 tools/lib/umcg/Makefile
 create mode 100644 tools/lib/umcg/libumcg.c
 create mode 100644 tools/lib/umcg/libumcg.h
 create mode 100644 tools/testing/selftests/umcg/.gitignore
 create mode 100644 tools/testing/selftests/umcg/Makefile
 create mode 100644 tools/testing/selftests/umcg/umcg_core_test.c
 create mode 100644 tools/testing/selftests/umcg/umcg_test.c

-- 
2.31.1.818.g46aad6cb9e-goog

