Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300354F251
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfFVAFO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:05:14 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:44684 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfFVAFN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:05:13 -0400
Received: by mail-pl1-f202.google.com with SMTP id n1so4465253plk.11
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RH4r7kndiMZuzkloO60/eV46GQCIwbbHWtivaOQNx8E=;
        b=AlJqBCOH77JCstgkPmGAZLgRUSD9zvatMOj3hlS41EdO8GggJp6HBONVpx/jhauvgq
         8AJYbxCo4G0bCR/ZL4FQ8B8+IWJY2WfIJ1YRwYg5JXFKA/gXZcRwW59UyJpziaVKPJMD
         w/V/JtAWur3tBIDTeoEHR7ZUYTOlGArmeV75OKSfGB53kteVVkiD50m114i64uhrcDHW
         kKiF2N+0rp0kEs0/V6xldaibUNauG2QYFkENtyXQ2vJG3z/F6Xg3uIhwM6tlnXlcDucd
         /iycXpCPysDjGuvfZjg6xm7UFHlgNwKHAPLDV5kfEXLPXmjXQ7Mys9GnXKhb3JR5lTB6
         04eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RH4r7kndiMZuzkloO60/eV46GQCIwbbHWtivaOQNx8E=;
        b=Rfoo2LEqCLVeiPM34l+UcsLRDkbIkIy779KbNEFb2KJ9rwJe4B9AxZAUs6b40RpQgw
         Dr3FBXLXwpCHiLWH+2sgvUkwiANKd2PtyQ0nGZG8Ql5A3cFBs38+JD4CZnveAjkel9OQ
         Am75D5ylSakHxb3zwv2fdl/Ic8GA8SP5H+se3GJgO8J58A/0Je62NpZKyS46kT8Y0Z56
         zw7Kr5NGC/7hcKxVTor1ZR41kBKUmRTQuMHUvAPL6zLbW6Skr332VQDcxcAKckl2Be2Y
         qEOrUWSTt/o2Ln7NlfhU+k2zto75PtIMlb/bhuWiY8qHbjzvx02ZH34i0gMad7fv8mZK
         lleQ==
X-Gm-Message-State: APjAAAW/JscAdzVRnGVFxjDosZaHBieglpl5vUptZuV7ANep0CaCGPXc
        HAx66+TlWlaN8AGgHhVlHZFeEcmVU4fxI7/VOWwLtg==
X-Google-Smtp-Source: APXvYqyVHJVn9d0VYeGJ4jqknCWJTY1KI/Z/06tozEDcOyTsuENI6t9yu2qMQUxyG2gPRdwFuoh5T585JPCvavnyfPVFAQ==
X-Received: by 2002:a63:1d5:: with SMTP id 204mr21711270pgb.207.1561161912148;
 Fri, 21 Jun 2019 17:05:12 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:57 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 28/29] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..9f92a013ab27 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -242,6 +243,11 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+
+	if (ret)
+		return ret;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.22.0.410.gd8fdbe21b5-goog

