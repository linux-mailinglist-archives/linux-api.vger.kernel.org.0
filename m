Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABF7D0A5
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfGaWRS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:17:18 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48163 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfGaWRS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:18 -0400
Received: by mail-qt1-f201.google.com with SMTP id x7so62850281qtp.15
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0wvr7l0OfQCpncv5jcw0tGNb43fa+c615YU3AwXBobQ=;
        b=JtMG+7GfDdoaoq8E+Gpj5xUJvOyHAHIBQYN/5LMZv06DTj6ZvlEm2cJUCONAwzGUbP
         GK36LK9w+ftPnukYabwQIKWRmVwDi4Pl1KEKPEDvl7Fo3u/OJlTVhn3iV1fWGbjoy7QN
         s/HadNGszchMetFyBlbfiOchIuq8Tjvbgfm9Za5ZK20lXUFd79+hX5IE0h7NK+KIe4Xk
         jS4zcSBFQ3AEbVpTjuh/miN5rqBsVs1zzhXIKrsVVIkKzgVZZc6DQOgKMnowxWxNcRV4
         gvGcQMZ9j9NkVGd9ArI82+xY/6cbbO0HFaHWXRZ+aEgjjS7Ix3QR6oGrnLeWOcVNfSTA
         uruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0wvr7l0OfQCpncv5jcw0tGNb43fa+c615YU3AwXBobQ=;
        b=ZzKnQfl15bCv+4XYNadcZqXqrkGPt8tNWbX8+lqCHT8TyU5svVo3a/9fdPrjeMQ40J
         WfPMQr/FaHKZtb1U0toiZlT1pvg12fH0JMBOtUQlivxMqHKCKTS5VyH29EnGvVtHA4g8
         oUR00OSUesu8N6Xv09gjobYV62XMIYgWO/DcACpc9eSj42mtbxIvR+juBoPIzoYpkY8v
         52UANj2LgKscf80HIgRynKZ7oWduIADiK8Pv1aSdjjQHrzDx/74U8BCdNg/8GG+lBBeE
         JZvdJBvAMg69fqBECXuzCuoQPuyCcPe0EpXvIcuCmujS0RNRDTo/nf9tK4Zj7KFb14XP
         8DnQ==
X-Gm-Message-State: APjAAAXZ+/vrDuJU7d/O9TkS2fPTgnuZi0kw+lJ77WlmvegacEWIbNFC
        UAzmQdH1PNQNI2rgt8dz3m3xhhZJx4gNmpL5kgDltw==
X-Google-Smtp-Source: APXvYqxUoO/oavOOyoTYQRAm2XiiclbrazlFt1RtxZDfQMp3ob+EXXLfNSnGBHTCU7U7KZPBAfTvul8eCr2Xy8uirW8VdQ==
X-Received: by 2002:a37:d95:: with SMTP id 143mr52836481qkn.132.1564611437244;
 Wed, 31 Jul 2019 15:17:17 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:08 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 20/29] x86/mmiotrace: Lock down the testmmiotrace module
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

