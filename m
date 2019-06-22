Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BA84F23A
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFVAEl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:41 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43029 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfFVAEl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:41 -0400
Received: by mail-qk1-f202.google.com with SMTP id v4so9381510qkj.10
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kMkOq/TdZP2DxC+0jYMlNvaXt/K0jRyWoQ2RXLMuYi0=;
        b=QRjJLKdNtZo8CP4nTH7hluG2qV1AXyHaeNhLgJ9dx1fDUKb4PKvKgsxZC9qD/JpyOc
         nDlpqLlNjPK2Fr6/XPB9DFGktNMicEjN1U3rsUDXfXc0qt6uDJ4LiVqBRuB0IEYVTdqC
         g9pw8gFOb/hrRGu3KsVlrmVHnvI6Fg2+fFpvLxGvsYk9kHFo5degfWEqDha7Y8eH/AMU
         owop8HB8frx+BdG4M4kFYi15V93p/L6y8OBHHLti5WrGcp5xyaJuzKxcJQQIy7uVl5RI
         bM63+qZ8cl4gZwKMeJroO8r+Eqm/Y9IaQqorCVln/XP6Sft3X+wUDeJFpOaUTuF1wRyz
         uPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kMkOq/TdZP2DxC+0jYMlNvaXt/K0jRyWoQ2RXLMuYi0=;
        b=gbiO+BZkkL1KaCjKR+ggqotPgNF5kuguV4yX2Ud1+oldLpx35orBu2oJpbmyJdUyi6
         WZRFz62pupAi7c7IBx4uF0f1I+8ZeHIVNk7ciwdHXSZJ6ziJdciZ85Z8bTSIwDRyK4Y0
         8tMkGD1IkUnhaXtk3QfOotYmdhFMKGqfuG78lU08wzSAG5wT/O8xI4F86m90MNk+DDn8
         2koFek13DfB9EE8sAMU0bfSlSJf6l3tCuYuYEPT8UVnrB9xr2f9w3rVZ93zxvMRcTYcT
         j2HXAYGwkUxany902L1O4OBNw5YBxD1c0xgTMfnCsGLIpXOBTFIWPLAVqRqWxnhgRkVm
         dNyw==
X-Gm-Message-State: APjAAAXeuQ4dS1BFQ2VZ4DOLVQCWd2VA5dD7NlYvegvd7QEXn5HlVSx6
        wFv/KnC594pvnBBOzMmLhTvFZV4Bnzb7gTWH552ECA==
X-Google-Smtp-Source: APXvYqyfTelCSA7v0vPY8aBBSkh56jUJFjBxZnlm2jUkbBn4LGuF/pZ/ysDWTqqbVvj8Ybj3gU9B9i2a5Gg4/j2L/hPeGw==
X-Received: by 2002:a37:a9c9:: with SMTP id s192mr111878928qke.335.1561161880192;
 Fri, 21 Jun 2019 17:04:40 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:44 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 15/29] acpi: Ignore acpi_rsdp kernel param when the kernel
 has been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..60cda8a0f36b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -40,6 +40,7 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
+#include <linux/security.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -194,7 +195,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !security_locked_down(LOCKDOWN_ACPI_TABLES))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.22.0.410.gd8fdbe21b5-goog

