Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635D179BFE
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfG2V6T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56108 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389244AbfG2V6S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so55190144wmj.5
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CL7BuFSrbJFNxj7ShYd110TtYKaJGS9/+ZXIwtFyKB0=;
        b=n7mF5N4Y31jDw1naKhkxwokqodl0+81LKojt1OmSg1cQlk+r4WTap4L3dSwiu9kJwq
         VHc51PQ2aGcV0zv0c+0cZLgM09rW1kGxW7fHKRO5lxTS4W6Cof3x8OjNthPxdDMHPfC2
         oc1n7O1w58MOt9Hb3qEVSsmG0Zs+PNX6x5ZT80FFOh91I1kFpZqB4Pu31G+76wLIQbNT
         erlC500m6/V5lcuX+gOuvaqR8If2IodE4mruUOrlBIo7PsV6cag2SxN7/RqPf4vkU547
         Ufq/qcevG5uuGQ9YPENLjLcp57HT+WaervgK7fF5xy18fs6k3BbEjS63dac0NaKgJ0fe
         eeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CL7BuFSrbJFNxj7ShYd110TtYKaJGS9/+ZXIwtFyKB0=;
        b=YZnKLLWI7fTtk67foJ+cG0Gyl+rb6p+D1sjX7JZeprUnUSWEfbEV4IjtyAoE1NzVmv
         o+AOrJa1LPj5b9W90DzqR1mAtdvjsFD+wE5S7OnnXm35elOmbjqRj4nl6kpA9LQSaTx2
         fyd7yt0x9bP/Y/J/ZfV1aRGyWLq90YiAe49Ni2hcjlG9Y+A2TKOOiaiX+RLVNbFe0Cdj
         53woq8Gz/BRXPgx6j5d6+jJUSukPLL1BdYveDHqaNhfw9iQMzWrw749Gz+ngZDYRydOj
         Zd7ImFTftBavvjpxGjByRwOKFbzirFMTi+AL2HkxRwf6YnuqrAfvgl4Anl2ZFs7QPMHc
         IQSg==
X-Gm-Message-State: APjAAAXgs8zNj3K7MoqDrQFzJ23z4ewra4JkYkYcZ8nH8DlQU3Y38GFi
        sPRLe7KqPY1tbpJQapRwQO9ODkJuleeSDeb712n5DoNp1TxnL3PUAsN1D/uMYzpwETHpwn1cHOQ
        miCTSC+/fKuEooieTLTr7K2t8q8jXMTD2HI4hhK09fBshHGVRAZ31XE8+vZmDIwmpDd65mZPlHf
        dtEN7IsjJ9sNrtLyw2Tz60f49nZQ==
X-Google-Smtp-Source: APXvYqx5iz2o6SvSGcoO1F7NoeIhRAN/6eGgdUUVZlDoXesZdLXrHe3iOasMyCZyS4bqyPaoSe02JQ==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr41295154wma.100.1564437495430;
        Mon, 29 Jul 2019 14:58:15 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:14 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
Subject: [PATCHv5 11/37] kernel: Add do_timens_ktime_to_host() helper
Date:   Mon, 29 Jul 2019 22:56:53 +0100
Message-Id: <20190729215758.28405-12-dima@arista.com>
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

From: Andrei Vagin <avagin@gmail.com>

The helper subtracts namespace's clock offset from the given time
and checks that the result is in [0, KTIME_MAX].

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 17 ++++++++++++++
 kernel/time_namespace.c        | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 334c1a1c6607..9ba9664ff0ab 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -56,6 +56,18 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 		*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *offsets);
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	struct timens_offsets *offsets = current->nsproxy->time_ns->offsets;
+
+	if (!offsets)
+		return tim;
+
+	return do_timens_ktime_to_host(clockid, tim, offsets);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -82,6 +94,11 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 
 static inline void timens_add_monotonic(struct timespec64 *ts) {}
 static inline void timens_add_boottime(struct timespec64 *ts) {}
+
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	return tim;
+}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index f849c59f1108..9807c5c90cb2 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -16,6 +16,49 @@
 #include <linux/err.h>
 #include <linux/mm.h>
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *ns_offsets)
+{
+	ktime_t offset;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+		offset = timespec64_to_ktime(ns_offsets->monotonic);
+		break;
+	case CLOCK_BOOTTIME:
+	case CLOCK_BOOTTIME_ALARM:
+		offset = timespec64_to_ktime(ns_offsets->boottime);
+		break;
+	default:
+		return tim;
+	}
+
+	/*
+	 * Check that @tim value is in [offset, KTIME_MAX + offset]
+	 * and subtract offset.
+	 */
+	if (tim < offset) {
+		/*
+		 * User can specify @tim *absolute* value - if it's lesser than
+		 * the time namespace's offset - it's already expired.
+		 */
+		tim = 0;
+	} else if (KTIME_MAX - tim < -offset) {
+		/*
+		 * User-supplied @tim may be close or even equal KTIME_MAX
+		 * and time namespace offset can be negative.
+		 * Let's check (tim - offset) for an overflow.
+		 * Return KTIME_MAX in such case, as the time value is
+		 * thousands *years* in future anyway.
+		 */
+		tim = KTIME_MAX;
+	} else {
+		tim = ktime_sub(tim, offset);
+	}
+
+	return tim;
+}
+
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
-- 
2.22.0

