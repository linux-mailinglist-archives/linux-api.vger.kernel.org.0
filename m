Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E55A6D507
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391654AbfGRToq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:44:46 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48796 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391633AbfGRTop (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:44:45 -0400
Received: by mail-qt1-f201.google.com with SMTP id x7so25391222qtp.15
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Fsa5djs+VQ2BrQJC+FUs9YwCCHQQfjCNM9PGrMIw+A=;
        b=GUfpKO3Ga00Csg4gANFyqY7Cii9zK5UJiC7y7T53XWMHXolPbGtqL3/Y47/RTYgeVm
         Mi6RCLXrn+mFXqpu5OsWOJKds5n11Pm7/VfKFqyJyZc9yr639fO4YGJKtjbx4J4dg9DS
         PJwJtApulzrCc0Bgg28sX6Ujl31wRI6PaW5rfHbkzmCSi0hS7nYUQu7E9PQiI4ht1XC+
         dnV7J2tcrTwkrO7Sg9e3n9F/+LqTDuw1UdpjFK6nE1GXMcyw2GcsKji4TXEFCm2+pont
         rqA8db+Ui8EDLoOR90H03Sx1uL/TpWN4SwHCRaaCI4xM2JGV2I8do4YqpvWrigRG+SNK
         TUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Fsa5djs+VQ2BrQJC+FUs9YwCCHQQfjCNM9PGrMIw+A=;
        b=VwYnU0qqjk/17g8Zc1XgwMmgFfyuwXA48LtDphSTmV6A4g7ACk9y9PgJXPVb3FsCsg
         QJ9Vbt4a80lJEuDDMy7sONKn/kxoZu5BqWembtyFByywjK3Q8/YNBxaR2KI1dVyVHhMl
         uGE8eS09GO6XGJtEpy1lwjfEgCUGRIQycpFcV2YXgMMGVhQvD5Z6KuQDASfWVWJNaJdb
         HmAiCK9lXvh9Nm9ECgox3fRJbGAOKDUb0IReV+S3KJ2IGByU1CvvTFL0rHqYVqrk+uzH
         esjuS29mKBbxJAymmMUluq1QkXVEAGR74q2MFmVaAao5vRIZ8RvCKgsrlh9XHdOn2LO+
         tbEQ==
X-Gm-Message-State: APjAAAXBhYmK/38J75E8hUUnT8DEkBoySU7DyzIvi+IQZigY0bw5WmPo
        cqFcRPNhw3CYGef6OajEw4ACqBYDgt7unltAxIj+Aw==
X-Google-Smtp-Source: APXvYqy741iSM2u6/mj5HF9mJLUvf4WTxBzk/3jchTmVB1EWeHxmWZcFTfDOtltj6LRSG0GCOtQ7D+jq/zKj0P7CgkdOdQ==
X-Received: by 2002:a0c:acab:: with SMTP id m40mr35031284qvc.52.1563479084552;
 Thu, 18 Jul 2019 12:44:44 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:56 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 10/29] hibernate: Disable when the kernel is locked down
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
2.22.0.510.g264f2c817a-goog

