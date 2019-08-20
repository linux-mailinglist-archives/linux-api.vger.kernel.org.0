Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843F295253
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfHTASZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:18:25 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49170 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbfHTASY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:24 -0400
Received: by mail-pf1-f202.google.com with SMTP id s10so3518963pfd.16
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KEN1/621HMw7IMfp8Bhrbn/lMKb+FMpWN6y+R4B0zXU=;
        b=DnG3SLg+kryCv883pYqzrppk2z/DgKjwrD4Sghbocds356yt5bJDzjzQb1b+wveJDe
         1H79mW4g8luPWRTilF0N4iZ/U7F+W91vu3dXhCdCQZhqRx8+sFVTXbiFHFTKZXAewmB5
         46PiuAXySCSkliboNVn6zkBBwNsW0UkhHmUeR9+fwM4rBk4oq1wE2NCml1IQEsdPUxPj
         U8LftEt/jHOXe4DBSa4/VkbXgiMCFwq7AKbR5NVsLcT/uwzf2vvmZh83OgT0RNRBc7bZ
         V+ksZ0m0vn8rJUbVwZF0XuOrBWK7HDBzHHS38G68udbIipnGCbofxTBqMxOTRP4yP8Vn
         uH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KEN1/621HMw7IMfp8Bhrbn/lMKb+FMpWN6y+R4B0zXU=;
        b=D6l6kOHMmS8rYIVUQfkTIBYhsZ9yQYwl4YS/+90lNExptFeE2gnOnG3lKjT+CnQ/3O
         rDV8hiYlKANA0NLDTD1Azbac/Rgy1VHysJgxarEZCW3INeImsyVHjfEAUSTjhzPx7pxC
         59p2qQMk9WDEIOs9wCMktA+pUsh9DeZKYzwgUs/jdBnrYwIqk/6MNj5wAecEKrdM2/zY
         pF+gh684NN7chsVI/YLYeNOi6AAUpt8Bna7mNXgniAPblrhVoMCa03TL0AmZYgSQMbXf
         Neis6PrE2qWAK94tfP88Eh6PX6ni3zrdpTvoJeBC4KeLm1T6x3SPHgjEv1w3zEUEyQN8
         s0wA==
X-Gm-Message-State: APjAAAV1Qm5OZUyWrw6MAP+B6yWX6q+1hFH6MF+tLy2U0nEn5HMi+gKT
        V+8QQGBw4crN4DP4QwNS0M3C7GfeudmvzhP/GZ/BLA==
X-Google-Smtp-Source: APXvYqzu5BEv2mtJKqJd6UcBWYswLbyp2Wvqob1sMe+SQF24ZfScjj7xKDwMAvtmGOpUZt7gdkbtAJE2Vkut4H1ejF1s9A==
X-Received: by 2002:a63:9e56:: with SMTP id r22mr22292240pgo.221.1566260303010;
 Mon, 19 Aug 2019 17:18:23 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:41 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 05/29] lockdown: Restrict /dev/{mem,kmem,port} when the
 kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/char/mem.c           | 7 +++++--
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..d0148aee1aab 100644
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
@@ -786,7 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
-	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	return security_locked_down(LOCKDOWN_DEV_MEM);
 }
 
 #define zero_lseek	null_lseek
diff --git a/include/linux/security.h b/include/linux/security.h
index 9e8abb60a99f..e5dd446ef35b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -104,6 +104,7 @@ enum lsm_event {
 enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
+	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d8e42125a5dd..240ecaa10a1d 100644
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
2.23.0.rc1.153.gdeed80330f-goog

