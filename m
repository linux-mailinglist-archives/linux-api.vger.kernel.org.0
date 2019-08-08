Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E22856F1
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbfHHAIi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:08:38 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36760 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389784AbfHHAIi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:38 -0400
Received: by mail-qk1-f202.google.com with SMTP id t124so80979907qkh.3
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BzJTfX0sYPsZSKyjJWnAiNewKfNmb8++vKsSknaZcxY=;
        b=nJHg7sy82b57LQq6OZ5Pf4z3qb6gZmem/mTeHt5LmL/ZwHqh7qt371cdCMvAqVRODb
         bwZWz0T0ZOqhRlaeupaidr4a7bJMM+B4xYX67B5jWiaE2yNY81ExTPnuiPCyd4mCYcNq
         i8I+CcrVNTjxGO4n3pDZJ+7F93wOcwJuMuP8L2A4k1/vHi05KGWHeGV2VG2piwD+cpE/
         rggZZOn6CADIkZ33i6wNWnbZyKerxNimATuXIGYxfGICDUNduiyYt5tR+iYZCxAyOg3g
         XgXLWAfiGsatUaL9beVqeZdGiFZodkVInPxNZzO5DXKH4HZ63I1yh0B8lAyCS9zEKF1B
         h0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BzJTfX0sYPsZSKyjJWnAiNewKfNmb8++vKsSknaZcxY=;
        b=T7IYlBArUH24+e6Um2XTHX6ms9plr1zYeF8+6J6wORnqu1u4xPxfor0W8VG74wUHQK
         s9TDfH+nlGrjZbUD2IGVIvohQm7/FIQ2CgHgN0Y3PQBTvyxA9WY6SvgHzB8c3sI7APcR
         IyTEw2D2xibD3UgXv6vCmXaNmeM9XUrygeLo2izWF99mQLN0ljAlqUtNDejwKzDxlFeE
         LCtkiynmE2MK4LEVlqb+dHPP3tL/oa9goiScVYH5cV29fzJ/27wCY0EG28HmAHz0N4jc
         XuaiSMHx8mHmStwSjG8cYpMM8x1noKQl/z4FCySDMgfouDbkT72345iy2UyrtOnlfVLb
         00cA==
X-Gm-Message-State: APjAAAWiU1mOaKY8OsnIsUSuBM8Zg4nvAS3j1BIfQ5fqHUi0+NF7R/Zw
        vEHOu5SOTXaf/qs8CFdOrdNF8Bgs1AKXD/lG2s14zA==
X-Google-Smtp-Source: APXvYqyvZfkOri6UbL4qGMH2UeWvOCRGustMcDzwi5yLryEoH6XTQW9zJhcXl2bbpjl7+UMpQR03FtJUAmzCW+Wk9ekSlg==
X-Received: by 2002:ae9:ef0b:: with SMTP id d11mr10735109qkg.295.1565222917093;
 Wed, 07 Aug 2019 17:08:37 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:20 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 28/29] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..776f479e5499 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -30,6 +30,7 @@
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
2.22.0.770.g0f2c4a37fd-goog

