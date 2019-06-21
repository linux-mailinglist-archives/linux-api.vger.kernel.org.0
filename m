Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6392C4DE66
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfFUBUE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:04 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37370 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfFUBUC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:02 -0400
Received: by mail-pl1-f202.google.com with SMTP id w14so2678041plp.4
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NgELRMteSmX1KpxuaMDKOBuc0VBFM90Hd4coc/TmqVU=;
        b=ACSqKMI7rVvJrlydZWykRsEZ0OCQUb++cj7uLN+4lQThNhHP3k3PG9zYi37SyH9Dpn
         rd2VqHFnVXRkQl9OcOSg70pc13+aZIlScD9U8dcWo2cnsffi9SMnRtCCLkwSJ0mOuUL7
         HxS13GpMnI1s5UUVef6KmTow2HmUvlz+z2/jwv6EB2+Vd+0o+rxbiAQ7aKx0ceJZlWUx
         08Bf4/6Jk9EOtgPklFeXx8UuKWqzGkRSE0Bi3XuuN4S6b9RjFN4tCcO2oRFCm8p1OFSu
         JrFkr9Y8BMSFxcV1Zw74qQw28i5Vn+1ZzPo8Kme5IKT7/nwJUbJ5w2XPDlwhLIPqRESj
         ANTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NgELRMteSmX1KpxuaMDKOBuc0VBFM90Hd4coc/TmqVU=;
        b=QkmFokmxjKzkMc030ktr12qwZaiaypm35ICGvd1OW+Jq4bpzZzMD6CtuaLD3kKASJv
         Q3JwcU0E3z5VBigwsk+hZlbYAns78GkEhQ02dTbWkfhBG5gGla1jlYfVphy3ujD6cdlH
         N8b+9bST06zTnikpbbEPM0ptoOPCxsrmAaaoXdJ6jLiaTVzkN3hBOzuEAN/bEozq5476
         qrU2YS889oCvVz9/Hz74n0qDeB+4j9iuuW9/OpkLaKEIrRDdm7NiYIqqTwr8lPmbs6qB
         QcaAfjij3UdVd0PhXJl5galBNGLFi5HcJrvC/6u2lR5CsX9zvl0vKbD09OoMmj2fg0r4
         2O9Q==
X-Gm-Message-State: APjAAAXfL3AKw5IQYZkSlYDtEhSNsfmVOcJI2gQFonDs+XLzVvtfVLWG
        h+NIJuasgnv0cLhVKAFWJ0+kGO4an2Tm5Q74edlBbA==
X-Google-Smtp-Source: APXvYqzIeCMdr3ffaDQRIeVOvllR4sI3try+R35YojEX1TgCv8N6wazXrBjdBnNKX1W9SaKleY/gXbi5H41fVDmPoCOqhA==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr15535306pgm.143.1561080001656;
 Thu, 20 Jun 2019 18:20:01 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:17 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 06/30] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
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
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 034a8d54687f..2d3c69b9fd04 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -84,6 +84,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..040819d7b11b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,13 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (security_is_locked_down(LOCKDOWN_KEXEC))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 43a049b3b66a..94af1c3583d8 100644
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
2.22.0.410.gd8fdbe21b5-goog

