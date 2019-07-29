Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1979C00
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfG2V6W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39769 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfG2V6V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so10301915wrt.6
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpN4brfsFhqwubDyI7j+QXBI+7qrgWnZwpT+Z0DqDOU=;
        b=hq5GFBDv8gKlWCOZgFvZijCGjFdVa+5kRtXJPCuuDUazpPX2TW1CGRxQnY19ULONwY
         tc/TXErNAxf2iVv3zG/MKepJUvaOAnkvez5PIQVunL0eVYFmjDTfcK/jS6Rm7cviveUa
         Bg95CkoxsFTPzcwdswqcT2lMLiiumVUGC8Q2VGapzPp9GSagqK7j+I95y312yijfZ6mw
         8TarYxGfbMvIVkELoLNRLmkn9pNYQC6e9Rj71fVpa2BOoYt73gNK2qoSzp+wh7owtE2Q
         FeT5GqY/Toku76pD5myhCpV6rzp/WdgF4FlFhmceMCGNGNigNeVeb4Rq/JPKrkE1M+5B
         li2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpN4brfsFhqwubDyI7j+QXBI+7qrgWnZwpT+Z0DqDOU=;
        b=nZ/Q7w0HBX4whHU+ZJSYfhi/pmf0UJV71CzSUxNyQF/oI2Vu1g7K59W6rke1JuqvKX
         SfAMyrPf5I6M1Hzyx6WZ3hd8fsmHB5f0oe0er8UUC5t2TdJKZolPCNu1uMmFSF+dNGjk
         0f9muZ4XLExXI7ntcYuJGerVrWnKJf6i5gmFdMnTiMJ74zOpofwDMr4i92/BUqIrm2za
         eo/pct3EC8MWZqdDfOW0L7vm60GoWX1Mr+7QAtQlaZmJEzgY3pgauJjxRYkyiDd8qQ2d
         W0kNItPLjQ1WHDiEy1tujZlSlL957ZAHUQKxIUdXwKQAWoJ8dUhp8duq5soKkighAQ4c
         Wzdw==
X-Gm-Message-State: APjAAAXOxpfU5n89fjVVHKEH/ogt9cSQn5IJVHlYwJjxV+SywaXFLnGM
        cjrru9dUflJU9I0WpbYTKOIP5+BYzWNXRtlVdV3JHjHWFL7e7bJx8IfVbt+ukwHbyQr6BEGooZr
        OjZy2UaGWKk+g0WAVzRsUGzaxY3Sby4yQX7qMhfXpyefnPOS4hBVvVYeCYK64S1P+5XM0mcKuS5
        FjzTB5dmxcsGScusVHiweRr0DFyw==
X-Google-Smtp-Source: APXvYqzx2nhcz1wHcMzK3Sptq3VSfBLgqvF7rAr/cPc/sQqamObOo58CXfcaEodYjLiKY52daB4ivA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr5392205wro.307.1564437499523;
        Mon, 29 Jul 2019 14:58:19 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:18 -0700 (PDT)
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
Subject: [PATCHv5 14/37] alarmtimer: Make nanosleep time namespace aware
Date:   Mon, 29 Jul 2019 22:56:56 +0100
Message-Id: <20190729215758.28405-15-dima@arista.com>
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
index b1e82bb6cc6b..f21c743f6ede 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -825,6 +825,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
-- 
2.22.0

