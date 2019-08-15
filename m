Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9208F101
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbfHOQi5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:38:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32936 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbfHOQi5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:38:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id p77so1364431wme.0
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ETIHkSYMAOTDNEv7fS406d0qKzuQO+5fSqFounTdnk=;
        b=cc+gNkYnBv6B6XgW4uSgGPyvgmVCpjrafee8/9+P5gekuQ+nQt9wj2EqZkRI/e/HiO
         CcwZq1z99OhGgCEvdUwHJQbgJtqjjYk3kmkausc3QaZ3dB42TqqqFd90zlPimVhIbrQC
         lcQjxqmXo5KzcjKfzzU4YuN0CWuLugpkplCCqSFCaLo72+KyGEDp0UJ+Nkr92ORWzkd9
         s4roICH0YWvl5Zxx1knPXHsCq9AUgRy7+RX2qILG7YBLKKEjB9iOpulCwUWYXx24Wdxa
         r6ftr0uRU6AJkY2nvKKfxHutO3pi00jHMI/2ugbR4mP4waeRZ0Hs6pfAil570mggyM4R
         vG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ETIHkSYMAOTDNEv7fS406d0qKzuQO+5fSqFounTdnk=;
        b=JsIl1SuyizamD+bHhbzlC1L5PHYNepnj37dZMNvOo06oc1ZlFMvz2zlVKetx7KvgUV
         RC0qc0OvuXw3pXfldOt2W4c5b4Zvsd5FwTO/JIikoH4zdnO7kyb4hghUKrnEU2rstyvi
         qdKY8jBsJydcLAyy3cFieSztwIIaWSBkT4E1FP0eXIKqzwxmSHXCcytw1SdhxxVjpzha
         CNYSwFkN/5lcjJ3gKOxXHT0+zdo5JFPucAIbJx/OFK4RCBcFyNqwKhcRGlY58RRYYLGU
         s6QEeBjrLZEOZHTAQ8q+MJ0VsmcmtK1MofgYLyOInby/BRcdpxAIYjfdjFy356OfYNL1
         P43Q==
X-Gm-Message-State: APjAAAVeBWfpKuy1SOOM04LxBaR7IHxIUKDL3j/RcK7AogLEE8TP49Ul
        Sdzt2lW6bcII2IV39Bp0zJnymQ==
X-Google-Smtp-Source: APXvYqzjAXxM6yXzyjOSjV/E5M0xSHs0/yjywHKPTIFJhx1NmnggfHCdfn1KSAMIXLqWUC1RxJIu6A==
X-Received: by 2002:a1c:988a:: with SMTP id a132mr3513182wme.165.1565887135746;
        Thu, 15 Aug 2019 09:38:55 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:55 -0700 (PDT)
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
Subject: [PATCHv6 12/36] posix-timers: Make timer_settime() time namespace aware
Date:   Thu, 15 Aug 2019 17:38:12 +0100
Message-Id: <20190815163836.2927-13-dima@arista.com>
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
index 365ac40d46b1..1f30e3ef0918 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -891,6 +891,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-- 
2.22.0

