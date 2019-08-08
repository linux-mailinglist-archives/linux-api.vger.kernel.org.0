Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6958856DE
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbfHHAIU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:08:20 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55933 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389679AbfHHAIO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:14 -0400
Received: by mail-pl1-f202.google.com with SMTP id q11so54322137pll.22
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6aduxenHUMLAdRKp6MotdzoJ4uvtyrO7PmmmKZqbApo=;
        b=j5tx231Y0mVNxYudig/8nj6kcHI+p4B8cQgzlKqpa7X0AVceG335EYqBUA+mUrAHYJ
         7pQB/gqcMV0g7OR97dEU7gjfUcWBnQSwLHnR7tjrDsuqxNFB9L1h8fbLHOS4iz0gFmgK
         eCE3n7IHAU2Pl/Lo6eHFS9LIBrQr3F9IqumqP0jbbLTLbf3FNvHvPAdb7qrHWWz91VcM
         bcEcNYV4F8IOvbgRkTkPkZlA2+YUPkuN1VDPrx7U5+hRkFBgJzwcGd7F5dCAiElTi+Gz
         IB9MOaGbPPKxOMRfbalnm85x8IBy0brYdm604Tlu+Msvn4/r14ZzZ19Uss9ZWzIiunMV
         2hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6aduxenHUMLAdRKp6MotdzoJ4uvtyrO7PmmmKZqbApo=;
        b=EtTqEsgZTUHAyUtpUvr2v9rxSHkt2JSWDB3mx7sw04JUdMcRB3iV3u2HO/tequxVU0
         zqKCTioquY6klqgu6CgsZ/77NATDVmKo48wKWZNFrn7i8/Nem9q87UI8j+4lc1xiqaC2
         NLgkJw9hGyRGxg/PXPySIc0MI2lfVyc6RrqSMxeOQt6+NjInGw/Xv7Rlm/+MCFBJg5S+
         MVBgs6v1taRCnpcFRC8+sNf0iGwJ6UXAdVYMw6UNj+rULKOLO668ZIRt3wNo7kV2oZ4e
         X6q8zGub2RlOa91UYj+Sw7EZLUWljB1uhJIsQkRFoo3zl+CDpXmr2mQLsbdrubZWwDdy
         /e8A==
X-Gm-Message-State: APjAAAVlodnbd3C7nGD9h2AzgULgTZq2xvrgiWWv27EDcUAUrsYKzJix
        U1KN2Q0jkGOYujmzniOxNdsLplUMVENPGFtLgAihWA==
X-Google-Smtp-Source: APXvYqwG9J/qpgq7duxzP66qcjTOEqPq756wtOH8HlsfhP4JFCCsUuENolgCp5Xj2/ay80VgwzOr2hHiBr5zaVbZb7/Xzw==
X-Received: by 2002:a63:de07:: with SMTP id f7mr10283613pgg.213.1565222893329;
 Wed, 07 Aug 2019 17:08:13 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:11 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 19/29] Lock down module params that specify hardware
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
 kernel/params.c              | 27 ++++++++++++++++++++++-----
 security/lockdown/lockdown.c |  1 +
 3 files changed, 24 insertions(+), 5 deletions(-)

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
index cf448785d058..35f138fce762 100644
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
@@ -541,6 +550,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
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
@@ -553,8 +568,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
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
2.22.0.770.g0f2c4a37fd-goog

