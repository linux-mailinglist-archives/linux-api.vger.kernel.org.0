Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0804DEA5
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFUBVw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:21:52 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33547 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfFUBUb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:31 -0400
Received: by mail-pg1-f202.google.com with SMTP id k19so2626539pgl.0
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MFrhOOVeW4IxvuHo8Dzy6dq7eeQGF3tpEcYBlR0WBso=;
        b=TcZabgisBkyxXJLrHlJokm7pF3TBlp704rcyxWqQr7UBjl5F7Ssjc96k7OlHa57HX4
         3xR1+ubHcpOaZiH1aTCE78J/YCxbY6z4BwqD44zr9aEv32L/y7usgub1W7sKV2xDI3ui
         tF6cAzVnYWH7eBYL/UDuUTdSJHS9OCxCP6uQ+DH/jPiEGGXMqGomAGLzMHwBmJGKO/Xi
         AZybp8B/Ge2tdSkOVjvjBa4Zoteog0hysbk6bv3DsMj+DyQe2nRuLsoe34IQ3l3jBxvY
         vTJuWKTdI92NMOeDD33HDAxRxSAyxBwigO9hlP8a6pjmvcu3N8UTxybhZunMy4TXM8Pb
         mrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MFrhOOVeW4IxvuHo8Dzy6dq7eeQGF3tpEcYBlR0WBso=;
        b=XbUSirwNV+uApgi2t9wNCcclIJfcfb5Uz2cL5IgJpsdfU8sRI+B31chl2yeobwgYva
         z8kXa4e7ceQ4xJjMSchbTwHVGH56qcSt1WAMZesEvR0Dmsy/WDIKVmWMCubV400lVUt/
         DMpwtRIavIItILgFNh/oRT/rq0NX/SlE0eySsgs96cleDgYXeZRYsL+Mr9/ediggBRl/
         gPtWEeukVJyCeeidDDV4dRBiC93j/FPitB9Ig8MaReiAbKIux+Lk51/YvwmjbnelaCYb
         GIVuYPxztYaLLyhO7B/vercIhbWT/bgk8/3wIQubTiD+Zj8wKzl4mXTeJxVZxba0rjb+
         MPEQ==
X-Gm-Message-State: APjAAAUb9fOw1xWkPTBT2a2RppVObrsyGZnrpXM8yNCLPlZDDBLroqnm
        uvrYDJPyiNYTvvIeIWW/EDG8NhjnDiz9K2AmfHeung==
X-Google-Smtp-Source: APXvYqxHE/gBOkhAiSbfrmS0K/Wbmqx3GctJ6ZvOlTkR58pahzRkAQYiz5QtoA6YyUzTLy4ssZQCfYbpp0KUfKwAi76AKQ==
X-Received: by 2002:a65:448b:: with SMTP id l11mr15174758pgq.74.1561080030187;
 Thu, 20 Jun 2019 18:20:30 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:28 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 17/30] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Linn Crosetto <linn@hpe.com>,
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
index 8fccbe49612a..f8e7d70f07ee 100644
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
 
+	if (security_is_locked_down(LOCKDOWN_ACPI_TABLES)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.22.0.410.gd8fdbe21b5-goog

