Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2540F7D098
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbfGaWQx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:16:53 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42582 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbfGaWQw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:16:52 -0400
Received: by mail-pg1-f201.google.com with SMTP id q10so20565936pgi.9
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mRx6DvobeAgz9fXiYoI+VAmx830kBHXoGc7G6A5EVd0=;
        b=IXsxtFi3dTqKB+o/Wp7s083XS7SjUbQMcCgIsd0WIzzMtZmNaSQKck9SZk8/LV/tKW
         iauqc9Sh1AIluynW7+PR4PhpczN6yRdIv953ynjwuwFWHa/UVnQ72sULwrXjNjS6e/rU
         9B58SiL1PCO7x+gwtiCfLRDcFLfHYqJckXhIxs7f7BmC/OAWPsSihkTtRDo4hMCslWC4
         DcbbsuYXQYGwOfMS+1sE0Xp813o+0VO5tuwgaPAWsIiBTlDFJ2yTuhzH/viPVcMxtFXv
         PCDiNz31TQAFo2c/g5gz4FxUjGG5qNoYLTvZVJc1/xMrVhVCF6vii+6Ml1XW+QkFPzAs
         w83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mRx6DvobeAgz9fXiYoI+VAmx830kBHXoGc7G6A5EVd0=;
        b=Nsn6AzCAX83+5LoImWcMsrmbudz8k/gaUUHK3Kd9LsZSQjFa06oAQ/Gaq4hxt7lD38
         6ymWz+UHwqopym1mUJvuQTDzd20FW7MeDVs4LDm5PVD6NvIphYkEOEVIMxOZRqlFHTTm
         GUnJ7PTasJTG5VK+qj0FTfdROlCoSMhWcI9+v+LHHn5u/kYNxscOkxHFMUmO7g95bvb9
         n/dGCM63C66rS36ld8I7gab+YemoAhO8hmtaQ8u2gSLk3YIqLldY4Oe7XLnSYVGDiT1x
         x9nTR9cTfyrs/Wo79dPkKnbR4uLu6DpxEYPY/rN4kuega0Z7SN33MX3eD0TPHYY7GzHn
         rLSw==
X-Gm-Message-State: APjAAAU19KJYxuRtK15kbWaTepK8OT4RDSfBaFAHaTKluhAPfLKHZMCl
        A1vP0j2OzoW8x5lv92ym/4MGhgsNQsT65MNVugWXiw==
X-Google-Smtp-Source: APXvYqwPUST8bcWEuK6wPg2C/0aVphd5/eFEPuRhKx/A1xJZobcujQxWD9xlWlFEjxq639LtyRci3WWJHAF+9qOzVRDrpA==
X-Received: by 2002:a65:44cc:: with SMTP id g12mr37784362pgs.409.1564611411719;
 Wed, 31 Jul 2019 15:16:51 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:58 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 10/29] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
---
 include/linux/security.h     | 1 +
 kernel/power/hibernate.c     | 3 ++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 69c5de539e9a..304a155a5628 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -106,6 +106,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
+	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index cd7434e6000d..3c0a5a8170b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -30,6 +30,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -68,7 +69,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 6f302c156bc8..a0996f75629f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -21,6 +21,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

