Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 600F579C15
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfG2WBg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:01:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54235 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389244AbfG2V6Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so55203067wmj.3
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBAXcNmS3l3nfaiqDJOSvjXWDET+01IZ2JhTywzQRP4=;
        b=g1q/BkZMUq4el8iFlMlE2qzEkE7J7+rd1DrZqn3UcvHHX2Du2fxG9Z0DDNHr5oVrJ+
         1Bxb98mT/fjQcQKWJva03y4yz82D14gv4jdRlqzV2hhwMSna4jSOLGfbfOirH28IYrTc
         W60RLQS8L+tZBl0NbRkSq/1DiLiC+lUiVsBXwjjOXHw8gXxkZKf/spkYWt8dP05SBtxF
         bTxglugbOuelSJ01Uj1DhSI9c8egDb8kOj19tHiHMfd3fmISNJBGTAdnBO75pS2H7J7Q
         lI+azQYIqSjR6z2IlEhXX8Wf2U+l2ww8dFlEKvbhF/SchTCpj5V8wbN/ORqhHKnPqt0+
         Sdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBAXcNmS3l3nfaiqDJOSvjXWDET+01IZ2JhTywzQRP4=;
        b=to3Tvll+z+TBx77KyxUw78ErpWocsmmHJftrPF9DPzusm6pj/XEQMwgYxBXw2Ije3H
         G92P0bbEJ+dG2zeGMldxm7aoJu/c0+95U2zrCh2nyWv/U37MRL5aQPpCTV5H+J+lrFQE
         +/s8Ou8XC0q//1EGJ9fHJyxChvl+JMjJsclKkWpCKdpStmKfZz1Et8yWwZQ9koMgCtpC
         3d30SBc4qsQVpO5EnQYdbC4mwZZBbIVAvTkYkoAxw7TIzbHS5iCUhz+GBfe4vMMzyGJF
         b+oG7Qp+QRpyvSP2ZBXf6/R9qxxeAF2PiaVkkb2jnuqbwiiSHC5gFpGm8EJ6C5LimA7W
         ePlQ==
X-Gm-Message-State: APjAAAXFtG5yP3MzC34KAnpDjcjMpdTKEo4hW2hY/XjSM3iAtG0awiDm
        gRlcVXk/i2DhnaBAOuZcVsTUnrx8f3lRPcpQqw1kHx851zSFWNchsY6WThInBMz0CG9rgUAsv5k
        PxJvdLXJoHxdIdKLYtK8kil8RQ//X7P2/3TC3QgKRzZZjvUiG/4J4vA3pKEfLV9+IWNTtsqzKZd
        5NkMXD0v5T+6opnNZDGOnqtAQfUQ==
X-Google-Smtp-Source: APXvYqyzsOlLiIxvCd/A4+OkbZ3kiGOeGsnV+RFBRn/XHct9ebVfv42p6MhTkWgwqVkj+rzPZitpZw==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr100565206wmd.73.1564437503760;
        Mon, 29 Jul 2019 14:58:23 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:23 -0700 (PDT)
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
Subject: [PATCHv5 17/37] fd/proc: Respect boottime inside time namespace for /proc/uptime
Date:   Mon, 29 Jul 2019 22:56:59 +0100
Message-Id: <20190729215758.28405-18-dima@arista.com>
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

