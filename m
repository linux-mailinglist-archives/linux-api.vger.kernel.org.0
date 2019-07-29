Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0379BD6
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfG2V70 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:59:26 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41740 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389450AbfG2V7M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:59:12 -0400
Received: by mail-wr1-f41.google.com with SMTP id c2so60263123wrm.8
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8TNpPfRzkd/STVPqA/OmSveOcsf2nPj4laDcq0UFS8=;
        b=XLSDH1Nz0pN5WkflENvDp7KvTw3mfOAw93+QETM26nPcTcrXiHz5NCHaZicpwAVudS
         08sGxWHWCupk5AS1eb3Mjj7DhmEKpoJ/B5/v/mrJQoV/WVL92kuuyyGGTw+xXJ2AtJo6
         wv3RjmYNrOp5Ebfu1maTC5CY+3LEOYTfdSI1CCMzXydYhNY1rlpTlQ79YydXQC2ZFYRL
         Njx7Y0qq+Y6FPL9qigsLXWF0UcXOe20NVim2m8H5Vyrz+fstXo1QuJ1i2hWsPdIqoo+6
         diIJTvcmtx7MM+RCtUfbnWf0gBI/9EBVwLyUWh51gclK3psKYLncKyeIdB92GGwUggDD
         u8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8TNpPfRzkd/STVPqA/OmSveOcsf2nPj4laDcq0UFS8=;
        b=lTTqNy9+++ln6JCCjSie+7Ai5SxKOEhzG3HImWE6C1oqWnteaw8Nnx9eHz/LuyWDEi
         rUtC4nw2v6kvr7AgJ5NixoijLs7TEZO9bFQ5/9EmYgP7S6msURc93usbI4/TEf8gTA9I
         B/tpmYcGJkneVjyI207h5/vrovl/1/Fd2dAK+eEByPyYR0xgePtt7oAJEKelEpG+dXTl
         QIa/x+3dwfEBziQRMmpgzMGvb5jBbN8l2JHJQvjPlR8N1kL+QwatWmK3Tr5QsjuHvsXg
         XzphDyYHabqbaCj/Byb/dUEq2tEJrrLaG5Wy2DzvIwyxFDF0BQ4WaoF94u5xFyBwPLOQ
         UypA==
X-Gm-Message-State: APjAAAUTlC+IaAvVZPukJOab2tQjNG9zZw0rPa52isq9iOoHWx/0zaqg
        xJn5BnVAJ/Rv255TFGjc3z+1t+aDMmiNhVKuyg4sF8CXfATJdTKcrmz+iONMoD13G9r4YS9WbBn
        pvbckjP4I74W42F26lcuKHGUbPRqPHPNq9OlllfbbArH3wQH/6vlcdR5R4QVvISMdZMF69J9RKt
        IFhI9xJQNsV3zMmuCLSN7CsdEBrw==
X-Google-Smtp-Source: APXvYqz0attZTqRvroRGRmJOSKDYIfczrl7AZqIItXDlnk/rqWOjgsQUXi2hDMrhwI5XxSxm3lLTtg==
X-Received: by 2002:adf:eb49:: with SMTP id u9mr2699879wrn.215.1564437550243;
        Mon, 29 Jul 2019 14:59:10 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:09 -0700 (PDT)
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
Subject: [PATCHv5 12/37] timerfd: Make timerfd_settime() time namespace aware
Date:   Mon, 29 Jul 2019 22:57:32 +0100
Message-Id: <20190729215758.28405-51-dima@arista.com>
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

timerfd_settime() accepts an absolute value of the experation time if
TFD_TIMER_ABSTIME is specified. This value is in task's time namespace
and has to be converted to the host's time namespace.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 6a6fc8aa1de7..9b0c2f65e7e8 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/rcupdate.h>
+#include <linux/time_namespace.h>
 
 struct timerfd_ctx {
 	union {
@@ -196,6 +197,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
 	}
 
 	if (texp != 0) {
+		if (flags & TFD_TIMER_ABSTIME)
+			texp = timens_ktime_to_host(clockid, texp);
 		if (isalarm(ctx)) {
 			if (flags & TFD_TIMER_ABSTIME)
 				alarm_start(&ctx->t.alarm, texp);
-- 
2.22.0

