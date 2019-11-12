Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2EFF864D
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKLB3S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:29:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40440 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfKLB15 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id f3so1195618wmc.5
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14h9vFCPokwSzv6HoNFRi92QbmDZesI+ZDkQN0up0HI=;
        b=FYI6HTFHZJlXLBU4xrLxMBlPA50h62FqV47C1cRotvc8PUmv2q4RtH+0YIfpQxePoG
         Se8fnG/78iLr5M5RlHJqVG0r86rGOMD01cP2reElcv+fNfG6nK3Deed98vgUHDiAKZlz
         /HPfohCSqcbIHCcfcfeKBAL223kl/sgTnV+2WUFjVHZVVOKHMhxQUP+IUNTj42DqZ8IP
         +YeMMEWFnd+PKhqAWqwF3un0nF4QBisAsKbJk519OGrRO/9IhY/Ws774SQfMU+ycGSy+
         2iVqYpZioA4yVbLYc+TbmxCPVQzAW70jRbBY52NN/AznKdRsl4PLOZWwd7ZBTYwngduY
         jDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14h9vFCPokwSzv6HoNFRi92QbmDZesI+ZDkQN0up0HI=;
        b=TULjbi5cKYFfIJpTfi4RH6gRLTqsolUCNNdPbmK2d/KcqsHKYHYHQxILLioP1dmzWf
         GCU/4h0xbWhAraqFVkaWD+0vIXxIT0PoE/ssD0eEyy6bhSBLNvoTERJORhaGiihYuXQP
         3dZCbzwYbGkSHkhiJGKaLeoK0uoNHFYYQtnx6frWLWtE81/0iUT2OyiAfgBCnEgQdswo
         F+s0C7Xh2YMy85ia/mCsI59OLwCTYdt3kfJDttSpsdAs9Dc86YS945P78mfCJzljICeD
         vMf7NzEszq5IBFuv3weJz2ntXtdnIo+FQrES0SAgxTpixXwB0T5mT0/SIMI/b7hpogGB
         BKaQ==
X-Gm-Message-State: APjAAAVYavYHvFO3fr/GVetRWwQrKZeX4ejC3nbVNhLtVbf+VHkhe1Dg
        JmTvvepFdGUTIz91qYcxzNQf/Q==
X-Google-Smtp-Source: APXvYqzRYWbXynaSfskNf1zXWZ+1HG/EQfCPzqhtvrtJxlv3s8syqZivAed9FAXZbai7CCJjPrI9bA==
X-Received: by 2002:a05:600c:2919:: with SMTP id i25mr1522555wmd.158.1573522075902;
        Mon, 11 Nov 2019 17:27:55 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:55 -0800 (PST)
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
Subject: [PATCHv8 18/34] fs/proc: Respect boottime inside time namespace for /proc/uptime
Date:   Tue, 12 Nov 2019 01:27:07 +0000
Message-Id: <20191112012724.250792-19-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
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
2.24.0

