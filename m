Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCFD290FDF
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436678AbgJQGBj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 02:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411574AbgJQGBg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 02:01:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E72C0613DC
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:57 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 1so2129038pgd.9
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u8/LRl2/qV4QI9xUjYWGrJSgKrHy7RyYkI/74EkmgQM=;
        b=lI9f0YYR3iGhBL4onJoktDCEPLFF2WT03PAbrCw866sSdfPfRuy0rHtCDRECK1Er2j
         8KbwdnlvHlP1WtM/3Si1EdkmA0ESPUbsZBRNWsSgt32mGgY+w89Kk3n96fCDG3h9kRID
         DQqVAjm61LOfBrwcwPqRSGm5P+0pPMPH0HS9AJhV1A7rJF3LH3/edwRzbou25JhfSI4K
         AjmKUMmuM4PaEH61jbvwyyeofnIpi1nbwN/jAoNX6LGae0GUtIWxZqsAjFfdtjsOqx8B
         6bWP4P4hw84PLAS2uTq0WAxk6kocPrPf6dtQKRFq0/j/yQ/KYKqeIJcRlVhvR2s4Yzl1
         bk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u8/LRl2/qV4QI9xUjYWGrJSgKrHy7RyYkI/74EkmgQM=;
        b=Ql199lo40sCcLcBK1EUCTQkCXaBQusvq9Fl1zW/AGmhc2k5EfJiCCGuUXW/2tfTbxR
         h+TFDPEx0XVHJ0I8vbkw2DnLz+9r7R6r0gJLjleB5p2bbSrjgxDRhXcl/zFRJfUlTaop
         LM4DqeqE+YUkyPpmFVERARE/NumW+at4kvdpZinOalDfP3osTIqR62jpgNt1tOZCe8mM
         UYaKNrmmTP6JeXrT+e6PTPl+xlghD3F5q/y+0+POZMnPznEiY7F7jkIzbG5tORxpZAOo
         NOX59jLMamokJDD5OtlyiGFtVXUG7k2LRyJrcdaD2+w1lBx5IxeE7AjZ9Fskj8lkWy5X
         +s/A==
X-Gm-Message-State: AOAM532kfbkxK+b3AmAfQPHlNa1xPYONBFafZfNkHUj5RjSPg6BF9srQ
        GtSvNRih0bQYqxaY328ZNuzB2fc=
X-Google-Smtp-Source: ABdhPJw2cdV6wyDbdnSSnQqUaSrIar3KYC+VaVtCNxLlTqE4vDyUvFyqMm5+5Qhy8mkNCfV9RPrhvME=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a62:7c09:0:b029:152:60c9:43b2 with SMTP id
 x9-20020a627c090000b029015260c943b2mr6090892pfc.79.1602893576611; Fri, 16 Oct
 2020 17:12:56 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:12:31 -0700
In-Reply-To: <cover.1602892799.git.pcc@google.com>
Message-Id: <3cabc4cf8ac3c7c9005df489625d26193c0db4c7.1602892799.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602892799.git.pcc@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v12 6/8] signal: deduplicate code dealing with common
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
index 7bbc0e9cf084..9b7fef0c559d 100644
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
index 018c19f6cf66..acdfd5a6d424 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1649,6 +1649,15 @@ void force_sigsegv(int sig)
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
@@ -1657,10 +1666,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
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
@@ -1689,10 +1695,7 @@ int send_sig_fault(int sig, int code, void __user *addr
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
@@ -1710,10 +1713,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
 
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
@@ -1724,10 +1724,7 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
 
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
@@ -1738,10 +1735,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
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
@@ -1753,10 +1747,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
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
@@ -1770,10 +1761,8 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
 	struct kernel_siginfo info;
 
 	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
+	set_sigfault_common_fields(&info, SIGTRAP, TRAP_HWBKPT, addr);
 	info.si_errno = errno;
-	info.si_code  = TRAP_HWBKPT;
-	info.si_addr  = addr;
 	return force_sig_info(&info);
 }
 
@@ -3266,12 +3255,23 @@ int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
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
@@ -3286,31 +3286,15 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
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
@@ -3347,11 +3331,22 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
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
@@ -3366,31 +3361,15 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
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
2.29.0.rc1.297.gfa9743e501-goog

