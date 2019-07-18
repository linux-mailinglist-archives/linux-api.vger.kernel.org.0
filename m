Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E351A6D522
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403988AbfGRTpL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:45:11 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56973 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403984AbfGRTpL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:45:11 -0400
Received: by mail-pg1-f202.google.com with SMTP id h5so17242957pgq.23
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JVVIIgLtDOBKlqbr3dAhxhQOQv6A3XP76vT4880U/G8=;
        b=SeXjRzGuTikZ6KQwoTivnohUXmbA9jZtlGvnhbW5Gf6eGO+4VFd29B9NCWSdujqhu/
         8fh2j1Om1PhG29VKxAvPHvHEnsKA9M4CYYYG/Lu9Hp+oZek3BD7S8Mig7S68+6KmwG1c
         /xo6cEaF8hx9fJlpJ/R/SstDqmbSIAXSy9NQlEtsI+j+VydsrXaPd4V0Beh16tfWRfGg
         F7FfxfLwPdOpWRZpLyOlY+tC4JNNX68ecbgofIWwHOVea/cuOB6mklZYjtyQQINP37o7
         1nsCU4lqB4gv/44OPNg1qrVANEr2JgFG1OziWfA8hG4f0UGUfVWeP4bgBBn0aAiyTeRO
         foKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JVVIIgLtDOBKlqbr3dAhxhQOQv6A3XP76vT4880U/G8=;
        b=ItIlSBMk+cpmZJLlAVt0+vwzjkwEvJ7dfeooLsOGByk0kxrk1M2YR5MzgNTER5EpA1
         dimu5jmEpI78DjIZEI2GAfHvtczbiVFi1WBa+cIAPHBQS62ef8t2wbo0/0vE6J0OcFre
         VLBwav8Ffe1gw2gqZ3CBprbUotAuWFwEO38/lgqaP4EsHGWicFza6pxinh6XPUR7p7xD
         0YWGy/64TVHwcD3ijQn46vWz8hO6Y62PV7AEIS+nvOodbBCN2BOZfJTJk4CYPQ5nv6rQ
         3pKAj04MT1QzZF8MwUgc3CuHKF81S5YpuoFbBeN19ESKDYZKzKXbxpS/YvAUvGtByx5q
         iopw==
X-Gm-Message-State: APjAAAXCGVK3WI2D+RHN8kyAuDxznVTcLHICvSIOjg2so8UuizuIBEZM
        zLvmOGeMYi7fx4WNK3Cxat1b+kcj0U4dCdoyzjfFkg==
X-Google-Smtp-Source: APXvYqyrMfaHa+wsv0nlaqRsdZ00CNxJSF2ky+cOy/8f3LYHWhlJwVQ8Qy4eVKCExKgmZMrlPSjOjbjg7/Xdu0/lTFJ7Wg==
X-Received: by 2002:a63:20a:: with SMTP id 10mr49075232pgc.226.1563479110182;
 Thu, 18 Jul 2019 12:45:10 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:06 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 20/29] x86/mmiotrace: Lock down the testmmiotrace module
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
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.22.0.510.g264f2c817a-goog

