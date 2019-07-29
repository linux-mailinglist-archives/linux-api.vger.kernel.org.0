Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A0179BDD
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfG2V7k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:59:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33300 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfG2V7G (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:59:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so63570755wru.0
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhPhiPaFDmP+L0m96dR9tEY4UhLjSpCkVC6HHYt2zds=;
        b=DZBkV0+s+TtseOsPpPa66AkmOte80A27CebUVQt23cgBLUj7apYI4zrxp0Sbug2gif
         //MRIfm5sL0j/FVbTC7rbgIa4R5I0+HRzrGzxh+DlbxNmUchfE60lw4t6gqEGnqcVc4R
         4LUf3FsO7RlZaLTJvl77VMV9P3+NiVy/1IRwfv+YobIhNuD+B+AeoAv0G3sYLaWu153g
         dbu+oVWssTYH9Riqhgwyg0U2jc4jNf5hapgaMVGBT7AU1HLrm0Ataq7zxDKyGh00YXw0
         LkJ5P5Top9pCmw7+MGyB9RqocGV5mVG3bayONdLdgFvKwx8+IIIcFBkKdGxtJ27DXiDp
         9xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhPhiPaFDmP+L0m96dR9tEY4UhLjSpCkVC6HHYt2zds=;
        b=uWDr4DSwfrgo3zjaAdpjKE5HpGvwtCqd/faLFrdcYvKBXb3h0cseF6x6xtBDdFg8Sp
         6oT1A93Lze7vRUYsvgGnTNUEcqf63v+JoyAU5CxagArLwB/VETycCc9XgnRcuF2H5y9R
         OBjBtOagbGkpUvgCOskP7wvc5uYatdMw94HraZviE1/kxeEMzZIOyqz5RuNLTg1Lpdii
         VBt4h5ABeI/RpFcA/8Doh28XsG+F8qAyvZbcxjO1hmQzoQnRm/M1CB7AEU8ydDeSD5t1
         fP6XnG34gIuQMQlA0BoOkIs8RswLlIGWrXT8T2+Rmrd2UE5XPrtNXaV01E8nMMGgWJi9
         VXJQ==
X-Gm-Message-State: APjAAAXzE6s2VRu3EpcyI9lNhFCkSJE+Hkt9CSpbEhe9wfOLyT/+1nV2
        zvAtMvK0GpqfaXfQFXron03APH897kk3RbYszEgCspH8M+riheO/GfpPO+MOfo/VILMyKuVsovD
        34yA2m5RGnF0Zz3LFltrzqF7LfGzPprkUQIbvj9kxCpEiD6BlAsvGjVyRj2ineqzzZVqBqOXIna
        HrAvjT64aVadBKs7Q9xd2RKK939Q==
X-Google-Smtp-Source: APXvYqxP9V4UaBxfz++Yj6H9Zuz5qnwSOuUggElyn8aw0CKHIw611jJNheWFqH4OjW0SEHoD8FiQIw==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr103004551wrj.352.1564437544418;
        Mon, 29 Jul 2019 14:59:04 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:03 -0700 (PDT)
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
Subject: [PATCHv5 08/37] posix-timers: Use clock_get_ktime() in common_timer_get()
Date:   Mon, 29 Jul 2019 22:57:28 +0100
Message-Id: <20190729215758.28405-47-dima@arista.com>
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
index fb1848c84241..aae7ab53790d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -666,7 +666,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
 	const struct k_clock *kc = timr->kclock;
 	ktime_t now, remaining, iv;
-	struct timespec64 ts64;
 	bool sig_none;
 
 	sig_none = timr->it_sigev_notify == SIGEV_NONE;
@@ -684,12 +683,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
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
2.22.0

