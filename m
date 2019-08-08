Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E497856D6
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbfHHAIG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:08:06 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54277 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730681AbfHHAIG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:06 -0400
Received: by mail-pg1-f201.google.com with SMTP id m17so47629079pgh.21
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=Kf/lJKUGyFrHWv7boTRudlru1eDOO0jCqNVRU6s/zrZ4UBZ45Bbg1hHE2vw7Kquw/O
         BtmrDHrQUguITMHZO1XRWt3qpTLuWh6bxlUqECbMiGx7OZtBnvpDBakjN0ycek+Ym0oT
         VEE/nfvsA+clVcjyvYnP3yVfxBQ9QpNrgqiSN9iXWbQBKtZODoUBJE3gL1xgQP4vtAXo
         kMtaA+zKROv6wnq4ugj/1KFMS84SGY1llsNh7tQgLT1xUYuAM/6MYMXMd0eGnvzRvPLX
         JyMQ8QDVGqY9caZ+fSX9gEVqLuWWBd36lDPkXMHTMMeiOjGTb3iNw5XbNw5OK6wScvda
         CO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=V+d7VipzvyyrQ1pwqX0MlHz2aQX3SCAr7HT+lQ6sqLZkQMigOsXiZUYxCRuhLgskk+
         8CdppC70ww6oYvrq5JGkAgN7Ow43+k6HO58zjtzYqsuwXle7/qoV6R6ezxSN/b+f/bUu
         Cs26plAjvkpkHEDaTZB2bHVrAbvawzTHIxiAUQwsQYbBCNO8OLxCtPiCOdtEs/Q3bJez
         +KJVF5uNyJ6QrA94XXT5sb+YhNw8fuHZbbjoNI/VWXPeAw+WgEm+IP8M0ujL4q3JQPWd
         tdOkGBmOKVCvnY6vQPZ8Hc0Y0HYujX5ia/si607x/9MFviV6dxJey/xr2g1Ihbh+dw62
         R9kQ==
X-Gm-Message-State: APjAAAUjMu/xlR6sa7EGyqQUEKm7YpM9TFmEBob9UXoqjtVvIb2KhBZF
        mLm7zIfGaIODFZsW04o5UiKxw5q/ADePcqSTScqi1Q==
X-Google-Smtp-Source: APXvYqwwJbX16Z8GxujpyEl8EKb14qjxjwwHWOxL57n+QSxdmTSznG4fkHV2cE5AB2mqJ3GSZPqFVdUoApC44ww6iiEddg==
X-Received: by 2002:a65:6859:: with SMTP id q25mr9838575pgt.181.1565222885343;
 Wed, 07 Aug 2019 17:08:05 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:08 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 16/29] acpi: Disable ACPI table override if the kernel is
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

