Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2442B017
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 01:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhJLX1d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Oct 2021 19:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLX1c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Oct 2021 19:27:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE8C061570
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 16:25:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ls18so781033pjb.3
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+MCbUR+9Em0iYarChlkTpQ1HVke2G/DGf/+kVt506hA=;
        b=K9rtvqDADOFi/pV5Xt1D0nPncFQCJGbmTgJ6Gh9DcnS3GNIm588XShQ24y6u8kIcAB
         GmbYJg3UT98mpFJfsSaNTUzmRplRn67F3kZuwMvDNrZq+PENH7D9XR1Wl0+y91tTRCnD
         bCd4A2n2YUHcESbQsCNiVMQCg0SDCPV1gMYMeg1xO8RwEYoWoCvPqK2AsKDAxuIOzNAv
         z1BeJuotoWsSKzPV6HyMGPBbdxkbLLSMS0lwPoaLj/FWv/vMZzBzoFNAHRAJqP6t5So6
         Ay5NNU+Wu84lNQ08vuDl9qk97LMNxXBm9PREA9ck+9zarZYhb4SNrlHrlnwW7aHv+/zq
         Ws9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+MCbUR+9Em0iYarChlkTpQ1HVke2G/DGf/+kVt506hA=;
        b=prML+nEq4f7lJuVN2d4TOM7ETKwwXLyEWmbzEsnrtm/JxI85iePHGJvU5BGAazn+Y9
         nz7X0eqPRLQOImUC7ffH9kVWi2vV1Ernb+cU+dfoKRP7F6mOG8LvJtSO6jIcbCkkGMUY
         IcgG0qHufXwZsR+nCREW/HvU2MKrh5cRqElilg2BD5U6+Sg43vMx1m2qAuHw7JaPmnl+
         PutirTOGQdt8V0WTEt/RcLun8qYO/mc8KYXJBOWlAWt2gOBlxssIdOk3vbGAU2Au6oIw
         bStV2GfUH0d162qlvmkpvsqQpw6h2kmyvRfl/GWdYH2tzAoCn7TBVWysJE0dsCv7agpr
         ySgA==
X-Gm-Message-State: AOAM533HkkIxqhzty1VFIAora8qRMkZJg2J/qSe8Xm4GGfr8YcaL2RiT
        br2DhKLX+gP4w8xzRDIZJLLJPg==
X-Google-Smtp-Source: ABdhPJxjh74j84b81uD2Wn5kWtHXWmrQZ1OVNkdEUMaIHUWxMYB0qGb8Uw91qe1lKFjIKloQRA4B7g==
X-Received: by 2002:a17:902:db01:b0:13e:d9ac:b8ff with SMTP id m1-20020a170902db0100b0013ed9acb8ffmr33135606plx.46.1634081130322;
        Tue, 12 Oct 2021 16:25:30 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id v20sm12675026pgc.38.2021.10.12.16.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:25:29 -0700 (PDT)
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
Subject: [PATCH v0.7 0/5] sched,mm,x86/uaccess: implement User Managed Concurrency Groups
Date:   Tue, 12 Oct 2021 16:25:17 -0700
Message-Id: <20211012232522.714898-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

User Managed Concurrency Groups (UMCG) is an M:N threading
subsystem/toolkit that lets user space application developers implement
in-process user space schedulers.

Key changes from the previous patchset
https://lore.kernel.org/all/20210917180323.278250-1-posk@google.com/ :

- userspace atomic helpers moved into mm/
- UMCG task states are now tagged with timestamps
- cross-mm interactions (wakeups) are not permitted
- several smaller fixes and refactorings

These big things remain to be addressed (in no particular order):
- support tracing/debugging
- make context switches faster (see umcg_do_context_switch in umcg.c)
- support other architectures
- cleanup and post userspace support in tools/lib/umcg/
- cleanup and post selftests in tools/testing/selftests/umcg/
- allow cross-mm wakeups (securely)

I'm working on finalizing libumcg and kselftests.

Signed-off-by: Peter Oskolkov <posk@google.com>

Peter Oskolkov (5):
  sched/umcg: add WF_CURRENT_CPU and externise ttwu
  mm, x86/uaccess: add userspace atomic helpers
  sched/umcg: implement UMCG syscalls
  sched/umcg: add Documentation/userspace-api/umcg.rst
  sched/umcg: add Documentation/userspace-api/umcg.txt

 Documentation/userspace-api/umcg.rst   | 611 ++++++++++++++++
 Documentation/userspace-api/umcg.txt   | 594 ++++++++++++++++
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 arch/x86/include/asm/uaccess_64.h      |  93 +++
 fs/exec.c                              |   1 +
 include/linux/sched.h                  |  71 ++
 include/linux/syscalls.h               |   3 +
 include/linux/uaccess.h                |  46 ++
 include/uapi/asm-generic/unistd.h      |   6 +-
 include/uapi/linux/umcg.h              | 137 ++++
 init/Kconfig                           |  10 +
 kernel/entry/common.c                  |   4 +-
 kernel/exit.c                          |   5 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  12 +-
 kernel/sched/fair.c                    |   4 +
 kernel/sched/sched.h                   |  15 +-
 kernel/sched/umcg.c                    | 926 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   4 +
 mm/maccess.c                           | 264 +++++++
 20 files changed, 2797 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/userspace-api/umcg.rst
 create mode 100644 Documentation/userspace-api/umcg.txt
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c

--
2.25.1

