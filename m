Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE417D0EA
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfGaWTB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:19:01 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37612 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731331AbfGaWRM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:12 -0400
Received: by mail-pl1-f202.google.com with SMTP id n4so37818504plp.4
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AYLtZ41z1RHlFpOZnl+JGLaHaK4EJ2Av6xB01tUKIjQ=;
        b=vvpeXRKyc5OhHv4Gr/tukOYbwIwjOYYXtqIP/Io9iIGtPO3Kve6jw/W7bz2rF/pLv1
         RlW5o4cGWbTXLPdROo8nSoKA3X7rpN7sDIwV1d/Fkm3vpj5fFKlODN732XeUwRiYz3Ke
         TW9ChBbAGCWNTBdcbOZ73xw4f5kes2Emo/1AT/+3MfhQ8BoEcrnKZHlAFFwFtqt85uMv
         Hrp+989qk4cKlnGSLSV1ao/ObzrMwaeocP0iHhwU4p9uXakErgQiaqLm3O0VzWsyNNyY
         9CqLjrTvWM8AjYlNkYT/fe066FOTrmczakFGWc6cjFSFGLsLIYYWVoFByBrYFECbZTDO
         MNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AYLtZ41z1RHlFpOZnl+JGLaHaK4EJ2Av6xB01tUKIjQ=;
        b=GWbAgl44ch4seYS2uPeFAoi4JfSALtkh+bh1MX+5KRMAArMA3zwU6wD3EIepLnKHWK
         eUYtg2RuKJltoUNI3LqQN/gi18ED+qGgjcEYMRQ8SizXl2HIkv5fhKD496HW6biJZyNc
         p78Z5xxCHqc0haChFrIANitIhDWX3p9H0x8GH8pTKALtdlK4UAQHo120IJ6591eG9Z0F
         ktPBx3U+vezkAq652lDSfGjC48KBbvkCxNGbH0brqJe1NesuucJWxXAOFI1SAwRgNi06
         rv+CquKg40hw8JDVtBAyxOgxjvi8vLCuZdKwZ/1KEfnmJ5Eb/sEuWyU/TaPsrkM5aLR+
         jUqw==
X-Gm-Message-State: APjAAAXO7Ih8os92H9OdmY8lvyUU0Cfc/djvRVleL0XcT7rOJ/s3SA+X
        SEzfEJufu73LUVhQY1Kdfm/rI0b/Mofdh7kWmri3bA==
X-Google-Smtp-Source: APXvYqzkiW7uEdQQUtaZ0YHcWPNEQQcr9wR/H4mTJIlJ8xEUbv8Q5RP5zNIsLLGkfkAO0eul945srgorH4QzlUVn11pgkg==
X-Received: by 2002:a63:5402:: with SMTP id i2mr88751122pgb.414.1564611431661;
 Wed, 31 Jul 2019 15:17:11 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:06 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 18/29] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Lock down TIOCSSERIAL as that can be used to change the ioport and irq
settings on a serial port.  This only appears to be an issue for the serial
drivers that use the core serial code.  All other drivers seem to either
ignore attempts to change port/irq or give an error.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 5 +++++
 include/linux/security.h         | 1 +
 security/lockdown/lockdown.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4223cb496764..6e713be1d4e9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/security.h>
 
 #include <linux/irq.h>
 #include <linux/uaccess.h>
@@ -862,6 +863,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		goto check_and_exit;
 	}
 
+	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
+	if (retval && (change_irq || change_port))
+		goto exit;
+
 	/*
 	 * Ask the low level driver to verify the settings.
 	 */
diff --git a/include/linux/security.h b/include/linux/security.h
index 3773ad09b831..8f7048395114 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -112,6 +112,7 @@ enum lockdown_reason {
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
+	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 22482e1b9a77..00a3a6438dd2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

