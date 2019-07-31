Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0597D0FE
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfGaWQn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:16:43 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:42245 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbfGaWQm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:16:42 -0400
Received: by mail-ua1-f73.google.com with SMTP id q23so7253321uam.9
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F1VsQKe1CvGe90szBrckBeIyG/tsASbX2ypyWhc14LE=;
        b=OA/ewO2STl/8HuS0PxOzP53cqnJU4I2To46Ls2zbIPrZrcu6dWb3BWrs8Gv7I+OTa/
         8YbrIh1IYkmK0OtcTqi75E137+aNk2E/WFI/YsvmZnzcOaaf98xzsMoisWzYfDfLC2B7
         JN2b+P5R1eLpJX4dG9c9oeCWku4dL7sYsIrkTSNq5KSAuZFriPHkloD2Eg+XpfaeK/Ui
         hlokk/dSOm/77WEK1BNNuhO3N3lFKkSgLy8FYH8Z9lCWel6MAa8V17P6MG633C4Wxbb8
         b+F00xixmbEGqv+LwFArWUhV5ybH8n5Yo5qa0k/kDIAOJb71ElqEWbgXe+hHxUS3Ryct
         U9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F1VsQKe1CvGe90szBrckBeIyG/tsASbX2ypyWhc14LE=;
        b=EsHw0uzCPGVlUjV31s01SJAFj8/y8zpCFMWp3+sr0Hzo/y2F087gGouKg/MxM4qXZk
         vBAR5bYbwLoTV+1JXx6njyyZFLnD0Ee3ur4A1H8siZ8DtLKtC852F86kt0KJdggXVvi6
         Y4pJb1EfCRFy8NO3EwhdLuj+XmZIYC3wLFkDSpS8leSOwPkOqNlm4LlgrXJ6TP+nF/Jx
         3aWBpM44Cu5DX87C5tf/IezOOpbvK0SmB7joke4Dk1hWl4Ij7/7n8x24FjXVFRYykGE1
         8+3D+5vX7d2VQAyXwy4AMfrxB5sh31f8npnXJVC5QiXXJY2QZWwFIvTN8xqbqdu/Opvz
         SFww==
X-Gm-Message-State: APjAAAWYWap8wcwFiHQekYJTmG8GZwulzeSodh8dXSb0xSj9KrGGtNrG
        g/7SqQ2DKKjKPBJaiJa8PSUP+6K8GjjPZxIvCiIBBg==
X-Google-Smtp-Source: APXvYqx6UQL2kVcMcSAcMfiNdlcC1RYlaghiMf1GsQfTNxHzAwOnaMO09aJRTxLnk22BC2WML6UwPWYSOTr5JgeP2S6utw==
X-Received: by 2002:a05:6102:3c5:: with SMTP id n5mr42332847vsq.56.1564611401552;
 Wed, 31 Jul 2019 15:16:41 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:54 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 06/29] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 8 ++++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9458152601b5..69c5de539e9a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -105,6 +105,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1b018f1a6e0d..bc933c0db9bf 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -205,6 +205,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	result = security_locked_down(LOCKDOWN_KEXEC);
+	if (result)
+		return result;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d2ef29d9f0b2..6f302c156bc8 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

