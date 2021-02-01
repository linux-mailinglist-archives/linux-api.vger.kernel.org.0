Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7630B091
	for <lists+linux-api@lfdr.de>; Mon,  1 Feb 2021 20:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhBATmt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Feb 2021 14:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBATml (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Feb 2021 14:42:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A9C061573;
        Mon,  1 Feb 2021 11:42:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id s24so225082pjp.5;
        Mon, 01 Feb 2021 11:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQLuUgJy+o1hW9AunpfEc1qlY4Nc1HNzMaooRQ/maGI=;
        b=c+2FqPenYDUXmY2kNElCjc1zpbv1nfM3B2pKaKRri5HOpiZXABTyHA/PQlo65RJr+Z
         14Pt8sXeP01DXpN2ebzEEbqt4n938aJ3hopdR7MCIZlmle6G3XvdFqZapeDec2yFUeUJ
         0avNYAVfgR+txKKakSpI+lBCzfKr//gTUa7x9uJ2gwwFu8V7eldlnJMjKhTgEnsQzER7
         d0L/5h4KFw/n8EMVErFTT/nrrzJtdlioCpEas5H7QzuuqaU1bqnMPpsf4yAQNMLU6zax
         /VMRyu313OLhK+I5lm57OtJpwofCPks0qjOWNX6mDMCAkxinGN7D9Mg5wEdg4IHQRdeX
         6g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQLuUgJy+o1hW9AunpfEc1qlY4Nc1HNzMaooRQ/maGI=;
        b=Me/jWZJqp3DRHh6WtxlJaqashfDB0RgB6RhW9fIR5z7xbmmJVRm1f5FUbTeY9XwOFA
         hZWqHiZy688Y/K9nBWoQCVpnCb4LWYMBDpcc+X8eyx5gxVyn9Sqj129H+im6iIO23E7X
         HycM2Bb/Hbihh/+7ovGT32Q5qOPp03zYrEc0oczc6855wkV6IbQSOEu8xf/udWyLnT77
         A23uq5NhECABuVWTYwQsYOFXqIinIuzN/sF45Jw4VoBbmk5RsnA9ns7CfcG5nbwf2vWE
         /S5uPxn4j/zG3K2hqXT4UMo4Otq6r4Fom5cApzkJMzS4pQJUH+Xy+CIcMpjPsTv64jgx
         h58w==
X-Gm-Message-State: AOAM5300LVvJShndznNrBDJ7T7IOtyEFI+5slzUSXX8YZOeyWGzTmcjP
        3uwtXvstDl3z+liCU+6CJn0=
X-Google-Smtp-Source: ABdhPJyUpFpB8WB7DGdGa42I0331TOpmj95xQ5DyrrcB4Il8FwZOLlGyylyvihXjujMle9NwJNLgTA==
X-Received: by 2002:a17:902:7d96:b029:e0:151c:598b with SMTP id a22-20020a1709027d96b02900e0151c598bmr18881431plm.2.1612208519740;
        Mon, 01 Feb 2021 11:41:59 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id i4sm18213155pfo.40.2021.02.01.11.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:41:59 -0800 (PST)
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
Subject: [PATCH 1/3] arm64/ptrace: don't clobber task registers on syscall entry/exit traps
Date:   Mon,  1 Feb 2021 11:40:10 -0800
Message-Id: <20210201194012.524831-2-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201194012.524831-1-avagin@gmail.com>
References: <20210201194012.524831-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

ip/r12 for AArch32 and x7 for AArch64 is used to indicate whether or not
the stop has been signalled from syscall entry or syscall exit. This
means that:

- Any writes by the tracer to this register during the stop are
  ignored/discarded.

- The actual value of the register is not available during the stop,
  so the tracer cannot save it and restore it later.

Right now, these registers are clobbered in tracehook_report_syscall.
This change moves the logic to gpr_get and compat_gpr_get where
registers are copied into a user-space buffer.

This will allow to change these registers and to introduce a new
ptrace option to get the full set of registers.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/asm/ptrace.h |   5 ++
 arch/arm64/kernel/ptrace.c      | 104 ++++++++++++++++++++------------
 2 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e58bca832dff..0a9552b4f61e 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -170,6 +170,11 @@ static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)
 	return psr;
 }
 
