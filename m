Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3779C17
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfG2WBr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:01:47 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40239 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389254AbfG2V6S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:18 -0400
Received: by mail-wm1-f48.google.com with SMTP id v19so54829137wmj.5
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8TNpPfRzkd/STVPqA/OmSveOcsf2nPj4laDcq0UFS8=;
        b=J/yMUgi7iMEAQ2WpRqDSNy6MFsL7kyNsDQu8Yi4RlvU6lloGIOeUeFvcMpb5kPY2N0
         Gxkcp/BjRuLchidbhOtgSwup/V35CZHd7VHsru3aHwngyl+hRdK6FjhtBK9At4mvD7ar
         KMYMBtfNKHePWUWFEdzL0JAYRq0hLB3z5luoUHvQXJV6CISw24ahW4oW3qlGkV12wYBl
         IT7urvkxHJjWRScu6Mcg3fMKVJmsOYKLqV1IKGMzxlNi2FWaw2KY8thOvrRg/8lTiXUg
         Ef67SrP0z3GKttqi6QNH6tAB5ek+uo9Rnlex07Nl3oGJl7gvOrtC3wwMFZwPUKdwtJ2j
         qXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8TNpPfRzkd/STVPqA/OmSveOcsf2nPj4laDcq0UFS8=;
        b=qCwbgnXzq3fC7zHK0wuKWPKNzr2I6XSGdCXI+AqjpdWx3bsU9fILMLWTxu65Q4V2lh
         N7h+PcK9DUv0kmafPEkVFKnneFgZy1XwNtdWzHzcHwuNaKM0pObHcDt2WtSoD/tJvtco
         jOh7rwaiLd4fVXr+pCqX7OoD/S+vDRXv5pjQ6El8PHAxrSCe5D9TFBbug6xhO+zRGAhl
         V9JQy7zYDNPqaYvmgR71oIZA1HtmTRwDkuiJqaAAawFqFUAXnyh99ONraothntB5NQJk
         e5BOvw5m824o2j1W/AeWrJjA+LMyFuqBYinPsuippBUoUevIX0scqFrwqsg5QmMkhNI7
         i4Aw==
X-Gm-Message-State: APjAAAUz2xUzHNQv5lV38mIuF8TwiSOj2//VB/VpkpF57XS/thPRZs95
        69tWWJGhBoKUjrANBtWftxijyUBFkUP4irhDp3tKtdq1cVx1GEApHVxU1cVy+9gSOoPCK9aezf7
        7ceIo5X+SQngp64Zq66GoxNbuMwKGNj1McINffgq6+pnYbm7J5lqZn1Afj8Ohvlh38cXEkmq0o3
        a5muPEUGfrfjwJnsdk4eH0TOWP3w==
X-Google-Smtp-Source: APXvYqz4176aOTeCNi73iY0yQuzJl+7nAo4SUM4laukIpgBNIU5mgcUz6o/ihZnr144Lr2TFEiP/bQ==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr104786959wml.90.1564437496783;
        Mon, 29 Jul 2019 14:58:16 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:16 -0700 (PDT)
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
Subject: [PATCHv5 12/37] timerfd: Make timerfd_settime() time namespace aware
Date:   Mon, 29 Jul 2019 22:56:54 +0100
Message-Id: <20190729215758.28405-13-dima@arista.com>
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

timerfd_settime() accepts an absolute value of the experation time if
TFD_TIMER_ABSTIME is specified. This value is in task's time namespace
and has to be converted to the host's time namespace.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 6a6fc8aa1de7..9b0c2f65e7e8 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/rcupdate.h>
+#include <linux/time_namespace.h>
 
 struct timerfd_ctx {
 	union {
@@ -196,6 +197,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
 	}
 
 	if (texp != 0) {
+		if (flags & TFD_TIMER_ABSTIME)
+			texp = timens_ktime_to_host(clockid, texp);
 		if (isalarm(ctx)) {
 			if (flags & TFD_TIMER_ABSTIME)
 				alarm_start(&ctx->t.alarm, texp);
-- 
2.22.0

