Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E514F34135F
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 04:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhCSDLP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Mar 2021 23:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhCSDLG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Mar 2021 23:11:06 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE19C06174A
        for <linux-api@vger.kernel.org>; Thu, 18 Mar 2021 20:11:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v136so33074595qkb.9
        for <linux-api@vger.kernel.org>; Thu, 18 Mar 2021 20:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BJHNeqQDLW5ACx+McYD14wYIv9UOyih/aWTkaBW70O4=;
        b=vLLPq9A1q5bywvJZyLfkR1JzazxXX4mRGXrkjlwr2NrRrVAAeChy9wcGdW6IYEtKKf
         rN7lK4/Q7uhUsWaWJHhubbsnNclkvKqchB+gw0vshFr21humtA1TtJIN/79BUICV3h8T
         KMicEsjYAR283ySA8Z6mzl+qtTlt/+eY+Jrf9n2KYybgxChBEwXBS4dwuPlnuxqX81M0
         K9VNVKoNedgrAsKLDmhQuNlLelyN+auRnX/kgIpxeWdL5x1IXbwnUQi7GEuctKFXlqIT
         /jFUdXHPx43dXUIC1Wp0cnE6p+nkH6+LREQ9/REt7HDVGkg7igY1bIrLJlOIbooaBBKN
         SGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BJHNeqQDLW5ACx+McYD14wYIv9UOyih/aWTkaBW70O4=;
        b=dIJJ2L0TWKHuABpu6khl8gRlMcNVphpYt6Zc5rrIJQ3n/KOlUrGn83LlZ2GBk9NPjF
         Baw0ukgUjtO8FcJfXF3oxm4WWPY8SBLPkQJMcnrZEgegaMgDEfUYl+CnkFUb1QgEls23
         XXKZBEj3OuiqYehWj5HkERRj6tRfixXm5Q1GENq/JHii4hsmf+/E5BVgs8R5gBw/2NkI
         O7pE3gwN3OE/N9cOIblf1ab6vZ5lnMu/XVM5VsHgzciUE+e6rVqRrrTEA+LUz/e+QQyV
         8EPIXGi2rXFc1e7J4MoFd0fLt8gJBH6mCmGWSXhuj0zKyo7os1gyVJrEKCTJrFaPthEa
         9GUA==
X-Gm-Message-State: AOAM5333koOuWRA8GT41fIlOEpF9bojF3F0ySJXzyTPiPk4rtvKpWgbv
        KQkuuoVKH5f28uXOdmM2nH8piYA=
X-Google-Smtp-Source: ABdhPJyPsv1kzNeth0gIFVMwUWeakWh5cPGmwQKrq8LWnFiL/jdH3HL0NPcBHI5ql++QrWNpPXPFl/I=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:455:89c6:cb5a:9b7f])
 (user=pcc job=sendgmr) by 2002:a05:6214:f6d:: with SMTP id
 iy13mr7384358qvb.24.1616123465898; Thu, 18 Mar 2021 20:11:05 -0700 (PDT)
Date:   Thu, 18 Mar 2021 20:10:54 -0700
In-Reply-To: <13d725cb8e741950fb9d6e64b2cd9bd54ff7c3f9.1616123271.git.pcc@google.com>
Message-Id: <2d653d055f38f779937f2b92f8ddd5cf9e4af4f4.1616123271.git.pcc@google.com>
Mime-Version: 1.0
References: <13d725cb8e741950fb9d6e64b2cd9bd54ff7c3f9.1616123271.git.pcc@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 3/3] arm64: pac: Optimize kernel entry/exit key
 installation code paths
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

The kernel does not use any keys besides IA so we don't need to
install IB/DA/DB/GA on kernel exit if we arrange to install them
on task switch instead, which we can expect to happen an order of
magnitude less often.

Furthermore we can avoid installing the user IA in the case where the
user task has IA disabled and just leave the kernel IA installed. This
also lets us avoid needing to install IA on kernel entry.

On an Apple M1 under a hypervisor, the overhead of kernel entry/exit
has been measured to be reduced by 15.6ns in the case where IA is
enabled, and 31.9ns in the case where IA is disabled.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ieddf6b580d23c9e0bed45a822dabe72d2ffc9a8e
---
v8:
- rebase to 5.12-rc3

 arch/arm64/include/asm/asm_pointer_auth.h | 20 +------------
 arch/arm64/include/asm/pointer_auth.h     | 36 ++++++++++++++++++-----
 arch/arm64/kernel/asm-offsets.c           |  4 ---
 arch/arm64/kernel/entry.S                 | 33 ++++++++++++---------
 arch/arm64/kernel/pointer_auth.c          |  1 +
 arch/arm64/kernel/process.c               |  1 +
 arch/arm64/kernel/suspend.c               |  3 +-
 7 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/include/asm/asm_pointer_auth.h b/arch/arm64/include/asm/asm_pointer_auth.h
index 52dead2a8640..8ca2dc0661ee 100644
--- a/arch/arm64/include/asm/asm_pointer_auth.h
+++ b/arch/arm64/include/asm/asm_pointer_auth.h
@@ -13,30 +13,12 @@
  * so use the base value of ldp as thread.keys_user and offset as
  * thread.keys_user.ap*.
  */
