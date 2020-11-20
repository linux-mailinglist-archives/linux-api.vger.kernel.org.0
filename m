Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1F2BB715
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 21:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbgKTUeB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 15:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbgKTUeB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 15:34:01 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD133C0613CF
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 12:34:00 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id l3so7311378ply.6
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HUyQwqda+W6FCUadbLHRIIKbkgk8bVAoQNFKxp4rBE8=;
        b=pJvXQOouCDYvrXgHCoJoq8yazaUcMG44tmjXqJbhdkFCUJfDOKDDMAelAV115b5BCP
         vbW+2ILhPUYvEIjFp1NTtu+AvdwttlZZcKsOaP/Fx73Ym/oC2UuM1p5tz0QVVYpI3Nup
         UY/u0BzsB+fPkER5Wt6cAVfofdZJMifgl0quzKBiAqPeBQtpPCDB3YSCcCLeNNwj5wDz
         x3ODyXspnhTyO0FZ0AC2xEmiuaQGBijfc3eTUVwXgCzXzs9AI/Z7wnubELX8Z7p5QkBa
         OfcoQZbLAG0h8JIvfohEOZRTXcabe40rYWJ270R5eXWHOdFUo7CHjR/2q6oY6jE7c7w7
         1B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HUyQwqda+W6FCUadbLHRIIKbkgk8bVAoQNFKxp4rBE8=;
        b=c51GMluZcf9Lo+sAwfyGI648wj2xKWjTwTTWSa2SEIbbD/cTOEJvsKmELPpIDKshk7
         pk4Z5Lh79uU7+uCkTXclBOVUgDxkJgBOMG/gU8imnm7dhACa5QXjNBa3fzVQmGVlTdiG
         KtVyReMmmj8YVRz84d1XkuGWWP71/b8/ngBqnoIitY9ErUIkcZASha4syIeapNjez4pa
         OT73dXJnGpilydgVGcMWeDqjOVVDetqy0LchIeD5Cp+rqPvhKqB0nUN9KkPN+5mfta0d
         Cqm3FXNgzFKZ1JkXj0xrh4sHblh+K2stw+DmvkdJICxMtWUtdfQVYBOpA/nD9DBxAAbI
         RvZA==
X-Gm-Message-State: AOAM533R4ge236g9wQXyea1iYuYoc6itZYjafofPohnV5oWnI0e7SXH6
        YwfAXeyfJeh2flWK8Dhx0uYJedw=
X-Google-Smtp-Source: ABdhPJw2M8qy6cVWBnbZzy673Gcd3QvhsRS3BGBI/+JkVE7xj6Th3BE4Z+//vmqOelsGAF5xsXNsuMw=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a05:6a00:794:b029:197:e418:ac4d with SMTP id
 g20-20020a056a000794b0290197e418ac4dmr1543533pfu.47.1605904440203; Fri, 20
 Nov 2020 12:34:00 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:33:45 -0800
Message-Id: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v21 1/2] signal: define the SA_EXPOSE_TAGBITS bit in sa_flags
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

Architectures that support address tagging, such as arm64, may want to
expose fault address tag bits to the signal handler to help diagnose
memory errors. However, these bits have not been previously set,
and their presence may confuse unaware user applications. Therefore,
introduce a SA_EXPOSE_TAGBITS flag bit in sa_flags that a signal
handler may use to explicitly request that the bits are set.

The generic signal handler APIs expect to receive tagged addresses.
Architectures may specify how to untag addresses in the case where
SA_EXPOSE_TAGBITS is clear by defining the arch_untagged_si_addr
function.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://linux-review.googlesource.com/id/I16dd0ed2081f091fce97be0190cb8caa874c26cb
---
To be applied on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11

 include/linux/signal.h                 | 14 ++++++++++++++
 include/linux/signal_types.h           |  2 +-
 include/uapi/asm-generic/signal-defs.h |  3 +++
 kernel/signal.c                        | 24 ++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index b256f9c65661..205526c4003a 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -469,4 +469,18 @@ struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
 #endif
 
+#ifndef arch_untagged_si_addr
+/*
+ * Given a fault address and a signal and si_code which correspond to the
+ * _sigfault union member, returns the address that must appear in si_addr if
+ * the signal handler does not have SA_EXPOSE_TAGBITS enabled in sa_flags.
+ */
+static inline void __user *arch_untagged_si_addr(void __user *addr,
+						 unsigned long sig,
+						 unsigned long si_code)
+{
+	return addr;
+}
+#endif
+
 #endif /* _LINUX_SIGNAL_H */
diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
index a7887ad84d36..68e06c75c5b2 100644
--- a/include/linux/signal_types.h
+++ b/include/linux/signal_types.h
@@ -78,6 +78,6 @@ struct ksignal {
 
 #define UAPI_SA_FLAGS                                                          \
 	(SA_NOCLDSTOP | SA_NOCLDWAIT | SA_SIGINFO | SA_ONSTACK | SA_RESTART |  \
-	 SA_NODEFER | SA_RESETHAND | __ARCH_UAPI_SA_FLAGS)
+	 SA_NODEFER | SA_RESETHAND | SA_EXPOSE_TAGBITS | __ARCH_UAPI_SA_FLAGS)
 
 #endif /* _LINUX_SIGNAL_TYPES_H */
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index c790f67304ba..fe929e7b77ca 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -20,6 +20,8 @@
  * so this bit allows flag bit support to be detected from userspace while
  * allowing an old kernel to be distinguished from a kernel that supports every
  * flag bit.
+ * SA_EXPOSE_TAGBITS exposes an architecture-defined set of tag bits in
+ * siginfo.si_addr.
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
@@ -41,6 +43,7 @@
 /* 0x00000100 used on sparc */
 /* 0x00000200 used on sparc */
 #define SA_UNSUPPORTED	0x00000400
+#define SA_EXPOSE_TAGBITS	0x00000800
 /* 0x00010000 used on mips */
 /* 0x01000000 used on x86 */
 /* 0x02000000 used on x86 */
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f34819e80de..26018c59821d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2524,6 +2524,26 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
 	return signr;
 }
 
+static void hide_si_addr_tag_bits(struct ksignal *ksig)
+{
+	switch (siginfo_layout(ksig->sig, ksig->info.si_code)) {
+	case SIL_FAULT:
+	case SIL_FAULT_MCEERR:
+	case SIL_FAULT_BNDERR:
+	case SIL_FAULT_PKUERR:
+		ksig->info.si_addr = arch_untagged_si_addr(
+			ksig->info.si_addr, ksig->sig, ksig->info.si_code);
+		break;
+	case SIL_KILL:
+	case SIL_TIMER:
+	case SIL_POLL:
+	case SIL_CHLD:
+	case SIL_RT:
+	case SIL_SYS:
+		break;
+	}
+}
+
 bool get_signal(struct ksignal *ksig)
 {
 	struct sighand_struct *sighand = current->sighand;
@@ -2761,6 +2781,10 @@ bool get_signal(struct ksignal *ksig)
 	spin_unlock_irq(&sighand->siglock);
 
 	ksig->sig = signr;
+
+	if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
+		hide_si_addr_tag_bits(ksig);
+
 	return ksig->sig > 0;
 }
 
-- 
2.29.2.454.gaff20da3a2-goog

