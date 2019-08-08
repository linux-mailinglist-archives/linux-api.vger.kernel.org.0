Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC685705
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbfHHAJI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:09:08 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:57072 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389705AbfHHAIR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:17 -0400
Received: by mail-vk1-f202.google.com with SMTP id a4so39672336vki.23
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0wvr7l0OfQCpncv5jcw0tGNb43fa+c615YU3AwXBobQ=;
        b=BDkDRuySmH99+uoxWfrhpwfmKNKn2qJaU9U/nzEU3gQ85Ycz5x21SymY69Kx+7BgVn
         TZPOXubIcxk1FUPhB6QPNSl3h3POtgH+QVLlxpPrMnvAgPD+plxy9dozCgZIlKD0ESsz
         iVLNLuxn0fk0sWBXSMA72U0mJt7FbH0qWwkKkcF87ZfT348ivWRfkl/gDkGlhug9gwlZ
         GeZmmEpvW3AYDgqzlpv5CvDBjmAv1VmBDOChd3NOcXBd+mKUdcddnrKvAKhtkENqp5T1
         M4+uNNJlDgYygp6TjDT3uFuRNHqNmm0ky2+YxmrB0VARBMGlEhTuKkGXpnJE2AgWP9HT
         l8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0wvr7l0OfQCpncv5jcw0tGNb43fa+c615YU3AwXBobQ=;
        b=VSCqCZtmPhlJwn/xjYfdixoOVSD8gsGFtEgfYtvmyNYE3hAP8dFOS+E4Jga1mWUoIZ
         p59Cm/7nWr+qxIXeHb0OCRGZw+FOiDS7jNZ95a6qhWpuV/6vIBUxkAwBr5prQagwcYFr
         7aos2nOGQsoWm42BQAJKYj7U7B9a5JThaVbeNCCwK2krZ3+C6lGTor4xw9Jvx4IVXjfj
         LWEzJTdRsry2oJ5yaV6/lbkEpgEaLBkk47dylW+xLv13reLSC9N2frKA8VYxPakPCSq1
         F3bRKEBIX1WiDJWu8PeFZfzY3S6xT9qVhUVqWIYX0wTqta7g64Zh29Z4DTiuSsJfnlzD
         ZuUw==
X-Gm-Message-State: APjAAAWwxyUPhYHIlZle1BPfGgm9LeMvw4TIesP6T0Cm11H+sv7+XDmT
        BbP+dUjqbKoXdqVfkMcTSLJvPUOJ1G/jA/N3ZnfgsA==
X-Google-Smtp-Source: APXvYqxcfpqqsavzaQSk6TZq5rSUgP4b30JIhvbXsxs7veg7Eg3YU6weBFgQ8LHBcnt8hZcdSe5A5T0ZlXIZX06xlzylkg==
X-Received: by 2002:ab0:6e2:: with SMTP id g89mr7736803uag.56.1565222896120;
 Wed, 07 Aug 2019 17:08:16 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:12 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 20/29] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
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
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index 0881e1ff1e58..a8bd952e136d 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mmiotrace.h>
+#include <linux/security.h>
 
 static unsigned long mmio_address;
 module_param_hw(mmio_address, ulong, iomem, 0);
@@ -115,6 +116,10 @@ static void do_test_bulk_ioremapping(void)
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
index 43fa3486522b..3f7b6a4cd65a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -114,6 +114,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
+	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5177938cfa0d..37b7d7e50474 100644
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
2.22.0.770.g0f2c4a37fd-goog

