Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE079BEC
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfG2WAN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:00:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42124 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389346AbfG2V6x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so13561838wrr.9
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QlOwhEOC4bO6ztUPcHZX2D8R8lwFv2ELZ3dmT/1+sz8=;
        b=GniQmcImU6aGr9ZnMTvc9NlCGDJeFI2pQ+o2evRgG/m2iBzuZ0MPiZj1X2FQl15aD4
         ohxwLYPDwNeB+L8iIdnC/LcYZWLt4yYuiU4VNPiLfIqKPi7OCC/KXNH8d8f1XqyYEYu4
         EcmrXYY68JkbQVTQw9TotsJ7hlSkkocNbOaBo6eGOeWq4Oq0/K1axFyX10F/F4Wuibgi
         jxYo0pzlvkIsPuNUgAtei9L9KLJnRhs9xqJPUQJhQ98R2lQxKZSeizKaCXIaTws3No4Z
         NT30lI4KcLcTvoyb3OcZFjlECu9McQ/cuBDjgSyM6N5kKsZP9EEZL5JWxOCX1JYNIDvh
         xwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlOwhEOC4bO6ztUPcHZX2D8R8lwFv2ELZ3dmT/1+sz8=;
        b=N9LpLsiDxgLDrQIlNHzG3leogaI4fiqemOFOC4em0CrvCYuvlDk1wHwPlWA3P2Qqh+
         +RIovf4eaOJt81YPsL8afJjPIaRKHuU1HyoFZmnxKJ2IPu86Nh63CPlsyLqCNlMWT2QJ
         THltuR/TadoOwpxbE0FzcXcl1vLMTBXiF0AY/xrpPkdkMabUhi9vYFCt1yIAV6K6Mcg3
         CRv60kYpgmwWZIExXZ0/vzfwcW+2+ygChSdWAFWtnanSA4wsu0CgeZBqOeRGHMbbZ9Jy
         fDh7cGVygWFfYZq1OWh3OwNxqgdPda0QSDiLwcNnrBs5f8+tZqX2vQwAkB2MP2TruMHw
         1d6A==
X-Gm-Message-State: APjAAAV4AE9Edx4+WEd9iZdUQ6Sp2lNnl47WdWt5SCIMB4hSdOQqKW18
        obnLlpX0tNVzmmCUljOI5CsAvHcFA5D2zWN+X8sK1UROIsivTGLHKEgtfc3OBeV1U4K+SQBBiM3
        Cliz3BqIRXTWEXNUU/QYQMp+VNF/0hc3q3YrinpbPaQnj1VJiccxs2OBEd0XklWemcOZYoi9T+C
        qatDP3ehVqr+bWFpDSPIWqGBSTTA==
X-Google-Smtp-Source: APXvYqxGNkbtCVrpqfsxiuUfy9QMpEWxVyLJoQ/I77nmoMlZMKO9zi5ZrnBMbycP+tEAPONQakZldQ==
X-Received: by 2002:adf:cf0d:: with SMTP id o13mr77419816wrj.291.1564437531653;
        Mon, 29 Jul 2019 14:58:51 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:51 -0700 (PDT)
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
Subject: [PATCHv5 37/37] selftest/timens: Check that a right vdso is mapped after fork and exec
Date:   Mon, 29 Jul 2019 22:57:19 +0100
Message-Id: <20190729215758.28405-38-dima@arista.com>
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

