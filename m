Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304EC4DE64
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFUBT7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:19:59 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38428 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfFUBT5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:19:57 -0400
Received: by mail-pl1-f202.google.com with SMTP id s22so2679840plp.5
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oTJZhc67YgKisP9p9JrVMJPjUu1Ev+S7xJTrYSbTZx4=;
        b=B/tZc+vn3WaktKNK9T4k1XUjU+a/eU0uQ08kmrDc1+bigYos9FB2WWsluAGeB/G36t
         YfAi0QjD4sjtPxtMnKY6HzjB3jTO7vK2JNYab6BtyV5526LbxUvgwZPU16Y9DmMfjK4z
         PQ9+5uZQxgsE+fsDixETFuS8E05F8v1i/abMsI5HQdBgKOMJtdKMQgAx5Pe5e2c/C8ml
         gdAMxEOcKnAU+r0v6LKNDPeTkZYEtmhHO99KvvbB57QlAyqICjo623Oiw4CezwS5sEuD
         cjmdF2SlV+e5wr/yTJ4vkNPAiCUGAy0Vu6pDAhDhbwTMEFwf3GRrdiUDbbutIw6NbH2o
         d0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oTJZhc67YgKisP9p9JrVMJPjUu1Ev+S7xJTrYSbTZx4=;
        b=SSivUIiuYrKa6NjTYGV8cUWmpaGVDbDqBFbT7Qtc+RlwYmSF9bJNJ6cWdWIfpkjqqD
         Jo2kuDR01nhVq/EIUEphDqLRXsmCrLsfdGPn6umYRlz8SBa8ereY/EKDuu4TmMhv9TvX
         4ocq20D6GDHRiKgEvHYsxh4xRHyNU/wiGQoy0qJB27W6EY6D+QUEf1eAUZNaUmWI8Ckm
         PfPxuFeFNNNACsSWPci+Q5FpbQqZladQAzeLGeaoIAMZLQztMnX9uYPlBdyMK8h/cZk1
         MkygTOgBGEoyxVhZqXLViD/GEBAZDBN70gq/I9MmU0uL7h8cMUb+Wz8VpQ4ZKKb2dVvx
         vQ7Q==
X-Gm-Message-State: APjAAAU/qjQ/tr9fyy4zmjv0Y93NawULjwTbSmiZQMOqMj6lFAmj0VHL
        eDNTBq+K9zY29jN0FDtNRdWRiT2byT1PyqPmp6RDzw==
X-Google-Smtp-Source: APXvYqwexMzej4VdUeudQPwQh1qQKM6SYeoBeLdyWoQWkXhoBCQ4iKlvwP3IZKrK3rle+thzWDsw0C7WLpDrWAB4n88CsA==
X-Received: by 2002:a63:490a:: with SMTP id w10mr15275691pga.6.1561079996688;
 Thu, 20 Jun 2019 18:19:56 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:15 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 04/30] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jessica Yu <jeyu@kernel.org>
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
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/security.h     |  1 +
 kernel/module.c              | 39 +++++++++++++++++++++++++++++-------
 security/lockdown/lockdown.c |  1 +
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index a86a7739ca24..a7612b03b42a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -82,6 +82,7 @@ enum lsm_event {
  */
 enum lockdown_reason {
 	LOCKDOWN_NONE,
+	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/module.c b/kernel/module.c
index 0b9aa8ab89f0..780e9605ff88 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2763,8 +2763,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2779,16 +2780,40 @@ static int module_sig_check(struct load_info *info, int flags)
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
+		if (security_is_locked_down(LOCKDOWN_MODULE_SIGNATURE))
+			return -EPERM;
+		return 0;
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
index 1ecb2eecb245..08abd7e6609b 100644
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
2.22.0.410.gd8fdbe21b5-goog

