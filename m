Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8CB2B1478
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 03:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKMCxv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 21:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMCxv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 21:53:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C7BC0613D1
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:53:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a126so8749672ybb.11
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QztXRcPk4d+xd9dmcuOkIa9fM1vyfckjDGQB4T/+WHg=;
        b=g3kRDcBiu1wlhyf8CB2RsNQnyBJHg11netMo7aeD2RszaCear2byCA/BgbGJP9OtuA
         RG/U+zIJ8h5FV5Rmk7x32FZ5urvpBhwaFoYVMGxgngbSoqCwdFUgMJipZGFqfyp3qeEV
         /zo401bgSZlmoiYVrt3KOHqgL1PuGRHKKxlgBTomMpKwT76XWAo52HeqgFNO63AnD94a
         CScI+4lJGb6CgDTOXwqqjijnV5KO2GR4oKN/ragb58leue7bTKFz9iGMb+LwCynp8E1N
         1YUgEqvXVazYRYbkvKXLrz3oyhMAYo9HTrX8Ou7XOSyTdWvUdm6PjKGFvq+KKbJQ/5SI
         NKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QztXRcPk4d+xd9dmcuOkIa9fM1vyfckjDGQB4T/+WHg=;
        b=gFr66eHxK53ByZvkx538Fnq6D/v1nPlri3l/CS/xK6umWtTJ9XK9PwTEQxJLVrYGS0
         wK8yuQLsLQHt0KkoTIRHgfmc29Dxqb5C00jOCwglVyvPsUE7Eg7ntTb56nlB5hwi05gL
         CfjYys1sAjsWVGhsqQfzefggGQsHNkCC/S7pf7kLMnCCZLpCPKoAJdh0HKayteEFnvEs
         8bjHacfFOQEBwDgu5kFj202EO+2rl24+0+M5S1p9KOvmNrVucniLl/taRB6bssE0nfjL
         7utfTftPqxEdTot9PasXWPdki0fRHTLGfyKbRUy9vm6AXF1PRPSElHjdE6er3ZXlkSFe
         duOw==
X-Gm-Message-State: AOAM532GfGDmEyrh3y7oQoc8QZHOZbpqBwwNe8KZOnS70KvA0wHPu3qB
        LUCHhtpfFe3yIaBojSkbWFp9MM8=
X-Google-Smtp-Source: ABdhPJyczbYlv1seWiMzq8Kx8Ix3igSdjcDTL8xsvj6Wky4XdP/dGvFXEPuTw6h812siGrXpplBqDeY=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:60d7:: with SMTP id u206mr67694ybb.315.1605236030131;
 Thu, 12 Nov 2020 18:53:50 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:53:34 -0800
In-Reply-To: <cover.1605235762.git.pcc@google.com>
Message-Id: <878dbcb5f47bc9b11881c81f745c0bef5c23f97f.1605235762.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1605235762.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v16 4/6] signal: clear non-uapi flag bits when
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
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
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
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
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
index ef8f2a28d37c..8f5bd12ee41b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3985,6 +3985,16 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
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
2.29.2.299.gdc1121823c-goog

