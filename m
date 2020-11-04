Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439DA2A6F78
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 22:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgKDVS3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 16:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDVS3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 16:18:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3466C0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 13:18:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c196so136021ybf.0
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 13:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4D7Q2kZ3L7YBvRzuP8i1p6TftH53P5xo5cWP8p2xBcs=;
        b=Rmav60W+RCIT2LWA2rZ8FJfCiKqCs+BcZaagAHdLyU7ZWJGfDkLcL8cb0d8pdgG60Z
         Z2JffzIBG6dSLtIZMiuMmzMdJOwM+8H1QmM2KiWAxHsGcK2pZ37irAwkaBH9ebMwd785
         kgA5sLQ+wgPkXyeaewPpPM/J//nS+YODNqspdh6Ui5Sd/bvAG0GyFEp8Cfy4WmQ+rBgk
         dweykfNEfOxiGgawsm2cdgk1cw01rob6cov3VHHE1WMPWLeBBtlMMvRMd/+zY9MZEnPz
         Vr2pqDYoX5CjaCVFT5Q5a2k+UaOyizffKHEEPa/MZmNjwKbjDANXQJdJYstBK75O7m9N
         cz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4D7Q2kZ3L7YBvRzuP8i1p6TftH53P5xo5cWP8p2xBcs=;
        b=cNN4CjkZO03xD2yrapu3SLNF0vnvXDxhuPaBVjY72GoMUYA6Qps6KJkFQrLEFkkHpY
         Q251AgDJ6zgfjvJiblssSC1D256UjLribDumEIqjvTlfhbafhSju04nN3DWn04ix9H/c
         j5KtweII1QGjx6D3buytCK6Au44ObPn/WOgk+KgJIs/f5hyEoi6yZZziSXEzA71iT3/k
         FKrTGIPt3Ig4O5aBmGuwSAQ2ilNebG/lA8YN5XvioZxblvfzsuIioXQB/b6oMRlmppiz
         7q5DJk14z7UDgKx8ZNWxT3SFXT79rZNaQz2N50j/OkRRxf2RcQ0NnrzP8XZys6E9Q1Yi
         cvlg==
X-Gm-Message-State: AOAM531k66ZZXIWzDbLUqVm5NQ0xj5Xus5kKni/5ZqO5WEGxQLmZkCKb
        LL3W6A+Qgr3Hjw8izJoCOMfIZ6k=
X-Google-Smtp-Source: ABdhPJxCMjn3XEy0/8f51pRz3bV7jkfFqDLqs9/bfY94sEGmhkUmhkE3HKdEBSeU0CZpyiHs8RCZHYQ=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:b851:: with SMTP id b17mr7525251ybm.15.1604524708250;
 Wed, 04 Nov 2020 13:18:28 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:18:08 -0800
In-Reply-To: <cover.1604523707.git.pcc@google.com>
Message-Id: <039adb228822eb1f0c90cbfc716fc28fa298c58e.1604523707.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604523707.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v14 5/8] signal: clear non-uapi flag bits when
 passing/returning sa_flags
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

Previously we were not clearing non-uapi flag bits in
sigaction.sa_flags when storing the userspace-provided sa_flags or
when returning them via oldact. Start doing so.

This allows userspace to detect missing support for flag bits and
allows the kernel to use non-uapi bits internally, as we are already
doing in arch/x86 for two flag bits. Now that this change is in
place, we no longer need the code in arch/x86 that was hiding these
bits from userspace, so remove it.

This is technically a userspace-visible behavior change for sigaction, as
the unknown bits returned via oldact.sa_flags are no longer set. However,
we are free to define the behavior for unknown bits exactly because
their behavior is currently undefined, so for now we can define the
meaning of each of them to be "clear the bit in oldact.sa_flags unless
the bit becomes known in the future". Furthermore, this behavior is
consistent with OpenBSD [1], illumos [2] and XNU [3] (FreeBSD [4] and
NetBSD [5] fail the syscall if unknown bits are set). So there is some
precedent for this behavior in other kernels, and in particular in XNU,
which is probably the most popular kernel among those that I looked at,
which means that this change is less likely to be a compatibility issue.

