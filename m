Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79C69C30
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfGOUA1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:00:27 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37050 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbfGOUA0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:26 -0400
Received: by mail-pl1-f201.google.com with SMTP id n4so8344170plp.4
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RqpfjquZ0GE2zpg4eJx3Cd128lI5VFuP5LKKMsWaFSI=;
        b=pAFIQjO33EAXPRRh+j+8nZiaw+WI8Xw1Fa6DZNgdB7zZx2A1EGkXPj46P4Q5VOpGBz
         JcmYxpaDUscEFw1lRXB/bfKXJrsUlP0FHkN1oEFjUJdwwrdeE9Q6j+FsfTTaDvdF/lOL
         7CGophnnEH0kve3B7v4Xky1J6MS3VJ0IfYjtEucLIHGAbLN5l3iB0/fgauLGOPwt1RRf
         gdTugZchq9qqOL2i9ei2vjVNzJ1cQr8L2LQeGJuzqDA6nin6fVzaeMWaR5xx+njjTvy8
         gXoOwFkBUhRx1ycrD/WIirZVvdk2PE+Vg587H1WoE/kf0p6xm9UtCXWMciAbcD7ByrhV
         g/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RqpfjquZ0GE2zpg4eJx3Cd128lI5VFuP5LKKMsWaFSI=;
        b=ORrHUxyaIXQSaXwoI1qDnVX8iEjx62I+6BWpjf4R4UI52nW4TDMOlu5ydYI4j8tjnk
         DR8S58CcBZnn5J8c71I/qmUGGFA0SFz7tihcuiso5tiDxhC0coVmxWaidDvre/vNIt4G
         3hbuUOSvlocZ2SM7l66f/Mz92m4BTLIvWPgicHuWN8r5/Po2ZTbSvQylOlZ+VQS7z5Vd
         7vwFhpYJG2FPVoUtFFGNBACfbb0nA4rdvLMuDgFJ1X5HeN10ma+Y1H9nqEeWuYGgPvUV
         UWmgtTEUN/Eg72+2IcfhfNBxKefJDknk+ZTYm/sIIpSOi8gLYGRInHtk/3V0X5eBnC+n
         vR5w==
X-Gm-Message-State: APjAAAWpavOlLjXthP9U0PcYx++ci6XS3dtKjxaDyq0svo8OqUPfHsRI
        iXQpjZ2dBKmHeFfgSXJIf46hQoyQEXpn1MSehO+HIw==
X-Google-Smtp-Source: APXvYqyGVV4UqtL4SyuFVuLy4As2KjplUBshYGHg/OONSN3srDOmMtYRsJ6sOWrUX2XwlAdRaYdP14jkVrCbHX6ZEvoc7A==
X-Received: by 2002:a63:1305:: with SMTP id i5mr29060137pgl.211.1563220825360;
 Mon, 15 Jul 2019 13:00:25 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:29 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 12/29] x86: Lock down IO port access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

IO port access would permit users to gain access to PCI configuration
registers, which in turn (on a lot of hardware) give access to MMIO
register space. This would potentially permit root to trigger arbitrary
DMA, so lock it down by default.

This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
KDDISABIO console ioctls.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: x86@kernel.org
---
 arch/x86/kernel/ioport.c     | 7 +++++--
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 0fe1c8782208..61a89d3c0382 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
+#include <linux/security.h>
 #include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/slab.h>
@@ -31,7 +32,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
-	if (turn_on && !capable(CAP_SYS_RAWIO))
+	if (turn_on && (!capable(CAP_SYS_RAWIO) ||
+			security_locked_down(LOCKDOWN_IOPORT)))
 		return -EPERM;
 
 	/*
@@ -126,7 +128,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) ||
+		    security_locked_down(LOCKDOWN_IOPORT))
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
diff --git a/include/linux/security.h b/include/linux/security.h
index 8adbd62b7669..79250b2ffb8f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -108,6 +108,7 @@ enum lockdown_reason {
 	LOCKDOWN_KEXEC,
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
+	LOCKDOWN_IOPORT,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 655fe388e615..316f7cf4e996 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -23,6 +23,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
+	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

