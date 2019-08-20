Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190169526A
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfHTATB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:19:01 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52071 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfHTATA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:19:00 -0400
Received: by mail-vs1-f74.google.com with SMTP id 125so1387752vsr.18
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WRMzqxGXLNI0SsBdZY8cEvaiXgaE0VA439c0Hio6O3c=;
        b=Mhh4cPNkmy8sQQ8Xxa6AAQ9jY+vx5NznNoSQsXjJgvPnFoVdCPwv1xnIxLGy8wXOGa
         Y+QauLaf0LDbBMzar7QnmBa5VhZCshx710U0wHANb09ggoNAPyH9zceRsKiRbEGz0qlu
         QvTXKIWp1YhLEhIVJ+uBGGcUZsogr6LaPafLxs4ZMANGUX6XfXwcbGuGD0umHIP0TbIE
         ykMq+1ZXLAn6HbdHiF4uA4bH4kYP3p2OcaBjMtd6lwrj/dSTbS6ccppsiSHGxtEyegpB
         aDdOBJexX3QW8dhwf9EjxMlcSOXlKXlVj4ox4W2c39ULGab0VcK2dYwnTYmdPBPhuzBs
         xM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WRMzqxGXLNI0SsBdZY8cEvaiXgaE0VA439c0Hio6O3c=;
        b=ZDi60brCAqzDIbGI9TETLOfXa/thtZc/flWqTD/KZlloKwyN9C2L6KX2mMeqgTuOjg
         gsb9W+jPP9QQ1VaGwHcjcivfj5kpGvCimLjdZNG/tXGEsITSa4lJVCU6qMgMwPVsW4eM
         lPvcVahyURzGvYz3o4EUusL6zvfiraNKisnYDsnzuvAyIcsGYv1uAUUxxCIARS81c94t
         cd5WWa+v8FaUb2uXcZ9VlE4NFazwaDS+PEj9Ry51OJ2ZI2zryCASzogtidoiRfA6kL4Q
         7XYfqzSWwHQG3Al7Hf0vEoBVk50pyHNRMwlei/NWUc4S9URRprXGnDLz1cYxsXQ3p13G
         qpJA==
X-Gm-Message-State: APjAAAUg6HBMXYQ81O0kC+YXRaaYxoV2Zi4ie13Q7nQ1Xjic8ljReMIO
        Cz3lWJa0al7WkdF+WikylEaFV8JOS/c1i7F76xiajw==
X-Google-Smtp-Source: APXvYqyV4Kgwvl5pQht/U4WWNO2ngHwajMUTquOJOpL/jf7OovZEbp24SlhZhz06vIk33GR7iA5I4Do0Ql2vGMvUJiqKbA==
X-Received: by 2002:a1f:1654:: with SMTP id 81mr9237922vkw.49.1566260339513;
 Mon, 19 Aug 2019 17:18:59 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:55 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 19/29] lockdown: Lock down module params that specify
 hardware parameters (eg. ioport)
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
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     |  1 +
 kernel/params.c              | 21 ++++++++++++++++-----
 security/lockdown/lockdown.c |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b4a85badb03a..1a3404f9c060 100644
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
index 771c77f9c04a..0fa434294667 100644
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

