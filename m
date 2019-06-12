Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24D742FFE
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbfFLT1e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:27:34 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51488 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbfFLT1G (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:27:06 -0400
Received: by mail-wm1-f46.google.com with SMTP id 207so7731286wma.1
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xB4BKK0rKD1Yr6+/PDJJP2p+OtOC/CpKgFN6/nohqnE=;
        b=oclm8AVGlEQnxLXEI9FHPqnN1+M0kQAI16c7b84Kk0Fg7+EpxY46jg21E15ZTrkHE3
         R8Uus8KJE67K5ajUmCSIQCeJkWoqY1duZ1KPmbTG63/5pw2ZUISy+IuQ+1SRFKcHUJ1h
         GtSzAUEtI8hth5s0V3KKVSnOQwOrAdxSx5RsLnX2baHVfDVTxoytkTCCKwQO/KTrPUHm
         Ra2q3vOFrmWHLIPyIBfX8nC7Bh5oakz4RH0Pm7NWuPntD2fGlAkdF7fW9PgOsqku8mSe
         7+T/lf+97uaDu1GlYKTZlvzeHp6k5Py9IyMxDLOJfK9x1iteKR6GgE61YQhWirJBe3Uo
         8HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xB4BKK0rKD1Yr6+/PDJJP2p+OtOC/CpKgFN6/nohqnE=;
        b=Jx9uSne0TQjh7XLvKe610imngBevq0mL7odcBqNBrag5GM7fu94PZpuYgsLzEbI5bV
         CS8jpxNJsxeIivbIhCW2eDtb/PyhkHK1EFzoAiCOPyJ286jXfBbJTf1WDwT6q1cNEVFN
         925yF9tZ5p4XI42H+6GCvnUSXlkLYUt9TIQxyr5QpdlKXxn5KRNwbjxV1ChXDt2hNt0s
         0LjZLZoelw9SMyHHkgU4dpE45ASF/Efq2iixQon9Nu5Rsp2NhnhU/b2ek1CIXpVtkAI2
         WQsKF4pyZafc9uVYa6x/IWPJ37nWbe4oG2X5F9rWIQlszu7wX5lzD5vrIpaeLwFV8QEC
         QoXg==
X-Gm-Message-State: APjAAAVY3FS9z8mPrOWw4ECGq4Y0RSpHYTOUMKwsLp/B1+qydil20MT9
        DysncpEjJtBhhrQ1a0TKwnXAkg==
X-Google-Smtp-Source: APXvYqwBoA5ZN/+6A2RGZ3893fxUct95+ZmVXU/QC1qe1iwHsiXNyqcSC2GOodR3wfWuwQ0Dka0q1w==
X-Received: by 2002:a1c:5f85:: with SMTP id t127mr549147wmb.104.1560367623474;
        Wed, 12 Jun 2019 12:27:03 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.27.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:27:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: [PATCHv4 23/28] selftest/timens: Add a test for clock_nanosleep()
Date:   Wed, 12 Jun 2019 20:26:22 +0100
Message-Id: <20190612192628.23797-24-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
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
 .../selftests/timens/clock_nanosleep.c        | 100 ++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)
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
index 000000000000..dfd4e3429c75
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,100 @@
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

