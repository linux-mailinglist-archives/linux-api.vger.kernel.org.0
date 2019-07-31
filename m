Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D97D089
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfGaWQi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:16:38 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37735 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731162AbfGaWQh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:16:37 -0400
Received: by mail-pg1-f202.google.com with SMTP id n9so40293412pgq.4
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u2905WeoBzsTcUqrWVSX7p6zMJ6qFdPBK2S0ptkFjO4=;
        b=u51IK7rm5PXjX+fuzwbwKYHh7z82TiYvcoisKg+mw4dPfi537EDtpJlHb76TtTHgFv
         vjevqlCVpTIEf22kAsMGnz4NvYb86Gl3aaZQ7/L505uG3YhegqctpP0VO697Qg91mgDg
         M5ywjgGoguWLtgYdI+0kwbkbWSgDaSrnCP43WUSkiaX1YlO/EkbVGJb/RMkgPpF7PFaZ
         p3DxrCKXrxnUKluUrp0ln4c4E06Efrj/BhiYxtBNH5VKYSkQOpVg8FFhnIreEfA/8oNd
         cAnWttGxFRdm5bq72j2e42G36uPkg9YEYwn/BC3539tTHq4v3L8llkrFCJNdd0ZPP/PK
         VYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u2905WeoBzsTcUqrWVSX7p6zMJ6qFdPBK2S0ptkFjO4=;
        b=Fy7QEAb5FgHJVezfmtZaTJe0FgWrgs0xOY+ZbofssZf2bVqNwmxoV7aGUYI0RJ3Ono
         FXcAbcSUGMM+3/unFqGk/AR+MB9w50nyTqhY2u7rq7MOVSRLV5agqbT3eNgJy/vfxdrd
         4mS1U1YEb0P01puDPgObJEFjpK8b+yXR+aV8fB/B5p+Kt4elRVEuBxOpBJaiOp9vnF5K
         r2gDt5FmSqZiX6nlLDVgSacdL1M4tTXa0ljoSSDYyxTnv0BWrmHESbwwJOjaDgmq/9l1
         nbpKDgQYWmizdHSdeMZp9+Z0bJpkUibrzTC8hklv0h5o6R+sKz3pPiUQfU5WXhbdDbwM
         ic/g==
X-Gm-Message-State: APjAAAX706x4/jyh4Blhbbq3kEhrrTMKoBYH4gdwnagdbMBHKL1ghO88
        ktnPP+soZL762qaFihA3Ui3yRc6O90vJpqJMp0kY9g==
X-Google-Smtp-Source: APXvYqz9nvN6pLViGUJfhDU7XrmbV1ThI84+OES+YdosYp86dZSWqyXpxYB8/pHdM0JLrTFBZ3J3PT7o5Op4B7wSckVznA==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr6925516pge.453.1564611396278;
 Wed, 31 Jul 2019 15:16:36 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:52 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 04/29] Enforce module signatures if the kernel is locked down
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
index cd8df516666d..318209889e26 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2771,8 +2771,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2787,16 +2788,38 @@ static int module_sig_check(struct load_info *info, int flags)
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
2.22.0.770.g0f2c4a37fd-goog

