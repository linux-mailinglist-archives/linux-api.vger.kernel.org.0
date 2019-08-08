Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE06D85722
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbfHHAJk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:09:40 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40235 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbfHHAHl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:07:41 -0400
Received: by mail-pl1-f202.google.com with SMTP id 91so54309463pla.7
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F1VsQKe1CvGe90szBrckBeIyG/tsASbX2ypyWhc14LE=;
        b=qMlQjFH4LNkPFt7okSAYQH4LtgYOG/hpHDLWPX566YGyPNtYJPUP46rcks4c8eYnlb
         0bNs4gihvrRlVOh7tP/Xx/1BqrbyEXSnnaOOpY9HI+9wJsc3wJD2PF5r/GwLRZeUaYMb
         amKeZJBCwihyM/juh7mpeQuNxOuwGxJ9NIxBA9znCQKrTU72jhbs+1l3EcTedt8WGozq
         BelKAb8SlmNg4vuZFYuqAK88knD3oJ0DDgpmSGebDO7s3E3QGb7ZbaHu1OLTTpwaG5sS
         F0qMtxQ/4l2MjyX8Z6GY0yoXhEMxtyJK+E73Gdo88OD3vLRca9iG/my2Faw6p3KXszOw
         kfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F1VsQKe1CvGe90szBrckBeIyG/tsASbX2ypyWhc14LE=;
        b=dQPEcq9QG9UtppNFe91ocf2MmMElCzdsmkLVTSR5NKbWYyyUqkHLFKUc/2fo3fALIA
         z3atUmYfm0iF9IA/0+lT+4lyzgOHKfvzSTQjtEzad3JdizgbRANg631bzvaJkITmgPTN
         Q9RDgpA2WU2zvb74wxM3CIJ0hKJAjWoH2vVEhI6dIJ1HSdgf1gmWP30hSQl9bGIs8Hqn
         hjjau/yh2A+Z10Y5RnaiCmDYnv5g7jDZp0po3JQmnYr4zyR67tDqyIMDvjDrV9xNkToC
         /kQRsPt8yKcVJvnm9rHx+wRFw4djSMTa0sEVZMbIoMx4t40fEciL0ynhsRRDzfleI3+u
         Fr6A==
X-Gm-Message-State: APjAAAUBcPiec7qZ6BS6tvFRCpyjLaoAUdGkjJ3SSnroW6UWEKZhwSoo
        jnyrQLOfF3uuq9hkzO0+dXIjfSewkCBHtYQhYg/vtQ==
X-Google-Smtp-Source: APXvYqyhRtz7BIHwY/gc5z8qI7waq/52irPZx7U7/ay1YZFhLhsfUoUA1xgDlFmESnZc3tLh3+OeQj7gqeFdOTwZNMoaFQ==
X-Received: by 2002:a65:6815:: with SMTP id l21mr10209698pgt.146.1565222859667;
 Wed, 07 Aug 2019 17:07:39 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:58 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 06/29] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 8 ++++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9458152601b5..69c5de539e9a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -105,6 +105,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1b018f1a6e0d..bc933c0db9bf 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -205,6 +205,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	result = security_locked_down(LOCKDOWN_KEXEC);
+	if (result)
+		return result;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d2ef29d9f0b2..6f302c156bc8 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

