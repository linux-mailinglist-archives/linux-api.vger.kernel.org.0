Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E777952B3
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfHTAUd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:20:33 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41620 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfHTASV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:21 -0400
Received: by mail-vk1-f201.google.com with SMTP id b7so2360222vkh.8
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=010QS9WoWtGoiC1ndkOQ/THJSGP3hTPvp7YVgOrBMsw=;
        b=S/h/SfnsgFfAPrl/AMQC0M7+bE6qZ2UhyS+NlB+ZHqJgnkxWzZCNeJz6TfFSHpI3b/
         WNN4+TiYxCgDaDddsL95FRicBBIij+z1M9yenWIJ4HjBjTBspEIFA2vPk0Sz0ipY84t1
         IlhTIsS429DAEC2qUVfOBOokIi/VJjAeeiiADtx2DDSt8luPO7dOH+jf9NwRpCG3BtFv
         eEmzOiqiMwwe9DpMtd7xo4xxUaPKi76MJqJqb5M4WQuRh5Hli/DB6P9BQgN8trWC1gL7
         j4U7P2Yxxv9Ee3ddEPp/VQV1voaUNznzhDu3qaLAzTLpiVxRdQCI2vL/owBk6K3uOtCX
         wFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=010QS9WoWtGoiC1ndkOQ/THJSGP3hTPvp7YVgOrBMsw=;
        b=pMGiySpH4Lvwz0mTssSkDQe/mOBD0tzam5gEJewvKZqT5cL4Qz1Gh+i9prbbZI/AZX
         +vYUEf561IMS8St/YzEU8k0lmMyaeGgFrg+eoxpuDKhYOc2VsAlbX7HhPMVeRcDoFPd5
         wu8ResaFrP9LGcC4P6cmzhBphG2Sd5H0cGj0Z54GnnpjV9vpfIBur+tY3dEUmfUYXov1
         lqB3wkecHa0eXlAXQ4ufWJpYIXQhcreN4PPS3QkbuKbFx8qUdBdmj02+u63rDNnIISfT
         tgeIs7sQ6qMNoFJS2Fqvb+ugBjdbkD5z90z0I9XNvyNPFhj7/V5qr1ukXMY0hvMS27rM
         Gc/A==
X-Gm-Message-State: APjAAAUyvcM/95xZFCjrCk59qn6J3eHqSUDXCQtRw/goTRQTWkZqiDkJ
        Qj0ZB/CRLcHbQrAzMJuZT7mC0lcdErVZYnMNHQHERw==
X-Google-Smtp-Source: APXvYqxAssp7SU+dLaaXmcm2AenK7QOgvuf2jsiQEsQiaYrXPIys5VI0nS54KZNc5aFnofVRdbSADDB+iCNU76/o7QGAhg==
X-Received: by 2002:a1f:ec41:: with SMTP id k62mr9132584vkh.32.1566260300517;
 Mon, 19 Aug 2019 17:18:20 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:40 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 04/29] lockdown: Enforce module signatures if the kernel
 is locked down
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
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     |  1 +
 init/Kconfig                 |  5 +++++
 kernel/module.c              | 37 +++++++++++++++++++++++++++++-------
 security/lockdown/Kconfig    |  1 +
 security/lockdown/lockdown.c |  1 +
 5 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 74787335d9ce..9e8abb60a99f 100644
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
diff --git a/init/Kconfig b/init/Kconfig
index 0e2344389501..e6069368f278 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1939,6 +1939,11 @@ config MODULE_SIG
 	  kernel build dependency so that the signing tool can use its crypto
 	  library.
 
+	  You should enable this option if you wish to use either
+	  CONFIG_SECURITY_LOCKDOWN_LSM or lockdown functionality imposed via
+	  another LSM - otherwise unsigned modules will be loadable regardless
+	  of the lockdown policy.
+
 	  !!!WARNING!!!  If you enable this option, you MUST make sure that the
 	  module DOES NOT get stripped after being signed.  This includes the
 	  debuginfo strip done by some packagers (such as rpmbuild) and
diff --git a/kernel/module.c b/kernel/module.c
index 80c7c09584cf..2206c08a5e10 100644
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
diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
index 7a1d213227a4..e84ddf484010 100644
--- a/security/lockdown/Kconfig
+++ b/security/lockdown/Kconfig
@@ -1,6 +1,7 @@
 config SECURITY_LOCKDOWN_LSM
 	bool "Basic module for enforcing kernel lockdown"
 	depends on SECURITY
+	select MODULE_SIG if MODULES
 	help
 	  Build support for an LSM that enforces a coarse kernel lockdown
 	  behaviour.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 7172ad75496b..d8e42125a5dd 100644
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
2.23.0.rc1.153.gdeed80330f-goog

