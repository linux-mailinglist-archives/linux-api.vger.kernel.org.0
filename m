Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38594F270
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfFVAEy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:54 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55339 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfFVAEw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:52 -0400
Received: by mail-pg1-f201.google.com with SMTP id b10so4968131pgb.22
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PrHz11Fkohxiw/KAEo+rgP52AAtQBps1BcwB0CKo3qA=;
        b=JFwCQU3VW6N8fQbj5QygplLOospCB4WZ2mimGCOP6n+WOhSurcQpgYKoX9iw+cZ2K6
         lfr0JV9a5FEYabcfgKFD2n6Oe6+2jlR6WwmG5IJWl6TSHGZbMzYhWldPaBoWulWPSt2Q
         n6nwq8yowPRfRHqRBFYCGiKeHVxfu8hk5JpXAy9ZSyUlF8mKnwxIGeYB/JaeT0mfCdVH
         jsnv53RcgGR+gNUsAtx76M4TpYdiprXQiVmjKDZ3WUiyWxBtk+IPYE4Tqu3u+i1Sl/Bv
         2XAbs7AoszictGZ1JEiOzfUFw9KrUEgZ3ZX1sk/r5opiNHJKIXKeADFd8BG+XePh9aML
         4/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PrHz11Fkohxiw/KAEo+rgP52AAtQBps1BcwB0CKo3qA=;
        b=mqIbpjjzlRLvp4wguKZNz0OOSB2z4r8KL4zY0IN+QpTVWR71KI2yNSKTIbTygmxK59
         rL/sTsbCO+65pmOeN4Q8Ph7gxF3mlqbHc5sYfoRoRUTiaBlVHPiP6XiquOdNzBiMTi+z
         z+afKBBod8ZRvF0SwKFN8hltWHcxDzpcd1k1INx5oKFy+ceVNZq8xrJp0Yw0qEuxrOZB
         MaYKhxh0h2hpA9x81t/sRtTtMHH+IqECXUH1mLycjyzek/2fEmb7rhYYPKyXWj4LVMWd
         vu1y6NwwzK6QOERPMYc32FiooglYwDYnZupZygPGeU00d161JycIYVriV8HqXTCP1Z2f
         /9tA==
X-Gm-Message-State: APjAAAWYJu4zXggknQdhYBCbtq6TeEj7zPJIpOhKJxtjlMkwFO9lMZz/
        wchYx6gQ7RJLTM9QZICDtw5R6TMd/qKQOlWy0qFJAw==
X-Google-Smtp-Source: APXvYqxHPrRmaCO3xqjug+sv8qg9vhcJoBN5OdWTZlBjLu//lwEN4PjtXf5eSjG7q2BsNifXC/ydRjwvulqX9FFBZNjGHQ==
X-Received: by 2002:a63:6146:: with SMTP id v67mr15959623pgb.116.1561161892042;
 Fri, 21 Jun 2019 17:04:52 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:49 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 20/29] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space. This is
a runtime check rather than buildtime in order to allow configurations
where the same kernel may be run in both locked down or permissive modes
depending on local policy.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
---
 arch/x86/mm/testmmiotrace.c  | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index f6ae6830b341..6b9486baa2e9 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mmiotrace.h>
+#include <linux/security.h>
 
 static unsigned long mmio_address;
 module_param_hw(mmio_address, ulong, iomem, 0);
@@ -114,6 +115,10 @@ static void do_test_bulk_ioremapping(void)
 static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
+	int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
+
+	if (ret)
+		return ret;
 
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
diff --git a/include/linux/security.h b/include/linux/security.h
index 88064d7f6827..c649cb91e762 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -93,6 +93,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
+	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d03c4c296af7..cd86ed9f4d4b 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -29,6 +29,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
+	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

