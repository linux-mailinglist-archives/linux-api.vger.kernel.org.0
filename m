Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC104F23E
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFVAEo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:44 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:47396 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfFVAEn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:43 -0400
Received: by mail-vs1-f74.google.com with SMTP id d139so2862499vsc.14
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n33H2caFWJMziV8Vl9fEyuQPirYfKy2HcqzebAjjbEk=;
        b=QWSAua9g9RwKP0uU2R678HQj1nTTQlk+ccuY/QK3BB9zuEyoAp2MVYhulrYkxknxtp
         8CcguRHGvVDf5J0QYKG9GN2mG6EWCobGgzOL2HDjpsFhBVlDO71Hs+o0pLtXh/p3Ed4V
         N5nM6O7m5g2LG2oUQZP1CsRN/M4x/GGJNW1x6vRcXwslO1ZZEosxSyRhL7850ntFt/Qr
         0nB8h31WahXFNIUcWpZ86cgp6VcJyrAzNoEdvFqSnlqNyhwwQTw4mGjPAMnnSJ4bBY5N
         uVnBjMN4HatYvmQyuAT2EkWPBDPyZag+Wolf4TT6MIZc1eWQtxhPUA57hp8Msm/MWMnW
         KRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n33H2caFWJMziV8Vl9fEyuQPirYfKy2HcqzebAjjbEk=;
        b=rD+jN8QoAZ1Dn13yQmRfwqfB7/b1QMzlf5oS1filbVy461QSK8f45fUsZADioDYTm1
         rHid2A2N6waz52rxboIV0DspJ3nqCoaatdmKWJlC0cJuMwDbPwF+ThW/yaL1EJrEl3vL
         EWbXRuQ4/mws9eSx1tisQtb8ZuOnMj2dqIRdQYwakmV+U/+8v58hv8qlB9ciVRvrelvY
         r+rpnd+yMcMbCqpIH2WvACduJy9Q3trpq7rux8IyIeYocDXQscp+f3nd5D2Y0mlb8UUZ
         BhOcoHyLLUP3JaiI0gN0WILRYfAKTm9mvQwVndhHBHgBU09lhr+hPMtPXphKg3Rq4/GW
         mWKA==
X-Gm-Message-State: APjAAAVOogzCPCeiBgeAZdgoP0Csth7fCEekjlMKHuKXQFMcGlqqiWFS
        H+v2uH3XaeGMnbY+Ajasm8JtA+54CJOQiUD3Gmz+YA==
X-Google-Smtp-Source: APXvYqz+aR99joPErIIEbc2OhbHDT9lUw4o9PwDXDXdQ9wGtV1PBN1Bun/Dpx72Xl1cgY14BcfWe++NbFFwjQPw4r6febw==
X-Received: by 2002:a67:7fd8:: with SMTP id a207mr52544296vsd.85.1561161882682;
 Fri, 21 Jun 2019 17:04:42 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:45 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 16/29] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <linn@hpe.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/tables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 8fccbe49612a..41d9ccd0e075 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -34,6 +34,7 @@
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -539,6 +540,11 @@ void __init acpi_table_upgrade(void)
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
2.22.0.410.gd8fdbe21b5-goog

