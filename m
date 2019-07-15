Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9750369C2B
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbfGOUAc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:00:32 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:41879 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbfGOUAb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:31 -0400
Received: by mail-yw1-f74.google.com with SMTP id b75so14444389ywh.8
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZEWny5IFVoAY7+7cwG/iN1wA0h299zlUxTBItvDj0ts=;
        b=Zfkc7JwT5DU9z/o6qruZxUvtSG5dHseEY5MyWv9EfNowXWpECqNH74HmrCMpY6Lsun
         3lxELHqfkmTXqStjmCVEcrC3IDwxUkHckii/7WySAhjlykpTyjBF/liwYjw9UnL/kVae
         6ClWIRuDpOr2LvVMtLUJHKoWljg+4Ia5S3WKrOGk7PtbLhtvrFnyIgSOjTwxG00RrlCb
         3oWH8ea4VF9Ft1q0IQz4DKN+4VMPrFH5nCiC93O9QyydA33KSjv/A+IzI++Hmng0T7tw
         9HMZSl3RRI4QVLFy5s5SjteInYvM820efwrlprc802kSCOH8bjGGcPa4+zTPM19yVLAS
         8Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZEWny5IFVoAY7+7cwG/iN1wA0h299zlUxTBItvDj0ts=;
        b=kM+Vpg009BfZhLp6h64x186adBgCnGqyg5+dGwAIyvZ/GNI8IVXlt2+0pFabBHpjCC
         Xkny0iW0k+C6KLROa0guURzqZrY2RDqbWz79tf37jYFUUOadYjstz/Q/ExfD2q/3p5W4
         SoY6Xe0Y5/3hxNLvHVhox+Iac2AY7b8P9yL13EBf4xHT1gaeu130bjOwTdRebMwsR4KT
         3rg9hIm696WkFf/mucF0N2Zet7gblygdvtDGNoQ+0ma2bTLC+dx9k4irx9YUaMCjolSG
         glv5AALBuv9W1LtLrCFJaXcclwXCvQjnL0J2Ontn0q69tK5ZMk/sPPNdGimiWJ9g6JGx
         GeJg==
X-Gm-Message-State: APjAAAW2uuR43oKHrHVkAT18GZl4hzsglrTUdzbOfaBmvRBX0DQj8GTx
        cZ++QEAgaTqQuN8FL2KkIa8RO58IiF+rO5UxrkunDg==
X-Google-Smtp-Source: APXvYqyzP/ucQqITruoZ0U+xlf6n9TF8TcpzkJcXEBuAaYKylOcVnzZ/5O1mjzra9mVwgBw/6PyLE7/KRPqtyFMjsNtNrA==
X-Received: by 2002:a81:1d05:: with SMTP id d5mr15971402ywd.299.1563220830741;
 Mon, 15 Jul 2019 13:00:30 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:31 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 14/29] ACPI: Limit access to custom_method when the kernel
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
index d99c0bee739d..67dbc5c70ea0 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

