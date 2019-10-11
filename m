Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16868D372D
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfJKBZ5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:25:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38374 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfJKBXu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:23:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id y18so493153wrn.5
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4NkZd3+L9Zc9aLTq5lNzxqpZor3mG4y4h8wq599474=;
        b=diwpJPk27mWG1S3iugiI7WTlAFCeA72zADOW4LdHzHMxWdBnffkKb6VvOO+j8lOaMw
         igpOKZ1JmF9v4oQ/59kmYCe3V6NbDxsayK6OBI4gWIU1xcIzWwsMvy1BTOtMmwDsIq6k
         M6zDwcfrqP+lPT1phry/1mMvSRaFW3mOcP1dLbM5qqxyJSTx368KWHYxgJLGwJeFz4TO
         ADo0D5YbbqhP9k4SzgAPjizWGfGRi2kDWaL81uuhkI3YF06bunaZZBPgKHjp+wqr08dh
         Axf9imDfYfWU8dxHvS1z/RcKBhMBY8yHWRHWryovnwKHlYNmb0bxdR7wlbKhxOZf5nXQ
         mtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4NkZd3+L9Zc9aLTq5lNzxqpZor3mG4y4h8wq599474=;
        b=XW8bP/YgqVomvc9nPAOQBPJ6/uNyicv+LCCPsHKF2ncO+HcWO/hmtHqBdDnu+3IFEq
         m1bhc+wgOzxEvAufsT427PEwxDq0Vbgm79kvdYhEnMCcKaHLBJnQRGXDcsOFucikn9GJ
         ySrNKKZD62ETLBDJdhxcFqTDUgcmSw+rbq6fAJgW8RirSaL37gYG4ZyZO9FJBfjFj4Uy
         lB0skAvovVUE65TxEAvtJJ4R4k812VZx1f5FEYR6VPg/KNpBuAza6DJaXjdkeL5NVJD9
         UpLpnKdORuWnhC9O5h3v7Psif16mpHp8RuX30LAD5wKtun3g60BdW7j5LK0jI19zdzn8
         S3oA==
X-Gm-Message-State: APjAAAWWU7F/I2569wlR98ZfVLaE60DbhbQw60qJeJBX8en0/x9O1ypm
        wcms6mZfmqOF38NA7BDSQIBv+w==
X-Google-Smtp-Source: APXvYqyBfeXEbJQpSUBrKcxiMSbwYkh9g79/3pWnIBrMaU9cKsjY3PSa7qG8ZM9XXA6QPY4usvitOA==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr7148735wro.310.1570757028130;
        Thu, 10 Oct 2019 18:23:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:47 -0700 (PDT)
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
Subject: [PATCHv7 02/33] time: Add timens_offsets to be used for tasks in timens
Date:   Fri, 11 Oct 2019 02:23:10 +0100
Message-Id: <20191011012341.846266-3-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Introduce offsets for time namespace. They will contain an adjustment
needed to convert clocks to/from host's.

A new namespace is created with the same offsets as the time namespace
of the current process.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 22 ++++++++++++++++++++++
 kernel/time/namespace.c        |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 873b908c9ba8..3d429c7ecca5 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -12,11 +12,17 @@
 struct user_namespace;
 extern struct user_namespace init_user_ns;
 
+struct timens_offsets {
+	struct timespec64 monotonic;
+	struct timespec64 boottime;
+};
+
 struct time_namespace {
 	struct kref kref;
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 	struct ns_common ns;
+	struct timens_offsets offsets;
 } __randomize_layout;
 extern struct time_namespace init_time_ns;
 
@@ -37,6 +43,20 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_add(*ts, ns_offsets->monotonic);
+}
+
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_add(*ts, ns_offsets->boottime);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -61,6 +81,8 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 	return 0;
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts) {}
+static inline void timens_add_boottime(struct timespec64 *ts) {}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 2662a69e0382..c2a58e45fc4b 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/err.h>
+#include <linux/mm.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -60,6 +61,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
+	ns->offsets = old_ns->offsets;
 	return ns;
 
 fail_free:
-- 
2.23.0

