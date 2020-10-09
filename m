Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D767287F8D
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 02:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgJIAos (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Oct 2020 20:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIAos (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Oct 2020 20:44:48 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6EEC0613D2
        for <linux-api@vger.kernel.org>; Thu,  8 Oct 2020 17:44:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y24so4837965plr.20
        for <linux-api@vger.kernel.org>; Thu, 08 Oct 2020 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/Tg0+isY40zzcX4u+8DrhedSBR99PO26Ea0k6P5Awi8=;
        b=KzOFOFhP0w12CbuGoPhBuriUBv1rKrVddd3Xr1+mMW5rD38NYFSlg8jqcyStDq2qsS
         /wFdtjO34lg/43qZXOqJ+4v3uMSGsWr8hcRfHyp/NfjQnFhllXlFiXGp3n06D9xE+Rc2
         7ywakRtcxcvFL30P/f/x5/RzDN+s0oX+FIVqV5HixMPHLGHqMV0XJ59EVaHK6tw4+GW2
         8UuatoqpLDKZxYfo3Mb5b190rLsJyyqRg8FmBHimFYQpBXlg9qVvl42IfWejktwfWKIg
         zko2aIy6pT+IRkXBbaD88lgA/OluDAKs6ZLdYvMgmkx3iy4Bufuq5TDuh7XqYP+jAjwT
         TU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Tg0+isY40zzcX4u+8DrhedSBR99PO26Ea0k6P5Awi8=;
        b=a9ZWryOpdJ5741gMLjrnDfs0a+6DcZtSn4M72n8DLPGFnP7ftfBuVDQqnHSJWbKwzB
         AWjYJ6k7h1TlCoK3ZHJShGRWUSSmMlcf6BkMyw3H3pn5tgvZvhiu+95NgzPrX6lrqc3h
         Y2PT9iLPH9w5EcEGId+gq+nXSXwdc3k1cAp/j4RERCkulGDUJidSiWeYnWu3/k0kT4mK
         Ix1v90pud7Qy2n0mXpBZ9sFwg7gtr2YdVe3MNit+2hAbE995/LI//Dy0w1XXSuu1moi6
         cxUXrWRaEceU+9Vw/lAZ2O4gDHUUapkNHnOUIz74DCqh/tKJjHwlXb0efwETIaaviDNB
         RN8A==
X-Gm-Message-State: AOAM531MTax/+gAN+RaTVhXpa6p+Q1IamgXY1NCvXPY69tF0rcVggLf3
        EN9ngRCWbHshuzNaX5TcTZDddoY=
X-Google-Smtp-Source: ABdhPJyJw9Y14jDext5q4vs0sLqZAy6s3DZpAPXg6T/ZKylPG4ib/JpmWKIXZCFWLRNuAvnoQnM5W7g=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a63:4142:: with SMTP id o63mr1246784pga.337.1602204285832;
 Thu, 08 Oct 2020 17:44:45 -0700 (PDT)
Date:   Thu,  8 Oct 2020 17:44:17 -0700
In-Reply-To: <cover.1602204097.git.pcc@google.com>
Message-Id: <faf73e50de20aee54941e912975a85ea171aad35.1602204097.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602204097.git.pcc@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v11 6/8] signal: deduplicate code dealing with common
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
2.28.0.1011.ga647a8990f-goog

