Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079B930B090
	for <lists+linux-api@lfdr.de>; Mon,  1 Feb 2021 20:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBATms (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Feb 2021 14:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBATml (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Feb 2021 14:42:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F0FC06174A;
        Mon,  1 Feb 2021 11:42:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id my11so436335pjb.1;
        Mon, 01 Feb 2021 11:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54HaqmXpfsd5zEV3HoPbFBl5GxWxzwJ8Zfrym0Khwo8=;
        b=DyokyQNh+PByr5WdoEJ15eDHP6uAClVcSsLQ8bJfzh7+fb6F0petWfGhE1b3rAuRxR
         rn1mQWomuvuuT6ar9JJJuTmEOVpAuIPYfh+gL2YOFHqV7rF6KK0JhQE4dC7ZzNMu9iFs
         PAd8op3ZxMXLDcBS7VvG4BSq5Kvl5/+7zFFQpMaQeJITXQXKdBxIuOFAn3YOOGzHZc0Y
         WUc/8air7gZV6G4ruIthZlHHhhKmTEbNrzqQ9v9TLa47mfTNKeBJXMJ8ODkKUMsfdQNq
         9chTAtxh1A+ZzQkZOekFDQFt9WedIlOVbNAwAGsgOoqk1qmLBwho0B62/G4h9DMdHOKP
         2+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54HaqmXpfsd5zEV3HoPbFBl5GxWxzwJ8Zfrym0Khwo8=;
        b=QEmc0gYjM0cRHmRxWgZ36Bb4648SsEMfT+grQytJDdbA0+H87k7XxzjBdXO655y+y4
         c65DfrBt0uOy45kekAF+l8xj2RwRMuwny+cn+rrkHEgA7fXXma769z0GV2UGFgFJRjaV
         0/NlzKfM4z5EN5F7saMcZXDce0T5AZUfKuqNs3cK4tlxZEab5eVik2pNj/khXJZIIKa/
         RUsPXDwV/LtoA6Cw4NKUHyTy/k8rtuDgYc8QogqgJxAu1i1fmbP8Y0k14kU91F/EYNnH
         Ou6RBJ++3dpxxG7H97/RQ7K5F+4pGSZHnWeJmhk+U5FkHvCEd1dcc1dFURUmGCTrZx2L
         CByQ==
X-Gm-Message-State: AOAM530Xn8BjVUrQ3kdoxQT1r1oMoalnsSdEvWmquqX28mlEWxQNv2f1
        WPBabmdPh/XIxmEFTR6bB6A=
X-Google-Smtp-Source: ABdhPJwfWrhxZkDE5l0bwgoiSOHOseDRKOL8wG7innfO3wgvBgOKr7r36RB2BQhqZUrDBbueiCpj5Q==
X-Received: by 2002:a17:90b:4b86:: with SMTP id lr6mr444008pjb.107.1612208521215;
        Mon, 01 Feb 2021 11:42:01 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id i4sm18213155pfo.40.2021.02.01.11.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:42:00 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH 2/3] arm64/ptrace: introduce PTRACE_O_ARM64_RAW_REGS
Date:   Mon,  1 Feb 2021 11:40:11 -0800
Message-Id: <20210201194012.524831-3-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201194012.524831-1-avagin@gmail.com>
References: <20210201194012.524831-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

We have some ABI weirdness in the way that we handle syscall
exit stops because we indicate whether or not the stop has been
signalled from syscall entry or syscall exit by clobbering a general
purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
and restoring its old value after the stop.

This behavior was inherited from ARM and it isn't common for other
architectures. Now, we have PTRACE_GET_SYSCALL_INFO that gives all
required information about system calls, so the hack with clobbering
registers isn't needed anymore.

This change adds the new ptrace option PTRACE_O_ARM64_RAW_REGS.  If it
is set, PTRACE_GETREGSET returns values of all registers without
clobbering r12 or x7 and PTRACE_SETREGSE sets all registers even if a
process has been stopped in syscall-enter or syscall-exit.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/uapi/asm/ptrace.h |  4 ++
 arch/arm64/kernel/ptrace.c           | 70 ++++++++++++++++------------
 include/linux/ptrace.h               |  1 +
 include/uapi/linux/ptrace.h          |  9 +++-
 4 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 758ae984ff97..465cc9713895 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -109,6 +109,10 @@ struct user_hwdebug_state {
 	}		dbg_regs[16];
 };
 
