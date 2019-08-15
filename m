Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6658F0E2
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbfHOQjd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42555 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732660AbfHOQjd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so2753804wrq.9
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QlOwhEOC4bO6ztUPcHZX2D8R8lwFv2ELZ3dmT/1+sz8=;
        b=Krs86DRVNTVgo/j/k/uiSGf3vcKUhuqPsV/TDx0kVx4p2zPAC1JIhIdF02WAoqEz7o
         uEeC0dGkeWcO5wZsfdlmWDGV0BNCPlT7myjt5GQX9RRlYiWEmwZhOwRNUCukcg3C3Tar
         swL2AscP6JlmzUHtpNVFIkPXfDPCyULsGp25K/LGpp1RNKIHZwXZ56EtER1T4UG7SbH8
         2tZoc+m4mdFieyFtKdTRzvEuYUsLvbhSWv7lz3G/b4a1Qqeth0bHMoi2ICSzlhqLvHMt
         XV1Soqs12Y9NE47S51Pm0XTR/Vrlas6M3dZtjEODvBcGmy6uwN+t7+TWmaH2++YFVH73
         x24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlOwhEOC4bO6ztUPcHZX2D8R8lwFv2ELZ3dmT/1+sz8=;
        b=hxjpa7+fZ5ZqSScRBdeRS0cwPMQnfWcN+2y8HSX0xk5CcXCGsLXccknnIenG4ICYSQ
         2NknePeQDbNYeJaEKIcJ9GA8UyawG1Fa/ghkxgTjQjm6zAS4SFwZkVBJq6IA8Dj189JO
         VG9N6IimaNjxvZIbcern17pehMI8s1lB9wnie1DxEoC8/Sfxsg/kfoBYIIYxCU8Veydn
         qNy8pzkhyRWj4o8ro5AIGkhjNDp4lfAhPFn22O3pbNb8m+s4NEJD9l7ugEuTAbfZG4Kh
         6oRyduGw5VlcJOYt8WXqjI2aPZ7+9WUnUU8c7xVso0CGSYv8ByfFDlPGVcHCS95rFGq/
         vJ8g==
X-Gm-Message-State: APjAAAVp+lPHQbBLo0IHTOjR15bWPNgKTIjjxXPDkdv13AcABL8TzGYD
        2+yjSQdHCVScqZZ3urZS2m8g9w==
X-Google-Smtp-Source: APXvYqztK2I0QgbTl4htGjkjFkvwJgmku1QeLCBTziWxHDmG2T54lb6U3mJxBtRv7pWIXzQywQl/4A==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr6225691wrs.347.1565887171252;
        Thu, 15 Aug 2019 09:39:31 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:30 -0700 (PDT)
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
Subject: [PATCHv6 36/36] selftest/timens: Check that a right vdso is mapped after fork and exec
Date:   Thu, 15 Aug 2019 17:38:36 +0100
Message-Id: <20190815163836.2927-37-dima@arista.com>
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

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |  1 +
 tools/testing/selftests/timens/Makefile   |  2 +-
 tools/testing/selftests/timens/exec.c     | 93 +++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/exec.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 16292e4d08a5..789f21e81028 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,5 @@
 clock_nanosleep
+exec
 gettime_perf
 gettime_perf_cold
 procfs
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 97e0460eaf48..b77fe22fa24d 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf exec
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
new file mode 100644
index 000000000000..de7798832429
--- /dev/null
+++ b/tools/testing/selftests/timens/exec.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define OFFSET (36000)
+
+int main(int argc, char *argv[])
+{
+	struct timespec now, tst;
+	int status, i;
+	pid_t pid;
+
+	if (argc > 1) {
+		if (sscanf(argv[1], "%ld", &now.tv_sec) != 1)
+			return pr_perror("sscanf");
+
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec) > 5)
+				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
+		}
+	}
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	if (_settime(CLOCK_MONOTONIC, OFFSET))
+		return 1;
+
+	for (i = 0; i < 2; i++) {
+		_gettime(CLOCK_MONOTONIC, &tst, i);
+		if (abs(tst.tv_sec - now.tv_sec) > 5)
+			return pr_fail("%ld %ld\n",
+					now.tv_sec, tst.tv_sec);
+	}
+
+	if (argc > 1)
+		return 0;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("fork");
+
+	if (pid == 0) {
+		char now_str[64];
+		char *cargv[] = {"exec", now_str, NULL};
+		char *cenv[] = {NULL};
+
+		/* Check that a child process is in the new timens. */
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+				return pr_fail("%ld %ld\n",
+						now.tv_sec + OFFSET, tst.tv_sec);
+		}
+
+		/* Check that a proper vdso will be mapped after execve. */
+		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
+		execve("/proc/self/exe", cargv, cenv);
+		return pr_perror("execve");
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("waitpid");
+
+	if (status)
+		ksft_exit_fail();
+
+	ksft_test_result_pass("exec\n");
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.22.0

