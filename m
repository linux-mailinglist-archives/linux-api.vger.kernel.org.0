Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1134DE76
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfFUBU1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:27 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41952 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfFUBU0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:26 -0400
Received: by mail-pf1-f202.google.com with SMTP id q14so1563788pff.8
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S9uK51Tt5kTkNleSSR/hMhgYxxujw1wxKeyqQuG6LR0=;
        b=H5xvGNs3/JGGDuqCosXJWsRozrb5ppiKaTdNYWvS42z7Nm1KS0IDqLzZj7y5L747HS
         LZ30WMLFKfEiTA9DmEQyGsStSLAeQDYtd8KjP8EeErMKxa1ixgm0YvXUBMGd277RaGIt
         sHjAP7bA5KJmvuIk50IAlBoQoBZvyOqtsA35V+Ivo84S0hn5KcJPKZg/W3Ghjf/qBK23
         cPTwV3p0MO+KBxmdRGAatKc4IhIJ0MSdAxDnJ42o8cUHOl7U+j7cJIvuwTfhjU5x6aZj
         DrJHuE1edXR5UUMVvKGCWk8fR2wVKaYYeQZIW/HN0qH6jTY3yRrL50noU5MI5CX8cuvJ
         0URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S9uK51Tt5kTkNleSSR/hMhgYxxujw1wxKeyqQuG6LR0=;
        b=qmqgQ//QumZueSmoVWKW3lDl1DfA+Sk+ecyYzJiktLWe3txYRBCL/eLDxeOV8iSyxt
         58i/PTLkLtUm1ROW+3gr2H3Fg64IcPy1JzECAth1bbx6cgfEJlCXNeQqvDKIfii7/XbG
         Fp9CWy8dEyrP332NA8K8GXhRjfKe+RW3mXFiN39LXHcgGKcv5jb9XqBDumINRzvVpuQ6
         IYWklAOk6jYqbDAXsBDZnNUUDy2lnmqNmy0Qn6RwWz3/zd6j0c6UIESvWejNDiUIfdXR
         XRDgzAhvQhpJnIp4HfsbYnu1KmSvAxt+GrizGlaB5V2POF8ZzEyJTD7tZK2X9B839HZA
         orTQ==
X-Gm-Message-State: APjAAAXjLRiPlSPQItMI/oSET5tK7Litry/ukIISExp5p+H+f25jWt3c
        ayU23FoVnfMfcWdbgL1f+jUiLviK9hZe9HEHmBjITA==
X-Google-Smtp-Source: APXvYqwu/7e8Vq+i5eFYDNfYaCHNV6myTYb8Peic9ryWcCRijQmNJ86iOc+yP6VTDURQPWb+hiVa7wAYEZH4TGdWSwApEg==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr6048922pgc.63.1561080025466;
 Thu, 20 Jun 2019 18:20:25 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:26 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 15/30] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>, linux-acpi@vger.kernel.org
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
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 4 ++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index aa972dc5cb7e..5c684b09a2d1 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -29,6 +30,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 
+	if (security_is_locked_down(LOCKDOWN_ACPI_TABLES))
+		return -EPERM;
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
diff --git a/include/linux/security.h b/include/linux/security.h
index 81c0968e485f..88d0f5d0cd87 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -89,6 +89,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
+	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index a01301972290..bfc0e088aa85 100644
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
2.22.0.410.gd8fdbe21b5-goog

