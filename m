Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A720C4F269
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfFVAEh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:37 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50183 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFVAEd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:33 -0400
Received: by mail-pf1-f202.google.com with SMTP id h27so5295803pfq.17
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KhB8k5EQ6oackeS+pjqoF9TX+2zbJEYkNBGyLQREeww=;
        b=fpp37vrxC2zzNF4VYXnqpXLxv/GRJVI9czcu5CjPcqPqIYiLaMJlD2Vk/Uwp7TAuhD
         n8W8D3vPD+8NKZ3to4ocFRbsjD84dm2a22V7a9tan3vAnDLizMLJQHkgJt0aHe5SGXsI
         4ecUre6B5AxnZE+Tf2Z1k4s3s82h4dFaNiLPB4pJ66yJsjbx9mkKA8Q/A41O+blCEUPq
         u0OLJipGcviIsNscneNUdtsGZnCMbcYLcghvwelZ8mrEOqWwO5LcJ5pugOLcew54PeI9
         p1iCj0LwWuUUDpV7f4UipuTFmNRpd7DYGG1Qt9G0H0nxcXT/7VuiZkdItcOYIzxoQC+b
         Datg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KhB8k5EQ6oackeS+pjqoF9TX+2zbJEYkNBGyLQREeww=;
        b=jpK2r7XgXJF+xzonbg5bHd4k23YB7M3V9XBOAwDa/657chVngNFbbcLHP4L6ff62fX
         4mysdmd8nbDss1N6IV1jA8OtcGjjR9Jz1bPOkyzpmm1jvtsKkid3FRxKazVQaYfPY7Kt
         C5ygL/95EW7EnPpKkmMtSN+QlgfVcQypOgDtr1XJCX9ZB1zUE+8sDZLJoz0zBSVx0vsX
         pCnlbRNq/o6nI6oNbk9i6okvP4P7OJ1aL8GGiWXXYmrbGVyHvsxA262UN+yC+OepJvPk
         Xa8kocdjBIBsGC0uGx9tLpSVyxs5dgyrrqRFxEJYxWvSZyeNvz6v5uZUYM9hDoVNWX43
         oQiw==
X-Gm-Message-State: APjAAAUhsGcbnF2hJlhOqVOFNhAcHIbzK+/P5/lsnFo9OTPAvYdyWAtQ
        IvCrrq2DuaVo4VCoq1SX6dahZ/dNQJHQ3VNCG59LeA==
X-Google-Smtp-Source: APXvYqyeoN3qECYwlSUWOV5qISEKFpiFf7um1aRObU9/wvILwiDNOLiFr99GCpgElPi0EQ02dPrioEU/FKmIqkY17ONTGA==
X-Received: by 2002:a65:64d5:: with SMTP id t21mr21487870pgv.310.1561161872026;
 Fri, 21 Jun 2019 17:04:32 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:41 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 12/29] x86: Lock down IO port access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>, x86@kernel.org
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
index 1b849f10dec6..60569b7e9465 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -87,6 +87,7 @@ enum lockdown_reason {
 	LOCKDOWN_KEXEC,
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
+	LOCKDOWN_IOPORT,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index e2ee8a16b94c..895ef3ba1b4c 100644
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
2.22.0.410.gd8fdbe21b5-goog

