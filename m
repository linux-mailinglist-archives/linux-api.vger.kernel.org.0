Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20AD69BD8
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfGOUAH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:00:07 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34366 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbfGOUAH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:07 -0400
Received: by mail-pl1-f201.google.com with SMTP id 71so8832709pld.1
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oRvWsZp4PPUfRyX2ON14DSSZgIGsbQD9v/C1S79uaF4=;
        b=u19ff6FTpFVbyQDEinDr9SJQnvqnV5os6TEuvxanMydy1b2YqvhyBFNo/tU/vKfZ4w
         TfzbNDIZivzuO7va8fNKDvqvQB9395QkHj9O1Tg1GWCdkHhfMs4ETA6aN28O7wFTNGyc
         q8o/BKGnaIjrhv3DQ4cA8soI5fYow8qx7tOLEYly4hwxfKxMiRw5fDyeq8qTuGbfW8Po
         d/YWDf52a2vnTtVWqh3JAHTFS1XAvYw4xC89kbaPNWEL4DV2eoGx+6y6tAyI9eHMZeyO
         mhDVi/LgvCcTw8vRnWbAvhpxmTzH3MiP8dt16CDV+pPSdJJvm4H2oVZrMSV37g3QPu/r
         Wiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oRvWsZp4PPUfRyX2ON14DSSZgIGsbQD9v/C1S79uaF4=;
        b=mI7oVItmKX466dUpIzZBd/JGVJuQ46pyrswvO1FLyUYHUmpt5lYc/nG9DvhUUNX13r
         3SYCTJ8o15Lfj99TTGb3RZvi7+MG06iEBohR6/fw7gZTadjuiZhvWBljRUfr5l1MUq2H
         lksFWLiVWPI3lbZY8PEmC5vY1C8M1vuw55Oi0wkLn8zzhqZbYHgcO1X7yp29Pk0oNEU5
         fpE1BpR6WLoYh/ww6JhQzCJJvsLE8h6UbjTs5Kgc2vtedtXaRqXK/lgrR5Oxl7woQroC
         Y6w9g/9vpXfk94ZXlnZYb0ymO3za+1KIrSzMjFMOv8hP4Hnu2zxe+Tu6lToVPwhvGmMU
         enxg==
X-Gm-Message-State: APjAAAX6DsDZhNWk2f9yu8ruzDxzin5ik7+28VvNO5V1O/7zNTO7RBm9
        J4LC9So2GBpq4Bhod53YhCKrPm8Yd7CXNOyZOq8zpw==
X-Google-Smtp-Source: APXvYqzKgOw7wVyeoqQwjH8KUrijPHlX0N3PyzYOsHxoYKdGfqeiWlHAIXeUilSk+oMaVxq3UXNAH8JgdkOClRUAdbwVkA==
X-Received: by 2002:a63:3ec7:: with SMTP id l190mr29802503pga.334.1563220806224;
 Mon, 15 Jul 2019 13:00:06 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:22 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 05/29] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org
---
 drivers/char/mem.c           | 7 +++++--
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..d0148aee1aab 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -29,8 +29,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/uio.h>
-
 #include <linux/uaccess.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -786,7 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
-	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	return security_locked_down(LOCKDOWN_DEV_MEM);
 }
 
 #define zero_lseek	null_lseek
diff --git a/include/linux/security.h b/include/linux/security.h
index 8e70063074a1..9458152601b5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -104,6 +104,7 @@ enum lsm_event {
 enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
+	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2c53fd9f5c9b..d2ef29d9f0b2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -19,6 +19,7 @@ static enum lockdown_reason kernel_locked_down;
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
+	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

