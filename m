Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA8403F39
	for <lists+linux-api@lfdr.de>; Wed,  8 Sep 2021 20:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348289AbhIHSuU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 14:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348265AbhIHSuU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 14:50:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA76C061757
        for <linux-api@vger.kernel.org>; Wed,  8 Sep 2021 11:49:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u1so1876890plq.5
        for <linux-api@vger.kernel.org>; Wed, 08 Sep 2021 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4F7KTw8b2Sf/F6Hrpsu9jZkL1CByiMkGRka7IEfpAvo=;
        b=CVM0ZsEFfRAM8aDm30mklDPrHdVrbL1OWZZ2IV1+rairSkLVMUYPkOX3QgoL0ZO9Hd
         xPcwsTnZhYx2o0sR0hqvwYIV0w95Md1hxC2f0CY2UWAFWTdzrJUgGPe5bSFmDJV67WnN
         nsuSJyCtApbrtdUVYUkttjzIQkw1y/TaMuVC+OJbBRdcALt7A1YK8PETbwr+xnyJ0uZN
         caZcJOSKqkJDcie41UOARgjpriY4+dM/RNYNMBzjxI5W34Ar41vHGXxt3PnCK3yAjv0f
         1Fti90DYOgZLwc1Td5xRrrjM1EjAwz/rCRFMXOldWsSEMQRDJZSBp3roCjygD4Qb1e6N
         7Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4F7KTw8b2Sf/F6Hrpsu9jZkL1CByiMkGRka7IEfpAvo=;
        b=Zu0Xx6FIquwRvPHmFzLVgK6LrU1RJ3kyHy0nRYXGK4kJFHP1AY3J94tCPRu0liXABj
         psdF6yvFNzoLTDHD87GJeSOUfeH0axTQxyvXxHpeCjrZa5ucTbDCJ1pUvjzSqx+jBsC2
         TZ4JzB9WuJR9ml2W5DAwOHvX+bHXmIabjmuiczDR1AAF0hyiEj3TzJB+4UukTX0dwY0g
         qvl7iMpxXuP8mnaNeFX/F4hrLrdeu14lGjx88fEyAG7+acrEuZ9ge7buPuycDtbjlINT
         aEuUPjxnJDTA99jdOZpvkicQFuO8F0PY582mQJ2/3sWJHl+LqzmZt3lmfPXV3vVS/W0K
         kRmw==
X-Gm-Message-State: AOAM533T4gVuqAJQHQlMunZPbzdGYxqM80vHsJmSzTIkDHLqSNx42Vbh
        75DtequbWDME4mctLbFknY/s7Q==
X-Google-Smtp-Source: ABdhPJw54XuyRRZD2yO7LGO0G8d4TUd37AWQHtqJ+drdy/wFj8Vw0VR8DCK+/KfvLS4jzLN/yfqLUQ==
X-Received: by 2002:a17:90a:3ec4:: with SMTP id k62mr5795759pjc.32.1631126951276;
        Wed, 08 Sep 2021 11:49:11 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id m64sm3645640pga.55.2021.09.08.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:49:11 -0700 (PDT)
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
Subject: [PATCH 0/4 v0.5] sched/umcg: RFC UMCG patchset
Date:   Wed,  8 Sep 2021 11:49:01 -0700
Message-Id: <20210908184905.163787-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is an update on v0.4:
https://lore.kernel.org/lkml/20210801200617.623745-1-posk@google.com/

Key changes:

v0.3 => v0.4:
- made idle workers list logic simpler
- only one idle server tracking
- removed two fields from struct umcg_task
- added timeout handling
- added worker preemption
- added a doc patch that now documents the syscalls and state
  transitions.

v0.4 => v0.5:
- refactored idle workers list management, as suggested by
  Thierry Delisle here:
  https://lore.kernel.org/lkml/3530714d-125b-e0f5-45b2-72695e2fc4ee@uwaterloo.ca/

I will now clean up libumcg (userspace) and selftests and post them
in a follow-up patchset.

Peter Oskolkov (4):
  sched/umcg: add WF_CURRENT_CPU and externise ttwu
  sched/umcg: RFC: add userspace atomic helpers
  sched/umcg: RFC: implement UMCG syscalls
  sched/umcg: add Documentation/userspace-api/umcg.rst

 Documentation/userspace-api/umcg.rst   | 546 ++++++++++++++++++++++
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
 kernel/sched/umcg.c                    | 618 +++++++++++++++++++++++++
 kernel/sched/umcg.h                    | 325 +++++++++++++
 kernel/sys_ni.c                        |   4 +
 15 files changed, 1673 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/userspace-api/umcg.rst
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c
 create mode 100644 kernel/sched/umcg.h

--
2.25.1

