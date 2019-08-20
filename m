Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9896D95296
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfHTASx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:18:53 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41512 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfHTASx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:53 -0400
Received: by mail-pl1-f202.google.com with SMTP id ci3so2936833plb.8
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r2xGnC0FtOlmxcR7U4lP7p0O5/wEeWW3Rzosx6HPL/8=;
        b=JXk7YvHu8uy9Vx2jXXzyKER+S/SWTrnD/83LRDR4ElsTuqbjh18fiB1AgcrqZ1ZtIF
         dMLq3zzoXUE6dXGuKvPut+6ATWyGRbKYpJQIWJjwFu6Tktlm4+khhBMdXLh/0OqWlkJD
         h3VT2eyE0HfHclqvuDTTYe++NSkz3ZXZS/oEfZAVPh9H+VGFEqFJWQTLj/AGb6qRW153
         dVTBXGCk+4jZcyzl7B6lYmE2JFLT24V4zbxfcymtMySEfGel9M+ifHbgb0XkoBrbcMve
         Smv1XxFiTFUE/g7rS3PzrYA0UBMXXLGMKnG7YB3ziODgQiU6yzj6lIxTEPV4wJpLoQRH
         +Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r2xGnC0FtOlmxcR7U4lP7p0O5/wEeWW3Rzosx6HPL/8=;
        b=YA+dFmm+Znz0+Q3POuAdW9zWBc9d6eKnZkOKDchfI832c3MSvgO6NnGmJDDzPGjTTT
         e/7O+U30F+YPhwud3pck1XB+Ts8v6FEQEqJHyi/qjdNXza1dVTx9suAYCzyg3h1kIr1K
         /d+kdB2MTaOBG2D3QcVsJsoCLw6BAfiuSpOhaKFHV5+v6ya4l/O5+nmta1la72x8bYUI
         s0NJHKM5r4s6MzEpHgWaogeDb4EKG3tqbMyLmvpgchpP0Em6u2qmjHStXYaW9Q1j8Zh9
         62pZcchdn5mri2p7gbJVB23Kgc/9/JLJIwT4oBS6+Zhd+bO8pdAtfZl5Nfj4bhxMmCxP
         TLvw==
X-Gm-Message-State: APjAAAWBqbDY723CDfxneH7JonDpm5hez8v+6nhqXS5LIbxhRRRQOGQV
        F+Q3ORo7ySq3hhvmHtH+ODsagO849nPj+oJj2WkSRQ==
X-Google-Smtp-Source: APXvYqxrGakYRkc/UBdl5S+Lz4mZIkCuit30tjXFo94slFXGF6j556kZ0jwzI6cM9tqT+OLJIW/WjG8X9KIlf81TlA81yg==
X-Received: by 2002:a65:56c1:: with SMTP id w1mr21932176pgs.395.1566260331657;
 Mon, 19 Aug 2019 17:18:51 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:52 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 16/29] acpi: Disable ACPI table override if the kernel is
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

>From the kernel documentation (initrd_table_override.txt):

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
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/acpi/tables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index de974322a197..b7c29a11c0c1 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -20,6 +20,7 @@
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -577,6 +578,11 @@ void __init acpi_table_upgrade(void)
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
2.23.0.rc1.153.gdeed80330f-goog

