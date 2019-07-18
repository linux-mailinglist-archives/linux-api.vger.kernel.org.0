Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00ED6D50D
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbfGRTov (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:44:51 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:38076 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391695AbfGRTou (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:44:50 -0400
Received: by mail-yw1-f74.google.com with SMTP id f15so22133577ywb.5
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RqpfjquZ0GE2zpg4eJx3Cd128lI5VFuP5LKKMsWaFSI=;
        b=qB9l0rlZdf1ZSzaRrkTDiiRPVJ59qbbPv/eC3uB0Eygb7kg3fkemSZwjWZu4/V2e7r
         RqGqRUuCJJpwr+tC6Eqans0mir3JuYlFXe9OUuCjNjx7dr94sdMzyJssS6GNXaJPaLA2
         jLr1mPI6iXVmtCKOQzDzXuWUR9KeIUX1YwugsPZbbx+3aYnwWBr4Tm8dKeznrou7F3zH
         +6GQwehAYwQ91AzLcAQxko+dJauQHFA+gVoaiM5xlaraqYrmD2AVzvat1ZR2i34hY6F4
         vPdulwSobVmL4QVh4zui3Jy23qYxvfpcYiXoLPjoqjIFO9noO62KTo1vNCi8XTqGvDDk
         JNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RqpfjquZ0GE2zpg4eJx3Cd128lI5VFuP5LKKMsWaFSI=;
        b=TJaz0bw9/3EQoGtHcwn5cFfp+udd0cMwTx12hOkBZpZjl5i5mltz0pNtdkZZsUW9a/
         i+G3zCm39xYmdmWdYcxYnMRh37YsLrCO1QJe3K3lXZCxdZB10LpIOpbgEdzWyDXJs+L6
         9aazWlphTDipjqdynRevqZ2k9vhN9CwuJu7bBCaWDt1NpTiU+FlSjUR4+GdrcmtTdQEJ
         4omiRPlReFfcr1DH5Lfqt6piK+2i2UfNAKhKo1KCFENmPIPj6CG+fEpU3sVRGyRSJ1E7
         KIFdSCKThctdQXqMjHa/cEL1oGt23fjhBu8mMYlEuoGGSZ325zxIRLtby7c9tQeVRJrY
         C+1w==
X-Gm-Message-State: APjAAAX4yEv33qvQzkwcmm0ZD6OSFXo4e410XVueMO3cpDxDGEYgE+V1
        9LGJdCksyQ+bQgTq7PYOahy4P2XqoRDvdzAfzUt1tw==
X-Google-Smtp-Source: APXvYqy/t8VeuQfO2ZAGyoAVYFHwDJHul3AKIzmL6DhaskBsqNip8Z6iUGnuploP6DNyyDk+p2NwIaUJnDyntsETVXfrxw==
X-Received: by 2002:a25:2a56:: with SMTP id q83mr27205767ybq.299.1563479089832;
 Thu, 18 Jul 2019 12:44:49 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:58 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 12/29] x86: Lock down IO port access when the kernel is
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

