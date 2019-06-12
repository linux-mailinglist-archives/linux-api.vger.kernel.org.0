Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2DE42FE5
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfFLT0n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54909 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfFLT0m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so7717759wme.4
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rK/lNTew08hzz7HVO7HvkTGvRJb6fOU+pbsMF8QlYRY=;
        b=aFtV8t1b278IHm3Tle4YnOGl7ZnK+s1pPy/zaNTpl/YFd+aL6V1fYPPIyDUVhWY926
         4ksmAVHcMULbDG00EA3OWsI2r6GnIPIsrNBZtQMauBSeHdm9lGomOuHjQTja9q+4zxMM
         iHhS2KQcTy75D9DPSp/E354oiiAPJADqm8D5x8NrRHmGKGmJLtJ92U80BkWc8dfYFZIv
         9G9YeMXBTcwNOwr9rGVMO489UssFOusGfOvD6CJzGMl5WJk52RC1FHcuHvgYsO+jCnuB
         HnxJjsRiXRVERfxu+EosyhbRZyBw9UAaJDNQwAIry2AORYsKXdq47vc0P06BWmqP6h0q
         IlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rK/lNTew08hzz7HVO7HvkTGvRJb6fOU+pbsMF8QlYRY=;
        b=bxj+WeJcTEa+WFiPRb+kP9sQL2F7TQrAVs0BoJ5h1IN3ScZJFmgCWe02NwvLEsNU+R
         IaJ3LIZM09xNtxIjhJchprEo9a2rg2oYHwMaE3ilkYYzU7JlHYUo4jTFpjBbH/aNrFQh
         vmNRfravJYdMy4JT97vdGKXQkvqQ7IULK5kMddEwrs2mjPaixNyHF8bQUr4dRXfC4Hge
         NgmzQ55Q3jqTsinlJwPrNQgQOG+FrkzbwLqzXedbtAJ9EDKIlXip0nNWqEmd6XyBlw2g
         BGO4lK1gxHNF8wNTe1QO+ocxb+7DelOTGIPbIYd3lif4ehl9N6F4A5rIhdsXEm7avPNv
         2fOQ==
X-Gm-Message-State: APjAAAW6JQk3C4e1q2XpjmvcpVrL+3DkvVpo4K91mRmR3zIaD3ahbe7V
        dURkfHArAWg7MgwdzWEbvtxLZQ==
X-Google-Smtp-Source: APXvYqzMfQUFZfq6v52zu5p5+HWuQccYeU0xiKemwObMzGtIL/qvtSAsDP2TF2j5l7+IuCaOaBCqFg==
X-Received: by 2002:a1c:1bc9:: with SMTP id b192mr531803wmb.152.1560367600141;
        Wed, 12 Jun 2019 12:26:40 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:39 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 07/28] posix-timers/timens: Take into account clock offsets
Date:   Wed, 12 Jun 2019 20:26:06 +0100
Message-Id: <20190612192628.23797-8-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire timer_settime() syscall into time namespace virtualization.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 573942ae2629..dba77ee48e74 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -857,6 +857,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-- 
2.22.0

