Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B1769BDC
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfGOUAH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:00:07 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:38656 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbfGOUAF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:05 -0400
Received: by mail-qk1-f201.google.com with SMTP id n190so14723486qkd.5
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TwJXmltaqPXLScJPeplt82MxiWbulhRh2wFIx7ld1zA=;
        b=ez1GXT9nZIq+ffUv9Nt01xF//IGziQvTA9O3l8axleQKlvpyQ/S9oROQTNMx41aKgk
         AU1ljjo2SB6lQxwVtYMG5LSys/JGSzfOQhO7tjfYkz7vqisWa3myMVUEq1C7zuazG6kh
         V2/ee+25ZZYB9wV+O+XRFY4UJbr8AlNLlh5FWHE8SuYpGoLMCIeBPSoPni6/Z9QYzt+x
         6kTgCUVdFOPZJ+WN/b93E35YbI5w5711X6Ll4qJnB8xsVNA4V2tN5yFrZVTkBksC3oBH
         j0enEoqd1uSR8FgrlnVs+3SEG6030xrGzQAJGOdntHDolpEOAl/HoL+X7zaQD/0aPoYB
         KOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TwJXmltaqPXLScJPeplt82MxiWbulhRh2wFIx7ld1zA=;
        b=o0HvpRNK6a6YpgNqgBxYyrdFxQJkbnX4EknOy68caIo0DdCtqPJJrR/3KkY8MKeFfZ
         w2e4+jHWqwnnVj36VDf1vxgN98pVU2pUUWkLJq/PeSmnvUoG1YczVuij23j6IMkk9TWX
         N1xbVvdDZS89CtH/pL5wFx5S1ojELK6tQ1n/SNK+Rn30FNRrbdW5sno205NtYdXb/nkG
         H+/+I8Ez26kCnsV1ntKFdver8iaxUAzud6EyEB6oGDaNZGGpTZFCQ+QHM+pR5Crb0mGz
         44fsebiOXk/jU9zrDbiYiF3Sm7nfl+h/jTUk9zM+Wf05+kvHs57nji5lOpUHVaIH9ktT
         19iQ==
X-Gm-Message-State: APjAAAWOIQCW9XoGiufPYDP6BHJ3NAWwTG0rMrlsaYsOIZ57wNil+rw0
        TK46fB071z3vpmTFahgVi+sIoQAoT+p1SS1VaV6mCA==
X-Google-Smtp-Source: APXvYqzi+4fr5TD7sMKrXWIt+3sjf0W2pz9ll2yGx0MlNg/GG0+GnAIP/TxUIAD1SxjzU8Y/+X3ewjIBvsG9TUx1jMhQQw==
X-Received: by 2002:a05:620a:1411:: with SMTP id d17mr17132602qkj.137.1563220803792;
 Mon, 15 Jul 2019 13:00:03 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:21 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 04/29] Enforce module signatures if the kernel is locked down
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

