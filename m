Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4094DEA3
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfFUBVu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:21:50 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:36996 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfFUBUg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:36 -0400
Received: by mail-vk1-f201.google.com with SMTP id v135so1936795vke.4
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U3fhGq6r/NgiqaQQyES6rVTVBeVN4SZv/SOjn2ijb/0=;
        b=mwxX56tGc5bdcrdp7LPWQyAEQAkbcg1Xa55uNakzWLnArZGhBBM8/YfLo+cMRh8DtX
         vrRS8xRv6wDsAXxkkRDUDDVNLABwTIvD4/R8eu1g/4B6DSNeabRlbKD5wdkCofA6OqW5
         o7rwM1e2Ldf/n4PStpf+Oap3yTX6pey52rRx0bREIBZQlH0Ww2HvIWgFDLUON8aYKoFf
         cammmjj5lURN9Kg8tm6kUiGfHzhJos5AkiV7C8gf92EvHRMDyBjJSyrQ5ou0+kiCOfIx
         k2fZHvDVdKvEIx5adFMh/J1O/CMWdgiKHgmxhucHEyq/Iu4snxTqdhosWJ74AdacIcvV
         TaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U3fhGq6r/NgiqaQQyES6rVTVBeVN4SZv/SOjn2ijb/0=;
        b=k+/5CP3ta2z3gb5C3cqUPzFwIJQzvrNUX6oDoCHMCIrTRvUeFAyblLAve7AnkV7Xmm
         R2SQ0rcnjWDGMlAuYHyjzY5fYb4v27iZS/xl6SgJhQ6WXmiBahRYIotRgcfnKJmKrHxj
         Hm5IF8/O5ohGgcCN1waAyGx1/zryhWQ1J7s5KPMPN5f2IF4UPCtoyBFFABPnECP9PxtC
         icsSu3xeXi1aK3s2cG0Kvp+KWYi12zNfLpesQQEgkuQco7XjR7DnswbKgQAejDmZlB5k
         /DI3G8x+pGIPzDth8H5rTVhimaCcwHKXOVf3TppDS/CDaLBK4ZtUFJzAXSdRupRluELW
         8IOw==
X-Gm-Message-State: APjAAAWDV0tDV73SXO2JO0d7AmQWMEVNi8eRtcqUfXLtUBv0QK1fLJXm
        e0nO/b9hkkVPbleCzP7L0LEp3OJVbWPHCJ1CccemLA==
X-Google-Smtp-Source: APXvYqzWE4EamSp5rpUPDi/0xpqKPoKydoH9Fwzwh6qKoNDL8d4i9gk8ozCNMFrubgA0TD2wFtuqZJkJZxR32Trr6G5AHw==
X-Received: by 2002:ab0:2994:: with SMTP id u20mr5795117uap.114.1561080035406;
 Thu, 20 Jun 2019 18:20:35 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:30 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 19/30] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
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
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 7 +++++++
 include/linux/security.h         | 1 +
 security/lockdown/lockdown.c     | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 351843f847c0..2dbef7dc23f6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/security.h>
 
 #include <linux/irq.h>
 #include <linux/uaccess.h>
@@ -852,6 +853,12 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if ((change_port || change_irq) &&
+	    security_is_locked_down(LOCKDOWN_TIOCSSERIAL)) {
+		retval = -EPERM;
+		goto exit;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
diff --git a/include/linux/security.h b/include/linux/security.h
index 87c433f1e7db..cb5d74f9b9ff 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -91,6 +91,7 @@ enum lockdown_reason {
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
+	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index ced4ddbb36b4..c6456f300220 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

