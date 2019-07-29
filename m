Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDAD79BC9
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbfG2V66 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44406 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389394AbfG2V65 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so63448657wrf.11
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L061fqxdJDm/6UczpPY16FNAif/88rIuI3OcvE+KkOc=;
        b=SqDFYU9SHvoiaFTyzgsTjxb/4ifU0afkv6XkWaly3k0tacrVq581WrKU7ZzD+8ozxK
         Xt0ZZpdMxTeczUPR60ebKi3unnbZPPTqyMtIaPNPXW5wrsp84aHPMr6GppNUY8gLIgHA
         hCUaRfSL1DDDo7bi46Occ710gXuYaraTuGtAXPKfdF+2MsUmdPz/g/bGWM1/L8lT0BMP
         5WH49oSmB7swGJZ50sWcIm9srGv+MJeUKSqXiohAi0B8ddXoAf2LmX15qvffV6jEmY4t
         3+atxlzgQxP/t+Wyqd+L2VxOmLTX0o/x8vuJOWbjZ1IJ2HHhzttZFCGn/Id7tupvXk2H
         eoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L061fqxdJDm/6UczpPY16FNAif/88rIuI3OcvE+KkOc=;
        b=UJtK1AVaJK7Kq8rAcJnMxwg/pZ7kP8HjQrUzLbhdpzNVjxqavlfESX7tqQ2vaOmX9x
         KMhSE438AgpgmWd7HqDiHGOXrUO3KlzBVx9ymTVSJn+t23wIBt0xA9eijqYRFaLJE5dc
         4KXzwShwEkcZc/RMXog66IdXUGIE1Uz0QMEdwARb1IAML865qOJCrBwlBto91Ve76dLT
         XaHenvWb7/FNh4sA/+uEbi3ZoWL+iL5/2RB/38o3PbNlS9V2lhSjP40XNkyNE3TRXJYl
         gRWe9LiJ8QBJvWQFJRl8dmOCJHUasAjqxzl0+fc+l/7udZeIJaTwJ8YO3wuBaavpAMgQ
         rc0A==
X-Gm-Message-State: APjAAAWe1Z0JgcbB5lcUbe2E2gS4hVaekLyNCkU3C3g9K0Mlbmh9djEF
        GVqkdHC7biuvnDWld10rpBD0xSjd6wkpNNCM9E/ZbMn/uHIOHmY/nC+MeGawNE3eTuGaRqOdQsu
        P9X2Rw0FEDEUU747Si/j5WOVEss3cSsU1T8+yN4/tlwBa3qMDbs0k/Axjx7ShS1hBdTnmW1asms
        d64AbdMLSmFhJE2530leXhQjc+jw==
X-Google-Smtp-Source: APXvYqyJWf2J5IBV9Q2uoOO/KKxc7seuX1r2sbgCXyxgbH01SmMW6YI0hHJN6Dvv8oUeyS2oqSjkLA==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr19691562wrs.136.1564437536052;
        Mon, 29 Jul 2019 14:58:56 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:55 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 02/37] timens: Add timens_offsets
Date:   Mon, 29 Jul 2019 22:57:22 +0100
Message-Id: <20190729215758.28405-41-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Introduce offsets for time namespace. They will contain an adjustment
needed to convert clocks to/from host's.

Allocate one page for each time namespace that will be premapped into
userspace among vvar pages.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 MAINTAINERS                    |  1 +
 include/linux/time_namespace.h |  1 +
 include/linux/timens_offsets.h |  8 ++++++++
 kernel/time_namespace.c        | 14 ++++++++++++--
 4 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/timens_offsets.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ce6ff88f7efd..b58c49d331eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12837,6 +12837,7 @@ S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
 F:	include/linux/time_namespace.h
+F:	include/linux/timens_offsets.h
 F:	kernel/time_namespace.c
 F:	kernel/time/*timer*
 
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 9507ed7072fe..b6985aa87479 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -8,6 +8,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/err.h>
+#include <linux/timens_offsets.h>
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
new file mode 100644
index 000000000000..7d7cb68ea778
--- /dev/null
+++ b/include/linux/timens_offsets.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIME_OFFSETS_H
+#define _LINUX_TIME_OFFSETS_H
+
+struct timens_offsets {
+};
+
+#endif
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 7ee6be0647bc..f849c59f1108 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/err.h>
+#include <linux/mm.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -47,6 +48,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 {
 	struct time_namespace *ns;
 	struct ucounts *ucounts;
+	struct page *page;
 	int err;
 
 	err = -ENOSPC;
@@ -59,15 +61,22 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		goto fail_free;
+	ns->offsets = page_address(page);
+	BUILD_BUG_ON(sizeof(*ns->offsets) > PAGE_SIZE);
+
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
-		goto fail_free;
+		goto fail_page;
 
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
 	return ns;
-
+fail_page:
+	free_page((unsigned long)ns->offsets);
 fail_free:
 	kfree(ns);
 fail_dec:
@@ -95,6 +104,7 @@ void free_time_ns(struct kref *kref)
 	struct time_namespace *ns;
 
 	ns = container_of(kref, struct time_namespace, kref);
+	free_page((unsigned long)ns->offsets);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.22.0

