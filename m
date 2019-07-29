Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF079BFF
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfG2V6U (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44338 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfG2V6T (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so63447178wrf.11
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aoCU6uPiHr0PzNNlgylsAXV9auaD7Fl9k+QB3VPTwmU=;
        b=ON4VHzES+B/jfG7vTOtWjSgEGPQD0zrGmt6jz5giNgVQbhqIMvOUOlN1gM3JzvUWe/
         IGqMM+pYFQ78AaNJ9Hsa3w8YxDkSggEmShReMrE3WotwdxfcPAHGELp2Z80/g0iLM77/
         wSrKM5XBdZ0uxHW/6eMOUBRWn4YeC1ab6BgVoHXwqx6I49mzpZhSVuqq8m2vv9SLoTO6
         zr0MsayJMMyNQ/5pc+UiVp3rjnytJIvrcPhuzdNWyij3bZpks8ed8L+PMhy3b2ZVWCBV
         3bIC8zze+cAte15hHO5VIBL434b7TtsT9s2GJyYaNewFiy9I3KpZdy/hUdSh2TWmy0Bk
         lTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aoCU6uPiHr0PzNNlgylsAXV9auaD7Fl9k+QB3VPTwmU=;
        b=Fh5OZXXbAEyF+/NIu9VfTYhwPhHEFKBi4y75q8FwBnEYGbNAr2vVuymKWQIQ71EsC8
         W3Vx/v7/ISFkuGzmKTqhJ64OGvN6XxDeWYvZGbbH9gb13XHr4FTc59jhF6eWy2OOuWEM
         rtm7Hy6Mw/XFsHnCIfg8ZZg4fxTrj33b2NaOHSufKHis+L8NScmg+NoBkr3Z8wz7KNfi
         d15EIAcy0RxprNiCgP0/Qt6bSRQcDka7MWb6k9lstQPnZ4zX3szzKgdRO15YZT3j/OWR
         N7mP74ftAG+FI38rDiGNWQ8HGhqi6BckLzRXmTONx1CrUSJsCTosSksHBdEG7oZrVr5r
         3YVg==
X-Gm-Message-State: APjAAAWfGAYRrRzPiDBD8FxHXIxQLfJuiIUNOznGvxtqjedBpVI8VcUT
        tmaJkDxIHs8atUfpof5O47c/dOeMVVw2Jy8dpDzP7ihHUoHBur6zsiKaberEF1o6l6RUTZN8vZW
        QtMAUM3abZM7BfvXpIhTDlh/Y+qnMX/XdyUDXGmcryKZJAkevaGS6tvgq+N10IsIA0lHOo+q7I2
        ojofeiCyPtWNCW3PfizudggJK8GA==
X-Google-Smtp-Source: APXvYqy/FnJSSgTdo+YzH4zB+N6B3pvg4EGHaqm2wFVzFyIWkxDAQd6vkEhzCcSp8QPncdlXdQc8TA==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr19690168wrs.136.1564437498092;
        Mon, 29 Jul 2019 14:58:18 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:17 -0700 (PDT)
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
Subject: [PATCHv5 13/37] posix-timers: Make timer_settime() time namespace aware
Date:   Mon, 29 Jul 2019 22:56:55 +0100
Message-Id: <20190729215758.28405-14-dima@arista.com>
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
index 265fbc816520..c979e720a5a1 100644
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

