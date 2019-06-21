Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59044DE7A
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfFUBUj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:39 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38604 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfFUBUi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:38 -0400
Received: by mail-pg1-f201.google.com with SMTP id 21so2982174pgl.5
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LzkRv880sCWOO5kDA1eICQkyZ0YymQEU3SqA2aswVgo=;
        b=sbuim71wq0khSjkJ8HLdFMG6PzZgQcr3z5mOl7rou1pj/UYQAGxdLEdN9CyfUo6vBc
         1G/MdNWAlpeq8IKBBdHXZo9MY0Ny2Adlwo+cuoT2GSLK47+Ha8gzMxY3VxFvLRJWagJe
         btY6DWqszatmSNHnz+Xn9yImXf0X7UEYnPSB8n5eLFlWRDLGhgiDW0SqjSwsWB625M1/
         fo7wnnaIjgQPcs89Any8jZMRL3kL2lgP6xWPL9IGyTRLuoDLbWXMCCxNdzUmczW3DoyG
         x1oXwxbMgauOFdVDo3w/zwEDo7q7ScGAGtEAcU3yd5nFJh/5iiKzeM4Wy5XBk+TTGKjH
         KChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LzkRv880sCWOO5kDA1eICQkyZ0YymQEU3SqA2aswVgo=;
        b=B//w0YKCGn9XtDCorhw3wciuCvN6kvnS5OBQxI5Xr8Wns6vqaE1MK6JRA0B5n4uHFA
         azX8bZoZZ/kKwk3ZuQ6kfFIjaRIZxsi0uXK/70uUk+VbWDdIntcZRDtApXn52jRGI4sF
         rZJpgjWUslbzbTGdMtmtkOZYPaluCfjRFWKvCzZwRB1QWnySQUmHc7qSzryzXPLnje6W
         kdUayZ1AH1b0ROiDFRqkOiCCRKHL7/+5YOFm4UcUfJhes/jOePjrNHfp0dVbTiU1mgyg
         APmvtu6H47AEdJdh3+iDCDFLm0+H2Q1mtEEtzZ9fQmh7ArpefKpXE65/kUm9LL7Mj1kM
         0vnQ==
X-Gm-Message-State: APjAAAVsH+bl7CbxqNLqmg2n+ZYe0SO9dsxYE+b9EgQF4xGUFEF4YHjA
        Cxty59wZNMaQYGUsf8ObCVr5e9+SwXEbqg7UI6WvKg==
X-Google-Smtp-Source: APXvYqxImdv08d081T9gu+GwczlARXjqV+Cji1pvNFWp8nNnVWonvxVHQgNVqbFMJ3gwy9+ftPotnHW7q4YwpkvGHk865A==
X-Received: by 2002:a63:f64a:: with SMTP id u10mr7995559pgj.329.1561080037825;
 Thu, 20 Jun 2019 18:20:37 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:31 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 20/30] Lock down module params that specify hardware
 parameters (eg. ioport)
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>
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
---
 include/linux/security.h     |  1 +
 kernel/params.c              | 27 ++++++++++++++++++++++-----
 security/lockdown/lockdown.c |  1 +
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index cb5d74f9b9ff..47ca04ac00f6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -92,6 +92,7 @@ enum lockdown_reason {
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
+	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/params.c b/kernel/params.c
index ce89f757e6da..59544a2ec0b9 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
@@ -108,13 +109,19 @@ bool parameq(const char *a, const char *b)
 	return parameqn(a, b, strlen(a)+1);
 }
 
-static void param_check_unsafe(const struct kernel_param *kp)
+static bool param_check_unsafe(const struct kernel_param *kp,
+			       const char *doing)
 {
 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
 		pr_notice("Setting dangerous option %s - tainting kernel\n",
 			  kp->name);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
+
+	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
+	    security_is_locked_down(LOCKDOWN_MODULE_PARAMETERS))
+		return false;
+	return true;
 }
 
 static int parse_one(char *param,
@@ -144,8 +151,10 @@ static int parse_one(char *param,
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
@@ -553,6 +562,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
 	return count;
 }
 
+#ifdef CONFIG_MODULES
+#define mod_name(mod) (mod)->name
+#else
+#define mod_name(mod) "unknown"
+#endif
+
 /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
 static ssize_t param_attr_store(struct module_attribute *mattr,
 				struct module_kobject *mk,
@@ -565,8 +580,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
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
index c6456f300220..0788d4805449 100644
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
2.22.0.410.gd8fdbe21b5-goog

