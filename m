Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05606D54A
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbfGRTqK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:46:10 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:32997 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403964AbfGRTpI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:45:08 -0400
Received: by mail-pf1-f201.google.com with SMTP id d190so17190115pfa.0
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RRBZMPW7QAp9NmodVTLU1AXKruLeSmfJqtEU4d2fgdQ=;
        b=PM4iWh23cboh7pTTqTINE3qbgbZieKP97PqntC4mhWSgTVDlPP3Tu19Hes/MgnZ0ff
         d8jyHj6X1VRLzfpeSTP05uJbDi5p2mLa705sH0W/D5XFjMeex4AcMdWatG+1iGfB7RnL
         g0aH0W28tt10yqV1Fi/+rnGkqWMKJWPzgDZMGJonjCYYDqlTvAXyHXivFG7EW+fEjhbE
         BYq14HbffrVLYWDyOtB8OVZe0tzVKCKWAIyxKmm0kVdTBNLjDpC5vrExWq0fcKgUjl9O
         WD/PrjMEXVUqf9UzLthr2eWWTZeWMVBMdxRgWSKnNOmoWTg/B03VmeNYjC3AGSfD/56X
         wUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RRBZMPW7QAp9NmodVTLU1AXKruLeSmfJqtEU4d2fgdQ=;
        b=aUEiZdbOSUFlsjmwxDbjAR/+RSXzSESPpKdECDooej8X1SfPIeSGQMcjY5CtfIhgcc
         S/gqRPMb/uYM1Tzr0T+knOIPtRvJ6mV17MoOOL3/r/xnMAuN9Wefeq6Uw0kl9hNi8mjr
         YtO7s4NNIF67RIjDYYpNSPPAGXMwKKI4TacpOWGsDfiyyXeUwpaQdAS+bCd2RI/OuPw7
         zxxaSclz/4qAlN0FrKZYhotPL3T40+J/07hVvt8wjLq9Pd2LOQy7kROkbUTgCYSOMvnx
         HirDe1qznLuGOLaANsCpZ7JiMvNKz/pb+IqFd7kZm/oMCSajXq1yoSS1LaEmpvHnkIk9
         bBYA==
X-Gm-Message-State: APjAAAWkeW/GCh4ZWNxlWuye2J0SDtZJwuQXDV7x2AihxXomKLt+m+fO
        PoIJuWbWzRZMcdVG9rRUZl2+gK0J9sVx96YX1QHLPA==
X-Google-Smtp-Source: APXvYqyuxq14TWeVgh27x5/3o80oK9cyWbyqgkolQ76QSM/rVnF0ch2qx/On89W/J5+HzZE8WUADsEA4zaNpRf0qUEfdjg==
X-Received: by 2002:a63:9a51:: with SMTP id e17mr50126681pgo.212.1563479107590;
 Thu, 18 Jul 2019 12:45:07 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:05 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
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
2.22.0.510.g264f2c817a-goog

