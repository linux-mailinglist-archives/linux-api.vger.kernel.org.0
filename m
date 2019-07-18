Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F836D526
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404008AbfGRTpP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:45:15 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47453 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403987AbfGRTpO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:45:14 -0400
Received: by mail-pg1-f201.google.com with SMTP id o19so17212774pgl.14
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mT71xXVMH/YHXOSXzvPL0YxfKiIdabN6lyP5dpCrImQ=;
        b=vodmcAMnUh0hMddJHJka9lcA79+EsuKYh9jQ/nRDimpHP2j8dNS8ZkNSHnz15Zmqxx
         8T5PpWkIyrO0Ihi3lsLVJAiZ97yw/aI99IUsFCTgFUHjyHhUXbNSNcTg9QWvbAzg/tNt
         L0PHpzxXoK70mVorxkpV8am65v+xyxN+KJAg3OvNkHdHIRddY3OJPlIZqkHhPdmzVq91
         ltHihVyene7ZHPNesB5qECUzVqNVMvBNHmTKBQA2VOJBmbaUJKj9vBz4inT8xG7TzG/S
         HB7ijyroYoriT/1w/4121SWUE7G78gYZB+0NUbyp6tIzdK2uWXRNVrrNFKG1qVdw25Lx
         fKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mT71xXVMH/YHXOSXzvPL0YxfKiIdabN6lyP5dpCrImQ=;
        b=OnllMBqKPtIWj7UFn2/dw4hVqVzI0DZfBPwGZRr67m2raRg/kW7ULjC7Kh30DJmL66
         BQYWgZbqK1IS9Mpk1MVwzMzRBdF3yDMDij6QJaPSUvnwC6a27id4QIjgGNirVi/6/Pf5
         /b/xCSkIr4JI0b/sSosTwoBcIR/y9/YhWMgvGzv4l6ISnkU8vUVdc3eF2j6YG+Yp7EgC
         2mGX5LqqHpd+fu+JQWVsoDy+YCRjvprmElYdHcazIzgVlLat1kGmN114TJPVC8ZfzIPR
         aEBwwY6wVjjtIzfFoBmSIVtfb2IEL2lksxwAdk0gdVFlp27sph0C5JmpTXDJRfpWnFWo
         kVyw==
X-Gm-Message-State: APjAAAU24RTAcrZevBkERmDaNoHpYYpb+lIE27UYLo0Pi2p8CXvKGeNB
        flTZefTqovKX2wS3KL4ui3yKfZCY0NblG31V32kTvA==
X-Google-Smtp-Source: APXvYqzvoYeByMb8GuABYxGSZRPpcq3M3gaVftP8ooVueZdKIuBRQTXo4VTviDY8kkeRKzQJJaR/UejRFk1iKrC5nLfDZw==
X-Received: by 2002:a65:5304:: with SMTP id m4mr48981605pgq.126.1563479112898;
 Thu, 18 Jul 2019 12:45:12 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:07 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 21/29] Lock down /proc/kcore
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
index 37b7d7e50474..c050b82c7f9f 100644
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

