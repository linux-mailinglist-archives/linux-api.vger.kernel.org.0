Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7CE4F266
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFVAEP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:15 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53132 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfFVAEP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:15 -0400
Received: by mail-qt1-f201.google.com with SMTP id d26so9777165qte.19
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/+3/eHA+dSCIdfxEbsEJE5ZPu3YcdHs14Y4qiRI8qP0=;
        b=NHPhigq8H1Po8LVtH5GbIbnsfNJsBGYMYY2gEq3zllF27oLua38Vj9z3wa+okf8okb
         pWH8iQupEO8ZFxTX+7BkdVwPl9krXRrBOrM2ceSMETStMsli0y5kRfGaoJeyAfmxsGYs
         o8uSDCGcI305P4/xETNJWHi1axbKmmzz8veJll2OP3L72Jegea7jCAMBcOnplFMrmN+K
         ytNo4+f9k5qf7ZV83nxVq8Qpj3r4HNyoA67wTs19qVwB1HYRsUq7H7CtagwoBI6KNa8x
         POTZqxmWt7TQDlbu9VSGvXTAtI7pnzKL+/L/HA38N6Itp3uWcvomSdNGbKbv4ZVcDhbB
         7eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/+3/eHA+dSCIdfxEbsEJE5ZPu3YcdHs14Y4qiRI8qP0=;
        b=Z5YNw6AOODO5k3T/BQ91MeZpWPgK6/PJXrU6/ns+7ZlnrKLhbC8OF16l0eq9Cd78g4
         POIq8dGlSWd3Ey7WViNwbnBm5UZaAi2szMN/o8bBBHP4pyAtJuJ/N6AXXV5774GEwnFj
         jQ//98t1zWskDZPB8vaCN98zqvqgv8TPLAKTF0ocJhtl4nW9UgLztIngPiznCkyk4IIp
         r6/T+bqNm/JWmktCBkEVuE6Ur+5zVn46SWlVmBzwGauWHs4o5yu+kIzdd0Q7ZIr0eeHU
         fR8ssCXLtMmHTMptjBKsympMeubpkIjsEecV5m93hiPEnzjjxuBKoqDIxFVJmqL5M+um
         dj1g==
X-Gm-Message-State: APjAAAXYHtp8INcuoVHumbMEsMrHR4mCbI/h7/12aGeQ3WOsfoOzvlqj
        7zrA+E1wGCG1XrCs1inAC9OhJcon0mX9Ry66AmJFoQ==
X-Google-Smtp-Source: APXvYqx73LVPKUTT0/Z2o6KTeTT6M6JdkpFVqc84Ol8mGehYEExhBCBNgJGcfHkD+Wx3YMnYmuwtGz8w8+pv3jt43vq5Fg==
X-Received: by 2002:a37:a152:: with SMTP id k79mr7772332qke.411.1561161854063;
 Fri, 21 Jun 2019 17:04:14 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:34 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 05/29] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: x86@kernel.org
---
 drivers/char/mem.c           | 6 +++++-
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..93c02493f0fa 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -29,8 +29,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/uio.h>
-
 #include <linux/uaccess.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -786,6 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	int ret = security_locked_down(LOCKDOWN_DEV_MEM);
+
+	if (ret)
+		return ret;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 46d85cd63b06..200175c8605a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -83,6 +83,7 @@ enum lsm_event {
 enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
+	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 25a3a5b0aa9c..565c87451f0f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -19,6 +19,7 @@ static enum lockdown_reason kernel_locked_down;
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
+	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

