Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB2856E0
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbfHHAIU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:08:20 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46618 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389691AbfHHAIT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:19 -0400
Received: by mail-pf1-f202.google.com with SMTP id g21so57840057pfb.13
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FIo2fvd2ZRzAOCkOenwujWvUsEXtgcv+etTkEkyg1xI=;
        b=HlI7Rts+QtzRW4GLuPztGKD87kPYSJpcD3OcKSF7X6Jeb+mS7V0K0o+ODF2M0pKW/6
         hoY6BTWys59pq3J8kngkIEDoJ8ojECUgkCBjrcuXzU5T8AXEKSmWLwFa4Jy7mn/EcZ4u
         RRE/0qOmbsCIC3kJ9SRcwCm+0BZFq2evgpl7Mmuc9q6iwW2hNjJ7riryL9Hzqmp6OuAs
         GesRAMU2i91ckfgz34XqnR1B+65GbI2mHCxbduG2FfQqEFUm1sOXOXwTRYeKAkJS8Sp7
         mqVoQHjMSHglXCEX3tU0WQnI3P/41LOjRdnHyq5Unv+q0EPR+Ej9jiXyD0QsqXXsMK6c
         QTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FIo2fvd2ZRzAOCkOenwujWvUsEXtgcv+etTkEkyg1xI=;
        b=arXZGpY4ew7Q/s/zof1q1y0id9MLVFenqVRWQgnDUUAYRIZyyTrIWqRce7pxfh5faD
         XkHLePf9V8sDWVFuvcWyTTE4NIv0b89Csby29EUiy5AsoiUsTMedp/lJeJGP26Cu5lsx
         9ig0dneLQIwJEwh+dUjpsRt3H3ZUxwWkYlexg/eFB1s2hTzv160hj3Y+R6yleXPxRGx5
         4GIStHT6+AbOMzawIPDyuAMWz4Ko6dxpMrjHylPTjKKfWchNoplqFbQ+zpofJ+fjdZNR
         yJrtGJQGHj4oSo/1OfsfNSMg5piHZQpa9MCHd0SDLcC8PxU6MvVJmQ9bcu8ghg/vEmFv
         S61w==
X-Gm-Message-State: APjAAAV90bBga59HXaNniDtgH9yvbWLqmSrtVsQBQCrDnNGmYbYIoO0F
        36BV/roRBYhnW+V42HQOVNV1/5Ur+EXBT1e5PZpfIQ==
X-Google-Smtp-Source: APXvYqzKY7wvOvJHauSEDw4LLkZ+RRap1la60w5DLrgKijg8RNHHD9Stn9spETv3/0cCk0lp2pzTJcX639VU3uIGImRybg==
X-Received: by 2002:a65:458d:: with SMTP id o13mr9885716pgq.34.1565222898530;
 Wed, 07 Aug 2019 17:08:18 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:13 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 21/29] Lock down /proc/kcore
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
index 3f7b6a4cd65a..f0cffd0977d3 100644
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
index 37b7d7e50474..c050b82c7f9f 100644
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
2.22.0.770.g0f2c4a37fd-goog

