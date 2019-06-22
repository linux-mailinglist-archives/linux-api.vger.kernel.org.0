Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68714F237
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFVAEh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:37 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:45850 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfFVAEg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:36 -0400
Received: by mail-vk1-f201.google.com with SMTP id z6so3027226vkd.12
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h2S4TyM7CDyJMzOjQbRR8ZxxuMRjDhoCrTzyxHQF79A=;
        b=wDF1wRh7YRdkWENFBegReRPWg8Ckd32u7DCN0+IKAyery8b1+s7dI+zT3p8kB6IsBS
         5ib5OAxiJgbnyubCe8ihMsjXCVgjsTjfbb1f3vFEpfT5YYOdxv9l2B5NGb/b7nhGNKyK
         Ibh8t5mZvnavG9IT55dA1L9Uk4eK3afpzt5DPbSJFHyBwYP4ct439OguaEVPITJLKpLE
         OAMCezhOu1zvy1uc46JxSLEBLHZ5r5I5Bewf9BckvkjTBLbmYQw3EIzELHSaNbnr0Hxn
         aeE9u8eiAhIPpTR0XzbZL3CmimTaGzMLgzXV576COBT89EzENtfZbTVKlCjDiDg30Yow
         lbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h2S4TyM7CDyJMzOjQbRR8ZxxuMRjDhoCrTzyxHQF79A=;
        b=p+dlA+L1MtFCXL4yc9yKcFPpN+W6nheFJnZX7Zccp1wLy8MbV7yMfhKfpiIdENJ4C0
         Scgi9LYI/JMP70spdFr7GBtIaQipo9P8+jYX7OMzU2DM56+9gprtUZWyOZVHnSGi1v6m
         PVkhG6PC9Q7NKpwjiDUaf13XkDEl+QIxM+Ul9XWMH1R8rJPJp1BqBUKV1IIfOgSBoKGM
         X/UX5fop3zgx/t7NKT7BNPlbBPvquCqJMxDz7Wy1jnbt69F5/ajmVJqPlwmNvtWWI605
         sBe/gFQkTPivISgQC7KRF7avhOzI28zoXKRGP/ctUaqMXMTwKG2J7O7GVw4YmZYpuQXS
         7wFw==
X-Gm-Message-State: APjAAAW2IgCjY4hFXgYaQLkgHxJfURPjBmR50wzVcId2/IF3nuVJm0fO
        IgWdUv2iEZHCyj1qKPF3I8A4PrPN0OBIkYsp81bAbQ==
X-Google-Smtp-Source: APXvYqwS2MgA1SXOj6fV/hh/k0TpKrnXr6zcFgypgeQp/ElwyjlX3xUnkgtDu8Nw/KiSDM52/+plAywMWgkcmWo34zOLNw==
X-Received: by 2002:a67:13c3:: with SMTP id 186mr57496678vst.8.1561161874880;
 Fri, 21 Jun 2019 17:04:34 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:42 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 13/29] x86/msr: Restrict MSR access when the kernel is
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
index 4588414e2561..131861b4e447 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -39,6 +39,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/security.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -84,6 +85,10 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	err = security_locked_down(LOCKDOWN_MSR);
+	if (err)
+		return err;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -135,6 +140,9 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
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
index 60569b7e9465..30bc6f058926 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -88,6 +88,7 @@ enum lockdown_reason {
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
+	LOCKDOWN_MSR,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 895ef3ba1b4c..297a065e6261 100644
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
2.22.0.410.gd8fdbe21b5-goog

