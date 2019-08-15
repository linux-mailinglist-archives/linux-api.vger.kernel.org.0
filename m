Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB68F0CB
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfHOQjD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44128 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732324AbfHOQjD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so2744044wrf.11
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBAXcNmS3l3nfaiqDJOSvjXWDET+01IZ2JhTywzQRP4=;
        b=Ea62pj4GwRIhBbcl3F+yl8GH57tG3qBQ/uZnTuUqIhq92RdhfYySLk9+dvAOOVtxc7
         1d2WJsu0kHmKDhkjS7wvpPbS/YkmRAWyKddYNPT7Fufzi3Car+UPC9G7MWDX/yprMLCs
         pe20PGUOVJQHPrgtpaDP+LwwchZXVprQMK/0Q/ZLUmDaAKTF3hDMZTcTsphq5mLSH04i
         Ezh4Q24ZAHZEMe2nWpMnolreFeIJXDF98eroOo5AUOEgY4n1dOLqzTdYa0ru1YOV5Yso
         kljs6FNHhSiMdF3wTrAD+COtOxTfNzpdcgQlEbYOG9QWwu9LyJh2KWuFJ4hRB0ykRP6y
         rxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBAXcNmS3l3nfaiqDJOSvjXWDET+01IZ2JhTywzQRP4=;
        b=tGxreOcmaQz7ltRO0nMfOwds43FZrD0oHYZoxs2rQDn/+WHcI7mabdCvExGi9TZBq3
         at+WNk0uTL9tLhEET3XHyP8oUz6Ffe0SGvieihTre+8CgZH5g/fZBQzG6H6W4Fma+6dT
         AUcS/phppVEU/1s2bVfMAJgIDSzZBc6bGBikHoDBQkeSNjr1rinThhw73idTF4TJ9yeZ
         RoJ0TfQ9uVznKh0RSGjdrJs7xHj5Fb4/puVBNTQDLd6kkfmIxrWc7zgEvtUdkvD21AzQ
         TcHuhKXGoKMwijISZ3XF/FLKX0oPmdkXVjYblWVsuHSUEST9bpwGzi22EwTLMzlu5Fva
         jNaQ==
X-Gm-Message-State: APjAAAXg8dFxcHNSm8/Wv3a4NRhBL1T4dTIO+FrGNGXkZeQR5fWXw2Bq
        liKEtdp0WKwtmi3TvczfL0PEcw==
X-Google-Smtp-Source: APXvYqwKOiGydl+4zn3GoYcnRO+8R+asfCMd1zXzop65k0bIXTVW253QxUthlrrMDyVqkR1pdSP66Q==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr6216185wrm.2.1565887141195;
        Thu, 15 Aug 2019 09:39:01 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:00 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv6 16/36] fd/proc: Respect boottime inside time namespace for /proc/uptime
Date:   Thu, 15 Aug 2019 17:38:16 +0100
Message-Id: <20190815163836.2927-17-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/proc/uptime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index a4c2791ab70b..5a1b228964fb 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
 
 static int uptime_proc_show(struct seq_file *m, void *v)
@@ -20,6 +21,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
 
 	ktime_get_boottime_ts64(&uptime);
+	timens_add_boottime(&uptime);
+
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-- 
2.22.0

