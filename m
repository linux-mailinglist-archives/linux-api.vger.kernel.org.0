Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD06779BF5
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfG2WAo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:00:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34120 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbfG2V6q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so43919662wmd.1
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kW0VPhYCrDSswd0PPA3RvCOD8M4i/u3OaqhqtDVaSgw=;
        b=SACzK5XqeM8TF6GrRbw7c2yX1YrOhwrjp164LAluLWqd4S6lLUfO8QcCUlMoQZwHKb
         /z8GFLL+CoRlMh2yb634ud+tVfZx2sw9BvFQfUvb/dL3eXT0m/WRhaeeO3+fqIy4q1Fc
         UG/vUA2cF9wSk5r5ZLZPBYEtQiEjkO7EuIZqm7cexpSDFoQJPUvRtUpZfozGJk9gh1i+
         DM25kMBHoUxARXrx6LmZyNOUPkKCEObHVDTwDxvyL1EzlZwbb7w8S0IHh7RZkNs6pIDR
         eeX2iq+oMJUcuYJySfYksfx1ohmym41vvjzUiswYr0UdyFrB1X6JPp0FpPQd+9OexBX9
         V9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kW0VPhYCrDSswd0PPA3RvCOD8M4i/u3OaqhqtDVaSgw=;
        b=U5NorHlme50HGNXBVEH57Iz3OQgAz+FC7NW2yz3fahv1mdTlLBN9rmK+voUoLbBtR4
         5aPbI4b11t/Tb8IK0/wxtRiPHGokWnsAo+cUnEwJ8mSaM1gDZaoamWwbfdBwcqmMEsDc
         ypvmVv9y2e/7YNKFyRbJDRj3lmrrCvvcgM/wIERO6Ri7sXU5LbT7IdxXIiyMy3Nwv2m5
         Ki+rMW5ufkzyzDCRukc2x21D2VA419wxvjjGkqoHmrzVkq2JXKHQREHS0MONXxXFP+UM
         SRDlm41ht9rBGoTs/RZ1hL0Eom298iAIg/0WphisOn91iuBrabXdpx8IZHMrTwCyw8ot
         3g6A==
X-Gm-Message-State: APjAAAV6VSl0Cyq9R5i3wHoVdqRxQJgHcMkxrz3NCs2o0zd4EyUncS5G
        kdbZL+eQwV89JY4mz9qgHKXnKj6ZchMDxl8uzKqvcKuYAqChA1wh6yZqg2LtPl4g4g5e/HQkTmx
        K6/kj85Wf1734to1Bvwte8rrqvRYSFnpwERGnUlCk4ADL6tKQsqkYFYs3zO5FNAUeE+TnMGcqtn
        zy1fE/ADNqWzQLciMRPsriQMrc1Q==
X-Google-Smtp-Source: APXvYqx3SYv9oDUniMdy7NM0JVclB1wNLjXx/BnGTJYsmMSnO6DgOYVgP2hClbhg2Bz51nfEVEfL+Q==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr103550930wmf.51.1564437524406;
        Mon, 29 Jul 2019 14:58:44 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:43 -0700 (PDT)
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
Subject: [PATCHv5 32/37] selftest/timens: Add a test for timerfd
Date:   Mon, 29 Jul 2019 22:57:14 +0100
Message-Id: <20190729215758.28405-33-dima@arista.com>
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

Check that timerfd_create() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   2 +-
 tools/testing/selftests/timens/timerfd.c  | 129 ++++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)
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
index 000000000000..b87076aae040
--- /dev/null
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -0,0 +1,129 @@
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
+		return pr_perror("clock_gettime(%d)", clockid);
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
+			return pr_perror("timerfd_create(%d)", clockid);
+
+		if (i == 1)
+			flags |= TFD_TIMER_ABSTIME;
+
+		if (timerfd_settime(fd, flags, &new_value, NULL))
+			return pr_perror("timerfd_settime(%d)", clockid);
+
+		if (timerfd_gettime(fd, &new_value))
+			return pr_perror("timerfd_gettime(%d)", clockid);
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
+	ksft_set_plan(3);
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

