Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2507D0F4
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfGaWTM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:19:12 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:43542 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbfGaWRI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:08 -0400
Received: by mail-vs1-f73.google.com with SMTP id w76so18226780vsw.10
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=KNtYwwW10pBzgMhIxkJCS/uENsLSdnfeR4Sv0jIZjE/kqgEDSSHm7qFmZbYcYGhoW6
         ah/D6endKWnFZUJYaYj7c4Z+Ww90IGwhNDxIsN8ddpHHjZu1K7WMe4g+HC9ErAOL+Oan
         P+BwGpuxFHwb5gLspVTRu+6V+KSMYrvGqWk/8uA5Bh2vAksZ/MPON9EHcNcYaMbAc+XA
         C8a2S8I67YkszaV+R1icsFv0U0LpSf3kIpJXXD+cQD5wRZp78DzPMYAZY0V+NEYlQnJJ
         vgeuo4JK2gW0U5FN7kBmSeEw1cE/vN5M3uTg1hBFh/FZ4R94jpLxHeYydBoPJgYD3CRN
         TwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=G3lTdcg+qHo0BL7xVtiF5SLuoYXcC2zlDs9hp3itJcMdneOlvpCj5s2FwmFT5I4Wu2
         8n5jYupuGZnQiUCZN9PvgPm+f27pRXGXYw4KTNxhQaXNk7LeuUEWa4cmjgVTzulAbfY7
         ru42gx8su4I6lZQ4SBKBlgzD7xIK2ok3sKtBw5XMrrht+yvTpx+RnBdzBBDHVbXypbpj
         CkloulJV8nfaSLE8UE5z+IeqY6xtXS0LRtgr3MmiNciCjVmJp10guY5a8kIBZiesTPim
         r001QNDPoB5/A5kMfhRn92x3D+S5I5xra+aIwIR7UrpG3MH4kC/p6sLcXeV8EMoz1EO2
         2WeQ==
X-Gm-Message-State: APjAAAWYpb8MHk5+8vl6sl64QOqvCxBdoegfReOFr4FXYie0dgjB+DKO
        yPOVGkDI5RFEY+3uFfMJ/jWbfnIWA/bHjQWfo0DFWw==
X-Google-Smtp-Source: APXvYqyn7wWBd2XqZE1SpADBue93B65mbiHUDF9eDEu3R6HN098MIwjsGaS2ZfwdCHJzwoGqIuAtZDoBJTZs2wCzIwTnOA==
X-Received: by 2002:ab0:4307:: with SMTP id k7mr12696958uak.45.1564611426939;
 Wed, 31 Jul 2019 15:17:06 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:04 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 16/29] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <lcrosetto@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Linn Crosetto <lcrosetto@gmail.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <lcrosetto@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/tables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b32327759380..180ac4329763 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -20,6 +20,7 @@
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -578,6 +579,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (security_locked_down(LOCKDOWN_ACPI_TABLES)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.22.0.770.g0f2c4a37fd-goog

