Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0067F861C
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKLB1y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:27:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55445 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfKLB1x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so1278526wmb.5
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBdLYJdhjeFT5w6s0m0U5Bo50muPeSkrn41Bj/OgNzU=;
        b=Pki/A7gikh7SOzuzY9xY1WmR5BVkRnRJkPpCiLW3ZBTdz1AO8TfPMEABrrbko7vpZ0
         nx1KWMSlCNsK9ABxXGzNEKs/BMfxok/Y4JQ5THAhur3SWePd23N9ddaVTNL0SufASqNM
         aUi1P+fbMz06GB1aaAMKQAEMCXd0Lj0V0clQFEZKklv0zrvp9MxolF1cpHC+YbZmMjQx
         UCGYOGtMab6yZ1VuSbJz82YnYu3ewMUX592H7yeY4A3cTgtcagwJHx0TxkQUlOEcXQso
         Y9l4GZSrUlyezIAy9EUA9r2oqQv5rJswnevUXtlnLCYLI1DCR9OyQ62FlKRxfIF3Eltq
         NdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBdLYJdhjeFT5w6s0m0U5Bo50muPeSkrn41Bj/OgNzU=;
        b=OgEPdM8GM8lNPxD10QoREiCg5leGCcy0i1b9XhLiS47M8ed+mKidzRn8iBBa8LE4r5
         /GDIFc59V84rm3uviAdmiO1G96rgE4wlJoIUhv85qAPYkq9RyELAylu/y59Mg41UJ2le
         rVxYW+3yTRksR41H+OeqzMs3k3mhpuGMD23cXTXJC/oQCe+LFXboW+kfdZcMd3xnzoF0
         QBNdIUn/okbzYuWJ6cPLYHiklUfOjst4DtUr+ExMiz3y4rZYDasrcHTumkD6Xs3lzBC6
         wWMu/twXSlbJNGxs+H8nJRSyfjOSkq+Ac6kDtU8lP5fEfleUhHkpWIX9imbtjyInR0xO
         RDbA==
X-Gm-Message-State: APjAAAVGazu2/sdkvLli/I/ty36KMRnyX4us5XObst6oo85XOC4qwPL6
        cOSqKIdJe93OAKyQAoeUnm8BqQ==
X-Google-Smtp-Source: APXvYqz3Y1ZxljDDH+9AJcIgAzsfMqPySbX9a/6ixpOXwB//28V58jMYIKISZ2Ag1RcsS4He9XRvrQ==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr1525920wma.12.1573522070554;
        Mon, 11 Nov 2019 17:27:50 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:50 -0800 (PST)
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
Subject: [PATCHv8 14/34] posix-timers: Make timer_settime() time namespace aware
Date:   Tue, 12 Nov 2019 01:27:03 +0000
Message-Id: <20191112012724.250792-15-dima@arista.com>
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

Wire timer_settime() syscall into time namespace virtualization.

sys_timer_settime() calls the ktime->timer_set() callback. Right now,
common_timer_set() is the only implementation for the callback.

There user-supplied timer's value is converted from timespec64 to ktime
and then timens_ktime_to_host() can be used to convert namespace's time
to the host time.

Inside a time namespace kernel's time differ on a fixed offset from
a user-supplied, but only absolute values (TIMER_ABSTIME) must
be converted.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d26b915b227a..473082b0b57f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -885,6 +885,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-- 
2.24.0

