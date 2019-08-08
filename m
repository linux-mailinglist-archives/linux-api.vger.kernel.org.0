Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6F8571A
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbfHHAJW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:09:22 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37746 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389632AbfHHAIB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:01 -0400
Received: by mail-pg1-f201.google.com with SMTP id n9so53109648pgq.4
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HYGYby6crp40dCLBmhgwCvdnfCZZwxit6AHkXOrrVgc=;
        b=DvXSmx2jhj8bHAJU1Vj7/I5jwoEGF0urfO5A+cbejgX5sC7HbhpImArmayvvTCoUPr
         8CDNZqiGvkgLyIndEE2bIpdXQKsGV+IzSKMADXRvJbxdCmJzcyduT0fzwY8j8HBIeFYI
         RvCnY4x/jhRG2B8teqWoFjV0y6rMXouhVAx17hc4EKRJbm8hEKs0tT4SIXVmOEIhLC6v
         yTB2E30QNR055+D8sK0S4jRtnpv5pwNKN8is+YqcKHE+YQ5p6TGqyjJFMBfSxBa2sK7x
         Ief6Shz1b+MwK7E52j+iUBDuJQ+EkUpEeD1pTIXnzK8lUWVelsBBWtqaYI9MAeyOe4cr
         Ms6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HYGYby6crp40dCLBmhgwCvdnfCZZwxit6AHkXOrrVgc=;
        b=ZNBqU0aVjApbarqW2hTZt2PldR4B5b6FG0TTE1AQd1GWvO2gLU83vt//+HAIrZnKBx
         KdkzyneltEOl/lterV3P7PnVJrClbZfpXEdIHgX+B1sRocGbUJ9Qomdk0q1C4PJRX8/b
         oau+Dxi0VMKaNaoNWADGNXHVC+wSX2s889feC30QX9zeN/4b6+1uzuaGHdOeid9KM1VX
         g0RFj1FbLS9tftqlSxGRQU1Lpsy18qNOmmTGaaXqxDIgsul8ULrIMZX3zL5FTFpsXHwE
         rkteQfG6O2Btl4DMOY/9GR1Scumyn92cqUPsdqe5t84F3LRve6/SrHOpJ6c7Wr0uWOee
         Ei6w==
X-Gm-Message-State: APjAAAW7lv4nwth0XzeOFHp5cmvCnxbuHnc5FlvAA1zHyZ7Er02fuWAz
        lG4r48Dh3YqLcjhNbesZuNh0cbO7Fq8YsdHoiXMyGA==
X-Google-Smtp-Source: APXvYqz6bYJHQ5sZ5xj2/KrBurgwQPt+m6iwr0ff7wAAGDBEDLTiqXvJ5XCsr10Ya8UVbvXfbW2QSyIz4Kb0tRI9b5DEzA==
X-Received: by 2002:a63:1b56:: with SMTP id b22mr9895821pgm.265.1565222880106;
 Wed, 07 Aug 2019 17:08:00 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:06 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 14/29] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 6 ++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index b2ef4c2ec955..7031307becd7 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -29,6 +30,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 
 	struct acpi_table_header table;
 	acpi_status status;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+	if (ret)
+		return ret;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
diff --git a/include/linux/security.h b/include/linux/security.h
index 155ff026eca4..1c32522b3c5a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -110,6 +110,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
+	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d99c0bee739d..ecb51b1a5c03 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

