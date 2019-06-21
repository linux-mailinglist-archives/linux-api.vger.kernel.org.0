Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB794DE98
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfFUBVP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:21:15 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:37327 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfFUBVE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:21:04 -0400
Received: by mail-yw1-f73.google.com with SMTP id f11so4929655ywc.4
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=knoEDxerDamiS2udwBAyDKB2ttd1lX+80CF4AC/SyM0=;
        b=ICMNVRkNz9HnJz3EvoIc4iF32ARr2jxl8GgTxe7lk2BN+XJU+KaLeMD/xZw/RUgzBj
         2IL4z04wtDp23HqSdMnyrxoaA16Rk6s7u8X92iR3qnSMgGiAALWsSPXk8Rbm5iZf1HFJ
         AKcA2cV/jHmxmTRZu1LPNcYoeYkmR1BjKdhDUXgEAN2OyQgMW1krbjk+tbEoV/1+MYP5
         /Uq42xpHhwGYRr2fefqC2TK7cE5w8u6XMt4GStffGhwP6FZ2bof1USBItw3kW7Kd7giP
         GHViyL8q45sG3E0i5Do1T6WQHdYVQaRRGdkUud8BrJPUj45c8qJIwU9nXrpeons+BrZ/
         k/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=knoEDxerDamiS2udwBAyDKB2ttd1lX+80CF4AC/SyM0=;
        b=lC3Mc/DEuWE1Ns59JGK/kuAovjUV4KWf5XXKcfu63FNN7hjdGWhoyD8uIu/3YEb00b
         Hb7WuyVcWdre+uQw+Qiv4xed7OZS7K16qaF6rpiy5nz9hZlpkiuyzhmj0uk+heCQ+5zt
         UShmNYEbLK8Z3OYVdqySpMkZxPp8ZivurBJSpevX8UyXa64q0315w0yN+15bxLSLjZi1
         NRVxdVp+pXUO4+/L/n7xUG/GWmXrOWnJOst0gOW4wH0nhsxTwdXHXV+o9kGMoXZp/77+
         vNHW204BZukpcZ1PVDn6Ycrp87JX2XXXtc5eVfrxcbOn9ZA8BMulgOL1FMoSDLOSv9pr
         oP8g==
X-Gm-Message-State: APjAAAXaIviuOSQ5S1DsoBYKBP0BmBAfFwBhhEjOEoW6b1koulomqmnn
        JCAnNFx2CWCsCggB6Z+hhJwigVNqJA8w6erHYgMEuQ==
X-Google-Smtp-Source: APXvYqzXtKc4q/eOrcelOahjOBOrBEBeNLXGOpYukdIfoX1WsAoG+47EYNVhHraiGgoP/Z3FQm4pLmztSWSJawWS+XNZAw==
X-Received: by 2002:a81:590a:: with SMTP id n10mr7812986ywb.187.1561080063114;
 Thu, 20 Jun 2019 18:21:03 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:41 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-31-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 30/30] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
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
 drivers/firmware/efi/efi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..a9ea649e0512 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -242,6 +243,9 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	if (security_is_locked_down(LOCKDOWN_ACPI_TABLES))
+		return -EPERM;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.22.0.410.gd8fdbe21b5-goog

