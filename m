Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E13C1A0D
	for <lists+linux-api@lfdr.de>; Thu,  8 Jul 2021 21:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhGHTt3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Jul 2021 15:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGHTt0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Jul 2021 15:49:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA82DC06175F
        for <linux-api@vger.kernel.org>; Thu,  8 Jul 2021 12:46:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so7411680pgv.3
        for <linux-api@vger.kernel.org>; Thu, 08 Jul 2021 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2tbsmsmlDRoopi/FhqV0EfeiFdZZDeCa4NXAauSAKU=;
        b=H5HBKbvvGFsGCvG69k0058xJDgg/GmZN/qRcMi1l3v+cGs+9HBjFhzKOjtbJKDaKYs
         3wldqKAthzTdW8QhASSj8wVGwOHAccaH0UAvjVNcj5ePUuQLHSkufEWBG8XoJc2AcNGL
         /5r3fTRDdPb3fjfmmDsiEJrUMVm77ZqypuZlrrnM6AEUYnjl2ML0LvUwhxg0AqMn3eA8
         pB17d7VbQPRzcp6nx/YDeHMIVDwruRfr2DIvoh2IE02nD9oPf1JQIC9WkXY+WPVKGs9T
         0f48amKvo+cZ6o3VahO1UFMpONaO87UaitBfbHLa9uJ21oTAX+L9zeubE7KTMVMA5yOS
         DwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2tbsmsmlDRoopi/FhqV0EfeiFdZZDeCa4NXAauSAKU=;
        b=hJjbHcM1mKG5AbElnZK3U9fw6a67XH3KSAAxvYHodgWN1F/pGGY5FLSgIPkIXbVyh+
         xwq6JKm6ehyefTsN3HuOrBVR1gOkeIqthCy00THmydntZsQUAxQEn+3556/IHgkj7hhT
         izb49hempInyH/LO/D1NZuVLedSzbX+DELdpOu38gvqYDd5Bqk4bb2y46KVvk30Z2vH/
         rn9t5nYQJJYATaaZP5lI2GspfspU8nRMmIlug+pRU49TwMGZJ0zIQQkTcpO7/Eg+Btxt
         A0yYptWDmz7cuQ+9vMyO4BkyCc0JrDIlCuS86XI0HTK6Z7xe/xZ4MXg8zNkej58Csa5L
         dbUg==
X-Gm-Message-State: AOAM531qcH16ujjMm/oUWdWOoo0Xw1AruGLtLjcn2lrX1nsXYGCxSaVl
        33OpASYGbYZ5i6D7w2qBM2/4Cw==
X-Google-Smtp-Source: ABdhPJwLnwQKPLwG23BBbW74R66Sp9qXaZ71vgpbzvoa+uGTojieRAMl+vGnXrAuGigpZiFQGdhuDQ==
X-Received: by 2002:a63:de18:: with SMTP id f24mr27846968pgg.112.1625773603274;
        Thu, 08 Jul 2021 12:46:43 -0700 (PDT)
Received: from localhost.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id v1sm3283176pjg.19.2021.07.08.12.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:46:42 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Subject: [RFC PATCH 0/3 v0.2] RFC: sched/UMCG
Date:   Thu,  8 Jul 2021 12:46:35 -0700
Message-Id: <20210708194638.128950-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is another attempt at implementing UMCG, based on
discussion in https://lore.kernel.org/patchwork/cover/1433967/

Most of the "why" is covered here (some details are obsolete):
https://lore.kernel.org/patchwork/cover/1433967/#1632328

At a high level, UMCG servers/workers provide the foundation
for an M:N threading library, as described in the link above.

In addition, servers without workers can be used as "basic"
UMCG tasks if wait/wake/context-switch are the only desired
operations.

Joel Fernandes has also once mentioned that he had a use case
for a wake+bring-the-wakee-to-the-current-CPU operation,
so this is now also supported via UMCG_WF_CURRENT_CPU flag
(patch 3).

Patch 1: add WF_CURRENT_CPU and tweak ttwu - same as last time
Patch 2: add X86_64 helpers to work atomically with userspace values
Patch 3: implement UMCG kernel-side

In this version of the patchset I used only userspace/TLS
data, as suggested by Peter Zijlstra. With the exception
of one issue (see patch 3 commit message) everything seems
to be working great.

This TLS-only approach makes the userspace code a bit more
involved, so I'm not posting libumcg/selftests with this
patchset to focus on the kernel side only.


TODO:
  - put atomic helpers from patch 2 into their proper place (unless
    keeping them in kernel/sched/umcg.h is OK)
  - fix the wake server issue in preempt disable block (see patch 3)
  - implement timeout handling
  - imlement worker preemption
  - more testing
  - manpages, docs, and similar
  - attach libumbc and selftest patches


Peter Oskolkov (3):
  sched: add WF_CURRENT_CPU and externise ttwu
  sched/umcg: RFC: add userspace atomic helpers
  sched/umcg: RFC: implement UMCG syscalls

 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/sched.h                  |   6 +
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/umcg.h              | 246 +++++++++++++
 init/Kconfig                           |  10 +
 kernel/exit.c                          |   7 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  20 +-
 kernel/sched/fair.c                    |   4 +
 kernel/sched/sched.h                   |  15 +-
 kernel/sched/umcg.c                    | 481 +++++++++++++++++++++++++
 kernel/sched/umcg.h                    | 271 ++++++++++++++
 kernel/sys_ni.c                        |   4 +
 14 files changed, 1068 insertions(+), 11 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c
 create mode 100644 kernel/sched/umcg.h

--
2.25.1

