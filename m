Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D143B69C1F
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfGOUBu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:01:50 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45110 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbfGOUAu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:50 -0400
Received: by mail-pf1-f201.google.com with SMTP id i27so10859584pfk.12
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=27bG30v551PCUw49w0IhwfwVjWUxHkMd+OR3VLoSFAQ=;
        b=TtALnbKpnTpmzFXbZcyThBpPXUD2vVMXHLz9/K8WCJZcT3sMigJcUb/tqieCDmJYOh
         LKx1gN0TYA3+pZ4/kF+qHhWNB06etdiDXdmEYNb/MtNPes8oGYvUJlPhfR4z8qXd4ldc
         q3cHPE6KMeWpAwlHSonpn/7Li7o6pH7n3SRDWVXWy0KDhxAewWkmSChbNmDmbAwsy+OO
         m/KF6f0nDfVKtyBESrNNS6tPtxph9XndwqSrxe5fJU3pbkhLrN14ZuxLHqMZ6DVhzq3x
         Ll+p9sRpyRcNcxXNlcvQmuSwnxf+IIPUZzC2PZ56UEdGVoIGdscmmb0Tqyh/yQPbDJ0N
         HL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=27bG30v551PCUw49w0IhwfwVjWUxHkMd+OR3VLoSFAQ=;
        b=d9uF/Iz8gdQQOzarbMf7SFpmtzgn2d0o4Bk4Xq/vc8r920oW6NVgiwFIWMm6HaK7r5
         cSms/NyNKkLzZkRSAy94QHxGu83n7XRfWQrd90Z5yc/SpGfmBknyO862gH+0yVBjwMz/
         /vME/sJn7mLIuwnMXlv4pfrkUcvfY7b2um2V7ouU8rBUpHZ4qOL5OAskrecj9HK5X30G
         YF9VR5zixq1TkcoKgaAq6V7zqLt9MJukOt7nXR0a+R1NVjshW4Sq2tf/pfnshpCoRpf3
         YcLeKfKBCD4/lXtPjR3tZ3GIFVPCWyCO2vNiZC3nj9Sp3+UkoIK+MTuYYmHBXDIsWWv2
         HKyQ==
X-Gm-Message-State: APjAAAXdR7tqzqUJeSsShpd4MKFfVr1Ed9nzUQOX+1Eu0uUtRY6t59bp
        Bz3XUNk8f+Tanw6HBiiHhQH94lIoVuCD2XZEhj98zw==
X-Google-Smtp-Source: APXvYqzkGmLJbJxcjs2hj9aWPl3QD/H1QcvcXF5PeHJYQdVT4P2+EUPV+l8kcWG1CRmP7Y/ux0sv82HRaOS4eeckdgZiew==
X-Received: by 2002:a63:4522:: with SMTP id s34mr28567890pga.362.1563220849269;
 Mon, 15 Jul 2019 13:00:49 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:38 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 21/29] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data. This is limited to lockdown
confidentiality mode and is still permitted in integrity mode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/kcore.c              | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index f5834488b67d..ee2c576cc94e 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/memory.h>
 #include <linux/sched/task.h>
+#include <linux/security.h>
 #include <asm/sections.h>
 #include "internal.h"
 
@@ -545,6 +546,10 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	int ret = security_locked_down(LOCKDOWN_KCORE);
+
+	if (ret)
+		return ret;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 3f7b6a4cd65a..f0cffd0977d3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,6 +116,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_KCORE,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index e725f63c29d2..9c097240a3a6 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -31,6 +31,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.510.g264f2c817a-goog

