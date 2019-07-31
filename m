Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056047D09E
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfGaWRD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:17:03 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34731 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbfGaWRD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:03 -0400
Received: by mail-pf1-f202.google.com with SMTP id i2so44194596pfe.1
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HYGYby6crp40dCLBmhgwCvdnfCZZwxit6AHkXOrrVgc=;
        b=vEIr33UIHvwt3NqWIeZrb/59ulOIkcz7rfoXwf/T7Bm7ES4NLBQqA6eXizkSfE5vv3
         FVEAfneKoLgNu2aaC4bzbB6LYw3f5NFnjVqP9s+oObZTrYzSawiE4g5T+5pK9LWkPzUl
         7xNScG5swOXfYyB94pVc7cUTPklTEBfex/kk3GW9Dg8+hjfhm1+QG3rYI58FWSo1tnd4
         UeCcXHE0/5Ni3ftiD+G+C/RFLw00Rz2lckGBrmAO/B7jRyjVzhQxOkSNAX9TQgQB3NmR
         7rl0+tiA/WMA9OSfgrZdMhc7qhOUYeikze2HYm/uZdry/tyxh+9xAwJQvnLL40YFd70T
         P3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HYGYby6crp40dCLBmhgwCvdnfCZZwxit6AHkXOrrVgc=;
        b=oemmtluOdLCJXbsJOGRfi3//j07q7QRLWrDPgBUXn11L1xljvbQJNuG29VxkmVnyCp
         MtOeQ+eLnvnR55qQbAfcTA7o0CZ47G62dGoG2Wnr7/yzCSAS0zVT553PSSElCIeEsIxA
         qbpoNHMaLaigS7BwvKlmAHHuNt98kfPL4kzj7bMqAm2mq8mNqOJB4DwFzvdMoQDpiWp8
         hc9ru41gtXJZ+8olEfeu3J/uTE6HYiR1IE0Dp4tbGGSDXxPXtYJXZX+UZt7oG4yQeKeu
         YBWr1CHn1dR922DQL4aeYUnqLVR+9z8G4PFf2T1YFMwlj9Y8KbN3YLIgOKmhyxxHPki5
         Af6A==
X-Gm-Message-State: APjAAAWDHjD8OyhKWgQUo8d1PATyhXaX20qAbEh/Obd3ekpKAOUr2sgN
        STMJPin4/fCGla3sSK77xcvI420HMRtVeBFazI7o+A==
X-Google-Smtp-Source: APXvYqyQZy9xxO83dP4iiWV5yfSeSzijFuI+zHtpaDtjdJ7UzaPhV7163QoMF0NcR4Ie34IrDesajYUwC/D45vF1v4y3aQ==
X-Received: by 2002:a65:458d:: with SMTP id o13mr114131617pgq.34.1564611421758;
 Wed, 31 Jul 2019 15:17:01 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:02 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 14/29] ACPI: Limit access to custom_method when the kernel
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

