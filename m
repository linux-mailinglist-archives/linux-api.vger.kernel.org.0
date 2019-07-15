Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2017169C26
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfGOUCC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:02:02 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48537 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732522AbfGOUAj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:39 -0400
Received: by mail-pf1-f201.google.com with SMTP id u21so10850104pfn.15
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6D0LT3kOVXFnzThxDWKYD3nJFmfA+k8GxVnpNpHN0jQ=;
        b=skNA0Zp0MFTgZ25ppBqcBepyRwgDB+SK+DMX63rm062qS/6ITw3TJ65vULvshl/TtW
         1yZWQbMVqnxpBWEsQYNtyKQ6lRuwNRorHBsub03kLBk72nEp68iw8HJZXBRNwVeE+USZ
         itxOsdWZdOvNbvaZECK5Ty85MxqMfKwYPCQtWK37i3zMdD/zXKZ7z0NzXOoC+t1DpYpx
         9PDFJhuk7aEFF7pchF4lWOUpfd5Ywv26LZROy4USqNjgj3ka56bjikdRTRSJj1e+cLJr
         xpNkbDDWelhTVtGwZAdkulUh13MBt8NDAm1EA8qyfqFu1ZGbS0D8/iJhrnDBfYWmZE4x
         lxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6D0LT3kOVXFnzThxDWKYD3nJFmfA+k8GxVnpNpHN0jQ=;
        b=RMPS5mlQjWLW9exolFfBpH0KtnFh6OKIPOMSBU7WHFKcF/A7VwgcTWhE+MHCdZS/zz
         W4NXHknKMP+IR9ZCigKVmC8jTarmjAnFQjlMkvnqniZhmKFJAjLoNtfCrAneMlT9T5Tl
         mRGR13JgFfMlHgrlXEnQWNKKvI0pqMlXG8DX/B2OrfgTJcZhh5MNmxtFx555XmP5J9P0
         z8FyeRuKcpfNn7ak1WyHenlbE1xHjGEuabl+Cs+0FQBNxyplssfiX24D7WaFUb8aMdFp
         kgZfFre11KG3bxMwnkbsAhOeYCy64ZWdJdqui/Nbpenz4XifthNir2pmrvE7UJ7HksyD
         phAA==
X-Gm-Message-State: APjAAAVQMShjCWCYStgN7DJqyZ9pw3osLcoy/mAR2Gx68nL2A7HaZTjO
        FtG9HxNbQRJTl+wou+z/rPAuBdSdcsKou+MOI63n3A==
X-Google-Smtp-Source: APXvYqwX139JUoCV5imG25Ui0tA/gIuLEykR+UmIdT4xltTZpxM2nFpRz0YlncnpYVBThrlKvKGvsPAzEJX07X+Rj65jCw==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr28640627pgk.378.1563220838301;
 Mon, 15 Jul 2019 13:00:38 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:34 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 17/29] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/pcmcia/cistpl.c      | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index abd029945cc8..629359fe3513 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1575,6 +1576,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	error = security_locked_down(LOCKDOWN_PCMCIA_CIS);
+	if (error)
+		return error;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1c32522b3c5a..3773ad09b831 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -111,6 +111,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 67dbc5c70ea0..96106c2870ef 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

