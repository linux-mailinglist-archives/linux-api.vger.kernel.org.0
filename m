Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50D2BA125
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 04:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgKTD35 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Nov 2020 22:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgKTD35 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Nov 2020 22:29:57 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADFFC0613CF
        for <linux-api@vger.kernel.org>; Thu, 19 Nov 2020 19:29:56 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y62so5731291pfg.13
        for <linux-api@vger.kernel.org>; Thu, 19 Nov 2020 19:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=olEIulL0UmBfXw7U+bYjpZB32LG7gHj2l5yAiBQ4mdA=;
        b=Fl019Mxon4X2MT/eGceZzjTGEDsC4Tj9TkNRCKDRMzzTGwWCS7h69l4uSbExid1tmT
         NvDfvSD7nlC2ye9mziZY/YblFY00+AtE5c6zNMA1TU/Dp5pyH/fywZ/Ue9jF8bfLppYH
         X5oPVjM6xAvAkwY0HgHro/GtZR5NIWMZUia4kxCdnsKlkle2aloDKExK0az3qzJZQsKH
         A10nNwavspHqVumbGfQQbxEFPqyBzzhIyWF39NDRLnwVio5L/GD8nz9ZSFsyRSRyHJhS
         NsZUuBcquq89gqPchqs6WGFiiUSeFPu4SjDVRF3Rd1QLvbPNHXXtBSAvdkKo5u+rhnK/
         1LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=olEIulL0UmBfXw7U+bYjpZB32LG7gHj2l5yAiBQ4mdA=;
        b=qKTk+Qj+hoZR1OOPKQLOqXT/elV2Pg0ITdhEDsC2EvdSg8T7fFqa2A7yRvl7eLcXr3
         HD/FFmFWzsPOizrvXCZ+0vi55iU9qDRaLk1MOluqJfnSb9tm7nnLzZ3BVvHbRwRQ0O81
         KNy0lEmeCRrO74fUrdzuaZNoMIPnvC378eVmecS25Io3a3TanlsAh7QgpubxBzciZBkI
         DIl2c1w7BKQ9ceWZ8P7MKyBOZAyky1RImqO+Sr1Ll1lEA/0xOnmrmPytbyCU3Z44QcAy
         FNjlsGsDYu919E1xbag3+nPYQYQ6mJ/1LUxmDUi/7W6B5ZsRD5Y/VPks6YeqcnjT8PEF
         RSNA==
X-Gm-Message-State: AOAM531Il0UCMtPcEjukTQfuCg4+3xTsquaKatBVrI0NB6U7MIu9OvaS
        YU5aLsGrv6MOvP2eCKeUiSi1X3w=
X-Google-Smtp-Source: ABdhPJw3jg+inNwg8DyR7i/DMkUMCDYGNOxEkf/FuSGzCaWI3Fkq4ayoGzR9O2EH56JZhCJgMDhs/Ec=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a05:6a00:2d9:b029:18e:f4a2:d1a7 with SMTP id
 b25-20020a056a0002d9b029018ef4a2d1a7mr12106632pft.75.1605842996312; Thu, 19
 Nov 2020 19:29:56 -0800 (PST)
Date:   Thu, 19 Nov 2020 19:29:46 -0800
Message-Id: <b584bf342a38580daa7aa73eda72184e9453a5e4.1605842067.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v4 1/2] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
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
 arch/arm64/include/asm/processor.h | 10 +++++++-
 arch/arm64/kernel/mte.c            | 40 +++++++-----------------------
 arch/arm64/kernel/process.c        | 29 ++++++++++++++++++++++
 4 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..68731cf8d822 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -343,6 +343,9 @@ config KASAN_SHADOW_OFFSET
 	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
 	default 0xffffffffffffffff
 
+config ARM64_NEED_SCTLR_USER
+	bool
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Kernel Features"
@@ -1666,6 +1669,7 @@ config ARM64_MTE
 	default y
 	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARM64_NEED_SCTLR_USER
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
 	  architectural support for run-time, always-on detection of
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fce8cbecd6bc..4d4f217034f8 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -153,11 +153,15 @@ struct thread_struct {
 	struct ptrauth_keys_kernel	keys_kernel;
 #endif
 #ifdef CONFIG_ARM64_MTE
-	u64			sctlr_tcf0;
 	u64			gcr_user_incl;
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
index 52a0638ed967..959c55862131 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -72,26 +72,6 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
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
 static void update_gcr_el1_excl(u64 incl)
 {
 	u64 excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
@@ -121,7 +101,8 @@ void flush_mte_state(void)
 	write_sysreg_s(0, SYS_TFSRE0_EL1);
 	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
 	/* disable tag checking */
-	set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);
+	set_task_sctlr_el1((current->thread.sctlr_user & ~SCTLR_EL1_TCF0_MASK) |
+			   SCTLR_EL1_TCF0_NONE);
 	/* reset tag generation mask */
 	set_gcr_el1_excl(0);
 }
@@ -131,9 +112,6 @@ void mte_thread_switch(struct task_struct *next)
 	if (!system_supports_mte())
 		return;
 
-	/* avoid expensive SCTLR_EL1 accesses if no change */
-	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
-		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
 	update_gcr_el1_excl(next->thread.gcr_user_incl);
 }
 
@@ -147,7 +125,7 @@ void mte_suspend_exit(void)
 
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 {
-	u64 tcf0;
+	u64 sctlr = task->thread.sctlr_user & ~SCTLR_EL1_TCF0_MASK;
 	u64 gcr_incl = (arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT;
 
 	if (!system_supports_mte())
@@ -155,23 +133,23 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 
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
 		task->thread.gcr_user_incl = gcr_incl;
 	} else {
-		set_sctlr_el1_tcf0(tcf0);
+		set_task_sctlr_el1(sctlr);
 		set_gcr_el1_excl(gcr_incl);
 	}
 
@@ -187,7 +165,7 @@ long get_mte_ctrl(struct task_struct *task)
 
 	ret = task->thread.gcr_user_incl << PR_MTE_TAG_SHIFT;
 
-	switch (task->thread.sctlr_tcf0) {
+	switch (task->thread.sctlr_user & SCTLR_EL1_TCF0_MASK) {
 	case SCTLR_EL1_TCF0_NONE:
 		return PR_MTE_TCF_NONE;
 	case SCTLR_EL1_TCF0_SYNC:
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a47a40ec6ad9..f3d53d2aad81 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -541,6 +541,29 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
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
@@ -566,6 +589,12 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	dsb(ish);
 
+#ifdef CONFIG_ARM64_NEED_SCTLR_USER
+	/* avoid expensive SCTLR_EL1 accesses if no change */
+	if (prev->thread.sctlr_user != next->thread.sctlr_user)
+		update_sctlr_el1(next->thread.sctlr_user);
+#endif
+
 	/*
 	 * MTE thread switching must happen after the DSB above to ensure that
 	 * any asynchronous tag check faults have been logged in the TFSR*_EL1
-- 
2.29.2.454.gaff20da3a2-goog

