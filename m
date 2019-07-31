Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864EF7D09B
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfGaWQ7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:16:59 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:51158 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbfGaWQ5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:16:57 -0400
Received: by mail-vk1-f201.google.com with SMTP id p196so29966451vke.17
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+lxhGCdajZtpWA+WbiP8jppyBQ25CBPRuMFm1CLt5nU=;
        b=j4MKFnGU7X99YI5wLcfXrhbOFDvuZvPJ8DeJhyJvAsxAIFQzgYt+EFTnWPv0qMmkqR
         RG0mjKzeZVlqOwakSykYJYD4KlJ6ZRROwgtz1cp0jWXaki3qCH9YM8h6Kql3AgjbTz3t
         7UnMOKbyWLe96otjDVG+dPr1R4wuC89qSfNHZvEltYLDw8qpgwmXL88G1rNcHSh8Ucbo
         ch/Jb5eC737kJjy3xmYpy0cGNVYHfTX0wvJfVwGTLzHiYfpNJAZHSMZhxoPG3QCTu+0+
         AAWnCM2SF0ibefGRIEsGmypEVjUHwxuhFVw1+MxxB9icrlIFugrsv66o4wI0DPZ0k6yJ
         OJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+lxhGCdajZtpWA+WbiP8jppyBQ25CBPRuMFm1CLt5nU=;
        b=Y1aSb+laaNH91VHp1QTKnzMnR2+oaoAKDGO+Mk58pIqkmnmf1rx/F19A93Fbfm6Rzn
         4FxZLQ22Wrh4P9TMKWsLEdFcnMD0a33B+3cqJGzPU4DzE5WpTdzoIKQk67NkNFp3jqYt
         6Zbv7E+lbRR331up1MRbJqE8E57QgZs+JeNOsapaHAPD1v1SiohH6CJ5V68Xs8k3pOYq
         ulWw2+DMP3w90UQpV7RY0SDxVbaq2hmMlGMnAm6sy1jPWVhxsJTATDElE/rhv8T3spux
         oO4NoJKpf/InDbbHHbyYjlHj11kqBgEi/EySpTKXIfrZpbaqBju8hIzeNMAcG5XiBqqn
         8RqQ==
X-Gm-Message-State: APjAAAVuZv5H0MT7D2fOviR23Bkv4bD5sptNYAAyJCue8TW2z77hNepW
        ZVT/03YSNbQESZnpZjyFF9+ONJn5pDlUUJLbS1HRjA==
X-Google-Smtp-Source: APXvYqxwKJQQ8ekyXiq1k3fR6hTec9hMbAJGRiOniCHDcosaUUyGqhUT6qBrA15i3/RsTk4jytW4bKpkShWzY+8vWDLwpA==
X-Received: by 2002:a1f:3692:: with SMTP id d140mr49563787vka.88.1564611416854;
 Wed, 31 Jul 2019 15:16:56 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:00 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 12/29] x86: Lock down IO port access when the kernel is
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

