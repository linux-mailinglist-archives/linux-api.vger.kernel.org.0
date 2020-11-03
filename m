Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818F72A3B4F
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 05:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgKCEKQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Nov 2020 23:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEKP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Nov 2020 23:10:15 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7DC0617A6
        for <linux-api@vger.kernel.org>; Mon,  2 Nov 2020 20:10:15 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id dd7so9527073qvb.6
        for <linux-api@vger.kernel.org>; Mon, 02 Nov 2020 20:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wiOdp88P/BG6VMM4mtlTh6YUDgvCN8JARGfeK5h8OQo=;
        b=Z0oxPU81Fkr1VM1Zt3giA88xp03+jjvXYyJVUGIOE3EjPepRgvssEj/DAfvegATbpC
         8S7EWypII9Z+nGq3HimSdAZBzddoHk1KQL6PYBJ3inyRG4C0yN6hDa9Y/E8cIfjtLM+O
         ebJtBYpmAFYVBQ0VypkiujvyFmjiTITy+85PM1C5gtaMo8VahsgzysLVgdLcmGijjwxj
         1RK+33b4rApf5fqcjKFWBTa9eB0gPCngbq+Y1QjobGBGZ9izhyfOBWiQ+v+sLX3wY+v3
         v2APhG6ExmIeOLSZ2zEKuLJceCPo4whoRbnCIsbavrFX6z3dgLlkmWowOqnKnjkL7BT8
         5khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wiOdp88P/BG6VMM4mtlTh6YUDgvCN8JARGfeK5h8OQo=;
        b=X0TyJWmb6kfbGrzwh3F4OYxxlHMmtmu9jHg3fKrVKWo3s7PAc7xuhza57pLQl+OB3b
         AJRFUqypZAmXv5Ehvwe5Umkod37201HozdegOMMI3uTE98n4436mxWYwRJ7Zzn+BcED8
         jPWe1bK1DLgNoPaBovYOcjzUvTzmRrwgAQ9aLxpufZq6JzV5sw44cVM01cyLbSPLKdZa
         VZWVejzjdK/LhAALs4XnVFgiFJfJl6e/jR9Yuh6bmtary7qdbBn5Q+x9u2NEAfcnGm3u
         if8XlRXFP2v3MOnqLFl2GP5MLLqHL2vydzP2Uz6y8tHAcHfGf7HVuD7bhfQzqmBlZFtt
         0lbw==
X-Gm-Message-State: AOAM532+YdLFlBjpJOwwNj29k6dsgvAliO6rr5VntAWO3huqqlAEHcQc
        CkClbSR4CsHJxYb9hLdieJRRFAQ=
X-Google-Smtp-Source: ABdhPJyEwDQDdqIUPXWBsRmP9iWUgBiVMZsjgdisqiRBZcYfNoqdKzq/5cPfHg71xXCQwcsrqOXZj40=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a0c:da8b:: with SMTP id z11mr18079383qvj.40.1604376614863;
 Mon, 02 Nov 2020 20:10:14 -0800 (PST)
Date:   Mon,  2 Nov 2020 20:09:42 -0800
In-Reply-To: <cover.1604376407.git.pcc@google.com>
Message-Id: <03ef1475a4f28ba1098089ad9eebc6a3a1a17209.1604376407.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604376407.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v13 6/8] signal: deduplicate code dealing with common
 _sigfault fields
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

