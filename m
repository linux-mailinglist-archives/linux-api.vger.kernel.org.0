Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC20E2B57BF
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 04:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKQDRk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 22:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKQDRk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 22:17:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9413BC0613CF
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 19:17:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v13so19027567ybe.18
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 19:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+/xhIY0o37SOCy7xplXuFsniKU4mnkPoK9rcWBJmUrk=;
        b=HSx4T7wa8IETmW2qd314AN06jL7a6fY0TcQqEnIyWddUkU1QWGQ09XzCd1a2N9M3up
         GtKmdYch+pokun+erjbbSd2lQ+WkprOeYLBC1zO8Og7j/pDBpwu2z9BaPK1tQVErme/W
         xYuixNHu8Q1K7RUrCpECVjVXoH3vEVJi1eGW/DfxVbuHEqfsjbkbKry8iYXhX1rWlbz9
         LeIeucuhgbNmAuVOqm/fTod7+JrsuRrI2giGsg+xzbzeLsoI2QzJOW/1fNO+c6+KaE/s
         lvxEY6Dqt7I2xRwr36pGCUGyywyDhFtg2x6xCCIudF1iFoVxRxq4JAPC9DlgiX1ns/dc
         /u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+/xhIY0o37SOCy7xplXuFsniKU4mnkPoK9rcWBJmUrk=;
        b=e3EyC0gQW0VFrnetziVnbojRQSgdRsH0Jo269hlZLRrSmVlbuiUtRmg5OLJMGeZgAA
         ckdgfouXzI5ZYLYsObY+lRfIgVPNED5QVL1BbWR1+g51s28C43sLqYb/PK7m42/767xJ
         QAR6LJLbgSF7O3YwXtH8I60k2c97RjD7na5SiD3Mu1Mtd8Xp91ULXYJ3Hcc3cEN9gtK8
         8f/HHeAO6l2Ubn3RNJ3lXqbJn/1fFms6hSyHXtFQTGnVP2TRpvtsXuawEW/yyIPWTV0b
         R0nGM1mDbFbFA68k2u4HeamjhaWQpeFbrDI2Rn1A3A+Uq6QcHAeMQXtgh2B9O57Aa88J
         wZLQ==
X-Gm-Message-State: AOAM530LjknSuPirdzIpRSW5XJyjGDucM1XJVUvTJ51NGZYV/wG7Znp3
        A55RZMxVesOXRzQ1NGTFmwZj/3w=
X-Google-Smtp-Source: ABdhPJwRYjpupZkut/RoyUhkE1Q9L5yF98e/0p4cjPYwHL6vMYKZ0fqA4JVjgLKq9F6BXbGqaSNyIn8=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:b11e:: with SMTP id g30mr26756032ybj.71.1605583057711;
 Mon, 16 Nov 2020 19:17:37 -0800 (PST)
Date:   Mon, 16 Nov 2020 19:17:25 -0800
In-Reply-To: <cover.1605582887.git.pcc@google.com>
Message-Id: <bda7ddff8895a9bc4ffc5f3cf3d4d37a32118077.1605582887.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1605582887.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v17 2/3] signal: define the SA_UNSUPPORTED bit in sa_flags
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
index 44f070982752..c790f67304ba 100644
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
@@ -34,6 +40,7 @@
 /* 0x00000080 used on parisc */
 /* 0x00000100 used on sparc */
 /* 0x00000200 used on sparc */
+#define SA_UNSUPPORTED	0x00000400
 /* 0x00010000 used on mips */
 /* 0x01000000 used on x86 */
 /* 0x02000000 used on x86 */
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

