Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06514DE87
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFUBUW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:22 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:46524 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfFUBUV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:21 -0400
Received: by mail-vk1-f201.google.com with SMTP id p64so1922074vkp.13
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CzBxgMlxffTA0lJ5WOaB1QtnT14VCitT8JguNCecpUw=;
        b=nfEv5GDn7qzUEFAMik5m0jrcBfN7/vHJcWuqbj2vRyl4pepxUY9LA34VHUAktFemJa
         TUncVWKrSoPgIZoiMxUX5MrxFk0fqVIg+3NhDICooGFUPooEaDsgwXEYFJDrgBGHgX9a
         a4nYvBvXCeJ/diWDIJjX3sTOBX1STejQuLYZ8uoS5mAVGSzya3l7nz8q+n5fDIXHDkHA
         oDvumuHZMTWCFrQefeXaidW+ZBhlkOeKRbIVtWU697a2EiBPpmINDnQ/ZhJM7mYwV6wp
         KqcwiwWV9ma/4gILbOVjh0W9LtqiqmFhj1sz78sQ4GlRQS4oMeboKNmPL0AlFTn4G3cQ
         xkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CzBxgMlxffTA0lJ5WOaB1QtnT14VCitT8JguNCecpUw=;
        b=UvKdLNzg/Dp2qhiChT3dQl7tMlrSPMkaEJ6OuOjnZ+AuP9em+L7V0mFgCcqB3qx0GM
         ehl3Ts/q+d5WJgKaBjWYeIwU6IAhrL1JOa9RmCyIM9taJGgNMbrNlG2dg9ibhhkC75+F
         bR2aB9xrqrJVhEvrVtS1NJ4txofqSHvu2KSOJolsR1jfm1rViDenT0Csp4BnTl+M/NrI
         VB6ZKn2WYDloszsEWtgPBqANCGsA9TxSkJwYzN8RTyDydOBzAR2kLj5SXyIvlxysNjuU
         8+YvRoahaWTbl1f1pquMQQIowgqjlfZPi/egBqpzSsyeYA1JD1yFtKfGx47bVNi39QKr
         58RA==
X-Gm-Message-State: APjAAAXCdZRPMnsNcrDAvYxFNB3HQF6O9GAJwPNQv9ruMRrUFaCNWkRp
        hKsGg+lFnEIHT9b40BtizMqSyyZroM/KiQlEokXFgQ==
X-Google-Smtp-Source: APXvYqx0Rb1ARR9PojtNfhWZw2VUMZsavzIO9nkzoNaoUb1T7EzrbSEu8XZQ8HWIliUpSRN1KS6nSYFystZ7jmpOfELIPQ==
X-Received: by 2002:ab0:16d6:: with SMTP id g22mr76010599uaf.14.1561080020630;
 Thu, 20 Jun 2019 18:20:20 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:24 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 13/30] x86: Lock down IO port access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
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
index 0fe1c8782208..ac0ba0b2f3be 100644
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
+			security_is_locked_down(LOCKDOWN_IOPORT)))
 		return -EPERM;
 
 	/*
@@ -126,7 +128,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) ||
+		    security_is_locked_down(LOCKDOWN_IOPORT))
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
diff --git a/include/linux/security.h b/include/linux/security.h
index 95aa5ac1fa6b..59f0ac7adfa6 100644
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
index ae76a7cce7ba..6e426887bb23 100644
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

