Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6734135E
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 04:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCSDLP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Mar 2021 23:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhCSDLD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Mar 2021 23:11:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0440CC06174A
        for <linux-api@vger.kernel.org>; Thu, 18 Mar 2021 20:11:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y7so50597169ybh.20
        for <linux-api@vger.kernel.org>; Thu, 18 Mar 2021 20:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bCbJd+P4sd810vdDojMTg0wxtRKXuk+niGlwoxFtOls=;
        b=YDIsWw9wiz+pzSpcxvgHgxhlY+vk+9uphEImcHWu7Sirwd6NB/6CMLzUXe0qIPCOvT
         JAIiINfGt27OyFAxO1jIdvgQMFhA0T/5NHQIG9ZOuH4b8QCBU7UvOHM5Hyy37Bqqj//9
         pf4nSZqznN6ZHkJQyfRvnoHp71WxkuvnAxt80kMc4b0gb6Zm8++G/ilLxw/RYgrypM/R
         2W1NWaaZ1HZhRV93V4FPwE8QL0xVyZdMVDxVUTXIEsrzZGNjwCSCPrtrer9Hm35henZ6
         vkS3Nuw1w/WQic/p8pRQJl8bXN83SkLNj03+xW/xXAVgwO9HfUOnW+y9fBWqji3t3m2E
         bLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bCbJd+P4sd810vdDojMTg0wxtRKXuk+niGlwoxFtOls=;
        b=FQlCNQEq6fBOdP1QHboytODvJ5b7tLVuQK8hJEUDcnWeqgHyPo7Ybmx6PGZmdhTDqQ
         LSHd5ph9QNrN7kVExDQ9zvkcwh1SAuYSUlnDKAj+plEO8Iypw0ulmLLlNIaF4A3zQA9l
         q9rJkH/Fqa1dmLFOfxZCcoMzdnEYO4jdzAp8akQ66r3cw0TrhDycLLEZIDdY+AHWTeVE
         MGCKDMPKdFGkXwoWCj2uVTPOnX1f9ktIgs5f+LG0JDEw5c2S8gQoUXxa685x3t1s53Zk
         VZ8MYu/Hiha+/gWC2eVWL9uikjwlbC4ft+9EVrbemysKLefeiXEehvu7zEIZ/tuUMy5J
         RqLg==
X-Gm-Message-State: AOAM530fehac2kXB8R3LwStzZ7Zsw4Rl266ffwG6pUiWhag9kkeyeepz
        RB6CPO6Ql96HZvgA+Cao+OtZNAM=
X-Google-Smtp-Source: ABdhPJxeT8xt3kK+xpHImNje5fUjx5a70RjayIvBNn8i20JxqinNV5A6soaTMLc7VKifQYWak/spRso=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:455:89c6:cb5a:9b7f])
 (user=pcc job=sendgmr) by 2002:a25:e651:: with SMTP id d78mr3615858ybh.93.1616123462041;
 Thu, 18 Mar 2021 20:11:02 -0700 (PDT)
Date:   Thu, 18 Mar 2021 20:10:52 -0700
Message-Id: <13d725cb8e741950fb9d6e64b2cd9bd54ff7c3f9.1616123271.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 1/3] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In an upcoming change we are going to introduce per-task SCTLR_EL1
bits for PAC. Move the existing per-task SCTLR_EL1 field out of the
MTE-specific code so that we will be able to use it from both the
PAC and MTE code paths and make the task switching code more efficient.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ic65fac78a7926168fa68f9e8da591c9e04ff7278
---
v8:
- rebase to 5.12-rc3

v7:
- drop CONFIG_ARM64_NEED_SCTLR_USER

 arch/arm64/include/asm/mte.h       |  4 ---
 arch/arm64/include/asm/processor.h |  6 +++-
 arch/arm64/kernel/mte.c            | 47 ++++++------------------------
 arch/arm64/kernel/process.c        | 30 +++++++++++++++----
 4 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 9b557a457f24..1a4909b44297 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -40,7 +40,6 @@ void mte_free_tag_storage(char *storage);
 void mte_sync_tags(pte_t *ptep, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void flush_mte_state(void);
-void mte_thread_switch(struct task_struct *next);
 void mte_suspend_exit(void);
 long set_mte_ctrl(struct task_struct *task, unsigned long arg);
 long get_mte_ctrl(struct task_struct *task);
@@ -63,9 +62,6 @@ static inline void mte_copy_page_tags(void *kto, const void *kfrom)
 static inline void flush_mte_state(void)
 {
 }
-static inline void mte_thread_switch(struct task_struct *next)
-{
-}
 static inline void mte_suspend_exit(void)
 {
 }
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ca2cd75d3286..80895bb30490 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -151,11 +151,13 @@ struct thread_struct {
 	struct ptrauth_keys_kernel	keys_kernel;
 #endif
 #ifdef CONFIG_ARM64_MTE
-	u64			sctlr_tcf0;
 	u64			gcr_user_excl;
 #endif
+	u64			sctlr_user;
 };
 
+#define SCTLR_USER_MASK SCTLR_EL1_TCF0_MASK
+
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
@@ -247,6 +249,8 @@ extern void release_thread(struct task_struct *);
 
 unsigned long get_wchan(struct task_struct *p);
 
+void set_task_sctlr_el1(u64 sctlr);
+
 /* Thread switching */
 extern struct task_struct *cpu_switch_to(struct task_struct *prev,
 					 struct task_struct *next);
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index b3c70a612c7a..ea8a90259e7f 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -124,26 +124,6 @@ bool mte_report_once(void)
 	return READ_ONCE(report_fault_once);
 }
 
