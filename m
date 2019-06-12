Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8542FF4
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfFLT1N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:27:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39714 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfFLT1M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:27:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so15488545wrt.6
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ksRGStZF6QCaA6nna+N4wh/TM9BtGkGQ4q0OpSDny6o=;
        b=AVyvvColl0CGo4dMLMz+GetbY7r6vpLo4Q4IjqtorX8mM2CAXCsOR+4ou4mbrlMc1v
         Zm+D5nLWIRUOUovrUhnjy5kD4YTNp57GaUawIehZKGuZPv3LlCLL0p36Q/svMK9Xs+Ea
         W36dF8AOx7a/AIO4Gvp0bkHZurQJQCY2Uh4Q7TnKdFkLg86sQjvQ2qKRqkGrQC79OJ2S
         YcYXR4OFSGpDtw0/phnXE2jiN9fDCyUCojvZA2+dlkBaq+rH8FLzff18gO0taO79wTIy
         SwGBEbMGEil/FcIK7gehxBCh9VxiFc1aEOr8xrp5Xb1HfDaQgFdiivZA70i4RdfLvSNc
         3Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ksRGStZF6QCaA6nna+N4wh/TM9BtGkGQ4q0OpSDny6o=;
        b=glhuICSYjz5rXjEweXd0lvweiINBxLLMFPumQNEvk1bj+N0t29PhI3arJheVJu32WL
         f/0//5rx2FgqMJ2GFJ3Ky0p1f10I20UMrxFIKujIZUGq0/nPDRzBwFQ5D+PugTdkjbRB
         YBIpwBWHGkL84+ncgDNXo47AQkqBZKq4AAIYPpXBX9NerZkr5ps0+V93/rTpEyGtcuPr
         kG91BlCbRqDqXzhA5lv9m/+If8Og0ie/PvmyITEN0pIhkMDCJAiGELC8U3AZJDKgS9o/
         JhwPwx39Ozaxc3bykLNef92z3eFsYWIOqeTARvZeSdmPu1P0LLn6oy73u9bVLmEHAiLJ
         GL7A==
X-Gm-Message-State: APjAAAUUbaTOyZn9RcStfK478/d7f7EDZEWwlXlIn35j+XQcpHyv//g1
        k0lF9pqkFtHRVmnNuBeIK7Tl6Q==
X-Google-Smtp-Source: APXvYqwurNlgeZeJuK7JcwSvbj3ROInpDNqCYw2rKVecuwNdwAVwX7nDOChrnVht3RRH9OU7f2np/A==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr9709542wrq.91.1560367630666;
        Wed, 12 Jun 2019 12:27:10 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.27.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:27:10 -0700 (PDT)
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
Subject: [PATCHv4 28/28] selftest/timens: Check that a right vdso is mapped after fork and exec
Date:   Wed, 12 Jun 2019 20:26:27 +0100
Message-Id: <20190612192628.23797-29-dima@arista.com>
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

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |  1 +
 tools/testing/selftests/timens/Makefile   |  2 +-
 tools/testing/selftests/timens/exec.c     | 91 +++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)
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
index ef65bf96b55c..9e0edf354906 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf exec
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
new file mode 100644
index 000000000000..b3a05c41e202
--- /dev/null
+++ b/tools/testing/selftests/timens/exec.c
@@ -0,0 +1,91 @@
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