Link: [1] https://github.com/openbsd/src/blob/f634a6a4b5bf832e9c1de77f7894ae2625e74484/sys/kern/kern_sig.c#L278
Link: [2] https://github.com/illumos/illumos-gate/blob/76f19f5fdc974fe5be5c82a556e43a4df93f1de1/usr/src/uts/common/syscall/sigaction.c#L86
Link: [3] https://github.com/apple/darwin-xnu/blob/a449c6a3b8014d9406c2ddbdc81795da24aa7443/bsd/kern/kern_sig.c#L480
Link: [4] https://github.com/freebsd/freebsd/blob/eded70c37057857c6e23fae51f86b8f8f43cd2d0/sys/kern/kern_sig.c#L699
Link: [5] https://github.com/NetBSD/src/blob/3365779becdcedfca206091a645a0e8e22b2946e/sys/kern/sys_sig.c#L473
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Link: https://linux-review.googlesource.com/id/I35aab6f5be932505d90f3b3450c083b4db1eca86
---
v10:
- rename SA_UAPI_FLAGS -> UAPI_SA_FLAGS
- refactor how we define it to avoid mentioning flags more
  than once

 arch/arm/include/asm/signal.h    |  2 ++
 arch/parisc/include/asm/signal.h |  2 ++
 arch/x86/kernel/signal_compat.c  |  7 -------
 include/linux/signal_types.h     | 12 ++++++++++++
 kernel/signal.c                  | 10 ++++++++++
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/signal.h b/arch/arm/include/asm/signal.h
index 65530a042009..430be7774402 100644
--- a/arch/arm/include/asm/signal.h
+++ b/arch/arm/include/asm/signal.h
@@ -17,6 +17,8 @@ typedef struct {
 	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
 
+#define __ARCH_UAPI_SA_FLAGS	(SA_THIRTYTWO | SA_RESTORER)
+
 #define __ARCH_HAS_SA_RESTORER
 
 #include <asm/sigcontext.h>
diff --git a/arch/parisc/include/asm/signal.h b/arch/parisc/include/asm/signal.h
index 715c96ba2ec8..30dd1e43ef88 100644
--- a/arch/parisc/include/asm/signal.h
+++ b/arch/parisc/include/asm/signal.h
@@ -21,6 +21,8 @@ typedef struct {
 	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
 
+#define __ARCH_UAPI_SA_FLAGS	_SA_SIGGFAULT
+
 #include <asm/sigcontext.h>
 
 #endif /* !__ASSEMBLY */
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a7f3e12cfbdb..ddfd919be46c 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -165,16 +165,9 @@ void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
 {
 	signal_compat_build_tests();
 
-	/* Don't leak in-kernel non-uapi flags to user-space */
-	if (oact)
-		oact->sa.sa_flags &= ~(SA_IA32_ABI | SA_X32_ABI);
-
 	if (!act)
 		return;
 
-	/* Don't let flags to be set from userspace */
-	act->sa.sa_flags &= ~(SA_IA32_ABI | SA_X32_ABI);
-
 	if (in_ia32_syscall())
 		act->sa.sa_flags |= SA_IA32_ABI;
 	if (in_x32_syscall())
diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
index f8a90ae9c6ec..a7887ad84d36 100644
--- a/include/linux/signal_types.h
+++ b/include/linux/signal_types.h
@@ -68,4 +68,16 @@ struct ksignal {
 	int sig;
 };
 
+#ifndef __ARCH_UAPI_SA_FLAGS
+#ifdef SA_RESTORER
+#define __ARCH_UAPI_SA_FLAGS	SA_RESTORER
+#else
+#define __ARCH_UAPI_SA_FLAGS	0
+#endif
+#endif
+
+#define UAPI_SA_FLAGS                                                          \
+	(SA_NOCLDSTOP | SA_NOCLDWAIT | SA_SIGINFO | SA_ONSTACK | SA_RESTART |  \
+	 SA_NODEFER | SA_RESETHAND | __ARCH_UAPI_SA_FLAGS)
+
 #endif /* _LINUX_SIGNAL_TYPES_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index 74e7315c24db..832b654dee8c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3964,6 +3964,16 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	if (oact)
 		*oact = *k;
 
+	/*
+	 * Clear unknown flag bits in order to allow userspace to detect missing
+	 * support for flag bits and to allow the kernel to use non-uapi bits
+	 * internally.
+	 */
+	if (act)
+		act->sa.sa_flags &= UAPI_SA_FLAGS;
+	if (oact)
+		oact->sa.sa_flags &= UAPI_SA_FLAGS;
+
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
-- 
2.29.1.341.ge80a0c044ae-goog

