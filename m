Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CAF4300F
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfFLT0p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55583 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfFLT0o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so7696595wmj.5
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qkjB3IOi28arCXhgllHnytCrvmzEqMgo82CEycz3eU=;
        b=ktiIxgdaWNMzSkpMdy2bSqkLdK0BWCP+FYYUgBqSc8jSuT4IS2YnUkDdsZGleIFXKn
         fR/JX1UldYmS0tYY7l2PVS/GwUmuNSkSpGsZ6NB3RJtdmF4bQGMeT17fXR7fEpnjTA0e
         4AdO3LPk6RpQ3hCcutrk1OYKHNKVH5j1r6kT9Fc6oHYe8Of1JSPBMAaBBX8CazEG0O/v
         cLDotMQ6rBGI+J/2CIewoBBCPkWH5BqYzQaJwYc3mp/SSGSZkHmTSwrnOhXrkX9L1PhN
         s2GsejSgP7P+sUGHrVtebHzfoVXqz3AAVSqRinTcgg39f5iDNOtUC94Pn0HC5JW4xgCj
         bCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qkjB3IOi28arCXhgllHnytCrvmzEqMgo82CEycz3eU=;
        b=n1eGsVm4I16GlDi5QZEx/6LtuHu18TZTYJelpNTpSsai5JdFELyXOOEybbugGZ9Ubx
         TI34F8IlbnqBJq6tfYPGBHLf7SOfMKpU4Zd+9i9WPz3NgECYorILtlF9zL1c6IO2v0mg
         3jAPYQ5uZJDPHAMdNK7ozSJA2ppT18MMXyhDp3JcaB3D1znoQbFfCB6zdeLsnkK6hOaf
         VGjg/Y0UGRtT3jLln0YJXxXWD1lC7GxCwsxOJatCWLL2Pldnby5EJvvVMk1gmNt1t/7L
         xjsCrV5pkaKc9GrnpEJB7kAlIO9GJGTmmgZtZhG5/DFZ5sSzq8ODaIOPg2qHWr3RTDXq
         WS8Q==
X-Gm-Message-State: APjAAAUT5/bfcUuFryTwBZPPo2QUP4ax1DKhYWsG5pNSjAELCQvPa/dH
        02o7LYH/FfF83Ko+2zrlzlJMhQ==
X-Google-Smtp-Source: APXvYqzb/Gj37ht5UhPIiWmr5OpmGFCzdSKaugZfvxBmgJnspXb+uV4sCorLCGUsWogXaswFY1SGwA==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr348100wmb.103.1560367602993;
        Wed, 12 Jun 2019 12:26:42 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:42 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
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
Subject: [PATCHv4 09/28] timens: Shift /proc/uptime
Date:   Wed, 12 Jun 2019 20:26:08 +0100
Message-Id: <20190612192628.23797-10-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Respect boottime inside time namespace for /proc/uptime

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

