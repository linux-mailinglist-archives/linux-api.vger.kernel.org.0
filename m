Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1042B1464
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 03:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKMCq0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 21:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKMCq0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 21:46:26 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12823C0613D6
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:46:22 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u14so4966985plq.5
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lUEiJXSYZDs6+Qn4UpsCZYPeFsNKuEieQkr3dWS75aY=;
        b=EvfTo0edUqDuBAriOPubmF24MEjI11rQynQHXK2nawtmRsuJHmiK0ornX1yfNMfKA1
         SehoGzrCPBkjSpEy5cuPZ0Bwiw2UZg9kadTP4lRbgR++7POZy6ZNzi0khyUC1Lr+/sNu
         mDU7+c/d9zWrhImaTLAevDWi+1EGECHTQS5b0LuWEOZ2HgM9wBU5T52+DSyA0mZ0vZ2L
         9ZD0OwHT5li9+fVLa3eau7lWkfgRDedORgfo6vQSSEJ5PLutNnvMttcrkbwd3aWXq6ep
         rbWeYVC0iGheOf/Buq3foMvoL0nX+/X3NJCaounE0udQAr1UCO37w4lIfo54RdB34Cqb
         eE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lUEiJXSYZDs6+Qn4UpsCZYPeFsNKuEieQkr3dWS75aY=;
        b=myrclPxA5VW6v+QE+bqYgVFZ/B6fOqumpnpxBGR27ivgTee2jK37+AH1NlPX+W/n+k
         x7efG1/vcX1E2k3tepUjxFtAWaiq3bOn7Il/JoLO5fnMUtV0CsLXRCnBxHs5tADoPV4x
         xpi7ItWf5JemSeuOSGzv+d06RR14TTxzgOuQfglSMIo3n82T3QCy0UO6kHHiiypixmpl
         2BCv1M/D6AU9LeI5GDvItoNBNVr/XbjBv/wqsj99Z1pjc5nSDY6gan7HPmuYcgOphUxA
         pD6nmdXMGsCaHR4SspJg2XlbGxPJLInTcFdpEBmnSMIs7lOuOA2m5FPtHHbbivIsIAy+
         Orvg==
X-Gm-Message-State: AOAM531A/X74EcmK3gaG6TV9pJNEOjKV2F7OSWzZaHJ8SCvUS1yPdXa1
        1DSWb15ti8NEpAvwBw2oxQUJxi0=
X-Google-Smtp-Source: ABdhPJwLOzxpq1YXrc2y7i4Sw4OIP3nv7cbZzPmE2fmQN1OfADzGqbV9TwzOWbCYl6Covu6iciL+p18=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a05:6a00:1684:b029:18b:665e:5211 with SMTP id
 k4-20020a056a001684b029018b665e5211mr150458pfc.20.1605235581478; Thu, 12 Nov
 2020 18:46:21 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:46:06 -0800
In-Reply-To: <cover.1605235488.git.pcc@google.com>
Message-Id: <3581410892be6851d804bbbb84fccf06073f1262.1605235488.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1605235488.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v15 5/6] signal: define the SA_UNSUPPORTED bit in sa_flags
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
index 8f5bd12ee41b..8f34819e80de 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3985,6 +3985,12 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
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
2.29.2.299.gdc1121823c-goog

