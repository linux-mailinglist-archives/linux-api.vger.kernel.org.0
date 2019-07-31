Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243B37D0F6
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfGaWTO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:19:14 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41768 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbfGaWRA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:00 -0400
Received: by mail-pg1-f202.google.com with SMTP id b18so43750908pgg.8
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q3etb4lqcpfoYcLMBUBDWWlC5fl/teVFWCZH3Y1QNdw=;
        b=quGzWel87vKpTW4m4ti6UC5lPNM8poQ5r/5Gcx2k+UB1of3DzW/ygjWMG+qe/Fd4uM
         cDTpYU+PDwUIfPSRoB6CQIQj14vfKG771ql+UsouBTpmPik0ygjY67XRnFdi9Kxcg7ZS
         +bQ9M+2CNh/LhLV+HYPRlRvvArey+z6EEfT82xg/+VTjZ6i//Lq5auWIhNehcWDM1krg
         UtiiHS1J2R7eUNf8pXRVBs907DgLQKa70qAYzpZJfVOFrM+OBJyVIDoMThdLqXErL6Do
         Um1IJ+0Apei97QMgGp8BKBMTadz8Hvrz8eHjCdW6y1/DwlwDIl4hwCQ7BCxBPWQ+qcdb
         GZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q3etb4lqcpfoYcLMBUBDWWlC5fl/teVFWCZH3Y1QNdw=;
        b=mHQSoeEol5WYB4/o4i2JJ7aM4568fdq7z0YZE+WknYSYyHmYugjNZhx/GK96Ib4rLS
         LECvh6J4l8KfcaSdht4mS9OXp78NJROlW/58ato1rJhtZcjcdSG420PwW5zUZfQ63xQa
         xrXHyKchm1WydOomvG5ODlW8Up4Qo1HRRL+NCseTh4X1/Ard5CQUH29DRET2D4fNcnEV
         XOVv5E3MEHbqrGhs1hlEvhksFlFKQqYqVnMq5GqcQFrjYaT5wdscV0i8fwcKkUjERE92
         eauMAGa2eRQmzW9SeEClDOYCOmoA6+jxtW1rN3lY2hkp2lkuCZWY17XoUjF/0KaugjSu
         QlLQ==
X-Gm-Message-State: APjAAAUbgcykHqvilBAZ0nLnwpbM4zmsoWR3kmZgugDHzvtVvlqx9jyf
        KhCVgxu3vvsLwFZ1EhRiZ2i3uBA4dP4AwikPP9iF3g==
X-Google-Smtp-Source: APXvYqy4ds11BOZ1ZwNIDQc3p6kAWpXPQHkBqVxVp8RzbiUM4j34Y4iiH1c07QLZF/c58qzuumf7YAJNTWdC2BSj0z0cCw==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr26982787pgf.340.1564611419264;
 Wed, 31 Jul 2019 15:16:59 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:01 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 13/29] x86/msr: Restrict MSR access when the kernel is
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
2.22.0.770.g0f2c4a37fd-goog