-	.macro ptrauth_keys_install_user tsk, tmp1, tmp2, tmp3
+	.macro __ptrauth_keys_install_user tsk, tmp1, tmp2, tmp3
 	mov	\tmp1, #THREAD_KEYS_USER
 	add	\tmp1, \tsk, \tmp1
-alternative_if_not ARM64_HAS_ADDRESS_AUTH
-	b	.Laddr_auth_skip_\@
-alternative_else_nop_endif
 	ldp	\tmp2, \tmp3, [\tmp1, #PTRAUTH_USER_KEY_APIA]
 	msr_s	SYS_APIAKEYLO_EL1, \tmp2
 	msr_s	SYS_APIAKEYHI_EL1, \tmp3
-	ldp	\tmp2, \tmp3, [\tmp1, #PTRAUTH_USER_KEY_APIB]
-	msr_s	SYS_APIBKEYLO_EL1, \tmp2
-	msr_s	SYS_APIBKEYHI_EL1, \tmp3
-	ldp	\tmp2, \tmp3, [\tmp1, #PTRAUTH_USER_KEY_APDA]
-	msr_s	SYS_APDAKEYLO_EL1, \tmp2
-	msr_s	SYS_APDAKEYHI_EL1, \tmp3
-	ldp	\tmp2, \tmp3, [\tmp1, #PTRAUTH_USER_KEY_APDB]
-	msr_s	SYS_APDBKEYLO_EL1, \tmp2
-	msr_s	SYS_APDBKEYHI_EL1, \tmp3
-.Laddr_auth_skip_\@:
-alternative_if ARM64_HAS_GENERIC_AUTH
-	ldp	\tmp2, \tmp3, [\tmp1, #PTRAUTH_USER_KEY_APGA]
-	msr_s	SYS_APGAKEYLO_EL1, \tmp2
-	msr_s	SYS_APGAKEYHI_EL1, \tmp3
-alternative_else_nop_endif
 	.endm
 
 	.macro __ptrauth_keys_install_kernel_nosync tsk, tmp1, tmp2, tmp3
diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index cefe7e9b6fa9..d50416be99be 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -35,6 +35,25 @@ struct ptrauth_keys_kernel {
 	struct ptrauth_key apia;
 };
 
+#define __ptrauth_key_install_nosync(k, v)			\
+do {								\
+	struct ptrauth_key __pki_v = (v);			\
+	write_sysreg_s(__pki_v.lo, SYS_ ## k ## KEYLO_EL1);	\
+	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
+} while (0)
+
+static inline void ptrauth_keys_install_user(struct ptrauth_keys_user *keys)
+{
+	if (system_supports_address_auth()) {
+		__ptrauth_key_install_nosync(APIB, keys->apib);
+		__ptrauth_key_install_nosync(APDA, keys->apda);
+		__ptrauth_key_install_nosync(APDB, keys->apdb);
+	}
+
+	if (system_supports_generic_auth())
+		__ptrauth_key_install_nosync(APGA, keys->apga);
+}
+
 static inline void ptrauth_keys_init_user(struct ptrauth_keys_user *keys)
 {
 	if (system_supports_address_auth()) {
@@ -46,14 +65,9 @@ static inline void ptrauth_keys_init_user(struct ptrauth_keys_user *keys)
 
 	if (system_supports_generic_auth())
 		get_random_bytes(&keys->apga, sizeof(keys->apga));
-}
 
-#define __ptrauth_key_install_nosync(k, v)			\
-do {								\
-	struct ptrauth_key __pki_v = (v);			\
-	write_sysreg_s(__pki_v.lo, SYS_ ## k ## KEYLO_EL1);	\
-	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
-} while (0)
+	ptrauth_keys_install_user(keys);
+}
 
 static __always_inline void ptrauth_keys_init_kernel(struct ptrauth_keys_kernel *keys)
 {
@@ -90,6 +104,9 @@ static __always_inline void ptrauth_enable(void)
 	isb();
 }
 
+#define ptrauth_suspend_exit()                                                 \
+	ptrauth_keys_install_user(&current->thread.keys_user)
+
 #define ptrauth_thread_init_user()                                             \
 	do {                                                                   \
 		ptrauth_keys_init_user(&current->thread.keys_user);            \
@@ -101,6 +118,9 @@ static __always_inline void ptrauth_enable(void)
 					   SCTLR_ELx_ENDA | SCTLR_ELx_ENDB);   \
 	} while (0)
 
+#define ptrauth_thread_switch_user(tsk)                                        \
+	ptrauth_keys_install_user(&(tsk)->thread.keys_user)
+
 #define ptrauth_thread_init_kernel(tsk)					\
 	ptrauth_keys_init_kernel(&(tsk)->thread.keys_kernel)
 #define ptrauth_thread_switch_kernel(tsk)				\
@@ -112,8 +132,10 @@ static __always_inline void ptrauth_enable(void)
 #define ptrauth_set_enabled_keys(tsk, keys, enabled)	(-EINVAL)
 #define ptrauth_get_enabled_keys(tsk)	(-EINVAL)
 #define ptrauth_strip_insn_pac(lr)	(lr)
+#define ptrauth_suspend_exit()
 #define ptrauth_thread_init_user()
 #define ptrauth_thread_init_kernel(tsk)
+#define ptrauth_thread_switch_user(tsk)
 #define ptrauth_thread_switch_kernel(tsk)
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8b4fbad427b3..a02573c32f79 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -148,10 +148,6 @@ int main(void)
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
   DEFINE(PTRAUTH_USER_KEY_APIA,		offsetof(struct ptrauth_keys_user, apia));
-  DEFINE(PTRAUTH_USER_KEY_APIB,		offsetof(struct ptrauth_keys_user, apib));
-  DEFINE(PTRAUTH_USER_KEY_APDA,		offsetof(struct ptrauth_keys_user, apda));
-  DEFINE(PTRAUTH_USER_KEY_APDB,		offsetof(struct ptrauth_keys_user, apdb));
-  DEFINE(PTRAUTH_USER_KEY_APGA,		offsetof(struct ptrauth_keys_user, apga));
   DEFINE(PTRAUTH_KERNEL_KEY_APIA,	offsetof(struct ptrauth_keys_kernel, apia));
   BLANK();
 #endif
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 36ae1cdfaeb6..2e46c75a5b48 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -247,21 +247,26 @@ alternative_else_nop_endif
 	check_mte_async_tcf x19, x22
 	apply_ssbd 1, x22, x23
 
-	ptrauth_keys_install_kernel_nosync tsk, x20, x22, x23
-
 #ifdef CONFIG_ARM64_PTR_AUTH
 alternative_if ARM64_HAS_ADDRESS_AUTH
 	/*
 	 * Enable IA for in-kernel PAC if the task had it disabled. Although
 	 * this could be implemented with an unconditional MRS which would avoid
 	 * a load, this was measured to be slower on Cortex-A75 and Cortex-A76.
+	 *
+	 * Install the kernel IA key only if IA was enabled in the task. If IA
+	 * was disabled on kernel exit then we would have left the kernel IA
+	 * installed so there is no need to install it again.
 	 */
 	ldr	x0, [tsk, THREAD_SCTLR_USER]
-	tbnz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
+	tbz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
+	__ptrauth_keys_install_kernel_nosync tsk, x20, x22, x23
+	b	2f
+1:
 	mrs	x0, sctlr_el1
 	orr	x0, x0, SCTLR_ELx_ENIA
 	msr	sctlr_el1, x0
-1:
+2:
 	isb
 alternative_else_nop_endif
 #endif
@@ -368,24 +373,24 @@ alternative_else_nop_endif
 3:
 	scs_save tsk, x0
 
-	/*
-	 * No kernel C function calls after this as user keys are set and IA may
-	 * be disabled.
-	 */
-	ptrauth_keys_install_user tsk, x0, x1, x2
-
 #ifdef CONFIG_ARM64_PTR_AUTH
 alternative_if ARM64_HAS_ADDRESS_AUTH
 	/*
-	 * IA was enabled for in-kernel PAC. Disable it now if needed.
-	 * All other per-task SCTLR bits were updated on task switch.
+	 * IA was enabled for in-kernel PAC. Disable it now if needed, or
+	 * alternatively install the user's IA. All other per-task keys and
+	 * SCTLR bits were updated on task switch.
+	 *
+	 * No kernel C function calls after this.
 	 */
 	ldr	x0, [tsk, THREAD_SCTLR_USER]
-	tbnz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
+	tbz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
+	__ptrauth_keys_install_user tsk, x0, x1, x2
+	b	2f
+1:
 	mrs	x0, sctlr_el1
 	bic	x0, x0, SCTLR_ELx_ENIA
 	msr	sctlr_el1, x0
-1:
+2:
 alternative_else_nop_endif
 #endif
 
diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
index f03e5bfe4490..60901ab0a7fe 100644
--- a/arch/arm64/kernel/pointer_auth.c
+++ b/arch/arm64/kernel/pointer_auth.c
@@ -43,6 +43,7 @@ int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
 		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
 	if (arg & PR_PAC_APGAKEY)
 		get_random_bytes(&keys->apga, sizeof(keys->apga));
+	ptrauth_keys_install_user(keys);
 
 	return 0;
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7cf46509e46b..0ccae6a53b9d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -568,6 +568,7 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	entry_task_switch(next);
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(prev, next);
+	ptrauth_thread_switch_user(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index d7564891ffe1..0525c3a3c3f8 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -74,8 +74,9 @@ void notrace __cpu_suspend_exit(void)
 	 */
 	spectre_v4_enable_mitigation(NULL);
 
-	/* Restore additional MTE-specific configuration */
+	/* Restore additional feature-specific configuration */
 	mte_suspend_exit();
+	ptrauth_suspend_exit();
 }
 
 /*
-- 
2.31.0.rc2.261.g7f71774620-goog

