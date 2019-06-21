Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9304DE82
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFUBUB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:01 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:42120 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfFUBUA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:00 -0400
Received: by mail-vk1-f201.google.com with SMTP id y198so1929107vky.9
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=af57BkICHWtBEhAhRPluDJYSzW4vsTQOt2Dv2I5IOUk=;
        b=IRoWUe0kjnWk9CRB6Z3Q7oivIgHLoAwxJpttK3/Z3gbuY1mYGG7YWlvonyoh8zcbxI
         KeCB2/G1j2TNV0nkIzTQbahxxwWsnUBzhzWH6R1dB4sNFqbWbLcijUga8nOMxpytUaZ3
         XlCVS9WUO1DIfqSeGm7s7coBacLNgbZUhSLkeASDr9aqbX2pXx4SkdAcoQb1OUgof4xn
         dFvQty7FufoTUDPOjO3T0WYizaF//2mFsuJk+sNNn82E6UtPGZ5Jh6TymRyetnY2XRC6
         gfjAFyq8anZLg9Vudv29aT9PuCF//21C6070ryWaDgfv6/HaJn4j6AV/E6k8oypHrJBG
         X0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=af57BkICHWtBEhAhRPluDJYSzW4vsTQOt2Dv2I5IOUk=;
        b=K1C8AnY9B9mjLamo1hU6KBYaKPC/9L06brwApLt40zSzWQnGQu649i4W9AtdKn+eo1
         9Y+/shr5z62eXc91Ciz6ZoXUOQ/iwR1oNeda+5g1TqpwzndesyYM/I8imdwnA4XIpKGc
         Pp5G2xVGRvvUi303rqcQHBDf9FsFj/WE8ZVnTiG5/h1U1dcMa7X3k3Pg8YDNFiDsn2Ja
         wAH7at0AbYhSEdOQzKPBizUFEkpNIVtBGqguZGCdmm18jlx30f0Up2o2bF5MgKVQJ4ce
         LvQbwW+UUexrzmbdYs2EuRfJujLa957PshEd6buGjuHKBkwa2Wd1AHLYDsJpsJtIlCu/
         UPaw==
X-Gm-Message-State: APjAAAXtzsN+rqqJhFwkGO5GZ6iOabj7jDh2C18esqm0ORrTmyZEwJaP
        uxK6D6FjUgGhWudlmR36qMAg0/2J7M9Ns4Rw1SqzbQ==
X-Google-Smtp-Source: APXvYqwXRS8EJiFrJCkqS+n54YP83haAvmyw56J7NYjzVVdgXkRvIWiemc8ps7T4xv83p/2EJ11QgnpB+zJ9Edj+Wch3gQ==
X-Received: by 2002:a67:e3d5:: with SMTP id k21mr5168267vsm.172.1561079999251;
 Thu, 20 Jun 2019 18:19:59 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:16 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 05/30] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
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
 drivers/char/mem.c           | 4 +++-
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..1ee6cff43eea 100644
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
@@ -786,6 +786,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (security_is_locked_down(LOCKDOWN_DEV_MEM))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
diff --git a/include/linux/security.h b/include/linux/security.h
index a7612b03b42a..034a8d54687f 100644
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
index 08abd7e6609b..43a049b3b66a 100644
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

