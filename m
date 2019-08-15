Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C838F0DC
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfHOQj3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:29 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35160 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732551AbfHOQj2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:28 -0400
Received: by mail-wr1-f42.google.com with SMTP id k2so2781371wrq.2
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nEPH/HBT5LEaDOPJsRodxQcT9N0GAR3W8MewC/Ub1VE=;
        b=mSKeHxRB4C77stJOS1616XTkfC137+/GBdHbgLvaUj7EtAug5e3h+srqzc2Wc5NO+i
         WMGRUUDjubyh9yY1MbmvZ0kNM2/RLdwufDi028VwzTd/qMGhy9pI5Gs3YIwn6MvEsiZK
         r7QOcsUTNvZ5eE0XBHn8/LRPMYWxsY0Q5/fMeWcTXZf1/QfdNfTf8veAzIfBouYfuk7p
         Msp/Ec1xTC45F0Brln1a0Qdy70F8U+meQJEvYKtksiWy8rztlAWk5L4ERq0yL12yiH35
         eKc3sVMESfJ+UL5pUvxO420R6Xg/zJ81Mk+XdAaImE5mnS8ozIlmMhOjadZCMIkhDYY6
         aMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nEPH/HBT5LEaDOPJsRodxQcT9N0GAR3W8MewC/Ub1VE=;
        b=bQXozKQOpK8GZRw9GcfdSY0/oAngLPnOFMtvYQC3bU75no1dy0PVvCE1jLNmJwld0Q
         H2hG2TE6k1pxKP5bouT/Eoxb+O4fLA350fDYrpBD91eSGU8lpP9E22qgaqoHuILkd4Uj
         0okETcIyqHGkFCgK5/W1hxmzhGx/TNmyj24yGYWqzCoNUrTD7RxsTCfNEUxAeuTHEgc8
         qHNVHnY5iDIeZ2DrPITqLMuSHWPPv/cBUhcdyqV8+T2BPuficU/Fi+BOoJF1TCDdrHSW
         EMXAU/VHVmMwlUF1WiS87YF0srmFxF3BX7sa87L9MwwH30pil7oF9N2xBhb0/dOyHnSl
         IDoQ==
X-Gm-Message-State: APjAAAVNrdGFmWf3vK3fI9DWv3xXUEGAnBZJp/C3OXfeUye3/RkTvnSX
        A060D+ngyH+6to/f2QuTTJTA8A==
X-Google-Smtp-Source: APXvYqypI4neG/Btuqh0RoLRQNcNbnzSpECKZrS2aaGU3SvOR8pqPmlzuuTjaAzfqg9oJ5TPnpdwqQ==
X-Received: by 2002:a5d:6981:: with SMTP id g1mr6249139wru.193.1565887165333;
        Thu, 15 Aug 2019 09:39:25 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:24 -0700 (PDT)
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
Subject: [PATCHv6 32/36] selftest/timens: Add a test for clock_nanosleep()
Date:   Thu, 15 Aug 2019 17:38:32 +0100
Message-Id: <20190815163836.2927-33-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Check that clock_nanosleep() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |   1 +
 tools/testing/selftests/timens/Makefile       |   2 +-
 .../selftests/timens/clock_nanosleep.c        | 102 ++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index b609f6ee9fb9..9b6c8ddac2c8 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,2 +1,3 @@
+clock_nanosleep
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 66b90cd28e5c..76a1dc891184 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd
+TEST_GEN_PROGS := timens timerfd clock_nanosleep
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
new file mode 100644
index 000000000000..7956e65d3032
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#include "log.h"
+#include "timens.h"
+
+static long long get_elapsed_time(int clockid, struct timespec *start)
+{
+	struct timespec curr;
+	long long secs, nsecs;
+
+	if (clock_gettime(clockid, &curr) == -1)
+		return pr_perror("clock_gettime");
+
+	secs = curr.tv_sec - start->tv_sec;
+	nsecs = curr.tv_nsec - start->tv_nsec;
+	if (nsecs < 0) {
+		secs--;
+		nsecs += 1000000000;
+	}
+	if (nsecs > 1000000000) {
+		secs++;
+		nsecs -= 1000000000;
+	}
+	return secs * 1000 + nsecs / 1000000;
+}
+
+int run_test(int clockid)
+{
+	long long elapsed;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct timespec now = {};
+		struct timespec start;
+
+		if (clock_gettime(clockid, &start) == -1)
+			return pr_perror("clock_gettime");
+
+
+		if (i == 1) {
+			now.tv_sec = start.tv_sec;
+			now.tv_nsec = start.tv_nsec;
+		}
+
+		now.tv_sec += 2;
+		clock_nanosleep(clockid, i ? TIMER_ABSTIME : 0, &now, NULL);
+
+		elapsed = get_elapsed_time(clockid, &start);
+		if (elapsed < 1900 || elapsed > 2100) {
+			pr_fail("clockid: %d abs: %d elapsed: %lld\n",
+				clockid, i, elapsed);
+			return 1;
+		}
+		ksft_test_result_pass("clockid: %d abs:%d\n", clockid, i);
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, nsfd;
+
+	nscheck();
+
+	ksft_set_plan(4);
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	if (_settime(CLOCK_MONOTONIC, 7 * 24 * 3600))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, 9 * 24 * 3600))
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Unable to open timens_for_children");
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("Unable to set timens");
+
+	ret = 0;
+	ret |= run_test(CLOCK_MONOTONIC);
+	ret |= run_test(CLOCK_BOOTTIME_ALARM);
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
+
-- 
2.22.0

