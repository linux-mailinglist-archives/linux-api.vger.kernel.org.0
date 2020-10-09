Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A851287F8C
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 02:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgJIAoo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Oct 2020 20:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIAoo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Oct 2020 20:44:44 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6EC0613D2
        for <linux-api@vger.kernel.org>; Thu,  8 Oct 2020 17:44:44 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t4so5183264qtd.23
        for <linux-api@vger.kernel.org>; Thu, 08 Oct 2020 17:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DiXgOtW41EBiKZO8ua1O6hkUcsVE3S9bgdto7K9hmgU=;
        b=JcIdK8+jrEJA2Ll+s+2DE2KxzvMCdK6Q+qxt+QqYpMBUAITtVMcbupIRpSbL6EdaKv
         2jAMr3m3+1X8iWYiKkNFPbQDGkNXmTVBP7p7Ue43vpxGdo+D0RGqkoYBUDDEoLg0skgo
         rznN+zaOFguGVQ/HZEjlNw7jtkiK5TZ8k3v4McJHXgqP57ztnD0MXA5ZOIlZKdVzv+Qt
         7bXYtPAWvO1isDw+buWzOysgHDuAlG59Tn1ukFiKQdoOLnJ7jDu1Iefsxp0UOZ807t7p
         +P9FMa1xu4pyrGzcAvNVhqf9GvJGqY9NsbInLCpk7T7uwcMHgEk1cZYpFLJDD95u6NaU
         9Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DiXgOtW41EBiKZO8ua1O6hkUcsVE3S9bgdto7K9hmgU=;
        b=GP7vAuA8Zl96OvM7rnQcP1lrHj3qksZKON3Hiktppdruf3A5OeP/Fe2kXUyOy8qzYV
         0e8D2succLOHudMWWMgH2FSnFulQuTr4/tr6yjDdzF1id4zxLTaqWd0V7rIAw2jy8J+s
         vQ7cKfC9fOZIXbZ+UObbC4cCRmir2e7nW9VFRoumdrQX+yAXWFYwmbCUoFy8ED3RALVJ
         MzsOipyzCzHAjGl6WA9iE1OtstVUZD31Xf6cLigqaD8SEtehF4xXUj9yRFcU2TIM4Kqo
         03ZyUc/7Wu/VW1LqXU29mRCPhTkWVfXAu5jrSbMAmp4v1cAvH5sC93rBa4kVGf/gz0qe
         l+qA==
X-Gm-Message-State: AOAM5323rZWQa9vYSmc4SlTO+Dph/08PUMCdx52pyV1jgUjJr6i//aYN
        16TEGPhhTGyQhJKezidLWBfi9C4=
X-Google-Smtp-Source: ABdhPJxj5fUuoORZeJ30tIhqrBKrBMQ5KIPT0cYLAAFWFeKDRReDGdWJfQsyCH0rdfUMKYA2nbkz/+0=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a0c:ffb2:: with SMTP id d18mr10475143qvv.44.1602204283427;
 Thu, 08 Oct 2020 17:44:43 -0700 (PDT)
Date:   Thu,  8 Oct 2020 17:44:16 -0700
In-Reply-To: <cover.1602204097.git.pcc@google.com>
Message-Id: <e9536d1774d5c0627ab6cfabb3e5033a123a9252.1602204097.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602204097.git.pcc@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v11 5/8] signal: define the SA_UNSUPPORTED bit in sa_flags
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
index 2ef8c238679e..018c19f6cf66 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3984,6 +3984,12 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
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
2.28.0.1011.ga647a8990f-goog

