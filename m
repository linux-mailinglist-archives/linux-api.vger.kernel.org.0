Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5A952A1
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfHTAUM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:20:12 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38172 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbfHTASo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:44 -0400
Received: by mail-pf1-f202.google.com with SMTP id e25so3530840pfn.5
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=28L+ehB4vT7SQwhr1GVEAssWYqpFu3ff7CisXtvvxdY=;
        b=SvGMP+S6tMmZzB+fw4HPKsKm+2MzyO3OimsS0WVncAijxpLHKoBqaTGUEm9cRs2F3g
         JFUqTBIEbmfxGZMI708DrwMp7SC9bYp0+w98WIkUwTk7xD2TQ/plYib5XDtlmzInzPK4
         Bl15YFCF7X65kaqgC0Jq7joAWDh7/aaHOFj97YCrlK/WTgaq58IRXzDQei3jcJd9JEf1
         8zt90+b0w3jm7dsVXxx3U8USdMIbQTQegNG5MEYO04d4lN/NdioBvpCVsa65qQjwjwpJ
         bww+t43WooMK364Z+SmADURskaIOmMQDM/zOyPpKkUTMMVVLy5hhJzfDuMzR0cb4GqD2
         /bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=28L+ehB4vT7SQwhr1GVEAssWYqpFu3ff7CisXtvvxdY=;
        b=IQSc+VaVRQhzt77fXg5WdFk82ATGdyf/dJYMwRFLDO7SZ52zNRTCc5p2XVPuevczB2
         Jf7sUzF08Jrr+Fvp1UiztWZxka5bcRGhObrH+ezGNlampHDr8/EE6PcTg9Vi/T31MiSv
         NaFgMyyHFAA28qfYT+enstTyphZOYje1Rl8kjX2oTVrBjTc+iFGN8DtL0UF1NTwGb855
         F6Av/0YNYP8iEO8eoB6uiqAzFuzSP25hUmUvdCnOERxNsLzXgrrfpqLG95RMai6j5STe
         usYGsi7OZ56NG9+WgeIHA3lPFrTrCJz8RUp5J9Gpc3gpX8QIiIoQH0qw7Sa2KD4aw21E
         xwmg==
X-Gm-Message-State: APjAAAX2yDmONcHRQ9yzdVMybQXNf9I2/VjBsGeoCXoiOUOU0m0e0U3a
        tx0QgjEmSr4cyI3xmufrxV67He7tb7J2SGanv5nuXQ==
X-Google-Smtp-Source: APXvYqwSAuJyFawiCWBPUfWSfl+ey1b0WgKBia9JeslWeeR5kptToofdPLL2GkFbfzP46jJ2hazqwwFcv+/poIq39PAY2Q==
X-Received: by 2002:a65:4304:: with SMTP id j4mr22959013pgq.419.1566260323884;
 Mon, 19 Aug 2019 17:18:43 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:49 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 13/29] x86/msr: Restrict MSR access when the kernel is
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
Signed-off-by: James Morris <jmorris@namei.org>
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
index cd93fa5d3c6d..010637a79eac 100644
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
index 8b7d65dbb086..b1c1c72440d5 100644
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
2.23.0.rc1.153.gdeed80330f-goog

