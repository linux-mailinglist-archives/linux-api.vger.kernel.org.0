Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7613F8638
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKLB1i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:27:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34263 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfKLB1i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so1133505wmk.1
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LUDXBB8p4SWDZcyqO1bx/Tpm6RXRLsAhLch+D7CesM=;
        b=Np+AhLdECbNazejClk/a7TVO4e1SYS3ecZZMmIovr4QUo4n3sPwwe86RzsX9Npgeg+
         RD+ht8NU/XXfpfzxRE4qjmFFqHXOdZoUSKIYDHzCSJSyGvRGmZzuMmXGpIOR2Rvrwgce
         /wX2BAI5XPrE784FbFCE4cTM9fP5S9ytX4rl9G0zPIFtfyKsbgNq3UFTsMtHYwVsB1Gm
         Jn1tFo5/Ll46wNmJUeyjw+HfETwataqskbvjI5sIRVia0K2KosVTRaUDNiU6uKTIUyFq
         +SUPVhANn0cpsXh4fsATXOoMaVTzG6ZxaD2YqPgvkxEAn6qXQ8TEDiYAET9yfE+lYGu9
         792A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LUDXBB8p4SWDZcyqO1bx/Tpm6RXRLsAhLch+D7CesM=;
        b=epega6f20uYAEgCWmcEZ5wp2mfmTMNRdnEGkvMgvdESRECqGMAdsE6rWkhzIVqbU9F
         HXDvk5xsAc6suyAyV9bwc+eibgOd/soIonMctNpkvVS/Wf8GId8yPrGmQdXn5DL51s/6
         FUJSFNow9xOGFT3WroaVDD/XkmbIOsY6i4rjgQ3jW0JGOiuZEFRMcpwad7Ra42Q0CoqH
         Z0nMOogt0BNeWRLtX+qv74jt0Y2A6tporPOMPWl5REHLDik4PXfN9BGSkJHp+0kB0yHX
         inJ7bMm2RHD8EOUMB8B6ssdoi6aQ6CGAtTzIOddBrSFd3fEUvYamm62PqQWDGhaTX03d
         5sVA==
X-Gm-Message-State: APjAAAWF1wKMOoW7lZKnbEHj4fr3+zQTd83NVNot09r0jrbMk8XoVwOf
        3UAHl8EyeH/I1bZt2j5k3tA8zg==
X-Google-Smtp-Source: APXvYqxA+P+8170d9z5KNSrQMlSPGeDQlZV0PAWgY8kB//ieNASdl9SUMvosabPuxvilMRpl7JHEnQ==
X-Received: by 2002:a1c:998f:: with SMTP id b137mr1618590wme.104.1573522056635;
        Mon, 11 Nov 2019 17:27:36 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:36 -0800 (PST)
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
Subject: [PATCHv8 04/34] time: Add timens_offsets to be used for tasks in timens
Date:   Tue, 12 Nov 2019 01:26:53 +0000
Message-Id: <20191112012724.250792-5-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
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
2.24.0

