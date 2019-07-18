Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00946D54C
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404074AbfGRTqO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:46:14 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41719 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403924AbfGRTpF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:45:05 -0400
Received: by mail-pf1-f202.google.com with SMTP id q14so17227921pff.8
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1oQBZ5kAfw78ruR17gEno1cNC4m9jAFrzrAqQjxP+4s=;
        b=bOCM6GL0Ngw8/0ygiEX9zoY9+UeVpwZrC+HYXZNlVCmCNmQeIDTdOr9n5sq3gWDm+B
         si73WGz9FBMe21fi7q1cgUPVc6UKrNU5czhY45drBnT9fcda2oXVubTUpoYn7CB+THFG
         NfxtWL3+bwAI+nFPpXR/XYuXylxs0bB6wzi1p59YteoWl4BMGvMhrbg4YA6PkAj+hyO6
         JfNKoy8V2yjnRaFgKyjufj7DwMls0NaxqdhxPSGfjq1NGKNn9+15BYW4/frcFLB98ZE/
         XmzoxkPX8bn/kJ30VxkaYuMDwmXXo+IAwglnrNTNcTBgbwGY81zwuHuZBABAhx6R/r1L
         +KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1oQBZ5kAfw78ruR17gEno1cNC4m9jAFrzrAqQjxP+4s=;
        b=N7QA0JHIuSm7kPzHSrKJMeGhjBXNQEhpbQ08+N6V/0EyWEHlB/YkzQ1xMDo798L59t
         I7dSOR134J29UNXAx+zlwAOlGY0esZcSV12/aowg0jC1jtpoiJiGsbrTPce/fbA0xVHt
         RJv1YCMVc3CgqiFQMIaC2tQlCff1MxFRfIPe1Hb/0GI/WDOUv3rlWAbtkw3MZo2miwnQ
         9laXcLZjloBQnGARqGA8dW6Cx8CTo45T/Qf9d1qPgOhx1n5TNI2cRrmoTbtKAeHiTl+I
         D6CDeg4jLKfHJCZXKPLyRW7qsucPfKqPQHU+pGwcxCRov+tMSYxv5MWZ/uZFa1Ln4cXp
         tI0Q==
X-Gm-Message-State: APjAAAUxYWMETMM9qy2ioBuGY6JJC0SlcXAlO4+6lhZr0z3ShI6jV6T0
        V+olaV6kruxf8s4a50/toCwPP1zxc5ImunIoQt7Cxg==
X-Google-Smtp-Source: APXvYqxlQfzj0hot9XOlEEvXsk76ZdqvBcPQcFU/XkEmSUECO78P340Mt+UCgz76BE5DH0Pmt8Ux45GcQe6wETMsLvQxOQ==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr48832875pgc.139.1563479105018;
 Thu, 18 Jul 2019 12:45:05 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:04 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 18/29] Lock down TIOCSSERIAL
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
2.22.0.510.g264f2c817a-goog