+enum ptrace_syscall_dir {
+	PTRACE_SYSCALL_ENTER = 0,
+	PTRACE_SYSCALL_EXIT,
+};
+
 /*
  * This struct defines the way the registers are stored on the stack during an
  * exception. Note that sizeof(struct pt_regs) has to be a multiple of 16 (for
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 8ac487c84e37..39da03104528 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -40,6 +40,7 @@
 #include <asm/syscall.h>
 #include <asm/traps.h>
 #include <asm/system_misc.h>
+#include <asm/ptrace.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -561,7 +562,31 @@ static int gpr_get(struct task_struct *target,
 		   struct membuf to)
 {
 	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
-	return membuf_write(&to, uregs, sizeof(*uregs));
+	unsigned long saved_reg;
+	int ret;
+
+	/*
+	 * We have some ABI weirdness here in the way that we handle syscall
+	 * exit stops because we indicate whether or not the stop has been
+	 * signalled from syscall entry or syscall exit by clobbering the general
+	 * purpose register x7.
+	 */
+	saved_reg = uregs->regs[7];
+
+	switch (target->ptrace_message) {
+	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+		uregs->regs[7] = PTRACE_SYSCALL_ENTER;
+		break;
+	case PTRACE_EVENTMSG_SYSCALL_EXIT:
+		uregs->regs[7] = PTRACE_SYSCALL_EXIT;
+		break;
+	}
+
+	ret =  membuf_write(&to, uregs, sizeof(*uregs));
+
+	uregs->regs[7] = saved_reg;
+
+	return ret;
 }
 
 static int gpr_set(struct task_struct *target, const struct user_regset *regset,
@@ -575,6 +600,17 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	if (ret)
 		return ret;
 
+	/*
+	 * Historically, x7 can't be changed if the stop has been signalled
+	 * from syscall-enter of syscall-exit.
+	 */
+	switch (target->ptrace_message) {
+	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+	case PTRACE_EVENTMSG_SYSCALL_EXIT:
+		newregs.regs[7] = task_pt_regs(target)->regs[7];
+		break;
+	}
+
 	if (!valid_user_regs(&newregs, target))
 		return -EINVAL;
 
@@ -1206,6 +1242,20 @@ static inline compat_ulong_t compat_get_user_reg(struct task_struct *task, int i
 	struct pt_regs *regs = task_pt_regs(task);
 
 	switch (idx) {
+	case 12:
+		/*
+		 * We have some ABI weirdness here in the way that we handle
+		 * syscall exit stops because we indicate whether or not the
+		 * stop has been signalled from syscall entry or syscall exit
+		 * by clobbering the general purpose register r12.
+		 */
+		switch (task->ptrace_message) {
+		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+			return PTRACE_SYSCALL_ENTER;
+		case PTRACE_EVENTMSG_SYSCALL_EXIT:
+			return PTRACE_SYSCALL_EXIT;
+		}
+		return regs->regs[idx];
 	case 15:
 		return regs->pc;
 	case 16:
@@ -1282,6 +1332,17 @@ static int compat_gpr_set(struct task_struct *target,
 
 	}
 
+	/*
+	 * Historically, x12 can't be changed if the stop has been signalled
+	 * from syscall-enter of syscall-exit.
+	 */
+	switch (target->ptrace_message) {
+	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+	case PTRACE_EVENTMSG_SYSCALL_EXIT:
+		newregs.regs[12] = task_pt_regs(target)->regs[12];
+		break;
+	}
+
 	if (valid_user_regs(&newregs.user_regs, target))
 		*task_pt_regs(target) = newregs;
 	else
@@ -1740,53 +1801,16 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ptrace_request(child, request, addr, data);
 }
 
-enum ptrace_syscall_dir {
-	PTRACE_SYSCALL_ENTER = 0,
-	PTRACE_SYSCALL_EXIT,
-};
-
 static void tracehook_report_syscall(struct pt_regs *regs,
 				     enum ptrace_syscall_dir dir)
 {
-	int regno;
-	unsigned long saved_reg;
-
-	/*
-	 * We have some ABI weirdness here in the way that we handle syscall
-	 * exit stops because we indicate whether or not the stop has been
-	 * signalled from syscall entry or syscall exit by clobbering a general
-	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
-	 * and restoring its old value after the stop. This means that:
-	 *
-	 * - Any writes by the tracer to this register during the stop are
-	 *   ignored/discarded.
-	 *
-	 * - The actual value of the register is not available during the stop,
-	 *   so the tracer cannot save it and restore it later.
-	 *
-	 * - Syscall stops behave differently to seccomp and pseudo-step traps
-	 *   (the latter do not nobble any registers).
-	 */
-	regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[regno];
-	regs->regs[regno] = dir;
-
 	if (dir == PTRACE_SYSCALL_ENTER) {
 		if (tracehook_report_syscall_entry(regs))
 			forget_syscall(regs);
-		regs->regs[regno] = saved_reg;
-	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
-		tracehook_report_syscall_exit(regs, 0);
-		regs->regs[regno] = saved_reg;
 	} else {
-		regs->regs[regno] = saved_reg;
+		int singlestep = test_thread_flag(TIF_SINGLESTEP);
 
-		/*
-		 * Signal a pseudo-step exception since we are stepping but
-		 * tracer modifications to the registers may have rewound the
-		 * state machine.
-		 */
-		tracehook_report_syscall_exit(regs, 1);
+		tracehook_report_syscall_exit(regs, singlestep);
 	}
 }
 
-- 
2.29.2

