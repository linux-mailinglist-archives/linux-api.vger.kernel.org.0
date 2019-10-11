Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDD2D36F1
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfJKBYI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:24:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40747 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfJKBYH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so8515916wmj.5
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHSEhkeZHrF4YnSZBbhjOsPK+/ZOK5PIZldKE1yA3yU=;
        b=ojryX8Tmedwh13u7x6kVjloRS4/c5+zsU/uoxh9RMb5T1eHmaPX0A871xdwpXVMMwh
         kJugIEClpXmF7C+te52g44e97ouqdy9BiImAz2UT1bLch0uuBTk1iN/L/ZTK3cv+46KG
         UnQ9bSSCOxxB0TISAQCoL23zOLgjQXjeXRR3UP+FIQ6R65TUyvV/9MjDqgLC4ENwLr2A
         b0dCU61xgTLHOKXsxraOJD1+t8d3U4kJbdWOrC4VB16hBs1VLebA7583zNDhmcZIVbxd
         uFtKg8l58+eMfdZRXDSsmxL+gFZ0voA2ONabt1vu/zEkBZoVm0pTMqqQx8qceH2nwAfg
         sD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHSEhkeZHrF4YnSZBbhjOsPK+/ZOK5PIZldKE1yA3yU=;
        b=PosmbTubBVYN1CySERcMUgq1F0iBztOSdSMMa9QOlT3KDK3aEbuLLQx5ZUBucDdPp4
         P5rmDLFrpp0VPZObLPhKUmINepwisiRnOwYs9TOIoVqNsRVYibUWr+NKq9bXd/ABInnI
         OK4JPK2TFK8bR3eI7tzrcc77OU/iAxuADHljKBdpu/s0bbFOXeJrkPa/n4Dx+uzz0n62
         OYTbM1hWtl1Ewvv42sf0aKXJVriDLhv9qbnt904aJjw2p/8avTLUumaHesjbWIoIURNw
         nxS6budsABg1TCjr4+vz2zKbhOtverUX+B6JyMivVvFQtPGfd+yB7MWzZNDLG5TLvkKS
         fFdA==
X-Gm-Message-State: APjAAAUeMB4pqBMmXr9lQ655nKTUojV2VU4Z0zh5xisbndkfHVhwsfaZ
        N/Li2U9/qxMMJPSLHKcCaMDHBA==
X-Google-Smtp-Source: APXvYqxWJi7fDJSE2gWmNMxPyQep3RDnWZ63fbIYeaBrueIf47smyXLukgcK2ZwNPOOh+XHJuLZP9w==
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr954428wme.152.1570757044887;
        Thu, 10 Oct 2019 18:24:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:04 -0700 (PDT)
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
Subject: [PATCHv7 13/33] alarmtimer: Make nanosleep time namespace aware
Date:   Fri, 11 Oct 2019 02:23:21 +0100
Message-Id: <20191011012341.846266-14-dima@arista.com>
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
index c326427bb4cb..353e46f9acc2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -838,6 +838,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
-- 
2.23.0

