Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A46D54E
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403942AbfGRTqV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:46:21 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48963 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391708AbfGRTox (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:44:53 -0400
Received: by mail-pf1-f201.google.com with SMTP id u21so17202837pfn.15
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=minBZuRPisw7H2/W4JdDr67L/DoNl62iO6bi7/9H078=;
        b=BhUTX2qUiiL6RrJB93H+27tuRITeSctfUT6CBbrO9oyZLQ9WchkTXMgKEVUQS1edP+
         fnH6lELvdBHrqVkpYSwTLqF4XOqKrWQoWMgiTHJWMlKEr067Nw966u80Wx1wLCmQaYPS
         4fSvOVKYEGi+P/fLlUJUPh0qpkgKfhmmqmLwlU0mQWb4CbGE1qzTw3DA82a+SWTbOMXf
         EZ1hgCpbC2npvG2bdJaXPxv56ovd/haE4mI+ou/oP76+qfKRitD9VOlNSYFwsyhdu8xX
         pVKq+7iKlxCV7Tca/y2BBcYCWjr5A8jJkpzCvb8Qjm6CRYneVJ6iU4Ku5DQB5jOVVQW0
         SBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=minBZuRPisw7H2/W4JdDr67L/DoNl62iO6bi7/9H078=;
        b=KaRd4wPKIQTAzKZnbIfN6mgb9iZWzUr5y72PY49BjEryVzwWnPdL/cLznhOsPNEXG4
         GZSfNofXEOmyAuGfvzGuWBXYEwn0RDyyyYs7jBRRmdoVQ2yVq98lmcNWCPwEzlYyHh/P
         vDb/0gX4vuDZQSNtsuhFE8suhUCy5wqXMyWvxpbchP9cCYakjh+WSOMFRzgOZtxcGGWm
         KKihHq98QD4RG8WaxTniTXx+vgGhsMGSywe/X14e9juK0kDwgT8kYNsoxK9a4gjjUKSf
         7z2Jn4TXfAaWnJDNHABhCkftwv+7Xit3v29Mf+h6Np7XEGuf5FDrVlYVUCvDUrwpz/Wm
         4lUg==
X-Gm-Message-State: APjAAAXxevQCG1Y3zigUfJkAbY9WfFmaWFuIUb3hVF8FUbOfXfkjUDsp
        7pU/bN2wZIJisTENGJsKt6U8yz5GCs+fPFnG1FlCgA==
X-Google-Smtp-Source: APXvYqwDe+hjJ1l+N8oUy6ZAG2SYpCvM6947euWdk10aGOnm3bxMab6zPHzcMIIEn7Y+WkCc0Jsxg/KpVQ7JTli1NY22bw==
X-Received: by 2002:a63:593:: with SMTP id 141mr48453401pgf.78.1563479092164;
 Thu, 18 Jul 2019 12:44:52 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:59 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 13/29] x86/msr: Restrict MSR access when the kernel is
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

