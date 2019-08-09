Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1388452
	for <lists+linux-api@lfdr.de>; Fri,  9 Aug 2019 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfHIU6t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Aug 2019 16:58:49 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51444 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHIU6t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Aug 2019 16:58:49 -0400
Received: by mail-pg1-f201.google.com with SMTP id c9so4107800pgm.18
        for <linux-api@vger.kernel.org>; Fri, 09 Aug 2019 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eBQXEUJ4xG90qgyQmq59kEIpLR58l2iNnVeP+k7a23g=;
        b=rMxaNl5AsKq6YNwTXpua2sqDDA43FqhpUtJC7gyxqzGgupGFiMHIUyB7l/nDHPs2OE
         K1BnIyyLb4DD+tUtFKgJFNisQHq2ugAQS39MnTZyf86sdiRJxTaX2Se11M5G2oXCq1Wg
         0XavWtwnmGlFHooR8j5BIhZ/+SzDyom/Ot0q/CX4iFTq/lDouinbfWVfjYMDvCGJ+yos
         2GA2CzGK6mxom7oMSYSMg6U4hpjfeX1ncO5zQwsj3yXdv6Ms/GHmfhu1tt8sOp+y1p0G
         kDb1s2/Z7cxAzLMyBY+zRoZu3brFFWE0QBlXQA+vq0Xo3kTawHhb3EjzQLimYqVmEKZ0
         p4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eBQXEUJ4xG90qgyQmq59kEIpLR58l2iNnVeP+k7a23g=;
        b=aAYwXfdUzwxAnXudyOkYEXkh5WoCROG1Uidhh8rENXr2YM7TAMPPRDIx8vrS/k5jnc
         cUo2a3s9tAwdX8Fh21UY9MOXODRHr0TTYrg03aX/PsdrWl+o+HMcTuRBx+i5VlWHwFvM
         LyEwPy6u1U89sYvEU9GziOeVTVFXxmcW7PL9Ox25iUKqT3nhV2ruhr7eMfJ6l+/CvOb8
         9n2tWJQYTZf8cRubA3jRwh2sRf/l4YQSPF0Te7/Sp2YWHUfPqvK2Wejl+Tw1I+TMzyKn
         gl2rgnGQc8MF5EqR3C1tBUcVrgRYEbHhYfd151GMU8RTxo/qYYYVvF7vy9GhzJ7BKccy
         4p7Q==
X-Gm-Message-State: APjAAAWN8qc7L2B1zFxYM7lYAve+9WRhiw+aPT4ND1HO8+LYkkFXFVq3
        1I3Eno7ne7GZGfOgUAg+Gc4TceIWevJFoBlYO1COzg==
X-Google-Smtp-Source: APXvYqypvyr+nXY4Gz4HIOztkBZe1d5v+Q3txrKEylftEPnO3VwNYP/ngFop0XxwT2lDHqMwviPg9WFhIha741OGjCVzag==
X-Received: by 2002:a63:484a:: with SMTP id x10mr18952600pgk.430.1565384328279;
 Fri, 09 Aug 2019 13:58:48 -0700 (PDT)
Date:   Fri,  9 Aug 2019 13:58:22 -0700
In-Reply-To: <20190808111246.GA29211@linux-8ccs>
Message-Id: <20190809205822.109793-1-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808111246.GA29211@linux-8ccs>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V39] Lock down module params that specify hardware parameters
 (eg. ioport)
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Provided an annotation for module parameters that specify hardware
parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
dma buffers and other types).

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/security.h     |  1 +
 kernel/params.c              | 21 ++++++++++++++++-----
 security/lockdown/lockdown.c |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8f7048395114..43fa3486522b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -113,6 +113,7 @@ enum lockdown_reason {
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
+	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/params.c b/kernel/params.c
index cf448785d058..8e56f8b12d8f 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
@@ -96,13 +97,19 @@ bool parameq(const char *a, const char *b)
 	return parameqn(a, b, strlen(a)+1);
 }
 
-static void param_check_unsafe(const struct kernel_param *kp)
+static bool param_check_unsafe(const struct kernel_param *kp)
 {
+	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
+	    security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
+		return false;
+
 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
 		pr_notice("Setting dangerous option %s - tainting kernel\n",
 			  kp->name);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
+
+	return true;
 }
 
 static int parse_one(char *param,
@@ -132,8 +139,10 @@ static int parse_one(char *param,
 			pr_debug("handling %s with %p\n", param,
 				params[i].ops->set);
 			kernel_param_lock(params[i].mod);
-			param_check_unsafe(&params[i]);
-			err = params[i].ops->set(val, &params[i]);
+			if (param_check_unsafe(&params[i]))
+				err = params[i].ops->set(val, &params[i]);
+			else
+				err = -EPERM;
 			kernel_param_unlock(params[i].mod);
 			return err;
 		}
@@ -553,8 +562,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 		return -EPERM;
 
 	kernel_param_lock(mk->mod);
-	param_check_unsafe(attribute->param);
-	err = attribute->param->ops->set(buf, attribute->param);
+	if (param_check_unsafe(attribute->param))
+		err = attribute->param->ops->set(buf, attribute->param);
+	else
+		err = -EPERM;
 	kernel_param_unlock(mk->mod);
 	if (!err)
 		return len;
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 00a3a6438dd2..5177938cfa0d 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
+	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

