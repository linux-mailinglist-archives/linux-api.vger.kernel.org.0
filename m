Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2338B625
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhETShr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbhETSho (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:44 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E27C061760
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:22 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d15-20020a05620a136fb02902e9e93c69c8so13329259qkl.23
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ut0zCwGw2v2iMtDTI85iOMWrKrGormzL7WlmGjHw0lY=;
        b=Lj11KKwplu8YML2IusTUp9GABySsxLtPhvxMfHdsDf/cFJVpN3eHgHpEzDc10lHbDg
         y6x/erww0A0CrUp8nQsxgqRI+A4ZX4JLQuPnza+O/q1w+UwpMMLupVyjP9swvbKs4l7Q
         ZWaZ7biK+sNtSsfdG+ODA7uQZ35vCcWCXp+bOz3uoNJzHCTKy9rvgYysWdsJ6KCSUI/4
         cwxhFDWCNnPFjuj0ofV1M8UaMjcF0iLVa6YLSwP5r2l7ywCMwcm4e/lwRpsEM2E0fyRV
         KKZ5pVO2hW4ECdul+5UO5qGDZUWK9Tuay1bA2sSkYKRVNSzsQcPDxE5fTRNc4nbl4mUW
         oeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ut0zCwGw2v2iMtDTI85iOMWrKrGormzL7WlmGjHw0lY=;
        b=QavUgpFhvNowlDJ843B0lnNuS17AyGCMGdZFOoqlxrhvHQEzv5FssJKvQy8T1lZDlq
         54QysZ4I40hEPfc8QgeE6eVxK3Hye+UzqnwxC9tC2FZSY+BJvhZvPmCiXxjCF1b5s8vG
         hdDDYdRYPAfKWjCO71xfjDPj8X3KUOACPRhlY+XyJZyn0ikVl1X5TtQD/raQcHWW9xkD
         sHuD9jxAcGxOPFVsjYMiTvPonlutXWjZBuWCygw7sx/uYWPk5V2HEkrWZEpHg6cYuBAO
         cA+YeKM+zfYELfdnVaV1FlVrWxIdZQO/vLQugxP+rq1mzZvO7uj5TlmTfQLwv3wCzxFz
         ENFQ==
X-Gm-Message-State: AOAM532vTpRd8Et8WQvGydkRnl5mo6xqBWdJQczKIG8gb+WiNai+u2ry
        cCoJQpaNyTdQ+otZ1il0XEP7lr62
X-Google-Smtp-Source: ABdhPJzG8ZUQY1A6dyMVM+ov+Gjsz3tGq27e1s00mmkaqjrWZYBA+vB3OZJKY+9Ci9Q/H0XsuWAQdnKK
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a0c:e251:: with SMTP id x17mr7292901qvl.2.1621535781789;
 Thu, 20 May 2021 11:36:21 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:06 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-2-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 1/9] sched/umcg: add UMCG syscall stubs and CONFIG_UMCG
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

User Managed Concurrency Groups is a fast context switching and
in-process userspace scheduling framework.

Two main use cases are security sandboxes and userspace scheduling.

Security sandboxes: fast X-process context switching will open up a
bunch of light-weight security tools, e.g. gVisor, or Tor Project's
Shadow simulator, to more use cases.

