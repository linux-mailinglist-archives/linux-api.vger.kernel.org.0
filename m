Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B4BF861A
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKLB1u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:27:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34278 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfKLB1r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id j18so1133814wmk.1
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wrQtjXDEBeON+m5MSXDh9cF0WDhw/kV9ECREUgT5Nw=;
        b=HpyA0Fu7VObS4pFdF0w5PKswz+ASrhMXARZhXFS8aFB7Ktth5sbD+npAl+dNsJqy7R
         jKUezDaDypsdDgxDMBQ5Mez/s+jY9jkKVltxp8OTKH+g7T1I6vfhuxDNsu/VXgeWZ+Pd
         /lFV+OU3gYS/elTU7kHxzKShhOwXPG1CuPP7x+c6Snv9taHX0TzRiOUOWLbVBFCZQs61
         RUrouCwWonA8oGNqeYlTof0nSbL432XL38o35947PCgcY11E0g5n+0aaxlJMrRSYg2qA
         1eL8kHjN6JY8ZWVg0hUpmsRFPDXYrXphjEEM7UtrA3HLhDo91o0IccULk5cHaglPCBHq
         ZsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wrQtjXDEBeON+m5MSXDh9cF0WDhw/kV9ECREUgT5Nw=;
        b=ROZpbRKxYE4NhsDP8JCKp3wFAPxLnQaTQx9JBA2MwZ0tNNSlN5Zqh82gLhj8jkzPwb
         CPDsAwVYapEPDpyzAZDv8RtYoVt7jYsQJ5NkNL2We8BCtENAihvPnPyHyoqZylpQATmM
         IC/0hwCECt0+e+aMSCTUjA1xh3PflB6YACR06IXqO+ceEPgEuMlkYUnHVBauXKkcQP96
         RwqnIvT330xEi1+rpLsjSeUPq75D0G5xmPapKfuzt7kaqNkZO35Z5UwHPHvK0WoRyBQw
         zWXLk9nNetstNRQUSfJ9RBODFHLlKPqEnyidHCjE3reE3gB5XQ01bDTyVHGO6Sgl80EB
         Z+WQ==
X-Gm-Message-State: APjAAAUfy5YWORHc3yeMQUjvB70cviBD2PLVs6nDuEdhxeB0eH+hqYlT
        WfCa3gQBV7T98TqAIxc2pIrexw==
X-Google-Smtp-Source: APXvYqziaq4ziAfk8Dj9CBFCHlKWzX7CbywDJaQ72UNLms0rRz/i073D5fK54qGu4DVsyTrF/XhI5g==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr1495575wmc.54.1573522065138;
        Mon, 11 Nov 2019 17:27:45 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:44 -0800 (PST)
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
Subject: [PATCHv8 10/34] posix-timers: Use clock_get_ktime() in common_timer_get()
Date:   Tue, 12 Nov 2019 01:26:59 +0000
Message-Id: <20191112012724.250792-11-dima@arista.com>
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

Now, when the clock_get_ktime() callback exists, the suboptimal
timespec64-based conversion can be removed from common_timer_get().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a1f6b968c5d8..fe1de4f71ace 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -665,7 +665,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
 	const struct k_clock *kc = timr->kclock;
 	ktime_t now, remaining, iv;
-	struct timespec64 ts64;
 	bool sig_none;
 
 	sig_none = timr->it_sigev_notify == SIGEV_NONE;
@@ -683,12 +682,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 			return;
 	}
 
-	/*
-	 * The timespec64 based conversion is suboptimal, but it's not
-	 * worth to implement yet another callback.
-	 */
-	kc->clock_get_timespec(timr->it_clock, &ts64);
-	now = timespec64_to_ktime(ts64);
+	now = kc->clock_get_ktime(timr->it_clock);
 
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer move the
-- 
2.24.0

