Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD4CD856C9
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbfHHAHv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:07:51 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43828 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389560AbfHHAHv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:07:51 -0400
Received: by mail-qk1-f201.google.com with SMTP id v4so80705859qkj.10
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mRx6DvobeAgz9fXiYoI+VAmx830kBHXoGc7G6A5EVd0=;
        b=Nb/f8Yv6FUVnI6AIYErVf4XUZ415HdkvpRagDvig0laxwN4e5b6qWT1BqjPfyTY3gh
         /H3whwCBPF7qu+ONJFFcvISfyrKbJANEayQYzgY9gHmZ8YKQ+kEmvPYPYXODnWGXvi5d
         F8znJJWnR7znYQH4GDVeoGbQexpU7EVwK6PZksEIOj0WfKvyQIByPBZuAZ9IteArwCXj
         WCIVC/+E1p3z4aH2TMUjSVRwVSsuCq7uBHKlr80Wfaai9/4Xn1k7/15AnRb9A4Ctyc3R
         GgvmLYIcY0b7C23Fi2Fqh6yf9PKj8RyyTjrNT2czlJijhFqHjk2/PrJ/3idRZYhmTtMI
         D/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mRx6DvobeAgz9fXiYoI+VAmx830kBHXoGc7G6A5EVd0=;
        b=D9iUw6o1cs6ybxh+MwTrGGaEjkDVRhzysSJ57OlyT6+JKU80w2QMpkUyPBYcCTkMEa
         1eweDGdRIt4bSIRGIL7jev7PqFiUj2eWbu4qTe19VXpT1xyUtJ8qSk089db/5Sz97coG
         jG0/Lsgk0bXhLND4UMf1Ihoy6dpoQM9L8TpUu7fleX5QNWM5TL90DYhpW1G+X3KyN9dV
         zxcBl2ISCmxdMrpOSCBZ9i4NxB+24NEu2onlno7tOREyThxuD5Lnh6yOwwe/ZRsqmKmN
         nJlfC4l42Hpu0qHc6ex6F0JD5jW4mdcWBctbMJyGdPv1Hx4und9Lq3YlWux4DbBFixlG
         erBg==
X-Gm-Message-State: APjAAAVvXtun+2djRXaXpPoLsH6qQ7MEnRaVOLQvMVPZ7wWBTI9J+vjT
        2OPWLP0cLJPggF+JilixQRGRpKlkw7ckeWhMJnI2EQ==
X-Google-Smtp-Source: APXvYqzDD3e/DDDmmiFWtFLYPkI8+F4oMu/Vs4BKQACi8mWeuLre1RbWU/82SKWjQJaIbIWLzYoh5zi/iHEUBl2vePR/rA==
X-Received: by 2002:ae9:c303:: with SMTP id n3mr10359268qkg.372.1565222870081;
 Wed, 07 Aug 2019 17:07:50 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:02 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 10/29] hibernate: Disable when the kernel is locked down
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

