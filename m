Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64D23199E4
	for <lists+linux-api@lfdr.de>; Fri, 12 Feb 2021 07:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhBLGQ1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Feb 2021 01:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhBLGQ1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Feb 2021 01:16:27 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413CDC061574
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 22:15:47 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id v10so1104542qvn.1
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 22:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=AFQyEDOhqGiqjnvVF0gdE1aQTNa2qY5pmTjoLkFvdx0=;
        b=GyOC0AXpGD+slIVz4rvljnqiRS7UQ9RFwlbz9hRF0yaWGP0gPa08E+DLFaLdcQcc6k
         tKxLp9NJXjsTDruqxF1k1Rbwhuz3rbgoXXZyFRHjQI0AfCdL4tgxJe4/dHsmrRl/rwqd
         Wvff6BQ4nuQ/XDD+8zfc7Gt3auyehbePG1heVTyMYMiWqGXxhBM57DsRMfM+hGp00soH
         tzarAH7KtOY1rQKJpWy8mk+7tk0zopIi4t5RWg5QS7mPjCunli1jPJnMuIzbNyRzQt6w
         JCGg+OSE2fdkPI8qwltmOOKffrUUGjBnS/sWowne+63IXdW0s0cT70EnNmYk8vM8SQ+9
         ML6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=AFQyEDOhqGiqjnvVF0gdE1aQTNa2qY5pmTjoLkFvdx0=;
        b=JZ/PzQR9CQOLqEmP4ag/2MM4uZPtzC4EbndAn3uKAOo3/Dlt9xIiVgEEdYDmWH3Qg0
         CvFX21/stmVEtq0H1c/wkfVvHqoaGw0iWFbfxKtAjR2LcXoLSv8J5MmOgazQFHTGmWZc
         7qeR69BiCdG+cVwC9Vt0ENcyDpV3wnRNQLIWUqeE2RUF8WokeutOsk88nly0/MGVRU9k
         PC0pU+MwE+sGkv9ZBPeNJNKj5HWlaXZ3ED2IfdVYBvkiS+qvdxItQYz7GdlwB7Syjv5O
         oW6htCRTT4ZfcXvz8urzrEHW6wgNxOC7zA/s1oHHdp16JGyahjs28s1nO4WgV0SqbBCi
         pMlw==
X-Gm-Message-State: AOAM531CBYRgYiVYoExdFTJh92039l6qpn7SSM6/HMs3Slkknn6Z4GIC
        K5jprCodLjNX102aJ4Kum1RV4rU=
X-Google-Smtp-Source: ABdhPJypaslwh55mvFJMAJxDaPNzw7roCnSIqXQOBvU1FyT5NjNZaGECFBBtLssYxdfYnbE5KuEz/xM=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:300c:869a:ec89:df82])
 (user=pcc job=sendgmr) by 2002:a0c:99d2:: with SMTP id y18mr1380806qve.8.1613110546423;
 Thu, 11 Feb 2021 22:15:46 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:15:37 -0800
Message-Id: <51dbab807a063b05bd9fbf37b9333a1a20cc15fc.1613110413.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v7 1/3] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
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
v7:
- drop CONFIG_ARM64_NEED_SCTLR_USER

 arch/arm64/include/asm/mte.h       |  4 ---
 arch/arm64/include/asm/processor.h |  6 +++-
 arch/arm64/kernel/mte.c            | 47 ++++++------------------------
 arch/arm64/kernel/process.c        | 30 +++++++++++++++----
 4 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index d02aff9f493d..4e807969e767 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -42,7 +42,6 @@ void mte_free_tag_storage(char *storage);
 void mte_sync_tags(pte_t *ptep, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void flush_mte_state(void);
-void mte_thread_switch(struct task_struct *next);
 void mte_suspend_exit(void);
 long set_mte_ctrl(struct task_struct *task, unsigned long arg);
 long get_mte_ctrl(struct task_struct *task);
@@ -65,9 +64,6 @@ static inline void mte_copy_page_tags(void *kto, const void *kfrom)
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
index dc9ada64feed..48e8a75288a0 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -158,26 +158,6 @@ void mte_enable_kernel(void)
 	isb();
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
 
@@ -210,21 +190,12 @@ void flush_mte_state(void)
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
@@ -235,7 +206,7 @@ void mte_suspend_exit(void)
 
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 {
-	u64 tcf0;
+	u64 sctlr = task->thread.sctlr_user & ~SCTLR_EL1_TCF0_MASK;
 	u64 gcr_excl = ~((arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT) &
 		       SYS_GCR_EL1_EXCL_MASK;
 
@@ -244,23 +215,23 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 
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
 
@@ -277,7 +248,7 @@ long get_mte_ctrl(struct task_struct *task)
 
 	ret = incl << PR_MTE_TAG_SHIFT;
 
-	switch (task->thread.sctlr_tcf0) {
+	switch (task->thread.sctlr_user & SCTLR_EL1_TCF0_MASK) {
 	case SCTLR_EL1_TCF0_NONE:
 		ret |= PR_MTE_TCF_NONE;
 		break;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6616486a58fe..1d44c8597463 100644
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
2.30.0.478.g8a0d178c01-goog

