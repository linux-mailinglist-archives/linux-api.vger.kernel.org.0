Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6DF8655
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfKLB3j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:29:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34283 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfKLB1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id j18so1133883wmk.1
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IRDM+yZMFiOIAiSFtRM956uTQVJcNHmssWVn/wAfygY=;
        b=h9LvU7L/oDIBnoeon5ua8wIgejjwpHeKWMKe/nOfDXIe2KK5g/Owm0CuxczfExYVuk
         hbg/7mD+v0g3tSuoBblDcpDNjjie+i9kmJPD6QmwHWJy4tJGrQKBhTtA9rPz+eKz68Hb
         ONAqWc/mr1Ugkp/v+dygBCbZ8n/MbMQcgZuvpic17ikS5iCYQD+gTYQCXDrMia+Xtxar
         mLzZNLhsPnEthyXLKsMfD9z+IndyqYmKlVmnRRp4ZvWtRUUeeinTe+546Dit74BVUb1e
         f2658Q9++Ah/cEU+b2qtJqaGAH0/ahDSf1p9MWnADvbRE5ciRPGvAphFv62qROhi1sBA
         we4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IRDM+yZMFiOIAiSFtRM956uTQVJcNHmssWVn/wAfygY=;
        b=EZAwbp7ePhwfKlRBAinq1Bja42+hhXi7I4b2CtwpQA/DPCRj/h6TMt3XmB2RkaGCDf
         eXAdwISvR+2MON7DbPSSk7kuZVgYPDa7tFnhtD2h5wVSCQD6VmKdVKqdkzBEEEvNlXgu
         h3vwKKmF3/zudpGwxdxrOF9LmoJpfa7pl/9ZvxjsrAYztzqZiAr+hEG776F1hiqKbfRB
         Xmc6uqIxwokQ5vjPqSvkrBg/w2vOGelchc9nUcTNlwiWhUCHHDqq48u/vN1suyfM+uJz
         Y4qOWRHWNdiKuJw5AR18oS88P5DUvDW6sDBAhY6CGcf/9eqTBRBI65H9Ek4oOrmw5Y+W
         L2DA==
X-Gm-Message-State: APjAAAX7taHW7AHmdA6sCq0yZNkHEh+xDNZPJ59v1dH1Rbfj7YUGLu7v
        YR9v40o3o13dd15fRFQ3lkGMkg==
X-Google-Smtp-Source: APXvYqwdT+hnYzOuNQQNaxoU7+YKuDf5LEvb7iSstmb/ZyxbZlQmmYHTZWhzwyPFN6Jaff2kRTiBtA==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr1501401wmh.152.1573522067873;
        Mon, 11 Nov 2019 17:27:47 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:47 -0800 (PST)
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
Subject: [PATCHv8 12/34] kernel: Add do_timens_ktime_to_host() helper
Date:   Tue, 12 Nov 2019 01:27:01 +0000
Message-Id: <20191112012724.250792-13-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/time_namespace.h | 17 ++++++++++++++++
 kernel/time/namespace.c        | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 3d429c7ecca5..a68b1ab7b5bb 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -57,6 +57,18 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 	*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *offsets);
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	struct time_namespace *ns = current->nsproxy->time_ns;
+
+	if (likely(ns == &init_time_ns))
+		return tim;
+
+	return do_timens_ktime_to_host(clockid, tim, &ns->offsets);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -83,6 +95,11 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 
 static inline void timens_add_monotonic(struct timespec64 *ts) {}
 static inline void timens_add_boottime(struct timespec64 *ts) {}
+
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	return tim;
+}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index c2a58e45fc4b..1a0fbaa5d2d4 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -16,6 +16,42 @@
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
+	} else {
+		tim = ktime_sub(tim, offset);
+		if (unlikely(tim > KTIME_MAX))
+			tim = KTIME_MAX;
+	}
+
+	return tim;
+}
+
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
-- 
2.24.0

