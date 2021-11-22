Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1400E459673
	for <lists+linux-api@lfdr.de>; Mon, 22 Nov 2021 22:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhKVVQk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Nov 2021 16:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbhKVVQj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Nov 2021 16:16:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC8CC061574
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 13:13:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x7so14885648pjn.0
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSZbIIJ12X4cKbIfk8F4IXpXcCyw8aHucx8N+UnZR24=;
        b=KSoGHvCiWAIB/jwJ7MpdQKfFN3d1mvwbSqjegT4yVZLZ2maZHiuoxS93G/d3WVUgAt
         CF2P2NtagWfkNRcbxnV0kPy08IxVJC3pldLpb92wGlS9rJ7qdu2Izik1mhoBdERcx/EM
         BTOz2zUwxuR21uy8x/Xm9jVgHFNF2956x7V+mLChz+hGBaHmv1Z24O05hEUaDPrFz5eF
         bPkVfc2mb5b2/txxc+aPHlMtBW+O2EVQwb33zZMMqC/oPgGQ73mOo5EzoVaMuIGKO9b8
         EklelsTy4ki7wVeAIc2X14R6f/m/DWVFyvkUJ3dPVrfv4F8oQ42pGSZViv+N+ORRr2yS
         PcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSZbIIJ12X4cKbIfk8F4IXpXcCyw8aHucx8N+UnZR24=;
        b=zh935CMhwYErJyJLJj34nU3z+bfojMMgmLlLVMV3QtU5Uxrd12hfeA39s9Zr/wgNjp
         z9sd6oGxEwoLXbabmx8KiVHOZ+wQ/x40UBFMdy7zdppi7UC8Ejgsh2E7XHQRNksnxsAJ
         aYX54RHjAH2jzoUIO3yHjTgDmSHwJggGzQf14HSPRSbwJGONb+aOh2y65nlz3dLcBQzW
         dAEJl3sgKlVJ9FxVfq8RTOT+M9pBF25QJy5kdDQX4vt836ogrrLB1jYPA7bsiNMC9sbC
         /XdM4S15442MXhI9TJYjO/ZwPVzrL2r15LCqLBqJqfWWXcciS9yetiW0ePxIbh+BUqis
         wi6w==
X-Gm-Message-State: AOAM533BVVk1GfTdR7Yli4LOM0UJiZ9QEGg9GbsdbPgROQ2yYQh5MI8i
        sCI1kkMXpHwoZv1ykEsXug6EVA==
X-Google-Smtp-Source: ABdhPJzF/NM3OBcyfx8JimuF5YAQlD65oBAF4tFkp+dTome7P7AIGUYAxriUt8BsU9JswlMN1l5Ifg==
X-Received: by 2002:a17:903:248c:b0:142:9bf:8b0 with SMTP id p12-20020a170903248c00b0014209bf08b0mr111356plw.70.1637615611410;
        Mon, 22 Nov 2021 13:13:31 -0800 (PST)
Received: from posk-p1g4.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id h3sm10453671pfi.207.2021.11.22.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:13:30 -0800 (PST)
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
Subject: [PATCH v0.9.1 0/6] sched,mm,x86/uaccess: implement User Managed Concurrency Groups
Date:   Mon, 22 Nov 2021 13:13:21 -0800
Message-Id: <20211122211327.5931-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

User Managed Concurrency Groups (UMCG) is an M:N threading
subsystem/toolkit that lets user space application developers implement
in-process user space schedulers.

This v0.9.1 patchset is the same as v0.9, where u32/u64 in
uapi/linux/umcg.h are replaced with __u32/__u64, as test robot/lkp
does not recognize u32/u64 for some reason.

v0.9 is v0.8 rebased on top of the current tip/sched/core,
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
 tools/lib/umcg/libumcg.c               | 1202 ++++++++++++++++++++++++
 tools/lib/umcg/libumcg.h               |  299 ++++++
 tools/lib/umcg/libumcg.txt             |  438 +++++++++
 24 files changed, 4168 insertions(+), 12 deletions(-)
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

