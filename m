Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9BF4DE88
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfFUBUZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:25 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40488 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfFUBUX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:23 -0400
Received: by mail-pf1-f201.google.com with SMTP id z1so3257450pfb.7
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ad/yNjk/bvrZoco4Mw8YoxzrZODyqSCNyrUtVdvZI0s=;
        b=b9TAlZ5KNSkYjsrvs/PzLlMDftAEdoVj8mEsBEzleqTi807SU2DjvF7a8CmhiMbuxb
         Hzn6NmDTyehRi4XpCLIg5IgZdnBCugdvbJRkEvBW6m/v9TfQlimXc8K7QlV9RPWQRBPT
         f4Ow8iVgacQqNXu0wQ8l7Do9OM6r9JSh1nQhJUQ3jHXWewrXQMQLMtMJjSrDMiEn5ekc
         a9MHX4SMQ/Opp1EiBA117qOw/ds+Xy9wXhODb0amjF3lM2AQlR4odDrH9d2dUW2FZGj0
         QwDvuDjnhYK5u/K0KLCvqWRKIKOFif4rqul98NbkhtZ9j4dkupr+HqgzrEz0ZKv83ZAB
         IHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ad/yNjk/bvrZoco4Mw8YoxzrZODyqSCNyrUtVdvZI0s=;
        b=IFdnp/HRcaduo5gj3iCXLJtK0Rr2JqEtocQKim+bT7iHbNFG3XsNcyocNVHf5RPcLf
         kz+gfDS0f/pbJY1iRsJyo+scqQXewnejjgYfEAFWYCe8PolDEJreVHgK3pmXBXn+oK38
         kHWd6x6tpFoiko6NCL6WhMyOIu1Vc0gISPV5dCK9fwj/CBjAvyiOOcgRezkmcKHUgtnN
         OtVYwUyhuTRixYP3EgzTrhmXqtCEomyMOKLrEq3trOk6eJSk36vdUrSI5mwoNSv65Pxg
         SEBVDpUf/QnGfOW1D3G/L6inXfZ6VV6Py8gX4IH3tF5XVDv/JqZ+Rbz61PnuooAly1OT
         ZWLA==
X-Gm-Message-State: APjAAAV42PTu30nDzKitq/abIz4x6d8Fh6ChdjjXPEoMzfy8oczAIGiZ
        ah+1/ABCgTq1aQhjxyATFOtKfimGl3k4NGI4KLaLoQ==
X-Google-Smtp-Source: APXvYqxiWB8RGelDojcowMZSvi/aE6GUQF8hluI7DbVZsjcNnSvnBPNmxITR2+IuuuJY/CSZdRz9iOw/4EPHdhzOxcl1XA==
X-Received: by 2002:a63:360d:: with SMTP id d13mr15523401pga.80.1561080022714;
 Thu, 20 Jun 2019 18:20:22 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:25 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 14/30] x86/msr: Restrict MSR access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
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
index 4588414e2561..72f0ed5a93c3 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -39,6 +39,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/security.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -84,6 +85,9 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	if (security_is_locked_down(LOCKDOWN_MSR))
+		return -EPERM;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -135,6 +139,10 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		if (security_is_locked_down(LOCKDOWN_MSR)) {
+			err = -EPERM;
+			break;
+		}
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
diff --git a/include/linux/security.h b/include/linux/security.h
index 59f0ac7adfa6..81c0968e485f 100644
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
index 6e426887bb23..a01301972290 100644
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

