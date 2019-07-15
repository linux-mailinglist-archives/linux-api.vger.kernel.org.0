Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7DE69BEA
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfGOUA3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:00:29 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33565 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbfGOUA3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id d190so10851200pfa.0
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=minBZuRPisw7H2/W4JdDr67L/DoNl62iO6bi7/9H078=;
        b=d74tXKiZoNQe7CxJS6ufF6sO/j8wOIqa3x36LTPJYLKZ9UdNFn6dgCyjw3/Z1aZ7Jc
         F3DtrAN/vtTDtkmrDzpkxG4Ygv6pu2RnHQgx+UpdbfbCvP9LKb/XEd+WoKaB0truEiZV
         G30B5f9wQ+I4+G219HkbVJ3pushqH/sfs+uV8CxSJcwLYdl6CKlnuujbj3YPZOuefjN4
         IMG0qqIg37wHdHnGXCuiScEUx/4uD4x1aRjE4UtBtO4xlVP3+rg6eU9zIk7E8mbY1+SB
         2LR4iXq7zh3pK+SLZHXn08NYLKIY1FDi3EqHL5Eu48yvD8bL4AC0PpEIL8meyHk6F15Z
         DJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=minBZuRPisw7H2/W4JdDr67L/DoNl62iO6bi7/9H078=;
        b=LcgMRu4HUZ+rPzXfWt7tr4zK32EfEbKQvFzflZef2grFMbAxxWn+VB3fGMM/+1cwPd
         kS9UovCHrEFEsN8G6njA1hergIhQ0KghqMkCqKmlTFkEDtQEcLmdWHtzkYZgTiKCL00A
         I7GU6xGPWQ7UHw0s+oqYGdt0XrCCFzQW9lQcnblhkT1fNfAE/Q9WcCWceI3kCQ3mogM2
         UfGmz9RH85u7qip7Te62G/kRWOfzGB/m9Llwd25wOQ0rO2Ti4k5F1/Sy2tfySf1JlZM5
         a6RlYUClSCwfdMDaqaz+KRNEZ2VQy+2o/kcENxCXq7BB8c+6jwoo0jDIShcQw0ZOTNAk
         RpOQ==
X-Gm-Message-State: APjAAAU6rc50auvKgoCNseF06/N6+qOvpcF8ExTxl0IzHMHzBGUByeL7
        XaWvgqMty9imWKwPZNIwhuKoZKBuxekneGhczrDetQ==
X-Google-Smtp-Source: APXvYqwpmLV6Y3KrAl675DyixIjSMa8yMxj/Kd/VeXi89WUSQLx54b4G2b0/HphFUXnOK4guo6cOGJdMcvbyvZGU24+InQ==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr28815497pgk.431.1563220828029;
 Mon, 15 Jul 2019 13:00:28 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:30 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 13/29] x86/msr: Restrict MSR access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Writing to MSRs should not be allowed if the kernel is locked down, since
it could lead to execution of arbitrary code in kernel mode.  Based on a
patch by Kees Cook.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
cc: x86@kernel.org
---
 arch/x86/kernel/msr.c        | 8 ++++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 3db2252b958d..1547be359d7f 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/security.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -79,6 +80,10 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	err = security_locked_down(LOCKDOWN_MSR);
+	if (err)
+		return err;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -130,6 +135,9 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		err = security_locked_down(LOCKDOWN_MSR);
+		if (err)
+			break;
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
diff --git a/include/linux/security.h b/include/linux/security.h
index 79250b2ffb8f..155ff026eca4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -109,6 +109,7 @@ enum lockdown_reason {
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
+	LOCKDOWN_MSR,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 316f7cf4e996..d99c0bee739d 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -24,6 +24,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
+	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

