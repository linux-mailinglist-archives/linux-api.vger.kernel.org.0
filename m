Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0862CD206
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 10:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbgLCJFC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 04:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgLCJFA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 04:05:00 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8EBC061A52
        for <linux-api@vger.kernel.org>; Thu,  3 Dec 2020 01:04:20 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id my8so36109pjb.3
        for <linux-api@vger.kernel.org>; Thu, 03 Dec 2020 01:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KbARISkg9PR9dGpEGEUDQHcWVKcB/0bRiyQZ/ocP8cM=;
        b=VwaIXwV6O8zdiC+E5Nw+pBzlPO06cD4bSs2mHv+Q9c5K53t8od9MPQ8AANLKIXm6hL
         Hv/AUrgFPDMRO9qFH1jX2saAU82kMa5rPWIZjqFqyuJD4DWKXY7dVH7Ch/lF7NxjmoA/
         mzTS7i2Zsj2lB4xj6nnQlXDGiuYMVFN2eSFqZY5QjhAeR7fyib/J/AuZfM5nr0QBkj4Y
         dQQ707VtM17JdPyZhNFORB930zsU130VdSpS2SkBgLPWzNzueUTfMZqPhWhlWK4w6qia
         AQH9dbOIncKfTnzWtcJf2h5xtZhOc0Xt9i7hUn4ve9Nq60ZzJcGHW9EApAW/lyT9Fo8w
         MypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KbARISkg9PR9dGpEGEUDQHcWVKcB/0bRiyQZ/ocP8cM=;
        b=H1RqgkfSZyy6DRUcPK4pcWxWHbbliHmZB3kfgSZOOTQuvY4z4QusX5Y2MuEc1g/f++
         kaUr6gX/Ll+DRO+KfreXF96REelAfh1/ai4NHTJUeLsuJjXg4aMiaOdpXGkyBuKVNBaB
         TytialdvC/FCn/Zb7vV1LkUpsr1VLmP2fc6OcGv/Qglj7DNjRf7acz1/VPvpUg+Vt91t
         euS2HOXZGLlLkUEdpl6kFS0BxNeSpB85i2v8nE/9Ax2f7ajUh1Oj8LqUKdzJlq7In/fA
         yTRWB5c1E6G6fCGdmON3mrzQhNfeZnSkatodRzBYELq3eGDEBBfq/z6qiSBoCD+QaKP8
         dO2g==
X-Gm-Message-State: AOAM530uE/1p5mpARwtKT0USViQhRzUBv1vds/eGrK1XciMrNMuR8zMR
        BQE+pOTFGlRlshZ5MbyjMcephU4=
X-Google-Smtp-Source: ABdhPJxD55spOv87lOBTH1Gg2d221WJnVVlu9jvD3eRbxq7AMAZS2+6ywYvjpvnJCK9V0pp/kjVPhgg=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:90a:fb97:: with SMTP id
 cp23mr2183686pjb.215.1606986259246; Thu, 03 Dec 2020 01:04:19 -0800 (PST)
Date:   Thu,  3 Dec 2020 01:04:11 -0800
Message-Id: <d7b22bd755e464cc22d47c585c60a13b53cffea7.1606985721.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v5 1/2] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
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
 arch/arm64/Kconfig                 |  4 +++
 arch/arm64/include/asm/mte.h       |  4 ---
 arch/arm64/include/asm/processor.h | 10 ++++++-
 arch/arm64/kernel/mte.c            | 47 ++++++------------------------
 arch/arm64/kernel/process.c        | 34 +++++++++++++++++----
 5 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c35e73efd407..21a289dcdf7d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -344,6 +344,9 @@ config KASAN_SHADOW_OFFSET
 	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
 	default 0xffffffffffffffff
 
+config ARM64_NEED_SCTLR_USER
+	bool
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Kernel Features"
@@ -1671,6 +1674,7 @@ config ARM64_MTE
 	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
 	depends on AS_HAS_ARMV8_5
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARM64_NEED_SCTLR_USER
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
 	  architectural support for run-time, always-on detection of
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
index e8cfc41a92d4..254c04b75879 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -153,11 +153,15 @@ struct thread_struct {
 	struct ptrauth_keys_kernel	keys_kernel;
 #endif
 #ifdef CONFIG_ARM64_MTE
-	u64			sctlr_tcf0;
 	u64			gcr_user_excl;
 #endif
+#ifdef CONFIG_ARM64_NEED_SCTLR_USER
+	u64			sctlr_user;
+#endif
 };
 
+#define SCTLR_USER_MASK SCTLR_EL1_TCF0_MASK
+
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
@@ -249,6 +253,10 @@ extern void release_thread(struct task_struct *);
 
 unsigned long get_wchan(struct task_struct *p);
 
+#ifdef CONFIG_ARM64_NEED_SCTLR_USER
+void set_task_sctlr_el1(u64 sctlr);
+#endif
+
 /* Thread switching */
 extern struct task_struct *cpu_switch_to(struct task_struct *prev,
 					 struct task_struct *next);
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index dbda6598c19d..8c5bf77a0b02 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -158,26 +158,6 @@ void mte_enable(void)
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
 		return PR_MTE_TCF_NONE;
 	case SCTLR_EL1_TCF0_SYNC:
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4784011cecac..47e3dfb5d4a9 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -542,6 +542,29 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
 	write_sysreg(val, cntkctl_el1);
 }
 
+#ifdef CONFIG_ARM64_NEED_SCTLR_USER
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
+#endif  /* CONFIG_ARM64_NEED_SCTLR_USER */
+
 /*
  * Thread switching.
  */
@@ -567,12 +590,11 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	dsb(ish);
 
-	/*
-	 * MTE thread switching must happen after the DSB above to ensure that
-	 * any asynchronous tag check faults have been logged in the TFSR*_EL1
-	 * registers.
-	 */
-	mte_thread_switch(next);
+#ifdef CONFIG_ARM64_NEED_SCTLR_USER
+	/* avoid expensive SCTLR_EL1 accesses if no change */
+	if (prev->thread.sctlr_user != next->thread.sctlr_user)
+		update_sctlr_el1(next->thread.sctlr_user);
+#endif
 
 	/* the actual thread switch */
 	last = cpu_switch_to(prev, next);
-- 
2.29.2.454.gaff20da3a2-goog

