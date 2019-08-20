Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E472952A4
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfHTAUO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:20:14 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38700 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfHTASm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:42 -0400
Received: by mail-pg1-f201.google.com with SMTP id w5so3486302pgs.5
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kCjTIca0P/GJFxU16YX7DQ4xD2nMI3cX2Z/4NQSE/Sc=;
        b=KQBvkuF/M1dzuAgHwCf82DbbRCvPK9GZf64/jVQ9LTne8ba0vruPyKkUvzKEAV4Do4
         ldosC+iLz6ETawlccozW8ItJDaAXBXZATeA1nO9KNWC66nLVSi/eQGjxAac7SxWtBt80
         F9ttqj8ulV04NpJ8P0R7xE+kPWB2SEZJlKpep9r3m0leisPBJgO+H06QZtS1RIQwOUvM
         aAAycTME7urbUMVzfSxauE7k8SqURCLc0gl2bCAw8gfpHncP4xy8sHCRp5tNJ/ikjNCp
         SBh93SgFozLEQXaTzHPp0WxbWNcOyZQqp2QWf1ydPAlK7JE3o0wgHP6nnj9xLY5ZbGVr
         0hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kCjTIca0P/GJFxU16YX7DQ4xD2nMI3cX2Z/4NQSE/Sc=;
        b=FegmZSMW1VRnK8tlVmepHh0F1HQk7eVkXZU2e27ZuEe0FUb+y/p3+s9rn2iEONy+PJ
         XP0Ik/6eGTizrfBTg012CVL5Xh4pSmiBm6LA0CIyfNU/ukBFfLrAbsQvhhYtPNbDqXi4
         rUo8zXlo8Yry3noAowrDfj45GSZTKhCmPQkM4kXVbr+ZCpYwp8XnVJAuxLhWq5ox0ksb
         QWcBYR3MiQXLoHWkPVd8pCOONNnrSiLzlPoxjxLNAls/R+uDr8ewUNPBy9i5glCOuXVU
         OAp5jdQzQ7t0CP7oSP57EEQROVsoq3gZPsya6a9TDSzNw1gC3ZGBU+nEK5dvdzncg6ma
         Ub5A==
X-Gm-Message-State: APjAAAVOtS2m/I8JQgM9V4Pp75eT95S4canDRvBiMfDNURU0t7bBxZox
        CUzF4HBmjxj+Ouk1nIxVd9oISsTlWzkdgvVy34+ZQw==
X-Google-Smtp-Source: APXvYqzr6zlVHJzTizaYjQ19faJa7QXUmz9jrhB1Y8s+sfB8qo///FW6Fvqhu5135bQUk3prCTZtpuYEGE383ZOEomAwZw==
X-Received: by 2002:a63:6a81:: with SMTP id f123mr22683545pgc.348.1566260321339;
 Mon, 19 Aug 2019 17:18:41 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:48 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 12/29] x86: Lock down IO port access when the kernel is
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
Signed-off-by: James Morris <jmorris@namei.org>
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
index 2b763f0ee352..cd93fa5d3c6d 100644
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
index 410e90eda848..8b7d65dbb086 100644
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
2.23.0.rc1.153.gdeed80330f-goog

