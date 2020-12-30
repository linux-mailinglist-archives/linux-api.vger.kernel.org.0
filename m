Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144312E76B6
	for <lists+linux-api@lfdr.de>; Wed, 30 Dec 2020 08:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL3HAC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Dec 2020 02:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3HAC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Dec 2020 02:00:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530A4C061799
        for <linux-api@vger.kernel.org>; Tue, 29 Dec 2020 22:59:22 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id g7so3365815pji.0
        for <linux-api@vger.kernel.org>; Tue, 29 Dec 2020 22:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3ISa5VFbwsut7bhqIlwNTXJxogR0co5WGuyU1zP5Xno=;
        b=rE84mAIQ/tfJ5SR4luLHJlo9r0zpuwBdqEnI3CKZB9tYzvDGNrPezKps0dhGO7JgUn
         9oYTFDwohXYqQEq3qjdx6DEi9vVpnp70FtdWOSi19v7GMaxQGFQ5N9KwR+iPa6u8WYR1
         utFDWF3rNB2Q/47p8ljX2dUrlGtoZVXMnMpOuVtmsa2uQj5TQk5loAI67J4DrcDjKU1U
         H33MI16AfAPuo/xe0Sxx+ZK5WYVgyTBXQqnbYhW3A5lJgAN0jBKoJD0O1UNzEVWofrgr
         v7H4hzVt+wPYEeaXIypeLfJJOIBIa4zyxyPt6SIRnK2iS0Fgh9TVNIUoOu7p1p9/x5lN
         JDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3ISa5VFbwsut7bhqIlwNTXJxogR0co5WGuyU1zP5Xno=;
        b=AR9rwx845/puhqqeSi5lxMj9FYN2qbsZMqMVh/TNVCJ0lrvwtJ1Gz0SwOfqFknnFCX
         g4lR7XytVnvD7Ov/IBoFby8w9+w8y6r5TEe+jo9zRoAp1UYKrTyikBQg3xdsxTqUcDG8
         3s9JPLpx0i7umbWkdxSCm3SHnDAcEK/csz4ml1/AQGZv637VZx8y+L26Acnjp7CWEmpV
         mhBUOnhP1OnVnDkmTbRHhoX96S6mz5morQjUWWN8t3NiR49ldaMEnvpqrJCEWs2nxGhP
         GrHjQXNNvcxpH8eEqKIr7rF0TgWH6Va4pwJPvjMvcG5FeTqpLKbDCX4DhR4hlBq5Y1F5
         Gljw==
X-Gm-Message-State: AOAM533RV58GboY6+sFIfYbsrsUswYyFohIrpY89BPsIMiCBsXzvsr2R
        +15vaHeF+vDdWpSL7RAlvFRxGL4=
X-Google-Smtp-Source: ABdhPJyDiyr5GkPcwXkpHfOiGEOT/joN2GkhDApltIFUeS6z4RGhbLJRCKnVXl2hScFSiPlSdDzYZRM=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:902:b203:b029:dc:973:3ad0 with SMTP id
 t3-20020a170902b203b02900dc09733ad0mr51770439plr.44.1609311561639; Tue, 29
 Dec 2020 22:59:21 -0800 (PST)
Date:   Tue, 29 Dec 2020 22:59:13 -0800
Message-Id: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v6 1/3] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
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
index 05e17351e4f3..82e38d1ca012 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -348,6 +348,9 @@ config KASAN_SHADOW_OFFSET
 	default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
 	default 0xffffffffffffffff
 
+config ARM64_NEED_SCTLR_USER
+	bool
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Kernel Features"
@@ -1653,6 +1656,7 @@ config ARM64_MTE
 	# Required for tag checking in the uaccess routines
 	depends on ARM64_PAN
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
index ca2cd75d3286..3287d8888b24 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -151,11 +151,15 @@ struct thread_struct {
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
@@ -247,6 +251,10 @@ extern void release_thread(struct task_struct *);
 
 unsigned long get_wchan(struct task_struct *p);
 
+#ifdef CONFIG_ARM64_NEED_SCTLR_USER
+void set_task_sctlr_el1(u64 sctlr);
+#endif
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
index 6616486a58fe..2c4b8194adae 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -529,6 +529,29 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
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
@@ -553,12 +576,11 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
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
2.29.2.729.g45daf8777d-goog

