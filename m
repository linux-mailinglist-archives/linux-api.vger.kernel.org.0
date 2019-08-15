Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACF8F0C2
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbfHOQiv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:38:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39382 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbfHOQiv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:38:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so2765074wra.6
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J743gudYC+Vn0u6LFT/hGGfOPXqCgEVpEzbH7ikqtlc=;
        b=PmvTH0jTZioACPR8TLF4RLdGr8hsN9S3wm1uZBZgK/CPxYnyzPrbJzBzV/oywIy8le
         inH1FU9V0aEsqnma/OG+5qYn1T6wan2/dxfRDHBhlK17dUvXwu1RgbMrz7IM6D2D8OYE
         nxs9PPhKDttFulLE5Nct3kpHiVYHUX1TFU3WHFz3sbgGgzdWubUI1J999Os87ZTvffGB
         LaDfdZeIQX/I7QGxTOpuP4fyNEpluBZld5L38HZ83jDuFhsM+vCkjvEZNR1H5Plilxtv
         TK2FAVKUfnQsUBl7GFcqwAwqaQDBWsPhlSmDKDKcv2nf2GXz4s3Dc2fAa2hJdWy4Jgm7
         kN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J743gudYC+Vn0u6LFT/hGGfOPXqCgEVpEzbH7ikqtlc=;
        b=rdwkUK8DCq5Hb8D3C3KORm/FxGjPT+bvWz6OSYW4Xn8fZ7gbph78ZdnGaWyKAlXdOK
         GpzkftQ5NVjKaqpLPMupbRSOjErUQz6qVD4Kglj++zW96FEfY+mJGpc4d1UsQftsOeDk
         69xvjd/hNKd9ELsX5wp06L3zjzBfMmh/DLlHgR8q6gW32ExSSEWgJs77c+l/QSfMzqHF
         CgDplHYE+P6CpKo752tDt3x/EdZltytepjdXS4BOMtQfQlYJnNSgkFWsPEFJmxVIw7dg
         yS7F37hGnxHbSUOfou9FrfMijBaMFz+ERgADSX7L1amVjrnjpPUtROAWja4HC/5crpjY
         w/xg==
X-Gm-Message-State: APjAAAWgzXhY2HdVGtrCC1pDXDTBDni842TsrLNw4hGfdvypY++lIv05
        pxiK8FGmrmn1UXMNrdLS67cqIg==
X-Google-Smtp-Source: APXvYqxo2dhJ4dxROiCqUivIZNZiye2m3qyZsjYKYmzxlk4cAMMv2V2AYyOqit2iiBO1KQ8manTfDw==
X-Received: by 2002:adf:8541:: with SMTP id 59mr6368785wrh.298.1565887129651;
        Thu, 15 Aug 2019 09:38:49 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:49 -0700 (PDT)
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
Subject: [PATCHv6 08/36] posix-timers: Use clock_get_ktime() in common_timer_get()
Date:   Thu, 15 Aug 2019 17:38:08 +0100
Message-Id: <20190815163836.2927-9-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
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
index 7cf1216050d1..1d41c6a41d63 100644
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
2.22.0

