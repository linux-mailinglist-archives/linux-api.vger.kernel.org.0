Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5394D79C07
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfG2WAy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:00:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42103 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbfG2V6m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so13561397wrr.9
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=gK7byqnvCZsRyAqDUYBeiSCrVa5couP/h+KwniMJqL09zy+rCaIohJDUe9fStHvTA7
         JREI0X/pNKAN9fxf+88hlyirEJ9wIXGnsEl6D/EYxWQrZgmKwBAq6YVPrI0NvKK/HSST
         vRkw03heGflDUvYPLv0ERzuLcjmO6Z27rLXyVa5bIxr+JPAo9aeFJ8TMCN9GbUvf5pHb
         lXuDk7nvS5RxVQmOKi9cvUiaOhvfs8mXLFEcfA01gTUBIaJ5xNQAxl21rTlfwXaQaZ5c
         CJdzPvW9rvFWZGB5G4dhYwg6TUHvXTmaHPd0g32TU2ECThWVKeKSm6SkQYDgnyiGMqND
         HOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=VoCoCdzzZoLdNJHWsmYGcbD+T5zrVKev569MASLsQ1X4cMx8pkfa4Lx4knWlECtCJP
         ERwbArK4L8z7B1ydC/pH7h1BgaVSiEjtP7jKPkrbVxXpJUBJNMCt9XBoaW2uzUM6dvl7
         Byysy2BTbl04aLuDI027AdDrgscltYs0Tw5J9+gIfkOaNGvhhqn2PC2N57F9gYNXkfGv
         SMfpuq25TJEIJm0pVQCuizv7pNJMPka/bBnjYhMF5JqXeQQ0Seqfnv22p+ABxdW9GWZN
         72nm1s6YW2X51gvbBIDZmN1xKewPc8myIl2zB8U8zcSr+PTWkPCpAP7j66eK+0q9GIP+
         +s4A==
X-Gm-Message-State: APjAAAXZZjGYkRvnNSQGhpzy/NrJ1NSm4vF/qUVzBF9eFWQKn01IeiY0
        k8CNR43CJ/+oZIA5Q5s2su/lxXYiP4R5yBTl0KlSf64xoucU6523gD9AXO8jMnERqTwWoj8pekd
        FMUics0E7R1mQbOvhgR3P9LiQQgaT3vNWh787uLHAPXpv3Kq00uFRHW677pWye23S9GW4V2dW4j
        dWr8m0jlWucKl5bBqLVguMSFyLpg==
X-Google-Smtp-Source: APXvYqyujkIL21jruIIVOjs8R1vGjVkFnG/AhEu3LLytd44H68v1bQ5N8nR+C3IOS4wZrjo9GetQ1Q==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr103003683wrj.352.1564437520327;
        Mon, 29 Jul 2019 14:58:40 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:39 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv5 29/37] posix-clocks: Add align for timens_offsets
Date:   Mon, 29 Jul 2019 22:57:11 +0100
Message-Id: <20190729215758.28405-30-dima@arista.com>
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

Align offsets so that time namespace will work for ia32 applications on
x86_64 host.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index e93aabaa5e45..05da1b0563ce 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -2,9 +2,17 @@
 #ifndef _LINUX_TIME_OFFSETS_H
 #define _LINUX_TIME_OFFSETS_H
 
+/*
+ * Time offsets need align as they're placed on VVAR page,
+ * which is used by x86_64 and ia32 VDSO code.
+ * On ia32 offset::tv_sec (u64) has align(4), so re-align offsets
+ * to the same positions as 64-bit offsets.
+ * On 64-bit big-endian systems VDSO should convert to timespec64
+ * to timespec because of a padding occurring between the fields.
+ */
 struct timens_offsets {
-	struct timespec64 monotonic;
-	struct timespec64 boottime;
+	struct timespec64 monotonic __aligned(8);
+	struct timespec64 boottime __aligned(8);
 };
 
 #endif
-- 
2.22.0

