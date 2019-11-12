Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD974F863F
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKLB1y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:27:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33653 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfKLB1x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so9882608wrr.0
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1znNAGw/Z1q6zMts4RvOzjAIKcNOTR5cC9VZjL6t0T4=;
        b=no7ak0lp9bxnBWXhC4+Tx+Ld3kfGjWGcwqMxHG6k1Jesn3stq1RTFYQvubLhKR8H4P
         M9YDX9NrHZhKHxHF1s2VvzBK5lBOzfFycGG7oxUSFBJXYHfxyV+76234bOF16UmArQEM
         GYENaeByzCN5GCGPTvEISHJgxSpMgeA8mpVALKx6yDLmfILABsljASkq0qXrVazyHDW/
         Wg5tmh51mW9+xE3rV6a/8f4QVhrQObsWvsmgnUi1CXQOlF3t3WvSSJQU/SUtyAEjfnLU
         yCVCVBUq4QPtwdF5vl8XANMH/2WyZG9X1r/doDnXU5Iv006YwcXzRa9JOWihNlRCwOTK
         iGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1znNAGw/Z1q6zMts4RvOzjAIKcNOTR5cC9VZjL6t0T4=;
        b=TnwsWVcs0ccpcXKrPbGUus7gKmVDLS/0bM53JIHX6QhAYr2pcPkU4pDY8+ifcYW+av
         Cp5Um/0TG4VSPLNQzZPcl33knTNVmLDXKABg5UEpbK0qHmEFVikN6PpCCaUvf7icu3yg
         8oi53309eYS6iTaHUQR1pXE6C+VfaGR5SKopZppZ9zngQxZWNRyMD6rhcds+zJCzD8zf
         D2/NCSkK5An8I0gH0n8pHsyImxHmkDDq3myLF8Fe/+NrwiwN1xWvbYMfAK3TI0K4AH1G
         JBeoKd/EEUahpynbNJ32a750V9QoWz6Q1Fbkyz4msuHiVAwikViqvLUKLUSjGMl4+5EM
         6Kmw==
X-Gm-Message-State: APjAAAWcg930iGaxSn6hu3hIRYlReaa3CEjCWs2/mq9qaHAjKndkzRf2
        63FxLC+zUWr5shXBq2N79G2nbw==
X-Google-Smtp-Source: APXvYqw1sQ5638emNp4oXahicRk566L49rP3h7hLu+1ZakVzvyAqS3EF8A2tV4rgYhA06BYSYjrp7w==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr24275641wrr.72.1573522071918;
        Mon, 11 Nov 2019 17:27:51 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:51 -0800 (PST)
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
Subject: [PATCHv8 15/34] alarmtimer: Make nanosleep time namespace aware
Date:   Tue, 12 Nov 2019 01:27:04 +0000
Message-Id: <20191112012724.250792-16-dima@arista.com>
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

clock_nanosleep() accepts absolute values of expiration time when
TIMER_ABSTIME flag is set. This absolute value is inside the task's
time namespace, and has to be converted to the host's time.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 9a8e81bc4ec2..b51b36e533c4 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -839,6 +839,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
-- 
2.24.0