In-process userspace scheduling is used extensively at Google to provide
latency control and isolation guarantees for diverse workloads while
maintaining high CPU utilization.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 11 +++++++++++
 include/uapi/asm-generic/unistd.h      | 25 ++++++++++++++++++++++++-
 init/Kconfig                           | 10 ++++++++++
 kernel/sys_ni.c                        | 13 +++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ecd551b08d05..2e984a77eb23 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -368,6 +368,17 @@
 444	common	landlock_create_ruleset	sys_landlock_create_ruleset
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
+447	common	umcg_api_version	sys_umcg_api_version
+448	common	umcg_register_task	sys_umcg_register_task
+449	common	umcg_unregister_task	sys_umcg_unregister_task
+450	common	umcg_wait		sys_umcg_wait
+451	common	umcg_wake		sys_umcg_wake
+452	common	umcg_swap		sys_umcg_swap
+453	common	umcg_create_group	sys_umcg_create_group
+454	common	umcg_destroy_group	sys_umcg_destroy_group
+455	common	umcg_poll_worker	sys_umcg_poll_worker
+456	common	umcg_run_worker		sys_umcg_run_worker
+457	common	umcg_preempt_worker	sys_umcg_preempt_worker
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6de5a7fc066b..cb8504e7ae07 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -873,8 +873,31 @@ __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 #define __NR_landlock_restrict_self 446
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 
+#define __NR_umcg_api_version 447
+__SYSCALL(__NR_umcg_api_version, sys_umcg_api_version)
+#define __NR_umcg_register_task 448
+__SYSCALL(__NR_umcg_register_task, sys_umcg_register_task)
+#define __NR_umcg_unregister_task 449
+__SYSCALL(__NR_umcg_unregister_task, sys_umcg_unregister_task)
+#define __NR_umcg_wait 450
+__SYSCALL(__NR_umcg_wait, sys_umcg_wait)
+#define __NR_umcg_wake 451
+__SYSCALL(__NR_umcg_wake, sys_umcg_wake)
+#define __NR_umcg_swap 452
+__SYSCALL(__NR_umcg_swap, sys_umcg_swap)
+#define __NR_umcg_create_group 453
+__SYSCALL(__NR_umcg_create_group, sys_umcg_create_group)
+#define __NR_umcg_destroy_group 454
+__SYSCALL(__NR_umcg_destroy_group, sys_umcg_destroy_group)
+#define __NR_umcg_poll_worker 455
+__SYSCALL(__NR_umcg_poll_worker, sys_umcg_poll_worker)
+#define __NR_umcg_run_worker 456
+__SYSCALL(__NR_umcg_run_worker, sys_umcg_run_worker)
+#define __NR_umcg_preempt_worker 457
+__SYSCALL(__NR_umcg_preempt_worker, sys_umcg_preempt_worker)
+
 #undef __NR_syscalls
-#define __NR_syscalls 447
+#define __NR_syscalls 458
 
 /*
  * 32 bit systems traditionally used different
diff --git a/init/Kconfig b/init/Kconfig
index 1ea12c64e4c9..bfac88dd5d73 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1661,6 +1661,16 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config UMCG
+	bool "Enable User Managed Concurrency Groups API"
+	default n
+	help
+	  Enable UMCG core wait/wake/swap operations as well as UMCG
+	  group/server/worker API. The core API is useful for fast IPC
+	  and context switching, while the group/server/worker API, together
+	  with the core API, form the basis for an in-process M:N userspace
+	  scheduling framework implemented in lib/umcg.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0ea8128468c3..fea55aa0222a 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -272,6 +272,19 @@ COND_SYSCALL(landlock_create_ruleset);
 COND_SYSCALL(landlock_add_rule);
 COND_SYSCALL(landlock_restrict_self);
 
+/* kernel/sched/umcg.c */
+COND_SYSCALL(umcg_api_version);
+COND_SYSCALL(umcg_register_task);
+COND_SYSCALL(umcg_unregister_task);
+COND_SYSCALL(umcg_wait);
+COND_SYSCALL(umcg_wake);
+COND_SYSCALL(umcg_swap);
+COND_SYSCALL(umcg_create_group);
+COND_SYSCALL(umcg_destroy_group);
+COND_SYSCALL(umcg_poll_worker);
+COND_SYSCALL(umcg_run_worker);
+COND_SYSCALL(umcg_preempt_worker);
+
 /* arch/example/kernel/sys_example.c */
 
 /* mm/fadvise.c */
-- 
2.31.1.818.g46aad6cb9e-goog

