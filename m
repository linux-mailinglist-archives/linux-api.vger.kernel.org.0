Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA044DE7B
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFUBUo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:44 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:40104 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfFUBUn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:43 -0400
Received: by mail-qt1-f201.google.com with SMTP id z6so6092296qtj.7
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fIFhmiOiT1d1AZu2E6BoXeD1gdoYT5pBASREIuKJk5E=;
        b=exdVzCNpyG+TXdyx1zMSMEGHDhm1ELXYDImiocGB1OExqvAiPAOVH++8fzdCIkF3cX
         I1YiXiqr2w28TuEDIdAtd4YiyW+PDnGaeZ3dCuFLFcbkuXJzewsLnKGiBFhcTBE1LOLv
         AK7gdYYpvYGeDpCTs8HA9RCOCWZeh7VVVUwBcLCo0Nj7m6ze/GupP1FtJGynNn0kTRdN
         zopBAyVpQUfdyBQWl/9Vh5zUILpPGH7+aJMp5jNFGmE7dCU6RtRNkE4QFHNTcDNhsEAJ
         k2CRVa100Ba7hesTTMPVHSMcnN9GMc3EZdbG2vTXXYuqgOClRWTcQSJp8ZgNqFsSMSBK
         Wp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fIFhmiOiT1d1AZu2E6BoXeD1gdoYT5pBASREIuKJk5E=;
        b=Y1YFBXu/eOv/DoGnZo60BOYWYn/dtezMxJi6Gajg/AjOU65DTHHj8Wn9Uh+ES3v9jy
         SRjHCuWbtLviw0HhUu1wcLQsfDPshAQ542t8nNY/AeuvFmY+qSkWx8nsnY8Mpsbmj/cg
         nGqPKhpMRPOCS3/A/Dq4Dmh3BI2z6DOgNbBLS3aJ7s/2prDPVbC3otBKBJFoYdp1Jpdf
         18UKWEDtDRGjHNS9C7X0vwui0UxitQAjr961Ux2/TJgYAQx9CYQp7gYAtWFaxWuNul0P
         /ENEy2OkLY2P25zZnQknRdRGSbZNJ1wWHX0Z8m0hX+CndR/ZXYxrliuiFRtIQEuwUZwe
         ZOUw==
X-Gm-Message-State: APjAAAXa0Yk/6wrlS+85RpMvgI6m3Sb7Ie3HaGbqi02lBEkgGZLj8YdL
        CsiHAEuh2/sv2WSaLU4exOz1hAZqDFR7qkf0LGMGzQ==
X-Google-Smtp-Source: APXvYqw3i5yA5qZQZzU45TUnIenX3cSptG593+0RmQ9grKt1vJcRec3c+XBXkp4U7WgWv7QRcx7z37fRGYjRGvArZyEnuw==
X-Received: by 2002:ac8:38c5:: with SMTP id g5mr117018528qtc.299.1561080043098;
 Thu, 20 Jun 2019 18:20:43 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:33 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 22/30] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
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
---
 fs/proc/kcore.c              | 3 +++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d29d869abec1..b410a16b1960 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/memory.h>
 #include <linux/sched/task.h>
+#include <linux/security.h>
 #include <asm/sections.h>
 #include "internal.h"
 
@@ -545,6 +546,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	if (security_is_locked_down(LOCKDOWN_KCORE))
+		return -EPERM;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 89b7adfae525..6752584729e2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -95,6 +95,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_KCORE,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 215615e67237..80ff4a31d8aa 100644
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
2.22.0.410.gd8fdbe21b5-goog