+#define PTRACE_O_ARM64_RAW_REGS	(1 << 28)
+
+#define _PTRACE_O_ARCH_OPTIONS PTRACE_O_ARM64_RAW_REGS
+
 /* SVE/FP/SIMD state (NT_ARM_SVE) */
 
 struct user_sve_header {
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 39da03104528..591a4478ad76 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -565,21 +565,23 @@ static int gpr_get(struct task_struct *target,
 	unsigned long saved_reg;
 	int ret;
 
-	/*
-	 * We have some ABI weirdness here in the way that we handle syscall
-	 * exit stops because we indicate whether or not the stop has been
-	 * signalled from syscall entry or syscall exit by clobbering the general
-	 * purpose register x7.
-	 */
 	saved_reg = uregs->regs[7];
 
-	switch (target->ptrace_message) {
-	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
-		uregs->regs[7] = PTRACE_SYSCALL_ENTER;
-		break;
-	case PTRACE_EVENTMSG_SYSCALL_EXIT:
-		uregs->regs[7] = PTRACE_SYSCALL_EXIT;
-		break;
+	if (!(target->ptrace & PT_ARM64_RAW_REGS)) {
+		/*
+		 * We have some ABI weirdness here in the way that we handle
+		 * syscall exit stops because we indicate whether or not the
+		 * stop has been signalled from syscall entry or syscall exit
+		 * by clobbering the general purpose register x7.
+		 */
+		switch (target->ptrace_message) {
+		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+			uregs->regs[7] = PTRACE_SYSCALL_ENTER;
+			break;
+		case PTRACE_EVENTMSG_SYSCALL_EXIT:
+			uregs->regs[7] = PTRACE_SYSCALL_EXIT;
+			break;
+		}
 	}
 
 	ret =  membuf_write(&to, uregs, sizeof(*uregs));
@@ -600,15 +602,17 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	if (ret)
 		return ret;
 
-	/*
-	 * Historically, x7 can't be changed if the stop has been signalled
-	 * from syscall-enter of syscall-exit.
-	 */
-	switch (target->ptrace_message) {
-	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
-	case PTRACE_EVENTMSG_SYSCALL_EXIT:
-		newregs.regs[7] = task_pt_regs(target)->regs[7];
-		break;
+	if (!(target->ptrace & PT_ARM64_RAW_REGS)) {
+		/*
+		 * Historically, x7 can't be changed if the stop has been
+		 * signalled from syscall-enter of syscall-exit.
+		 */
+		switch (target->ptrace_message) {
+		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+		case PTRACE_EVENTMSG_SYSCALL_EXIT:
+			newregs.regs[7] = task_pt_regs(target)->regs[7];
+			break;
+		}
 	}
 
 	if (!valid_user_regs(&newregs, target))
@@ -1243,6 +1247,8 @@ static inline compat_ulong_t compat_get_user_reg(struct task_struct *task, int i
 
 	switch (idx) {
 	case 12:
+		if (task->ptrace & PT_ARM64_RAW_REGS)
+			return regs->regs[idx];
 		/*
 		 * We have some ABI weirdness here in the way that we handle
 		 * syscall exit stops because we indicate whether or not the
@@ -1332,15 +1338,17 @@ static int compat_gpr_set(struct task_struct *target,
 
 	}
 
-	/*
-	 * Historically, x12 can't be changed if the stop has been signalled
-	 * from syscall-enter of syscall-exit.
-	 */
-	switch (target->ptrace_message) {
-	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
-	case PTRACE_EVENTMSG_SYSCALL_EXIT:
-		newregs.regs[12] = task_pt_regs(target)->regs[12];
-		break;
+	if (!(target->ptrace & PT_ARM64_RAW_REGS)) {
+		/*
+		 * Historically, r12 can't be changed if the stop has been
+		 * signalled from syscall-enter of syscall-exit.
+		 */
+		switch (target->ptrace_message) {
+		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+		case PTRACE_EVENTMSG_SYSCALL_EXIT:
+			newregs.regs[12] = task_pt_regs(target)->regs[12];
+			break;
+		}
 	}
 
 	if (valid_user_regs(&newregs.user_regs, target))
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 2a9df80ea887..987d6ec5f0ce 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -46,6 +46,7 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
+#define PT_ARM64_RAW_REGS	(PTRACE_O_ARM64_RAW_REGS << PT_OPT_FLAG_SHIFT)
 
 /* single stepping state bits (used on ARM and PA-RISC) */
 #define PT_SINGLESTEP_BIT	31
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 83ee45fa634b..bcc8c362ddd9 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -7,6 +7,7 @@
 /* has the defines to get at the registers. */
 
 #include <linux/types.h>
+#include <asm/ptrace.h>
 
 #define PTRACE_TRACEME		   0
 #define PTRACE_PEEKTEXT		   1
@@ -137,8 +138,14 @@ struct ptrace_syscall_info {
 #define PTRACE_O_EXITKILL		(1 << 20)
 #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
 
+/* (1<<28) is reserved for arch specific options. */
+#ifndef _PTRACE_O_ARCH_OPTIONS
+#define _PTRACE_O_ARCH_OPTIONS 0
+#endif
+
 #define PTRACE_O_MASK		(\
-	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
+	0x000000ff | PTRACE_O_EXITKILL | \
+	PTRACE_O_SUSPEND_SECCOMP | _PTRACE_O_ARCH_OPTIONS)
 
 #include <asm/ptrace.h>
 
-- 
2.29.2

