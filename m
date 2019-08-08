Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501488571C
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbfHHAJ2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:09:28 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44299 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbfHHAH4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:07:56 -0400
Received: by mail-pf1-f201.google.com with SMTP id j22so57768118pfe.11
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+lxhGCdajZtpWA+WbiP8jppyBQ25CBPRuMFm1CLt5nU=;
        b=S7YaGegxryfNkKXwSI8xLioAJSlCyuDkJE0jYWag7gVYqqzwEzJCYwXDG0GkmYWYP7
         yzHJ2yFBgIVDJfmf8NKFlVqYb7wWryKw+LpQm9+dtyGSdBohJZDjWVT8QZePp7+nc7hc
         KNjUt7Eo0aWXYJZTpXOt2d34f1ZkTebgP0rlHFbRNy13iPUK2PqNCUqcWSYvG3qM+2rz
         PNpoCsAN2dHagbKUz61/zKY8zuEhfQvereGVLzi3Kk6i22Q8jRGfSB+h/rou8dD1V5bw
         j3jU5WHYpAAF50obcByRqCOKVWCx8kLSHtGQgHOqxQA8cozwJ/UA/r+jR6DeSHWd/Gh6
         Ousw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+lxhGCdajZtpWA+WbiP8jppyBQ25CBPRuMFm1CLt5nU=;
        b=kjU6egBWlCBjM4N6k3qdq7RDUC5iR+WT2i+Z8o8upiDWHJrgtPYViDOFJsjmf/sxpJ
         S43hAu14pwGmKC//tBezlKRAYtGwFIe/Q+cnyx0LNeXq2N1VJbUZrpN8hQKdI8Ih1wAY
         oydoALb5plpvPBcwGm4oYY4kAJAFwvZmbqstCH88xlyM9N7xVPiCHvdpPM19kqWgOODc
         pm6ZhBHLK5aVGYFZGkjvGEmI2nMiuK8hTVnrkiNgUCIrXc5YGd2JBMY4QIo3MuG4+0r3
         pDx5GOWoD7WKuOKZDN4mlHkl9QxOGVKZ61nItSKWNjd9lBa8kfeWT9EBvGjGhHe0xRjK
         Qy5g==
X-Gm-Message-State: APjAAAWejDtra7Vzte0eC5U287eHQSTGOQwmZjRqKVKVzytGdTIppf2t
        0OBHYYJWam6dIu5rshzaypRmu7pvcC7jJ3zOEfZWGg==
X-Google-Smtp-Source: APXvYqw/Ecrz9aHXpE6oYbBKgqW66Iqdnk5b/iTXTY4B3ihijL6hWDBQG5Jg8iVaMHXcaTuQe5IIa1Lw8QNKa2JehgqmMQ==
X-Received: by 2002:a63:d315:: with SMTP id b21mr10219401pgg.326.1565222874892;
 Wed, 07 Aug 2019 17:07:54 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:04 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 12/29] x86: Lock down IO port access when the kernel is
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
2.22.0.770.g0f2c4a37fd-goog