-static void update_sctlr_el1_tcf0(u64 tcf0)
-{
-	/* ISB required for the kernel uaccess routines */
-	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF0_MASK, tcf0);
-	isb();
-}
-
-static void set_sctlr_el1_tcf0(u64 tcf0)
-{
-	/*
-	 * mte_thread_switch() checks current->thread.sctlr_tcf0 as an
-	 * optimisation. Disable preemption so that it does not see
-	 * the variable update before the SCTLR_EL1.TCF0 one.
-	 */
-	preempt_disable();
-	current->thread.sctlr_tcf0 = tcf0;
-	update_sctlr_el1_tcf0(tcf0);
-	preempt_enable();
-}
-
 static void update_gcr_el1_excl(u64 excl)
 {
 
@@ -176,21 +156,12 @@ void flush_mte_state(void)
 	write_sysreg_s(0, SYS_TFSRE0_EL1);
 	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
 	/* disable tag checking */
-	set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);
+	set_task_sctlr_el1((current->thread.sctlr_user & ~SCTLR_EL1_TCF0_MASK) |
+			   SCTLR_EL1_TCF0_NONE);
 	/* reset tag generation mask */
 	set_gcr_el1_excl(SYS_GCR_EL1_EXCL_MASK);
 }
 
-void mte_thread_switch(struct task_struct *next)
-{
-	if (!system_supports_mte())
-		return;
-
-	/* avoid expensive SCTLR_EL1 accesses if no change */
-	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
-		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
-}
-
 void mte_suspend_exit(void)
 {
 	if (!system_supports_mte())
@@ -201,7 +172,7 @@ void mte_suspend_exit(void)
 
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 {
-	u64 tcf0;
+	u64 sctlr = task->thread.sctlr_user & ~SCTLR_EL1_TCF0_MASK;
 	u64 gcr_excl = ~((arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT) &
 		       SYS_GCR_EL1_EXCL_MASK;
 
@@ -210,23 +181,23 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 
 	switch (arg & PR_MTE_TCF_MASK) {
 	case PR_MTE_TCF_NONE:
-		tcf0 = SCTLR_EL1_TCF0_NONE;
+		sctlr |= SCTLR_EL1_TCF0_NONE;
 		break;
 	case PR_MTE_TCF_SYNC:
-		tcf0 = SCTLR_EL1_TCF0_SYNC;
+		sctlr |= SCTLR_EL1_TCF0_SYNC;
 		break;
 	case PR_MTE_TCF_ASYNC:
-		tcf0 = SCTLR_EL1_TCF0_ASYNC;
+		sctlr |= SCTLR_EL1_TCF0_ASYNC;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	if (task != current) {
-		task->thread.sctlr_tcf0 = tcf0;
+		task->thread.sctlr_user = sctlr;
 		task->thread.gcr_user_excl = gcr_excl;
 	} else {
-		set_sctlr_el1_tcf0(tcf0);
+		set_task_sctlr_el1(sctlr);
 		set_gcr_el1_excl(gcr_excl);
 	}
 
@@ -243,7 +214,7 @@ long get_mte_ctrl(struct task_struct *task)
 
 	ret = incl << PR_MTE_TAG_SHIFT;
 
-	switch (task->thread.sctlr_tcf0) {
+	switch (task->thread.sctlr_user & SCTLR_EL1_TCF0_MASK) {
 	case SCTLR_EL1_TCF0_NONE:
 		ret |= PR_MTE_TCF_NONE;
 		break;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 325c83b1a24d..bb89f6208a20 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -529,6 +529,27 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
 	write_sysreg(val, cntkctl_el1);
 }
 
+static void update_sctlr_el1(u64 sctlr)
+{
+	sysreg_clear_set(sctlr_el1, SCTLR_USER_MASK, sctlr);
+
+	/* ISB required for the kernel uaccess routines when setting TCF0. */
+	isb();
+}
+
+void set_task_sctlr_el1(u64 sctlr)
+{
+	/*
+	 * __switch_to() checks current->thread.sctlr as an
+	 * optimisation. Disable preemption so that it does not see
+	 * the variable update before the SCTLR_EL1 one.
+	 */
+	preempt_disable();
+	current->thread.sctlr_user = sctlr;
+	update_sctlr_el1(sctlr);
+	preempt_enable();
+}
+
 /*
  * Thread switching.
  */
@@ -553,12 +574,9 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	dsb(ish);
 
-	/*
-	 * MTE thread switching must happen after the DSB above to ensure that
-	 * any asynchronous tag check faults have been logged in the TFSR*_EL1
-	 * registers.
-	 */
-	mte_thread_switch(next);
+	/* avoid expensive SCTLR_EL1 accesses if no change */
+	if (prev->thread.sctlr_user != next->thread.sctlr_user)
+		update_sctlr_el1(next->thread.sctlr_user);
 
 	/* the actual thread switch */
 	last = cpu_switch_to(prev, next);
-- 
2.31.0.rc2.261.g7f71774620-goog

