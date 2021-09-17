Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D389340FEEE
	for <lists+linux-api@lfdr.de>; Fri, 17 Sep 2021 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbhIQSEv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Sep 2021 14:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhIQSEv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Sep 2021 14:04:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBDDC061764
        for <linux-api@vger.kernel.org>; Fri, 17 Sep 2021 11:03:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 5so6691379plo.5
        for <linux-api@vger.kernel.org>; Fri, 17 Sep 2021 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36UC4VgoNG+xUtS3CUnA5OGNelTv5dcazwBLXCUgHnY=;
        b=P1pGgZux5VMQly7sgAybNbszwaVyT5rwESyq+rTJiAKIJbuLc2+x+ycZbQbZ4JI14H
         Db8JqrT1DkjnkiYttNeODKJnmZ7udMy35kEIeBCVa9/8TBOwuPhDuR6RCyhztWnlsAjy
         t2NSz6HnBcD47HCQNO71jicTOg/3MYm0g7dRyYjjU6VkXIyAiPXGu3LrWHkp1rdHSx01
         CoDtapPx38Gh4KeDoc2p1nKKnLELg5mIKL6UuwlocI+sFLnVgp5RhTWMnVqGSyU1dSjz
         dLFdlUyOrY8II6Zi74OoLAYiQgKiO7VT1J+tsrQfTo2TqA/FI8D4Xk/YnBeTSfH2XyaQ
         Zsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36UC4VgoNG+xUtS3CUnA5OGNelTv5dcazwBLXCUgHnY=;
        b=GR/ACjnITQFE6QTQH0guQw/rShueedEquXz96LmsNpFDScXob2wB8uL//HfNDiejBR
         FV43sONsH5dT6wBwQgFkzHN5j2oEoXnV70J92dtuzzrJ1iKNTbzDhkvs56ic9LOH6dvN
         f7DWND+7YADh17x5padJO49bGX51RQIs7me1wMXQBhBczJlwi9IJK6hPfDPFVARqW+/m
         j7JR81gYH/ZJYzrJJowF8O5oJLarg6gwrwG795AeOa4VG8pLqfcsOjbY89ReOK/hezqS
         OEmk6fiXsaBaoQ5JT36VvvvXicB20OjB5aiTMCE3Upm5JXIH/Dm0ORapekz4bALGadLU
         mnzg==
X-Gm-Message-State: AOAM533xrB0sNos9KmTETpYojz9Zco7Z6zOHPhjAwDemR7OQO/9IOm51
        0H07Y1eRevU3fTCm0X+yqKGr6w==
X-Google-Smtp-Source: ABdhPJxeNM00Cp6rlI/AYcwyGrkNzny06sDpAiN8TOJ491ocsLeW14aAgGv/7dHroVBI6eDgT//ZIg==
X-Received: by 2002:a17:902:c94f:b0:13b:8359:9506 with SMTP id i15-20020a170902c94f00b0013b83599506mr10707262pla.33.1631901808773;
        Fri, 17 Sep 2021 11:03:28 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id b24sm5781773pfi.205.2021.09.17.11.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 11:03:28 -0700 (PDT)
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
Subject: [PATCH 0/5 v0.6] sched/umcg: RFC UMCG patchset
Date:   Fri, 17 Sep 2021 11:03:18 -0700
Message-Id: <20210917180323.278250-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Many thanks to Jann Horn for a detailed review of v0.5:
https://lore.kernel.org/lkml/20210908184905.163787-1-posk@google.com/

The main change in this patchet vs v0.5 is pinning of
pages containing struct umcg_task of RUNNING workers
and their servers. This allows uaccess operations from
sched_submit_work (preempt-disabled). The pages are
pinned only for RUNNING workers, i.e. at most NR_CPUS
pages are pinned by UMCG at any one time, across the
whole machine.

A smaller change is the move of worker wakeup processing
from sched_update_worker() to exit_to_user_mode_loop(),
to ensure that no kernel locks are held if the worker
is descheduled there.

Commit messages in patches 2 and 3 list more changes.

Peter Oskolkov (5):
  sched/umcg: add WF_CURRENT_CPU and externise ttwu
  sched/umcg: RFC: add userspace atomic helpers
  sched/umcg: RFC: implement UMCG syscalls
  sched/umcg: add Documentation/userspace-api/umcg.rst
  sched/umcg: add Documentation/userspace-api/umcg.txt

 Documentation/userspace-api/umcg.rst   | 550 ++++++++++++++++++
 Documentation/userspace-api/umcg.txt   | 537 ++++++++++++++++++
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 fs/exec.c                              |   1 +
 include/linux/sched.h                  |  56 ++
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/umcg.h              | 117 ++++
 init/Kconfig                           |  10 +
 kernel/entry/common.c                  |   1 +
 kernel/exit.c                          |   2 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  18 +-
 kernel/sched/fair.c                    |   4 +
 kernel/sched/sched.h                   |  15 +-
 kernel/sched/umcg.c                    | 745 +++++++++++++++++++++++++
 kernel/sched/umcg_uaccess.h            | 344 ++++++++++++
 kernel/sys_ni.c                        |   4 +
 18 files changed, 2408 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/userspace-api/umcg.rst
 create mode 100644 Documentation/userspace-api/umcg.txt
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c
 create mode 100644 kernel/sched/umcg_uaccess.h

--
2.25.1

