Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC642FF0
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfFLT1E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:27:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55613 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbfFLT1E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:27:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so7697437wmj.5
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7yTmYIUCyP0lO5LLTymZeoF+pQnSJe+s6ibbY5pTvLk=;
        b=JVg29dRaRlKV5ua9xQxF0rxuXNw72V/mIuj47AwyKxzMY/TniWi97P63MdfJQ8Hv0G
         ypuDcJ1k5JiH84718CawIy4x3zfvz3U7RdqjzzacmgC69b795inffF3CLPmTgjrUV3eB
         +J+xBxY1cRibWFjF3LchKpFPzzfhAmMsQEKPI1K7P1AWgYcnOgMvFLkkdAff4FazSVfu
         tFHXBD3WmyzAzCuJAiyUOU9hJRmQ6b250SwebwYxdzJ4JeMWRawrpP9sFDFayC28vGrq
         t3xiIKhwqv64TNA5uF/rGXnneD5p+YlfiYd9o9opV6NfzAcj9DcTmJgNw/qppK7o7nJ5
         x6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yTmYIUCyP0lO5LLTymZeoF+pQnSJe+s6ibbY5pTvLk=;
        b=kT6yCw/S1jvFgkM1UrvtAoL1zyZn3AcDA1sAjBYSTvQoLMh8UNefFghZqgxCa182Vb
         Au7XGdu4zRNdnBG82JMtnALbA/2HyHzstS69YA/KZJ/wtBwm/+tinau+IX0BamnBWsZ0
         HB5FXonB3dcS2bmifrRLnvU7RgOLZ5IRfMZebHX5EZeOg8MGKZxHlhOQABgC5iEnLFlW
         /j88JtkuV8Ebe72eZAtmLh1bX+/kj5ciiN/e3ldNQkwKYcBI7pHxhhI5F8+8/XnogJp7
         Pea5E/vcr+hQbmnDk2Csf5U3ep7B5GfA+TnMk3PJc5sRXzUdh3QBZvTvYctycq7+7LU2
         keyg==
X-Gm-Message-State: APjAAAXLbChWCq6NoXH9B9On2awSq2lJiv5a2//foL8IJbVqEECIWhSS
        RDuvXSEpoAoOfo0l5kabY19wOA==
X-Google-Smtp-Source: APXvYqyNPpegXIXH95xmIvr2cCaEJ2uN7zFl3Wxf7I/In6ytCEarcq6CQ+DZO9WonXysjZM6iTg4rA==
X-Received: by 2002:a1c:5412:: with SMTP id i18mr512795wmb.11.1560367621992;
        Wed, 12 Jun 2019 12:27:01 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.27.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:27:01 -0700 (PDT)
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
Subject: [PATCHv4 22/28] selftest/timens: Add a test for timerfd
Date:   Wed, 12 Jun 2019 20:26:21 +0100
Message-Id: <20190612192628.23797-23-dima@arista.com>
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

Check that timerfd_create() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   2 +-
 tools/testing/selftests/timens/timerfd.c  | 127 ++++++++++++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/timerfd.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 27a693229ce1..b609f6ee9fb9 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1 +1,2 @@
 timens
+timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index b877efb78974..66b90cd28e5c 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens
+TEST_GEN_PROGS := timens timerfd
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
new file mode 100644
index 000000000000..c9816db4fe79
--- /dev/null
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#include "log.h"
+#include "timens.h"
+
+static int tclock_gettime(clock_t clockid, struct timespec *now)
+{
+	if (clockid == CLOCK_BOOTTIME_ALARM)
+		clockid = CLOCK_BOOTTIME;
+	return clock_gettime(clockid, now);
+}
+
+int run_test(int clockid, struct timespec now)
+{
+	struct itimerspec new_value;
+	long long elapsed;
+	int fd, i;
+
+	if (tclock_gettime(clockid, &now))
+		return pr_perror("clock_gettime");
+
+	for (i = 0; i < 2; i++) {
+		int flags = 0;
+
+		new_value.it_value.tv_sec = 3600;
+		new_value.it_value.tv_nsec = 0;
+		new_value.it_interval.tv_sec = 1;
+		new_value.it_interval.tv_nsec = 0;
+
+		if (i == 1) {
+			new_value.it_value.tv_sec += now.tv_sec;
+			new_value.it_value.tv_nsec += now.tv_nsec;
+		}
+
+		fd = timerfd_create(clockid, 0);
+		if (fd == -1)
+			return pr_perror("timerfd_create");
+
+		if (i == 1)
+			flags |= TFD_TIMER_ABSTIME;
+
+		if (timerfd_settime(fd, flags, &new_value, NULL))
+			return pr_perror("timerfd_settime");
+
+		if (timerfd_gettime(fd, &new_value))
+			return pr_perror("timerfd_gettime");
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
+					      clockid, elapsed);
+			return 1;
+		}
+
+		close(fd);
+	}
+
+	ksft_test_result_pass("clockid=%d\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec btime_now, mtime_now;
+
+	nscheck();
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+	clock_gettime(CLOCK_BOOTTIME, &btime_now);
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0\n%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600,
+			CLOCK_BOOTTIME, 9 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+	mtime_now.tv_sec += 70 * 24 * 3600;
+	btime_now.tv_sec += 9 * 24 * 3600;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		ret = 0;
+		ret |= run_test(CLOCK_BOOTTIME, btime_now);
+		ret |= run_test(CLOCK_MONOTONIC, mtime_now);
+		ret |= run_test(CLOCK_BOOTTIME_ALARM, btime_now);
+
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return ret;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}
+
-- 
2.22.0