We're about to add more common _sigfault fields, so deduplicate the
existing code for initializing _sigfault fields in {send,force}_sig_*,
and for copying _sigfault fields in copy_siginfo_to_external32 and
post_copy_siginfo_from_user32, to reduce the number of places that
will need to be updated by upcoming changes.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I4f56174e1b7b2bf4a3c8139e6879cbfd52750a24
---
 include/linux/signal.h |  13 ++++++
 kernel/signal.c        | 101 ++++++++++++++++-------------------------
 2 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index b256f9c65661..e9fb05041e7a 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -50,6 +50,19 @@ enum siginfo_layout {
 
 enum siginfo_layout siginfo_layout(unsigned sig, int si_code);
 
+static inline bool siginfo_layout_is_fault(enum siginfo_layout layout)
+{
+	switch (layout) {
+	case SIL_FAULT:
+	case SIL_FAULT_MCEERR:
+	case SIL_FAULT_BNDERR:
+	case SIL_FAULT_PKUERR:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Define some primitives to manipulate sigset_t.
  */
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f34819e80de..d18930aafbf4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1650,6 +1650,15 @@ void force_sigsegv(int sig)
 	force_sig(SIGSEGV);
 }
 
+static void set_sigfault_common_fields(struct kernel_siginfo *info, int sig,
+				       int code, void __user *addr)
+{
+	info->si_signo = sig;
+	info->si_errno = 0;
+	info->si_code = code;
+	info->si_addr = addr;
+}
+
 int force_sig_fault_to_task(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
@@ -1658,10 +1667,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 	struct kernel_siginfo info;
 
 	clear_siginfo(&info);
-	info.si_signo = sig;
-	info.si_errno = 0;
-	info.si_code  = code;
-	info.si_addr  = addr;
+	set_sigfault_common_fields(&info, sig, code, addr);
 #ifdef __ARCH_SI_TRAPNO
 	info.si_trapno = trapno;
 #endif
@@ -1690,10 +1696,7 @@ int send_sig_fault(int sig, int code, void __user *addr
 	struct kernel_siginfo info;
 
 	clear_siginfo(&info);
-	info.si_signo = sig;
-	info.si_errno = 0;
-	info.si_code  = code;
-	info.si_addr  = addr;
+	set_sigfault_common_fields(&info, sig, code, addr);
 #ifdef __ARCH_SI_TRAPNO
 	info.si_trapno = trapno;
 #endif
@@ -1711,10 +1714,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
 
 	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
 	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = code;
-	info.si_addr = addr;
+	set_sigfault_common_fields(&info, SIGBUS, code, addr);
 	info.si_addr_lsb = lsb;
 	return force_sig_info(&info);
 }
@@ -1725,10 +1725,7 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
 
 	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
 	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = code;
-	info.si_addr = addr;
+	set_sigfault_common_fields(&info, SIGBUS, code, addr);
 	info.si_addr_lsb = lsb;
 	return send_sig_info(info.si_signo, &info, t);
 }
@@ -1739,10 +1736,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 	struct kernel_siginfo info;
 
 	clear_siginfo(&info);
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_code  = SEGV_BNDERR;
-	info.si_addr  = addr;
+	set_sigfault_common_fields(&info, SIGSEGV, SEGV_BNDERR, addr);
 	info.si_lower = lower;
 	info.si_upper = upper;
 	return force_sig_info(&info);
@@ -1754,10 +1748,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 	struct kernel_siginfo info;
 
 	clear_siginfo(&info);
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_code  = SEGV_PKUERR;
-	info.si_addr  = addr;
+	set_sigfault_common_fields(&info, SIGSEGV, SEGV_PKUERR, addr);
 	info.si_pkey  = pkey;
 	return force_sig_info(&info);
 }
@@ -1771,10 +1762,8 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
 	struct kernel_siginfo info;
 
 	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
+	set_sigfault_common_fields(&info, SIGTRAP, TRAP_HWBKPT, addr);
 	info.si_errno = errno;
-	info.si_code  = TRAP_HWBKPT;
-	info.si_addr  = addr;
 	return force_sig_info(&info);
 }
 
@@ -3267,12 +3256,23 @@ int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
 void copy_siginfo_to_external32(struct compat_siginfo *to,
 		const struct kernel_siginfo *from)
 {
+	enum siginfo_layout layout =
+		siginfo_layout(from->si_signo, from->si_code);
+
 	memset(to, 0, sizeof(*to));
 
 	to->si_signo = from->si_signo;
 	to->si_errno = from->si_errno;
 	to->si_code  = from->si_code;
-	switch(siginfo_layout(from->si_signo, from->si_code)) {
+
+	if (siginfo_layout_is_fault(layout)) {
+		to->si_addr = ptr_to_compat(from->si_addr);
+#ifdef __ARCH_SI_TRAPNO
+		to->si_trapno = from->si_trapno;
+#endif
+	}
+
+	switch (layout) {
 	case SIL_KILL:
 		to->si_pid = from->si_pid;
 		to->si_uid = from->si_uid;
@@ -3287,31 +3287,15 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		to->si_fd   = from->si_fd;
 		break;
 	case SIL_FAULT:
-		to->si_addr = ptr_to_compat(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		break;
 	case SIL_FAULT_MCEERR:
-		to->si_addr = ptr_to_compat(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_addr_lsb = from->si_addr_lsb;
 		break;
 	case SIL_FAULT_BNDERR:
-		to->si_addr = ptr_to_compat(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_lower = ptr_to_compat(from->si_lower);
 		to->si_upper = ptr_to_compat(from->si_upper);
 		break;
 	case SIL_FAULT_PKUERR:
-		to->si_addr = ptr_to_compat(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_pkey = from->si_pkey;
 		break;
 	case SIL_CHLD:
@@ -3348,11 +3332,22 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
 static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 					 const struct compat_siginfo *from)
 {
+	enum siginfo_layout layout =
+		siginfo_layout(from->si_signo, from->si_code);
+
 	clear_siginfo(to);
 	to->si_signo = from->si_signo;
 	to->si_errno = from->si_errno;
 	to->si_code  = from->si_code;
-	switch(siginfo_layout(from->si_signo, from->si_code)) {
+
+	if (siginfo_layout_is_fault(layout)) {
+		to->si_addr = compat_ptr(from->si_addr);
+#ifdef __ARCH_SI_TRAPNO
+		to->si_trapno = from->si_trapno;
+#endif
+	}
+
+	switch (layout) {
 	case SIL_KILL:
 		to->si_pid = from->si_pid;
 		to->si_uid = from->si_uid;
@@ -3367,31 +3362,15 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		to->si_fd   = from->si_fd;
 		break;
 	case SIL_FAULT:
-		to->si_addr = compat_ptr(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		break;
 	case SIL_FAULT_MCEERR:
-		to->si_addr = compat_ptr(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_addr_lsb = from->si_addr_lsb;
 		break;
 	case SIL_FAULT_BNDERR:
-		to->si_addr = compat_ptr(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_lower = compat_ptr(from->si_lower);
 		to->si_upper = compat_ptr(from->si_upper);
 		break;
 	case SIL_FAULT_PKUERR:
-		to->si_addr = compat_ptr(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_pkey = from->si_pkey;
 		break;
 	case SIL_CHLD:
-- 
2.29.1.341.ge80a0c044ae-goog

