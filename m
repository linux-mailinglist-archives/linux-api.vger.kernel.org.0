Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06F1D372A
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfJKBZl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:25:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54874 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfJKBYA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so8695542wmp.4
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6h5ltuzBzsMDnujDaOCl6FgyEGnILVHlkhd54q6wqWU=;
        b=Hk5W1A9oh9bfJB2PEdRb9fVDucanzYe/zlbcpnRx+bUkycxFFkN1qlqPKp69htKOk3
         w5o8L0jsWzx3ugER/6GpUvnz5wWZlQ0b8jKiUfMVQVDkfsu49LXnbw7hpJKHuhtYb20m
         5fAZIbcSiCQC74zZr79KSsCW+T+PdKsIk/McjOGOTg4r/IYsdb0NvRLQ83ZbQnGhJ7gf
         wbjtgpE3L5jMwssh6hOLilvxZkvWFKIBN8CWfnZmg7OT9lLJlJjsBMpLt25lhQEz0Aze
         aIR3kjcXERAQUT58DQUgf9DZHSW0T3Vm/erhVF7dXTTH5RD4/Nk48ALoBdfcdY3Rs+ps
         KSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6h5ltuzBzsMDnujDaOCl6FgyEGnILVHlkhd54q6wqWU=;
        b=DxVUmWxtGoIkxIeL83G93GxG+M0atf8hW8OMiQzgFfkqoQVtHUW19KH8nePxvrdKpm
         NYrt+6a5HPxZK1DBLk8ZVRgJrB/8Cw2Uk9elSsTIqAgXS0UEuujCtSN/7wOw1YGNu1IO
         BHlRDzqfte6p3vky2arlvp8RIC4brG3YGUClp2yQc1JBEn751Wain7xaqkBfQcQ/VwZL
         Ts4mTv+QHcqjoOKovkzxN6ZTced9YVkWcCxwc40dW66VPvEIWTV/XXg0YLHFrHsgxGet
         Q/SRvjLu2cm0K86NYDon0202a5VSguN9YhexlvRWVvXS7TW/2boG0v6mVN6tizdUQW2w
         WTyw==
X-Gm-Message-State: APjAAAWf2L2wFY7DjIQCVl7MPEefmAlD46IpPyvKnUJc+tWVI9psL7jk
        bSqoHlqAl8bSeANlr+Zd/cIyDQ==
X-Google-Smtp-Source: APXvYqyeUSuqG7UOQunyB2Zu8R5Vl1iifySulgzKwEfZOlOoPJ2n2X4U1h0k+YjIrhR23R0xVs3Elg==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr935644wms.168.1570757037346;
        Thu, 10 Oct 2019 18:23:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:56 -0700 (PDT)
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
Subject: [PATCHv7 08/33] posix-timers: Use clock_get_ktime() in common_timer_get()
Date:   Fri, 11 Oct 2019 02:23:16 +0100
Message-Id: <20191011012341.846266-9-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
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
index 1d7329e8425f..47a8d43fe1c6 100644
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
2.23.0

