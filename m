Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70069BF6
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfGOUAr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:00:47 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52975 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbfGOUAo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:44 -0400
Received: by mail-pf1-f202.google.com with SMTP id a20so10838014pfn.19
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cmSzh4dtjNx/P+yROnH7EGJs7UfjLe1mZ8JUMa9RMlI=;
        b=oZY9eqJZOq0g+fIwSn9L1Bd7+IvSG5PmYH+irfYuUEGUGVedGZ4zYdyHPlquK/xafd
         S/N656316SMDuzoFQRZ1psGUlP7iBlP6T46CJkRLSw9K4A9IoLoLCVFz04u9xHIp86fh
         6GrUCyj07ZsajFN9ou+5adigVhuwrUrL25pP2XqvyMAXa2lFs4ZFsANlOyK7v99xJjq/
         JMTIZlQKyYbUxMooIuvlFJq5MRV5yMs5Nnv3dtR1UiTgl3PRzN9e/fco2UIij/KZB4ar
         gbm1XsZIh/tLzuqSQpDHN9QuVBPQD8Ete1dI2AiLp6x3Me+rTf8WVDcRp6YGfd0hJOqK
         Az0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cmSzh4dtjNx/P+yROnH7EGJs7UfjLe1mZ8JUMa9RMlI=;
        b=PwetxBuPBrKxQkGQ1iz1KOSiN0p6RGItoAR+WCXE51ZW+YZ6gA/eMc+9WMGaXhFvLT
         G0v3yLWft77oZ3XKOBzisndNOEWW2/2Iw761UtPCkWHDxGYbQrV5AmQdHhcMld3J8Tnt
         r5C1l2gpdvGre36vuIxVHb6GkKsq3yUQoR49+mti/e0T24FYZOVpsUsiRPYExe5+zDra
         PKByV0EyeZZccQfAZdnrmWDXTRi8THe1A90aGJCiqJyyAgeAkqsd4Qx/3BVZHXXmbdXC
         yy66LvtLkOu/Wt64s6RpCjwtR9tzNMikK9pPS69GBbQTEE6gxNfhepXxC5lzM3GfEDYi
         buQQ==
X-Gm-Message-State: APjAAAUZ7rn6a835jMOFNNB3G1malFTfBeKIYNCzd49KwBHd/VcHQYwC
        SaYKarn9qlHkcqP/ipLML9ouS8dxO1Pm/PNHQhIvQg==
X-Google-Smtp-Source: APXvYqyzIvqz0TZoPY8nlguNiiDuTnJcj8lZOYnyhvWc4EfdP/oipkbD8qlGc4Cay8amBfhAwZMB7gdMHVNA1s1E3DLv2Q==
X-Received: by 2002:a63:e807:: with SMTP id s7mr27900175pgh.194.1563220843484;
 Mon, 15 Jul 2019 13:00:43 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:36 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
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
---
 include/linux/security.h     |  1 +
 kernel/params.c              | 28 +++++++++++++++++++++++-----
 security/lockdown/lockdown.c |  1 +
 3 files changed, 25 insertions(+), 5 deletions(-)

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
index cf448785d058..f2779a76d39a 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
@@ -96,13 +97,20 @@ bool parameq(const char *a, const char *b)
 	return parameqn(a, b, strlen(a)+1);
 }
 
-static void param_check_unsafe(const struct kernel_param *kp)
+static bool param_check_unsafe(const struct kernel_param *kp,
+			       const char *doing)
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
@@ -132,8 +140,10 @@ static int parse_one(char *param,
 			pr_debug("handling %s with %p\n", param,
 				params[i].ops->set);
 			kernel_param_lock(params[i].mod);
-			param_check_unsafe(&params[i]);
-			err = params[i].ops->set(val, &params[i]);
+			if (param_check_unsafe(&params[i], doing))
+				err = params[i].ops->set(val, &params[i]);
+			else
+				err = -EPERM;
 			kernel_param_unlock(params[i].mod);
 			return err;
 		}
@@ -541,6 +551,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
 	return count;
 }
 
+#ifdef CONFIG_MODULES
+#define mod_name(mod) ((mod)->name)
+#else
+#define mod_name(mod) "unknown"
+#endif
+
 /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
 static ssize_t param_attr_store(struct module_attribute *mattr,
 				struct module_kobject *mk,
@@ -553,8 +569,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 		return -EPERM;
 
 	kernel_param_lock(mk->mod);
-	param_check_unsafe(attribute->param);
-	err = attribute->param->ops->set(buf, attribute->param);
+	if (param_check_unsafe(attribute->param, mod_name(mk->mod)))
+		err = attribute->param->ops->set(buf, attribute->param);
+	else
+		err = -EPERM;
 	kernel_param_unlock(mk->mod);
 	if (!err)
 		return len;
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 07a49667f234..065432f9e218 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
+	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

