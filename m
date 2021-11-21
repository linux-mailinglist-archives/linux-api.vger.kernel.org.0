Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B5458687
	for <lists+linux-api@lfdr.de>; Sun, 21 Nov 2021 22:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhKUVXu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 21 Nov 2021 16:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKUVXu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 21 Nov 2021 16:23:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239EC061574
        for <linux-api@vger.kernel.org>; Sun, 21 Nov 2021 13:20:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h24so12196552pjq.2
        for <linux-api@vger.kernel.org>; Sun, 21 Nov 2021 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MhUzbKs/SChoSvLqGymUTLX20vHnAWWvvrY4L2Mof+U=;
        b=SVWBJ+zIwM2mq1uNZe30jbwEJn1x3vDPpBNeC6wEf1wmnn3HSXj3zU2q0jqOnwKFK2
         l0m4Gk4LX2NoKDwOTk/Dr3aVSE0zmQkkzFXqzgfoApAP+MRw7RNZetqDU1Wevig6WSlZ
         i4w1T3iGGt2u+zG0esS1CVuoZPzi3I3K8e8FIWDCgn5ijT9JlgRCuoNtt4dwSzXE70MS
         u1QW7BE8uQCxuxgia2LLzAqsVUrovRL/xIvP3osOchYgoDa3iRiaiUDFKaUhCyOZSvwi
         SrmC0CPfZgy7pbaoUCAg0NF7UWoEhq7qz2TazfXtMhWWYim+PyID7SJZadrf/SsQB67q
         wXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MhUzbKs/SChoSvLqGymUTLX20vHnAWWvvrY4L2Mof+U=;
        b=xDi3d5aUb4dAAbbtISq83uMfDp2QtXSCSIgKVTfiQ9WJ2/tiaQqr54bF4cGcU/2vOQ
         c6xrnfjg5Te75ayyD/Dm/T44dp7meyOCbPgVCFgS6xn1QQEca21vo0qteEp/0fBTuu4c
         QpQPGw0Mma5mCKY8RpYBYTZwwrAL0rV7NJL7EoH3N2vDEFHFLMbIU6/Gzw1PauMptvv0
         cfBXCSLIgbmpuIuFsQyGT9PLXuRvRGswvH4Et4WTsMOHqq9zJllsvxjqthuEFdc1VvQ5
         FdyYInzabY4NRAIDfaQebjlufyv2ExWctEIq3BvXbetUmFInkxt/FebSb4qrqRtxsrAR
         FYpg==
X-Gm-Message-State: AOAM530JKYAUdDn3Qh3HJEpSNLbIIPT8XD9C2W20WVmkOYAgECP3eB28
        LWdAW1pvVB2Psz6kvN8RCpIgdw==
X-Google-Smtp-Source: ABdhPJy5687jw03NISdBUoXI2Ay0BajbQGzxG3rxk1ppq7ocA010bJmxzfelJXIT2fLi76CgA0x1PA==
X-Received: by 2002:a17:90b:4b48:: with SMTP id mi8mr24688165pjb.214.1637529644363;
        Sun, 21 Nov 2021 13:20:44 -0800 (PST)
Received: from posk-p1g4.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id k8sm6207924pfu.75.2021.11.21.13.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 13:20:43 -0800 (PST)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH v0.9 0/6] sched,mm,x86/uaccess: implement User Managed Concurrency Groups
Date:   Sun, 21 Nov 2021 13:20:34 -0800
Message-Id: <20211121212040.8649-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

User Managed Concurrency Groups (UMCG) is an M:N threading
subsystem/toolkit that lets user space application developers implement
in-process user space schedulers.

This patchset is v0.8 rebased on top of the current tip/sched/core,
with a fix in umcg_update_state of an issue reported by Tao Zhou.

Key changes from patchset v0.7:
https://lore.kernel.org/all/20211012232522.714898-1-posk@google.com/:

- added libumcg tools/lib/umcg;
- worker "wakeup" is reworked so that it is now purely a userspace op,
  instead of waking the thread in order for it to block on return
  to the userspace immediately;
- a couple of minor fixes and refactorings.

These big things remain to be addressed (in no particular order):
- support tracing/debugging
- make context switches faster (see umcg_do_context_switch in umcg.c)
- support other architectures
- cleanup and post selftests in tools/testing/selftests/umcg/
- allow cross-mm wakeups (securely)


Peter Oskolkov (6):
  sched/umcg: add WF_CURRENT_CPU and externise ttwu
  mm, x86/uaccess: add userspace atomic helpers
  sched/umcg: implement UMCG syscalls
  sched/umcg, lib/umcg: implement libumcg
  sched/umcg: add Documentation/userspace-api/umcg.txt
  sched/umcg, lib/umcg: add tools/lib/umcg/libumcg.txt

 Documentation/userspace-api/umcg.txt   |  598 ++++++++++++
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 arch/x86/include/asm/uaccess_64.h      |   93 ++
 fs/exec.c                              |    1 +
 include/linux/sched.h                  |   71 ++
 include/linux/syscalls.h               |    3 +
 include/linux/uaccess.h                |   46 +
 include/uapi/asm-generic/unistd.h      |    7 +-
 include/uapi/linux/umcg.h              |  137 +++
 init/Kconfig                           |   10 +
 kernel/entry/common.c                  |    4 +-
 kernel/exit.c                          |    5 +
 kernel/sched/Makefile                  |    1 +
 kernel/sched/core.c                    |   12 +-
 kernel/sched/fair.c                    |    4 +
 kernel/sched/sched.h                   |   15 +-
 kernel/sched/umcg.c                    |  949 +++++++++++++++++++
 kernel/sys_ni.c                        |    4 +
 mm/maccess.c                           |  264 ++++++
 tools/lib/umcg/.gitignore              |    4 +
 tools/lib/umcg/Makefile                |   11 +
 tools/lib/umcg/libumcg.c               | 1201 ++++++++++++++++++++++++
 tools/lib/umcg/libumcg.h               |  299 ++++++
 tools/lib/umcg/libumcg.txt             |  438 +++++++++
 24 files changed, 4167 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/userspace-api/umcg.txt
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c
 create mode 100644 tools/lib/umcg/.gitignore
 create mode 100644 tools/lib/umcg/Makefile
 create mode 100644 tools/lib/umcg/libumcg.c
 create mode 100644 tools/lib/umcg/libumcg.h
 create mode 100644 tools/lib/umcg/libumcg.txt


base-commit: cb0e52b7748737b2cf6481fdd9b920ce7e1ebbdf
--
2.25.1

