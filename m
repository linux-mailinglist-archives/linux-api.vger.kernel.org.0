Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D040F863E
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKLB1v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:27:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35352 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKLB1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so1225913wmo.0
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1nBTHy/xxCdgq9VX3BOGXRLXKQPYvIloWH+7YU/thyM=;
        b=UF4LzP8uwlLDqP+WSoW/loK7YhgAK4GYuKRO11rlEX7fRJ8mBUIE6GfkAGqAAcnNvn
         v+grtwmBc+PAOrCKJLphWdm9SmJkQ4FfCqur9ZBCJKe0/8wPe1HFjxFDG3cjRhvcnfvU
         ptYCNVgW8T/HsImr3vVD76jf59REuJ8Va+d0K152qqrlUNEWYiE8J+GGzhk9TWABHP/Y
         OSVjNDfTpR1Ca7DpmpZFmkEomtOHTChVZjyNp22iFPcL6Uvd+6QaXoSmL0+/bIXENyNN
         SOQYkSbpwrIA7COuUsn5dokpDn7sK2f5nsi82BRO5Tn998zRsvqRZjVSa2DTPudCBacG
         axrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nBTHy/xxCdgq9VX3BOGXRLXKQPYvIloWH+7YU/thyM=;
        b=BNnpicOH858p6mLTp+VaVr3myxIktiNKN1IiNXgek0LuB6b7pR4cb6yQ20PIarHFA9
         c2fakK5LDEuqoON55YgtmLvZTqWXwNg1k2ZpZO5opFECTQqMc2jdUe5zcoOMr59tHos8
         E6XPQrskggYyvNGRgaLFUyudEKSkwxy3Hf1CiD3XYmOlH8Lqys2EQZS1yMRc+o5nGfFB
         wizmMWlgC7FpxPyFVnFycDUETDvOGtlsaogEF2Mef6LWlu+1qUpYmt71+13AL+YTQL/i
         uUnXuDqxEd/wDLHnIto6NeT9uDXHj9Z0geiRu6gCn4rCEplBU4be/PVMFgji+7qTRn5a
         NghA==
X-Gm-Message-State: APjAAAU/lp4VZeZp/8xUzSHcnFFI9G06Cwgk7FETy0IYEfrhOisE4VGu
        4o2HUvibPOAa9W6QMT0+KD1AWg==
X-Google-Smtp-Source: APXvYqzRo66use8kzeT8+3JOJx8BVcg9fZNDbkUhrCd41/6tzxcHW+kS9pCEDdkXXePM+lNMjlXQFA==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr1511715wmd.104.1573522069211;
        Mon, 11 Nov 2019 17:27:49 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:48 -0800 (PST)
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
Subject: [PATCHv8 13/34] timerfd: Make timerfd_settime() time namespace aware
Date:   Tue, 12 Nov 2019 01:27:02 +0000
Message-Id: <20191112012724.250792-14-dima@arista.com>
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

timerfd_settime() accepts an absolute value of the expiration time if
TFD_TIMER_ABSTIME is specified. This value is in task's time namespace
and has to be converted to the host's time namespace.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 48305ba41e3c..f9da5752a79e 100644
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
2.24.0

