Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D785A6D51B
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbfGRTpE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:45:04 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53124 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403850AbfGRTpD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:45:03 -0400
Received: by mail-pg1-f202.google.com with SMTP id h3so17229363pgc.19
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/m12V7GtFFETHB33XzQ6fgVMLtCqWgKLhcMJE/WeTig=;
        b=LX5aIKwFXuP4UXL8ulshAwY566U1sskEr/Wfas2wvpeI6QYdJajJTyuhAbgM8UARfY
         09XfL9uMfDEMn9Wi/g16tPbfdpDAUqwrXNGw1cMnbrySCuOKHk1c0MQO8sosiRx8M3Td
         DXZ+PJtuNAm3T4wGi+2RClGgh9IoBWJrf5p8S0ng6uEClG1Sl6R1w1rYkIRV9XCloG5S
         hTe6/Tfh5i/ac04mQS/nl/vSRtUnT0va6CTFlrxsnDrhH4MZstKIq0qBAXehTtcSbXIH
         Ru/1FTNhAQayEnoENFc7/u2037ol51D0LhgcV6HWhz6qZQ8N3vAx6bvUFjdEoC7uk5mC
         AvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/m12V7GtFFETHB33XzQ6fgVMLtCqWgKLhcMJE/WeTig=;
        b=cuop9HjXJ6Fb6Vov1AWHrjm9aEPHvLjQXYqUmt2kp4cd1pQwXV7QTuvaNOgxC9n6BL
         Agn+tYRL1qadKfC9dR6BZM2cCdZN/m/oPojlxvf6flnCLzQFiagqzQs0zLshlL1Trpqs
         KAMDm0jWWvmpE5Qi2/6s0/SrSnKSyyFp/ubuY7U5ftPCfmuxdoYjgq2Wu9F5Zd8dlODy
         su14u/VCex1BIWjTv32UohmecGH5jGo/liKaQwcBZjgJmqgqCrX9CDcYmVd2xNMQT0rl
         bzpOm7h/ivPGj6tHHUGm60hlkOi2XBfWsZ7Y+seeTldm8KRyLp84MaTvzsmBXpZfiFl3
         jJEQ==
X-Gm-Message-State: APjAAAUBwKMm5L6zqmD8Ft3Ho+TRTzLBa/j2+pP+FQCgUZmqQ7iZb8Vv
        cMmucPEghpqG1WWOoffxeGMhdrUMY8bXRSgPuH/GBw==
X-Google-Smtp-Source: APXvYqweJz/mcSG09wtj4r4l346wIoy6Cn9FG2qUepklV3b0EHI7QNRxVKXSJh3QzyYxMK1q2HyykdXns3r+RSMJvWEmsA==
X-Received: by 2002:a65:4d4e:: with SMTP id j14mr49019897pgt.50.1563479102392;
 Thu, 18 Jul 2019 12:45:02 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:03 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 17/29] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/pcmcia/cistpl.c      | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index abd029945cc8..629359fe3513 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1575,6 +1576,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	error = security_locked_down(LOCKDOWN_PCMCIA_CIS);
+	if (error)
+		return error;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1c32522b3c5a..3773ad09b831 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -111,6 +111,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index ecb51b1a5c03..22482e1b9a77 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

