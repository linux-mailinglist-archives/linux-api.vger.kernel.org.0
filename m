Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFD4F245
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFVAEz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:55 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:53167 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfFVAEz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:55 -0400
Received: by mail-vk1-f201.google.com with SMTP id l186so3031545vke.19
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E6ROmks1YP8CwMOFQbw770isN8mKFQ6O3PhJWfaTMq0=;
        b=cpBykRhdrV9WvWOUQ0h1bdHdihLaySqHs97UUlYGQjYPCfnQENBajs/VWwRncZdWQJ
         x3qp4dXdCHuLvr0Mp9gBg782SJ3QvOmtlMNNdGpXLWvphNDNK0JImHSRoWKx2+Acm19p
         g/ua8GzrquOQvXhYsRy0aBLAk5lrgayhBjNpvyBXlqdfAauipEGwI0ELTVNh+Y4hnp/T
         azc+iqLbvc0ObICwB2E/JKUSQJQEvpYBDmbLnn0W+yOQNMrspXNt9MaRhDRXIAJ1i2kx
         Ue/EZgQQhMcAruOAHGrXEeDsgIwOVf9cSnt7HPqH6YwJy6llXY6OkWVOn+911ox4eb2F
         q7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E6ROmks1YP8CwMOFQbw770isN8mKFQ6O3PhJWfaTMq0=;
        b=mUf0HUvl7QOP4F6tffwpiRhlR6yWMF9eiUhfduqTKtXnxNfnTikPoBYJz0veFqqIZC
         OlDDt3wpmTXrqYcdLbiTB53pBuOWfHVasaUi8OJapdjvzaYIO5QlTyN3vB2DvnNk/z76
         Rg3n6uPlKX96wblbyML9H8odcpUNTnxsv//+psYSqkME8RmuupBwP0PdwBceb6q8bMbX
         OlVXlG6a977eYMRLuQqNhy91575JckJiIk/ujx33m38UbxevVz4UsCQJldRnh9rQtm0B
         YWwaHbdqGlo1xYmRTBkOOcoLotKDGT8OeSa/kejFVH+W/G+87zvWtM3meyiWTEXHIGwu
         mojA==
X-Gm-Message-State: APjAAAW4UHKw4dZ9cRbyMixx6avJIrwzAHaGTlZ64Y5zf7U0SboMp6Q5
        9xenpMJeUcSSuOcWFlThZeNIg2h7BA1vcc44JGq/tQ==
X-Google-Smtp-Source: APXvYqw+u/Eu3DXZ9kV8rsq9HGa/mUShM0pFU+LKsox84T0C57wKcFXQ5hrwtrEFi/oEfemF3cbnfzDA0KSHSaaITTC+qw==
X-Received: by 2002:a1f:8bc4:: with SMTP id n187mr930984vkd.32.1561161894624;
 Fri, 21 Jun 2019 17:04:54 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:50 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 21/29] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
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
 fs/proc/kcore.c              | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d29d869abec1..4e95edb1e282 100644
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
index c649cb91e762..3875f6df2ecc 100644
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
index cd86ed9f4d4b..4c9b324dfc55 100644
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

