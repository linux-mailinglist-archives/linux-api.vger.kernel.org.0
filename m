Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC06D4FA
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391393AbfGRToa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:44:30 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55979 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391467AbfGRTo3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:44:29 -0400
Received: by mail-pl1-f201.google.com with SMTP id q11so14418971pll.22
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TwJXmltaqPXLScJPeplt82MxiWbulhRh2wFIx7ld1zA=;
        b=KpW5XOBG641l/Xw8B2PEiHxAcqUkwOdT8pWMv4P9X4i+9tASsD+6DKmFEGZAItkLm3
         nt+eL03RKB94E27Z+0SWtx0TsF44fWmjxgOtF7Cs9dp929LT5CINR0ubQgGECLFjJZ9b
         CBGqD0yXt2ziKZH/d3fp5ogvaF6WdfGy97JSO7OMqv0X+tki9ZHCr2+fiw/XlJ6SrObJ
         yF5qQ8imSZIYloYPzge8UZvrzBiV9dfpFgb+FEj56i6tVz5f5s0K17nWcTTh9VZGux5y
         azQvE+1YXrsqP9Ep53uXtGtJZPhew0u89/7pYmaCmMG+M7r3LcHMmHanccR7UURyvdFV
         bxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TwJXmltaqPXLScJPeplt82MxiWbulhRh2wFIx7ld1zA=;
        b=btGnUdebbZ0X+jaiylOUGSxDfiW98dulu3oNlRHLZNxVK2VamHZ9RNWVOlGjsnMb/1
         9LHYBl6VCvpMKgQ7MI3I/wagQOh/5CUSSaoO35Sd1S2zaWFspjAN7tE4pADu/VI0K/PQ
         jPakJfw4SbYRNK1kV9RAr+90ra2ASBB2xLJzF/mEcTJLavwRASasaGr/C/eAbYleRRXg
         DmGVgmR2jkV4eMXlegTm9jpRCyB6W066PHh1rl4N3Lca9YiYVdoiRctIPQtadlrGtik9
         rlDhNaWrPWGe5G2LuHJtRhOFaFXsFEesfEKtpLKUI5JE9qDGYk6y6t5Y3xjivv39qX56
         BNjg==
X-Gm-Message-State: APjAAAUA16u94+/fURRyokFgRthw1VZyon5roDl0Ai/tv0bpYnElnLVg
        JTpn2v2F89IpAsDmzgrlRUN8kIN1U7/HEnA1YPXSQw==
X-Google-Smtp-Source: APXvYqxsgSe+hKIUupoQACu1/e2K7TL8mPi+SfdyEwMn/PeozIXLkIfTEE+jqRKohan3TNzkLTn9q6P0KM1Cs9A3zxP4YQ==
X-Received: by 2002:a63:10a:: with SMTP id 10mr50049340pgb.281.1563479068817;
 Thu, 18 Jul 2019 12:44:28 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:50 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 04/29] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

If the kernel is locked down, require that all modules have valid
signatures that we can verify.

I have adjusted the errors generated:

 (1) If there's no signature (ENODATA) or we can't check it (ENOPKG,
     ENOKEY), then:

     (a) If signatures are enforced then EKEYREJECTED is returned.

     (b) If there's no signature or we can't check it, but the kernel is
	 locked down then EPERM is returned (this is then consistent with
	 other lockdown cases).

 (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
     the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we
     return the error we got.

Note that the X.509 code doesn't check for key expiry as the RTC might not
be valid or might not have been transferred to the kernel's clock yet.

 [Modified by Matthew Garrett to remove the IMA integration. This will
  be replaced with integration with the IMA architecture policy
  patchset.]

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/security.h     |  1 +
 kernel/module.c              | 37 +++++++++++++++++++++++++++++-------
 security/lockdown/lockdown.c |  1 +
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 54a0532ec12f..8e70063074a1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -103,6 +103,7 @@ enum lsm_event {
  */
 enum lockdown_reason {
 	LOCKDOWN_NONE,
+	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/module.c b/kernel/module.c
index a2cee14a83f3..d8e1258e54af 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2753,8 +2753,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2769,16 +2770,38 @@ static int module_sig_check(struct load_info *info, int flags)
 		err = mod_verify_sig(mod, info);
 	}
 
-	if (!err) {
+	switch (err) {
+	case 0:
 		info->sig_ok = true;
 		return 0;
-	}
 
-	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !is_module_sig_enforced())
-		err = 0;
+		/* We don't permit modules to be loaded into trusted kernels
+		 * without a valid signature on them, but if we're not
+		 * enforcing, certain errors are non-fatal.
+		 */
+	case -ENODATA:
+		reason = "Loading of unsigned module";
+		goto decide;
+	case -ENOPKG:
+		reason = "Loading of module with unsupported crypto";
+		goto decide;
+	case -ENOKEY:
+		reason = "Loading of module with unavailable key";
+	decide:
+		if (is_module_sig_enforced()) {
+			pr_notice("%s is rejected\n", reason);
+			return -EKEYREJECTED;
+		}
 
-	return err;
+		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		return err;
+	}
 }
 #else /* !CONFIG_MODULE_SIG */
 static int module_sig_check(struct load_info *info, int flags)
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d30c4d254b5f..2c53fd9f5c9b 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -18,6 +18,7 @@ static enum lockdown_reason kernel_locked_down;
 
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
+	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

