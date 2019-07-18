Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5346D518
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbfGRTpC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:45:02 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:39762 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403867AbfGRTpB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:45:01 -0400
Received: by mail-ua1-f73.google.com with SMTP id 43so2791052uaj.6
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8KDC4TFcTV1Qdw2x6JDnGyK/1HMGYSMk6A05DVDwER8=;
        b=dq01yU/V68RBr2Lu3Ccu8jV81vXcun9dJ22LdvOfwo75XHTlumm+2N75HW/98KlkvM
         roP9j5uWvt0qI0/ymgD4PJlLxcwHRn1BQmgzycgaUEy261hGKsR0sNCwLnmF3JU2Crt0
         mV9LOvlp5DTQnbf+eHXgmQcTf6vdcPYanOndpoSh0UC2Xa9TsLmYlLdHnwaULJeTFFi2
         YXrc1GqxAyzeVGlMFUru9/qj6xUccrDwzYoCxO9/bM5n6GGlEw4sYibtTMdnRRhRly3K
         7wUgeC16EnLGT0oQl4J1pPuuzR++NAjnCvd3j4ZtED8EVEt4cQqWDREp14+UTkJUly0l
         86Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8KDC4TFcTV1Qdw2x6JDnGyK/1HMGYSMk6A05DVDwER8=;
        b=fMuLHVhKXNcUE5LzY9GNsY+YVT3MGjXsc3N59ggzciLwnHzzQiDmWaSY3AmybNFVS0
         NcgzMLPD/OHmxnCzUdoWZ9JH15zRz85l/bnR1lf8YL/vQmpguUBW9Gz7NcuEWJECDs+h
         Glp1naz9wxuU8y5KoH2z8y+puBy+w116l2ZDjTjvq8iHo9Y9VLSdj6Dj3vQhmHpeUdon
         3Nb6ZsEg8nqmiuZaYfYnQ3Z9pLgBzuvio8KDniZ3LgbsunFwB0o/mlAIwdSTt8BrepFn
         IM08zMsBUBqpGdj/LY/iuiMXS5OZ3qVRvu2p8TRNe6gU4ZFzyMQOFfK3godvJ/veDegk
         rdng==
X-Gm-Message-State: APjAAAXt+bs6otyvGkj8k5UDrkqctiGlNExzUc82DGTbn0W1oRUtIylH
        5Pqt75XnNi672uUVul4CpmpIF9oPLCRUtdcegIxC4g==
X-Google-Smtp-Source: APXvYqwoBuMtJhdfuOUM+HOKTlVvU3+lHPezK3uGPo6GGnVqXOM7R5MHWqWIevMdGYtZWmhwaC7r2yO6XEFK/yaJRVrKLA==
X-Received: by 2002:a1f:5945:: with SMTP id n66mr19511174vkb.58.1563479100123;
 Thu, 18 Jul 2019 12:45:00 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:02 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 16/29] acpi: Disable ACPI table override if the kernel is
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
2.22.0.510.g264f2c817a-goog

