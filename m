Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674B13DCD87
	for <lists+linux-api@lfdr.de>; Sun,  1 Aug 2021 22:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHAUGa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 1 Aug 2021 16:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhHAUGa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 1 Aug 2021 16:06:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49AAC06175F
        for <linux-api@vger.kernel.org>; Sun,  1 Aug 2021 13:06:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e21so17220014pla.5
        for <linux-api@vger.kernel.org>; Sun, 01 Aug 2021 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azZm4s2ItKFFM6P1T/V7Z4U9NU3xhdubwb5X+bc1wpI=;
        b=KuNyqP+Rlms7E+4zWlYj6P8Th/4KnDCAoxkX1SuRhop94eaeeFLy94V4Mvh2qcWLkn
         gphUC6LKNMPvYDZrVJDSuoWyAqC4i9C7iNLtNJ7eH3bBw1cwvXisWq5TTccu2hu1esVV
         UPGXWPloaMY2F1lELn7m3oihgQJEYFk6h7qRVk6UMdDn/Kn2Fs9ZS4CHF9EYfltm0Lhl
         7I/PtQybXlEgRAaFEXYWIVh2s4dCqZ9swhFIS1h2938988jDh1h66bMloBeJzPabUSVy
         4EHZdjgzIXqCS4DQYV+ig7tYNpcvKojdSVHNyYCBhK2yGmSrjYcaRN8RLuPKRIyXW13j
         uQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azZm4s2ItKFFM6P1T/V7Z4U9NU3xhdubwb5X+bc1wpI=;
        b=pbwdXWik6FPF8A5DcsLdV3l+FUN16ifKW66vj+ca6llsopyKwjx5lWnCsCucp3mUBu
         TVBp/GmaXtCangAT2mTs9OXQsZI4ie/KGDPy/pJCnlDlLdPXJ5lRgT/nd0Mab/TB21g+
         H/jayKjaZvjowYgySz120a2/YGNYZcm4pM0m8BzTXBgCRKN6OWNj9XfSHFUPuoJZzCw8
         ZyC4+1DudV8ROiHaeCcW47K9fNsRNSG8Ap38UaKT0Yz6kg0v9n2JDIXAzlAZkc17fazI
         ry1x5/KxIiZEZxiS+u1fuV9uaWL3sdVIEgiKoWtzsCy+OzxG06Eo+A80A8oyi8pTkMgl
         Yaiw==
X-Gm-Message-State: AOAM530sVbjOQKCudkLA7YhgpRG2m12TyvK2i3Ft8u3rBv8o83vDYVdI
        HKy+j+9Uy4wV6KO6swubI/Fz0Q==
X-Google-Smtp-Source: ABdhPJykIKwdJ3YQiR9QYmfh/XXE7vTxgi5e6RwTs15LS9FhzhnHzyf+73jP193tdLruwLdRw7xT4Q==
X-Received: by 2002:a63:1748:: with SMTP id 8mr2227544pgx.369.1627848381272;
        Sun, 01 Aug 2021 13:06:21 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id b3sm9293714pfi.179.2021.08.01.13.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:06:20 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH 0/4 v0.4] sched/umcg: RFC UMCG patchset
Date:   Sun,  1 Aug 2021 13:06:13 -0700
Message-Id: <20210801200617.623745-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is an update on v0.3:

https://lore.kernel.org/patchwork/cover/1461708/

Key changes v0.3 => v0.4:
- made idle workers list logic simpler
- only one idle server tracking
- removed two fields from struct umcg_task
- added timeout handling
- added worker preemption
- added a doc patch that now documents the syscalls and state
  transitions.

More details on the state of the patchset and future work are provided
in the patch 4 commit message.

Peter Oskolkov (4):
  sched: add WF_CURRENT_CPU and externise ttwu
  sched/umcg: RFC: add userspace atomic helpers
  sched/umcg: add Documentation/userspace-api/umcg.rst
  sched/umcg: RFC: implement UMCG syscalls

 Documentation/userspace-api/umcg.rst   | 532 ++++++++++++++++++++++
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/sched.h                  |   6 +
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/umcg.h              | 114 +++++
 init/Kconfig                           |  10 +
 kernel/exit.c                          |   7 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  20 +-
 kernel/sched/fair.c                    |   4 +
 kernel/sched/sched.h                   |  15 +-
 kernel/sched/umcg.c                    | 601 +++++++++++++++++++++++++
 kernel/sched/umcg.h                    | 211 +++++++++
 kernel/sys_ni.c                        |   4 +
 15 files changed, 1528 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/userspace-api/umcg.rst
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c
 create mode 100644 kernel/sched/umcg.h

--
2.25.1

