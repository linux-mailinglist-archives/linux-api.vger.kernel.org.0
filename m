Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5702A6F79
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgKDVSc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 16:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDVSc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 16:18:32 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F1C0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 13:18:30 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a27so13315pfl.17
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1F5n8xtS2dM5ch0WQR4OI0jZvv8gDSLIMGjbAJfRQFg=;
        b=VPeI7hVSTtcadpuYSXbsMJD0uZh0MTNOT604DbJ0REXA9KtSMpJXxnnvzlGmPNcjfc
         3g4xEqnW9WskyHOBXMpp3RxPuq6LWfnw8kWb4N0qb7bLSkWnf2tdW1wZjvP9Vc8R0Eoy
         X3kKwZDLgfV71dUon6XGaCSZrWDfr18NvCVrlLXaIz+VCZf3AL6eF5/NtBv8Ub2Bjna1
         QbvZRznDtO/LodA7h2+zj7mGdoHZknH/se8/HCQNEop+GG66u0q65jFGCWJFF28b95PI
         //ZoWTTUH6udZ/G3NDTywthSVZT+v9gmD+DpkMA/iqr360bkyRpEcfPpmiw28oVhihJi
         3RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1F5n8xtS2dM5ch0WQR4OI0jZvv8gDSLIMGjbAJfRQFg=;
        b=ocafVRloduWEfjpaVL+PBo+xXXtmsbONV91XH1RAIJVOw/IzyfxdxIvcELoCuvz+pC
         CsCVymk9dcIz5kkIa/rD1nLJ2QTa6RDg4ToGkhllgSQ5PLhGJcnZ3pT1RZD4jBRQtnpw
         DmURQ6I7BrNBE+KB6fqZTQXnLhIGmHPNIHvx4rxrFXc5YYTDw0/s3a3ObdZRNxCxBJjI
         2XlzgsmDYggoWCjSKsJ2AtpCBBYm987pwa1jtpLLMdbJAQT1nfp2b208VtmCoov44n94
         gK/X3Z+MLhXNRZAaplNVfk88tHzGRRwB+IX40HFlEL4WccRK/YTb6H5/UIMekCJpBiVH
         Oy8A==
X-Gm-Message-State: AOAM530iP5RrAWx6G52UZMuDdmjjyUWPEiECCUpKZI5cd+Cz0HQN/BZh
        mgAZZ5Jxn2+N0/vOxWKzVqgNQLk=
X-Google-Smtp-Source: ABdhPJxfFXRJAMUgdz1uktN8ikMzTi9fkdDEJI54Vm+4AUpSnekGYZn4MG1xizafJRvzrOq0L5Rb9AU=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:90b:46d7:: with SMTP id
 jx23mr6213173pjb.86.1604524710112; Wed, 04 Nov 2020 13:18:30 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:18:09 -0800
In-Reply-To: <cover.1604523707.git.pcc@google.com>
Message-Id: <87501c1e71b5a6ed96bb9b540718b0752d4d6fed.1604523707.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1604523707.git.pcc@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v14 6/8] signal: define the SA_UNSUPPORTED bit in sa_flags
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

Define a sa_flags bit, SA_UNSUPPORTED, which will never be supported
in the uapi. The purpose of this flag bit is to allow userspace to
distinguish an old kernel that does not clear unknown sa_flags bits
from a kernel that supports every flag bit.

In other words, if userspace does something like:

  act.sa_flags |= SA_UNSUPPORTED;
  sigaction(SIGSEGV, &act, 0);
  sigaction(SIGSEGV, 0, &oldact);

and finds that SA_UNSUPPORTED remains set in oldact.sa_flags, it means
that the kernel cannot be trusted to have cleared unknown flag bits
from sa_flags, so no assumptions about flag bit support can be made.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Link: https://linux-review.googlesource.com/id/Ic2501ad150a3a79c1cf27fb8c99be342e9dffbcb
---
v11:
- clarify the commit message

 include/uapi/asm-generic/signal-defs.h | 7 +++++++
 kernel/signal.c                        | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 493953fe319b..0126ebda4d31 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -14,6 +14,12 @@
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NODEFER prevents the current signal from being masked in the handler.
  * SA_RESETHAND clears the handler when the signal is delivered.
+ * SA_UNSUPPORTED is a flag bit that will never be supported. Kernels from
+ * before the introduction of SA_UNSUPPORTED did not clear unknown bits from
+ * sa_flags when read using the oldact argument to sigaction and rt_sigaction,
+ * so this bit allows flag bit support to be detected from userspace while
+ * allowing an old kernel to be distinguished from a kernel that supports every
+ * flag bit.
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
@@ -42,6 +48,7 @@
 #ifndef SA_RESETHAND
 #define SA_RESETHAND	0x80000000
 #endif
+#define SA_UNSUPPORTED	0x00000400
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
diff --git a/kernel/signal.c b/kernel/signal.c
index 832b654dee8c..d18930aafbf4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3964,6 +3964,12 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	if (oact)
 		*oact = *k;
 
+	/*
+	 * Make sure that we never accidentally claim to support SA_UNSUPPORTED,
+	 * e.g. by having an architecture use the bit in their uapi.
+	 */
+	BUILD_BUG_ON(UAPI_SA_FLAGS & SA_UNSUPPORTED);
+
 	/*
 	 * Clear unknown flag bits in order to allow userspace to detect missing
 	 * support for flag bits and to allow the kernel to use non-uapi bits
-- 
2.29.1.341.ge80a0c044ae-goog

