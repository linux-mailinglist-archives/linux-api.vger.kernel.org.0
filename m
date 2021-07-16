Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0561E3CBC12
	for <lists+linux-api@lfdr.de>; Fri, 16 Jul 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhGPSuk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 14:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhGPSuY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 14:50:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6323C06175F
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso1369961pjg.2
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+pBQszJfRlqDFcT5AL34vP285QtEH3o1QexaECMHjE=;
        b=C6DA69bqkyuEEQ3/+YCbmMXwlUQEL2xr8/dCAS92UBXzQIfwSujEmvMblQ9zZkfwFq
         y7i7pqMBykFqqMxhPBauRADJsOdFnqoOQqSeLwUgsH+7oLrF6GH35rs0ff7KBGgCrFjl
         +0RLeSt0GDAIMuIfhSscxggApj0IYW+zFOUbgFlEOTBMgU80KSryDUrLcPEMeXPm24BG
         hDz/KrYY9D5MstmykN0+L429aMS7EEh5mDNBBCywkkaOVN2edvjWANrWwXmxSlk/MEfq
         CefVoLCI64YKzU6182BkczRnBclrvgrIRnhrA8A+4ZWjJd7qCNZnDlRA/qD6AWzsjE7T
         c5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+pBQszJfRlqDFcT5AL34vP285QtEH3o1QexaECMHjE=;
        b=aE0UH3reCGOTQ6B/JiK4n9f1drngeK1bVtPmACycAT67ezjKZmaaZS+QyUioGU5EFM
         zfXpDfLkANanAHAee02aHWaDhShnd6g7zY55A+B6qt+qPbTcCD943K1XA96eZWGBqur6
         bgh9JdyVFmTwcwhrrlSnFZMKH1Aq1hQ90AHYnF3D257rAgk5erJua1+Z650qQWD4z0DU
         lEExfP9jU0KHGcS+HhYqCgPJNodPtnSXpV0brsahphpxivWbXMmIuosTWfBrj123ej48
         FC3WKj7Dohxdyd9JfuqmV7LAwQ1OTW4v7Jh6yUoGGiKmHnwOaW140BLpeeGxescv01/x
         jpIw==
X-Gm-Message-State: AOAM533BrIT8m6XZnbiF0fZFylYQm58ceji1w2DW03WdJqsoqhp+IXLl
        h8fFZOKbL4Krs6v9UwQ53I7HdQ==
X-Google-Smtp-Source: ABdhPJx25sqmHQRngk6kCUpj+FKylcaajEufZWTIO2wsCzdPzzfsFBsP1+lrBSYS0cTw9qfYsGQECg==
X-Received: by 2002:a17:90a:fd93:: with SMTP id cx19mr16879210pjb.65.1626461248258;
        Fri, 16 Jul 2021 11:47:28 -0700 (PDT)
Received: from localhost.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id q125sm3170240pga.87.2021.07.16.11.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:47:27 -0700 (PDT)
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
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [RFC PATCH 0/4 v0.3] sched/UMCG
Date:   Fri, 16 Jul 2021 11:47:15 -0700
Message-Id: <20210716184719.269033-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is another attempt at implementing UMCG, based on
discussion in https://lore.kernel.org/patchwork/cover/1433967/ and
https://lore.kernel.org/lkml/20210708194638.128950-1-posk@google.com/

Most of the "why" is covered here (some details are obsolete):
https://lore.kernel.org/patchwork/cover/1433967/#1632328

At a high level, UMCG servers/workers provide the foundation
for an M:N threading library, as described in the link above.

Joel Fernandes has also once mentioned that he had a use case
for a wake+bring-the-wakee-to-the-current-CPU operation,
so this is now also supported via UMCG_WF_CURRENT_CPU flag
(patch 3).

Patch 1: add WF_CURRENT_CPU and tweak ttwu - same as last time
Patch 2: add X86_64 helpers to work atomically with userspace values
Patch 3: add helpers to work with single-linked lists in userspace
Patch 4: implement UMCG kernel-side

In this version of the patchset I used only userspace/TLS
data, as suggested by Peter Zijlstra. With the exception
of one issue (see patch 3 commit message) everything seems
to be working great.

This TLS-only approach makes the userspace code a bit more
involved, so I'm not posting libumcg/selftests with this
patchset to focus on the kernel side only.

v0.2->v0.3 chages:
- split patch 2 into two paches: atomic ops and llist ops
- rework atomic ops in patch 2 to avoid "stac/clac nonsense"
- make llist kernel-side operations constant time (no indefinite
  spinning)
- make task wakeup work without spinning/retries

I'm not aware of any issues with this patchset other than
what's mentioned below. In short, it seems that "SMP basics":
block/wake detection, worker "scheduling" by servers, etc.
all work.

TODO:
  - combine cmpxchg_user_32/64 functions into a macro in patch 2
  - implement timeout handling
  - imlement worker preemption
  - more testing
  - manpages, docs, and similar
  - attach libumbc and selftest patches

Peter Oskolkov (4):
  sched: add WF_CURRENT_CPU and externise ttwu
  sched/umcg: RFC: add userspace atomic helpers
  sched/umcg: RFC: add userspace sll helpers
  sched/umcg: RFC: implement UMCG syscalls

 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/sched.h                  |   6 +
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/umcg.h              | 259 +++++++++++++
 init/Kconfig                           |  10 +
 kernel/exit.c                          |   7 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  20 +-
 kernel/sched/fair.c                    |   4 +
 kernel/sched/sched.h                   |  15 +-
 kernel/sched/umcg.c                    | 485 +++++++++++++++++++++++++
 kernel/sched/umcg.h                    | 298 +++++++++++++++
 kernel/sys_ni.c                        |   4 +
 14 files changed, 1112 insertions(+), 11 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c
 create mode 100644 kernel/sched/umcg.h

--
2.25.1

