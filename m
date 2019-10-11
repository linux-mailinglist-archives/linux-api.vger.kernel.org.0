Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CEED3709
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfJKBYE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:24:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45408 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfJKBYE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so9918360wrm.12
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZwK+S94n8+kuxECVrn+dJbtZsya6IRammowz8Zd06g=;
        b=EjAnH+Up6qu7vsX0veTfZxyxwpJyu/LTnvpcgQ/9g3/OYYhs7cCrGZZZ143rfx+YuN
         tm+SWRL3uTMBoHkLKHPZrGBl50GIHvxODlvb5OSlR8bRAVw0oMVa0mR0VDhc3lbcLvmH
         0Mmr8og/CPAwGHDf73pm+tO0ryAo8H916ev/UzKNLLXUBHF6mlrPDw2Cs/qfchNjVUQb
         gQRfKixxLj14Ns51EUvri8JIHJyS+f8Voianj8hp/RdObBhsF/ZtjAHD9wLBbaDebY/z
         DWUquEv9lk9QSsjuVb6PYrnjuZt1rKY/c8n2itNhc5vJbXlmph7n6Hph7Af3E6qx5Fxj
         0Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZwK+S94n8+kuxECVrn+dJbtZsya6IRammowz8Zd06g=;
        b=Z8G4an09MDnK1dPz/JX3v1F3BQgC469nKxkbZRKhVv3vDQjVjFBEv6oDB0+kU0esEE
         ffRhtLq4gZVCWYKSkfTq7AgEymyNRMAdQ81vkBF7zp/uT3VNm/p3YAQcWsMrQVu4Ge+5
         OM3WExBkwBLtaK2FIdn/ObvJpbQZRWU4Uyf90PGmkrQOln1I4FKfK09DcvpoL91Npgki
         M4YsIJ8L5fl4YucUJ4OaEG763C+FjFnHSEv55/awZj5/Tga++vPlzzkd2mhDsZDQIHHs
         ZGkJ6tPVFPvfd0VjiZyztFNOrtPHr2QUbu7rngnm7X3SHe8ZJD5gs/KdvUQLq335yQHs
         Pvxw==
X-Gm-Message-State: APjAAAUonKWXo1PKWufkf1IuwcudfOGL4O5akSo8bVjY7PHEoJoZW7CC
        vXxxnhHd1ghECYrHRtaEGNjD1g==
X-Google-Smtp-Source: APXvYqw5OUm4NHXxoFn4k+ZROCcl6LeUPiH8VPyth6eBe+oA075nwaLbwXgNQFx4j299LNaZpr6suQ==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr11032327wrv.101.1570757041900;
        Thu, 10 Oct 2019 18:24:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:01 -0700 (PDT)
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
Subject: [PATCHv7 11/33] timerfd: Make timerfd_settime() time namespace aware
Date:   Fri, 11 Oct 2019 02:23:19 +0100
Message-Id: <20191011012341.846266-12-dima@arista.com>
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

timerfd_settime() accepts an absolute value of the expiration time if
TFD_TIMER_ABSTIME is specified. This value is in task's time namespace
and has to be converted to the host's time namespace.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 48305ba41e3c..f9da5752a79e 100644
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
2.23.0

