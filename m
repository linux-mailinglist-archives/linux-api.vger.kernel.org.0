Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD079BFB
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbfG2V6P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43635 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389200AbfG2V6N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so63435025wru.10
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhPhiPaFDmP+L0m96dR9tEY4UhLjSpCkVC6HHYt2zds=;
        b=Bzxe9fv+Gz9B6U6SUD29DrXP1PQacwElm6trKex2rmrhyk1ecXwic4zCCCkdnAzAPt
         RijKROc66z96BoZXqqRukc8FohDP7DRbkAkgGcOSCWPMRwWi5CODxc2hciZQxNAByw8v
         JbF7/dC9laMqSlnJChBeNExlDSvj/VJPcC+LF017UUgY16fCbvaPHSH7HV69CPbLZjC7
         Ng6lxt19dY/6UzEdL4UE+OdONBMxN8SFiLhpS69++vrmWmoz/dEog0uddCKVW+3XIH7u
         DnrCaf1A99Xz+36wIhMyqMSbeC4i3g+Ub5Eev8nq3aK21RdkF5huE7347qRtTrOaZriI
         EGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhPhiPaFDmP+L0m96dR9tEY4UhLjSpCkVC6HHYt2zds=;
        b=HPd4aoAiIwkPm6C8aIOu+l8lrjfC85uJCAdbfqMKcm53XgT4u1hNGoIfN2F21t9b/E
         a12lH4y9AC8ok8xrN8JwaEA1lFUIgBvCDPSUzWctPGsJLT8u60fkRYZZvvunoG6DCX3e
         SjTqradiEwu9H3TBBiK0trkIirhZ5lLi2IBdeuEW3Cr61VcnRbl1S2JzHccedQKSOLwh
         TBikKaYtKkjRrOP1IgMZpiV2G2zil1A0AU1cEZ42AsdMlHwIif4G+avEbYrIEr07SBmQ
         H5MXTWypRGp+Ak0xjRzb8K3vfpYhQTQZrhuCtFRs3bma0aqPCq1H5bDknO5bDkLXU9a+
         l9aA==
X-Gm-Message-State: APjAAAXpB+lJzhHXKLcUBjy722gopkiO6s2k3rHKUBKaSOfrJJ6SpUlz
        /AtWBqjF2NXgnSMv1R43jttOeuQNoHrAog7ZDImYn37w4CvLQZXyQpcW/kmiX43oPX94btNEFjL
        Jr9gJqQqau2g9tklzgT/TQrT0qkSc7PY65cagIuiMEw7MnrbpvWlPdab4RBhUYkptf5QJ1he2Ed
        ZaMrRuXsB8hecLKer+XAtrpm2cdA==
X-Google-Smtp-Source: APXvYqwT7Ntey25cXNcYdTP4MtDlylpRRIJQkyoXQeD7IX6ZyEkezqaNJ64y7V8W26u5fHbiS/ObuQ==
X-Received: by 2002:adf:db46:: with SMTP id f6mr71646636wrj.212.1564437491336;
        Mon, 29 Jul 2019 14:58:11 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:10 -0700 (PDT)
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
Date:   Mon, 29 Jul 2019 22:56:50 +0100
Message-Id: <20190729215758.28405-9-dima@arista.com>
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

