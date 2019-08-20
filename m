Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED519526D
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfHTATG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:19:06 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:37468 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbfHTATG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:19:06 -0400
Received: by mail-vk1-f201.google.com with SMTP id v135so2386415vke.4
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QVXgaTwVG9VreaH3kje2rc/wKurD8V4CNVZ/noHYMMk=;
        b=bj7lFYyjZn020SZbZOk33R7A56KuaUFVTe2noLL8QdE7HgZxuAhxLaUSgMCukpx3vn
         jvYHzDrs6UZ+J8cEPlybtgzi1a4GcjbDQKj91Fxmq838IZuuR1o01r26YEk81pj8tU4u
         F62FzJH9nZ+M3/4CpkH1ed7675JPtKKC/L3+HwSvIge7LZEdpDlGPnbl0dSL34+lPro0
         e19bCC2w0bloNUoPXX0F3Ow5/Yb0M/32OU5P0qvxdNLrBw0DxhsYs5hAPDuhxvob+LE3
         keTHnblpb76cieqWg1IhWeobmLv4+1YH8q1Yv6SsJ3p7OLDyh54wMAVyugFGEyqVzf8o
         EClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QVXgaTwVG9VreaH3kje2rc/wKurD8V4CNVZ/noHYMMk=;
        b=dZCZ3rfl7R843CvBMQVY/pk/ZJX6UE5cdK2XdFSAAI5NiwAXWPW3jIJiZx9srNbHUA
         9Fo4xwKooAOzIQu0Z18ij2o5m+qJXXQ/d9gcbq+XlYD0sCVFkWpS0nAGtYMTK3cCKtyf
         wmOeTaZTRGFeHVq7tkfGMn0Lu80bUI3/zHnq010d+Bv/YIITKkIAUGk7WH35y7mhVikf
         /AgrP3rL3Jmtj8wB30k4pmMcl8gwJg1IT86TnNX3RW9+HI5YYK4T3u6KmcrgbyCmYoF0
         cxdhgmBNSVeKZJ8dk6OXmkLb6qq+pQ3AMgxVuD23IWd/sR5iE915Habw7/UKp4m1a9xc
         5K+Q==
X-Gm-Message-State: APjAAAWz9OF5B3gmiXYHceGk2YQs2B1phb0z2+Y8ghs9ybYV2WlTK7Bi
        iS9Xf84ZsTrMIE14aPHiZUIv5rqAowMDMtCyQnBzqQ==
X-Google-Smtp-Source: APXvYqzx0pbLPeq+7iW9FmfOUkB/8f86o5aEj/xOncerWqYh1W5+r4mi86/9A3la/JbE3hLldzHA1rPe+X4GGuSw65luZg==
X-Received: by 2002:a67:d11d:: with SMTP id u29mr15922362vsi.147.1566260344913;
 Mon, 19 Aug 2019 17:19:04 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:57 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 21/29] lockdown: Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data. This is limited to lockdown
confidentiality mode and is still permitted in integrity mode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: James Morris <jmorris@namei.org>
---
 fs/proc/kcore.c              | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index f5834488b67d..ee2c576cc94e 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/memory.h>
 #include <linux/sched/task.h>
+#include <linux/security.h>
 #include <asm/sections.h>
 #include "internal.h"
 
@@ -545,6 +546,10 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	int ret = security_locked_down(LOCKDOWN_KCORE);
+
+	if (ret)
+		return ret;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index d8db7ea4c4bf..669e8de5299d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,6 +116,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_KCORE,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2eadbe0667e7..403b30357f75 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -31,6 +31,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

